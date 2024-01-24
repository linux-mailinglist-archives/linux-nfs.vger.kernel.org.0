Return-Path: <linux-nfs+bounces-1305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5E83AA8E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 14:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4AF29221A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jan 2024 13:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9D677646;
	Wed, 24 Jan 2024 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vF9Ge5f1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48601C33;
	Wed, 24 Jan 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101265; cv=none; b=s8Eo5LaT3+ZIQPHerWQdNNwERnO2duzS2FO3eJz4tSJv7Mg4C3NGJpCB6WBgADXsFf/3LyKeoSjlPP0z7EGG9PxZ+SIFGUEYgGq5xBZKP8FokvxFDcN+a8u1kpWypjaJXRNKQT4if5Ih3wGv/WtQMozi47dRB1WO2CvwFdpTb48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101265; c=relaxed/simple;
	bh=CaWBk8W57U1J2tKr/2lfxmwlgUWi6Z7kOVUq7Ob3Osg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJeLnPdxU0LDlvlFXfotEHTAmVe8lW5PY/G/MnX58ivSpNfQZt8Rie+sZreYP0oFYCWZd04KGFXjts/qFJrc1s0eQ00RqyDxLJVtc5fb6liCLoIUoPTt+iEAszZoDPLXRYOYup5s2sjfGhDZ6qbVgBUVSzpGCcIl6fbNL/0RdlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=vF9Ge5f1; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706101263; x=1737637263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EyfEbuE2m3W3td1FX1vnkdULktPLmvgov4r/SOas2DM=;
  b=vF9Ge5f16VykeAVaFYm/TFGsq6skEUMknvVge6t+r+HZzJw7MPf50tsZ
   Hi38kx+yAnY3LNDUq2GymH2ZTWX9s40MU733OkQQxGYqogUoFEvUcuj3a
   r3qdHby6K2n+euwDujSi3aLJIgtx+tSpNdskBY2yvIenOWD3djL9sWwS2
   A=;
X-IronPort-AV: E=Sophos;i="6.05,216,1701129600"; 
   d="scan'208";a="376507030"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 13:00:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id CCFE84A256;
	Wed, 24 Jan 2024 13:00:54 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29753]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.57:2525] with esmtp (Farcaster)
 id 2c1c4b45-4d43-48c9-8a9a-9ac46e67b68f; Wed, 24 Jan 2024 13:00:54 +0000 (UTC)
X-Farcaster-Flow-ID: 2c1c4b45-4d43-48c9-8a9a-9ac46e67b68f
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.174) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 24 Jan 2024 13:00:52 +0000
Received: from dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (10.15.1.225)
 by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Wed, 24 Jan 2024 13:00:52 +0000
Received: by dev-dsk-mngyadam-1c-a2602c62.eu-west-1.amazon.com (Postfix, from userid 23907357)
	id 138952D62; Wed, 24 Jan 2024 14:00:52 +0100 (CET)
From: Mahmoud Adam <mngyadam@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <viro@zeniv.linux.org.uk>, <xuyang2018.jy@fujitsu.com>,
	<stable@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<--suppress-cc=body@amazon.com>, Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong"
	<djwong@kernel.org>, Jeff Layton <jlayton@kernel.org>, Amir Goldstein
	<amir73il@gmail.com>, Mahmoud Adam <mngyadam@amazon.com>
Subject: [PATCH 2/2] fs: move S_ISGID stripping into the vfs_*() helpers
Date: Wed, 24 Jan 2024 14:00:26 +0100
Message-ID: <20240124130025.2292-3-mngyadam@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240124130025.2292-1-mngyadam@amazon.com>
References: <20240124130025.2292-1-mngyadam@amazon.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Yang Xu <xuyang2018.jy@fujitsu.com>

commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b upstream.

[remove userns argument of helpers for 5.4.y backport]

Move setgid handling out of individual filesystems and into the VFS
itself to stop the proliferation of setgid inheritance bugs.

Creating files that have both the S_IXGRP and S_ISGID bit raised in
directories that themselves have the S_ISGID bit set requires additional
privileges to avoid security issues.

When a filesystem creates a new inode it needs to take care that the
caller is either in the group of the newly created inode or they have
CAP_FSETID in their current user namespace and are privileged over the
parent directory of the new inode. If any of these two conditions is
true then the S_ISGID bit can be raised for an S_IXGRP file and if not
it needs to be stripped.

