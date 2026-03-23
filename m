Return-Path: <linux-nfs+bounces-20319-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMKBM9TmwGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20319-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:08:04 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 756232ED490
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C808F3004DD0
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95635BDC7;
	Mon, 23 Mar 2026 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c1whoNeW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6904929D26E;
	Mon, 23 Mar 2026 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249681; cv=none; b=YrXbJetdmPGIXJaLGq37DWgBzsA5p2PT7WOC9PGVfOXckKjXgCj/P+2xMmfUY9oGOGb4cvlXAL5xpf4D6gd2AxqUYyqPqs6J9R/ZUJlxCluIEULY3acQF2JRuZxENQrusvRRtaBKnAjqVPo8R9P/89h/f9du69KAA3MWFHp7mtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249681; c=relaxed/simple;
	bh=Bni+bZOu3HAbuzlxBOe2r2Hyk0p4alr/L5/hUjQ19sE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeCWz7zWTSARwAphZcBwOBBnl+LfjP4B71C9cGBtFH0wQODnnzeM/GH6pkjejnyO7+WFh7qxvKvoz3dLS7XhWf2uyISuevMC81xjJ76lnyzZVArI6zlUnoRdmfHvP0ZmVFwzVjz1n9a0g6JO4u0OxJtIuPoBVGhTtpM0hFusdP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c1whoNeW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=nH7dHutnSS0pA3lIyNuawQ4wrQ5J+w6YTHYXc99Cav4=; b=c1whoNeWBu0hMYDq+QjWLuxFDW
	PCNZ0ZQ8oEuRgLIvccTFZfbEnomrv9Yin+PxSpNm2Wti1CPJwh3HdMdbwSr/JbRwm0Ep4jZ7bb0KZ
	X4iYI0UR54Y/XNAyC73dQFTt9/h+aBHwo5+LJ5mzWbg75Q9/NC75oevUzzpYezp5hyW1K+PhgDe0U
	Lrv9VQxdUtwQNvf/8UeFkcI2P2CHabSrps4p2NPxncv3aZIWR3CY80ANIyUajb680tx3WJkEO/q65
	mkAZb1h0m58ZQ6UAUw6GFMMB6i5S/M4gq1EnZp1TIS6RCxUyZ3cwBe8RlEp/ICZzFfnLF4xzqcBpc
	Tz70boJw==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOI-0000000GALs-0Nhi;
	Mon, 23 Mar 2026 07:07:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] exportfs: split out the ops for layout-based block device access
Date: Mon, 23 Mar 2026 08:07:17 +0100
Message-ID: <20260323070746.2940140-2-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070746.2940140-1-hch@lst.de>
References: <20260323070746.2940140-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20319-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 756232ED490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The support to grant layouts for direct block device access works
at a very different layer than the rest of exports.  Split the methods
for it into a separate struct, and move that into a separate header
to better split things out.  The pointer to the new operation vector
is kept in export_operations to avoid bloating the super_block.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS                    |  2 +-
 fs/nfsd/blocklayout.c          | 14 ++++++------
 fs/nfsd/nfs4layouts.c          |  9 ++++----
 fs/xfs/xfs_export.c            |  4 +---
 fs/xfs/xfs_pnfs.c              | 12 ++++++++---
 fs/xfs/xfs_pnfs.h              | 11 +++++-----
 include/linux/exportfs.h       | 25 +++++++---------------
 include/linux/exportfs_block.h | 39 ++++++++++++++++++++++++++++++++++
 8 files changed, 74 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/exportfs_block.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7d10988cbc62..c93a3c336553 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9845,7 +9845,7 @@ S:	Supported
 F:	Documentation/filesystems/nfs/exporting.rst
 F:	fs/exportfs/
 F:	fs/fhandle.c
-F:	include/linux/exportfs.h
+F:	include/linux/exportfs*.h
 
 FILESYSTEMS [IDMAPPED MOUNTS]
 M:	Christian Brauner <brauner@kernel.org>
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index a7cfba29990e..7464e9e37af1 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2014-2016 Christoph Hellwig.
  */
-#include <linux/exportfs.h>
+#include <linux/exportfs_block.h>
 #include <linux/iomap.h>
 #include <linux/slab.h>
 #include <linux/pr.h>
@@ -32,8 +32,8 @@ nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
 	u32 device_generation = 0;
 	int error;
 
-	error = sb->s_export_op->map_blocks(inode, offset, length, &iomap,
-			iomode != IOMODE_READ, &device_generation);
+	error = sb->s_export_op->block_ops->map_blocks(inode, offset, length,
+			&iomap, iomode != IOMODE_READ, &device_generation);
 	if (error) {
 		if (error == -ENXIO)
 			return nfserr_layoutunavailable;
@@ -194,8 +194,8 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		iattr.ia_size = lcp->lc_newsize;
 	}
 
