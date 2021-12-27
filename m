Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45648045A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhL0TLi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45276 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhL0TLg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B33B7B81148
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15868C36AEC;
        Mon, 27 Dec 2021 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632294;
        bh=/bCzGcoRaTtjdBK5oZaxmBRvH6J4+pqPfY9R+5C8kHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W8Is4LL0r3rPBVhyAUrPm1eXAakoBpL1uAtDUeJ6V7GtAGONnBX56yGjCMj83IuPW
         f9vNcqnac61fFKVnF/tMV76CVdbSY1U69Rmwoms7FQXpuJk5x49m/CaaaZNw7qyohd
         Yg7Dsdcc0cajiEwCR8N1ycl6lUWWKOGgXcLOHIG8ge7BXonskf4kG19GN0CLOlnSZr
         3vIJ5k37LhDogncKGkGWM0yPf/elRWDjChi8Aac4auios/MuB7Tl6nQGNBb9SRKx8a
         4A0h+OPdvo8GxuoYhBUxeHb2JqNHdNzMToCiRwc7fRukkGe2K6v0II9DUBN/uzKlQb
         BqHRK6pHrsdLw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/8] NFS: Support statx_get and statx_set ioctls
Date:   Mon, 27 Dec 2021 14:05:03 -0500
Message-Id: <20211227190504.309612-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-7-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <20211227190504.309612-2-trondmy@kernel.org>
 <20211227190504.309612-3-trondmy@kernel.org>
 <20211227190504.309612-4-trondmy@kernel.org>
 <20211227190504.309612-5-trondmy@kernel.org>
 <20211227190504.309612-6-trondmy@kernel.org>
 <20211227190504.309612-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Richard Sharpe <richard.sharpe@primarydata.com>

Add support for returning all of the Windows attributes with a statx
ioctl.
Add support for setting all of the Windows attributes using an ioctl.

Signed-off-by: Richard Sharpe <richard.sharpe@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c             |  24 +-
 fs/nfs/getroot.c         |   3 +-
 fs/nfs/inode.c           |  41 +++-
 fs/nfs/internal.h        |   8 +
 fs/nfs/nfs3proc.c        |   1 +
 fs/nfs/nfs4_fs.h         |  31 +++
 fs/nfs/nfs4file.c        | 511 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4proc.c        | 124 ++++++++++
 fs/nfs/nfs4xdr.c         |  63 ++++-
 fs/nfs/nfstrace.c        |   5 +
 fs/nfs/nfstrace.h        |   5 +
 fs/nfs/proc.c            |   1 +
 include/linux/nfs_fs.h   |   1 +
 include/linux/nfs_xdr.h  |   3 +
 include/uapi/linux/nfs.h |  90 +++++++
 15 files changed, 887 insertions(+), 24 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9883f72fdb6f..10a6484c59d3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -48,11 +48,6 @@
 
 /* #define NFS_DEBUG_VERBOSE 1 */
 
