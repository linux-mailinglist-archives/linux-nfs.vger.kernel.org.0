Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31875330BF
	for <lists+linux-nfs@lfdr.de>; Tue, 24 May 2022 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiEXS5C (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 May 2022 14:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240487AbiEXS5C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 May 2022 14:57:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351F050075
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 11:57:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C52E1615D5
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:56:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2602BC34100
        for <linux-nfs@vger.kernel.org>; Tue, 24 May 2022 18:56:59 +0000 (UTC)
Subject: [PATCH v2 1/6] fs/locks.c: Count held file locks
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 24 May 2022 14:56:58 -0400
Message-ID: <165341861814.3187.17138555190814888671.stgit@bazille.1015granger.net>
In-Reply-To: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
References: <165341832236.3187.8388683641228729897.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To properly handle an NFSv4.0 RELEASE_LOCKOWNER operation, NFSD needs
to know whether there are locks associated with a lockowner. The
current mechanism for making this assessment is heavyweight, to say
the least.

Instead, NFSD could count the number of locks based on the number of
calls to ->lm_get_owner() and ->lm_put_owner(). The number of
->lm_get_owner() and ->lm_put_owner() calls should always be 100%
balanced once all the locks belonging to a specific lock owner are
removed.

However, NFSD would have to sort out two cases:

+ When fs/locks adds or removes a lock record, and
+ When fs/locks copies a conflicting lock

The latter case should never adjust the "locks held" count. Add a
boolean argument to both APIs so that NFSD knows exactly when to
bump and decrement the lockowner's new "locks held" counter.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svclock.c  |    4 ++--
 fs/locks.c          |   15 ++++++++-------
 fs/nfsd/nfs4state.c |   12 +++++++++---
 fs/nfsd/state.h     |    1 +
 include/linux/fs.h  |   12 +++---------
 5 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index cb3658ab9b7a..020eef930bf1 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -790,12 +790,12 @@ nlmsvc_notify_blocked(struct file_lock *fl)
 	printk(KERN_WARNING "lockd: notification for unknown block!\n");
 }
 
-static fl_owner_t nlmsvc_get_owner(fl_owner_t owner)
+static fl_owner_t nlmsvc_get_owner(fl_owner_t owner, bool lock)
 {
 	return nlmsvc_get_lockowner(owner);
 }
 
-static void nlmsvc_put_owner(fl_owner_t owner)
+static void nlmsvc_put_owner(fl_owner_t owner, bool unlock)
 {
 	nlmsvc_put_lockowner(owner);
 }
diff --git a/fs/locks.c b/fs/locks.c
index ca28e0e50e56..bfeb6c3de03f 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -292,7 +292,8 @@ void locks_release_private(struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_put_owner) {
-			fl->fl_lmops->lm_put_owner(fl->fl_owner);
+			fl->fl_lmops->lm_put_owner(fl->fl_owner,
+						   fl->fl_type == F_UNLCK);
 			fl->fl_owner = NULL;
 		}
 		fl->fl_lmops = NULL;
@@ -358,7 +359,8 @@ EXPORT_SYMBOL(locks_init_lock);
 /*
  * Initialize a new lock from an existing file_lock structure.
  */
-void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
+static void locks_copy_conflock(struct file_lock *new, struct file_lock *fl,
+				bool lock)
 {
 	new->fl_owner = fl->fl_owner;
 	new->fl_pid = fl->fl_pid;
@@ -372,17 +374,16 @@ void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
 
 	if (fl->fl_lmops) {
 		if (fl->fl_lmops->lm_get_owner)
-			fl->fl_lmops->lm_get_owner(fl->fl_owner);
+			fl->fl_lmops->lm_get_owner(fl->fl_owner, lock);
 	}
 }
-EXPORT_SYMBOL(locks_copy_conflock);
 
 void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
 	/* "new" must be a freshly-initialized lock */
 	WARN_ON_ONCE(new->fl_ops);
 
-	locks_copy_conflock(new, fl);
+	locks_copy_conflock(new, fl, true);
 
 	new->fl_file = fl->fl_file;
 	new->fl_ops = fl->fl_ops;
@@ -926,7 +927,7 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
 			module_put(owner);
 			goto retry;
 		}
