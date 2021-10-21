Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58A3435AA5
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Oct 2021 08:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUGIl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Oct 2021 02:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhJUGIk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Oct 2021 02:08:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4178C06161C;
        Wed, 20 Oct 2021 23:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZtmbQu8tFnChql+nwH2seJ2xwSPNVUa6shaSNBkIMzA=; b=WIkWvO3hXVw7TSpR5XULWr6s6h
        vWavgW1rXJSW2uIOBPCbY2p427q2xDKvUC9kZPcO3p8iD9qBiEdXSRAEBxrkB0nJ487beoDLhvDDp
        bz4n07XoMKfkJBPa3G7lWgbjPCs6CY6bt3fDZoCa0FFARgIQBDHBnY4AMflaeZWwDJDuOVwcejMBQ
        arUzeYPV+CXaQ9oNH2fkU5ePftinntzSmKGUubM+XUVyJWriq0j0J16dc1vc8J3kznJgS7UuxKuW7
        BSJbrDN78UxCNFDOf6PMgAyk4fnVXAJTwebls/ShmO6MPBhoymYqmWSwifkdNcyqP673cA73jOxB+
        z50zsdGA==;
Received: from [2001:4bb8:180:8777:7df0:a8d8:40cc:3310] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdRDa-006U6S-Qt; Thu, 21 Oct 2021 06:06:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/7] bsg-lib: initialize the bsg_job in bsg_transport_sg_io_fn
Date:   Thu, 21 Oct 2021 08:06:04 +0200
Message-Id: <20211021060607.264371-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211021060607.264371-1-hch@lst.de>
References: <20211021060607.264371-1-hch@lst.de>
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

