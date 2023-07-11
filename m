Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3A174ED83
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 14:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGKMBo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 08:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjGKMBn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 08:01:43 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0F10CB;
        Tue, 11 Jul 2023 05:01:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 12E3967373; Tue, 11 Jul 2023 14:01:38 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:01:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
Subject: Re: NFS workload leaves nfsd threads in D state
Message-ID: <20230711120137.GA27050@lst.de>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com> <20230710075634.GA30120@lst.de> <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com> <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com> <20230710172839.GA7190@lst.de> <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 10, 2023 at 05:40:42PM +0000, Chuck Lever III wrote:
> > blk_rq_init_flush(rq);
> > - rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
> > + rq->flush.seq |= REQ_FSEQ_PREFLUSH;
> > spin_lock_irq(&fq->mq_flush_lock);
> > list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
> > spin_unlock_irq(&fq->mq_flush_lock);
> 
> Thanks for the quick response. No change.

I'm a bit lost and still can't reprodce.  Below is a patch with the
only behavior differences I can find.  It has two "#if 1" blocks,
which I'll need to bisect to to find out which made it work (if any,
but I hope so).

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d59..67364e607f2d1d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2927,6 +2927,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	struct blk_plug *plug = blk_mq_plug(bio);
 	const int is_sync = op_is_sync(bio->bi_opf);
+	bool is_flush = op_is_flush(bio->bi_opf);
 	struct blk_mq_hw_ctx *hctx;
 	struct request *rq;
 	unsigned int nr_segs = 1;
@@ -2967,16 +2968,23 @@ void blk_mq_submit_bio(struct bio *bio)
 		return;
 	}
 
-	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
-		return;
-
-	if (plug) {
-		blk_add_rq_to_plug(plug, rq);
-		return;
+#if 1	/* Variant 1, the plug is holding us back */
+	if (op_is_flush(bio->bi_opf)) {
+		if (blk_insert_flush(rq))
+			return;
+	} else {
+		if (plug) {
+			blk_add_rq_to_plug(plug, rq);
+			return;
+		}
 	}
+#endif
 
 	hctx = rq->mq_hctx;
 	if ((rq->rq_flags & RQF_USE_SCHED) ||
+#if 1	/* Variant 2 (unlikely), blk_mq_try_issue_directly causes problems */
+	    is_flush || 
+#endif
 	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
 		blk_mq_insert_request(rq, 0);
 		blk_mq_run_hw_queue(hctx, true);
