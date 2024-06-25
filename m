Return-Path: <linux-nfs+bounces-4304-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D0991721B
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 22:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78748288913
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 20:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5F617DE0D;
	Tue, 25 Jun 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWZt6wS9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC05B17D88A
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345736; cv=none; b=AUcrw7ibCeNPuecXdikAYnbda05LNFo1Tu1zLe8xXL2Zeq5Ukb5eYiicZsYs+FCz3dRVk9vV/i9KF9j6jwToxvmUQY2gBEuYT1k1ZKAGPdsnTbzaAu+iHk32GTu5w9G/+C31E9gZKOFVtYg0mySy4pbPkh9K+8s1FvyEUzWkDfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345736; c=relaxed/simple;
	bh=87tOrnHzg8Y5Vy1Jc3JNDHlpcKVtZ9nE6wxT+vUhn00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPqbR2QlGajeiiSX8vQOL4n3Hh/+wJ6Ig1Yx46javqfyE0+mrI3bUIkzFlVX2Oo80h5rV0ndHQjP7OqDcSMqnfAI+nJD2Fdmq4+gXwHa/kXIwXTYzxwgvKpjGFeZxtfT1OrPuFus1XXX9b6WemBY9j91mvhM0vE592l3qQuBYac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWZt6wS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29123C32781;
	Tue, 25 Jun 2024 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719345736;
	bh=87tOrnHzg8Y5Vy1Jc3JNDHlpcKVtZ9nE6wxT+vUhn00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWZt6wS9zX8AvFS5Lv4LCXKdZL1DLKauYgtfSKQhtu8h+5mKyPXJy5udikJUTQP12
	 mdKi3jxoqhhuODFInCrpYj6+T++iPDcbB+9h0B+uvyHiY+QtJDIu2hVlqfl7dg3IdG
	 AD/Eng1uTyRA9iUW9F9a80dXep4vbpk0tn5tM/DT4swAtL85xf0YtO1r7nPDuiqiEV
	 eH53gzvcsqPFZuvFiGHLmTvisXM9dek588OJss1tWhPyjHPJ89aIJEbHZeefqpKSmh
	 UBnlHIOPkX592aENTEmySZqQWnA0iW4eVtl7v+OQJK/KaVZXwkFF8jgHNCtirgl55E
	 hmEXMQ7L0pqgA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 1/3] nfs/blocklayout: Fix premature PR key unregistration
Date: Tue, 25 Jun 2024 16:02:06 -0400
Message-ID: <20240625200204.276770-6-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625200204.276770-5-cel@kernel.org>
References: <20240625200204.276770-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9397; i=chuck.lever@oracle.com; h=from:subject; bh=qJ3IwM8sZzntNZUTMYpHV59s+1ZH+Ys+1D3DUW/Ik7A=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmeyJCnoIp8tn3fL27E0Uor36SDnPBUD70UBcXO lBCn0L3OJyJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnsiQgAKCRAzarMzb2Z/ l730D/9FG2VTicLV2LX/cXMtM0j8nAioNdYiDAOPH0Gn7/KIzFHIbwVxV/VT4QYnqEJaxl5VjMc T/KTTX0lqn6NieIzxASw8ok16rkqTgW5tE3mhz4j6whuKTeEov45fBmIEMelXWnVOvuFayddLG4 tt9VYasdIkLrygJCI1zDYcK4KRl8E+As2uQjwSY3sxScfdkZ+YHYCei604o1C83tzQ9AllT/HLP qQeR2uzUyn7NMxCOxEuQqZoFwzWhzOHoMztfjYGwdDwQ2Ntg/hFDBGJ4xkIqvoofLGTAs4Ix8P2 LWjG8k0lxtZwcTEAKoVe+g4coOgbTNFYomV3YdxWgxs2CVSPEnRvXGqpPPTgIvHLBq4rnS6Sqbe kVLa7MBKQhTreZGpzc3YJnRROhRwBvGhXofYBn2tPFJnFu+G84hC67+h/vowAE5oXeG963lYkyG iwSYXTrRDP+OOn363ahXNUzT4HLw8ajTeD4UGK75VBHvvCBFyw4wfGj/L/mqVi73S0acojpKAWy ygMo7cIfdOsopSAP+094tGsvaxDYN/bY5Amr8Gkq9kWeG7fNWvvVy/7j83+iPKWRo/BDrmCj/D7 cqd6otZ0HqcKWRE3vFVCl2+o2WiRw0cWscm6cFOw/Uc/8XBmFLn5VNxCDBRyK1kse3KQZtafUMa 3N0Mhdj1Cll8vbA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

