Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5ED2C907C
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 23:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgK3WEH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 17:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgK3WEG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Nov 2020 17:04:06 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CAC0613D4
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:25 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id f15so9428654qto.13
        for <linux-nfs@vger.kernel.org>; Mon, 30 Nov 2020 14:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0JyMZfz8+0avmOEl//mrmV9tvJT2r5yGvgT6Yrbnb9Y=;
        b=DPKWHuikL0Iu2Xm7JeT1Zlxb3pBp2Vcxt7Z5zq+1aV9CmPBE3y9g1co/gPf+2sIJ+r
         h6KGSKVlU2SBcy0FDlehdiAxr32bvo9uVuIZwsyJEMS0CX4QuN4oz2yR0Z4mLJ8M6pF2
         BrB+N9sqB0nStuPvQ7ic2EzYdUeux8+L+439FnDH/hw5j+eTQnSbF0FQ+VdmEhlmEjUI
         +2azzZWWDPc3lyM3nayBxVo9b4FibnxXI3STukH1B4tDLBHSkBrGdPQHhkb29Zv9twi+
         gJMWbCQLnElOg5hkmiHrhI7nowDVXznTm0PXyyye+8TBwom7ljQzZD288khXK4u99Z3F
         bD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0JyMZfz8+0avmOEl//mrmV9tvJT2r5yGvgT6Yrbnb9Y=;
        b=srAiu1VlwMKMsTHssP3dyxBxLAPa5q4/oLcUF2QKhUaRbw1fv9I/os56COSXwM8cO9
         DT+wx42JyiSeKiflQ4o5ILxlOQwbwO0b6iIJcTtEnn9nkzNZPpoexpODbeOYxJCpX9CV
         DQHOL7bGnHiGOBQwfqP3PT1ay0dsrF9EzEqzJQzpr/cAUeQqZmE1TM1QOjY6UWrFlOBO
         ncSMBTdqok25a+Q8v53VHpcmf1s3jj3H/jPPZ01w3FgjNjgBHWtrbW0cWgAADs8yY2VW
         4EqfYBc55QHof9N9ryYxLCWcs8wCThSO5bKI3wgFhiwtiKNulwC0YOz7K5ivzfBdamPu
         sC5w==
X-Gm-Message-State: AOAM532jMu7Jg27gkD/4aIYg6G1f5XRJH0x1UR6XKvqNlp5gTYpSq1pN
        dghZDIb/X9NpsoOyszrD4w==
X-Google-Smtp-Source: ABdhPJy0TYnXN4CUocWihYR37QjkpoiE4uZ83PFQpqLMpe2ek+U1fQyK7tSGL/OFM6ptv5UaDnUZOg==
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr24348237qtw.233.1606773804986;
        Mon, 30 Nov 2020 14:03:24 -0800 (PST)
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id q62sm17642886qkf.86.2020.11.30.14.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:03:24 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/6] nfsd: close cached files prior to a REMOVE or RENAME that would replace target
Date:   Mon, 30 Nov 2020 17:03:16 -0500
Message-Id: <20201130220319.501064-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130220319.501064-3-trond.myklebust@hammerspace.com>
References: <20201130220319.501064-1-trond.myklebust@hammerspace.com>
 <20201130220319.501064-2-trond.myklebust@hammerspace.com>
 <20201130220319.501064-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

It's not uncommon for some workloads to do a bunch of I/O to a file and
delete it just afterward. If knfsd has a cached open file however, then
the file may still be open when the dentry is unlinked. If the
underlying filesystem is nfs, then that could trigger it to do a
sillyrename.

On a REMOVE or RENAME scan the nfsd_file cache for open files that
correspond to the inode, and proactively unhash and put their
references. This should prevent any delete-on-last-close activity from
occurring, solely due to knfsd's open file cache.

This must be done synchronously though so we use the variants that call
flush_delayed_fput. There are deadlock possibilities if you call
flush_delayed_fput while holding locks, however. In the case of
nfsd_rename, we don't even do the lookups of the dentries to be renamed
until we've locked for rename.

