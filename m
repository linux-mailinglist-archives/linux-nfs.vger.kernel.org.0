Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F174DAEF
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jul 2023 18:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbjGJQWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjGJQVs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 12:21:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BEC12B
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 09:21:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB7C161072
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 16:21:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7421AC433C7;
        Mon, 10 Jul 2023 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689006103;
        bh=o+YldJw1ZRKip3zha1Ij+EtkAGKIDHDYwuhJyG8+VPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueJyDOVpI5s15YxVOyuzKxRrzNowuADmNlG5C9Lr0Atq0RU8DEDTl9GlCeygGV8bU
         rNZEmmFwBUkk3z846LbB8poVb72Ic5vzGNMA7pMsxFHqCKoxcqZ+PweJB/iACIpBtT
         qs8xHDQfrzUv6Yoj3lrRl1Y5Sy6WXEYC3a9YMTGARXJdkEHGXTstrKiwzjFYMkWmtm
         ySCBKCHxifW3S1fO/M1buXhTV89cVM1ZkT0GdfLXfeZ6Z8Ta5YwnLYYGgM1pV5/uk4
         XXUoEYYVSplvLlfNFAvOown0mL5wYxkg7PcuGRE51wk+iQddAAv9Sg8hdJTP4iErfU
         5Ar5Nb7dV/+4w==
