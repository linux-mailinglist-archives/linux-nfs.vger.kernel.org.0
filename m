Return-Path: <linux-nfs+bounces-17078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 925A2CBB3EB
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33D4930010F4
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0B02874ED;
	Sat, 13 Dec 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NR4iRf0J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760421D7E42
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765659384; cv=none; b=NtfHNxO9uYpkP5HTYr0zgktvF4HGE7pn/xTfuNaTIRY4Shkixh2lbQYNRVLJXJw0rKqmYF/yEYAr/3fWihJD8R9H5MaPOzdD6mu9rcZFM2GJetyr5NlvRlh+HW2szMKcbfIcgDlwz5+N8P0gL3DIKLzOoBJb+fWm8tWhz4VnpBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765659384; c=relaxed/simple;
	bh=j22yvEOnSERDINh3LROcpg3n3NOlVZGwl6tXt0kWwwI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=phkhGEC04Bk6vuXqjDH5HlNKYuVUC06YnJkFBT8fgW0p74uoy+FyU9rwaJyGkUk1kKCTp5BlhefSCES72sHaP/dkXz21i3wILiw07yECk/GKhaqN+du0O1pgn9RNoJfUOTAYQQ7pfp6WfyJc8F5RebSGC3LllSx3X82ZLCdayd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NR4iRf0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2180C113D0;
	Sat, 13 Dec 2025 20:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765659384;
	bh=j22yvEOnSERDINh3LROcpg3n3NOlVZGwl6tXt0kWwwI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NR4iRf0JFtglpIk3McKYCywisC4Ro0aIBYOhhJ9M2eGRE/tGkEd02qM92gg8mqIkB
	 uyS/pc3Z8nKmPleQLUi78hwHm5/YEmSPRTkq18tBS38cKWv7Kl0sUVV9HdlCExwPi7
	 orJS2bluzHWA6uTC9KbBnS1KdCKZO0t0jWj7hGrD0GwN7f3DoyNpW+8ep+4DKJshmx
	 Xfb5J+bh7Yu9zYGZeNgMUbglsPDKjJSGa5jl/JveNS5HA4GQjWnfTaJXGZ67LlaUkh
	 0ls5Y4IgDnnAFR9ht9q4iiYYvF76qgTxNEPk0PapSDhcMdRUn+zKi7NMIktZ+BkEUH
	 ZTxa9b7hXHzIA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B8DAEF40068;
	Sat, 13 Dec 2025 15:56:22 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 15:56:22 -0500
X-ME-Sender: <xms:9tI9aelHGIsEVeazVfZDO2tBjUe0VefryazLSWZI3NZ5pOBVznQiGg>
    <xme:9tI9aQrITD6bzWPNec9zc20Nq2OUPgd6OGcYpH-kIjK4_CFHlJGZKj7DR2JW_kOwJ
    QqNWroPN-infwcJpBAV_58fPAMRgi3spHOLIwEFqLlxNZenY72JK4Br>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdevhhhutghk
    ucfnvghvvghrfdcuoegtvghlsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
    ephfffkefffedtgfehieevkeduuefhvdejvdefvdeuuddvgeelkeegtefgudfhfeelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkh
    hlvghvvghrodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleel
    heelqdefvdelkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrih
    hlrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvihhlsegsrhhofihnrdhnrghmvgdprhgtphhtthhopegrnhhnrgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepthhrohhnughmhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrih
    drnhhgohesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheptghhuhgtkhdrlhgvvhgvrhes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehtohhmsehtrghlphgvhidrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:9tI9aexIkdMAkwzeKJOmf5CeR7nn8xG-zC6mQYEdZX5prmmILl8d9A>
    <xmx:9tI9aQSM8lba37nv4ZLhS_jZTYrqtiOhseM01QY45hjIMyjL_QNe1Q>
    <xmx:9tI9abKegQ6IO7ElfY2B7vskaJs6_cpsrXEXaDndwXo-0aknpVmywQ>
    <xmx:9tI9aXWOTgy1C9yEjdBlR3PtvAPB3FlIMEhgh3e7BgenXJRm5yPxmQ>
    <xmx:9tI9afSHxiSmkk3z4mZVHBXT9QAoaOJhUZRjCWqC73qaUPx_tz-6TLyG>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 955AA780054; Sat, 13 Dec 2025 15:56:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AsDHoGDOXTJk