-		locks_copy_conflock(fl, cfl);
+		locks_copy_conflock(fl, cfl, false);
 		goto out;
 	}
 	fl->fl_type = F_UNLCK;
@@ -1145,7 +1146,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
 				goto retry;
 			}
 			if (conflock)
-				locks_copy_conflock(conflock, fl);
+				locks_copy_conflock(conflock, fl, true);
 			error = -EAGAIN;
 			if (!(request->fl_flags & FL_SLEEP))
 				goto out;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a280256cbb03..d2d9748eaca6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -6735,21 +6735,26 @@ nfs4_transform_lock_offset(struct file_lock *lock)
 }
 
 static fl_owner_t
-nfsd4_lm_get_owner(fl_owner_t owner)
+nfsd4_lm_get_owner(fl_owner_t owner, bool lock)
 {
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
 	nfs4_get_stateowner(&lo->lo_owner);
+	if (lock)
+		atomic_inc(&lo->lo_lockcnt);
 	return owner;
 }
 
 static void
-nfsd4_lm_put_owner(fl_owner_t owner)
+nfsd4_lm_put_owner(fl_owner_t owner, bool unlock)
 {
 	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)owner;
 
-	if (lo)
+	if (lo) {
+		if (unlock)
+			atomic_dec(&lo->lo_lockcnt);
 		nfs4_put_stateowner(&lo->lo_owner);
+	}
 }
 
 /* return pointer to struct nfs4_client if client is expirable */
@@ -6903,6 +6908,7 @@ alloc_init_lock_stateowner(unsigned int strhashval, struct nfs4_client *clp,
 		return NULL;
 	INIT_LIST_HEAD(&lo->lo_blocked);
 	INIT_LIST_HEAD(&lo->lo_owner.so_stateids);
+	atomic_set(&lo->lo_lockcnt, 0);
 	lo->lo_owner.so_is_open_owner = 0;
 	lo->lo_owner.so_seqid = lock->lk_new_lock_seqid;
 	lo->lo_owner.so_ops = &lockowner_ops;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f3d6313914ed..762dff43cf70 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -505,6 +505,7 @@ struct nfs4_openowner {
 struct nfs4_lockowner {
 	struct nfs4_stateowner	lo_owner;	/* must be first element */
 	struct list_head	lo_blocked;	/* blocked file_locks */
+	atomic_t		lo_lockcnt;	/* count of locks held */
 };
 
 static inline struct nfs4_openowner * openowner(struct nfs4_stateowner *so)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b848355b5e6c..841cd62d3eb1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1030,8 +1030,8 @@ struct file_lock_operations {
 
 struct lock_manager_operations {
 	void *lm_mod_owner;
-	fl_owner_t (*lm_get_owner)(fl_owner_t);
-	void (*lm_put_owner)(fl_owner_t);
+	fl_owner_t (*lm_get_owner)(fl_owner_t owner, bool lock);
+	void (*lm_put_owner)(fl_owner_t owner, bool unlock);
 	void (*lm_notify)(struct file_lock *);	/* unblock callback */
 	int (*lm_grant)(struct file_lock *, int);
 	bool (*lm_break)(struct file_lock *);
@@ -1153,10 +1153,9 @@ void locks_free_lock(struct file_lock *fl);
 extern void locks_init_lock(struct file_lock *);
 extern struct file_lock * locks_alloc_lock(void);
 extern void locks_copy_lock(struct file_lock *, struct file_lock *);
-extern void locks_copy_conflock(struct file_lock *, struct file_lock *);
 extern void locks_remove_posix(struct file *, fl_owner_t);
 extern void locks_remove_file(struct file *);
-extern void locks_release_private(struct file_lock *);
+extern void locks_release_private(struct file_lock *fl);
 extern void posix_test_lock(struct file *, struct file_lock *);
 extern int posix_lock_file(struct file *, struct file_lock *, struct file_lock *);
 extern int locks_delete_block(struct file_lock *);
@@ -1225,11 +1224,6 @@ static inline void locks_init_lock(struct file_lock *fl)
 	return;
 }
 
-static inline void locks_copy_conflock(struct file_lock *new, struct file_lock *fl)
-{
-	return;
-}
-
 static inline void locks_copy_lock(struct file_lock *new, struct file_lock *fl)
 {
 	return;


