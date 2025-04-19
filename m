Return-Path: <linux-nfs+bounces-11175-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB3FA94254
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 10:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E1C19E2F93
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Apr 2025 08:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649191A8407;
	Sat, 19 Apr 2025 08:37:55 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E750D1A5B9B;
	Sat, 19 Apr 2025 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051875; cv=none; b=LUgI3DhfOgAOIFzEv4tPjXGzfb3yzEgCYTX+Y5POxfrFkySudHTCY51PZTge7yQX/rgjtX+Pgh97KAtxkFgO912JqHbdjzaa6dSQRbAhB2o49VQ7TeuwMhbf40DUOcIeF2Aa1KwyPfZIJWD8iMZNMfhUmoCU5u6mocVyQ9i2Yw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051875; c=relaxed/simple;
	bh=P9RFDeyBkDkbaio9Lo6rkiHLfMPI1vCJmkTnj0lCITo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OPa5dSiKCeEUhrJOOkqKTnLwA6LHJDBr9VYjMxwZn2xJKXUTb+FOsPFSV8elq1JqfUAEXxkexSnVgIgZcJ3EncirSOuBFdrXUOrQ478NKeMIlUmDHzxHMl9v1dLdtb4qpNwLaJnnSrNpD4m1paBovIeAKC97Q55l/iEdydGZZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZflKp4MVbzHrDH;
	Sat, 19 Apr 2025 16:34:22 +0800 (CST)
Received: from kwepemg500017.china.huawei.com (unknown [7.202.181.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 697E6140259;
	Sat, 19 Apr 2025 16:37:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemg500017.china.huawei.com
 (7.202.181.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 19 Apr
 2025 16:37:49 +0800
From: Li Lingfeng <lilingfeng3@huawei.com>
To: <trondmy@kernel.org>, <anna@kernel.org>, <jlayton@kernel.org>,
	<bcodding@redhat.com>
CC: <linux-nfs@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <houtao1@huawei.com>, <yi.zhang@huawei.com>,
	<yangerkun@huawei.com>, <lilingfeng@huaweicloud.com>,
	<lilingfeng3@huawei.com>
Subject: [PATCH] nfs: fix the race of lock/unlock and open
Date: Sat, 19 Apr 2025 16:57:09 +0800
Message-ID: <20250419085709.1452492-1-lilingfeng3@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500017.china.huawei.com (7.202.181.81)

LOCK may extend an existing lock and release another one and UNLOCK may
also release an existing lock.
When opening a file, there may be access to file locks that have been
concurrently released by lock/unlock operations, potentially triggering
UAF.
While certain concurrent scenarios involving lock/unlock and open
operations have been safeguarded with locks – for example,
nfs4_proc_unlckz() acquires the so_delegreturn_mutex prior to invoking
locks_lock_inode_wait() – there remain cases where such protection is not
yet implemented.

The issue can be reproduced through the following steps:
T1: open in read-only mode with three consecutive lock operations applied
    lock1(0~100) --> add lock1 to file
    lock2(120~200) --> add lock2 to file
    lock3(50~150) --> extend lock1 to cover range 0~200 and release lock2
T2: restart nfs-server and run state manager
T3: open in write-only mode
    T1                            T2                                T3
                            start recover
lock1
lock2
                            nfs4_open_reclaim
                            clear_bit // NFS_DELEGATED_STATE
lock3
 _nfs4_proc_setlk
  lock so_delegreturn_mutex
  unlock so_delegreturn_mutex
  _nfs4_do_setlk
                            recover done
                                                lock so_delegreturn_mutex
                                                nfs_delegation_claim_locks
                                                get lock2
   rpc_run_task
   ...
   nfs4_lock_done
    locks_lock_inode_wait
    ...
     locks_dispose_list
     free lock2
                                                use lock2
                                                // UAF
                                                unlock so_delegreturn_mutex

Get so_delegreturn_mutex before calling locks_lock_inode_wait to fix this
issue.

Fixes: c69899a17ca4 ("NFSv4: Update of VFS byte range lock must be atomic with the stateid update")
Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
---
 fs/nfs/nfs4proc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 970f28dbf253..297ee2442c02 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7112,13 +7112,16 @@ static void nfs4_locku_done(struct rpc_task *task, void *data)
 		.inode = calldata->lsp->ls_state->inode,
 		.stateid = &calldata->arg.stateid,
 	};
+	struct nfs4_state_owner *sp = calldata->ctx->state->owner;
 
 	if (!nfs4_sequence_done(task, &calldata->res.seq_res))
 		return;
 	switch (task->tk_status) {
 		case 0:
 			renew_lease(calldata->server, calldata->timestamp);
+			mutex_lock(&sp->so_delegreturn_mutex);
 			locks_lock_inode_wait(calldata->lsp->ls_state->inode, &calldata->fl);
+			mutex_unlock(&sp->so_delegreturn_mutex);
 			if (nfs4_update_lock_stateid(calldata->lsp,
 					&calldata->res.stateid))
 				break;
@@ -7375,6 +7378,7 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_lockdata *data = calldata;
 	struct nfs4_lock_state *lsp = data->lsp;
+	struct nfs4_state_owner *sp = data->ctx->state->owner;
 
 	if (!nfs4_sequence_done(task, &data->res.seq_res))
 		return;
@@ -7386,8 +7390,12 @@ static void nfs4_lock_done(struct rpc_task *task, void *calldata)
 				data->timestamp);
 		if (data->arg.new_lock && !data->cancelled) {
 			data->fl.c.flc_flags &= ~(FL_SLEEP | FL_ACCESS);
-			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0)
+			mutex_lock(&sp->so_delegreturn_mutex);
+			if (locks_lock_inode_wait(lsp->ls_state->inode, &data->fl) < 0) {
+				mutex_unlock(&sp->so_delegreturn_mutex);
 				goto out_restart;
+			}
+			mutex_unlock(&sp->so_delegreturn_mutex);
 		}
 		if (data->arg.new_lock_owner != 0) {
 			nfs_confirm_seqid(&lsp->ls_seqid, 0);
@@ -7597,11 +7605,14 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	int status;
 
 	request->c.flc_flags |= FL_ACCESS;
-	status = locks_lock_inode_wait(state->inode, request);
-	if (status < 0)
-		goto out;
 	mutex_lock(&sp->so_delegreturn_mutex);
 	down_read(&nfsi->rwsem);
+	status = locks_lock_inode_wait(state->inode, request);
+	if (status < 0) {
+		up_read(&nfsi->rwsem);
+		mutex_unlock(&sp->so_delegreturn_mutex);
+		goto out;
+	}
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-- 
2.31.1


