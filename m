Return-Path: <linux-nfs+bounces-4081-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B211C90F54B
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7AB1C20A2E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05F15572F;
	Wed, 19 Jun 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCYRoBji"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834F1E87B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818812; cv=none; b=M1Ya/96CRT01U72yASp62PnEobb14UYlW0O4t186yjcz3LiWnMeVepR7PStTYWNpZefgDFYvhw1vv1BI7iJ4wciBfJLzXazX7EbJDZcR+ZJ3oLWmtsf0AZtCup+oM3ZFP4ogNolrO7Rps3o8UOg/i88CxEWpw6zSzvxRwLuckdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818812; c=relaxed/simple;
	bh=7Cr0kcvmCok79YFMgU73r9NZ7nXhqcCcx2+MstZoL34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7O2fUgw4GMK8YU4LLYxvwBebms0xqElIqH494jU7krTuGFSYzjrkaEMUyMHxBS6NGi6lcEy0Q3pfWdDsJ3EYlplgOobfyuh5Dkp29oGPjEaw9HBAkVf9E6PyrndR+iXn/qR4oJzIFutIWrF2/OumjNXnMz//e8Eag9QVdHo/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCYRoBji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91BDC32786;
	Wed, 19 Jun 2024 17:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818812;
	bh=7Cr0kcvmCok79YFMgU73r9NZ7nXhqcCcx2+MstZoL34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCYRoBjiaElkD4j3zdiENHmRi2Uv8EXAnL+wP9WpWJkh9dOpROfVzibFpPohiikW+
	 wpAlFM942oKoLixJwEogwop7WmZGv66RqgHcpnrOQvp0nj1J3d2ZsAqor6AC5IE3pl
	 yo1O8ddBAvq1inB7kycOfK6qCixKybxacmDEmk5CJ/Ie1DmBgnR9fHVKcFza1FowYh
	 auovSyDOoB5FgkQ77GmYTkOF64UQDqkSds6rCxcIcQQ9OZE3JLRP86kfRxw9OppHsZ
	 ZsywH5JxJbFSUi8Zsm1p9Ivxno2p/txITEWpxKqY47IlGXJVdSB0ZuvCx8KURob7mx
	 WjoM+AUspI6bA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 3/4] nfs/blocklayout: Fix premature PR key unregistration
Date: Wed, 19 Jun 2024 13:39:33 -0400
Message-ID: <20240619173929.177818-9-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619173929.177818-6-cel@kernel.org>
References: <20240619173929.177818-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5925; i=chuck.lever@oracle.com; h=from:subject; bh=dHe9H/hu2rXJ7p/feuLdWXoTXyCzRf6rlvqCZYCN73k=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcxfXS51l0M8Yz9dM4lQ1EfrNWuINzGTV6Kvrc z5K3PZ62saJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnMX1wAKCRAzarMzb2Z/ l8ozD/92bsxP+C6MRkIJsNlroELGvxzspdShy0gUKNQDKiFy/tfC2AXNz39654SIjpTkApcwcr+ REGjyUzw3VAXUvmbeFGikFaIIgv0AAXiVDu2zUK+lgabk7X8RfMycWHoBJXyftSCdjNDorq74Dz jpjKl2Y4nPlFwpOaTpwx+gLxV1FwWqNQQbBBNFFzwRrUqqRHJ4So4Ipf0SW3NhtN7g6p0WiuiRZ DIt7X3OQDbLMGeUItNNYs1zs0Cq9O+RaPF7QgEZDX++Pw5bFr+9DpTk1nK1PjJFa4oiaI4jGaxv SY1vEmTQNbCJDX/Z+8B1UxJdmxNAiEaCq8ZmMRuU9r12CDf0ZpIJ8PqH4itIY/OxejBqgd40QUn AK728XgZF8AtA+dbHj89/rZ6DjA+Atu0wt+LpFW9zK+OKEAtynYO1gOq9FTCEC1TCokVc5ZEZrI KuDBPWClVIkvJaHbCF5UEtbSG0Pto5I0nqFvt8L/4BDh3F0ExIxpl/HbhKUfxwkyV4NJf1cWNZz 9Au3E7FqSjFheRDp46hk8FOHKrTqxyjtcZWG6AbPC4TxdKVrjUOYIxkAheefSTSqSbbjKa2JI0D BWf43OaG/1A+4Vrb/aJ/XpJsMm9i2Kpjyqks3EFZ0BCF67VmroumMaTY9FPD7vG9R88Js1uL7cw PUypTKX6WeJkJTA==
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
 fs/nfs/blocklayout/blocklayout.c |  9 ++++++++-
 fs/nfs/blocklayout/blocklayout.h |  1 +
 fs/nfs/blocklayout/dev.c         | 29 +++++++++++++++++++++--------
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 6be13e0ec170..75cc5e50bd37 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -571,8 +571,14 @@ bl_find_get_deviceid(struct nfs_server *server,
 	if (!node)
 		return ERR_PTR(-ENODEV);
 
-	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0)
+	if (test_bit(NFS_DEVICEID_UNAVAILABLE, &node->flags) == 0) {
+		struct pnfs_block_dev *d =
+			container_of(node, struct pnfs_block_dev, node);
+		if (d->pr_reg)
+			if (d->pr_reg(d) < 0)
+				goto out_put;
 		return node;
+	}
 
 	end = jiffies;
 	start = end - PNFS_DEVICE_RETRY_TIMEOUT;
@@ -581,6 +587,7 @@ bl_find_get_deviceid(struct nfs_server *server,
 		goto retry;
 	}
 
+out_put:
 	nfs4_put_deviceid_node(node);
 	return ERR_PTR(-ENODEV);
 }
diff --git a/fs/nfs/blocklayout/blocklayout.h b/fs/nfs/blocklayout/blocklayout.h
index f1eeb4914199..8aabaf5218b8 100644
--- a/fs/nfs/blocklayout/blocklayout.h
+++ b/fs/nfs/blocklayout/blocklayout.h
@@ -116,6 +116,7 @@ struct pnfs_block_dev {
 
 	bool (*map)(struct pnfs_block_dev *dev, u64 offset,
 			struct pnfs_block_dev_map *map);
+	int (*pr_reg)(struct pnfs_block_dev *dev);
 };
 
 /* sector_t fields are all in 512-byte sectors */
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 356bc967fb5d..3d2401820ef4 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -230,6 +230,26 @@ static bool bl_map_stripe(struct pnfs_block_dev *dev, u64 offset,
 	return true;
 }
 
+static int bl_register_scsi(struct pnfs_block_dev *d)
+{
+	struct block_device *bdev = file_bdev(d->bdev_file);
+	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	int error;
+
+	if (d->pr_registered)
+		return 0;
+
+	error = ops->pr_register(bdev, 0, d->pr_key, true);
+	if (error) {
+		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
+		return -error;
+	}
+
+	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
+	d->pr_registered = true;
+	return 0;
+}
+
 static int
 bl_parse_deviceid(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask);
@@ -373,14 +393,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		goto out_blkdev_put;
 	}
 
-	error = ops->pr_register(bdev, 0, d->pr_key, true);
-	if (error) {
-		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
-		goto out_blkdev_put;
-	}
-	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
-
-	d->pr_registered = true;
+	d->pr_reg = bl_register_scsi;
 	return 0;
 
 out_blkdev_put:
-- 
2.45.1


