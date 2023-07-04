Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C14746717
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 04:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjGDCDG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 22:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjGDCC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 22:02:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234110C7
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 19:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AC2E6106C
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 02:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C0BC433C8;
        Tue,  4 Jul 2023 02:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688436169;
        bh=CXFIL4N513DbhI27syorCSjY+Mq+7vxdgUn7Q09Af0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+PHd/yuBWJ5sEezwvo6mUX08JBlRE2nhCewtKdErCpMlgl4S77KNJEAiViWuHBNG
         PiCpXKBJLQKjUyonYClczRM5FutFsV5w2E6iJ5OQewKw8mQuph+JM+4rQER2JfdjcF
         RB6Du8LoNC+YNnrC4XM+gzS5WsbKvC7k8CIaH0CnCct5D4HrQSxAALN7eMHNxvILLY
         jvSzpeswqipFWwhGSoEq5s1WCX3FS1AKgytR4CP2oXMOjQhWSvSPqlTYNnEJSy+OGu
         zge7Zc6IU5AKP47kqCkr3kQdpa2Y9BEg/3I3pyCY9uhuY8Duco+txfHVnmE/cB/qD5
         Ni9wgveBNOvzA==
Date:   Mon, 3 Jul 2023 22:02:46 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 9/9] SUNRPC: Convert RQ_BUSY into a per-pool bitmap
Message-ID: <ZKN9xmRn+EN/TQwY@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842930872.139194.10164846167275218299.stgit@manet.1015granger.net>
 <168843398253.8939.16982425023664424215@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168843398253.8939.16982425023664424215@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 04, 2023 at 11:26:22AM +1000, NeilBrown wrote:
> On Tue, 04 Jul 2023, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > I've noticed that client-observed server request latency goes up
> > simply when the nfsd thread count is increased.
> > 
> > List walking is known to be memory-inefficient. On a busy server
> > with many threads, enqueuing a transport will walk the "all threads"
> > list quite frequently. This also pulls in the cache lines for some
> > hot fields in each svc_rqst (namely, rq_flags).
> 
> I think this text could usefully be re-written.  By this point in the
> series we aren't list walking.
> 
> I'd also be curious to know what latency different you get for just this
> change.

Not much of a latency difference at lower thread counts.

The difference I notice is that with the spinlock version of
pool_wake_idle_thread, there is significant lock contention as
the thread count increases, and the throughput result of my fio
test is lower (outside the result variance).


