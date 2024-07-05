Return-Path: <linux-nfs+bounces-4646-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE69A928C6F
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 18:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 555B5B20F84
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1BD13A88B;
	Fri,  5 Jul 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IyuBzuHK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E496D1C2AF
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198007; cv=none; b=dCMC95CPsCTyKZ6tRDCKCV72tZHawUvvh8zjv6tlySjWDsEqSlOJDdb2PxiDYNoH+KyNxBu2tCCKnbL9hmOufQxeM3x093smMsardiXKSu9+/DiqkzYVj9VBt3TCxGiI8RjIWbVzeilbaMRJFxdiUI08fImYgk3llpmbn6oyzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198007; c=relaxed/simple;
	bh=YSizkOw3wrMCwSVA+kNrbQfinwax191ca5RxmEHDVc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cWk7TBl5VZjkAsdABewaNMzKtbIBzRPuTF0sQUOzCl4/qgpVF4sEOBmWeaTRJPcCDDnLDYcu8C9Z2XLqp47X6xIb7Fve6dJmJpqaRbk/x8oQFcL1FbaMESsQj8QQImy+MWp4nTcehj63vyB+twsLAbBia6c1NRkLQGUGXs/afp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IyuBzuHK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=wHAWRficndaWpi7+X/WDJd1wtfEUvzaEcg2ki5nRRn4=; b=IyuBzuHKEUv+EHlJPwAFNBWl5G
	dsVbXEatUp7yfm5dExnIL8TnPtYOTJxarjVFEFQMio1/nrRUoLw5cGIvnUg0E6DSqEBIZljl3f0nX
	LtcXTfJRkOb1Vs1c6YBaojcuyVN5PpfGCWWTXMetVVMp8I0EQkmFzfvjTwmvJ89n78jyRqH14P2cy
	7Y7+5kh+Lt5MtGCfce4EeD8sW+OCb7QpnVcPvpsYS+Vo0Dt7JWef/h/GXNzQwo8U1AF8ceXPnMulE
	ZLVMn2u7+RP/7Z8RdFAEz3H8fuVYqM2RnW15fmAGUGeowr0PrrtsCt7mpoKtRAYa8fMbNOpe0kWHK
	LiE1OiNw==;
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm56-0000000GRjc-2jxs;
	Fri, 05 Jul 2024 16:46:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nvme: implement ->get_unique_id
Date: Fri,  5 Jul 2024 18:46:26 +0200
Message-ID: <20240705164640.2247869-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Implement the get_unique_id method to allow pNFS SCSI layout access to
NVMe namespaces.

This is the server side implementation of RFC 9561 "Using the Parallel
NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
Storage Devices".

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc10d..96e0879013b79d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2230,6 +2230,32 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	return ret;
 }
 
+int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
+		enum blk_unique_id type)
+{
+	struct nvme_ns_ids *ids = &ns->head->ids;
+
+	if (type != BLK_UID_EUI64)
+		return -EINVAL;
+
+	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid))) {
+		memcpy(id, &ids->nguid, sizeof(ids->nguid));
+		return sizeof(ids->nguid);
+	}
+	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64))) {
+		memcpy(id, &ids->eui64, sizeof(ids->eui64));
+		return sizeof(ids->eui64);
+	}
+
+	return -EINVAL;
+}
+
+static int nvme_get_unique_id(struct gendisk *disk, u8 id[16],
+		enum blk_unique_id type)
+{
+	return nvme_ns_get_unique_id(disk->private_data, id, type);
+}
+
 #ifdef CONFIG_BLK_SED_OPAL
 static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send)
@@ -2285,6 +2311,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
+	.get_unique_id	= nvme_get_unique_id,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d8b6b4648eaff9..1aed93d792b610 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,6 +427,21 @@ static void nvme_ns_head_release(struct gendisk *disk)
 	nvme_put_ns_head(disk->private_data);
 }
 
+static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
+		enum blk_unique_id type)
+{
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx, ret = -EWOULDBLOCK;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (ns)
+		ret = nvme_ns_get_unique_id(ns, id, type);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data)
@@ -454,6 +469,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.ioctl		= nvme_ns_head_ioctl,
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= nvme_getgeo,
+	.get_unique_id	= nvme_ns_head_get_unique_id,
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3a41133ac3f97..1907fbc3f5dbb3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1062,6 +1062,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
+		enum blk_unique_id type);
+
 struct nvme_zone_info {
 	u64 zone_size;
 	unsigned int max_open_zones;
-- 
2.43.0