However, there are several key issues with the current implementation:

* S_ISGID stripping logic is entangled with umask stripping.

  If a filesystem doesn't support or enable POSIX ACLs then umask
  stripping is done directly in the vfs before calling into the
  filesystem.
  If the filesystem does support POSIX ACLs then unmask stripping may be
  done in the filesystem itself when calling posix_acl_create().

  Since umask stripping has an effect on S_ISGID inheritance, e.g., by
  stripping the S_IXGRP bit from the file to be created and all relevant
  filesystems have to call posix_acl_create() before inode_init_owner()
  where we currently take care of S_ISGID handling S_ISGID handling is
  order dependent. IOW, whether or not you get a setgid bit depends on
  POSIX ACLs and umask and in what order they are called.

  Note that technically filesystems are free to impose their own
  ordering between posix_acl_create() and inode_init_owner() meaning
  that there's additional ordering issues that influence S_SIGID
  inheritance.

* Filesystems that don't rely on inode_init_owner() don't get S_ISGID
  stripping logic.

  While that may be intentional (e.g. network filesystems might just
  defer setgid stripping to a server) it is often just a security issue.

This is not just ugly it's unsustainably messy especially since we do
still have bugs in this area years after the initial round of setgid
bugfixes.

So the current state is quite messy and while we won't be able to make
it completely clean as posix_acl_create() is still a filesystem specific
call we can improve the S_SIGD stripping situation quite a bit by
hoisting it out of inode_init_owner() and into the vfs creation
operations. This means we alleviate the burden for filesystems to handle
S_ISGID stripping correctly and can standardize the ordering between
S_ISGID and umask stripping in the vfs.

We add a new helper vfs_prepare_mode() so S_ISGID handling is now done
in the VFS before umask handling. This has S_ISGID handling is
unaffected unaffected by whether umask stripping is done by the VFS
itself (if no POSIX ACLs are supported or enabled) or in the filesystem
in posix_acl_create() (if POSIX ACLs are supported).

The vfs_prepare_mode() helper is called directly in vfs_*() helpers that
create new filesystem objects. We need to move them into there to make
sure that filesystems like overlayfs hat have callchains like:

sys_mknod()
-> do_mknodat(mode)
   -> .mknod = ovl_mknod(mode)
      -> ovl_create(mode)
         -> vfs_mknod(mode)

get S_ISGID stripping done when calling into lower filesystems via
vfs_*() creation helpers. Moving vfs_prepare_mode() into e.g.
vfs_mknod() takes care of that. This is in any case semantically cleaner
because S_ISGID stripping is VFS security requirement.

Security hooks so far have seen the mode with the umask applied but
without S_ISGID handling done. The relevant hooks are called outside of
vfs_*() creation helpers so by calling vfs_prepare_mode() from vfs_*()
helpers the security hooks would now see the mode without umask
stripping applied. For now we fix this by passing the mode with umask
settings applied to not risk any regressions for LSM hooks. IOW, nothing
changes for LSM hooks. It is worth pointing out that security hooks
never saw the mode that is seen by the filesystem when actually creating
the file. They have always been completely misplaced for that to work.

The following filesystems use inode_init_owner() and thus relied on
S_ISGID stripping: spufs, 9p, bfs, btrfs, ext2, ext4, f2fs, hfsplus,
hugetlbfs, jfs, minix, nilfs2, ntfs3, ocfs2, omfs, overlayfs, ramfs,
reiserfs, sysv, ubifs, udf, ufs, xfs, zonefs, bpf, tmpfs.

All of the above filesystems end up calling inode_init_owner() when new
filesystem objects are created through the ->mkdir(), ->mknod(),
->create(), ->tmpfile(), ->rename() inode operations.

Since directories always inherit the S_ISGID bit with the exception of
xfs when irix_sgid_inherit mode is turned on S_ISGID stripping doesn't
apply. The ->symlink() and ->link() inode operations trivially inherit
the mode from the target and the ->rename() inode operation inherits the
mode from the source inode. All other creation inode operations will get
S_ISGID handling via vfs_prepare_mode() when called from their relevant
vfs_*() helpers.