-static int nfs_opendir(struct inode *, struct file *);
-static int nfs_closedir(struct inode *, struct file *);
-static int nfs_readdir(struct file *, struct dir_context *);
-static int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
-static loff_t nfs_llseek_dir(struct file *, loff_t, int);
 static void nfs_readdir_clear_array(struct page*);
 
 const struct file_operations nfs_dir_operations = {
@@ -63,6 +58,7 @@ const struct file_operations nfs_dir_operations = {
 	.release	= nfs_closedir,
 	.fsync		= nfs_fsync_dir,
 };
+EXPORT_SYMBOL_GPL(nfs_dir_operations);
 
 const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
@@ -104,8 +100,7 @@ static void put_nfs_open_dir_context(struct inode *dir, struct nfs_open_dir_cont
 /*
  * Open file
  */
-static int
-nfs_opendir(struct inode *inode, struct file *filp)
+int nfs_opendir(struct inode *inode, struct file *filp)
 {
 	int res = 0;
 	struct nfs_open_dir_context *ctx;
@@ -123,13 +118,14 @@ nfs_opendir(struct inode *inode, struct file *filp)
 out:
 	return res;
 }
+EXPORT_SYMBOL_GPL(nfs_opendir);
 
-static int
-nfs_closedir(struct inode *inode, struct file *filp)
+int nfs_closedir(struct inode *inode, struct file *filp)
 {
 	put_nfs_open_dir_context(file_inode(filp), filp->private_data);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nfs_closedir);
 
 struct nfs_cache_array_entry {
 	u64 cookie;
@@ -1064,7 +1060,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
    last cookie cache takes care of the common case of reading the
    whole directory.
  */
-static int nfs_readdir(struct file *file, struct dir_context *ctx)
+int nfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
@@ -1157,8 +1153,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
 }
+EXPORT_SYMBOL_GPL(nfs_readdir);
 
-static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
+loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 {
 	struct nfs_open_dir_context *dir_ctx = filp->private_data;
 
@@ -1196,19 +1193,20 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	spin_unlock(&filp->f_lock);
 	return offset;
 }
+EXPORT_SYMBOL_GPL(nfs_llseek_dir);
 
 /*
  * All directory operations under NFS are synchronous, so fsync()
  * is a dummy operation.
  */
-static int nfs_fsync_dir(struct file *filp, loff_t start, loff_t end,
-			 int datasync)
+int nfs_fsync_dir(struct file *filp, loff_t start, loff_t end, int datasync)
 {
 	dfprintk(FILE, "NFS: fsync dir(%pD2) datasync %d\n", filp, datasync);
 
 	nfs_inc_stats(file_inode(filp), NFSIOS_VFSFSYNC);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nfs_fsync_dir);
 
 /**
  * nfs_force_lookup_revalidate - Mark the directory as having changed
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 11ff2b2e060f..f872970d6240 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -127,7 +127,8 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 	if (server->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;
 	if (ctx->clone_data.sb) {
-		if (d_inode(fc->root)->i_fop != &nfs_dir_operations) {
+		if (d_inode(fc->root)->i_fop !=
+		    server->nfs_client->rpc_ops->dir_ops) {
 			error = -ESTALE;
 			goto error_splat_root;
 		}
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 33f4410190b6..8da662a4953d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -108,6 +108,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
 		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
 	return ino;
 }
+EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
 
 int nfs_drop_inode(struct inode *inode)
 {
@@ -501,7 +502,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			nfs_inode_init_regular(nfsi);
 		} else if (S_ISDIR(inode->i_mode)) {
 			inode->i_op = NFS_SB(sb)->nfs_client->rpc_ops->dir_inode_ops;
-			inode->i_fop = &nfs_dir_operations;
+			inode->i_fop = NFS_SB(sb)->nfs_client->rpc_ops->dir_ops;
 			inode->i_data.a_ops = &nfs_dir_aops;
 			nfs_inode_init_dir(nfsi);
 			/* Deal with crossing mountpoints */
@@ -867,6 +868,44 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 	return reply_mask;
 }
 
+static int nfs_getattr_revalidate_force(struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	struct nfs_server *server = NFS_SERVER(inode);
+
+	if (!(server->flags & NFS_MOUNT_NOAC))
+		nfs_readdirplus_parent_cache_miss(dentry);
+	else
+		nfs_readdirplus_parent_cache_hit(dentry);
+	return __nfs_revalidate_inode(server, inode);
+}
+
+static int nfs_getattr_revalidate_none(struct dentry *dentry)
+{
+	nfs_readdirplus_parent_cache_hit(dentry);
+	return NFS_STALE(d_inode(dentry)) ? -ESTALE : 0;
+}
+
+static int nfs_getattr_revalidate_maybe(struct dentry *dentry,
+					unsigned long flags)
+{
+	if (nfs_check_cache_invalid(d_inode(dentry), flags))
+		return nfs_getattr_revalidate_force(dentry);
+	return nfs_getattr_revalidate_none(dentry);
+}
+
+int nfs_getattr_revalidate(const struct path *path,
+			   unsigned long flags,
+			   unsigned int query_flags)
+{
+	if (query_flags & AT_STATX_FORCE_SYNC)
+		return nfs_getattr_revalidate_force(path->dentry);
+	if (!(query_flags & AT_STATX_DONT_SYNC))
+		return nfs_getattr_revalidate_maybe(path->dentry, flags);
+	return nfs_getattr_revalidate_none(path->dentry);
+}
+EXPORT_SYMBOL_GPL(nfs_getattr_revalidate);
+
 int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		struct kstat *stat, u32 request_mask, unsigned int query_flags)
 {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 12f6acb483bb..9602a886f0f0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -366,6 +366,12 @@ extern struct nfs_client *nfs_init_client(struct nfs_client *clp,
 			   const struct nfs_client_initdata *);
 
 /* dir.c */
+int nfs_opendir(struct inode *, struct file *);
+int nfs_closedir(struct inode *, struct file *);
+int nfs_readdir(struct file *file, struct dir_context *ctx);
+int nfs_fsync_dir(struct file *, loff_t, loff_t, int);
+loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence);
+
 extern void nfs_advise_use_readdirplus(struct inode *dir);
 extern void nfs_force_use_readdirplus(struct inode *dir);
 extern unsigned long nfs_access_cache_count(struct shrinker *shrink,
@@ -411,6 +417,8 @@ extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 extern int nfs_wait_atomic_killable(atomic_t *p, unsigned int mode);
+extern int nfs_getattr_revalidate(const struct path *path, unsigned long flags,
+				  unsigned int query_flags);
 
 /* super.c */
 extern const struct super_operations nfs_sops;
diff --git a/fs/nfs/nfs3proc.c b/fs/nfs/nfs3proc.c
index 1597eef40d54..ea3afdc8a58b 100644
--- a/fs/nfs/nfs3proc.c
+++ b/fs/nfs/nfs3proc.c
@@ -1019,6 +1019,7 @@ const struct nfs_rpc_ops nfs_v3_clientops = {
 	.dir_inode_ops	= &nfs3_dir_inode_operations,
 	.file_inode_ops	= &nfs3_file_inode_operations,
 	.file_ops	= &nfs_file_operations,
+	.dir_ops	= &nfs_dir_operations,
 	.nlmclnt_ops	= &nlmclnt_fl_close_lock_ops,
 	.getroot	= nfs3_proc_get_root,
 	.submount	= nfs_submount,
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index ed5eaca6801e..9f21d8520e99 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -248,6 +248,34 @@ struct nfs4_opendata {
 	int rpc_status;
 };
 
+struct nfs4_statx {
+	int		real_fd;		/* real FD to use,
+						   -1 means use current file */
+	__u32		fa_options;		/* statx flags */
+	__u64		fa_request[2];		/* Attributes requested */
+	__u64		fa_valid[2];		/* Attributes set */
+
+	struct timespec64 fa_time_backup;	/* Backup time */
+	struct timespec64 fa_btime;		/* Birth time */
+	/* Flag attributes */
+	__u64 fa_flags;
+	struct timespec64 fa_atime;		/* Access time */
+	struct timespec64 fa_mtime;		/* Modify time */
+	struct timespec64 fa_ctime;		/* Change time */
+	kuid_t		fa_owner_uid;		/* Owner User ID */
+	kgid_t		fa_group_gid;		/* Primary Group ID */
+        /* Normal stat fields after this */
+	__u32	 	fa_mode;		/* Mode */
+	unsigned int 	fa_nlink;
+	__u32		fa_blksize;
+	__u32		fa_spare;		/* Alignment */
+	__u64		fa_ino;
+	dev_t		fa_dev;
+	dev_t		fa_rdev;
+	loff_t		fa_size;
+	__u64		fa_blocks;
+};
+
 struct nfs4_add_xprt_data {
 	struct nfs_client	*clp;
 	const struct cred	*cred;
@@ -315,6 +343,9 @@ extern int nfs4_set_rw_stateid(nfs4_stateid *stateid,
 		const struct nfs_open_context *ctx,
 		const struct nfs_lock_context *l_ctx,
 		fmode_t fmode);
+int nfs4_set_nfs4_statx(struct inode *inode,
+		struct nfs4_statx *statx,
+		struct nfs_fattr *fattr);
 extern int nfs4_proc_getattr(struct nfs_server *server, struct nfs_fh *fhandle,
 			     struct nfs_fattr *fattr, struct inode *inode);
 extern int update_open_stateid(struct nfs4_state *state,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e79ae4cbc395..494ebc7cd1c0 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -9,6 +9,8 @@
 #include <linux/falloc.h>
 #include <linux/mount.h>
 #include <linux/nfs_fs.h>
+#include <linux/time32.h>
+#include <linux/compat.h>
 #include <linux/nfs_ssc.h>
 #include "delegation.h"
 #include "internal.h"
@@ -132,6 +134,503 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 	return filemap_check_wb_err(file->f_mapping, since);
 }
 
+static int nfs_get_timespec64(struct timespec64 *ts,
+			      const struct nfs_ioctl_timespec __user *uts)
+{
+	__s64 dummy;
+	if (unlikely(get_user(dummy, &uts->tv_sec) != 0))
+		return EFAULT;
+	ts->tv_sec = dummy;
+	if (unlikely(get_user(dummy, &uts->tv_nsec) != 0))
+		return EFAULT;
+	ts->tv_nsec = dummy;
+	return 0;
+}
+
+static int nfs_put_timespec64(const struct timespec64 *ts,
+			      struct nfs_ioctl_timespec __user *uts)
+{
+	__s64 dummy;
+
+	dummy = ts->tv_sec;
+	if (unlikely(put_user(dummy, &uts->tv_sec) != 0))
+		return EFAULT;
+	dummy = ts->tv_nsec;
+	if (unlikely(put_user(dummy, &uts->tv_nsec) != 0))
+		return EFAULT;
+	return 0;
+}
+
+static struct file *nfs4_get_real_file(struct file *src, unsigned int fd)
+{
+	struct file *filp = fget_raw(fd);
+	int ret = -EBADF;
+
+	if (!filp)
+		goto out;
+	/* Validate that the files share the same underlying filesystem */
+	ret = -EXDEV;
+	if (file_inode(filp)->i_sb != file_inode(src)->i_sb)
+		goto out_put;
+	return filp;
+out_put:
+	fput(filp);
+out:
+	return ERR_PTR(ret);
+}
+
+static unsigned long nfs4_statx_request_to_cache_validity(__u64 request,
+							  u64 fattr_supported)
+{
+	unsigned long ret = 0;
+
+	if (request & NFS_FA_VALID_ATIME)
+		ret |= NFS_INO_INVALID_ATIME;
+	if (request & NFS_FA_VALID_CTIME)
+		ret |= NFS_INO_INVALID_CTIME;
+	if (request & NFS_FA_VALID_MTIME)
+		ret |= NFS_INO_INVALID_MTIME;
+	if (request & NFS_FA_VALID_SIZE)
+		ret |= NFS_INO_INVALID_SIZE;
+
+	if (request & NFS_FA_VALID_MODE)
+		ret |= NFS_INO_INVALID_MODE;
+	if (request & (NFS_FA_VALID_OWNER | NFS_FA_VALID_OWNER_GROUP))
+		ret |= NFS_INO_INVALID_OTHER;
+
+	if (request & NFS_FA_VALID_NLINK)
+		ret |= NFS_INO_INVALID_NLINK;
+	if (request & NFS_FA_VALID_BLOCKS)
+		ret |= NFS_INO_INVALID_BLOCKS;
+
+	if (request & NFS_FA_VALID_TIME_CREATE)
+		ret |= NFS_INO_INVALID_BTIME;
+
+	if (request & NFS_FA_VALID_ARCHIVE) {
+		if (fattr_supported & NFS_ATTR_FATTR_ARCHIVE)
+			ret |= NFS_INO_INVALID_WINATTR;
+		else if (fattr_supported & NFS_ATTR_FATTR_TIME_BACKUP)
+			ret |= NFS_INO_INVALID_WINATTR | NFS_INO_INVALID_MTIME;
+	}
+	if (request & (NFS_FA_VALID_TIME_BACKUP | NFS_FA_VALID_HIDDEN |
+		       NFS_FA_VALID_SYSTEM | NFS_FA_VALID_OFFLINE))
+		ret |= NFS_INO_INVALID_WINATTR;
+
+	return ret ? (ret | NFS_INO_INVALID_CHANGE) : 0;
+}
+
+static long nfs4_ioctl_file_statx_get(struct file *dst_file,
+				      struct nfs_ioctl_nfs4_statx __user *uarg)
+{
+	struct nfs4_statx args = {
+		.real_fd = -1,
+		.fa_valid = { 0 },
+	};
+	struct inode *inode;
+	struct nfs_inode *nfsi;
+	struct nfs_server *server;
+	u64 fattr_supported;
+	unsigned long reval_attr;
+	unsigned int reval_flags;
+	__u32 tmp;
+	int ret;
+
+	/*
+	 * We get the first word from the uarg as it tells us whether
+	 * to use the passed in struct file or use that fd to find the
+	 * struct file.
+	 */
+	if (get_user(args.real_fd, &uarg->real_fd))
+		return -EFAULT;
+
+	if (get_user(args.fa_options, &uarg->fa_options))
+		return -EFAULT;
+
+	if (get_user(args.fa_request[0], &uarg->fa_request[0]))
+		return -EFAULT;
+
+	if (args.real_fd >= 0) {
+		dst_file = nfs4_get_real_file(dst_file, args.real_fd);
+		if (IS_ERR(dst_file))
+			return PTR_ERR(dst_file);
+	}
+
+	/*
+	 * Backward compatibility: we stole the top 32 bits of 'real_fd'
+	 * to create the fa_options field, so if its value is -1, then
+	 * assume it is the high word of (__s64)real_fd == -1, and just
+	 * set it to zero.
+	 */
+	if (args.fa_options == 0xFFFF)
+		args.fa_options = 0;
+
+	inode = file_inode(dst_file);
+	nfsi = NFS_I(inode);
+	server = NFS_SERVER(inode);
+	fattr_supported = server->fattr_valid;
+
+	trace_nfs_ioctl_file_statx_get_enter(inode);
+
+	if (args.fa_options & NFS_FA_OPTIONS_FORCE_SYNC)
+		reval_flags = AT_STATX_FORCE_SYNC;
+	else if (args.fa_options & NFS_FA_OPTIONS_DONT_SYNC)
+		reval_flags = AT_STATX_DONT_SYNC;
+	else
+		reval_flags = AT_STATX_SYNC_AS_STAT;
+
+	reval_attr = nfs4_statx_request_to_cache_validity(args.fa_request[0],
+							  fattr_supported);
+
+	if ((reval_attr & (NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME)) &&
+	    reval_flags != AT_STATX_DONT_SYNC && S_ISREG(inode->i_mode)) {
+		ret = filemap_write_and_wait(inode->i_mapping);
+		if (ret)
+			goto out;
+	}
+
+	if ((dst_file->f_path.mnt->mnt_flags & MNT_NOATIME) ||
+	    ((dst_file->f_path.mnt->mnt_flags & MNT_NODIRATIME) &&
+	     S_ISDIR(inode->i_mode)))
+		reval_attr &= ~NFS_INO_INVALID_ATIME;
+
+	ret = nfs_getattr_revalidate(&dst_file->f_path, reval_attr,
+				     reval_flags);
+	if (ret != 0)
+		goto out;
+
+	ret = -EFAULT;
+	if ((fattr_supported & NFS_ATTR_FATTR_OWNER) &&
+	    (args.fa_request[0] & NFS_FA_VALID_OWNER)) {
+		tmp = from_kuid_munged(current_user_ns(), inode->i_uid);
+		if (unlikely(put_user(tmp, &uarg->fa_owner_uid) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_OWNER;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_GROUP) &&
+	    (args.fa_request[0] & NFS_FA_VALID_OWNER_GROUP)) {
+		tmp = from_kgid_munged(current_user_ns(), inode->i_gid);
+		if (unlikely(put_user(tmp, &uarg->fa_group_gid) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_OWNER_GROUP;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_TIME_BACKUP) &&
+	    (args.fa_request[0] & NFS_FA_VALID_TIME_BACKUP)) {
+		if (nfs_put_timespec64(&nfsi->timebackup, &uarg->fa_time_backup))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_TIME_BACKUP;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_BTIME) &&
+	    (args.fa_request[0] & NFS_FA_VALID_TIME_CREATE)) {
+		if (nfs_put_timespec64(&nfsi->btime, &uarg->fa_btime))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_TIME_CREATE;
+	}
+
+	/* atime, mtime, and ctime are all stored in the regular inode,
+	 * not the nfs inode.
+	 */
+	if ((fattr_supported & NFS_ATTR_FATTR_ATIME) &&
+	    (args.fa_request[0] & NFS_FA_VALID_ATIME)) {
+		if (nfs_put_timespec64(&inode->i_atime, &uarg->fa_atime))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_ATIME;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_MTIME) &&
+	    (args.fa_request[0] & NFS_FA_VALID_MTIME)) {
+		if (nfs_put_timespec64(&inode->i_mtime, &uarg->fa_mtime))
+                        goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_MTIME;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_CTIME) &&
+	    (args.fa_request[0] & NFS_FA_VALID_CTIME)) {
+		if (nfs_put_timespec64(&inode->i_ctime, &uarg->fa_ctime))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_CTIME;
+	}
+
+        /*
+         * It looks like PDFS does not support or properly handle the
+         * archive bit.
+         */
+	if ((fattr_supported & NFS_ATTR_FATTR_ARCHIVE) &&
+	    (args.fa_request[0] & NFS_FA_VALID_ARCHIVE)) {
+		if (nfsi->archive)
+			args.fa_flags |= NFS_FA_FLAG_ARCHIVE;
+		args.fa_valid[0] |= NFS_FA_VALID_ARCHIVE;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_TIME_BACKUP) &&
+	    (args.fa_request[0] & NFS_FA_VALID_ARCHIVE)) {
+		if (timespec64_compare(&inode->i_mtime, &nfsi->timebackup) > 0)
+			args.fa_flags |= NFS_FA_FLAG_ARCHIVE;
+		args.fa_valid[0] |= NFS_FA_VALID_ARCHIVE;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_HIDDEN) &&
+	    (args.fa_request[0] & NFS_FA_VALID_HIDDEN)) {
+		if (nfsi->hidden)
+			args.fa_flags |= NFS_FA_FLAG_HIDDEN;
+		args.fa_valid[0] |= NFS_FA_VALID_HIDDEN;
+	}
+	if ((fattr_supported & NFS_ATTR_FATTR_SYSTEM) &&
+	    (args.fa_request[0] & NFS_FA_VALID_SYSTEM)) {
+		if (nfsi->system)
+			args.fa_flags |= NFS_FA_FLAG_SYSTEM;
+		args.fa_valid[0] |= NFS_FA_VALID_SYSTEM;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_OFFLINE) &&
+	    (args.fa_request[0] & NFS_FA_VALID_OFFLINE)) {
+		if (nfsi->offline)
+			args.fa_flags |= NFS_FA_FLAG_OFFLINE;
+		args.fa_valid[0] |= NFS_FA_VALID_OFFLINE;
+	}
+
+	if ((args.fa_valid[0] & (NFS_FA_VALID_ARCHIVE |
+				NFS_FA_VALID_HIDDEN |
+				NFS_FA_VALID_SYSTEM |
+				NFS_FA_VALID_OFFLINE)) &&
+	    put_user(args.fa_flags, &uarg->fa_flags))
+		goto out;
+
+	if ((fattr_supported & NFS_ATTR_FATTR_MODE) &&
+	    (args.fa_request[0] & NFS_FA_VALID_MODE)) {
+		tmp = inode->i_mode;
+		/* This is an unsigned short we put into an __u32 */
+		if (unlikely(put_user(tmp, &uarg->fa_mode) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_MODE;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_NLINK) &&
+	    (args.fa_request[0] & NFS_FA_VALID_NLINK)) {
+		tmp = inode->i_nlink;
+		if (unlikely(put_user(tmp, &uarg->fa_nlink) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_NLINK;
+	}
+
+	if (args.fa_request[0] & NFS_FA_VALID_BLKSIZE) {
+		tmp = i_blocksize(inode);
+		if (S_ISDIR(inode->i_mode))
+			tmp = NFS_SERVER(inode)->dtsize;
+		if (unlikely(put_user(tmp, &uarg->fa_blksize) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_BLKSIZE;
+	}
+
+	if (args.fa_request[0] & NFS_FA_VALID_INO) {
+		__u64 ino = nfs_compat_user_ino64(NFS_FILEID(inode));
+		if (unlikely(put_user(ino, &uarg->fa_ino) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_INO;
+	}
+
+	if (args.fa_request[0] & NFS_FA_VALID_DEV) {
+		tmp = inode->i_sb->s_dev;
+		if (unlikely(put_user(tmp, &uarg->fa_dev) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_DEV;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_RDEV) &&
+	    (args.fa_request[0] & NFS_FA_VALID_RDEV)) {
+		tmp = inode->i_rdev;
+		if (unlikely(put_user(tmp, &uarg->fa_rdev) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_RDEV;
+	}
+
+	if ((fattr_supported & NFS_ATTR_FATTR_SIZE) &&
+	    (args.fa_request[0] & NFS_FA_VALID_SIZE)) {
+		__s64 size = i_size_read(inode);
+		if (unlikely(put_user(size, &uarg->fa_size) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_SIZE;
+	}
+
+	if ((fattr_supported &
+	     (NFS_ATTR_FATTR_BLOCKS_USED | NFS_ATTR_FATTR_SPACE_USED)) &&
+	    (args.fa_request[0] & NFS_FA_VALID_BLOCKS)) {
+		__s64 blocks = inode->i_blocks;
+		if (unlikely(put_user(blocks, &uarg->fa_blocks) != 0))
+			goto out;
+		args.fa_valid[0] |= NFS_FA_VALID_BLOCKS;
+	}
+
+	if (unlikely(put_user(args.fa_valid[0], &uarg->fa_valid[0]) != 0))
+		goto out;
+	if (unlikely(put_user(args.fa_valid[1], &uarg->fa_valid[1]) != 0))
+		goto out;
+
+	ret = 0;
+out:
+	if (args.real_fd >= 0)
+		fput(dst_file);
+	trace_nfs_ioctl_file_statx_get_exit(inode, ret);
+	return ret;
+}
+
+static long nfs4_ioctl_file_statx_set(struct file *dst_file,
+				      struct nfs_ioctl_nfs4_statx __user *uarg)
+{
+	struct nfs4_statx args = {
+		.real_fd = -1,
+		.fa_valid = { 0 },
+	};
+	struct nfs_fattr *fattr = nfs_alloc_fattr();
+	struct inode *inode;
+	/*
+	 * If you need a different error code below, you need to set it
+	 */
+	int ret = -EFAULT;
+
+	if (fattr == NULL)
+		return -ENOMEM;
+
+	/*
+	 * We get the first u64 word from the uarg as it tells us whether
+	 * to use the passed in struct file or use that fd to find the
+	 * struct file.
+	 */
+	if (get_user(args.real_fd, &uarg->real_fd))
+		goto out_free;
+
+	if (args.real_fd >= 0) {
+		dst_file = nfs4_get_real_file(dst_file, args.real_fd);
+		if (IS_ERR(dst_file)) {
+			ret = PTR_ERR(dst_file);
+			goto out_free;
+		}
+	}
+	inode = file_inode(dst_file);
+	trace_nfs_ioctl_file_statx_set_enter(inode);
+
+	inode_lock(inode);
+
+	/* Write all dirty data */
+	if (S_ISREG(inode->i_mode)) {
+		ret = nfs_sync_inode(inode);
+		if (ret)
+			goto out;
+	}
+
+	ret = -EFAULT;
+	if (get_user(args.fa_valid[0], &uarg->fa_valid[0]))
+		goto out;
+	args.fa_valid[0] &= NFS_FA_VALID_ALL_ATTR_0;
+
+	if (args.fa_valid[0] & NFS_FA_VALID_OWNER) {
+		uid_t uid;
+
+		if (unlikely(get_user(uid, &uarg->fa_owner_uid) != 0))
+			goto out;
+		args.fa_owner_uid = make_kuid(current_user_ns(), uid);
+		if (!uid_valid(args.fa_owner_uid)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if (args.fa_valid[0] & NFS_FA_VALID_OWNER_GROUP) {
+		gid_t gid;
+
+		if (unlikely(get_user(gid, &uarg->fa_group_gid) != 0))
+			goto out;
+		args.fa_group_gid = make_kgid(current_user_ns(), gid);
+		if (!gid_valid(args.fa_group_gid)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	if ((args.fa_valid[0] & (NFS_FA_VALID_ARCHIVE |
+					NFS_FA_VALID_HIDDEN |
+					NFS_FA_VALID_SYSTEM)) &&
+	    get_user(args.fa_flags, &uarg->fa_flags))
+		goto out;
+
+	if ((args.fa_valid[0] & NFS_FA_VALID_TIME_CREATE) &&
+	    nfs_get_timespec64(&args.fa_btime, &uarg->fa_btime))
+		goto out;
+
+	if ((args.fa_valid[0] & NFS_FA_VALID_ATIME) &&
+	    nfs_get_timespec64(&args.fa_atime, &uarg->fa_atime))
+		goto out;
+
+	if ((args.fa_valid[0] & NFS_FA_VALID_MTIME) &&
+	    nfs_get_timespec64(&args.fa_mtime, &uarg->fa_mtime))
+		goto out;
+
+	if (args.fa_valid[0] & NFS_FA_VALID_TIME_BACKUP) {
+		if (nfs_get_timespec64(&args.fa_time_backup, &uarg->fa_time_backup))
+			goto out;
+	} else if ((args.fa_valid[0] & NFS_FA_VALID_ARCHIVE) &&
+			!(NFS_SERVER(inode)->fattr_valid & NFS_ATTR_FATTR_ARCHIVE)) {
+		args.fa_valid[0] |= NFS_FA_VALID_TIME_BACKUP;
+		if (!(args.fa_flags & NFS_FA_FLAG_ARCHIVE)) {
+			nfs_revalidate_inode(inode, NFS_INO_INVALID_MTIME);
+			args.fa_time_backup.tv_sec = inode->i_mtime.tv_sec;
+			args.fa_time_backup.tv_nsec = inode->i_mtime.tv_nsec;
+		} else if (args.fa_valid[0] & NFS_FA_VALID_TIME_CREATE)
+			args.fa_time_backup = args.fa_btime;
+		else {
+			nfs_revalidate_inode(inode, NFS_INO_INVALID_BTIME);
+			args.fa_time_backup = NFS_I(inode)->btime;
+		}
+	}
+
+        if (args.fa_valid[0] & NFS_FA_VALID_SIZE) {
+		if (copy_from_user(&args.fa_size, &uarg->fa_size,
+					sizeof(args.fa_size)))
+			goto out;
+		ret = inode_newsize_ok(inode,args.fa_size);
+		if (ret)
+			goto out;
+		if (args.fa_size == i_size_read(inode))
+			args.fa_valid[0] &= ~NFS_FA_VALID_SIZE;
+	}
+
+	/*
+	 * No need to update the inode because that is done in nfs4_set_nfs4_statx
+	 */
+	ret = nfs4_set_nfs4_statx(inode, &args, fattr);
+
+out:
+	inode_unlock(inode);
+	if (args.real_fd >= 0)
+		fput(dst_file);
+	trace_nfs_ioctl_file_statx_set_exit(inode, ret);
+out_free:
+	nfs_free_fattr(fattr);
+	return ret;
+}
+
+static long nfs4_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	long ret;
+
+	switch (cmd) {
+	case NFS_IOC_FILE_STATX_GET:
+		ret = nfs4_ioctl_file_statx_get(file, argp);
+		break;
+	case NFS_IOC_FILE_STATX_SET:
+		ret = nfs4_ioctl_file_statx_set(file, argp);
+		break;
+	default:
+		ret = -ENOIOCTLCMD;
+	}
+
+	dprintk("%s: file=%pD2, cmd=%u, ret=%ld\n", __func__, file, cmd, ret);
+	return ret;
+}
+
 #ifdef CONFIG_NFS_V4_2
 static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				      struct file *file_out, loff_t pos_out,
@@ -187,6 +686,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	return ret;
 }
 
+
 static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    size_t count, unsigned int flags)
@@ -461,4 +961,15 @@ const struct file_operations nfs4_file_operations = {
 #else
 	.llseek		= nfs_file_llseek,
 #endif
+	.unlocked_ioctl	= nfs4_ioctl,
+};
+
+const struct file_operations nfs4_dir_operations = {
+	.llseek		= nfs_llseek_dir,
+	.read		= generic_read_dir,
+	.iterate_shared	= nfs_readdir,
+	.open		= nfs_opendir,
+	.release	= nfs_closedir,
+	.fsync		= nfs_fsync_dir,
+	.unlocked_ioctl	= nfs4_ioctl,
 };
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 713a71fb3020..db09371a4fda 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7961,6 +7961,129 @@ static int _nfs41_proc_get_locations(struct inode *inode,
 
 #endif	/* CONFIG_NFS_V4_1 */
 
+static int _nfs4_set_nfs4_statx(struct inode *inode,
+		struct nfs4_statx *statx,
+		struct nfs_fattr *fattr)
+{
+	const __u64 statx_win = NFS_FA_VALID_TIME_CREATE |
+				NFS_FA_VALID_TIME_BACKUP |
+				NFS_FA_VALID_ARCHIVE | NFS_FA_VALID_HIDDEN |
+				NFS_FA_VALID_SYSTEM;
+	struct iattr sattr = {0};
+	struct nfs_server *server = NFS_SERVER(inode);
+	__u32 bitmask[3];
+	struct nfs_setattrargs arg = {
+		.fh             = NFS_FH(inode),
+		.iap            = &sattr,
+		.server		= server,
+		.bitmask	= bitmask,
+		.statx		= statx,
+	};
+	struct nfs_setattrres res = {
+		.fattr		= fattr,
+		.server		= server,
+	};
+	struct rpc_message msg = {
+		.rpc_proc       = &nfs4_procedures[NFSPROC4_CLNT_SETATTR],
+		.rpc_argp       = &arg,
+		.rpc_resp       = &res,
+	};
+	int status;
+
+	nfs4_bitmap_copy_adjust(
+		bitmask, server->attr_bitmask, inode,
+		NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+			NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
+			NFS_INO_INVALID_BTIME | NFS_INO_INVALID_WINATTR);
+	/* Use the iattr structure to set atime and mtime since handling already
+	 * exists for them using the iattr struct in the encode_attrs()
+	 * (xdr encoding) routine.
+	 */
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_MTIME)) {
+		sattr.ia_valid |= ATTR_MTIME_SET;
+		sattr.ia_mtime.tv_sec = statx->fa_mtime.tv_sec;
+		sattr.ia_mtime.tv_nsec = statx->fa_mtime.tv_nsec;
+	}
+
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_ATIME)) {
+		sattr.ia_valid |= ATTR_ATIME_SET;
+		sattr.ia_atime.tv_sec = statx->fa_atime.tv_sec;
+		sattr.ia_atime.tv_nsec = statx->fa_atime.tv_nsec;
+	}
+
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_OWNER)) {
+		sattr.ia_valid |= ATTR_UID;
+		sattr.ia_uid = statx->fa_owner_uid;
+	}
+
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_OWNER_GROUP)) {
+		sattr.ia_valid |= ATTR_GID;
+		sattr.ia_gid = statx->fa_group_gid;
+	}
+
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_SIZE)) {
+		sattr.ia_valid |= ATTR_SIZE;
+		sattr.ia_size = statx->fa_size;
+	}
+
+	nfs4_stateid_copy(&arg.stateid, &zero_stateid);
+
+	status = nfs4_call_sync(server->client, server, &msg, &arg.seq_args, &res.seq_res, 1);
+	if (!status) {
+		if (statx->fa_valid[0] & statx_win) {
+			struct nfs_inode *nfsi = NFS_I(inode);
+
+			spin_lock(&inode->i_lock);
+			if (statx->fa_valid[0] & NFS_FA_VALID_TIME_CREATE)
+				nfsi->btime = statx->fa_btime;
+			if (statx->fa_valid[0] & NFS_FA_VALID_TIME_BACKUP)
+				nfsi->timebackup = statx->fa_time_backup;
+			if (statx->fa_valid[0] & NFS_FA_VALID_ARCHIVE)
+				nfsi->archive = (statx->fa_flags &
+						 NFS_FA_FLAG_ARCHIVE) != 0;
+			if (statx->fa_valid[0] & NFS_FA_VALID_SYSTEM)
+				nfsi->system = (statx->fa_flags &
+						NFS_FA_FLAG_SYSTEM) != 0;
+			if (statx->fa_valid[0] & NFS_FA_VALID_HIDDEN)
+				nfsi->hidden = (statx->fa_flags &
+						NFS_FA_FLAG_HIDDEN) != 0;
+			if (statx->fa_valid[0] & NFS_FA_VALID_OFFLINE)
+				nfsi->offline = (statx->fa_flags &
+						 NFS_FA_FLAG_OFFLINE) != 0;
+
+			nfsi->cache_validity &= ~NFS_INO_INVALID_CTIME;
+			if (fattr->valid & NFS_ATTR_FATTR_CTIME)
+				inode->i_ctime = fattr->ctime;
+			else
+				nfs_set_cache_invalid(
+					inode, NFS_INO_INVALID_CHANGE |
+						   NFS_INO_INVALID_CTIME);
+			spin_unlock(&inode->i_lock);
+		}
+
+		nfs_setattr_update_inode(inode, &sattr, fattr);
+	} else
+		dprintk("%s failed: %d\n", __func__, status);
+
+	return status;
+}
+
+int nfs4_set_nfs4_statx(struct inode *inode,
+		struct nfs4_statx *statx,
+		struct nfs_fattr *fattr)
+{
+	struct nfs4_exception exception = { };
+	struct nfs_server *server = NFS_SERVER(inode);
+	int err;
+
+	do {
+		err = nfs4_handle_exception(server,
+				_nfs4_set_nfs4_statx(inode, statx, fattr),
+				&exception);
+	} while (exception.retry);
+	return err;
+}
+
 /**
  * nfs4_proc_get_locations - discover locations for a migrated FSID
  * @inode: inode on FSID that is migrating
@@ -10421,6 +10544,7 @@ const struct nfs_rpc_ops nfs_v4_clientops = {
 	.dir_inode_ops	= &nfs4_dir_inode_operations,
 	.file_inode_ops	= &nfs4_file_inode_operations,
 	.file_ops	= &nfs4_file_operations,
+	.dir_ops	= &nfs4_dir_operations,
 	.getroot	= nfs4_proc_get_root,
 	.submount	= nfs4_submount,
 	.try_get_tree	= nfs4_try_get_tree,
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index a45872f860ec..05a1f9fdf65d 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -129,12 +129,15 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				nfs4_fattr_value_maxsz)
 #define decode_getattr_maxsz    (op_decode_hdr_maxsz + nfs4_fattr_maxsz)
 #define encode_attrs_maxsz	(nfs4_fattr_bitmap_maxsz + \
-				 1 + 2 + 1 + \
+				 1 + 2 + 1 + 1 + 1 + \
 				nfs4_owner_maxsz + \
 				nfs4_group_maxsz + \
-				nfs4_label_maxsz + \
+				1 + \
+				1 + nfstime4_maxsz + \
+				nfstime4_maxsz + nfstime4_maxsz + \
 				1 + nfstime4_maxsz + \
-				1 + nfstime4_maxsz)
+				nfs4_label_maxsz + \
+				2)
 #define encode_savefh_maxsz     (op_encode_hdr_maxsz)
 #define decode_savefh_maxsz     (op_decode_hdr_maxsz)
 #define encode_restorefh_maxsz  (op_encode_hdr_maxsz)
@@ -1081,6 +1084,7 @@ xdr_encode_nfstime4(__be32 *p, const struct timespec64 *t)
 static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 				const struct nfs4_label *label,
 				const umode_t *umask,
+				const struct nfs4_statx *statx,
 				const struct nfs_server *server,
 				const uint32_t attrmask[])
 {
@@ -1153,6 +1157,34 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 		}
 	}
 
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_TIME_BACKUP) &&
+	    (attrmask[1] & FATTR4_WORD1_TIME_BACKUP)) {
+		bmval[1] |= FATTR4_WORD1_TIME_BACKUP;
+		len += (nfstime4_maxsz << 2);
+	}
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_TIME_CREATE) &&
+	    (attrmask[1] & FATTR4_WORD1_TIME_CREATE)) {
+		bmval[1] |= FATTR4_WORD1_TIME_CREATE;
+		len += (nfstime4_maxsz << 2);
+	}
+
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_ARCHIVE) &&
+	   (attrmask[0] & FATTR4_WORD0_ARCHIVE)) {
+		bmval[0] |= FATTR4_WORD0_ARCHIVE;
+		len += 4;
+	}
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_HIDDEN) &&
+	   (attrmask[0] & FATTR4_WORD0_HIDDEN)) {
+		bmval[0] |= FATTR4_WORD0_HIDDEN;
+		len += 4;
+	}
+
+	if (statx && (statx->fa_valid[0] & NFS_FA_VALID_SYSTEM) &&
+	   (attrmask[1] & FATTR4_WORD1_SYSTEM)) {
+		bmval[1] |= FATTR4_WORD1_SYSTEM;
+		len += 4;
+	}
+
 	if (label && (attrmask[2] & FATTR4_WORD2_SECURITY_LABEL)) {
 		len += 4 + 4 + 4 + (XDR_QUADLEN(label->len) << 2);
 		bmval[2] |= FATTR4_WORD2_SECURITY_LABEL;
@@ -1163,12 +1195,21 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 
 	if (bmval[0] & FATTR4_WORD0_SIZE)
 		p = xdr_encode_hyper(p, iap->ia_size);
+	if (bmval[0] & FATTR4_WORD0_ARCHIVE)
+		*p++ = (statx->fa_flags & NFS_FA_FLAG_ARCHIVE) ?
+			cpu_to_be32(1) : cpu_to_be32(0);
+	if (bmval[0] & FATTR4_WORD0_HIDDEN)
+		*p++ = (statx->fa_flags & NFS_FA_FLAG_HIDDEN) ?
+			cpu_to_be32(1) : cpu_to_be32(0);
 	if (bmval[1] & FATTR4_WORD1_MODE)
 		*p++ = cpu_to_be32(iap->ia_mode & S_IALLUGO);
 	if (bmval[1] & FATTR4_WORD1_OWNER)
 		p = xdr_encode_opaque(p, owner_name, owner_namelen);
 	if (bmval[1] & FATTR4_WORD1_OWNER_GROUP)
 		p = xdr_encode_opaque(p, owner_group, owner_grouplen);
+	if (bmval[1] & FATTR4_WORD1_SYSTEM)
+		*p++ = (statx->fa_flags & NFS_FA_FLAG_SYSTEM) ?
+			cpu_to_be32(1) : cpu_to_be32(0);
 	if (bmval[1] & FATTR4_WORD1_TIME_ACCESS_SET) {
 		if (iap->ia_valid & ATTR_ATIME_SET) {
 			*p++ = cpu_to_be32(NFS4_SET_TO_CLIENT_TIME);
@@ -1176,6 +1217,10 @@ static void encode_attrs(struct xdr_stream *xdr, const struct iattr *iap,
 		} else
 			*p++ = cpu_to_be32(NFS4_SET_TO_SERVER_TIME);
 	}
+	if (bmval[1] & FATTR4_WORD1_TIME_BACKUP)
+		p = xdr_encode_nfstime4(p, &statx->fa_time_backup);
+	if (bmval[1] & FATTR4_WORD1_TIME_CREATE)
+		p = xdr_encode_nfstime4(p, &statx->fa_btime);
 	if (bmval[1] & FATTR4_WORD1_TIME_MODIFY_SET) {
 		if (iap->ia_valid & ATTR_MTIME_SET) {
 			*p++ = cpu_to_be32(NFS4_SET_TO_CLIENT_TIME);
@@ -1248,7 +1293,7 @@ static void encode_create(struct xdr_stream *xdr, const struct nfs4_create_arg *
 
 	encode_string(xdr, create->name->len, create->name->name);
 	encode_attrs(xdr, create->attrs, create->label, &create->umask,
-			create->server, create->server->attr_bitmask);
+		     NULL, create->server, create->server->attr_bitmask);
 }
 
 static void encode_getattr(struct xdr_stream *xdr,
@@ -1434,12 +1479,12 @@ static inline void encode_createmode(struct xdr_stream *xdr, const struct nfs_op
 	case NFS4_CREATE_UNCHECKED:
 		*p = cpu_to_be32(NFS4_CREATE_UNCHECKED);
 		encode_attrs(xdr, arg->u.attrs, arg->label, &arg->umask,
-				arg->server, arg->server->attr_bitmask);
+			     NULL, arg->server, arg->server->attr_bitmask);
 		break;
 	case NFS4_CREATE_GUARDED:
 		*p = cpu_to_be32(NFS4_CREATE_GUARDED);
 		encode_attrs(xdr, arg->u.attrs, arg->label, &arg->umask,
-				arg->server, arg->server->attr_bitmask);
+			     NULL, arg->server, arg->server->attr_bitmask);
 		break;
 	case NFS4_CREATE_EXCLUSIVE:
 		*p = cpu_to_be32(NFS4_CREATE_EXCLUSIVE);
@@ -1449,7 +1494,7 @@ static inline void encode_createmode(struct xdr_stream *xdr, const struct nfs_op
 		*p = cpu_to_be32(NFS4_CREATE_EXCLUSIVE4_1);
 		encode_nfs4_verifier(xdr, &arg->u.verifier);
 		encode_attrs(xdr, arg->u.attrs, arg->label, &arg->umask,
-				arg->server, arg->server->exclcreat_bitmask);
+			     NULL, arg->server, arg->server->exclcreat_bitmask);
 	}
 }
 
@@ -1712,8 +1757,8 @@ static void encode_setattr(struct xdr_stream *xdr, const struct nfs_setattrargs
 {
 	encode_op_hdr(xdr, OP_SETATTR, decode_setattr_maxsz, hdr);
 	encode_nfs4_stateid(xdr, &arg->stateid);
-	encode_attrs(xdr, arg->iap, arg->label, NULL, server,
-			server->attr_bitmask);
+	encode_attrs(xdr, arg->iap, arg->label, NULL, arg->statx, server,
+		     server->attr_bitmask);
 }
 
 static void encode_setclientid(struct xdr_stream *xdr, const struct nfs4_setclientid *setclientid, struct compound_hdr *hdr)
diff --git a/fs/nfs/nfstrace.c b/fs/nfs/nfstrace.c
index 5d1bfccbb4da..0b88deb0216e 100644
--- a/fs/nfs/nfstrace.c
+++ b/fs/nfs/nfstrace.c
@@ -9,6 +9,11 @@
 #define CREATE_TRACE_POINTS
 #include "nfstrace.h"
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_ioctl_file_statx_get_enter);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_ioctl_file_statx_get_exit);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_ioctl_file_statx_set_enter);
+EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_ioctl_file_statx_set_exit);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_fsync_enter);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_fsync_exit);
 EXPORT_TRACEPOINT_SYMBOL_GPL(nfs_xdr_status);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 2ef7cff8a4ba..b67dd087fb47 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -166,6 +166,11 @@ DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_set_cache_invalid);
 
+DEFINE_NFS_INODE_EVENT(nfs_ioctl_file_statx_get_enter);
+DEFINE_NFS_INODE_EVENT_DONE(nfs_ioctl_file_statx_get_exit);
+DEFINE_NFS_INODE_EVENT(nfs_ioctl_file_statx_set_enter);
+DEFINE_NFS_INODE_EVENT_DONE(nfs_ioctl_file_statx_set_exit);
+
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
 			const struct inode *inode,
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 73dcaa99fa9b..8fd96d93630a 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -717,6 +717,7 @@ const struct nfs_rpc_ops nfs_v2_clientops = {
 	.dir_inode_ops	= &nfs_dir_inode_operations,
 	.file_inode_ops	= &nfs_file_inode_operations,
 	.file_ops	= &nfs_file_operations,
+	.dir_ops	= &nfs_dir_operations,
 	.getroot	= nfs_proc_get_root,
 	.submount	= nfs_submount,
 	.try_get_tree	= nfs_try_get_tree,
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 61f852ebb0a4..7a134e4c03e8 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -503,6 +503,7 @@ extern __be32 root_nfs_parse_addr(char *name); /*__init*/
 extern const struct file_operations nfs_file_operations;
 #if IS_ENABLED(CONFIG_NFS_V4)
 extern const struct file_operations nfs4_file_operations;
+extern const struct file_operations nfs4_dir_operations;
 #endif /* CONFIG_NFS_V4 */
 extern const struct address_space_operations nfs_file_aops;
 extern const struct address_space_operations nfs_dir_aops;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index f5588bc22cb1..9b0a56c11ca9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -812,6 +812,7 @@ struct nfs_createargs {
 	struct iattr *		sattr;
 };
 
+struct nfs4_statx;
 struct nfs_setattrargs {
 	struct nfs4_sequence_args 	seq_args;
 	struct nfs_fh *                 fh;
@@ -820,6 +821,7 @@ struct nfs_setattrargs {
 	const struct nfs_server *	server; /* Needed for name mapping */
 	const u32 *			bitmask;
 	const struct nfs4_label		*label;
+	const struct nfs4_statx		*statx;
 };
 
 struct nfs_setaclargs {
@@ -1744,6 +1746,7 @@ struct nfs_rpc_ops {
 	const struct inode_operations *dir_inode_ops;
 	const struct inode_operations *file_inode_ops;
 	const struct file_operations *file_ops;
+	const struct file_operations *dir_ops;
 	const struct nlmclnt_operations *nlmclnt_ops;
 
 	int	(*getroot) (struct nfs_server *, struct nfs_fh *,
diff --git a/include/uapi/linux/nfs.h b/include/uapi/linux/nfs.h
index 946cb62d64b0..df87da39bc43 100644
--- a/include/uapi/linux/nfs.h
+++ b/include/uapi/linux/nfs.h
@@ -9,6 +9,8 @@
 #define _UAPI_LINUX_NFS_H
 
 #include <linux/types.h>
+#include <asm/byteorder.h>
+#include <linux/time.h>
 
 #define NFS_PROGRAM	100003
 #define NFS_PORT	2049
@@ -35,6 +37,94 @@
 
 #define NFS_PIPE_DIRNAME "nfs"
 
+/* NFS ioctls */
+#define NFS_IOC_FILE_STATX_GET	_IOR('N', 2, struct nfs_ioctl_nfs4_statx)
+#define NFS_IOC_FILE_STATX_SET	_IOW('N', 3, struct nfs_ioctl_nfs4_statx)
+
+/* Options for struct nfs_ioctl_nfs4_statx */
+#define NFS_FA_OPTIONS_SYNC_AS_STAT			0x0000
+#define NFS_FA_OPTIONS_FORCE_SYNC			0x2000 /* See statx */
+#define NFS_FA_OPTIONS_DONT_SYNC			0x4000 /* See statx */
+
+#define NFS_FA_VALID_TIME_CREATE			0x00001UL
+#define NFS_FA_VALID_TIME_BACKUP			0x00002UL
+#define NFS_FA_VALID_ARCHIVE				0x00004UL
+#define NFS_FA_VALID_HIDDEN				0x00008UL
+#define NFS_FA_VALID_SYSTEM				0x00010UL
+#define NFS_FA_VALID_OWNER				0x00020UL
+#define NFS_FA_VALID_OWNER_GROUP			0x00040UL
+#define NFS_FA_VALID_ATIME				0x00080UL
+#define NFS_FA_VALID_MTIME				0x00100UL
+#define NFS_FA_VALID_CTIME				0x00200UL
+#define NFS_FA_VALID_OFFLINE				0x00400UL
+#define NFS_FA_VALID_MODE				0x00800UL
+#define NFS_FA_VALID_NLINK				0x01000UL
+#define NFS_FA_VALID_BLKSIZE				0x02000UL
+#define NFS_FA_VALID_INO				0x04000UL
+#define NFS_FA_VALID_DEV				0x08000UL
+#define NFS_FA_VALID_RDEV				0x10000UL
+#define NFS_FA_VALID_SIZE				0x20000UL
+#define NFS_FA_VALID_BLOCKS				0x40000UL
+
+#define NFS_FA_VALID_ALL_ATTR_0 ( NFS_FA_VALID_TIME_CREATE | \
+		NFS_FA_VALID_TIME_BACKUP | \
+		NFS_FA_VALID_ARCHIVE | \
+		NFS_FA_VALID_HIDDEN | \
+		NFS_FA_VALID_SYSTEM | \
+		NFS_FA_VALID_OWNER | \
+		NFS_FA_VALID_OWNER_GROUP | \
+		NFS_FA_VALID_ATIME | \
+		NFS_FA_VALID_MTIME | \
+		NFS_FA_VALID_CTIME | \
+		NFS_FA_VALID_OFFLINE | \
+		NFS_FA_VALID_MODE | \
+		NFS_FA_VALID_NLINK | \
+		NFS_FA_VALID_BLKSIZE | \
+		NFS_FA_VALID_INO | \
+		NFS_FA_VALID_DEV | \
+		NFS_FA_VALID_RDEV | \
+		NFS_FA_VALID_SIZE | \
+		NFS_FA_VALID_BLOCKS)
+
+#define NFS_FA_FLAG_ARCHIVE				(1UL << 0)
+#define NFS_FA_FLAG_HIDDEN				(1UL << 1)
+#define NFS_FA_FLAG_SYSTEM				(1UL << 2)
+#define NFS_FA_FLAG_OFFLINE				(1UL << 3)
+
+struct nfs_ioctl_timespec {
+	__s64		tv_sec;
+	__s64		tv_nsec;
+};
+
+struct nfs_ioctl_nfs4_statx {
+	__s32		real_fd;		/* real FD to use,
+						   -1 means use current file */
+	__u32		fa_options;
+
+	__u64		fa_request[2];		/* Attributes to retrieve */
+	__u64		fa_valid[2];		/* Attributes set */
+
+	struct nfs_ioctl_timespec fa_time_backup;/* Backup time */
+	struct nfs_ioctl_timespec fa_btime;     /* Birth time */
+	__u64		fa_flags;		/* Flag attributes */
+	/* Ordinary attributes follow */
+	struct nfs_ioctl_timespec fa_atime;	/* Access time */
+	struct nfs_ioctl_timespec fa_mtime;	/* Modify time */
+	struct nfs_ioctl_timespec fa_ctime;	/* Change time */
+	__u32		fa_owner_uid;		/* Owner User ID */
+	__u32		fa_group_gid;		/* Primary Group ID */
+	__u32		fa_mode;		/* Mode */
+	__u32	 	fa_nlink;
+	__u32		fa_blksize;
+	__u32		fa_spare;		/* Alignment */
+	__u64		fa_ino;
+	__u32		fa_dev;
+	__u32		fa_rdev;
+	__s64		fa_size;
+	__s64		fa_blocks;
+	__u64 		fa_padding[4];
+};
+
 /*
  * NFS stats. The good thing with these values is that NFSv3 errors are
  * a superset of NFSv2 errors (with the exception of NFSERR_WFLUSH which
-- 
2.33.1

