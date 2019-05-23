Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B192F27FAF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 16:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfEWO33 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 10:29:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36381 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730709AbfEWO33 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 10:29:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72CE585543;
        Thu, 23 May 2019 14:29:28 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3050D5B685;
        Thu, 23 May 2019 14:29:28 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id D978F108CFFE; Thu, 23 May 2019 10:28:41 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 5/5] locks: Cleanup lm_compare_owner and lm_owner_key
Date:   Thu, 23 May 2019 10:28:41 -0400
Message-Id: <6bbc24afa40196c60d4aa45ffa3327d4d3b1fd77.1558620385.git.bcodding@redhat.com>
In-Reply-To: <cover.1558620385.git.bcodding@redhat.com>
References: <cover.1558620385.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 14:29:28 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After the update to use nlm_lockowners for the NLM server, there are no
more users of lm_compare_owner and lm_owner key.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 Documentation/filesystems/Locking | 14 --------------
 fs/locks.c                        |  5 -----
 include/linux/fs.h                |  2 --
 3 files changed, 21 deletions(-)

diff --git a/Documentation/filesystems/Locking b/Documentation/filesystems/Locking
index dac435575384..204dd3ea36bb 100644
--- a/Documentation/filesystems/Locking
+++ b/Documentation/filesystems/Locking
@@ -361,8 +361,6 @@ so fl_release_private called on a lease should not block.
 
 ----------------------- lock_manager_operations ---------------------------
 prototypes:
-	int (*lm_compare_owner)(struct file_lock *, struct file_lock *);
-	unsigned long (*lm_owner_key)(struct file_lock *);
 	void (*lm_notify)(struct file_lock *);  /* unblock callback */
 	int (*lm_grant)(struct file_lock *, struct file_lock *, int);
 	void (*lm_break)(struct file_lock *); /* break_lease callback */
@@ -371,23 +369,11 @@ prototypes:
 locking rules:
 
 			inode->i_lock	blocked_lock_lock	may block
-lm_compare_owner:	yes[1]		maybe			no
-lm_owner_key		yes[1]		yes			no
 lm_notify:		yes		yes			no
 lm_grant:		no		no			no
 lm_break:		yes		no			no
 lm_change		yes		no			no
 
-[1]:	->lm_compare_owner and ->lm_owner_key are generally called with
-*an* inode->i_lock held. It may not be the i_lock of the inode
-associated with either file_lock argument! This is the case with deadlock
-detection, since the code has to chase down the owners of locks that may
-be entirely unrelated to the one on which the lock is being acquired.
-For deadlock detection however, the blocked_lock_lock is also held. The
-fact that these locks are held ensures that the file_locks do not
-disappear out from under you while doing the comparison or generating an
-owner key.
-
 --------------------------- buffer_head -----------------------------------
 prototypes:
 	void (*b_end_io)(struct buffer_head *bh, int uptodate);
diff --git a/fs/locks.c b/fs/locks.c
index 8af49f89ac2f..a647182496ee 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -657,9 +657,6 @@ static inline int locks_overlap(struct file_lock *fl1, struct file_lock *fl2)
  */
 static int posix_same_owner(struct file_lock *fl1, struct file_lock *fl2)
 {
-	if (fl1->fl_lmops && fl1->fl_lmops->lm_compare_owner)
-		return fl2->fl_lmops == fl1->fl_lmops &&
-			fl1->fl_lmops->lm_compare_owner(fl1, fl2);
 	return fl1->fl_owner == fl2->fl_owner;
 }
 
@@ -700,8 +697,6 @@ static void locks_delete_global_locks(struct file_lock *fl)
 static unsigned long
 posix_owner_key(struct file_lock *fl)
 {
-	if (fl->fl_lmops && fl->fl_lmops->lm_owner_key)
-		return fl->fl_lmops->lm_owner_key(fl);
 	return (unsigned long)fl->fl_owner;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..0fa010bb7b6a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1019,8 +1019,6 @@ struct file_lock_operations {
 };
 
 struct lock_manager_operations {
-	int (*lm_compare_owner)(struct file_lock *, struct file_lock *);
-	unsigned long (*lm_owner_key)(struct file_lock *);
 	fl_owner_t (*lm_get_owner)(fl_owner_t);
 	void (*lm_put_owner)(fl_owner_t);
 	void (*lm_notify)(struct file_lock *);	/* unblock callback */
-- 
2.20.1