In addition to this there are filesystems which allow the creation of
filesystem objects through ioctl()s or - in the case of spufs -
circumventing the vfs in other ways. If filesystem objects are created
through ioctl()s the vfs doesn't know about it and can't apply regular
permission checking including S_ISGID logic. Therfore, a filesystem
relying on S_ISGID stripping in inode_init_owner() in their ioctl()
callpath will be affected by moving this logic into the vfs. We audited
those filesystems:

* btrfs allows the creation of filesystem objects through various
  ioctls(). Snapshot creation literally takes a snapshot and so the mode
  is fully preserved and S_ISGID stripping doesn't apply.

  Creating a new subvolum relies on inode_init_owner() in
  btrfs_new_subvol_inode() but only creates directories and doesn't
  raise S_ISGID.

* ocfs2 has a peculiar implementation of reflinks. In contrast to e.g.
  xfs and btrfs FICLONE/FICLONERANGE ioctl() that is only concerned with
  the actual extents ocfs2 uses a separate ioctl() that also creates the
  target file.

  Iow, ocfs2 circumvents the vfs entirely here and did indeed rely on
  inode_init_owner() to strip the S_ISGID bit. This is the only place
  where a filesystem needs to call mode_strip_sgid() directly but this
  is self-inflicted pain.

* spufs doesn't go through the vfs at all and doesn't use ioctl()s
  either. Instead it has a dedicated system call spufs_create() which
  allows the creation of filesystem objects. But spufs only creates
  directories and doesn't allo S_SIGID bits, i.e. it specifically only
  allows 0777 bits.

* bpf uses vfs_mkobj() but also doesn't allow S_ISGID bits to be created.

The patch will have an effect on ext2 when the EXT2_MOUNT_GRPID mount
option is used, on ext4 when the EXT4_MOUNT_GRPID mount option is used,
and on xfs when the XFS_FEAT_GRPID mount option is used. When any of
these filesystems are mounted with their respective GRPID option then
newly created files inherit the parent directories group
unconditionally. In these cases non of the filesystems call
inode_init_owner() and thus did never strip the S_ISGID bit for newly
created files. Moving this logic into the VFS means that they now get
the S_ISGID bit stripped. This is a user visible change. If this leads
to regressions we will either need to figure out a better way or we need
to revert. However, given the various setgid bugs that we found just in
the last two years this is a regression risk we should take.

Associated with this change is a new set of fstests to enforce the
semantics for all new filesystems.

Link: https://lore.kernel.org/ceph-devel/20220427092201.wvsdjbnc7b4dttaw@wittgenstein [1]
Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [2]
Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [3]
Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [4]
Link: https://lore.kernel.org/r/1657779088-2242-3-git-send-email-xuyang2018.jy@fujitsu.com
Suggested-by: Dave Chinner <david@fromorbit.com>
Suggested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
[<brauner@kernel.org>: rewrote commit message]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[commit 94ac142c19f1016283a1860b07de7fa555385d31 upstream
	backported from 5.10.y, resolved context conflicts]
Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
---
 fs/inode.c       |  2 --
 fs/namei.c       | 84 +++++++++++++++++++++++++++++++++++++++---------
 fs/ocfs2/namei.c |  1 +
 3 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2995130e0cdc..a6c4c443d45a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2100,8 +2100,6 @@ void inode_init_owner(struct inode *inode, const struct inode *dir,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else
-			mode = mode_strip_sgid(dir, mode);
 	} else
 		inode->i_gid = current_fsgid();
 	inode->i_mode = mode;
diff --git a/fs/namei.c b/fs/namei.c
index f6708ab8ec7e..4ad800c82ac9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -52,8 +52,8 @@
  * The new code replaces the old recursive symlink resolution with
  * an iterative one (in case of non-nested symlink chains).  It does
  * this with calls to <fs>_follow_link().
- * As a side effect, dir_namei(), _namei() and follow_link() are now 
- * replaced with a single function lookup_dentry() that can handle all 
+ * As a side effect, dir_namei(), _namei() and follow_link() are now
+ * replaced with a single function lookup_dentry() that can handle all
  * the special cases of the former code.
  *
  * With the new dcache, the pathname is stored at each inode, at least as
