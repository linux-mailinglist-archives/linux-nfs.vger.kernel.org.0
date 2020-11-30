Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB562C8FFC
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388485AbgK3VZn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:25:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388604AbgK3VZm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 16:25:42 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D7C2084C;
        Mon, 30 Nov 2020 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606771501;
        bh=HufUug6259kNClrNT4VXbOysm6eh56f38WGdc9pBN5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njX6OVIgyvZBAm7ohJckIbtqiDNli6pjR/fYelk1LfkqOZGqu/DCilXNpRiVu2H6B
         VHk2ykv52PKgpVSVxBwHFH1NeoJu1GfNoE+9S8GFN3h3V9SFELk/I2zx8r2Y/HgqqS
         h+Krb0nrabA4aC7TJp9ofkKgemJV2vh2B2fxqudg=
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/6] nfsd: add a new EXPORT_OP_NOWCC flag to struct export_operations
Date:   Mon, 30 Nov 2020 16:24:50 -0500
Message-Id: <20201130212455.254469-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130212455.254469-1-trondmy@kernel.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Jeff Layton <jeff.layton@primarydata.com>

With NFSv3 nfsd will always attempt to send along WCC data to the
client. This generally involves saving off the in-core inode information
prior to doing the operation on the given filehandle, and then issuing a
vfs_getattr to it after the op.

Some filesystems (particularly clustered or networked ones) have an
expensive ->getattr inode operation. Atomicitiy is also often difficult
or impossible to guarantee on such filesystems. For those, we're best
off not trying to provide WCC information to the client at all, and to
simply allow it to poll for that information as needed with a GETATTR
RPC.

This patch adds a new flags field to struct export_operations, and
defines a new EXPORT_OP_NOWCC flag that filesystems can use to indicate
that nfsd should not attempt to provide WCC info in NFSv3 replies. It
also adds a blurb about the new flags field and flag to the exporting
documentation.

The server will also now skip collecting this information for NFSv2 as
well, since that info is never used there anyway.

Note that this patch does not add this flag to any filesystem
export_operations structures. This was originally developed to allow
reexporting nfs via nfsd. That code is not (and may never be) suitable
for merging into mainline.

Other filesystems may want to consider enabling this flag too. It's hard
to tell however which ones have export operations to enable export via
knfsd and which ones mostly rely on them for open-by-filehandle support,
so I'm leaving that up to the individual maintainers to decide. I am
cc'ing the relevant lists for those filesystems that I think may want to
consider adding this though.

Cc: HPDD-discuss@lists.01.org
Cc: ceph-devel@vger.kernel.org
Cc: cluster-devel@redhat.com
Cc: fuse-devel@lists.sourceforge.net
Cc: ocfs2-devel@oss.oracle.com
Signed-off-by: Jeff Layton <jeff.layton@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 Documentation/filesystems/nfs/exporting.rst | 27 +++++++++++++++++++++
 fs/nfs/export.c                             |  1 +
 fs/nfsd/nfs3xdr.c                           |  7 ++++--
 fs/nfsd/nfsfh.c                             | 14 +++++++++++
 fs/nfsd/nfsfh.h                             |  2 +-
 include/linux/exportfs.h                    |  2 ++
 6 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/nfs/exporting.rst b/Documentation/filesystems/nfs/exporting.rst
index 33d588a01ace..a3e3805833d1 100644
--- a/Documentation/filesystems/nfs/exporting.rst
+++ b/Documentation/filesystems/nfs/exporting.rst
@@ -154,6 +154,11 @@ struct which has the following members:
     to find potential names, and matches inode numbers to find the correct
     match.
 
+  flags
+    Some filesystems may need to be handled differently than others. The
+    export_operations struct also includes a flags field that allows the
+    filesystem to communicate such information to nfsd. See the Export
+    Operations Flags section below for more explanation.
 
 A filehandle fragment consists of an array of 1 or more 4byte words,
 together with a one byte "type".
@@ -163,3 +168,25 @@ generated by encode_fh, in which case it will have been padded with
 nuls.  Rather, the encode_fh routine should choose a "type" which
 indicates the decode_fh how much of the filehandle is valid, and how
 it should be interpreted.
