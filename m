Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E70FF2571C
	for <lists+linux-nfs@lfdr.de>; Tue, 21 May 2019 19:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfEUR5G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 May 2019 13:57:06 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:55330 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbfEUR5G (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 May 2019 13:57:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=wuyihao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TSK9qTq_1558461423;
Received: from ali-186590dcce93-2.local(mailfrom:wuyihao@linux.alibaba.com fp:SMTPD_---0TSK9qTq_1558461423)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 May 2019 01:57:03 +0800
Subject: [PATCH v3 1/2] NFSv4.1: Again fix a race where CB_NOTIFY_LOCK fails
 to wake a waiter
From:   Yihao Wu <wuyihao@linux.alibaba.com>
To:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>, caspar@linux.alibaba.com
References: <346806ac-2018-b780-4939-87f29648017c@linux.alibaba.com>
 <48a9d50b-f7b9-407d-06db-5c9079dfbf24@linux.alibaba.com>
Message-ID: <37564b2e-9167-a7c1-6f12-8fffaad088fb@linux.alibaba.com>
Date:   Wed, 22 May 2019 01:57:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <48a9d50b-f7b9-407d-06db-5c9079dfbf24@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit b7dbcc0e433f "NFSv4.1: Fix a race where CB_NOTIFY_LOCK fails to wake a waiter"
found this bug. However it didn't fix it.

This commit replaces schedule_timeout() with wait_woken() and
default_wake_function() with woken_wake_function() in function
nfs4_retry_setlk() and nfs4_wake_lock_waiter(). wait_woken() uses
memory barriers in its implementation to avoid potential race condition
when putting a process into sleeping state and then waking it up.

Fixes: a1d617d8f134 ("nfs: allow blocking locks to be awoken by lock callbacks")
Cc: stable@vger.kernel.org #4.9+
Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
v2->v3: remove unused variable flags in nfs4_retry_setlk()

 fs/nfs/nfs4proc.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c29cbef..5f89bbd 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6932,7 +6932,6 @@ struct nfs4_lock_waiter {
 	struct task_struct	*task;
 	struct inode		*inode;
 	struct nfs_lowner	*owner;
-	bool			notified;
 };
 
 static int
@@ -6954,13 +6953,13 @@ struct nfs4_lock_waiter {
 		/* Make sure it's for the right inode */
 		if (nfs_compare_fh(NFS_FH(waiter->inode), &cbnl->cbnl_fh))
 			return 0;
-
-		waiter->notified = true;
 	}
 
 	/* override "private" so we can use default_wake_function */
 	wait->private = waiter->task;
-	ret = autoremove_wake_function(wait, mode, flags, key);
+	ret = woken_wake_function(wait, mode, flags, key);
+	if (ret)
+		list_del_init(&wait->entry);
 	wait->private = waiter;
 	return ret;
 }
@@ -6969,7 +6968,6 @@ struct nfs4_lock_waiter {
 nfs4_retry_setlk(struct nfs4_state *state, int cmd, struct file_lock *request)
 {
 	int status = -ERESTARTSYS;
-	unsigned long flags;
 	struct nfs4_lock_state *lsp = request->fl_u.nfs4_fl.owner;
 	struct nfs_server *server = NFS_SERVER(state->inode);
 	struct nfs_client *clp = server->nfs_client;
@@ -6979,8 +6977,7 @@ struct nfs4_lock_waiter {
 				    .s_dev = server->s_dev };
 	struct nfs4_lock_waiter waiter = { .task  = current,
 					   .inode = state->inode,
-					   .owner = &owner,
-					   .notified = false };
+					   .owner = &owner};
 	wait_queue_entry_t wait;
 
 	/* Don't bother with waitqueue if we don't expect a callback */
@@ -6993,21 +6990,14 @@ struct nfs4_lock_waiter {
 	add_wait_queue(q, &wait);
 
 	while(!signalled()) {
-		waiter.notified = false;
 		status = nfs4_proc_setlk(state, cmd, request);
 		if ((status != -EAGAIN) || IS_SETLK(cmd))
 			break;
 
 		status = -ERESTARTSYS;
-		spin_lock_irqsave(&q->lock, flags);
-		if (waiter.notified) {
-			spin_unlock_irqrestore(&q->lock, flags);
-			continue;
-		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		spin_unlock_irqrestore(&q->lock, flags);
-
-		freezable_schedule_timeout(NFS4_LOCK_MAXTIMEOUT);
+		freezer_do_not_count();
+		wait_woken(&wait, TASK_INTERRUPTIBLE, NFS4_LOCK_MAXTIMEOUT);
+		freezer_count();
 	}
 
 	finish_wait(q, &wait);
-- 
1.8.3.1

