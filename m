Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEFF43302F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Oct 2021 09:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhJSH4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 19 Oct 2021 03:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhJSH4s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 19 Oct 2021 03:56:48 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5572CC061765;
        Tue, 19 Oct 2021 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZtmbQu8tFnChql+nwH2seJ2xwSPNVUa6shaSNBkIMzA=; b=sEnMkz4cQPpVU+eoBd32w2m/w5
        IPuLu31XTViECjKDi7SPBLXg99VM+RcgsE6xbIbfQ5oxgIBCE85RIrxtUkfbmCdiVBASdqSQAA58S
        hxA7mZg1TZRwKquJXHWFrv5KQ773eCFGRn1djdoE2I26sTKODxOm8ar+zScHx3iR/xlAK1r6oc0BY
        y+BlzF/WA3gY/s6HY9itPBr+OCrW7nY+HmbD/IZSx6KCXKvwbAX+kKRW1YF4CDCUXTKXbFvlgPMa9
        Hwgp+qEpvj6DKjJYbIPe/9jtb6xnsVkm00COxtZP6tGyzbybQ+tdGQxmDZXhYVSeKdtwgxwx0iruM
        X+c3MiFA==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjx9-000TA1-0t; Tue, 19 Oct 2021 07:54:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/7] bsg-lib: initialize the bsg_job in bsg_transport_sg_io_fn
Date:   Tue, 19 Oct 2021 09:54:15 +0200
Message-Id: <20211019075418.2332481-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019075418.2332481-1-hch@lst.de>
References: <20211019075418.2332481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Directly initialize the bsg_job structure instead of relying on the
->.initialize_rq_fn indirection.  This also removes the superflous
initialization of the second request used for BIDI requests.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/bsg-lib.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index ccb98276c964a..10aa378702fab 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -31,6 +31,7 @@ static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	struct bsg_job *job;
 	struct request *rq;
 	struct bio *bio;
+	void *reply;
 	int ret;
 
 	if (hdr->protocol != BSG_PROTOCOL_SCSI  ||
@@ -39,22 +40,28 @@ static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	if (!capable(CAP_SYS_RAWIO))
 		return -EPERM;
 
-	rq = blk_get_request(q, hdr->dout_xfer_len ?
+	rq = blk_mq_alloc_request(q, hdr->dout_xfer_len ?
 			     REQ_OP_DRV_OUT : REQ_OP_DRV_IN, 0);
 	if (IS_ERR(rq))
 		return PTR_ERR(rq);
 	rq->timeout = timeout;
 
 	job = blk_mq_rq_to_pdu(rq);
+	reply = job->reply;
+	memset(job, 0, sizeof(*job));
+	job->reply = reply;
+	job->reply_len = SCSI_SENSE_BUFFERSIZE;
+	job->dd_data = job + 1;
+
 	job->request_len = hdr->request_len;
 	job->request = memdup_user(uptr64(hdr->request), hdr->request_len);
 	if (IS_ERR(job->request)) {
 		ret = PTR_ERR(job->request);
-		goto out_put_request;
+		goto out_free_rq;
 	}
 
 	if (hdr->dout_xfer_len && hdr->din_xfer_len) {
-		job->bidi_rq = blk_get_request(rq->q, REQ_OP_DRV_IN, 0);
+		job->bidi_rq = blk_mq_alloc_request(rq->q, REQ_OP_DRV_IN, 0);
 		if (IS_ERR(job->bidi_rq)) {
 			ret = PTR_ERR(job->bidi_rq);
 			goto out_free_job_request;
@@ -134,11 +141,11 @@ static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 		blk_rq_unmap_user(job->bidi_bio);
 out_free_bidi_rq:
 	if (job->bidi_rq)
-		blk_put_request(job->bidi_rq);
+		blk_mq_free_request(job->bidi_rq);
 out_free_job_request:
 	kfree(job->request);
-out_put_request:
-	blk_put_request(rq);
+out_free_rq:
+	blk_mq_free_request(rq);
 	return ret;
 }
 
@@ -302,18 +309,6 @@ static int bsg_init_rq(struct blk_mq_tag_set *set, struct request *req,
 	return 0;
 }
 
-/* called right before the request is given to the request_queue user */
-static void bsg_initialize_rq(struct request *req)
-{
-	struct bsg_job *job = blk_mq_rq_to_pdu(req);
-	void *reply = job->reply;
-
-	memset(job, 0, sizeof(*job));
-	job->reply = reply;
-	job->reply_len = SCSI_SENSE_BUFFERSIZE;
-	job->dd_data = job + 1;
-}
-
 static void bsg_exit_rq(struct blk_mq_tag_set *set, struct request *req,
 		       unsigned int hctx_idx)
 {
@@ -350,7 +345,6 @@ static const struct blk_mq_ops bsg_mq_ops = {
 	.queue_rq		= bsg_queue_rq,
 	.init_request		= bsg_init_rq,
 	.exit_request		= bsg_exit_rq,
-	.initialize_rq_fn	= bsg_initialize_rq,
 	.complete		= bsg_complete,
 	.timeout		= bsg_timeout,
 };
-- 
2.30.2