+
+Export Operations Flags
+-----------------------
+In addition to the operation vector pointers, struct export_operations also
+contains a "flags" field that allows the filesystem to communicate to nfsd
+that it may want to do things differently when dealing with it. The
+following flags are defined:
+
+  EXPORT_OP_NOWCC
+    RFC 1813 recommends that servers always send weak cache consistency
+    (WCC) data to the client after each operation. The server should
+    atomically collect attributes about the inode, do an operation on it,
+    and then collect the attributes afterward. This allows the client to
+    skip issuing GETATTRs in some situations but means that the server
+    is calling vfs_getattr for almost all RPCs. On some filesystems
+    (particularly those that are clustered or networked) this is expensive
+    and atomicity is difficult to guarantee. This flag indicates to nfsd
+    that it should skip providing WCC attributes to the client in NFSv3
+    replies when doing operations on this filesystem. Consider enabling
+    this on filesystems that have an expensive ->getattr inode operation,
+    or when atomicity between pre and post operation attribute collection
+    is impossible to guarantee.
diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 3430d6891e89..8f4c528865c5 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -171,4 +171,5 @@ const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
+	.flags = EXPORT_OP_NOWCC,
 };
diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
index 2277f83da250..480342675292 100644
--- a/fs/nfsd/nfs3xdr.c
+++ b/fs/nfsd/nfs3xdr.c
@@ -206,7 +206,7 @@ static __be32 *
 encode_post_op_attr(struct svc_rqst *rqstp, __be32 *p, struct svc_fh *fhp)
 {
 	struct dentry *dentry = fhp->fh_dentry;
-	if (dentry && d_really_is_positive(dentry)) {
+	if (!fhp->fh_no_wcc && dentry && d_really_is_positive(dentry)) {
 	        __be32 err;
 		struct kstat stat;
 
@@ -261,7 +261,7 @@ void fill_pre_wcc(struct svc_fh *fhp)
 	struct kstat	stat;
 	__be32 err;
 
-	if (fhp->fh_pre_saved)
+	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
 		return;
 
 	inode = d_inode(fhp->fh_dentry);
@@ -287,6 +287,9 @@ void fill_post_wcc(struct svc_fh *fhp)
 {
 	__be32 err;
 
+	if (fhp->fh_no_wcc)
+		return;
+
 	if (fhp->fh_post_saved)
 		printk("nfsd: inode locked twice during operation.\n");
 
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index c81dbbad8792..0c2ee65e46f3 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -291,6 +291,16 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
+
+	switch (rqstp->rq_vers) {
+	case 3:
+		if (!(dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC))
+			break;
+		/* Fallthrough */
+	case 2:
+		fhp->fh_no_wcc = true;
+	}
+
 	return 0;
 out:
 	exp_put(exp);
@@ -559,6 +569,9 @@ fh_compose(struct svc_fh *fhp, struct svc_export *exp, struct dentry *dentry,
 	 */
 	set_version_and_fsid_type(fhp, exp, ref_fh);
 
+	/* If we have a ref_fh, then copy the fh_no_wcc setting from it. */
+	fhp->fh_no_wcc = ref_fh ? ref_fh->fh_no_wcc : false;
+
 	if (ref_fh == fhp)
 		fh_put(ref_fh);
 
@@ -662,6 +675,7 @@ fh_put(struct svc_fh *fhp)
 		exp_put(exp);
 		fhp->fh_export = NULL;
 	}
+	fhp->fh_no_wcc = false;
 	return;
 }
 
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index 56cfbc361561..fb2b60a76b32 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -35,6 +35,7 @@ typedef struct svc_fh {
 
 	bool			fh_locked;	/* inode locked by us */
 	bool			fh_want_write;	/* remount protection taken */
+	bool			fh_no_wcc;	/* no wcc data needed */
 	int			fh_flags;	/* FH flags */
 #ifdef CONFIG_NFSD_V3
 	bool			fh_post_saved;	/* post-op attrs saved */
@@ -54,7 +55,6 @@ typedef struct svc_fh {
 	struct kstat		fh_post_attr;	/* full attrs after operation */
 	u64			fh_post_change; /* nfsv4 change; see above */
 #endif /* CONFIG_NFSD_V3 */
-
 } svc_fh;
 #define NFSD4_FH_FOREIGN (1<<0)
 #define SET_FH_FLAG(c, f) ((c)->fh_flags |= (f))
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 3ceb72b67a7a..e7de0103a32e 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -213,6 +213,8 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
+#define	EXPORT_OP_NOWCC		(0x1)	/* Don't collect wcc data for NFSv3 replies */
+	unsigned long	flags;
 };
 
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
-- 
2.28.0