Once we've figured out what the target dentry is for a rename, check to
see whether there are cached open files associated with it. If there
are, then unwind all of the locking, close them all, and then reattempt
the rename.

None of this is really necessary for "typical" filesystems though. It's
mostly of use for NFS, so declare a new export op flag and use that to
determine whether to close the files beforehand.

Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 Documentation/filesystems/nfs/exporting.rst | 13 +++++++++++++
 fs/nfs/export.c                             |  2 +-
 fs/nfsd/vfs.c                               | 16 +++++++++-------
 include/linux/exportfs.h                    |  5 +++--
 4 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 960be64446cb..0e98edd353b5 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -202,3 +202,16 @@ following flags are defined:
     This flag exempts the filesystem from subtree checking and causes
     exportfs to get back an error if it tries to enable subtree checking
     on it.
+
+  EXPORT_OP_CLOSE_BEFORE_UNLINK - always close cached files before unlinking
+    On some exportable filesystems (such as NFS) unlinking a file that
+    is still open can cause a fair bit of extra work. For instance,
+    the NFS client will do a "sillyrename" to ensure that the file
+    sticks around while it's still open. When reexporting, that open
+    file is held by nfsd so we usually end up doing a sillyrename, and
+    then immediately deleting the sillyrenamed file just afterward when
+    the link count actually goes to zero. Sometimes this delete can race
+    with other operations (for instance an rmdir of the parent directory).
+    This flag causes nfsd to close any open files for this inode _before_
+    calling into the vfs to do an unlink or a rename that would replace
+    an existing file.
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index b9ba306bf912..5428713af5fe 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -171,5 +171,5 @@ const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
-	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK,
+	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|EXPORT_OP_CLOSE_BEFORE_UNLINK,
 };
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 1ecaceebee13..79cba942087e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1724,7 +1724,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	struct inode	*fdir, *tdir;
 	__be32		err;
 	int		host_err;
-	bool		has_cached = false;
+	bool		close_cached = false;
 
 	err = fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
 	if (err)
@@ -1783,8 +1783,9 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
 		goto out_dput_new;
 
-	if (nfsd_has_cached_files(ndentry)) {
-		has_cached = true;
+	if ((ndentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK) &&
+	    nfsd_has_cached_files(ndentry)) {
+		close_cached = true;
 		goto out_dput_old;
 	} else {
 		host_err = vfs_rename(fdir, odentry, tdir, ndentry, NULL, 0);
@@ -1805,7 +1806,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * as that would do the wrong thing if the two directories
 	 * were the same, so again we do it by hand.
 	 */
-	if (!has_cached) {
+	if (!close_cached) {
 		fill_post_wcc(ffhp);
 		fill_post_wcc(tfhp);
 	}
@@ -1819,8 +1820,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	 * shouldn't be done with locks held however, so we delay it until this
 	 * point and then reattempt the whole shebang.
 	 */
-	if (has_cached) {
-		has_cached = false;
+	if (close_cached) {
+		close_cached = false;
 		nfsd_close_cached_files(ndentry);
 		dput(ndentry);
 		goto retry;
@@ -1872,7 +1873,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
 		type = d_inode(rdentry)->i_mode & S_IFMT;
 
 	if (type != S_IFDIR) {
-		nfsd_close_cached_files(rdentry);
+		if (rdentry->d_sb->s_export_op->flags & EXPORT_OP_CLOSE_BEFORE_UNLINK)
+			nfsd_close_cached_files(rdentry);
 		host_err = vfs_unlink(dirp, rdentry, NULL);
 	} else {
 		host_err = vfs_rmdir(dirp, rdentry);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 2fcbab0f6b61..d829403ffd3b 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -213,8 +213,9 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
-#define	EXPORT_OP_NOWCC		(0x1)	/* Don't collect wcc data for NFSv3 replies */
-#define	EXPORT_OP_NOSUBTREECHK	(0x2)	/* Subtree checking is not supported! */
+#define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
+#define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
+#define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
 	unsigned long	flags;
 };
 
-- 
2.28.0

