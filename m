Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0257757EC8
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 15:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGRN7P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjGRN7O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 09:59:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444C4137
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 06:58:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22ED9615B5
        for <linux-nfs@vger.kernel.org>; Tue, 18 Jul 2023 13:58:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFFFC433C9;
        Tue, 18 Jul 2023 13:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689688709;
        bh=2lwfdAX6JUgMENDp4agUxYEwoJYbLZPR1o0BMOaHuNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kX0mKEFVYwMwtV1dD+CgIo2Y7JVDPntGvYs5IghO1lnZEb1PHmFWu+gu0rBWKjGGW
         6vOV35ToD4qir6WXJlhXP/AofraD7rbasBblAGFJCShNGsAYIj0uarPC4xBNR7I5Q+
         G4xK7mBvTIf+2WVQHdv/eIb6FIkMiXwQmLp3lZjQpDVAjrUdwh/IRMRhFQBSm/VL9X
         PffckD74nH2lPDL7bMneK4jLuujakSvKKnJhw+SGzjl4KU95ZHFfBB2cyI5Tggfmdq
         WHMA0lQ0FaXiqmCu9RhGSGmSJWDuPlH87j8Rr2IjP3a0g2Nd9fCKbrQgx5G1rcPmP7
         nqUVx//uuNuQA==
Date:   Tue, 18 Jul 2023 09:58:27 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
Message-ID: <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
 <168966228866.11075.18415964365983945832.stgit@noble.brown>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168966228866.11075.18415964365983945832.stgit@noble.brown>
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
> No callers of svc_pool_wake_idle_thread() care which thread was woken -
> except one that wants to trace the wakeup.  For now we drop that
> tracepoint.

That's an important tracepoint, IMO.

It might be better to have svc_pool_wake_idle_thread() return void
right from it's introduction, and move the tracepoint into that
function. I can do that and respin if you agree.


> One caller wants to know if anything was woken to set SP_CONGESTED, so
> set that inside the function instead.
> 
> Now svc_pool_wake_idle_thread() can "return" void.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  include/linux/sunrpc/svc.h |    2 +-
>  net/sunrpc/svc.c           |   13 +++++--------
>  net/sunrpc/svc_xprt.c      |   18 +++---------------
>  3 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index ea3ce1315416..b39c613fbe06 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -454,7 +454,7 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
>  
>  void		   svc_wake_up(struct svc_serv *);
>  void		   svc_reserve(struct svc_rqst *rqstp, int space);
> -struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_serv *serv,
> +void		   svc_pool_wake_idle_thread(struct svc_serv *serv,
>  					     struct svc_pool *pool);
>  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
>  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index b18175ef74ec..fd49e7b12c94 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -696,13 +696,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>   * @serv: RPC service
>   * @pool: service thread pool
>   *
> - * Returns an idle service thread (now marked BUSY), or NULL
> - * if no service threads are available. Finding an idle service
> - * thread and marking it BUSY is atomic with respect to other
> - * calls to svc_pool_wake_idle_thread().
> + * Wake an idle thread if there is one, else mark the pool as congested.
>   */
> -struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
> -					   struct svc_pool *pool)
> +void svc_pool_wake_idle_thread(struct svc_serv *serv,
> +			       struct svc_pool *pool)
>  {
>  	struct svc_rqst	*rqstp;
>  
> @@ -715,13 +712,13 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
>  		wake_up_process(rqstp->rq_task);
>  		rcu_read_unlock();
>  		percpu_counter_inc(&pool->sp_threads_woken);
> -		return rqstp;
> +		return;
>  	}
>  	rcu_read_unlock();
>  
>  	trace_svc_pool_starved(serv, pool);
>  	percpu_counter_inc(&pool->sp_threads_starved);
> -	return NULL;
> +	set_bit(SP_CONGESTED, &pool->sp_flags);
>  }
>  EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
>  
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 948605e7043b..964c97dbb36c 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -456,7 +456,6 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
>   */
>  void svc_xprt_enqueue(struct svc_xprt *xprt)
>  {
> -	struct svc_rqst *rqstp;
>  	struct svc_pool *pool;
>  
>  	if (!svc_xprt_ready(xprt))
> @@ -477,13 +476,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>  	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
>  	spin_unlock_bh(&pool->sp_lock);
>  
> -	rqstp = svc_pool_wake_idle_thread(xprt->xpt_server, pool);
> -	if (!rqstp) {
> -		set_bit(SP_CONGESTED, &pool->sp_flags);
> -		return;
> -	}
> -
> -	trace_svc_xprt_enqueue(xprt, rqstp);
> +	svc_pool_wake_idle_thread(xprt->xpt_server, pool);
>  }
>  EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
>  
> @@ -587,14 +580,9 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
>  void svc_wake_up(struct svc_serv *serv)
>  {
>  	struct svc_pool *pool = &serv->sv_pools[0];
> -	struct svc_rqst *rqstp;
>  
> -	rqstp = svc_pool_wake_idle_thread(serv, pool);
> -	if (!rqstp) {
> -		set_bit(SP_TASK_PENDING, &pool->sp_flags);
> -		smp_wmb();
> -		return;
> -	}
> +	set_bit(SP_TASK_PENDING, &pool->sp_flags);
> +	svc_pool_wake_idle_thread(serv, pool);
>  }
>  EXPORT_SYMBOL_GPL(svc_wake_up);
>  
> 
> 
