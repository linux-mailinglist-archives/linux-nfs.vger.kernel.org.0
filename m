Return-Path: <linux-nfs+bounces-7606-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5676B9B7DC8
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9BAEB2331E
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2024 15:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325AE19E99C;
	Thu, 31 Oct 2024 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="en2u195t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5B6A019
	for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730387221; cv=none; b=fcCVh4YQaQkntlUNt2DkbCmRDmS0sE8TmuCpHWZCThL89xH+hAjBQHEW9kxVhWxoBGcH/KoY1nMQ10cPp9uMtVKntgF9fKhsEhFP6jbzbhHT/V+iCbpRSPV6afNcK4vopmcP+byq0YcLEHBR/OnsSYio/chQwr9j9Dh2mRNVEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730387221; c=relaxed/simple;
	bh=h2EeO+RDrnIsPHyYE0q67DkKeZA7IVsjRSvZ1TyeRsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lnK5KtCC1HjLOIqHqt7Pss1sgtaPxdVT/4+dk7A65xwacN08TMZfNleX5sPbmyRMlpUT1c4Zo4BcKSO95T/wekeiZsIgaJ041de9Eas55ebEw/utE1A0g46MCz9Mucbibzc1cknV3dh3DejhdzHk8fYJSgXRfLfe362b0KzTTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=en2u195t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730387217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zW1p1Hk2ATUzKb/rrzNSAt+zs2hNmejNsvS9zd6KgUs=;
	b=en2u195thUNSP3vlhudZIm6bqDM7oM+EbGjGW3cDuBOArvRk+lnfS7GYlppIkz+Jax4NUW
	+iDHkLsWbo34xo1FHg7K5OjL07P7pSEFUBSAJSGZzGLANvajyMtYB6JliDAAcJecUDUJJX
	k7cKDhB7xNEI7Pb6aWfEm19By+ZDnj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-6H7ozxj9PNi7pSjP5mZ0Pg-1; Thu,
 31 Oct 2024 11:06:53 -0400
X-MC-Unique: 6H7ozxj9PNi7pSjP5mZ0Pg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 058B019540F3;
	Thu, 31 Oct 2024 15:06:51 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.17])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9EF919560A2;
	Thu, 31 Oct 2024 15:06:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] dm: add support for get_unique_id
Date: Thu, 31 Oct 2024 11:06:48 -0400
Message-ID: <701894fdf55ce2cb379eb26f6ee0536f96103ab9.1730387019.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This adds support to obtain a device's unique id through dm, similar to the
existing ioctl and persistent resevation handling.  We limit this to
single-target devices.

This enables knfsd to export pNFS SCSI luns that have been exported from
multipath devices.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

---
V2: style, add a comment about sanity, strip "uuid" from variable names

---
 drivers/md/dm.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 87bb90303435..ee97e23ffffc 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -3342,6 +3342,59 @@ void dm_free_md_mempools(struct dm_md_mempools *pools)
 	kfree(pools);
 }
 
+struct dm_blkdev_id {
+	u8 *id;
+	enum blk_unique_id type;
+};
+
+static int __dm_get_unique_id(struct dm_target *ti, struct dm_dev *dev,
+				sector_t start, sector_t len, void *data)
+{
+	struct dm_blkdev_id *dm_id = data;
+	const struct block_device_operations *fops = dev->bdev->bd_disk->fops;
+
+	if (!fops->get_unique_id)
+		return 0;
+
+	return fops->get_unique_id(dev->bdev->bd_disk, dm_id->id, dm_id->type);
+}
+
+/*
+ * Allow access to get_unique_id() for the first device returning a
+ * non-zero result.  Reasonable use expects all devices to have the
+ * same unique id.
+ */
+static int dm_blk_get_unique_id(struct gendisk *disk, u8 *id,
+		enum blk_unique_id type)
+{
+	struct mapped_device *md = disk->private_data;
+	struct dm_table *table;
+	struct dm_target *ti;
+	int ret = 0, srcu_idx;
+
+	struct dm_blkdev_id dm_id = {
+		.id = id,
+		.type = type,
+	};
+
+	table = dm_get_live_table(md, &srcu_idx);
+	if (!table || !dm_table_get_size(table))
+		goto out;
+
+	/* We only support devices that have a single target */
+	if (table->num_targets != 1)
+		goto out;
+	ti = dm_table_get_target(table, 0);
+
+	if (!ti->type->iterate_devices)
+		goto out;
+
+	ret = ti->type->iterate_devices(ti, __dm_get_unique_id, &dm_id);
+out:
+	dm_put_live_table(md, srcu_idx);
+	return ret;
+}
+
 struct dm_pr {
 	u64	old_key;
 	u64	new_key;
@@ -3667,6 +3720,7 @@ static const struct block_device_operations dm_blk_dops = {
 	.ioctl = dm_blk_ioctl,
 	.getgeo = dm_blk_getgeo,
 	.report_zones = dm_blk_report_zones,
+	.get_unique_id = dm_blk_get_unique_id,
 	.pr_ops = &dm_pr_ops,
 	.owner = THIS_MODULE
 };
@@ -3676,6 +3730,7 @@ static const struct block_device_operations dm_rq_blk_dops = {
 	.release = dm_blk_close,
 	.ioctl = dm_blk_ioctl,
 	.getgeo = dm_blk_getgeo,
+	.get_unique_id = dm_blk_get_unique_id,
 	.pr_ops = &dm_pr_ops,
 	.owner = THIS_MODULE
 };

base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
-- 
2.47.0


