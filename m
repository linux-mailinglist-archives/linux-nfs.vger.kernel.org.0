Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5AD435AAD
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 08:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhJUGIr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 02:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUGIq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 02:08:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3041AC06161C;
        Wed, 20 Oct 2021 23:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zwsoBId8IcnSgwMOFnvrbUriZK7O2i5DeoGRxyH3eME=; b=2ZplV0/L3RdzEPewqfulZoxVZb
        BOgCIGqg4OG6cD6WE0DB5XnjlrURKXo4gkFA3mPKfdUTSQ6WS1cUdQ9BtpxyiRuNob6k7qBfvm0c7
        ysr2Yn6bMrXnAuAlVCCb9reQIH3L1Ezb3B+JoBTf4c31gj+3nmUnP8poUvb+vjHpIgJcqNR2jVZXp
        ogs7KdrkytS61jmZgLfmpsy7BNcxJqWAmhN6VeqGsaksneYHZC/Gzv+gX5t9eFY1UMeW7cfMEWOF8
        juXFvDkGSJm1i8YB9z9kd35B7yXqsC5rKw4DmUFSB9kvqbzt4A/LvBaT20zHSKcGGyOgW/KtXI4xV
        nEKpuOrw==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdRDg-006U8e-So; Thu, 21 Oct 2021 06:06:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/7] block: remove the initialize_rq_fn blk_mq_ops method
Date:   Thu, 21 Oct 2021 08:06:06 +0200
Message-Id: <20211021060607.264371-7-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021060607.264371-1-hch@lst.de>
References: <20211021060607.264371-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Entirely unused now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-core.c       | 9 +--------
 include/linux/blk-mq.h | 5 -----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d0c2e11411d03..52a460d0aeb2a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -606,16 +606,9 @@ EXPORT_SYMBOL(blk_get_queue);
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
index 656fe34bdb6cd..649be3f21d740 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -565,11 +565,6 @@ struct blk_mq_ops {
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

