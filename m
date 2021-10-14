Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB442D3DB
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Oct 2021 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNHkP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 03:40:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45036 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhJNHkO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 03:40:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 61DE221A74;
        Thu, 14 Oct 2021 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634197089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/yt4sFkSwKeiPEwjxKe7RBVr/VqfiPCXjdyC3ZbF5M=;
        b=lHcnEK/3huHMegP8nt5Na8cJa8CrIa6CUKa+DI5r0g07qUd2BgcKUz55j+SKxebFh2rnxC
        CXR0X/9qlB3wXNDcrGHzipdgJZoR9IzMgw4SQBDyS77G5uXtJEqmVmdNQq7xzcGU9srVTi
        qmfno7EhMEiixYsPIrnIfV7hjgdSJlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634197089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x/yt4sFkSwKeiPEwjxKe7RBVr/VqfiPCXjdyC3ZbF5M=;
        b=MOqABLYGbBOGQINqYCatrzMLpKX7wh6h4WWrmvmVHuQcmpi4fsumvvNd+M0F1drc4HnRIh
        yFP4dZ4yG2H6T3Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DE5113D3F;
        Thu, 14 Oct 2021 07:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4fZNCmHeZ2GbIAAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 14 Oct 2021 07:38:09 +0000
Subject: Re: [PATCH 6/7] block: remove the initialize_rq_fn blk_mq_ops method
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211012120445.861860-1-hch@lst.de>
 <20211012120445.861860-7-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d176a9bd-8d69-4da1-4368-9d6437ccc5b5@suse.de>
Date:   Thu, 14 Oct 2021 09:38:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211012120445.861860-7-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 10/12/21 2:04 PM, Christoph Hellwig wrote:
> Entirely unused now.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c       | 9 +--------
>   include/linux/blk-mq.h | 5 -----
>   2 files changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9b8c706701900..2cc3189aaee35 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -615,16 +615,9 @@ EXPORT_SYMBOL(blk_get_queue);
>   struct request *blk_get_request(struct request_queue *q, unsigned int op,
>   				blk_mq_req_flags_t flags)
>   {
> -	struct request *req;
> -
>   	WARN_ON_ONCE(op & REQ_NOWAIT);
>   	WARN_ON_ONCE(flags & ~(BLK_MQ_REQ_NOWAIT | BLK_MQ_REQ_PM));
> -
> -	req = blk_mq_alloc_request(q, op, flags);
> -	if (!IS_ERR(req) && q->mq_ops->initialize_rq_fn)
> -		q->mq_ops->initialize_rq_fn(req);
> -
> -	return req;
> +	return blk_mq_alloc_request(q, op, flags);
>   }
>   EXPORT_SYMBOL(blk_get_request);
>   
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 0e941f2175784..d7f70cc79ac7d 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -571,11 +571,6 @@ struct blk_mq_ops {
>   	void (*exit_request)(struct blk_mq_tag_set *set, struct request *,
>   			     unsigned int);
>   
> -	/**
> -	 * @initialize_rq_fn: Called from inside blk_get_request().
> -	 */
> -	void (*initialize_rq_fn)(struct request *rq);
> -
>   	/**
>   	 * @cleanup_rq: Called before freeing one request which isn't completed
>   	 * yet, and usually for freeing the driver private data.
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
