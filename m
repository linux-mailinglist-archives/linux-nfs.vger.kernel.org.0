Return-Path: <linux-nfs+bounces-4234-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A04B69138C8
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 09:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E7D1F21BBD
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 07:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A2420317;
	Sun, 23 Jun 2024 07:36:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5577462
	for <linux-nfs@vger.kernel.org>; Sun, 23 Jun 2024 07:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719128200; cv=none; b=KL3xa5jMtUdWgsRgIt7ZtqUpIEiq9XMSPo+Z7q4lxezhA8wVdRTmvYPqWVcANy4SgBR30fKjWBe30VUZVJil4Wx5/fGFLutXRaktk3dw10vk3wzgzjykhnccJexVZM24AE2tPI1vgBtT7JxxcMlYuOXOeFiTAwkeQgegmSYJRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719128200; c=relaxed/simple;
	bh=jhYLBOoVcSp6RNM7j9BUY0U7XCjba1YIg/MOuKANTiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4i+n+/7BUaEP3VyWsoZJf7KGw0baGBAy3SxhmgqXEw/QT+QRnHm73lcbBVLW7Je+44w/4ONnypnnwycI95cdDDDekamiR6fvD0QjiU99lzTW4oFTIu7caTktPFk5H3x7mh2YwzfvDvXS/w2r/tCeDn/ncpJJeaWIaGkkLGwgks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7DBE167373; Sun, 23 Jun 2024 09:36:27 +0200 (CEST)
Date: Sun, 23 Jun 2024 09:36:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, cel@kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 1/4] nfs/blocklayout: Fix premature PR key
 unregistration
Message-ID: <20240623073627.GA28166@lst.de>
References: <20240621162227.215412-6-cel@kernel.org> <20240621162227.215412-7-cel@kernel.org> <20240622050324.GA11110@lst.de> <ZncJMl0eYOeLw5v9@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZncJMl0eYOeLw5v9@tissot.1015granger.net>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Jun 22, 2024 at 01:26:10PM -0400, Chuck Lever wrote:
> This patch currently adds the pr_reg callback to
> bl_find_get_deviceid(), which has no visibility of the volume
> hierarchy. Where should the registration be done instead? I'm
> missing something.

Something like the patch below (untested Sunday morning coding) should
do the trick:

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 947b2c52344097..6db54b215066e0 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -564,34 +564,32 @@ bl_find_get_deviceid(struct nfs_server *server,
 		gfp_t gfp_mask)
 {
 	struct nfs4_deviceid_node *node;
-	struct pnfs_block_dev *d;
-	unsigned long start, end;
+	int err = -ENODEV;
 
 retry:
 	node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags))
-		goto transient;
+	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
+		unsigned long end = jiffies;
+		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
 
-	d = container_of(node, struct pnfs_block_dev, node);
-	if (d->pr_register)
-		if (!d->pr_register(d))
-			goto out_put;
-	return node;
-
-transient:
-	end = jiffies;
-	start = end - PNFS_DEVICE_RETRY_TIMEOUT;
-	if (!time_in_range(node->timestamp_unavailable, start, end)) {
-		nfs4_delete_deviceid(node->ld, node->nfs_client, id);
-		goto retry;
+		if (!time_in_range(node->timestamp_unavailable, start, end)) {
+			nfs4_delete_deviceid(node->ld, node->nfs_client, id);
+			goto retry;
+		}
+		goto out_put;
 	}
 
+	err = bl_register_dev(container_of(node, struct pnfs_block_dev, node));
+	if (err)
+		goto out_put;
+	return node;
+
 out_put:
 	nfs4_put_deviceid_node(node);
-	return ERR_PTR(-ENODEV);
+	return ERR_PTR(err);
 }
 
 static int
diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index cc788e8ce90933..7efbef9d10dba8 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -104,6 +104,7 @@ struct pnfs_block_dev {
 	u64				start;
 	u64				len;
 
+	enum pnfs_block_volume_type	type;
 	u32				nr_children;
 	struct pnfs_block_dev		*children;
 	u64				chunk_size;
@@ -116,7 +117,6 @@ struct pnfs_block_dev {
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
-	bool (*pr_register)(struct pnfs_block_dev *dev);
 };
 
 /* pnfs_block_dev flag bits */
@@ -178,6 +178,7 @@ struct bl_msg_hdr {
 #define BL_DEVICE_REQUEST_ERR          0x2 /* User level process fails */
 
 /* dev.c */
+int bl_register_dev(struct pnfs_block_dev *d);
 struct nfs4_deviceid_node *bl_alloc_deviceid_node(struct nfs_server *server,
 		struct pnfs_device *pdev, gfp_t gfp_mask);
 void bl_free_deviceid_node(struct nfs4_deviceid_node *d);
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 16fb64d4af31db..72e061e87e145a 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -13,9 +13,74 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
+static void bl_unregister_scsi(struct pnfs_block_dev *dev)
+{
+	struct block_device *bdev = file_bdev(dev->bdev_file);
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+
+	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+		return;
+
+	if (ops->pr_register(bdev, dev->pr_key, 0, false))
+		pr_err("failed to unregister PR key.\n");
+}
+
+static bool bl_register_scsi(struct pnfs_block_dev *dev)
+{
+	struct block_device *bdev = file_bdev(dev->bdev_file);
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	int status;
+
+	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
+		return true;
+
+	status = ops->pr_register(bdev, 0, dev->pr_key, true);
+	if (status) {
+		pr_err("pNFS: failed to register key for block device %s.",
+		       bdev->bd_disk->disk_name);
+		return false;
+	}
+	return true;
+}
+
+static void bl_unregister_dev(struct pnfs_block_dev *dev)
+{
+	if (dev->nr_children) {
+		for (u32 i = 0; i < dev->nr_children; i++)
+			bl_unregister_dev(&dev->children[i]);
+		return;
+	}
+
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
+		bl_unregister_scsi(dev);
+}
+
+int bl_register_dev(struct pnfs_block_dev *dev)
+{
+	if (dev->nr_children) {
+		for (u32 i = 0; i < dev->nr_children; i++) {
+			int ret = bl_register_dev(&dev->children[i]);
+
+			if (ret) {
+				while (i > 0)
+					bl_unregister_dev(&dev->children[--i]);
+				return ret;
+			}
+		}
+
+		return 0;
+	}
+
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
+		return bl_register_scsi(dev);
+	return 0;
+}
+
 static void
 bl_free_device(struct pnfs_block_dev *dev)
 {
+	bl_unregister_dev(dev);
+
 	if (dev->nr_children) {
 		int i;
 
@@ -23,17 +88,6 @@ bl_free_device(struct pnfs_block_dev *dev)
 			bl_free_device(&dev->children[i]);
 		kfree(dev->children);
 	} else {
-		if (test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
-			struct block_device *bdev = file_bdev(dev->bdev_file);
-			const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
-			int error;
-
-			error = ops->pr_register(file_bdev(dev->bdev_file),
-				dev->pr_key, 0, false);
-			if (error)
-				pr_err("failed to unregister PR key.\n");
-		}
-
 		if (dev->bdev_file)
 			fput(dev->bdev_file);
 	}
@@ -226,30 +280,6 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	return true;
 }
 
-/**
- * bl_pr_register_scsi - Register a SCSI PR key for @d
- * @dev: pNFS block device, key to register is already in @d->pr_key
- *
- * Returns true if the device's PR key is registered, otherwise false.
- */
-static bool bl_pr_register_scsi(struct pnfs_block_dev *dev)
-{
-	struct block_device *bdev = file_bdev(dev->bdev_file);
-	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
-	int status;
-
-	if (test_and_set_bit(PNFS_BDEV_REGISTERED, &dev->flags))
-		return true;
-
-	status = ops->pr_register(bdev, 0, dev->pr_key, true);
-	if (status) {
-		pr_err("pNFS: failed to register key for block device %s.",
-		       bdev->bd_disk->disk_name);
-		return false;
-	}
-	return true;
-}
-
 static int
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);
@@ -392,7 +422,6 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		goto out_blkdev_put;
 	}
 
-	d->pr_register = bl_pr_register_scsi;
 	return 0;
 
 out_blkdev_put:
@@ -478,7 +507,9 @@ static int
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
-	switch (volumes[idx].type) {
+	d->type = volumes[idx].type;
+
+	switch (d->type) {
 	case PNFS_BLOCK_VOLUME_SIMPLE:
 		return bl_parse_simple(server, d, volumes, idx, gfp_mask);
 	case PNFS_BLOCK_VOLUME_SLICE:
@@ -490,7 +521,7 @@ bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
 	case PNFS_BLOCK_VOLUME_SCSI:
 		return bl_parse_scsi(server, d, volumes, idx, gfp_mask);
 	default:
-		dprintk("unsupported volume type: %d\n", volumes[idx].type);
+		dprintk("unsupported volume type: %d\n", d->type);
 		return -EIO;
 	}
 }

