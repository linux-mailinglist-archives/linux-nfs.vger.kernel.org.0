Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3781574DDAA
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 20:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjGJS54 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 14:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjGJS5y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 14:57:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89CC106
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 11:57:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B19B611AC
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 18:57:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3AFC433C8;
        Mon, 10 Jul 2023 18:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689015471;
        bh=L7WBhDsB2KWk2c5QRTze86AiIO7Voa0i0pglOp64msE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZzHnnI624hXU3hdgTE+cRXKvdXCK0rSL0HMODxqkUlQSZFNgZ8zF4Wi79CotXggJ
         HcVC08RzZDRT6lawlCe51AXF6XgDGRpjgzUpAw7quO+28dkzBBU3Rp4yHVclYiN+PN
         Qg2xHfCuTZGaNP+VviV6cHifH5f4595FBn4ssuVAvAGoGfL0f0UtUk2EPtqKCYkxhN
         4xwnPy0fM2uCK5bLgYGj/CNW/O8wS3BMNagNQYgsna9RAiGw1fgsuskeoKlTldUnEB
         Kgk59jxoDbojHVDgwUgpniGxXE/XR3yljr7kgq+PBJOCIDLA/G+ZHEGS+yK8lRyBVv
         rukHPIQZDZHcg==
Date:   Mon, 10 Jul 2023 14:57:48 -0400
From:   Chuck Lever <cel@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, neilb@suse.de, david@fromorbit.com
Subject: Re: [PATCH v3 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
Message-ID: <ZKxUrJ1y5bM3wYMU@manet.1015granger.net>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>
 <168900737297.7514.333293207540036098.stgit@manet.1015granger.net>
 <f6320e113f9ba505638a774ae33adda68575cec4.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6320e113f9ba505638a774ae33adda68575cec4.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 10, 2023 at 02:28:56PM -0400, Jeff Layton wrote:
> On Mon, 2023-07-10 at 12:42 -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > I've noticed that client-observed server request latency goes up
> > simply when the nfsd thread count is increased.
> > 
> > Walking the whole set of pool threads is memory-inefficient. On a
> > busy server with many threads, enqueuing a transport will visit all
> > the threads in the pool quite frequently. This also pulls in the
> > cache lines for some hot fields in each svc_rqst (namely, rq_flags).
> > 
> > The svc_xprt_enqueue() call that concerns me most is the one in
> > svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
> > down completion handling limits the total throughput per RDMA
> > connection.
> > 
> > Instead, set up a busy bitmap and use find_next_clear_bit, which
> > should work the same way as RQ_BUSY but will touch only the cache
> > lines that the bitmap is in. Stick with atomic bit operations to
> > avoid taking a spinlock during the search.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  include/linux/sunrpc/svc.h    |    6 ++++--
> >  include/trace/events/sunrpc.h |    1 -
> >  net/sunrpc/svc.c              |   24 +++++++++++++++++++-----
> >  net/sunrpc/svc_xprt.c         |   26 ++++++++++++++++++++------
> >  4 files changed, 43 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 86377506a514..6669f3eb9ed4 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -35,6 +35,7 @@ struct svc_pool {
> >  	spinlock_t		sp_lock;	/* protects sp_sockets */
> >  	struct list_head	sp_sockets;	/* pending sockets */
> >  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > +	unsigned long		*sp_busy_map;	/* running threads */
> >  	struct xarray		sp_thread_xa;
> >  
> >  	/* statistics on pool operation */
> > @@ -191,6 +192,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> >  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
> >  				+ 2 + 1)
> >  
> > +#define RPCSVC_MAXPOOLTHREADS	(4096)
> > +
> >  /*
> >   * The context of a single thread, including the request currently being
> >   * processed.
> > @@ -240,8 +243,7 @@ struct svc_rqst {
> >  #define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
> >  						 * to prevent encrypting page
> >  						 * cache pages */
> > -#define	RQ_BUSY		(5)			/* request is busy */
> > -#define	RQ_DATA		(6)			/* request has data */
> > +#define	RQ_DATA		(5)			/* request has data */
> >  	unsigned long		rq_flags;	/* flags field */
> >  	u32			rq_thread_id;	/* xarray index */
> >  	ktime_t			rq_qtime;	/* enqueue time */
> > diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> > index ea43c6059bdb..c07824a254bf 100644
> > --- a/include/trace/events/sunrpc.h
> > +++ b/include/trace/events/sunrpc.h
> > @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
> >  	svc_rqst_flag(USEDEFERRAL)					\
> >  	svc_rqst_flag(DROPME)						\
> >  	svc_rqst_flag(SPLICE_OK)					\
> > -	svc_rqst_flag(BUSY)						\
> >  	svc_rqst_flag_end(DATA)
> >  
> >  #undef svc_rqst_flag
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 109d7f047385..f6305b66fd28 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> >  		INIT_LIST_HEAD(&pool->sp_sockets);
> >  		spin_lock_init(&pool->sp_lock);
> >  		xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> > +		pool->sp_busy_map =
> > +			bitmap_alloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
> > +					  svc_pool_map_get_node(i));
> > +		if (!pool->sp_busy_map)
> > +			return NULL;
> > +		bitmap_fill(pool->sp_busy_map, RPCSVC_MAXPOOLTHREADS);
> >  
> >  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> >  		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> > @@ -598,6 +604,8 @@ svc_destroy(struct kref *ref)
> >  		percpu_counter_destroy(&pool->sp_threads_no_work);
> >  
> >  		xa_destroy(&pool->sp_thread_xa);
> > +		bitmap_free(pool->sp_busy_map);
> > +		pool->sp_busy_map = NULL;
> >  	}
> >  	kfree(serv->sv_pools);
> >  	kfree(serv);
> > @@ -649,7 +657,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
> >  
> >  	folio_batch_init(&rqstp->rq_fbatch);
> >  
> > -	__set_bit(RQ_BUSY, &rqstp->rq_flags);
> >  	rqstp->rq_server = serv;
> >  	rqstp->rq_pool = pool;
> >  
> > @@ -679,7 +686,7 @@ static struct svc_rqst *
> >  svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
> >  {
> >  	struct xa_limit limit = {
> > -		.max = U32_MAX,
> > +		.max = RPCSVC_MAXPOOLTHREADS,
> >  	};
> >  	struct svc_rqst	*rqstp;
> >  	int ret;
> > @@ -724,12 +731,19 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
> >  					   struct svc_pool *pool)
> >  {
> >  	struct svc_rqst	*rqstp;
> > -	unsigned long index;
> > +	unsigned long bit;
> >  
> > -	xa_for_each(&pool->sp_thread_xa, index, rqstp) {
> > -		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> > +	/* Check the pool's idle bitmap locklessly so that multiple
> > +	 * idle searches can proceed concurrently.
> > +	 */
> > +	for_each_clear_bit(bit, pool->sp_busy_map, pool->sp_nrthreads) {
> > +		if (test_and_set_bit(bit, pool->sp_busy_map))
> >  			continue;
> > 
> > 
> 
> I wonder if we also need to set the sp_busy_map bit when we're trying to
> shrink the threadpool? It seems like the code above that is trying to
> find a thread to do work could race with the task being killed, such
> that we try to take up a task that is no longer functional.

What I /think/ will happen is that while svc_pool_victim() is
holding the xa_lock, it will remove the rqst from the xarray.

Then when svc_pool_wake_idle_thread() calls xa_load(), it should
get a NULL, and treat that like a pool that doesn't have an
available thread to wake.


> > +		rqstp = xa_load(&pool->sp_thread_xa, bit);
> > +		if (!rqstp)
> > +			break;
> > +
> >  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> >  		wake_up_process(rqstp->rq_task);
> >  		percpu_counter_inc(&pool->sp_threads_woken);
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index db40f771b60a..f9c9babe0cba 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -735,6 +735,21 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  	return true;
> >  }
> >  
> > +static void svc_pool_thread_mark_idle(struct svc_pool *pool,
> > +				      struct svc_rqst *rqstp)
> > +{
> > +	clear_bit_unlock(rqstp->rq_thread_id, pool->sp_busy_map);
> > +}
> > +
> > +/*
> > + * Note: If we were awoken, then this rqstp has already been marked busy.
> > + */
> > +static void svc_pool_thread_mark_busy(struct svc_pool *pool,
> > +				      struct svc_rqst *rqstp)
> > +{
> > +	test_and_set_bit_lock(rqstp->rq_thread_id, pool->sp_busy_map);
> > +}
> > +
> >  static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
> >  {
> >  	struct svc_pool		*pool = rqstp->rq_pool;
> > @@ -756,18 +771,17 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
> >  	set_current_state(TASK_INTERRUPTIBLE);
> >  	smp_mb__before_atomic();
> >  	clear_bit(SP_CONGESTED, &pool->sp_flags);
> > -	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> > -	smp_mb__after_atomic();
> >  
> > -	if (likely(rqst_should_sleep(rqstp)))
> > +	if (likely(rqst_should_sleep(rqstp))) {
> > +		svc_pool_thread_mark_idle(pool, rqstp);
> >  		time_left = schedule_timeout(timeout);
> > -	else
> > +	} else
> >  		__set_current_state(TASK_RUNNING);
> >  
> >  	try_to_freeze();
> >  
> > -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> > -	smp_mb__after_atomic();
> > +	svc_pool_thread_mark_busy(pool, rqstp);
> > +
> >  	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> >  	if (rqstp->rq_xprt) {
> >  		trace_svc_pool_awoken(rqstp);
> > 
> > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
