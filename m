Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA743303A
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 09:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhJSH4y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 03:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbhJSH4x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 03:56:53 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D203C061745;
        Tue, 19 Oct 2021 00:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MaNYloGRLxzAenHrMLsvn7WDnjcD3wdf6JM95KrDeMc=; b=3pKX1DVBvd5ZpMinPboPjIhiCF
        dSjCUFrdUEDrBIGKxxz0ilK9ie1sMiadwkvaQLFylLCj17aEZCRkg0GRKvZdRsF6UK6S+EBJ7wXZD
        1ER0U3N1Ci4HKQoZbpKTiBMIQG/oQPWHrBh6KM4Xh+KJrVcGALJXx0cHNEYm6bsDkYHfjfuly4Tlv
        yvQeKHjBnkU4JMFi4AUj1ILCr/Os6UkoIUekn94cy6y2zxTFenJwRDKAKJdRkkb0s8U+6WSkogvTc
        H8eJfA+HobuFdBZDtCiB+4FjITBdyk/k/uNgsb/obItOwjwMDZVbssOqz/LxNLD+/YWcwadxrF0RX
        8wT9JWvw==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjxG-000TC8-RK; Tue, 19 Oct 2021 07:54:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 7/7] block: remove QUEUE_FLAG_SCSI_PASSTHROUGH
Date:   Tue, 19 Oct 2021 09:54:18 +0200
Message-Id: <20211019075418.2332481-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019075418.2332481-1-hch@lst.de>
References: <20211019075418.2332481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Export scsi_device_from_queue for use with pktcdvd and use that instead
of the otherwise unused QUEUE_FLAG_SCSI_PASSTHROUGH queue flag.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-debugfs.c   | 1 -
 drivers/block/pktcdvd.c  | 5 ++++-
 drivers/scsi/scsi_lib.c  | 8 ++++++++
 drivers/scsi/scsi_scan.c | 1 -
 include/linux/blkdev.h   | 3 ---
 5 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 68ca5d21cda77..a317f05de466a 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -124,7 +124,6 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(STATS),
 	QUEUE_FLAG_NAME(POLL_STATS),
 	QUEUE_FLAG_NAME(REGISTERED),
-	QUEUE_FLAG_NAME(SCSI_PASSTHROUGH),
 	QUEUE_FLAG_NAME(QUIESCED),
 	QUEUE_FLAG_NAME(PCI_P2PDMA),
 	QUEUE_FLAG_NAME(ZONE_RESETALL),
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index ea2262ec76d2c..cacf64eedad87 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2536,6 +2536,7 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	int i;
 	char b[BDEVNAME_SIZE];
 	struct block_device *bdev;
+	struct scsi_device *sdev;
 
 	if (pd->pkt_dev == dev) {
 		pkt_err(pd, "recursive setup not allowed\n");
@@ -2559,10 +2560,12 @@ static int pkt_new_dev(struct pktcdvd_device *pd, dev_t dev)
 	bdev = blkdev_get_by_dev(dev, FMODE_READ | FMODE_NDELAY, NULL);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
-	if (!blk_queue_scsi_passthrough(bdev_get_queue(bdev))) {
+	sdev = scsi_device_from_queue(bdev->bd_disk->queue);
+	if (!sdev) {
 		blkdev_put(bdev, FMODE_READ | FMODE_NDELAY);
 		return -EINVAL;
 	}
+	put_device(&sdev->sdev_gendev);
 
 	/* This is safe, since we have a reference from open(). */
 	__module_get(THIS_MODULE);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index a0f801fc8943b..9823b65d15368 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1967,6 +1967,14 @@ struct scsi_device *scsi_device_from_queue(struct request_queue *q)
 
 	return sdev;
 }
+/*
+ * pktcdvd should have been integrated into the SCSI layers, but for historical
+ * reasons like the old IDE driver it isn't.  This export allows it to safely
+ * probe if a given device is a SCSI one and only attach to that.
+ */
+#ifdef CONFIG_CDROM_PKTCDVD_MODULE
+EXPORT_SYMBOL_GPL(scsi_device_from_queue);
+#endif
 
 /**
  * scsi_block_requests - Utility function used by low-level drivers to prevent
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index fe22191522a3b..2808c0cb57114 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -280,7 +280,6 @@ static struct scsi_device *scsi_alloc_sdev(struct scsi_target *starget,
 	sdev->request_queue = q;
 	q->queuedata = sdev;
 	__scsi_init_queue(sdev->host, q);
-	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
 	WARN_ON_ONCE(!blk_get_queue(q));
 
 	depth = sdev->host->cmd_per_lun ?: 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6e1c6fbdee0b5..0e811a9642d7f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -356,7 +356,6 @@ struct request_queue {
 #define QUEUE_FLAG_STATS	20	/* track IO start and completion times */
 #define QUEUE_FLAG_POLL_STATS	21	/* collecting stats for hybrid polling */
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
-#define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
@@ -390,8 +389,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_secure_erase(q) \
 	(test_bit(QUEUE_FLAG_SECERASE, &(q)->queue_flags))
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
-#define blk_queue_scsi_passthrough(q)	\
-	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
 #define blk_queue_pci_p2pdma(q)	\
 	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 #ifdef CONFIG_BLK_RQ_ALLOC_TIME
-- 
2.30.2

