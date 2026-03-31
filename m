Return-Path: <linux-nfs+bounces-20545-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI9fFAnsy2l6MgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20545-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:45:13 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADA36C00D
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB96932588C7
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245C41C2FF;
	Tue, 31 Mar 2026 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fITyuDoU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082F41B34F;
	Tue, 31 Mar 2026 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971274; cv=none; b=TYfDuX7d9H0h+l80q26Xk1Gug8Yo+X7fA4ty0XrbTvnlYxSs//v/DYyAyFD3S1u6mtBAqAgV347ajswpIGTqG+l23AzmAaWkAroLxq3CJT003PluxF+ppU7U5m8PHiO0srUhXw3nj/XW3c+KHGczDMlFjbBFpCiJvROCaqGhnzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971274; c=relaxed/simple;
	bh=JLmbOZm7q3nkRMde8NCAZCg99xAzdO659HXsQEZ96NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edYsHnSUWmr4dqj7OUfyIZhhNgGfYZeZbXr0b9Myekp6IwWjTfYS1MU2pr9MfAEl4gNeBGw6BwufmUs00Gf5X2suIYE7UjIGMh6Ard+AgJxpbkhxs37ZbScETIWXXZuTFyzTOqp6YaVW2u9adA653zDheDe/t/oLH3pa0jVHzo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fITyuDoU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZG5cZw6LB0LYb6FZomW1We7eulTljILw3pR2izBYQm8=; b=fITyuDoUibtQI6F0I4f96CUX9g
	y1VgJGIkZdTAfqYs8CukMEz9jCTsxaUxfQgH3GXbXSJf7pLa3hOE+yS48bsS6Twb8LcI590dwVkyB
	cLmGf7DdwZ9FWLAQvt9sH+TOw6sFzc/90toL+wuYnq+WaeuLHKu+grzPgkcG4mya1gK1sNC7DyTc2
	v8srB/8+aiWuQDH1ns31Ncg8us3Zd7IrYBUDwcgnN3HsBajMG8iPqHb/ORRhWG80CGEVhgSq1W0A2
	joZrKzHHt5QctH2eMTbP31Zt4Unses0eM0B3cwJQihjdqb8TGR7imugWtjNj1sfzbO0OCAnbx/di5
	KEUmILSQ==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7b6m-0000000DBsE-2zmO;
	Tue, 31 Mar 2026 15:34:25 +0000
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
Date: Tue, 31 Mar 2026 17:33:29 +0200
Message-ID: <20260331153406.4049290-5-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331153406.4049290-1-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20545-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: E1ADA36C00D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently NFSD hard codes checking support for block-style layouts.
Lift the checks into a file system-helper and provide a exportfs-level
helper to implement the typical checks.

This prepares for supporting block layout export of multiple devices
per file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index c53eb67969eb..7b849b637b5e 100644
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
-	struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
-#endif
-
-	if (!(exp->ex_flags & NFSEXP_PNFS))
-		return;
+	expfs_block_layouts_t block_supported = exporfs_layouts_supported(sb);
 
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
index fee782a3edbe..acefa0b99f53 100644
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
 
 struct exportfs_block_ops xfs_export_block_ops = {
+	.layouts_supported	= xfs_fs_layouts_supported,
 	.get_uuid		= xfs_fs_get_uuid,
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
index d1dec4689b14..8d5b0b0c5a82 100644
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
+exporfs_layouts_supported(struct super_block *sb)
+{
+	struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
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
+exporfs_layouts_supported(struct super_block *sb)
+{
+	return 0;
+}
+#endif /* CONFIG_EXPORTFS_BLOCK_OPS */
+
 #endif /* LINUX_EXPORTFS_BLOCK_H */
-- 
2.47.3