-	error = inode->i_sb->s_export_op->commit_blocks(inode, iomaps,
-			nr_iomaps, &iattr);
+	error = inode->i_sb->s_export_op->block_ops->commit_blocks(inode,
+			iomaps, nr_iomaps, &iattr);
 	kfree(iomaps);
 	return nfserrno(error);
 }
@@ -218,8 +218,8 @@ nfsd4_block_get_device_info_simple(struct super_block *sb,
 
 	b->type = PNFS_BLOCK_VOLUME_SIMPLE;
 	b->simple.sig_len = PNFS_BLOCK_UUID_LEN;
-	return sb->s_export_op->get_uuid(sb, b->simple.sig, &b->simple.sig_len,
-			&b->simple.offset);
+	return sb->s_export_op->block_ops->get_uuid(sb, b->simple.sig,
+			&b->simple.sig_len, &b->simple.offset);
 }
 
 static __be32
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index ad7af8cfcf1f..616984fe3873 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2014 Christoph Hellwig.
  */
 #include <linux/blkdev.h>
+#include <linux/exportfs_block.h>
 #include <linux/kmod.h>
 #include <linux/file.h>
 #include <linux/jhash.h>
@@ -127,6 +128,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 {
 #if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
+	struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
 #endif
 
 	if (!(exp->ex_flags & NFSEXP_PNFS))
@@ -136,14 +138,11 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
 #endif
 #ifdef CONFIG_NFSD_BLOCKLAYOUT
-	if (sb->s_export_op->get_uuid &&
-	    sb->s_export_op->map_blocks &&
-	    sb->s_export_op->commit_blocks)
+	if (bops->get_uuid && bops->map_blocks && bops->commit_blocks)
 		exp->ex_layout_types |= 1 << LAYOUT_BLOCK_VOLUME;
 #endif
 #ifdef CONFIG_NFSD_SCSILAYOUT
-	if (sb->s_export_op->map_blocks &&
-	    sb->s_export_op->commit_blocks &&
+	if (bops->map_blocks && bops->commit_blocks &&
 	    sb->s_bdev &&
 	    sb->s_bdev->bd_disk->fops->pr_ops &&
 	    sb->s_bdev->bd_disk->fops->get_unique_id)
diff --git a/fs/xfs/xfs_export.c b/fs/xfs/xfs_export.c
index e3e3c3c89840..9b2ad3786b19 100644
--- a/fs/xfs/xfs_export.c
+++ b/fs/xfs/xfs_export.c
@@ -244,8 +244,6 @@ const struct export_operations xfs_export_operations = {
 	.get_parent		= xfs_fs_get_parent,
 	.commit_metadata	= xfs_fs_nfs_commit_metadata,
 #ifdef CONFIG_EXPORTFS_BLOCK_OPS
-	.get_uuid		= xfs_fs_get_uuid,
-	.map_blocks		= xfs_fs_map_blocks,
-	.commit_blocks		= xfs_fs_commit_blocks,
+	.block_ops		= &xfs_export_block_ops,
 #endif
 };
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 221e55887a2a..a52978f6fb76 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -49,7 +49,7 @@ xfs_break_leased_layouts(
  * Get a unique ID including its location so that the client can identify
  * the exported device.
  */
-int
+static int
 xfs_fs_get_uuid(
 	struct super_block	*sb,
 	u8			*buf,
@@ -104,7 +104,7 @@ xfs_fs_map_update_inode(
 /*
  * Get a layout for the pNFS client.
  */
-int
+static int
 xfs_fs_map_blocks(
 	struct inode		*inode,
 	loff_t			offset,
@@ -252,7 +252,7 @@ xfs_pnfs_validate_isize(
  * to manually flush the cache here similar to what the fsync code path does
  * for datasyncs on files that have no dirty metadata.
  */
-int
+static int
 xfs_fs_commit_blocks(
 	struct inode		*inode,
 	struct iomap		*maps,
@@ -332,3 +332,9 @@ xfs_fs_commit_blocks(
 	xfs_iunlock(ip, XFS_IOLOCK_EXCL);
 	return error;
 }
+
+struct exportfs_block_ops xfs_export_block_ops = {
+	.get_uuid		= xfs_fs_get_uuid,
+	.map_blocks		= xfs_fs_map_blocks,
+	.commit_blocks		= xfs_fs_commit_blocks,
+};
diff --git a/fs/xfs/xfs_pnfs.h b/fs/xfs/xfs_pnfs.h
index 940c6c2ad88c..9c289e98f2a6 100644
--- a/fs/xfs/xfs_pnfs.h
+++ b/fs/xfs/xfs_pnfs.h
@@ -2,13 +2,9 @@
 #ifndef _XFS_PNFS_H
 #define _XFS_PNFS_H 1
 
-#ifdef CONFIG_EXPORTFS_BLOCK_OPS
-int xfs_fs_get_uuid(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
-int xfs_fs_map_blocks(struct inode *inode, loff_t offset, u64 length,
-		struct iomap *iomap, bool write, u32 *device_generation);
-int xfs_fs_commit_blocks(struct inode *inode, struct iomap *maps, int nr_maps,
-		struct iattr *iattr);
+#include <linux/exportfs_block.h>
 
+#ifdef CONFIG_EXPORTFS_BLOCK_OPS
 int xfs_break_leased_layouts(struct inode *inode, uint *iolock,
 		bool *did_unlock);
 #else
@@ -18,4 +14,7 @@ xfs_break_leased_layouts(struct inode *inode, uint *iolock, bool *did_unlock)
 	return 0;
 }
 #endif /* CONFIG_EXPORTFS_BLOCK_OPS */
+
+extern struct exportfs_block_ops xfs_export_block_ops;
+
 #endif /* _XFS_PNFS_H */
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 8bcdba28b406..f07ce833fba3 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -6,9 +6,8 @@
 #include <linux/path.h>
 
 struct dentry;
-struct iattr;
+struct exportfs_block_ops;
 struct inode;
-struct iomap;
 struct super_block;
 struct vfsmount;
 
@@ -260,19 +259,13 @@ struct handle_to_path_ctx {
  * @commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
- * @get_uuid:
- *    Get a filesystem unique signature exposed to clients.
- *
- * @map_blocks:
- *    Map and, if necessary, allocate blocks for a layout.
- *
- * @commit_blocks:
- *    Commit blocks in a layout once the client is done with them.
- *
  * @flags:
  *    Allows the filesystem to communicate to nfsd that it may want to do things
  *    differently when dealing with it.
  *
+ * @block_ops:
+ *    Operations for layout grants to block on the underlying device.
+ *
  * Locking rules:
  *    get_parent is called with child->d_inode->i_rwsem down
  *    get_name is not (which is possibly inconsistent)
@@ -290,12 +283,6 @@ struct export_operations {
 	struct dentry * (*get_parent)(struct dentry *child);
 	int (*commit_metadata)(struct inode *inode);
 
-	int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
-	int (*map_blocks)(struct inode *inode, loff_t offset,
-			  u64 len, struct iomap *iomap,
-			  bool write, u32 *device_generation);
-	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
-			     int nr_iomaps, struct iattr *iattr);
 	int (*permission)(struct handle_to_path_ctx *ctx, unsigned int oflags);
 	struct file * (*open)(const struct path *path, unsigned int oflags);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
@@ -308,6 +295,10 @@ struct export_operations {
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
 	unsigned long	flags;
+
+#ifdef CONFIG_EXPORTFS_BLOCK_OPS
+	struct exportfs_block_ops *block_ops;
+#endif
 };
 
 /**
diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
new file mode 100644
index 000000000000..1f52fea8e4dc
--- /dev/null
+++ b/include/linux/exportfs_block.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2014-2026 Christoph Hellwig.
+ *
+ * Support for exportfs-based layout grants for direct block device access.
+ */
+#ifndef LINUX_EXPORTFS_BLOCK_H
+#define LINUX_EXPORTFS_BLOCK_H 1
+
+#include <linux/types.h>
+
+struct iattr;
+struct inode;
+struct iomap;
+struct super_block;
+
+struct exportfs_block_ops {
+	/*
+	 * Get the in-band device unique signature exposed to clients.
+	 */
+	int (*get_uuid)(struct super_block *sb, u8 *buf, u32 *len, u64 *offset);
+
+	/*
+	 * Map blocks for direct block access.
+	 * If @write is %true, also allocate the blocks for the range if needed.
+	 */
+	int (*map_blocks)(struct inode *inode, loff_t offset, u64 len,
+			struct iomap *iomap, bool write,
+			u32 *device_generation);
+
+	/*
+	 * Commit blocks previously handed out by ->map_blocks and written to by
+	 * the client.
+	 */
+	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
+			int nr_iomaps, struct iattr *iattr);
+};
+
+#endif /* LINUX_EXPORTFS_BLOCK_H */
-- 
2.47.3


