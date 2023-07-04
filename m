Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6284746700
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jul 2023 03:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGDBwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 21:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjGDBwm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 21:52:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177C7E4E
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jul 2023 18:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 925D36105A
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jul 2023 01:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711F3C433C8;
        Tue,  4 Jul 2023 01:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688435560;
        bh=0Gam63GHx4K0gEjASNZVmNr+LTcOv4AXvmNaJ9E6DvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cP1mjq/tO+aV+90+GBNlA4pwCx5pGF3LpELTMVt+rF9ePcsuywFxY4NfiwU3/t+sV
         OI6aTxSB5Li7EsSlt4PlvacBs5bmcBrWWaQORGbg9TFJ8MGg0n9nASPEiybvE0QUGE
         qRxsHjt+TQohD0+L59EaEh8vUdD02wZFYXaw++Q3I98DBhdJdSisS/1HpyIYyrfmms
         K5/JLcyFfGaTzM2Q8X/51DOUMiAgK4m8q0OfSWajjPJ3Rq29pRHMap4pM9ertU3OTq
         hSiAhdOqtDsZd8UOc25k1qlpo41IjvRM1fvhTxiPlg8bI9AJmeCbnrufga326tvaDm
         QBtpG4vahWFng==
Date:   Mon, 3 Jul 2023 21:52:37 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH v2 8/9] SUNRPC: Replace sp_threads_all with an xarray
Message-ID: <ZKN7ZT8XwUQP0OBW@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842930220.139194.2628840255224609992.stgit@manet.1015granger.net>
 <168843311716.8939.12802231528437837606@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168843311716.8939.12802231528437837606@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 04, 2023 at 11:11:57AM +1000, NeilBrown wrote:
> On Tue, 04 Jul 2023, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > We want a thread lookup operation that can be done with RCU only,
> > but also we want to avoid the linked-list walk, which does not scale
> > well in the number of pool threads.
> > 
> > BH-disabled locking is no longer necessary because we're no longer
> > sharing the pool's sp_lock to protect either the xarray or the
> > pool's thread count. sp_lock also protects transport activity. There
> > are no callers of svc_set_num_threads() that run outside of process
> > context.
> > 
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/nfssvc.c              |    3 +-
> >  include/linux/sunrpc/svc.h    |   11 +++----
> >  include/trace/events/sunrpc.h |   47 ++++++++++++++++++++++++++++-
> >  net/sunrpc/svc.c              |   67 ++++++++++++++++++++++++-----------------
> >  net/sunrpc/svc_xprt.c         |    2 +
> >  5 files changed, 93 insertions(+), 37 deletions(-)
> > 
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 2154fa63c5f2..d42b2a40c93c 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -62,8 +62,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
> >   * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point to a
> >   * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
> >   * nn->keep_active is set).  That number of nfsd threads must
> > - * exist and each must be listed in ->sp_all_threads in some entry of
> > - * ->sv_pools[].
> > + * exist and each must be listed in some entry of ->sv_pools[].
> >   *
> >   * Each active thread holds a counted reference on nn->nfsd_serv, as does
> >   * the nn->keep_active flag and various transient calls to svc_get().
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index 74ea13270679..6f8bfcd44250 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -32,10 +32,10 @@
> >   */
> >  struct svc_pool {
> >  	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
> > -	spinlock_t		sp_lock;	/* protects all fields */
> > +	spinlock_t		sp_lock;	/* protects sp_sockets */
> >  	struct list_head	sp_sockets;	/* pending sockets */
> >  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> > -	struct list_head	sp_all_threads;	/* all server threads */
> > +	struct xarray		sp_thread_xa;
> >  
> >  	/* statistics on pool operation */
> >  	struct percpu_counter	sp_messages_arrived;
> > @@ -195,7 +195,6 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
> >   * processed.
> >   */
> >  struct svc_rqst {
> > -	struct list_head	rq_all;		/* all threads list */
> >  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
> >  	struct svc_xprt *	rq_xprt;	/* transport ptr */
> >  
> > @@ -240,10 +239,10 @@ struct svc_rqst {
> >  #define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
> >  						 * to prevent encrypting page
> >  						 * cache pages */
> > -#define	RQ_VICTIM	(5)			/* about to be shut down */
> > -#define	RQ_BUSY		(6)			/* request is busy */
> > -#define	RQ_DATA		(7)			/* request has data */
> > +#define	RQ_BUSY		(5)			/* request is busy */
> > +#define	RQ_DATA		(6)			/* request has data */
> >  	unsigned long		rq_flags;	/* flags field */
> > +	u32			rq_thread_id;	/* xarray index */
> >  	ktime_t			rq_qtime;	/* enqueue time */
> >  
> >  	void *			rq_argp;	/* decoded arguments */
> > diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> > index 60c8e03268d4..ea43c6059bdb 100644
> > --- a/include/trace/events/sunrpc.h
> > +++ b/include/trace/events/sunrpc.h
> > @@ -1676,7 +1676,6 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
> >  	svc_rqst_flag(USEDEFERRAL)					\
> >  	svc_rqst_flag(DROPME)						\
> >  	svc_rqst_flag(SPLICE_OK)					\
> > -	svc_rqst_flag(VICTIM)						\
> >  	svc_rqst_flag(BUSY)						\
> >  	svc_rqst_flag_end(DATA)
> >  
> > @@ -2118,6 +2117,52 @@ TRACE_EVENT(svc_pool_starved,
> >  	)
> >  );
> >  
> > +DECLARE_EVENT_CLASS(svc_thread_lifetime_class,
> > +	TP_PROTO(
> > +		const struct svc_serv *serv,
> > +		const struct svc_pool *pool,
> > +		const struct svc_rqst *rqstp
> > +	),
> > +
> > +	TP_ARGS(serv, pool, rqstp),
> > +
> > +	TP_STRUCT__entry(
> > +		__string(name, serv->sv_name)
> > +		__field(int, pool_id)
> > +		__field(unsigned int, nrthreads)
> > +		__field(unsigned long, pool_flags)
> > +		__field(u32, thread_id)
> > +		__field(const void *, rqstp)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__assign_str(name, serv->sv_name);
> > +		__entry->pool_id = pool->sp_id;
> > +		__entry->nrthreads = pool->sp_nrthreads;
> > +		__entry->pool_flags = pool->sp_flags;
> > +		__entry->thread_id = rqstp->rq_thread_id;
> > +		__entry->rqstp = rqstp;
> > +	),
> > +
> > +	TP_printk("service=%s pool=%d pool_flags=%s nrthreads=%u thread_id=%u",
> > +		__get_str(name), __entry->pool_id,
> > +		show_svc_pool_flags(__entry->pool_flags),
> > +		__entry->nrthreads, __entry->thread_id
> > +	)
> > +);
> > +
> > +#define DEFINE_SVC_THREAD_LIFETIME_EVENT(name) \
> > +	DEFINE_EVENT(svc_thread_lifetime_class, svc_pool_##name, \
> > +			TP_PROTO( \
> > +				const struct svc_serv *serv, \
> > +				const struct svc_pool *pool, \
> > +				const struct svc_rqst *rqstp \
> > +			), \
> > +			TP_ARGS(serv, pool, rqstp))
> > +
> > +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_init);
> > +DEFINE_SVC_THREAD_LIFETIME_EVENT(thread_exit);
> > +
> >  DECLARE_EVENT_CLASS(svc_xprt_event,
> >  	TP_PROTO(
> >  		const struct svc_xprt *xprt
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 9b6701a38e71..ef350f0d8925 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -507,8 +507,8 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
> >  
> >  		pool->sp_id = i;
> >  		INIT_LIST_HEAD(&pool->sp_sockets);
> > -		INIT_LIST_HEAD(&pool->sp_all_threads);
> >  		spin_lock_init(&pool->sp_lock);
> > +		xa_init_flags(&pool->sp_thread_xa, XA_FLAGS_ALLOC);
> >  
> >  		percpu_counter_init(&pool->sp_messages_arrived, 0, GFP_KERNEL);
> >  		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> > @@ -594,6 +594,8 @@ svc_destroy(struct kref *ref)
> >  		percpu_counter_destroy(&pool->sp_threads_woken);
> >  		percpu_counter_destroy(&pool->sp_threads_timedout);
> >  		percpu_counter_destroy(&pool->sp_threads_starved);
> > +
> > +		xa_destroy(&pool->sp_thread_xa);
> >  	}
> >  	kfree(serv->sv_pools);
> >  	kfree(serv);
> > @@ -674,7 +676,11 @@ EXPORT_SYMBOL_GPL(svc_rqst_alloc);
> >  static struct svc_rqst *
> >  svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
> >  {
> > +	static const struct xa_limit limit = {
> > +		.max = U32_MAX,
> > +	};
> >  	struct svc_rqst	*rqstp;
> > +	int ret;
> >  
> >  	rqstp = svc_rqst_alloc(serv, pool, node);
> >  	if (!rqstp)
> > @@ -685,15 +691,25 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
> >  	serv->sv_nrthreads += 1;
> >  	spin_unlock_bh(&serv->sv_lock);
> >  
> > -	spin_lock_bh(&pool->sp_lock);
> > +	xa_lock(&pool->sp_thread_xa);
> > +	ret = __xa_alloc(&pool->sp_thread_xa, &rqstp->rq_thread_id, rqstp,
> > +			 limit, GFP_KERNEL);
> > +	if (ret) {
> > +		xa_unlock(&pool->sp_thread_xa);
> > +		goto out_free;
> > +	}
> >  	pool->sp_nrthreads++;
> > -	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
> > -	spin_unlock_bh(&pool->sp_lock);
> > +	xa_unlock(&pool->sp_thread_xa);
> > +	trace_svc_pool_thread_init(serv, pool, rqstp);
> >  	return rqstp;
> > +
> > +out_free:
> > +	svc_rqst_free(rqstp);
> > +	return ERR_PTR(ret);
> >  }
> >  
> >  /**
> > - * svc_pool_wake_idle_thread - wake an idle thread in @pool
> > + * svc_pool_wake_idle_thread - Find and wake an idle thread in @pool
> >   * @serv: RPC service
> >   * @pool: service thread pool
> >   *
> > @@ -706,19 +722,17 @@ struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
> >  					   struct svc_pool *pool)
> >  {
> >  	struct svc_rqst	*rqstp;
> > +	unsigned long index;
> >  
> > -	rcu_read_lock();
> > -	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> > +	xa_for_each(&pool->sp_thread_xa, index, rqstp) {
> >  		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> >  			continue;
> >  
> > -		rcu_read_unlock();
> >  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> >  		wake_up_process(rqstp->rq_task);
> >  		percpu_counter_inc(&pool->sp_threads_woken);
> >  		return rqstp;
> >  	}
> > -	rcu_read_unlock();
> >  
> >  	trace_svc_pool_starved(serv, pool);
> >  	percpu_counter_inc(&pool->sp_threads_starved);
> > @@ -734,32 +748,31 @@ svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
> >  static struct task_struct *
> >  svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
> >  {
> > -	unsigned int i;
> >  	struct task_struct *task = NULL;
> > +	struct svc_rqst *rqstp;
> > +	unsigned long zero = 0;
> > +	unsigned int i;
> >  
> >  	if (pool != NULL) {
> > -		spin_lock_bh(&pool->sp_lock);
> > +		xa_lock(&pool->sp_thread_xa);
> >  	} else {
> >  		for (i = 0; i < serv->sv_nrpools; i++) {
> >  			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
> > -			spin_lock_bh(&pool->sp_lock);
> > -			if (!list_empty(&pool->sp_all_threads))
> > +			xa_lock(&pool->sp_thread_xa);
> > +			if (!xa_empty(&pool->sp_thread_xa))
> >  				goto found_pool;
> > -			spin_unlock_bh(&pool->sp_lock);
> > +			xa_unlock(&pool->sp_thread_xa);
> >  		}
> >  		return NULL;
> >  	}
> >  
> >  found_pool:
> > -	if (!list_empty(&pool->sp_all_threads)) {
> > -		struct svc_rqst *rqstp;
> > -
> > -		rqstp = list_entry(pool->sp_all_threads.next, struct svc_rqst, rq_all);
> > -		set_bit(RQ_VICTIM, &rqstp->rq_flags);
> > -		list_del_rcu(&rqstp->rq_all);
> > +	rqstp = xa_find(&pool->sp_thread_xa, &zero, U32_MAX, XA_PRESENT);
> > +	if (rqstp) {
> > +		__xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
> 
> This bothers me.  We always delete the earliest thread in the xarray.
> So if we create 128 threads, then reduce the number to 64, the remaining
> threads will be numbers 128 to 256.
> This means searching in the bitmap will be (slightly) slower than
> necessary.
> 
> xa doesn't have a "find last" interface, but we "know" how many entries
> are in the array - or we would if we decremented the counter when we
> removed an entry.
> Currently we only decrement the counter when the thread exits - at which
> time it is removed the entry - which may already have been removed.
> If we change that code to check if it is still present in the xarray and
> to only erase/decrement if it is, then we can decrement the counter here
> and always reliably be able to find the "last" entry.
> 
> ... though I think we wait for a thread to exist before finding the next
>     victim, so maybe all we need to do is start the xa_find from
>     ->sp_nrthreads-1 rather than from zero ??
> 
> Is it worth it?  I don't know.  But it bothers me.

Well it would be straightforward to change the "pool_wake_idle_thread"
search into a find_next_bit over a range. Store the lowest thread_id
in the svc_pool and use that as the starting point for the loop.


> NeilBrown
> 
> 
> >  		task = rqstp->rq_task;
> >  	}
> > -	spin_unlock_bh(&pool->sp_lock);
> > +	xa_unlock(&pool->sp_thread_xa);
> >  	return task;
> >  }
> >  
> > @@ -841,9 +854,9 @@ svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
> >  	if (pool == NULL) {
> >  		nrservs -= serv->sv_nrthreads;
> >  	} else {
> > -		spin_lock_bh(&pool->sp_lock);
> > +		xa_lock(&pool->sp_thread_xa);
> >  		nrservs -= pool->sp_nrthreads;
> > -		spin_unlock_bh(&pool->sp_lock);
> > +		xa_unlock(&pool->sp_thread_xa);
> >  	}
> >  
> >  	if (nrservs > 0)
> > @@ -930,11 +943,11 @@ svc_exit_thread(struct svc_rqst *rqstp)
> >  	struct svc_serv	*serv = rqstp->rq_server;
> >  	struct svc_pool	*pool = rqstp->rq_pool;
> >  
> > -	spin_lock_bh(&pool->sp_lock);
> > +	xa_lock(&pool->sp_thread_xa);
> >  	pool->sp_nrthreads--;
> > -	if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
> > -		list_del_rcu(&rqstp->rq_all);
> > -	spin_unlock_bh(&pool->sp_lock);
> > +	__xa_erase(&pool->sp_thread_xa, rqstp->rq_thread_id);
> > +	xa_unlock(&pool->sp_thread_xa);
> > +	trace_svc_pool_thread_exit(serv, pool, rqstp);
> >  
> >  	spin_lock_bh(&serv->sv_lock);
> >  	serv->sv_nrthreads -= 1;
> > diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> > index 8ced7591ce07..7709120b45c1 100644
> > --- a/net/sunrpc/svc_xprt.c
> > +++ b/net/sunrpc/svc_xprt.c
> > @@ -46,7 +46,7 @@ static LIST_HEAD(svc_xprt_class_list);
> >  
> >  /* SMP locking strategy:
> >   *
> > - *	svc_pool->sp_lock protects most of the fields of that pool.
> > + *	svc_pool->sp_lock protects sp_sockets.
> >   *	svc_serv->sv_lock protects sv_tempsocks, sv_permsocks, sv_tmpcnt.
> >   *	when both need to be taken (rare), svc_serv->sv_lock is first.
> >   *	The "service mutex" protects svc_serv->sv_nrthread.
> > 
> > 
> > 
> 