> > The svc_xprt_enqueue() call that concerns me most is the one in
> > svc_rdma_wc_receive(), which is single-threaded per CQ. Slowing
> > down completion handling limits the total throughput per RDMA
> > connection.
> > 
> > So, avoid walking the "all threads" list to find an idle thread to
> > wake. Instead, set up an idle bitmap and use find_next_bit, which
> > should work the same way as RQ_BUSY but it will touch only the
> > cachelines that the bitmap is in. Stick with atomic bit operations
> > to avoid taking the pool lock.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  include/linux/sunrpc/svc.h    |    6 ++++--
> >  include/trace/events/sunrpc.h |    1 -
> >  net/sunrpc/svc.c              |   27 +++++++++++++++++++++------
> >  net/sunrpc/svc_xprt.c         |   30 ++++++++++++++++++++++++------
> >  4 files changed, 49 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 6f8bfcd44250..27ffcf7371d0 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -35,6 +35,7 @@ struct svc_pool {
> >  	spinlock_t		sp_lock;	/* protects sp_sockets */
> >  	struct list_head	sp_sockets;	/* pending sockets */
> >  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > +	unsigned long		*sp_idle_map;	/* idle threads */
> >  	struct xarray		sp_thread_xa;
> >  
> >  	/* statistics on pool operation */
> > @@ -190,6 +191,8 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> >  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
> >  				+ 2 + 1)
> >  
> > +#define RPCSVC_MAXPOOLTHREADS	(4096)
> > +
> >  /*
> >   * The context of a single thread, including the request currently being
> >   * processed.
> > @@ -239,8 +242,7 @@ struct svc_rqst {
> >  #define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
> >  						 * to prevent encrypting page
> >  						 * cache pages */
> > -#define	RQ_BUSY		(5)			/* request is busy */
> > -#define	RQ_DATA		(6)			/* request has data */
> > +#define	RQ_DATA		(5)			/* request has data */
> 
> Might this be a good opportunity to convert this to an enum ??
> 
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
> > index ef350f0d8925..d0278e5190ba 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -509,6 +509,12 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> >  		INIT_LIST_HEAD(&pool->sp_sockets);
> >  		spin_lock_init(&pool->sp_lock);
> >  		xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> > +		/* All threads initially marked "busy" */
> > +		pool->sp_idle_map =
> > +			bitmap_zalloc_node(RPCSVC_MAXPOOLTHREADS, GFP_KERNEL,
> > +					   svc_pool_map_get_node(i));
> > +		if (!pool->sp_idle_map)
> > +			return NULL;
> >  
> >  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> >  		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> > @@ -596,6 +602,8 @@ svc_destroy(struct kref *ref)
> >  		percpu_counter_destroy(&pool->sp_threads_starved);
> >  
> >  		xa_destroy(&pool->sp_thread_xa);
> > +		bitmap_free(pool->sp_idle_map);
> > +		pool->sp_idle_map = NULL;
> >  	}
> >  	kfree(serv->sv_pools);
> >  	kfree(serv);
> > @@ -647,7 +655,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
> >  
> >  	folio_batch_init(&rqstp->rq_fbatch);
> >  
> > -	__set_bit(RQ_BUSY, &rqstp->rq_flags);
> >  	rqstp->rq_server = serv;
> >  	rqstp->rq_pool = pool;
> >  
> > @@ -677,7 +684,7 @@ static struct svc_rqst *
> >  svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
> >  {
> >  	static const struct xa_limit limit = {
> > -		.max = U32_MAX,
> > +		.max = RPCSVC_MAXPOOLTHREADS,
> >  	};
> >  	struct svc_rqst	*rqstp;
> >  	int ret;
> > @@ -722,12 +729,19 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
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
> > +	for_each_set_bit(bit, pool->sp_idle_map, pool->sp_nrthreads) {
> > +		if (!test_and_clear_bit(bit, pool->sp_idle_map))
> >  			continue;
> 
> I would really rather the map was "sp_busy_map". (initialised with bitmap_fill())
> Then you could "test_and_set_bit_lock()" and later "clear_bit_unlock()"
> and so get all the required memory barriers.
> What we are doing here is locking a particular thread for a task, so
> "lock" is an appropriate description of what is happening.
> See also svc_pool_thread_mark_* below.
> 
> >  
> > +		rqstp = xa_load(&pool->sp_thread_xa, bit);
> > +		if (!rqstp)
> > +			break;
> > +
> >  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> >  		wake_up_process(rqstp->rq_task);
> >  		percpu_counter_inc(&pool->sp_threads_woken);
> > @@ -767,7 +781,8 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *stat
> >  	}
> >  
> >  found_pool:
> > -	rqstp = xa_find(&pool->sp_thread_xa, &zero, U32_MAX, XA_PRESENT);
> > +	rqstp = xa_find(&pool->sp_thread_xa, &zero, RPCSVC_MAXPOOLTHREADS,
> > +			XA_PRESENT);
> >  	if (rqstp) {
> >  		__xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
> >  		task = rqstp->rq_task;
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 7709120b45c1..2844b32c16ea 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -735,6 +735,25 @@ rqst_should_sleep(struct svc_rqst *rqstp)
> >  	return true;
> >  }
> >  
> > +static void svc_pool_thread_mark_idle(struct svc_pool *pool,
> > +				      struct svc_rqst *rqstp)
> > +{
> > +	smp_mb__before_atomic();
> > +	set_bit(rqstp->rq_thread_id, pool->sp_idle_map);
> > +	smp_mb__after_atomic();
> > +}
> 
> There memory barriers above and below bother me.  There is no comment
> telling me what they are protecting against.
> I would rather svc_pool_thread_mark_idle - which unlocks the thread -
> were
> 
>     clear_bit_unlock(rqstp->rq_thread_id, pool->sp_busy_map);
> 
> and  that svc_pool_thread_mark_busy were
> 
>    test_and_set_bit_lock(rqstp->rq_thread_id, pool->sp_busy_map);
> 
> Then it would be more obvious what was happening.

Not obvious to me, but that's very likely because I'm not clear what
clear_bit_unlock() does. :-)

I'll try this change for the next version of the series.


> Thanks,
> NeilBrown
> 
> > +
> > +/*
> > + * Note: If we were awoken, then this rqstp has already been marked busy.
> > + */
> > +static void svc_pool_thread_mark_busy(struct svc_pool *pool,
> > +				      struct svc_rqst *rqstp)
> > +{
> > +	smp_mb__before_atomic();
> > +	clear_bit(rqstp->rq_thread_id, pool->sp_idle_map);
> > +	smp_mb__after_atomic();
> > +}
> > +
> >  static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
> >  {
> >  	struct svc_pool		*pool = rqstp->rq_pool;
> > @@ -756,18 +775,17 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
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
> > 
> 