Date:   Mon, 10 Jul 2023 12:21:40 -0400
From:   Chuck Lever <cel@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        lorenzo@kernel.org, jlayton@redhat.com, david@fromorbit.com
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
Message-ID: <ZKwwFNeTw60Wuo+K@manet.1015granger.net>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168894969894.8939.6993305724636717703@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 10, 2023 at 10:41:38AM +1000, NeilBrown wrote:
> 
> The patch show an alternate approach to the recent patches which improve
> the latency for waking an idle thread when work is ready.
> 
> The current approach involves searching a linked list for an idle thread
> to wake.  The recent patches instead use a bitmap search to find the
> idle thread.  With this patch no search is needed - and idle thread is
> directly available without searching.
> 
> The idle threads are kept in an "llist" - there is no longer a list of
> all threads.
> 
> The llist ADT does not allow concurrent delete_first operations, so to
> wake an idle thread we simply wake it and do not remove it from the
> list.
> When the thread is scheduled it will remove itself - which is safe - and
> will take the next thread if there is more work to do (and if there is
> another thread).
> 
> The "remove itself" requires and addition to the llist api.
> "llist_del_first_this()" removes a given item if is it the first.
> Multiple callers can call this concurrently as along as they each give a
> different "this", so each thread can safely try to remove itself.  It
> must be prepared for failure.
> 
> Reducing the thread count currently requires finding any thing, idle or
> not, and calling kthread_stop().  This no longer possible as we don't
> have a list of all threads (though I guess we could keep the list if we
> wanted to...).  Instead the pool is marked NEED_VICTIM and the next
> thread to go idle will become the VICTIM and duly exit - signalling
> this be clearing VICTIM_REMAINS.  We replace kthread_should_stop() call
> with a new svc_should_stop() which checks and sets victim flags.
> 
> nfsd threads can currently be told to exit with a signal.  It might be
> time to deprecate/remove this feature.  However this patch does support
> it.
> 
> If the signalled thread is not at the head of the idle list it cannot
> remove itself.  In this case it sets RQ_CLEAN_ME and SP_CLEANUP and the
> next thread to wake up will use llist_del_all_this() to remove all
> threads from the idle list.  It then finds and removes any RQ_CLEAN_ME
> threads and puts the rest back on the list.
> 
> There is quite a bit of churn here so it will need careful testing.
> In fact - it doesn't handle nfsv4 callback handling threads properly as
> they don't wait the same way that other threads wait...  I'll need to
> think about that but I don't have time just now.
> 
> For now it is primarily an RFC.  I haven't given a lot of thought to
> trace points.
> 
> It apply it you will need
> 
>  SUNRPC: Deduplicate thread wake-up code
>  SUNRPC: Report when no service thread is available.
>  SUNRPC: Split the svc_xprt_dequeue tracepoint
>  SUNRPC: Clean up svc_set_num_threads
>  SUNRPC: Replace dprintk() call site in __svc_create()
> 
> from recent post by Chuck.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/lockd/svc.c                |   4 +-
>  fs/lockd/svclock.c            |   4 +-
>  fs/nfs/callback.c             |   5 +-
>  fs/nfsd/nfssvc.c              |   3 +-
>  include/linux/llist.h         |   4 +
>  include/linux/lockd/lockd.h   |   2 +-
>  include/linux/sunrpc/svc.h    |  55 +++++++++-----
>  include/trace/events/sunrpc.h |   7 +-
>  lib/llist.c                   |  51 +++++++++++++
>  net/sunrpc/svc.c              | 139 ++++++++++++++++++++++++----------
>  net/sunrpc/svc_xprt.c         |  61 ++++++++-------
>  11 files changed, 239 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 22d3ff3818f5..df295771bd40 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -147,7 +147,7 @@ lockd(void *vrqstp)
>  	 * The main request loop. We don't terminate until the last
>  	 * NFS mount or NFS daemon has gone away.
>  	 */
> -	while (!kthread_should_stop()) {
> +	while (!svc_should_stop(rqstp)) {
>  		long timeout = MAX_SCHEDULE_TIMEOUT;
>  		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
>  
> @@ -160,7 +160,7 @@ lockd(void *vrqstp)
>  			continue;
>  		}
>  
> -		timeout = nlmsvc_retry_blocked();
> +		timeout = nlmsvc_retry_blocked(rqstp);
>  
>  		/*
>  		 * Find a socket with data available and call its
> diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
> index c43ccdf28ed9..54b679fcbcab 100644
> --- a/fs/lockd/svclock.c
> +++ b/fs/lockd/svclock.c
> @@ -1009,13 +1009,13 @@ retry_deferred_block(struct nlm_block *block)
>   * be retransmitted.
>   */
>  unsigned long
> -nlmsvc_retry_blocked(void)
> +nlmsvc_retry_blocked(struct svc_rqst *rqstp)
>  {
>  	unsigned long	timeout = MAX_SCHEDULE_TIMEOUT;
>  	struct nlm_block *block;
>  
>  	spin_lock(&nlm_blocked_lock);
> -	while (!list_empty(&nlm_blocked) && !kthread_should_stop()) {
> +	while (!list_empty(&nlm_blocked) && !svc_should_stop(rqstp)) {
>  		block = list_entry(nlm_blocked.next, struct nlm_block, b_list);
>  
>  		if (block->b_when == NLM_NEVER)
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 456af7d230cf..646425f1dc36 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -111,7 +111,7 @@ nfs41_callback_svc(void *vrqstp)
>  
>  	set_freezable();
>  
> -	while (!kthread_freezable_should_stop(NULL)) {
> +	while (!svc_should_stop(rqstp)) {
>  
>  		if (signal_pending(current))
>  			flush_signals(current);
> @@ -130,10 +130,11 @@ nfs41_callback_svc(void *vrqstp)
>  				error);
>  		} else {
>  			spin_unlock_bh(&serv->sv_cb_lock);
> -			if (!kthread_should_stop())
> +			if (!svc_should_stop(rqstp))
>  				schedule();
>  			finish_wait(&serv->sv_cb_waitq, &wq);
>  		}
> +		try_to_freeze();
>  	}
>  
>  	svc_exit_thread(rqstp);
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 9c7b1ef5be40..7cfa7f2e9bf7 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -62,8 +62,7 @@ static __be32			nfsd_init_request(struct svc_rqst *,
>   * If (out side the lock) nn->nfsd_serv is non-NULL, then it must point to a
>   * properly initialised 'struct svc_serv' with ->sv_nrthreads > 0 (unless
>   * nn->keep_active is set).  That number of nfsd threads must
> - * exist and each must be listed in ->sp_all_threads in some entry of
> - * ->sv_pools[].
> + * exist.
>   *
>   * Each active thread holds a counted reference on nn->nfsd_serv, as does
>   * the nn->keep_active flag and various transient calls to svc_get().
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 85bda2d02d65..5a22499844c8 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -248,6 +248,10 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
>  }
>  
>  extern struct llist_node *llist_del_first(struct llist_head *head);
> +extern struct llist_node *llist_del_first_this(struct llist_head *head,
> +					       struct llist_node *this);
> +extern struct llist_node *llist_del_all_this(struct llist_head *head,
> +					     struct llist_node *this);
>  
>  struct llist_node *llist_reverse_order(struct llist_node *head);
>  
> diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
> index f42594a9efe0..c48020e7ee08 100644
> --- a/include/linux/lockd/lockd.h
> +++ b/include/linux/lockd/lockd.h
> @@ -280,7 +280,7 @@ __be32		  nlmsvc_testlock(struct svc_rqst *, struct nlm_file *,
>  			struct nlm_host *, struct nlm_lock *,
>  			struct nlm_lock *, struct nlm_cookie *);
>  __be32		  nlmsvc_cancel_blocked(struct net *net, struct nlm_file *, struct nlm_lock *);
> -unsigned long	  nlmsvc_retry_blocked(void);
> +unsigned long	  nlmsvc_retry_blocked(struct svc_rqst *rqstp);
>  void		  nlmsvc_traverse_blocks(struct nlm_host *, struct nlm_file *,
>  					nlm_host_match_fn_t match);
>  void		  nlmsvc_grant_reply(struct nlm_cookie *, __be32);
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 366f2b6b689c..cb2497b977c1 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -31,11 +31,11 @@
>   * node traffic on multi-node NUMA NFS servers.
>   */
>  struct svc_pool {
> -	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
> -	spinlock_t		sp_lock;	/* protects all fields */
> +	unsigned int		sp_id;		/* pool id; also node id on NUMA */
> +	spinlock_t		sp_lock;	/* protects all sp_socketsn sp_nrthreads*/
>  	struct list_head	sp_sockets;	/* pending sockets */
>  	unsigned int		sp_nrthreads;	/* # of threads in pool */
> -	struct list_head	sp_all_threads;	/* all server threads */
> +	struct llist_head	sp_idle_threads;/* idle server threads */

Actually... Lorenzo reminded me that we need to retain a mechanism
that can iterate through all the threads in a pool. The xarray
replaces the "all_threads" list in this regard.


>  	/* statistics on pool operation */
>  	struct percpu_counter	sp_sockets_queued;
> @@ -43,12 +43,17 @@ struct svc_pool {
>  	struct percpu_counter	sp_threads_timedout;
>  	struct percpu_counter	sp_threads_starved;
>  
> -#define	SP_TASK_PENDING		(0)		/* still work to do even if no
> -						 * xprt is queued. */
> -#define SP_CONGESTED		(1)
>  	unsigned long		sp_flags;
>  } ____cacheline_aligned_in_smp;
>  
> +enum svc_sp_flags {
> +	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
> +	SP_CONGESTED,
> +	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
> +	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
> +	SP_CLEANUP,		/* A thread has set RQ_CLEAN_ME */
> +};
> +
>  /*
>   * RPC service.
>   *
> @@ -195,7 +200,7 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>   * processed.
>   */
>  struct svc_rqst {
> -	struct list_head	rq_all;		/* all threads list */
> +	struct llist_node	rq_idle;	/* On pool's idle list */
>  	struct rcu_head		rq_rcu_head;	/* for RCU deferred kfree */
>  	struct svc_xprt *	rq_xprt;	/* transport ptr */
>  
> @@ -233,16 +238,6 @@ struct svc_rqst {
>  	u32			rq_proc;	/* procedure number */
>  	u32			rq_prot;	/* IP protocol */
>  	int			rq_cachetype;	/* catering to nfsd */
> -#define	RQ_SECURE	(0)			/* secure port */
> -#define	RQ_LOCAL	(1)			/* local request */
> -#define	RQ_USEDEFERRAL	(2)			/* use deferral */
> -#define	RQ_DROPME	(3)			/* drop current reply */
> -#define	RQ_SPLICE_OK	(4)			/* turned off in gss privacy
> -						 * to prevent encrypting page
> -						 * cache pages */
> -#define	RQ_VICTIM	(5)			/* about to be shut down */
> -#define	RQ_BUSY		(6)			/* request is busy */
> -#define	RQ_DATA		(7)			/* request has data */
>  	unsigned long		rq_flags;	/* flags field */
>  	ktime_t			rq_qtime;	/* enqueue time */
>  
> @@ -274,6 +269,20 @@ struct svc_rqst {
>  	void **			rq_lease_breaker; /* The v4 client breaking a lease */
>  };
>  
> +enum svc_rq_flags {
> +	RQ_SECURE,			/* secure port */
> +	RQ_LOCAL,			/* local request */
> +	RQ_USEDEFERRAL,			/* use deferral */
> +	RQ_DROPME,			/* drop current reply */
> +	RQ_SPLICE_OK,			/* turned off in gss privacy
> +					 * to prevent encrypting page
> +					 * cache pages */
> +	RQ_VICTIM,			/* agreed to shut down */
> +	RQ_DATA,			/* request has data */
> +	RQ_CLEAN_ME,			/* Thread needs to exit but
> +					 * is on the idle list */
> +};
> +
>  #define SVC_NET(rqst) (rqst->rq_xprt ? rqst->rq_xprt->xpt_net : rqst->rq_bc_net)
>  
>  /*
> @@ -309,6 +318,15 @@ static inline struct sockaddr *svc_daddr(const struct svc_rqst *rqst)
>  	return (struct sockaddr *) &rqst->rq_daddr;
>  }
>  
> +static inline bool svc_should_stop(struct svc_rqst *rqstp)
> +{
> +	if (test_and_clear_bit(SP_NEED_VICTIM, &rqstp->rq_pool->sp_flags)) {
> +		set_bit(RQ_VICTIM, &rqstp->rq_flags);
> +		return true;
> +	}
> +	return test_bit(RQ_VICTIM, &rqstp->rq_flags);
> +}
> +
>  struct svc_deferred_req {
>  	u32			prot;	/* protocol (UDP or TCP) */
>  	struct svc_xprt		*xprt;
> @@ -416,6 +434,7 @@ bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
>  void		   svc_rqst_free(struct svc_rqst *);
>  void		   svc_exit_thread(struct svc_rqst *);
> +bool		   svc_dequeue_rqst(struct svc_rqst *rqstp);
>  struct svc_serv *  svc_create_pooled(struct svc_program *, unsigned int,
>  				     int (*threadfn)(void *data));
>  int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
> @@ -428,7 +447,7 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
>  
>  void		   svc_wake_up(struct svc_serv *);
>  void		   svc_reserve(struct svc_rqst *rqstp, int space);
> -struct svc_rqst	  *svc_pool_wake_idle_thread(struct svc_serv *serv,
> +bool		   svc_pool_wake_idle_thread(struct svc_serv *serv,
>  					     struct svc_pool *pool);
>  struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
>  char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
> diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
> index f6fd48961074..f63289d1491d 100644
> --- a/include/trace/events/sunrpc.h
> +++ b/include/trace/events/sunrpc.h
> @@ -1601,7 +1601,7 @@ DEFINE_SVCXDRBUF_EVENT(sendto);
>  	svc_rqst_flag(DROPME)						\
>  	svc_rqst_flag(SPLICE_OK)					\
>  	svc_rqst_flag(VICTIM)						\
> -	svc_rqst_flag(BUSY)						\
> +	svc_rqst_flag(CLEAN_ME)						\
>  	svc_rqst_flag_end(DATA)
>  
>  #undef svc_rqst_flag
> @@ -1965,7 +1965,10 @@ TRACE_EVENT(svc_xprt_enqueue,
>  #define show_svc_pool_flags(x)						\
>  	__print_flags(x, "|",						\
>  		{ BIT(SP_TASK_PENDING),		"TASK_PENDING" },	\
> -		{ BIT(SP_CONGESTED),		"CONGESTED" })
> +		{ BIT(SP_CONGESTED),		"CONGESTED" },		\
> +		{ BIT(SP_NEED_VICTIM),		"NEED_VICTIM" },	\
> +		{ BIT(SP_VICTIM_REMAINS),	"VICTIM_REMAINS" },	\
> +		{ BIT(SP_CLEANUP),		"CLEANUP" })
>  
>  DECLARE_EVENT_CLASS(svc_pool_scheduler_class,
>  	TP_PROTO(
> diff --git a/lib/llist.c b/lib/llist.c
> index 6e668fa5a2c6..660be07795ac 100644
> --- a/lib/llist.c
> +++ b/lib/llist.c
> @@ -65,6 +65,57 @@ struct llist_node *llist_del_first(struct llist_head *head)
>  }
>  EXPORT_SYMBOL_GPL(llist_del_first);
>  
> +/**
> + * llist_del_first_this - delete given entry of lock-less list if it is first
> + * @head:	the head for your lock-less list
> + * @this:	a list entry.
> + *
> + * If head of the list is given entry, delete and return it, else
> + * return %NULL.
> + *
> + * Providing the caller has exclusive access to @this, multiple callers can
> + * safely call this concurrently with multiple llist_add() callers.
> + */
> +struct llist_node *llist_del_first_this(struct llist_head *head,
> +					struct llist_node *this)
> +{
> +	struct llist_node *entry, *next;
> +
> +	entry = smp_load_acquire(&head->first);
> +	do {
> +		if (entry != this)
> +			return NULL;
> +		next = READ_ONCE(entry->next);
> +	} while (!try_cmpxchg(&head->first, &entry, next));
> +
> +	return entry;
> +}
> +EXPORT_SYMBOL_GPL(llist_del_first_this);
> +
> +/**
> + * llist_del_all_this - delete all entries from lock-less list if first is the given element
> + * @head:	the head of lock-less list to delete all entries
> + * @this:	the expected first element.
> + *
> + * If the first element of the list is @this, delete all elements and
> + * return them, else return %NULL.  Providing the caller has exclusive access
> + * to @this, multiple concurrent callers can call this or list_del_first_this()
> + * simultaneuously with multiple callers of llist_add().
> + */
> +struct llist_node *llist_del_all_this(struct llist_head *head,
> +				      struct llist_node *this)
> +{
> +	struct llist_node *entry;
> +
> +	entry = smp_load_acquire(&head->first);
> +	do {
> +		if (entry != this)
> +			return NULL;
> +	} while (!try_cmpxchg(&head->first, &entry, NULL));
> +
> +	return entry;
> +}
> +
>  /**
>   * llist_reverse_order - reverse order of a llist chain
>   * @head:	first item of the list to be reversed
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index ffb7200e8257..55339cbbbc6e 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -507,7 +507,7 @@ __svc_create(struct svc_program *prog, unsigned int bufsize, int npools,
>  
>  		pool->sp_id = i;
>  		INIT_LIST_HEAD(&pool->sp_sockets);
> -		INIT_LIST_HEAD(&pool->sp_all_threads);
> +		init_llist_head(&pool->sp_idle_threads);
>  		spin_lock_init(&pool->sp_lock);
>  
>  		percpu_counter_init(&pool->sp_sockets_queued, 0, GFP_KERNEL);
> @@ -652,9 +652,9 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
>  
>  	pagevec_init(&rqstp->rq_pvec);
>  
> -	__set_bit(RQ_BUSY, &rqstp->rq_flags);
>  	rqstp->rq_server = serv;
>  	rqstp->rq_pool = pool;
> +	rqstp->rq_idle.next = &rqstp->rq_idle;
>  
>  	rqstp->rq_scratch_page = alloc_pages_node(node, GFP_KERNEL, 0);
>  	if (!rqstp->rq_scratch_page)
> @@ -694,7 +694,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>  
>  	spin_lock_bh(&pool->sp_lock);
>  	pool->sp_nrthreads++;
> -	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
>  	spin_unlock_bh(&pool->sp_lock);
>  	return rqstp;
>  }
> @@ -704,32 +703,34 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>   * @serv: RPC service
>   * @pool: service thread pool
>   *
> - * Returns an idle service thread (now marked BUSY), or NULL
> - * if no service threads are available. Finding an idle service
> - * thread and marking it BUSY is atomic with respect to other
> - * calls to svc_pool_wake_idle_thread().
> + * If there are any idle threads in the pool, wake one up and return
> + * %true, else return %false.  The thread will become non-idle once
> + * the scheduler schedules it, at which point is might wake another
> + * thread if there seems to be enough work to justify that.
>   */
> -struct svc_rqst *svc_pool_wake_idle_thread(struct svc_serv *serv,
> -					   struct svc_pool *pool)
> +bool svc_pool_wake_idle_thread(struct svc_serv *serv,
> +			       struct svc_pool *pool)
>  {
>  	struct svc_rqst	*rqstp;
> +	struct llist_node *ln;
>  
>  	rcu_read_lock();
> -	list_for_each_entry_rcu(rqstp, &pool->sp_all_threads, rq_all) {
> -		if (test_and_set_bit(RQ_BUSY, &rqstp->rq_flags))
> -			continue;
> -
> -		rcu_read_unlock();
> +	ln = READ_ONCE(pool->sp_idle_threads.first);
> +	if (ln) {
> +		rqstp = llist_entry(ln, struct svc_rqst, rq_idle);
>  		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
> -		wake_up_process(rqstp->rq_task);
> -		percpu_counter_inc(&pool->sp_threads_woken);
> -		return rqstp;
> +		if (!task_is_running(rqstp->rq_task)) {
> +			wake_up_process(rqstp->rq_task);
> +			percpu_counter_inc(&pool->sp_threads_woken);
> +		}
> +		rcu_read_unlock();
> +		return true;
>  	}
>  	rcu_read_unlock();
>  
>  	trace_svc_pool_starved(serv, pool);
>  	percpu_counter_inc(&pool->sp_threads_starved);
> -	return NULL;
> +	return false;
>  }
>  
>  static struct svc_pool *
> @@ -738,19 +739,22 @@ svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
>  	return pool ? pool : &serv->sv_pools[(*state)++ % serv->sv_nrpools];
>  }
>  
> -static struct task_struct *
> +static struct svc_pool *
>  svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
>  {
> -	unsigned int i;
> -	struct task_struct *task = NULL;
>  
>  	if (pool != NULL) {
>  		spin_lock_bh(&pool->sp_lock);
> +		if (pool->sp_nrthreads > 0)
> +			goto found_pool;
> +		spin_unlock_bh(&pool->sp_lock);
> +		return NULL;
>  	} else {
> +		unsigned int i;
>  		for (i = 0; i < serv->sv_nrpools; i++) {
>  			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
>  			spin_lock_bh(&pool->sp_lock);
> -			if (!list_empty(&pool->sp_all_threads))
> +			if (pool->sp_nrthreads > 0)
>  				goto found_pool;
>  			spin_unlock_bh(&pool->sp_lock);
>  		}
> @@ -758,16 +762,10 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *pool, unsigned int *stat
>  	}
>  
>  found_pool:
> -	if (!list_empty(&pool->sp_all_threads)) {
> -		struct svc_rqst *rqstp;
> -
> -		rqstp = list_entry(pool->sp_all_threads.next, struct svc_rqst, rq_all);
> -		set_bit(RQ_VICTIM, &rqstp->rq_flags);
> -		list_del_rcu(&rqstp->rq_all);
> -		task = rqstp->rq_task;
> -	}
> +	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> +	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
>  	spin_unlock_bh(&pool->sp_lock);
> -	return task;
> +	return pool;
>  }
>  
>  static int
> @@ -808,18 +806,16 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
>  static int
>  svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
>  {
> -	struct svc_rqst	*rqstp;
> -	struct task_struct *task;
>  	unsigned int state = serv->sv_nrthreads-1;
> +	struct svc_pool *vpool;
>  
>  	do {
> -		task = svc_pool_victim(serv, pool, &state);
> -		if (task == NULL)
> +		vpool = svc_pool_victim(serv, pool, &state);
> +		if (vpool == NULL)
>  			break;
> -		rqstp = kthread_data(task);
> -		/* Did we lose a race to svo_function threadfn? */
> -		if (kthread_stop(task) == -EINTR)
> -			svc_exit_thread(rqstp);
> +		svc_pool_wake_idle_thread(serv, vpool);
> +		wait_on_bit(&vpool->sp_flags, SP_VICTIM_REMAINS,
> +			    TASK_UNINTERRUPTIBLE);
>  		nrservs++;
>  	} while (nrservs < 0);
>  	return 0;
> @@ -931,16 +927,75 @@ svc_rqst_free(struct svc_rqst *rqstp)
>  }
>  EXPORT_SYMBOL_GPL(svc_rqst_free);
>  
> +bool svc_dequeue_rqst(struct svc_rqst *rqstp)
> +{
> +	struct svc_pool *pool = rqstp->rq_pool;
> +	struct llist_node *le, *last;
> +
> +retry:
> +	if (pool->sp_idle_threads.first != &rqstp->rq_idle)
> +		/* Not at head of queue, so cannot wake up */
> +		return false;
> +	if (!test_and_clear_bit(SP_CLEANUP, &pool->sp_flags)) {
> +		le = llist_del_first_this(&pool->sp_idle_threads,
> +					  &rqstp->rq_idle);
> +		if (le)
> +			le->next = le;
> +		return !!le;
> +	}
> +	/* Need to deal will RQ_CLEAN_ME thread */
> +	le = llist_del_all_this(&pool->sp_idle_threads,
> +				&rqstp->rq_idle);
> +	if (!le) {
> +		/* lost a race, someone else need to clean up */
> +		set_bit(SP_CLEANUP, &pool->sp_flags);
> +		svc_pool_wake_idle_thread(rqstp->rq_server,
> +					  pool);
> +		goto retry;
> +	}
> +	if (!le->next)
> +		return true;
> +	last = le;
> +	while (last->next) {
> +		rqstp = list_entry(last->next, struct svc_rqst, rq_idle);
> +		if (!test_bit(RQ_CLEAN_ME, &rqstp->rq_flags)) {
> +			last = last->next;
> +			continue;
> +		}
> +		last->next = last->next->next;
> +		rqstp->rq_idle.next = &rqstp->rq_idle;
> +		wake_up_process(rqstp->rq_task);
> +	}
> +	if (last != le)
> +		llist_add_batch(le->next, last, &pool->sp_idle_threads);
> +	le->next = le;
> +	return true;
> +}
> +
>  void
>  svc_exit_thread(struct svc_rqst *rqstp)
>  {
>  	struct svc_serv	*serv = rqstp->rq_server;
>  	struct svc_pool	*pool = rqstp->rq_pool;
>  
> +	while (rqstp->rq_idle.next != &rqstp->rq_idle) {
> +		/* Still on the idle list. */
> +		if (llist_del_first_this(&pool->sp_idle_threads,
> +					 &rqstp->rq_idle)) {
> +			/* Safely removed */
> +			rqstp->rq_idle.next = &rqstp->rq_idle;
> +		} else {
> +			set_current_state(TASK_UNINTERRUPTIBLE);
> +			set_bit(RQ_CLEAN_ME, &rqstp->rq_flags);
> +			set_bit(SP_CLEANUP, &pool->sp_flags);
> +			svc_pool_wake_idle_thread(serv, pool);
> +			if (!svc_dequeue_rqst(rqstp))
> +				schedule();
> +			__set_current_state(TASK_RUNNING);
> +		}
> +	}
>  	spin_lock_bh(&pool->sp_lock);
>  	pool->sp_nrthreads--;
> -	if (!test_and_set_bit(RQ_VICTIM, &rqstp->rq_flags))
> -		list_del_rcu(&rqstp->rq_all);
>  	spin_unlock_bh(&pool->sp_lock);
>  
>  	spin_lock_bh(&serv->sv_lock);
> @@ -948,6 +1003,8 @@ svc_exit_thread(struct svc_rqst *rqstp)
>  	spin_unlock_bh(&serv->sv_lock);
>  	svc_sock_update_bufs(serv);
>  
> +	if (test_bit(RQ_VICTIM, &rqstp->rq_flags))
> +		clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
>  	svc_rqst_free(rqstp);
>  
>  	svc_put(serv);
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index c4521bce1f27..d51587cd8d99 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -446,7 +446,6 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
>   */
>  void svc_xprt_enqueue(struct svc_xprt *xprt)
>  {
> -	struct svc_rqst *rqstp;
>  	struct svc_pool *pool;
>  
>  	if (!svc_xprt_ready(xprt))
> @@ -467,20 +466,19 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
>  	list_add_tail(&xprt->xpt_ready, &pool->sp_sockets);
>  	spin_unlock_bh(&pool->sp_lock);
>  
> -	rqstp = svc_pool_wake_idle_thread(xprt->xpt_server, pool);
> -	if (!rqstp) {
> +	if (!svc_pool_wake_idle_thread(xprt->xpt_server, pool)) {
>  		set_bit(SP_CONGESTED, &pool->sp_flags);
>  		return;
>  	}
>  
> -	trace_svc_xprt_enqueue(xprt, rqstp);
> +	// trace_svc_xprt_enqueue(xprt, rqstp);
>  }
>  EXPORT_SYMBOL_GPL(svc_xprt_enqueue);
>  
>  /*
>   * Dequeue the first transport, if there is one.
>   */
> -static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
> +static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool, bool *more)
>  {
>  	struct svc_xprt	*xprt = NULL;
>  
> @@ -493,6 +491,7 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
>  					struct svc_xprt, xpt_ready);
>  		list_del_init(&xprt->xpt_ready);
>  		svc_xprt_get(xprt);
> +		*more = !list_empty(&pool->sp_sockets);
>  	}
>  	spin_unlock_bh(&pool->sp_lock);
>  out:
> @@ -577,15 +576,13 @@ static void svc_xprt_release(struct svc_rqst *rqstp)
>  void svc_wake_up(struct svc_serv *serv)
>  {
>  	struct svc_pool *pool = &serv->sv_pools[0];
> -	struct svc_rqst *rqstp;
>  
> -	rqstp = svc_pool_wake_idle_thread(serv, pool);
> -	if (!rqstp) {
> +	if (!svc_pool_wake_idle_thread(serv, pool)) {
>  		set_bit(SP_TASK_PENDING, &pool->sp_flags);
>  		return;
>  	}
>  
> -	trace_svc_wake_up(rqstp);
> +	// trace_svc_wake_up(rqstp);
>  }
>  EXPORT_SYMBOL_GPL(svc_wake_up);
>  
> @@ -676,7 +673,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
>  			continue;
>  
>  		set_current_state(TASK_INTERRUPTIBLE);
> -		if (signalled() || kthread_should_stop()) {
> +		if (signalled() || svc_should_stop(rqstp)) {
>  			set_current_state(TASK_RUNNING);
>  			return -EINTR;
>  		}
> @@ -706,7 +703,10 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  	struct svc_pool		*pool = rqstp->rq_pool;
>  
>  	/* did someone call svc_wake_up? */
> -	if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
> +	if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
> +		return false;
> +	if (test_bit(SP_CLEANUP, &pool->sp_flags))
> +		/* a signalled thread needs to be released */
>  		return false;
>  
>  	/* was a socket queued? */
> @@ -714,7 +714,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
>  		return false;
>  
>  	/* are we shutting down? */
> -	if (signalled() || kthread_should_stop())
> +	if (signalled() || svc_should_stop(rqstp))
>  		return false;
>  
>  	/* are we freezing? */
> @@ -728,11 +728,9 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
>  {
>  	struct svc_pool		*pool = rqstp->rq_pool;
>  	long			time_left = 0;
> +	bool			more = false;
>  
> -	/* rq_xprt should be clear on entry */
> -	WARN_ON_ONCE(rqstp->rq_xprt);
> -
> -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> +	rqstp->rq_xprt = svc_xprt_dequeue(pool, &more);
>  	if (rqstp->rq_xprt) {
>  		trace_svc_pool_polled(pool, rqstp);
>  		goto out_found;
> @@ -743,11 +741,10 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
>  	 * to bring down the daemons ...
>  	 */
>  	set_current_state(TASK_INTERRUPTIBLE);
> -	smp_mb__before_atomic();
> -	clear_bit(SP_CONGESTED, &pool->sp_flags);
> -	clear_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> +	clear_bit_unlock(SP_CONGESTED, &pool->sp_flags);
>  
> +	llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> +again:
>  	if (likely(rqst_should_sleep(rqstp)))
>  		time_left = schedule_timeout(timeout);
>  	else
> @@ -755,9 +752,20 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
>  
>  	try_to_freeze();
>  
> -	set_bit(RQ_BUSY, &rqstp->rq_flags);
> -	smp_mb__after_atomic();
> -	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> +	if (!svc_dequeue_rqst(rqstp)) {
> +		if (signalled())
> +			/* Can only return while on idle list if signalled */
> +			return ERR_PTR(-EINTR);
> +		/* Still on the idle list */
> +		goto again;
> +	}
> +
> +	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> +
> +	if (svc_should_stop(rqstp))
> +		return ERR_PTR(-EINTR);
> +
> +	rqstp->rq_xprt = svc_xprt_dequeue(pool, &more);
>  	if (rqstp->rq_xprt) {
>  		trace_svc_pool_awoken(pool, rqstp);
>  		goto out_found;
> @@ -766,10 +774,11 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp, long timeout)
>  	if (!time_left)
>  		percpu_counter_inc(&pool->sp_threads_timedout);
>  
> -	if (signalled() || kthread_should_stop())
> -		return ERR_PTR(-EINTR);
>  	return ERR_PTR(-EAGAIN);
>  out_found:
> +	if (more)
> +		svc_pool_wake_idle_thread(rqstp->rq_server, pool);
> +
>  	/* Normally we will wait up to 5 seconds for any required
>  	 * cache information to be provided.
>  	 */
> @@ -866,7 +875,7 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
>  	try_to_freeze();
>  	cond_resched();
>  	err = -EINTR;
> -	if (signalled() || kthread_should_stop())
> +	if (signalled() || svc_should_stop(rqstp))
>  		goto out;
>  
>  	xprt = svc_get_next_xprt(rqstp, timeout);
> -- 
> 2.40.1
> 
