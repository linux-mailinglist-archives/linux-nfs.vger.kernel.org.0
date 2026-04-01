Return-Path: <linux-nfs+bounces-20591-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO1zLJAxzWn0agYAu9opvQ
	(envelope-from <linux-nfs+bounces-20591-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 16:54:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2B537C7ED
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 16:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D08314409C
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 14:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACD247A0DC;
	Wed,  1 Apr 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IkvevFpQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FF9472760;
	Wed,  1 Apr 2026 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054487; cv=none; b=kTibMb7DN/ekLKQG9f9DgeIraim9qtcYSyBKlEIMYL8/jQIkzbzXZenmHGhtLYm3jDb5qYhAzDRtCzmXlbkj5umsfsNQIBYw6Iddpx0hvZUGwtGRnnnF+uWDPiEX1Gbmk430qZilwdf8a/sNZhncW08RWi+2QJYlTXCDGke0bEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054487; c=relaxed/simple;
	bh=3PvW3/DdGYazzAtN3FmITxeXGrmv//CP9oTJkFDSG68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hg6VvMR94UyBKA1dTRzsQyd3B4TFMCUgk0nsc4moqOgw54mCsi5OpBb2Il97mDUm3FRmYjAkE9cOqzi8LamDi0xYIo8m0n2wZmLRqkm5YLr8QncBTjknuoT3743u7lhsvveTmbOHM6kJbJLGwNpWFEcOqLUztX4LKvxwvJ+ElQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IkvevFpQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CmPsgFnmfG3ErZo+clK2geXrAbMFOoPy8utupBe+P8A=; b=IkvevFpQcDquh4VAFXgFQ2iEsh
	wN08hJ8XzUKjgWCVClpnZmhYnw9JPyclw2CWqSLtQq9gvMakcEltw4cBISoqCXu5Pxy4etnCCXfmw
	EIji68EzbuGpQ/MTkoaTDoiNnUTM1kYdVoT+x5SHjIRih1zN5911MtVMGO4kxw9ch2fQWWHU+bI6U
	lxpjVAU4c1/N3YhVUmgv4dAMqZdtldZV+8I2xvtse23nCtU2WlgZHjGtC/1yYYzUci6I97ujbGEEf
	ehQ+WlAlqHpBvVI+9ih3idn0KKu4xr1lDi3ogf4DGPqefvt1BtTvEQO9EWmwE5hZjnXa8M2p/E9tt
	dt4oCEUg==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wl0-0000000FWJ0-2cKy;
	Wed, 01 Apr 2026 14:41:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] exportfs,nfsd: rework checking for layout-based block device access support
Date: Wed,  1 Apr 2026 16:40:25 +0200
Message-ID: <20260401144059.160746-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401144059.160746-1-hch@lst.de>
References: <20260401144059.160746-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20591-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2C2B537C7ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently NFSD hard codes checking support for block-style layouts.
Lift the checks into a file system-helper and provide a exportfs-level
helper to implement the typical checks.

This prepares for supporting block layout export of multiple devices
per file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c               |  3 +-
 fs/nfsd/nfs4layouts.c          | 26 +++++------------
 fs/xfs/xfs_pnfs.c              | 13 +++++++++
 include/linux/exportfs_block.h | 52 +++++++++++++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 8e8a76a44ff0..e20298f9212f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -735,7 +735,8 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 			goto out4;
 		err = 0;
 
-		nfsd4_setup_layout_type(&exp);
+		if (exp.ex_flags & NFSEXP_PNFS)
+			nfsd4_setup_layout_type(&exp);
 	}
 
 	expp = svc_export_lookup(&exp);
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 6c1ff21b83a2..0b51eabbafde 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) 2014 Christoph Hellwig.
  */
-#include <linux/blkdev.h>
 #include <linux/exportfs_block.h>
 #include <linux/kmod.h>
 #include <linux/file.h>
@@ -126,28 +125,17 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
-#if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
-	const struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
-#endif
-
-	if (!(exp->ex_flags & NFSEXP_PNFS))
-		return;
+	expfs_block_layouts_t block_supported = exportfs_layouts_supported(sb);
 
-#ifdef CONFIG_NFSD_FLEXFILELAYOUT
-	exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
-#endif
-#ifdef CONFIG_NFSD_BLOCKLAYOUT
-	if (bops && bops->get_uuid && bops->map_blocks && bops->commit_blocks)
+	if (IS_ENABLED(CONFIG_NFSD_FLEXFILELAYOUT))
+		exp->ex_layout_types |= 1 << LAYOUT_FLEX_FILES;
+	if (IS_ENABLED(CONFIG_NFSD_BLOCKLAYOUT) &&
+	    (block_supported & EXPFS_BLOCK_IN_BAND_ID))
 		exp->ex_layout_types |= 1 << LAYOUT_BLOCK_VOLUME;
