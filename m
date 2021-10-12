Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3498A42A417
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 14:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbhJLMOq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbhJLMOp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 08:14:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4471BC061570;
        Tue, 12 Oct 2021 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=otj5+fHPMg6yySPFoM+8gaTb8tzsfEJsOMRkoj8w0Q0=; b=uiiEma1UcEfcnWjdoBHLQOSR31
        0V6E6ykaSQ9rwhZT1UL4PTjlQy7viOjv9QCM0fH1axhCZprrrRXH7a+j3zqRwosO01ZbZqMC3j5gn
        p6yjVzustGnTCcLgN2sfwO+u1WmUh/fRJ4OadAcI2QzA74SJPYKPJyQdgungiVVmzn7umNt49ji3d
        hV6ivoD/nQ4h6tXaGoK2PQ2TuDWtbxGNRSimD+QecHX0z7Bqw1vgIIQMpCpDdIbKOQKmxDZy39n9m
        9najUk+JB0aXUwZDyulqFI79KogaOY3qsllDw3ygpj9JdjX90VgFLW8ZFwG7gWA2JyW5ZL3ClnuE9
        kVZl2rGA==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGce-006U8F-Gm; Tue, 12 Oct 2021 12:11:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 6/7] block: remove the initialize_rq_fn blk_mq_ops method
Date:   Tue, 12 Oct 2021 14:04:44 +0200
Message-Id: <20211012120445.861860-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012120445.861860-1-hch@lst.de>
References: <20211012120445.861860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Entirely unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 9 +--------
 include/linux/blk-mq.h | 5 -----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9b8c706701900..2cc3189aaee35 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -615,16 +615,9 @@ EXPORT_SYMBOL(blk_get_queue);
 struct request *blk_get_request(struct request_queue *q, unsigned int op,
 				blk_mq_req_flags_t flags)
 {
-	struct request *req;
-
 	WARN_ON_ONCE(op & REQ_NOWAIT);
 	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PM));
-
-	req = blk_mq_alloc_request(q, op, flags);
-	if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
-		q->mq_ops->initialize_rq_fn(req);
-
-	return req;
+	return blk_mq_alloc_request(q, op, flags);
 }
 EXPORT_SYMBOL(blk_get_request);
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0e941f2175784..d7f70cc79ac7d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -571,11 +571,6 @@ struct blk_mq_ops {
 	void (*exit_request)(struct blk_mq_tag_set *set, struct request *,
 			     unsigned int);
 
-	/**
-	 * @initialize_rq_fn: Called from inside blk_get_request().
-	 */
-	void (*initialize_rq_fn)(struct request *rq);
-
 	/**
 	 * @cleanup_rq: Called before freeing one request which isn't completed
 	 * yet, and usually for freeing the driver private data.
-- 
2.30.2

