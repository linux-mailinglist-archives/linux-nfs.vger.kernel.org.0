Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08252750677
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jul 2023 13:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGLLme (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jul 2023 07:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjGLLmb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Jul 2023 07:42:31 -0400
X-Greylist: delayed 433 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Jul 2023 04:42:17 PDT
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBAEAD
        for <linux-nfs@vger.kernel.org>; Wed, 12 Jul 2023 04:42:17 -0700 (PDT)
Message-ID: <82cb9937-bd11-64a9-2520-bf3cf81ec720@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689161700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BeQ2PUPffBPS46ar685O5CqXD4P761piGCzEtpEEO58=;
        b=VzY6ZkYC4s+BaTNpFoOLnYe/hh7/RC84lZA5ZTqzq8hdDNvueQ3E99HVvDStsER8g9XaPr
        ORV+WNU5KdyhhKDE7NXdIG4F7Hsgcx6DfpVgf4+eyzLEZQ8mq13KiImtJB8i7BWjmlSGTd
        PTOoqEMzesOWJkK3IYsB06WaaxSILGU=
Date:   Wed, 12 Jul 2023 19:34:53 +0800
MIME-Version: 1.0
Subject: Re: NFS workload leaves nfsd threads in D state
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@lst.de>, ross.lagerwall@citrix.com
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever <cel@kernel.org>
References: <7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com>
 <20230710075634.GA30120@lst.de>
 <3F16A14B-F854-41CC-A3CA-87C7946FC277@oracle.com>
 <F610D6B3-876F-4E5D-A3C4-A30F1B81D9B5@oracle.com>
 <20230710172839.GA7190@lst.de>
 <0F9A70B1-C6AE-4A8B-8A4B-8DC9ADED73AB@oracle.com>
 <20230711120137.GA27050@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230711120137.GA27050@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 2023/7/11 20:01, Christoph Hellwig wrote:
> On Mon, Jul 10, 2023 at 05:40:42PM +0000, Chuck Lever III wrote:
>>> blk_rq_init_flush(rq);
>>> - rq->flush.seq |= REQ_FSEQ_POSTFLUSH;
>>> + rq->flush.seq |= REQ_FSEQ_PREFLUSH;
>>> spin_lock_irq(&fq->mq_flush_lock);
>>> list_move_tail(&rq->flush.list, &fq->flush_data_in_flight);
>>> spin_unlock_irq(&fq->mq_flush_lock);
>>
>> Thanks for the quick response. No change.
> 
> I'm a bit lost and still can't reprodce.  Below is a patch with the
> only behavior differences I can find.  It has two "#if 1" blocks,
> which I'll need to bisect to to find out which made it work (if any,
> but I hope so).

Hello,

I tried today to reproduce, but can't unfortunately.

Could you please also try the fix patch [1] from Ross Lagerwall that fixes
IO hung problem of plug recursive flush?

(Since the main difference is that post-flush requests now can go into plug.)

[1] https://lore.kernel.org/all/20230711160434.248868-1-ross.lagerwall@citrix.com/

Thanks!

> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5504719b970d59..67364e607f2d1d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2927,6 +2927,7 @@ void blk_mq_submit_bio(struct bio *bio)
>  	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
>  	struct blk_plug *plug = blk_mq_plug(bio);
>  	const int is_sync = op_is_sync(bio->bi_opf);
> +	bool is_flush = op_is_flush(bio->bi_opf);
>  	struct blk_mq_hw_ctx *hctx;
>  	struct request *rq;
>  	unsigned int nr_segs = 1;
> @@ -2967,16 +2968,23 @@ void blk_mq_submit_bio(struct bio *bio)
>  		return;
>  	}
>  
> -	if (op_is_flush(bio->bi_opf) && blk_insert_flush(rq))
> -		return;
> -
> -	if (plug) {
> -		blk_add_rq_to_plug(plug, rq);
> -		return;
> +#if 1	/* Variant 1, the plug is holding us back */
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (blk_insert_flush(rq))
> +			return;
> +	} else {
> +		if (plug) {
> +			blk_add_rq_to_plug(plug, rq);
> +			return;
> +		}
>  	}
> +#endif
>  
>  	hctx = rq->mq_hctx;
>  	if ((rq->rq_flags & RQF_USE_SCHED) ||
> +#if 1	/* Variant 2 (unlikely), blk_mq_try_issue_directly causes problems */
> +	    is_flush || 
> +#endif
>  	    (hctx->dispatch_busy && (q->nr_hw_queues == 1 || !is_sync))) {
>  		blk_mq_insert_request(rq, 0);
>  		blk_mq_run_hw_queue(hctx, true);