Date: Sat, 13 Dec 2025 15:54:44 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <ede9496b-aaa8-41a9-8657-3a1f3cf4a9aa@app.fastmail.com>
In-Reply-To: <20251213-nfsd-dynathread-v1-5-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
 <20251213-nfsd-dynathread-v1-5-de755e59cbc4@kernel.org>
Subject: Re: [PATCH RFC 5/6] nfsd: adjust number of running nfsd threads based on
 activity
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> This patch is based on a draft patch by Neil:
>
> svc_recv() is changed to return a status.  This can be:
>
>  -ETIMEDOUT - waited for 5 seconds and found nothing to do.  This is
>           boring.  Also there are more actual threads than really
>           needed.
>  -EBUSY - I did something, but there is more stuff to do and no one
>           idle who I can wake up to do it.
>           BTW I successful set a flag: SP_TASK_STARTING.  You better
>           clear it.
>  0 - just minding my own business, nothing to see here.
>
> nfsd() is changed to pay attention to this status.  In the case of
> -ETIMEDOUT, if the service mutex can be taken (trylock), the thread
> becomes and RQ_VICTIM so that it will exit.  In the case of -EBUSY, if
> the actual number of threads is below the calculated maximum, a new
> thread is started.  SP_TASK_STARTING is cleared.

Jeff, since you reworked things to be based on a minimum rather
than a maximum count, is this paragraph now stale?


