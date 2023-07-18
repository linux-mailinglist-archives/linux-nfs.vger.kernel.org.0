Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D80757E20
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjGRNuD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 09:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjGRNuA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 09:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F362FA
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 06:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C14C761583
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 13:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C398BC433C9;
        Tue, 18 Jul 2023 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689688198;
        bh=P4yDgimb8WXF4N26IwGh/4oB0n6rF6dmM6ksyDzxi8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u56V7Wy9GMuazeRHXgPtAafzPgcZr9XOvpuuy5oo//lnEtMTOO++1BfFfYkrx7zGP
         Hs0MleJrKjAIE7RricKuWuaYJ1Pq7WMcII3a8WfjKmC5fHx0m2aCEYEYYHlMwQ1RXA
         cowgpKXGRMl7p2tGaNfz9HQ9iS8ZMgoAd0NY7aXYer+K0HpIxjJJ6oLeARrhqzGwle
         cN2gXH+Pehxi3qVwaGV0JyWbr2zvjVWSCYzyoI1vFwAlXin6z9vB/JlcRDfJ89sxMW
         Fssbtls4DrLZau335wq6fqNzeCUqc/4cBqdg8w8u+CJO0EKyVif5NaRmvr0l9ci36A
         x/tydiKsG3PMw==
Date:   Tue, 18 Jul 2023 09:49:54 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 07/14] SUNRPC: refactor svc_recv()
Message-ID: <ZLaYgnRSmpcp3z3t@bazille.1015granger.net>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228864.11075.17318657609206358910.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168966228864.11075.17318657609206358910.stgit@noble.brown>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> svc_get_next_xprt() does a lot more than get an xprt.  It mostly waits.
> 
> So rename to svc_wait_for_work() and don't bother returning a value.

Or svc_rqst_wait_for_work() ?

> The xprt can be found in ->rq_xprt.
> 
> Also move all the code to handle ->rq_xprt into a single if branch, so
> that other handlers can be added there if other work is found.
> 
> Remove the call to svc_xprt_dequeue() that is before we set TASK_IDLE.
> If there is still something to dequeue will still get it after a few
> more checks - no sleeping.  This was an unnecessary optimisation which
> muddles the code.

I think "This was an unnecessary optimisation" needs to be
demonstrated, and the removal needs to be a separate patch.

I would also move it before the patch adding
trace_svc_pool_polled() so we don't have a series with a
patch that adds a tracepoint followed by another patch
that removes the same tracepoint.


> Drop a call to kthread_should_stop().  There are enough of those in
> svc_wait_for_work().

A bit of this clean-up could be moved back to 2/14.


> (This patch is best viewed with "-b")
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  net/sunrpc/svc_xprt.c |   70 +++++++++++++++++++------------------------------
>  1 file changed, 27 insertions(+), 43 deletions(-)
> 
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 44a33b1f542f..c7095ff7d5fd 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -735,19 +735,10 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	return true;
>  }
>  
> -static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
> +static void svc_wait_for_work(struct svc_rqst *rqstp)
>  {
>  	struct svc_pool		*pool = rqstp->rq_pool;
>  
> -	/* rq_xprt should be clear on entry */
> -	WARN_ON_ONCE(rqstp->rq_xprt);
> -
> -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> -	if (rqstp->rq_xprt) {
> -		trace_svc_pool_polled(rqstp);
> -		goto out_found;
> -	}
> -
>  	set_current_state(TASK_IDLE);
>  	smp_mb__before_atomic();
>  	clear_bit(SP_CONGESTED, &pool->sp_flags);
> @@ -769,10 +760,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
>  		goto out_found;
>  	}
>  
> -	if (kthread_should_stop())
> -		return NULL;
> -	percpu_counter_inc(&pool->sp_threads_no_work);
> -	return NULL;
> +	if (!kthread_should_stop())
> +		percpu_counter_inc(&pool->sp_threads_no_work);
> +	return;
>  out_found:
>  	/* Normally we will wait up to 5 seconds for any required
>  	 * cache information to be provided.
> @@ -781,7 +771,6 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
>  		rqstp->rq_chandle.thread_wait = 5*HZ;
>  	else
>  		rqstp->rq_chandle.thread_wait = 1*HZ;
> -	return rqstp->rq_xprt;
>  }
>  
>  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct svc_xprt *newxpt)
> @@ -855,45 +844,40 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
>   */
>  void svc_recv(struct svc_rqst *rqstp)
>  {
> -	struct svc_xprt		*xprt = NULL;
> -	struct svc_serv		*serv = rqstp->rq_server;
> -	int			len;
> -
>  	if (!svc_alloc_arg(rqstp))
> -		goto out;
> +		return;
>  
>  	try_to_freeze();
>  	cond_resched();
> -	if (kthread_should_stop())
> -		goto out;
>  
> -	xprt = svc_get_next_xprt(rqstp);
> -	if (!xprt)
> -		goto out;
> +	svc_wait_for_work(rqstp);
>  
> -	len = svc_handle_xprt(rqstp, xprt);
> +	if (rqstp->rq_xprt) {
> +		struct svc_serv	*serv = rqstp->rq_server;
> +		struct svc_xprt *xprt = rqstp->rq_xprt;
> +		int len;
>  
> -	/* No data, incomplete (TCP) read, or accept() */
> -	if (len <= 0)
> -		goto out_release;
> +		len = svc_handle_xprt(rqstp, xprt);
>  
> -	trace_svc_xdr_recvfrom(&rqstp->rq_arg);
> +		/* No data, incomplete (TCP) read, or accept() */
> +		if (len <= 0) {
> +			rqstp->rq_res.len = 0;
> +			svc_xprt_release(rqstp);
> +		} else {
>  
> -	clear_bit(XPT_OLD, &xprt->xpt_flags);
> +			trace_svc_xdr_recvfrom(&rqstp->rq_arg);
>  
> -	rqstp->rq_chandle.defer = svc_defer;
> +			clear_bit(XPT_OLD, &xprt->xpt_flags);
>  
> -	if (serv->sv_stats)
> -		serv->sv_stats->netcnt++;
> -	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
> -	rqstp->rq_stime = ktime_get();
> -	svc_process(rqstp);
> -	return;
> -out_release:
> -	rqstp->rq_res.len = 0;
> -	svc_xprt_release(rqstp);
> -out:
> -	return;
> +			rqstp->rq_chandle.defer = svc_defer;
> +
> +			if (serv->sv_stats)
> +				serv->sv_stats->netcnt++;
> +			percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
> +			rqstp->rq_stime = ktime_get();
> +			svc_process(rqstp);
> +		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
>  
> 
> 
