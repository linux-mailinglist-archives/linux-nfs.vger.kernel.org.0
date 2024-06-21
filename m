Return-Path: <linux-nfs+bounces-4216-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D9912B43
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCC7B27A80
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AB115FCF6;
	Fri, 21 Jun 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMns3dnL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEA1757F8
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 16:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986964; cv=none; b=CqEii4NMoMBHcH79zQ/Z4/bbRegJmL3GtrAzI65AER8GZxJc+WvSDVU0iPQ46zzGXZEh6k0DkaPnS3gLrLcfOQAot8s+4eop3NuiecV3iqCzKe1OZjaaG5qa/GCmOIYTYykZt7aHhhpCtF+Bt7BhMY584x/ugz69XuDEnzMH9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986964; c=relaxed/simple;
	bh=VGWkXsOIrcL0K44gGoN4XC20rsgkpm6CuZolyejrPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxTymJ9GqJL7H/Zvlw+9NOAdoVSfYrHPLlNQNb0ul1whazkWPrmTm/rFGng/UnrdPy/slJWXJsHqjPSZx2fN7u9nzMNGxvRNZhoZcJU8HqATe3rped6TG9hCSezX36ISkPj1sB/m5Y3l/gMjoTX1l97nYfasbkNWLtg8RnyZT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMns3dnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C86C3277B;
	Fri, 21 Jun 2024 16:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718986964;
	bh=VGWkXsOIrcL0K44gGoN4XC20rsgkpm6CuZolyejrPDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DMns3dnLFWXIWySVVkyUJW8vu1vHO0NRKBfFg3zVuzJCjECoIYwzG10Et9eMtgUeE
	 TDxLSLgZwE5BOuh2G+tPrOCzyth6Fd/vtJbhcvI4VR2joyrec+bAQZ7eR4TYDF4tNL
	 myBm9H9UuB/ZO2DZYoYmkIprkwoWVHALuwtINNYdVZyvUewMQ2QkXlV3gKluLpug4x
	 4z/q4K++sF5KqwOonYlIYQFjrC6GVfU9PyjQXNGY+nQWru5bFcgSG4PoKK0x1jl/Sg
	 Vy7wtEjd2mLfko6dxkLoCD81GgWvWexlT4twn+muzOjwdhCZkPuG4knZp9GXpitWa/
	 iV4/Ln1litA9Q==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 1/4] nfs/blocklayout: Fix premature PR key unregistration
Date: Fri, 21 Jun 2024 12:22:29 -0400
Message-ID: <20240621162227.215412-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621162227.215412-6-cel@kernel.org>
References: <20240621162227.215412-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7169; i=chuck.lever@oracle.com; h=from:subject; bh=seYo1ktlLJ7RNV/jCJ4kC1U9ecb3ceeLiqQyhLZI/98=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmdajI9fqOmRvkvZYiNFqa5pVRM1OhAWySMA5UN 8VPnPgVNBmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnWoyAAKCRAzarMzb2Z/ lzPgD/9p2I5ki4WhEqUEP6SPQqg3NixwWSHXxQ9R8KhvEOfnW5GWDTpTO1KjEDn8ju9wuX061ip sB73vp68R63ls5w8qVLsB2j9Nn7ZeWCifsZYy2ye55wL2leS+8HOoDQ4lCq4+GQkQayuzr1srnr E+lIv738q9f1MKUHnQGUqPnHf4PVuwgHe8obddRExjxMY2bx6JHpCAzmrMBaWRXPXpQLG0omCdO 3aTbRw7yXdv59UrcThy4W9z/ynvv5MOZQzTAYH52cWJZpGjzsYtduJChqZzlumzYC2tpZbyZQAH J1V8aalsepedXZSAjuiW1BrDDj/RjA7ZnMeouNL8sdhTJyXzKh9UJ5ZM0rjYy/pqWXGm8tvv7bv duAroyV1my41aYWs/kkCWjcUKtOcl5JUR3gAJddkp0qR+Lg8ojQQnJhWnXTJshXQNLWNI+dbhLK Kknw8u5YEZpCLgRSa0Na8AgqxN2Wbr6YO589QhFrm/9X6eFVuAMZg6dbkAkrulYi/8HBpVq9Ox4 9iXoD9j/5U9z6Cop91qVu3pFLkywcyL0LNI8FxWO37c9oBfy8HbxPQrXxFT5q2lZhMaYePdmdTs CrRBsC3K6SSi1Q3Fo8HliMypg3G4BujQ6Jga3d6B8B9p1w1tQOJfX/76rquxUyFQFP27RPyPySs kBvxNNzcHWEhe5A==
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.c | 13 +++++++++--
 fs/nfs/blocklayout/blocklayout.h |  8 ++++++-
 fs/nfs/blocklayout/dev.c         | 39 +++++++++++++++++++++++---------
 3 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 6be13e0ec170..947b2c523440 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -564,6 +564,7 @@ bl_find_get_deviceid(struct nfs_server *server,
 		gfp_t gfp_mask)
 {
 	struct nfs4_deviceid_node *node;
+	struct pnfs_block_dev *d;
 	unsigned long start, end;
 
 retry:
@@ -571,9 +572,16 @@ bl_find_get_deviceid(struct nfs_server *server,
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
-		return node;
+	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags))
+		goto transient;
 
+	d = container_of(node, struct pnfs_block_dev, node);
+	if (d->pr_register)
+		if (!d->pr_register(d))
+			goto out_put;
+	return node;
+
+transient:
 	end = jiffies;
 	start = end - PNFS_DEVICE_RETRY_TIMEOUT;
 	if (!time_in_range(node->timestamp_unavailable, start, end)) {
@@ -581,6 +589,7 @@ bl_find_get_deviceid(struct nfs_server *server,
 		goto retry;
 	}
 
+out_put:
 	nfs4_put_deviceid_node(node);
 	return ERR_PTR(-ENODEV);
 }
diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index f1eeb4914199..cc788e8ce909 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -110,12 +110,18 @@ struct pnfs_block_dev {
 
 	struct file			*bdev_file;
 	u64				disk_offset;
+	unsigned long			flags;
 
 	u64				pr_key;
-	bool				pr_registered;
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
+	bool (*pr_register)(struct pnfs_block_dev *dev);
+};
+
+/* pnfs_block_dev flag bits */
+enum {
+	PNFS_BDEV_REGISTERED = 0,
 };
 
 /* sector_t fields are all in 512-byte sectors */
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 519c310c745d..83753a08a19d 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -23,9 +23,9 @@ bl_free_device(struct pnfs_block_dev *dev)
 			bl_free_device(&dev->children[i]);
 		kfree(dev->children);
 	} else {
-		if (dev->pr_registered) {
-			const struct pr_ops *ops =
-				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;
+		if (test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
+			struct block_device *bdev = file_bdev(dev->bdev_file);
+			const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 			int error;
 
 			error = ops->pr_register(file_bdev(dev->bdev_file),
@@ -226,6 +226,30 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	return true;
 }
 
+/**
+ * bl_pr_register_scsi - Register a SCSI PR key for @d
+ * @dev: pNFS block device, key to register is already in @d->pr_key
+ *
+ * Returns true if the device's PR key is registered, otherwise false.
+ */
+static bool bl_pr_register_scsi(struct pnfs_block_dev *dev)
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
 static int
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);
@@ -367,14 +391,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
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
+	d->pr_register = bl_pr_register_scsi;
 	return 0;
 
 out_blkdev_put:
-- 
2.45.1