> To support the above, some code is split out of svc_start_kthreads()
> into svc_new_thread().
>
> I think we want memory pressure to be able to push a thread into
> returning -ETIMEDOUT.  That can come later.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/nfsd/nfssvc.c               | 35 ++++++++++++++++++++-
>  fs/nfsd/trace.h                | 35 +++++++++++++++++++++
>  include/linux/sunrpc/svc.h     |  2 ++
>  include/linux/sunrpc/svcsock.h |  2 +-
>  net/sunrpc/svc.c               | 69 ++++++++++++++++++++++++------------------
>  net/sunrpc/svc_xprt.c          | 45 ++++++++++++++++++++++-----
>  6 files changed, 148 insertions(+), 40 deletions(-)
>
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 
> 993ed338764b0ccd7bdfb76bd6fbb5dc6ab4022d..26c3a6cb1f400f1b757d26f6ba77e27deb7e8ee2 
> 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -896,9 +896,11 @@ static int
>  nfsd(void *vrqstp)
>  {
>  	struct svc_rqst *rqstp = (struct svc_rqst *) vrqstp;
> +	struct svc_pool *pool = rqstp->rq_pool;
>  	struct svc_xprt *perm_sock = 
> list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct 
> svc_xprt), xpt_list);
>  	struct net *net = perm_sock->xpt_net;
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	bool have_mutex = false;
> 
>  	/* At this point, the thread shares current->fs
>  	 * with the init process. We need to create files with the
> @@ -916,7 +918,36 @@ nfsd(void *vrqstp)
>  	 * The main request loop
>  	 */
>  	while (!svc_thread_should_stop(rqstp)) {
> -		svc_recv(rqstp);
> +		switch (svc_recv(rqstp)) {
> +		case -ETIMEDOUT: /* Nothing to do */
> +			if (mutex_trylock(&nfsd_mutex)) {
> +				if (pool->sp_nrthreads > pool->sp_nrthrmin) {
> +					trace_nfsd_dynthread_kill(net, pool);
> +					set_bit(RQ_VICTIM, &rqstp->rq_flags);
> +					have_mutex = true;
> +				} else
> +					mutex_unlock(&nfsd_mutex);
> +			} else {
> +				trace_nfsd_dynthread_trylock_fail(net, pool);
> +			}
> +			break;
> +		case -EBUSY: /* Too much to do */
> +			if (pool->sp_nrthreads < pool->sp_nrthrmax &&
> +			    mutex_trylock(&nfsd_mutex)) {
> +				// check no idle threads?

Can this comment be clarified? It looks like a note-to-self, that maybe
something is unfinished.


> +				if (pool->sp_nrthreads < pool->sp_nrthrmax) {
> +					trace_nfsd_dynthread_start(net, pool);
> +					svc_new_thread(rqstp->rq_server, pool);
> +				}
> +				mutex_unlock(&nfsd_mutex);
> +			} else {
> +				trace_nfsd_dynthread_trylock_fail(net, pool);
> +			}
> +			clear_bit(SP_TASK_STARTING, &pool->sp_flags);
> +			break;
> +		default:
> +			break;
> +		}
>  		nfsd_file_net_dispose(nn);
>  	}
> 
> @@ -924,6 +955,8 @@ nfsd(void *vrqstp)
> 
>  	/* Release the thread */
>  	svc_exit_thread(rqstp);
> +	if (have_mutex)
> +		mutex_unlock(&nfsd_mutex);
>  	return 0;
>  }
> 
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index 
> 5ae2a611e57f4b4e51a4d9eb6e0fccb66ad8d288..8885fd9bead98ebf55379d68ab9c3701981a5150 
> 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -91,6 +91,41 @@ DEFINE_EVENT(nfsd_xdr_err_class, nfsd_##name##_err, \
>  DEFINE_NFSD_XDR_ERR_EVENT(garbage_args);
>  DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
> 
> +DECLARE_EVENT_CLASS(nfsd_dynthread_class,
> +	TP_PROTO(
> +		const struct net *net,
> +		const struct svc_pool *pool
> +	),
> +	TP_ARGS(net, pool),
> +	TP_STRUCT__entry(
> +		__field(unsigned int, netns_ino)
> +		__field(unsigned int, pool_id)
> +		__field(unsigned int, nrthreads)
> +		__field(unsigned int, nrthrmin)
> +		__field(unsigned int, nrthrmax)
> +	),
> +	TP_fast_assign(
> +		__entry->netns_ino = net->ns.inum;
> +		__entry->pool_id = pool->sp_id;
> +		__entry->nrthreads = pool->sp_nrthreads;
> +		__entry->nrthrmin = pool->sp_nrthrmin;
> +		__entry->nrthrmax = pool->sp_nrthrmax;
> +	),
> +	TP_printk("pool=%u nrthreads=%u nrthrmin=%u nrthrmax=%u",
> +		__entry->pool_id, __entry->nrthreads,
> +		__entry->nrthrmin, __entry->nrthrmax
> +	)
> +);
> +
> +#define DEFINE_NFSD_DYNTHREAD_EVENT(name) \
> +DEFINE_EVENT(nfsd_dynthread_class, nfsd_dynthread_##name, \
> +	TP_PROTO(const struct net *net, const struct svc_pool *pool), \
> +	TP_ARGS(net, pool))
> +
> +DEFINE_NFSD_DYNTHREAD_EVENT(start);
> +DEFINE_NFSD_DYNTHREAD_EVENT(kill);
> +DEFINE_NFSD_DYNTHREAD_EVENT(trylock_fail);
> +
>  #define show_nfsd_may_flags(x)						\
>  	__print_flags(x, "|",						\
>  		{ NFSD_MAY_EXEC,		"EXEC" },		\
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 
> 35bd3247764ae8dc5dcdfffeea36f7cfefd13372..f47e19c9bd9466986438766e9ab7b4c71cda1ba6 
> 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -55,6 +55,7 @@ enum {
>  	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
>  	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
>  	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
> +	SP_TASK_STARTING,	/* Task has started but not added to idle yet */
>  };
> 
> 
> @@ -442,6 +443,7 @@ struct svc_serv *svc_create(struct svc_program *, 
> unsigned int,
>  bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
>  					 struct page *page);
>  void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
> +int		   svc_new_thread(struct svc_serv *serv, struct svc_pool *pool);
>  void		   svc_exit_thread(struct svc_rqst *);
>  struct svc_serv *  svc_create_pooled(struct svc_program *prog,
>  				     unsigned int nprog,
> diff --git a/include/linux/sunrpc/svcsock.h 
> b/include/linux/sunrpc/svcsock.h
> index 
> de37069aba90899be19b1090e6e90e509a3cf530..5c87d3fedd33e7edf5ade32e60523cae7e9ebaba 
> 100644
> --- a/include/linux/sunrpc/svcsock.h
> +++ b/include/linux/sunrpc/svcsock.h
> @@ -61,7 +61,7 @@ static inline u32 svc_sock_final_rec(struct svc_sock 
> *svsk)
>  /*
>   * Function prototypes.
>   */
> -void		svc_recv(struct svc_rqst *rqstp);
> +int		svc_recv(struct svc_rqst *rqstp);
>  void		svc_send(struct svc_rqst *rqstp);
>  int		svc_addsock(struct svc_serv *serv, struct net *net,
>  			    const int fd, char *name_return, const size_t len,
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 
> dc818158f8529b62dcf96c91bd9a9d4ab21df91f..9fca2dd340037f82baa4936766ebe0e38c3f0d85 
> 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -714,9 +714,6 @@ svc_prepare_thread(struct svc_serv *serv, struct 
> svc_pool *pool, int node)
> 
>  	rqstp->rq_err = -EAGAIN; /* No error yet */
> 
> -	serv->sv_nrthreads += 1;
> -	pool->sp_nrthreads += 1;
> -
>  	/* Protected by whatever lock the service uses when calling
>  	 * svc_set_num_threads()
>  	 */
> @@ -763,45 +760,57 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
>  }
>  EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
> 
> -static int
> -svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
> +int svc_new_thread(struct svc_serv *serv, struct svc_pool *pool)

Is now an exported function, should get a kdoc comment.


>  {
>  	struct svc_rqst	*rqstp;
>  	struct task_struct *task;
>  	int node;
>  	int err;
> 
> -	do {
> -		nrservs--;
> -		node = svc_pool_map_get_node(pool->sp_id);
> -
> -		rqstp = svc_prepare_thread(serv, pool, node);
> -		if (!rqstp)
> -			return -ENOMEM;
> -		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
> -					      node, "%s", serv->sv_name);
> -		if (IS_ERR(task)) {
> -			svc_exit_thread(rqstp);
> -			return PTR_ERR(task);
> -		}
> +	node = svc_pool_map_get_node(pool->sp_id);
> 
> -		rqstp->rq_task = task;
> -		if (serv->sv_nrpools > 1)
> -			svc_pool_map_set_cpumask(task, pool->sp_id);
> +	rqstp = svc_prepare_thread(serv, pool, node);
> +	if (!rqstp)
> +		return -ENOMEM;
> +	set_bit(SP_TASK_STARTING, &pool->sp_flags);
> +	task = kthread_create_on_node(serv->sv_threadfn, rqstp,
> +				      node, "%s", serv->sv_name);
> +	if (IS_ERR(task)) {
> +		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
> +		svc_exit_thread(rqstp);

svc_exit_thread() decrements serv->sv_nrthreads and pool->sp_nrthreads
but this call site hasn't incremented them yet. Perhaps this error
flow needs a simpler clean-up than calling svc_exit_thread().


> +		return PTR_ERR(task);
> +	}
> 
> -		svc_sock_update_bufs(serv);
> -		wake_up_process(task);
> +	serv->sv_nrthreads += 1;
> +	pool->sp_nrthreads += 1;
> 
> -		wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
> -		err = rqstp->rq_err;
> -		if (err) {
> -			svc_exit_thread(rqstp);
> -			return err;
> -		}
> -	} while (nrservs > 0);
> +	rqstp->rq_task = task;
> +	if (serv->sv_nrpools > 1)
> +		svc_pool_map_set_cpumask(task, pool->sp_id);
> 
> +	svc_sock_update_bufs(serv);
> +	wake_up_process(task);
> +
> +	wait_var_event(&rqstp->rq_err, rqstp->rq_err != -EAGAIN);
> +	err = rqstp->rq_err;
> +	if (err) {
> +		svc_exit_thread(rqstp);
> +		return err;
> +	}
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(svc_new_thread);
> +
> +static int
> +svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
> +{
> +	int err = 0;
> +
> +	while (!err && nrservs--)
> +		err = svc_new_thread(serv, pool);
> +
> +	return err;
> +}
> 
>  static int
>  svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int 
> nrservs)
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index 
> 6973184ff6675211b4338fac80105894e9c8d4df..9612334300c8dae38720a0f5c61c0f505432ec2f 
> 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -714,15 +714,22 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
>  	return true;
>  }
> 
> -static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
> +static bool nfsd_schedule_timeout(long timeout)

Perhaps svc_schedule_timeout() is a more appropriate name for
a function that resides in net/sunrpc/svc_xprt.c.


> +{
> +	return schedule_timeout(timeout) == 0;
> +}
> +
> +static bool svc_thread_wait_for_work(struct svc_rqst *rqstp)
>  {
>  	struct svc_pool *pool = rqstp->rq_pool;
> +	bool did_timeout = false;
> 
>  	if (svc_thread_should_sleep(rqstp)) {
>  		set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
> +		clear_bit(SP_TASK_STARTING, &pool->sp_flags);
>  		if (likely(svc_thread_should_sleep(rqstp)))
> -			schedule();
> +			did_timeout = nfsd_schedule_timeout(5 * HZ);
> 
>  		while (!llist_del_first_this(&pool->sp_idle_threads,
>  					     &rqstp->rq_idle)) {
> @@ -734,7 +741,10 @@ static void svc_thread_wait_for_work(struct 
> svc_rqst *rqstp)
>  			 * for this new work.  This thread can safely sleep
>  			 * until woken again.
>  			 */
> -			schedule();
> +			if (did_timeout)
> +				did_timeout = nfsd_schedule_timeout(HZ);
> +			else
> +				did_timeout = nfsd_schedule_timeout(5 * HZ);
>  			set_current_state(TASK_IDLE | TASK_FREEZABLE);
>  		}
>  		__set_current_state(TASK_RUNNING);
> @@ -742,6 +752,7 @@ static void svc_thread_wait_for_work(struct 
> svc_rqst *rqstp)
>  		cond_resched();
>  	}
>  	try_to_freeze();
> +	return did_timeout;
>  }
> 
>  static void svc_add_new_temp_xprt(struct svc_serv *serv, struct 
> svc_xprt *newxpt)
> @@ -825,6 +836,8 @@ static void svc_handle_xprt(struct svc_rqst *rqstp, 
> struct svc_xprt *xprt)
> 
>  static void svc_thread_wake_next(struct svc_rqst *rqstp)
>  {
> +	clear_bit(SP_TASK_STARTING, &rqstp->rq_pool->sp_flags);
> +
>  	if (!svc_thread_should_sleep(rqstp))
>  		/* More work pending after I dequeued some,
>  		 * wake another worker
> @@ -839,21 +852,31 @@ static void svc_thread_wake_next(struct svc_rqst *rqstp)
>   * This code is carefully organised not to touch any cachelines in
>   * the shared svc_serv structure, only cachelines in the local
>   * svc_pool.
> + *
> + * Returns -ETIMEDOUT if idle for an extended period
> + *         -EBUSY is there is more work to do than available threads
> + *         0 otherwise.
>   */
> -void svc_recv(struct svc_rqst *rqstp)
> +int svc_recv(struct svc_rqst *rqstp)
>  {
>  	struct svc_pool *pool = rqstp->rq_pool;
> +	bool did_wait;
> +	int ret = 0;
> 
>  	if (!svc_alloc_arg(rqstp))
> -		return;
> +		return ret;
> +
> +	did_wait = svc_thread_wait_for_work(rqstp);
> 
> -	svc_thread_wait_for_work(rqstp);
> +	if (did_wait && svc_thread_should_sleep(rqstp) &&
> +	    pool->sp_nrthrmin && (pool->sp_nrthreads > pool->sp_nrthrmin))
> +		ret = -ETIMEDOUT;
> 
>  	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
> 
>  	if (svc_thread_should_stop(rqstp)) {
>  		svc_thread_wake_next(rqstp);
> -		return;
> +		return ret;
>  	}
> 
>  	rqstp->rq_xprt = svc_xprt_dequeue(pool);
> @@ -867,8 +890,13 @@ void svc_recv(struct svc_rqst *rqstp)
>  		 */
>  		if (pool->sp_idle_threads.first)
>  			rqstp->rq_chandle.thread_wait = 5 * HZ;
> -		else
> +		else {
>  			rqstp->rq_chandle.thread_wait = 1 * HZ;
> +			if (!did_wait &&
> +			    !test_and_set_bit(SP_TASK_STARTING,
> +					      &pool->sp_flags))
> +				ret = -EBUSY;
> +		}
> 
>  		trace_svc_xprt_dequeue(rqstp);
>  		svc_handle_xprt(rqstp, xprt);
> @@ -887,6 +915,7 @@ void svc_recv(struct svc_rqst *rqstp)
>  		}
>  	}
>  #endif
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(svc_recv);
> 
>
> -- 
> 2.52.0

The extensive use of atomic bit ops here is a little worrying.
Those can be costly -- and the sp_flags field is going to get
poked at by more and more threads as the pool's thread count
increases.


-- 
Chuck Lever

