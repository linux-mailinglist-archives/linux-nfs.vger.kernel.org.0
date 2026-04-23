Return-Path: <linux-nfs+bounces-21063-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODVdOkxi6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21063-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:48 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD8455FF9
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28BC13083FDC
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94E29ACCD;
	Thu, 23 Apr 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxfx5RtK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D823AC0FB
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968112; cv=none; b=IHGRcvipBtc6S0NycYytsITOLS7bsNv8geyx1/INbfqHs1GuW2We0/elDR1zvmjH5nCgs1q2BiFNvrCWwTLvuqLCIcIqVu+fVZpC5QpzHKx2Zw7XZ/y7nvIO+PidXK1DnzVjXbWfBm/eY1wVX/9bhaZzfVcoeNAiTZr7KeKkzvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968112; c=relaxed/simple;
	bh=wVD5F0fySUvqvF+OZHm0B/xE8oyI69cJukcFq0yFKtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1XOi9ZmmtHoFw1Ctp2uyJ8Sl+QLy500huH5HmeHxidKJXEDCigYYhboP9OtQ5uPB/UsfSm+5v9UBMDKXNDQbRZUSweOWy15U0XVBwoqkwLBC9ijZkvAJmhKZFuGmXe9gmeeabtfW9xIy+wAqpkEJPEWbqSC2DWELkT0xm3hwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxfx5RtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCBCC2BCB2;
	Thu, 23 Apr 2026 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968112;
	bh=wVD5F0fySUvqvF+OZHm0B/xE8oyI69cJukcFq0yFKtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxfx5RtKj3n/5+mw0aqi0wDijtOZPW5phtjGaVQNb+l5n7pkzeWCCVvkgBf/KDEIX
	 eHyJZyRXwXHlEmAmoRUM4loMYLIa3z4nXgqwCzDz4vxrWFNKBRRi9n8u7AzNwuTSVg
	 pk9MsMj9pV6rxh0ow6Dq95EZbp9cqc44khlkOUINYW+4M9e7vTyuypcqd6fHnLVqCh
	 uZftS1oJ95X0BA041xXpwdn5vZVsPMjqA+m9oFZjBMJ6XvnvXgzZjsZHe5im7WFy0+
	 dZWsr4kLjqmq58MzEywKsakQVu4BSUF6c/Zay9TKgEo5IJIkqjmTJ+oWzKUg6569Qx
	 6P5BnKzKriC3Q==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/4] exportfs,nfsd: rework checking for layout-based block device access support
Date: Thu, 23 Apr 2026 14:15:05 -0400
Message-ID: <20260423181505.742554-6-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423181505.742554-1-cel@kernel.org>
References: <20260423181505.742554-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,lst.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21063-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,oracle.com:email]
X-Rspamd-Queue-Id: 90BD8455FF9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christoph Hellwig <hch@lst.de>

Currently NFSD hard codes checking support for block-style layouts.
Lift the checks into a file system-helper and provide a exportfs-level
helper to implement the typical checks.

This prepares for supporting block layout export of multiple devices
per file system.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c               |  3 +-
 fs/nfsd/nfs4layouts.c          | 26 +++++------------
 fs/xfs/xfs_pnfs.c              | 13 +++++++++
 include/linux/exportfs_block.h | 52 +++++++++++++++++++++++++++++++++-
 4 files changed, 73 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 15972919e1e9..2584279a47ba 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1435,7 +1435,8 @@ static int svc_export_parse(struct cache_detail *cd, char *mesg, int mlen)
 			goto out4;
 		err = 0;
 
-		nfsd4_setup_layout_type(&exp);
+		if (exp.ex_flags & NFSEXP_PNFS)
+			nfsd4_setup_layout_type(&exp);
 	}
 
 	expp = svc_export_lookup(&exp);
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index cf5b7eb417c5..c3543d456702 100644
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
@@ -128,28 +127,17 @@ nfsd4_set_deviceid(struct nfsd4_deviceid *id, const struct svc_fh *fhp,
 
 void nfsd4_setup_layout_type(struct svc_export *exp)
 {
-#if defined(CONFIG_NFSD_BLOCKLAYOUT) || defined(CONFIG_NFSD_SCSILAYOUT)
 	struct super_block *sb = exp->ex_path.mnt->mnt_sb;
-	const struct exportfs_block_ops *bops = sb->s_export_op->block_ops;
-#endif
+	expfs_block_layouts_t block_supported = exportfs_layouts_supported(sb);
 
-	if (!(exp->ex_flags & NFSEXP_PNFS))
-		return;
-
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
2.53.0