@@ -2906,6 +2906,63 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * mode_strip_umask - handle vfs umask stripping
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode to be created in @dir
+ *
+ * Umask stripping depends on whether or not the filesystem supports POSIX
+ * ACLs. If the filesystem doesn't support it umask stripping is done directly
+ * in here. If the filesystem does support POSIX ACLs umask stripping is
+ * deferred until the filesystem calls posix_acl_create().
+ *
+ * Returns: mode
+ */
+static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
+{
+	if (!IS_POSIXACL(dir))
+		mode &= ~current_umask();
+	return mode;
+}
+
+/**
+ * vfs_prepare_mode - prepare the mode to be used for a new inode
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode
+ * @mask_perms:	allowed permission by the vfs
+ * @type:	type of file to be created
+ *
+ * This helper consolidates and enforces vfs restrictions on the @mode of a new
+ * object to be created.
+ *
+ * Umask stripping depends on whether the filesystem supports POSIX ACLs (see
+ * the kernel documentation for mode_strip_umask()). Moving umask stripping
+ * after setgid stripping allows the same ordering for both non-POSIX ACL and
+ * POSIX ACL supporting filesystems.
+ *
+ * Note that it's currently valid for @type to be 0 if a directory is created.
+ * Filesystems raise that flag individually and we need to check whether each
+ * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
+ * non-zero type.
+ *
+ * Returns: mode to be passed to the filesystem
+ */
+static inline umode_t vfs_prepare_mode(const struct inode *dir, umode_t mode,
+				       umode_t mask_perms, umode_t type)
+{
+	mode = mode_strip_sgid(dir, mode);
+	mode = mode_strip_umask(dir, mode);
+
+	/*
+	 * Apply the vfs mandated allowed permission mask and set the type of
+	 * file to be created before we call into the filesystem.
+	 */
+	mode &= (mask_perms & ~S_IFMT);
+	mode |= (type & S_IFMT);
+
+	return mode;
+}
+
 int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 		bool want_excl)
 {
@@ -2915,8 +2972,8 @@ int vfs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 
 	if (!dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
-	mode &= S_IALLUGO;
-	mode |= S_IFREG;
+
+	mode = vfs_prepare_mode(dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3186,8 +3243,7 @@ static int lookup_open(struct nameidata *nd, struct path *path,
 	 * O_EXCL open we want to return EEXIST not EROFS).
 	 */
 	if (open_flag & O_CREAT) {
-		if (!IS_POSIXACL(dir->d_inode))
-			mode &= ~current_umask();
+		mode = vfs_prepare_mode(dir->d_inode, mode, mode, mode);
 		if (unlikely(!got_write)) {
 			create_error = -EROFS;
 			open_flag &= ~O_CREAT;
@@ -3463,8 +3519,7 @@ struct dentry *vfs_tmpfile(struct dentry *dentry, umode_t mode, int open_flag)
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
-	if (!IS_POSIXACL(dir))
-		mode &= ~current_umask();
+	mode = vfs_prepare_mode(dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3723,6 +3778,7 @@ int vfs_mknod(struct inode *dir, struct dentry *dentry, umode_t mode, dev_t dev)
 	if (!dir->i_op->mknod)
 		return -EPERM;
 
+	mode = vfs_prepare_mode(dir, mode, mode, mode);
 	error = devcgroup_inode_mknod(mode, dev);
 	if (error)
 		return error;
@@ -3771,9 +3827,8 @@ long do_mknodat(int dfd, const char __user *filename, umode_t mode,
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
-	error = security_path_mknod(&path, dentry, mode, dev);
+	error = security_path_mknod(&path, dentry,
+			mode_strip_umask(path.dentry->d_inode, mode), dev);
 	if (error)
 		goto out;
 	switch (mode & S_IFMT) {
@@ -3821,7 +3876,7 @@ int vfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (!dir->i_op->mkdir)
 		return -EPERM;
 
-	mode &= (S_IRWXUGO|S_ISVTX);
+	mode = vfs_prepare_mode(dir, mode, S_IRWXUGO | S_ISVTX, 0);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3848,9 +3903,8 @@ long do_mkdirat(int dfd, const char __user *pathname, umode_t mode)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
-	error = security_path_mkdir(&path, dentry, mode);
+	error = security_path_mkdir(&path, dentry,
+			mode_strip_umask(path.dentry->d_inode, mode));
 	if (!error)
 		error = vfs_mkdir(path.dentry->d_inode, dentry, mode);
 	done_path_create(&path, dentry);
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index cd6a21439826..ba574fade6f0 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -198,6 +198,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	 * callers. */
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
+	mode = mode_strip_sgid(dir, mode);
 	inode_init_owner(inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
-- 
2.40.1


