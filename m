Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B48942A3E8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 14:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbhJLMKR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 08:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLMKR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 08:10:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC7C061570;
        Tue, 12 Oct 2021 05:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YjZkO/ZkbEt3peEfWyVz0lmAYsb2gt0A57XguI4HdCM=; b=p7FBXJBoI6dkJcrn+CzVQA9uve
        dttuUvbBHqzltCO2z/fIBN8BuySYRFNaEgB/qKhLU4S1v+NTWFJmxlr3IrnvjOPlIqGXSp60hWoRy
        2xaC76xtg1PY1shakZyWNJ8k3BrKCp1s3SQRhR4EQxBvSNFgdChs2rxccov9JOGBrUMwYBp4Oi4II
        A3XS9IPb+aK+8Cm7VlCuzTsXcDK6S0TynUm8XG1s4iYdnKhFzWl6ChNFZtuZYGIHY2XzHc+IRueFp
        e78aP1l94je1kuXpXcyyP4I1sl8zzUq89vkP1MlraM2RtO6uq6KSwfWrqJcm3feB/uIO6e7twpjPx
        d2QHumrg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGYO-006Tr0-Go; Tue, 12 Oct 2021 12:07:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] sd: implement ->get_unique_id
Date:   Tue, 12 Oct 2021 14:04:40 +0200
Message-Id: <20211012120445.861860-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012120445.861860-1-hch@lst.de>
References: <20211012120445.861860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add the method to query for a uniqueue ID of a given type by looking
it up in the cached device identification VPD page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d8f6add416c0a..ea1489d3e8497 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1757,6 +1757,42 @@ static void sd_rescan(struct device *dev)
 	sd_revalidate_disk(sdkp->disk);
 }
 
+static int sd_get_unique_id(struct gendisk *disk, u8 id[16], u8 type)
+{
+	struct scsi_device *sdev = scsi_disk(disk)->device;
+	const struct scsi_vpd *vpd;
+	const unsigned char *d;
+	int len = -ENXIO;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdev->vpd_pg83);
+	if (!vpd)
+		goto out_unlock;
+
+	len = -EINVAL;
+	for (d = vpd->data + 4; d < vpd->data + vpd->len; d += d[3] + 4) {
+		/* we only care about designators with LU association */
+		if (((d[1] >> 4) & 0x3) != 0x00)
+			continue;
+		if ((d[1] & 0xf) != type)
+			continue;
+
+		/*
+		 * Only exit early if a 16-byte descriptor was found.  Otherwise
+		 * keep looking as one with more entropy might still show up.
+		 */
+		len = d[3];
+		if (len != 8 && len != 12 && len != 16)
+			continue;
+		memcpy(id, d + 4, len);
+		if (len == 16)
+			break;
+	}
+out_unlock:
+	rcu_read_unlock();
+	return len;
+}
+
 static char sd_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -1861,6 +1897,7 @@ static const struct block_device_operations sd_fops = {
 	.check_events		= sd_check_events,
 	.unlock_native_capacity	= sd_unlock_native_capacity,
 	.report_zones		= sd_zbc_report_zones,
+	.get_unique_id		= sd_get_unique_id,
 	.pr_ops			= &sd_pr_ops,
 };
 
-- 
2.30.2

