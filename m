Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C667A3FBD96
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 22:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbhH3UrO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Aug 2021 16:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhH3UrN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 30 Aug 2021 16:47:13 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D448C061575
        for <linux-nfs@vger.kernel.org>; Mon, 30 Aug 2021 13:46:19 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 03DE47C6E; Mon, 30 Aug 2021 16:46:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 03DE47C6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1630356377;
        bh=hSWmsE9lWy3Caf3Go57RMX6C4UpWZoY3uqe0f5zg/VA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ei2R29RoFob25X8lvwas0u7kfnRf7x5zPmCpiQDsd23LUItsTcJT9L26d8n2uKLQ8
         SQ0bpnBLDCzGRqI6Um9hioTJkyZy5qsg1oStZSvEkm0i6efNyZuu0UIviwgath0vzv
         FeB6Gpdj2f3A0c5n35stUfwgLb+r0rXPFDDw1/2E=
Date:   Mon, 30 Aug 2021 16:46:16 -0400
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Mike Javorski <mike.javorski@gmail.com>,
        Mel Gorman <mgorman@suse.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] SUNRPC: don't pause on incomplete allocation
Message-ID: <20210830204616.GA13399@fieldses.org>
References: <163004202961.7591.12633163545286005205@noble.neil.brown.name>
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>
 <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>
 <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>
 <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
 <163027659478.7591.8897815399981483759@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163027659478.7591.8897815399981483759@noble.neil.brown.name>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For what it's worth, another positive report on this patch:
https://bugzilla.kernel.org/show_bug.cgi?id=213869#c10

--b.

On Mon, Aug 30, 2021 at 08:36:34AM +1000, NeilBrown wrote:
> 
> alloc_pages_bulk_array() attempts to allocate at least one page based on
> the provided pages, and then opportunistically allocates more if that
> can be done without dropping the spinlock.
> 
> So if it returns fewer than requested, that could just mean that it
> needed to drop the lock.  In that case, try again immediately.
> 
> Only pause for a time if no progress could be made.
> 
> Reported-and-tested-by: Mike Javorski <mike.javorski@gmail.com>
> Reported-and-tested-by: Lothar Paltins <lopa@mailbox.org>
> Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> 
> I decided I would resend, as I thought the for() loops could be clearer.
> This patch should perform exactly the same as the previous one.
> 
> 
>  net/sunrpc/svc_xprt.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index d66a8e44a1ae..e74d5cf3cbb4 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  {
>  	struct svc_serv *serv = rqstp->rq_server;
>  	struct xdr_buf *arg = &rqstp->rq_arg;
> -	unsigned long pages, filled;
> +	unsigned long pages, filled, ret;
>  
>  	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
>  	if (pages > RPCSVC_MAXPAGES) {
> @@ -672,11 +672,12 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  		pages = RPCSVC_MAXPAGES;
>  	}
>  
> -	for (;;) {
> -		filled = alloc_pages_bulk_array(GFP_KERNEL, pages,
> -						rqstp->rq_pages);
> -		if (filled == pages)
> -			break;
> +	for (filled = 0; filled < pages; filled = ret) {
> +		ret = alloc_pages_bulk_array(GFP_KERNEL, pages,
> +					     rqstp->rq_pages);
> +		if (ret > filled)
> +			/* Made progress, don't sleep yet */
> +			continue;
>  
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		if (signalled() || kthread_should_stop()) {
> -- 
> 2.32.0
