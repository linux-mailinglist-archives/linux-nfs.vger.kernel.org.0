Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FC3F5259
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Aug 2021 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhHWUop (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Aug 2021 16:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWUoo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Aug 2021 16:44:44 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D850C061575
        for <linux-nfs@vger.kernel.org>; Mon, 23 Aug 2021 13:44:01 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8F74B6855; Mon, 23 Aug 2021 16:44:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8F74B6855
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1629751440;
        bh=1jcNsmr4BfxRt785K4J9j0RKDEjgo33sug4bByiIIis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rr1X90tYkxmVq6FwcwDLY9Jzt1AqlAQFlSLrNLN5pvm6Fps0/4fsIpvWuH3M45RMh
         weFmzIncuWQWp6AV3sOYYpuoShnKr/5IrYhlwE0UHnECxhzBFumeuhce0mYZOcZmTT
         Cw97YRNZEiWVyQ8rMjGJQQLmVm8lD4SMqLdM4aN4=
Date:   Mon, 23 Aug 2021 16:44:00 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        "daire@dneg.com" <daire@dneg.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] Keep read and write fds with each nlm_file
Message-ID: <20210823204400.GH883@fieldses.org>
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
 <1629493326-28336-6-git-send-email-bfields@redhat.com>
 <FD16AB43-CC95-44FC-AB08-159AF5C3CAB7@oracle.com>
 <20210823185734.GG883@fieldses.org>
 <D4CAB684-DE35-4964-AB9C-43FD57FA003D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4CAB684-DE35-4964-AB9C-43FD57FA003D@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH v4] Keep read and write fds with each nlm_file

We shouldn't really be using a read-only file descriptor to take a write
lock.

