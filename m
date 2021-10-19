Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DBD433022
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234511AbhJSH4i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 03:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhJSH4i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 03:56:38 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88826C06161C;
        Tue, 19 Oct 2021 00:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=VBzWvzBEq9ZV1n7I09jN/S1fg5bKm73VxUaXlqGw6SY=; b=uapbJgRufOblnuS7HkO/l6urnK
        f3fZaVpRf38C1PDffuRgDsXnTl8FNjQ0X1N44jyAoLYVB0d8uDKPFOfOrAKhhmRI+4IawhBtvfFF1
        fM3ck1qMsJxWK1TZX+GaFD1ZHJVEw1//E6d0ZZNnEl0ytsmTGAD1UJVo2bBRzZii01UDRPAxuQOHy
        n01hMQcd6hI9wXB/3NhTz9FcMl6QU7aV2h0X5xj7n5emxhG056lmvtnDtmxVG4STnOqG7h4alTK0E
        IK3f/sEXyW/joVZrieqxasQNcz6j8CeuxWa2zfvKTO4Gm1vQGOQzrVymCD3BzgHs19yubmcyGOY8N
        2AMfJaUg==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjx1-000T7j-6O; Tue, 19 Oct 2021 07:54:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 1/7] block: add a ->get_unique_id method
Date:   Tue, 19 Oct 2021 09:54:12 +0200
Message-Id: <20211019075418.2332481-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019075418.2332481-1-hch@lst.de>
References: <20211019075418.2332481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add a method to query unique IDs from block devices.  It will be used to
remove code that deeply pokes into SCSI internals in the NFS server.
The implementation in the sd driver itself is also much nicer as it can
use the cached VPD page instead of always sending a command as the
current NFS code does.

For now the interface is kept very minimal but could be easily
extended when other users like a block-layer sysfs interface for
uniquue IDs shows up.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fd9771a1da096..6e1c6fbdee0b5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1177,6 +1177,14 @@ static inline void blk_ksm_unregister(struct request_queue *q) { }
 
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION */
 
+enum blk_uniqueue_id {
+	/* these match the Designator Types specified in SPC */
+	BLK_UID_T10	= 1,
+	BLK_UID_EUI64	= 2,
+	BLK_UID_NAA	= 3,
+};
+
+#define NFL4_UFLG_MASK			0x0000003F
 
 struct block_device_operations {
 	void (*submit_bio)(struct bio *bio);
@@ -1195,6 +1203,9 @@ struct block_device_operations {
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
+	/* returns the length of the identifier or a negative errno: */
+	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
+			enum blk_uniqueue_id id_type);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.30.2