-#endif
-#ifdef CONFIG_NFSD_SCSILAYOUT
-	if (bops && bops->map_blocks && bops->commit_blocks &&
-	    sb->s_bdev &&
-	    sb->s_bdev->bd_disk->fops->pr_ops &&
-	    sb->s_bdev->bd_disk->fops->get_unique_id)
+	if (IS_ENABLED(CONFIG_NFSD_SCSILAYOUT) &&
+	    (block_supported & EXPFS_BLOCK_OUT_OF_BAND_ID))
 		exp->ex_layout_types |= 1 << LAYOUT_SCSI;
-#endif
 }
 
 void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 7d689bb2efd9..266a07601e8d 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -13,6 +13,7 @@
 #include "xfs_bmap.h"
 #include "xfs_iomap.h"
 #include "xfs_pnfs.h"
+#include <linux/exportfs_block.h>
 
 /*
  * Ensure that we do not have any outstanding pNFS layouts that can be used by
@@ -45,6 +46,17 @@ xfs_break_leased_layouts(
 	return error;
 }
 
+static expfs_block_layouts_t
+xfs_fs_layouts_supported(
+	struct super_block	*sb)
+{
+	expfs_block_layouts_t	supported = EXPFS_BLOCK_IN_BAND_ID;
+
+	if (exportfs_bdev_supports_out_of_band_id(sb->s_bdev))
+		supported |= EXPFS_BLOCK_OUT_OF_BAND_ID;
+	return supported;
+}
+
 /*
  * Get a unique ID including its location so that the client can identify
  * the exported device.
@@ -335,6 +347,7 @@ xfs_fs_commit_blocks(
 }
 
 const struct exportfs_block_ops xfs_export_block_ops = {
+	.layouts_supported	= xfs_fs_layouts_supported,
 	.get_uuid		= xfs_fs_get_uuid,
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
index d1dec4689b14..de519b7b599b 100644
--- a/include/linux/exportfs_block.h
+++ b/include/linux/exportfs_block.h
@@ -7,13 +7,35 @@
 #ifndef LINUX_EXPORTFS_BLOCK_H
 #define LINUX_EXPORTFS_BLOCK_H 1
 
-#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/exportfs.h>
+#include <linux/fs.h>
 
 struct inode;
 struct iomap;
 struct super_block;
 
+/*
+ * There are the two types of block-style layout support:
+ *  - In-band implies a device identified by a unique cookie inside the actual
+ *    device address space checked by the ->get_uuid method as used by the pNFS
+ *    block layout.  This is a bit dangerous and deprecated.
+ *  - Out of band implies identification by out of band unique identifiers
+ *    specified by the storage protocol, which is much safer and used by the
+ *    pNFS SCSI/NVMe layouts.
+ */
+typedef unsigned int __bitwise expfs_block_layouts_t;
+#define EXPFS_BLOCK_FLAG(__bit) \
+	((__force expfs_block_layouts_t)(1u << __bit))
+#define EXPFS_BLOCK_IN_BAND_ID		EXPFS_BLOCK_FLAG(0)
+#define EXPFS_BLOCK_OUT_OF_BAND_ID	EXPFS_BLOCK_FLAG(1)
+
 struct exportfs_block_ops {
+	/*
+	 * Returns the EXPFS_BLOCK_* bitmap of supported layout types.
+	 */
+	expfs_block_layouts_t (*layouts_supported)(struct super_block *sb);
+
 	/*
 	 * Get the in-band device unique signature exposed to clients.
 	 */
@@ -35,4 +57,32 @@ struct exportfs_block_ops {
 			int nr_iomaps, loff_t new_size);
 };
 
+static inline bool
+exportfs_bdev_supports_out_of_band_id(struct block_device *bdev)
+{
+	return bdev->bd_disk->fops->pr_ops &&
+		bdev->bd_disk->fops->get_unique_id;
+}
+
+#ifdef CONFIG_EXPORTFS_BLOCK_OPS
+static inline expfs_block_layouts_t
+exportfs_layouts_supported(struct super_block *sb)
+{
+	const struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
+
+	if (!bops ||
+	    !bops->layouts_supported ||
+	    WARN_ON_ONCE(!bops->map_blocks) ||
+	    WARN_ON_ONCE(!bops->commit_blocks))
+		return 0;
+	return bops->layouts_supported(sb);
+}
+#else
+static inline expfs_block_layouts_t
+exportfs_layouts_supported(struct super_block *sb)
+{
+	return 0;
+}
+#endif /* CONFIG_EXPORTFS_BLOCK_OPS */
+
 #endif /* LINUX_EXPORTFS_BLOCK_H */
-- 
2.47.3