Most filesystems will put up with it.  But NFS, for example, won't.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/lockd/svc4proc.c         |   4 +-
 fs/lockd/svclock.c          |  25 ++++++---
 fs/lockd/svcproc.c          |   4 +-
 fs/lockd/svcsubs.c          | 102 +++++++++++++++++++++++++-----------
 fs/nfsd/lockd.c             |   8 ++-
 include/linux/lockd/bind.h  |   3 +-
 include/linux/lockd/lockd.h |   9 +++-
 7 files changed, 111 insertions(+), 44 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index bc496bbd696b..e10ae2c41279 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -40,13 +40,15 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 	/* Obtain file pointer. Not used by FREE_ALL call. */
 	if (filp != NULL) {
+		int mode = lock_to_openmode(&lock->fl);
+
 		error = nlm_lookup_file(rqstp, &file, lock);
 		if (error)
 			goto no_locks;
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.fl_file  = file->f_file;
+		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index bc1cf31f3cce..6abbc92b88e3 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -471,6 +471,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 {
 	struct nlm_block	*block = NULL;
 	int			error;
+	int			mode;
 	__be32			ret;
 
 	dprintk("lockd: nlmsvc_lock(%s/%ld, ty=%d, pi=%d, %Ld-%Ld, bl=%d)\n",
@@ -524,7 +525,8 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 
 	if (!wait)
 		lock->fl.fl_flags &= ~FL_SLEEP;
-	error = vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
+	mode = lock_to_openmode(&lock->fl);
+	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
 	lock->fl.fl_flags &= ~FL_SLEEP;
 
 	dprintk("lockd: vfs_lock_file returned %d\n", error);
@@ -577,6 +579,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 		struct nlm_lock *conflock, struct nlm_cookie *cookie)
 {
 	int			error;
+	int			mode;
 	__be32			ret;
 	struct nlm_lockowner	*test_owner;
 
@@ -595,7 +598,8 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 	/* If there's a conflicting lock, remember to clean up the test lock */
 	test_owner = (struct nlm_lockowner *)lock->fl.fl_owner;
 
-	error = vfs_test_lock(file->f_file, &lock->fl);
+	mode = lock_to_openmode(&lock->fl);
+	error = vfs_test_lock(file->f_file[mode], &lock->fl);
 	if (error) {
 		/* We can't currently deal with deferred test requests */
 		if (error == FILE_LOCK_DEFERRED)
@@ -641,7 +645,7 @@ nlmsvc_testlock(struct svc_rqst *rqstp, struct nlm_file *file,
 __be32
 nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 {
-	int	error;
+	int	error = 0;
 
 	dprintk("lockd: nlmsvc_unlock(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
@@ -654,7 +658,12 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	nlmsvc_cancel_blocked(net, file, lock);
 
 	lock->fl.fl_type = F_UNLCK;
-	error = vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
+	if (file->f_file[O_RDONLY])
+		error = vfs_lock_file(file->f_file[O_RDONLY], F_SETLK,
+					&lock->fl, NULL);
+	if (file->f_file[O_WRONLY])
+		error = vfs_lock_file(file->f_file[O_WRONLY], F_SETLK,
+					&lock->fl, NULL);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
 }
@@ -671,6 +680,7 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 {
 	struct nlm_block	*block;
 	int status = 0;
+	int mode;
 
 	dprintk("lockd: nlmsvc_cancel(%s/%ld, pi=%d, %Ld-%Ld)\n",
 				nlmsvc_file_inode(file)->i_sb->s_id,
@@ -686,7 +696,8 @@ nlmsvc_cancel_blocked(struct net *net, struct nlm_file *file, struct nlm_lock *l
 	block = nlmsvc_lookup_block(file, lock);
 	mutex_unlock(&file->f_mutex);
 	if (block != NULL) {
-		vfs_cancel_lock(block->b_file->f_file,
+		mode = lock_to_openmode(&lock->fl);
+		vfs_cancel_lock(block->b_file->f_file[mode],
 				&block->b_call->a_args.lock.fl);
 		status = nlmsvc_unlink_block(block);
 		nlmsvc_release_block(block);
@@ -803,6 +814,7 @@ nlmsvc_grant_blocked(struct nlm_block *block)
 {
 	struct nlm_file		*file = block->b_file;
 	struct nlm_lock		*lock = &block->b_call->a_args.lock;
+	int			mode;
 	int			error;
 	loff_t			fl_start, fl_end;
 
@@ -828,7 +840,8 @@ nlmsvc_grant_blocked(struct nlm_block *block)
 	lock->fl.fl_flags |= FL_SLEEP;
 	fl_start = lock->fl.fl_start;
 	fl_end = lock->fl.fl_end;
-	error = vfs_lock_file(file->f_file, F_SETLK, &lock->fl, NULL);
+	mode = lock_to_openmode(&lock->fl);
+	error = vfs_lock_file(file->f_file[mode], F_SETLK, &lock->fl, NULL);
 	lock->fl.fl_flags &= ~FL_SLEEP;
 	lock->fl.fl_start = fl_start;
 	lock->fl.fl_end = fl_end;
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index f4e5e0eb30fd..99696d3f6dd6 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -55,6 +55,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 	struct nlm_host		*host = NULL;
 	struct nlm_file		*file = NULL;
 	struct nlm_lock		*lock = &argp->lock;
+	int			mode;
 	__be32			error = 0;
 
 	/* nfsd callbacks must have been installed for this procedure */
@@ -75,7 +76,8 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 		*filp = file;
 
 		/* Set up the missing parts of the file_lock structure */
-		lock->fl.fl_file  = file->f_file;
+		mode = lock_to_openmode(&lock->fl);
+		lock->fl.fl_file  = file->f_file[mode];
 		lock->fl.fl_pid = current->tgid;
 		lock->fl.fl_lmops = &nlmsvc_lock_operations;
 		nlmsvc_locks_init_private(&lock->fl, host, (pid_t)lock->svid);
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 13e6ffc219ec..cb3a7512c33e 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -71,14 +71,35 @@ static inline unsigned int file_hash(struct nfs_fh *f)
 	return tmp & (FILE_NRHASH - 1);
 }
 
+int lock_to_openmode(struct file_lock *lock)
+{
+	return (lock->fl_type == F_WRLCK) ? O_WRONLY : O_RDONLY;
+}
+
+/*
+ * Open the file. Note that if we're reexporting, for example,
+ * this could block the lockd thread for a while.
+ *
+ * We have to make sure we have the right credential to open
+ * the file.
+ */
+static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
+			   struct nlm_file *file, int mode)
+{
+	struct file **fp = &file->f_file[mode];
+	__be32	nfserr;
+
+	if (*fp)
+		return 0;
+	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
+	if (nfserr)
+		dprintk("lockd: open failed (error %d)\n", nfserr);
+	return nfserr;
+}
+
 /*
  * Lookup file info. If it doesn't exist, create a file info struct
  * and open a (VFS) file for the given inode.
- *
- * FIXME:
- * Note that we open the file O_RDONLY even when creating write locks.
- * This is not quite right, but for now, we assume the client performs
- * the proper R/W checking.
  */
 __be32
 nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
@@ -87,42 +108,38 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 	struct nlm_file	*file;
 	unsigned int	hash;
 	__be32		nfserr;
+	int		mode;
 
 	nlm_debug_print_fh("nlm_lookup_file", &lock->fh);
 
 	hash = file_hash(&lock->fh);
+	mode = lock_to_openmode(&lock->fl);
 
 	/* Lock file table */
 	mutex_lock(&nlm_file_mutex);
 
 	hlist_for_each_entry(file, &nlm_files[hash], f_list)
-		if (!nfs_compare_fh(&file->f_handle, &lock->fh))
+		if (!nfs_compare_fh(&file->f_handle, &lock->fh)) {
+			mutex_lock(&file->f_mutex);
+			nfserr = nlm_do_fopen(rqstp, file, mode);
+			mutex_unlock(&file->f_mutex);
 			goto found;
-
+		}
 	nlm_debug_print_fh("creating file for", &lock->fh);
 
 	nfserr = nlm_lck_denied_nolocks;
 	file = kzalloc(sizeof(*file), GFP_KERNEL);
 	if (!file)
-		goto out_unlock;
+		goto out_free;
 
 	memcpy(&file->f_handle, &lock->fh, sizeof(struct nfs_fh));
 	mutex_init(&file->f_mutex);
 	INIT_HLIST_NODE(&file->f_list);
 	INIT_LIST_HEAD(&file->f_blocks);
 
-	/*
-	 * Open the file. Note that if we're reexporting, for example,
-	 * this could block the lockd thread for a while.
-	 *
-	 * We have to make sure we have the right credential to open
-	 * the file.
-	 */
-	nfserr = nlmsvc_ops->fopen(rqstp, &lock->fh, &file->f_file);
-	if (nfserr) {
-		dprintk("lockd: open failed (error %d)\n", nfserr);
-		goto out_free;
-	}
+	nfserr = nlm_do_fopen(rqstp, file, mode);
+	if (nfserr)
+		goto out_unlock;
 
 	hlist_add_head(&file->f_list, &nlm_files[hash]);
 
@@ -130,7 +147,6 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
 	dprintk("lockd: found file %p (count %d)\n", file, file->f_count);
 	*result = file;
 	file->f_count++;
-	nfserr = 0;
 
 out_unlock:
 	mutex_unlock(&nlm_file_mutex);
@@ -150,13 +166,34 @@ nlm_delete_file(struct nlm_file *file)
 	nlm_debug_print_file("closing file", file);
 	if (!hlist_unhashed(&file->f_list)) {
 		hlist_del(&file->f_list);
-		nlmsvc_ops->fclose(file->f_file);
+		if (file->f_file[O_RDONLY])
+			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
+		if (file->f_file[O_WRONLY])
+			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
 		kfree(file);
 	} else {
 		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
 	}
 }
 
+static int nlm_unlock_files(struct nlm_file *file)
+{
+	struct file_lock lock;
+	struct file *f;
+
+	lock.fl_type  = F_UNLCK;
+	lock.fl_start = 0;
+	lock.fl_end   = OFFSET_MAX;
+	for (f = file->f_file[0]; f <= file->f_file[1]; f++) {
+		if (f && vfs_lock_file(f, F_SETLK, &lock, NULL) < 0) {
+			pr_warn("lockd: unlock failure in %s:%d\n",
+				__FILE__, __LINE__);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /*
  * Loop over all locks on the given file and perform the specified
  * action.
@@ -184,17 +221,10 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 
 		lockhost = ((struct nlm_lockowner *)fl->fl_owner)->host;
 		if (match(lockhost, host)) {
-			struct file_lock lock = *fl;
 
 			spin_unlock(&flctx->flc_lock);
-			lock.fl_type  = F_UNLCK;
-			lock.fl_start = 0;
-			lock.fl_end   = OFFSET_MAX;
-			if (vfs_lock_file(file->f_file, F_SETLK, &lock, NULL) < 0) {
-				printk("lockd: unlock failure in %s:%d\n",
-						__FILE__, __LINE__);
+			if (nlm_unlock_files(file))
 				return 1;
-			}
 			goto again;
 		}
 	}
@@ -248,6 +278,15 @@ nlm_file_inuse(struct nlm_file *file)
 	return 0;
 }
 
+static void nlm_close_files(struct nlm_file *file)
+{
+	struct file *f;
+
+	for (f = file->f_file[0]; f <= file->f_file[1]; f++)
+		if (f)
+			nlmsvc_ops->fclose(f);
+}
+
 /*
  * Loop over all files in the file table.
  */
@@ -278,7 +317,7 @@ nlm_traverse_files(void *data, nlm_host_match_fn_t match,
 			if (list_empty(&file->f_blocks) && !file->f_locks
 			 && !file->f_shares && !file->f_count) {
 				hlist_del(&file->f_list);
-				nlmsvc_ops->fclose(file->f_file);
+				nlm_close_files(file);
 				kfree(file);
 			}
 		}
@@ -412,6 +451,7 @@ nlmsvc_invalidate_all(void)
 	nlm_traverse_files(NULL, nlmsvc_is_client, NULL);
 }
 
+
 static int
 nlmsvc_match_sb(void *datap, struct nlm_file *file)
 {
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 3f5b3d7b62b7..606fa155c28a 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -25,9 +25,11 @@
  * Note: we hold the dentry use count while the file is open.
  */
 static __be32
-nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
+nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
+		int mode)
 {
 	__be32		nfserr;
+	int		access;
 	struct svc_fh	fh;
 
 	/* must initialize before using! but maxsize doesn't matter */
@@ -36,7 +38,9 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp)
 	memcpy((char*)&fh.fh_handle.fh_base, f->data, f->size);
 	fh.fh_export = NULL;
 
-	nfserr = nfsd_open(rqstp, &fh, S_IFREG, NFSD_MAY_LOCK, filp);
+	access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
+	access |= NFSD_MAY_LOCK;
+	nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
 	fh_put(&fh);
  	/* We return nlm error codes as nlm doesn't know
 	 * about nfsd, but nfsd does know about nlm..
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index 0520c0cd73f4..3bc9f7410e21 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -27,7 +27,8 @@ struct rpc_task;
 struct nlmsvc_binding {
 	__be32			(*fopen)(struct svc_rqst *,
 						struct nfs_fh *,
-						struct file **);
+						struct file **,
+						int mode);
 	void			(*fclose)(struct file *);
 };
 
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 81b71ad2040a..da319de7e557 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -10,6 +10,8 @@
 #ifndef LINUX_LOCKD_LOCKD_H
 #define LINUX_LOCKD_LOCKD_H
 
+/* XXX: a lot of this should really be under fs/lockd. */
+
 #include <linux/in.h>
 #include <linux/in6.h>
 #include <net/ipv6.h>
@@ -154,7 +156,8 @@ struct nlm_rqst {
 struct nlm_file {
 	struct hlist_node	f_list;		/* linked list */
 	struct nfs_fh		f_handle;	/* NFS file handle */
-	struct file *		f_file;		/* VFS file pointer */
+	struct file *		f_file[2];	/* VFS file pointers,
+						   indexed by O_ flags */
 	struct nlm_share *	f_shares;	/* DOS shares */
 	struct list_head	f_blocks;	/* blocked locks */
 	unsigned int		f_locks;	/* guesstimate # of locks */
@@ -267,6 +270,7 @@ typedef int	  (*nlm_host_match_fn_t)(void *cur, struct nlm_host *ref);
 /*
  * Server-side lock handling
  */
+int		  lock_to_openmode(struct file_lock *);
 __be32		  nlmsvc_lock(struct svc_rqst *, struct nlm_file *,
 			      struct nlm_host *, struct nlm_lock *, int,
 			      struct nlm_cookie *, int);
@@ -301,7 +305,8 @@ int           nlmsvc_unlock_all_by_ip(struct sockaddr *server_addr);
 
 static inline struct inode *nlmsvc_file_inode(struct nlm_file *file)
 {
-	return locks_inode(file->f_file);
+	return locks_inode(file->f_file[0] ?
+				file->f_file[0] : file->f_file[1]);
 }
 
 static inline int __nlm_privileged_request4(const struct sockaddr *sap)
-- 
2.31.1