During generic/069 runs with pNFS SCSI layouts, the NFS client emits
the following in the system journal:

kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
kernel: pNFS: failed to open device /dev/disk/by-id/dm-uuid-mpath-0x6001405e3366f045b7949eb8e4540b51 (-2)
kernel: pNFS: using block device sdb (reservation key 0x666b60901e7b26b3)
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: [sdb] tag#16 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
kernel: sd 6:0:0:1: [sdb] tag#16 CDB: Write(10) 2a 00 00 00 00 50 00 00 08 00
kernel: reservation conflict error, dev sdb, sector 80 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 2
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: reservation conflict
kernel: sd 6:0:0:1: [sdb] tag#18 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
kernel: sd 6:0:0:1: [sdb] tag#17 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
kernel: sd 6:0:0:1: [sdb] tag#18 CDB: Write(10) 2a 00 00 00 00 60 00 00 08 00
kernel: sd 6:0:0:1: [sdb] tag#17 CDB: Write(10) 2a 00 00 00 00 58 00 00 08 00
kernel: reservation conflict error, dev sdb, sector 96 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
kernel: reservation conflict error, dev sdb, sector 88 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0
systemd[1]: fstests-generic-069.scope: Deactivated successfully.
systemd[1]: fstests-generic-069.scope: Consumed 5.092s CPU time.
systemd[1]: media-test.mount: Deactivated successfully.
systemd[1]: media-scratch.mount: Deactivated successfully.
kernel: sd 6:0:0:1: reservation conflict
kernel: failed to unregister PR key.

This appears to be due to a race. bl_alloc_lseg() calls this:

561 static struct nfs4_deviceid_node *
562 bl_find_get_deviceid(struct nfs_server *server,
563                 const struct nfs4_deviceid *id, const struct cred *cred,
564                 gfp_t gfp_mask)
565 {
566         struct nfs4_deviceid_node *node;
567         unsigned long start, end;
568
569 retry:
570         node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
571         if (!node)
572                 return ERR_PTR(-ENODEV);

nfs4_find_get_deviceid() does a lookup without the spin lock first.
If it can't find a matching deviceid, it creates a new device_info
(which calls bl_alloc_deviceid_node, and that registers the device's
PR key).

Then it takes the nfs4_deviceid_lock and looks up the deviceid again.
If it finds it this time, bl_find_get_deviceid() frees the spare
(new) device_info, which unregisters the PR key for the same device.

Any subsequent I/O from this client on that device gets EBADE.

The umount later unregisters the device's PR key again.

To prevent this problem, register the PR key after the deviceid_node
lookup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.c | 25 +++++----
 fs/nfs/blocklayout/blocklayout.h |  9 +++-
 fs/nfs/blocklayout/dev.c         | 91 ++++++++++++++++++++++++--------
 3 files changed, 94 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 6be13e0ec170..0becdec12970 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -564,25 +564,32 @@ bl_find_get_deviceid(struct nfs_server *server,
 		gfp_t gfp_mask)
 {
 	struct nfs4_deviceid_node *node;
-	unsigned long start, end;
+	int err = -ENODEV;
 
 retry:
 	node = nfs4_find_get_deviceid(server, id, cred, gfp_mask);
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
-		return node;
+	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags)) {
+		unsigned long end = jiffies;
+		unsigned long start = end - PNFS_DEVICE_RETRY_TIMEOUT;
 
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
 
+	if (!bl_register_dev(container_of(node, struct pnfs_block_dev, node)))
+		goto out_put;
+
+	return node;
+
+out_put:
 	nfs4_put_deviceid_node(node);
-	return ERR_PTR(-ENODEV);
+	return ERR_PTR(err);
 }
 
 static int
diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index f1eeb4914199..6da40ca19570 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -104,20 +104,26 @@ struct pnfs_block_dev {
 	u64				start;
 	u64				len;
 
+	enum pnfs_block_volume_type	type;
 	u32				nr_children;
 	struct pnfs_block_dev		*children;
 	u64				chunk_size;
 
 	struct file			*bdev_file;
 	u64				disk_offset;
+	unsigned long			flags;
 
 	u64				pr_key;
-	bool				pr_registered;
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
 };
 
+/* pnfs_block_dev flag bits */
+enum {
+	PNFS_BDEV_REGISTERED = 0,
+};
+
 /* sector_t fields are all in 512-byte sectors */
 struct pnfs_block_extent {
 	union {
@@ -172,6 +178,7 @@ struct bl_msg_hdr {
 #define BL_DEVICE_REQUEST_ERR          0x2 /* User level process fails */
 
 /* dev.c */
+bool bl_register_dev(struct pnfs_block_dev *d);
 struct nfs4_deviceid_node *bl_alloc_deviceid_node(struct nfs_server *server,
 		struct pnfs_device *pdev, gfp_t gfp_mask);
 void bl_free_deviceid_node(struct nfs4_deviceid_node *d);
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 519c310c745d..fc4eeb7bbf05 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -13,9 +13,75 @@
 
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
+	u32 i;
+
+	if (dev->nr_children) {
+		for (i = 0; i < dev->nr_children; i++)
+			bl_unregister_dev(&dev->children[i]);
+		return;
+	}
+
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
+		bl_unregister_scsi(dev);
+}
+
+bool bl_register_dev(struct pnfs_block_dev *dev)
+{
+	u32 i;
+
+	if (dev->nr_children) {
+		for (i = 0; i < dev->nr_children; i++) {
+			if (!bl_register_dev(&dev->children[i])) {
+				while (i > 0)
+					bl_unregister_dev(&dev->children[--i]);
+				return false;
+			}
+		}
+		return true;
+	}
+
+	if (dev->type == PNFS_BLOCK_VOLUME_SCSI)
+		return bl_register_scsi(dev);
+	return true;
+}
+
 static void
 bl_free_device(struct pnfs_block_dev *dev)
 {
+	bl_unregister_dev(dev);
+
 	if (dev->nr_children) {
 		int i;
 
@@ -23,17 +89,6 @@ bl_free_device(struct pnfs_block_dev *dev)
 			bl_free_device(&dev->children[i]);
 		kfree(dev->children);
 	} else {
-		if (dev->pr_registered) {
-			const struct pr_ops *ops =
-				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;
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
@@ -367,14 +422,6 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		goto out_blkdev_put;
 	}
 
-	error = ops->pr_register(file_bdev(d->bdev_file), 0, d->pr_key, true);
-	if (error) {
-		pr_err("pNFS: failed to register key for block device %s.",
-				file_bdev(d->bdev_file)->bd_disk->disk_name);
-		goto out_blkdev_put;
-	}
-
-	d->pr_registered = true;
 	return 0;
 
 out_blkdev_put:
@@ -460,7 +507,9 @@ static int
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
@@ -472,7 +521,7 @@ bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
 	case PNFS_BLOCK_VOLUME_SCSI:
 		return bl_parse_scsi(server, d, volumes, idx, gfp_mask);
 	default:
-		dprintk("unsupported volume type: %d\n", volumes[idx].type);
+		dprintk("unsupported volume type: %d\n", d->type);
 		return -EIO;
 	}
 }
-- 
2.45.1


