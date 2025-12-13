Return-Path: <linux-nfs+bounces-17077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12DEBCBB31D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A38300943D
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 20:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD13247280;
	Sat, 13 Dec 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9Llok5i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ED923BCF7
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 20:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765657221; cv=none; b=pCUkWpb5BQk3DPHSEqYXSZ5DvAb2N1SkIIAHkl8wSbVP4AtnBROewQVbJz3njJAvaTXYtMgSjwkdxkYkYmbfoIZi6fA9YVDHPlulcrrZJAX14zPm8KOJ23q63w/+/fvrjuxYAfnioui8xbX5A6CjYDb49JN0yQHK2tp5GReiQvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765657221; c=relaxed/simple;
	bh=GRNacjPK0/Mku14mzffnsgAhBgamIK72ago/e9ccRkE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=g+Ir6wJMg2pPtn1AE5Z56GFkKIbkGHMZRUU2uflSUfvZtEUD7VmFztP7BkkaxoNmTDhxlLete9aELppqO7grhwF5ZGd/qvn83LZFoJxWd3Ve3lhW0mHaUT3w/EFRj0Q90Ez4OybuqJ2emgUt2nTGBuTg/feuUVmhQ+2+4/JLVVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9Llok5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED804C113D0;
	Sat, 13 Dec 2025 20:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765657221;
	bh=GRNacjPK0/Mku14mzffnsgAhBgamIK72ago/e9ccRkE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Q9Llok5iVfczE078LzaMKh6CTyLTiU5N7iXNWnF8U4W7WjoMGVKpm5sBfuazYRmzw
	 MGrFTgOV5xJw5dlgjM6tlLTn5J8IWmoxn8zaTkP1wJP3yDmN1A/JvS1TrZLU0VPauV
	 yJpqzZJjuJXKBeOA8F7jgY/P7ugv5NJM8H+hgUaGVCbGP0y8WUaT93W8464ccH0Zrv
	 vIx6dq4oALFVUpoXWQc1J5ymy+iMzx9MHeOhmTtxMJMYjXh1GrOW6yK5ubeAHpVILX
	 0T93aCug+ClfGD5S6lBPenQ05ck5Ajr5iosADf2mx4OTU+qpD4+VgQOcBkxEStQ0Oc
	 S5rBXlFqxVVLQ==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 01189F40070;
	Sat, 13 Dec 2025 15:20:19 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 15:20:20 -0500
X-ME-Sender: <xms:g8o9aVPhczZoTGuNFZ2Dxo5yeKhvh28ZyCcx8wgBW5ROq7OVGzkQ7Q>
    <xme:g8o9aSxW2tkvuLVoqEg5eUmHBshI6dQdocAhRIcTWQLojePZl7LIZ1289sumCwiIm
    yvPo7s4e9kcVD5bgCsaWXRZdteiiGtU5DUI6LD_4Vmbgr1ahF6N4ds>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddttdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:g8o9aWZjr2oFuFL7yG8eqpnoDYBwFQi-TcwTPXhM_UMXNNhMVWqS2A>
    <xmx:g8o9afZtBe8uWJnBC16x6S9pfk9zuopf_47KpjbXkZa8XiehFRcUiQ>
    <xmx:g8o9abw-o-yINqdD2e7hO2fkwVwL4RYRYKff2Ja6MVY4MqxgLf--Nw>
    <xmx:g8o9abeuoAtyh1AJwlj8qDRPxQG9r8dieOgShiH3vKV1EcoUPIgZbQ>
    <xmx:g8o9aQ6QkZymzmkDy7dIv8AN_R_g6h6mUUYoCw2Q0NVNbpkcUuG8zh1W>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CDF37780054; Sat, 13 Dec 2025 15:20:19 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoeW-IICXitk
Date: Sat, 13 Dec 2025 15:19:59 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <828c4fe7-930b-41b3-be73-62b2c76f43e4@app.fastmail.com>
In-Reply-To: <20251213-nfsd-dynathread-v1-4-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
 <20251213-nfsd-dynathread-v1-4-de755e59cbc4@kernel.org>
Subject: Re: [PATCH RFC 4/6] sunrpc: introduce the concept of a minimum number of
 threads per pool
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> Add a new pool->sp_nrthrmin field to track the minimum number of threads
> in a pool. Add min_threads parameters to both svc_set_num_threads() and
> svc_set_pool_threads(). If min_threads is non-zero, then have
> svc_set_num_threads() ensure that the number of running threads is
> between the min and the max.
>
> For now, the min_threads is always 0, but a later patch will pass the
> proper value through from nfsd.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/svc.c             |  4 ++--
>  fs/nfs/callback.c          |  8 ++++----
>  fs/nfsd/nfssvc.c           |  8 ++++----
>  include/linux/sunrpc/svc.h |  7 ++++---
>  net/sunrpc/svc.c           | 21 ++++++++++++++++++---
>  5 files changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 
> fbf132b4e08d11a91784c21ee0209fd7c149fd9d..7899205314391415dfb698ab58fe97efc426d928 
> 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -340,7 +340,7 @@ static int lockd_get(void)
>  		return -ENOMEM;
>  	}
> 
> -	error = svc_set_num_threads(serv, 1);
> +	error = svc_set_num_threads(serv, 1, 0);
>  	if (error < 0) {
>  		svc_destroy(&serv);
>  		return error;
> @@ -368,7 +368,7 @@ static void lockd_put(void)
>  	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
>  #endif
> 
> -	svc_set_num_threads(nlmsvc_serv, 0);
> +	svc_set_num_threads(nlmsvc_serv, 0, 0);
>  	timer_delete_sync(&nlmsvc_retry);
>  	svc_destroy(&nlmsvc_serv);
>  	dprintk("lockd_down: service destroyed\n");
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 
> 44b35b7f8dc022f1d8c069eaf2f7d334c93f77fc..32bbc0e688ff3988e4ba50eeb36b4808cec07c87 
> 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -119,9 +119,9 @@ static int nfs_callback_start_svc(int minorversion, 
> struct rpc_xprt *xprt,
>  	if (serv->sv_nrthreads == nrservs)
>  		return 0;
> 
> -	ret = svc_set_num_threads(serv, nrservs);
> +	ret = svc_set_num_threads(serv, nrservs, 0);
>  	if (ret) {
> -		svc_set_num_threads(serv, 0);
> +		svc_set_num_threads(serv, 0, 0);
>  		return ret;
>  	}
>  	dprintk("nfs_callback_up: service started\n");
> @@ -242,7 +242,7 @@ int nfs_callback_up(u32 minorversion, struct 
> rpc_xprt *xprt)
>  	cb_info->users++;
>  err_net:
>  	if (!cb_info->users) {
> -		svc_set_num_threads(cb_info->serv, 0);
> +		svc_set_num_threads(cb_info->serv, 0, 0);
>  		svc_destroy(&cb_info->serv);
>  	}
>  err_create:
> @@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net 
> *net)
>  	nfs_callback_down_net(minorversion, serv, net);
>  	cb_info->users--;
>  	if (cb_info->users == 0) {
> -		svc_set_num_threads(serv, 0);
> +		svc_set_num_threads(serv, 0, 0);
>  		dprintk("nfs_callback_down: service destroyed\n");
>  		svc_destroy(&cb_info->serv);
>  	}
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 
> aafec8ff588b85b0e26d40b76ef00953dc6472b4..993ed338764b0ccd7bdfb76bd6fbb5dc6ab4022d 
> 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
>  	}
> 
>  	/* Kill outstanding nfsd threads */
> -	svc_set_num_threads(serv, 0);
> +	svc_set_num_threads(serv, 0, 0);
>  	nfsd_destroy_serv(net);
>  	mutex_unlock(&nfsd_mutex);
>  }
> @@ -704,7 +704,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct 
> net *net)
> 
>  	/* Special case: When n == 1, distribute threads equally among pools. */
>  	if (n == 1)
> -		return svc_set_num_threads(nn->nfsd_serv, nthreads[0]);
> +		return svc_set_num_threads(nn->nfsd_serv, nthreads[0], 0);
> 
>  	if (n > nn->nfsd_serv->sv_nrpools)
>  		n = nn->nfsd_serv->sv_nrpools;
> @@ -732,7 +732,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct 
> net *net)
>  	for (i = 0; i < n; i++) {
>  		err = svc_set_pool_threads(nn->nfsd_serv,
>  					   &nn->nfsd_serv->sv_pools[i],
> -					   nthreads[i]);
> +					   nthreads[i], 0);
>  		if (err)
>  			goto out;
>  	}
> @@ -741,7 +741,7 @@ int nfsd_set_nrthreads(int n, int *nthreads, struct 
> net *net)
>  	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
>  		err = svc_set_pool_threads(nn->nfsd_serv,
>  					   &nn->nfsd_serv->sv_pools[i],
> -					   0);
> +					   0, 0);
>  		if (err)
>  			goto out;
>  	}
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 
> ee9260ca908c907f4373f4cfa471b272bc7bcc8c..35bd3247764ae8dc5dcdfffeea36f7cfefd13372 
> 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -36,6 +36,7 @@
>  struct svc_pool {
>  	unsigned int		sp_id;		/* pool id; also node id on NUMA */
>  	unsigned int		sp_nrthreads;	/* # of threads currently running in pool 
> */
> +	unsigned int		sp_nrthrmin;	/* Min number of threads to run per pool */
>  	unsigned int		sp_nrthrmax;	/* Max requested number of threads in pool 
> */
>  	struct lwq		sp_xprts;	/* pending transports */
>  	struct list_head	sp_all_threads;	/* all server threads */
> @@ -72,7 +73,7 @@ struct svc_serv {
>  	struct svc_stat *	sv_stats;	/* RPC statistics */
>  	spinlock_t		sv_lock;
>  	unsigned int		sv_nprogs;	/* Number of sv_programs */
> -	unsigned int		sv_nrthreads;	/* # of server threads */
> +	unsigned int		sv_nrthreads;	/* # of running server threads */
>  	unsigned int		sv_max_payload;	/* datagram payload size */
>  	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
>  	unsigned int		sv_xdrsize;	/* XDR buffer size */
> @@ -447,8 +448,8 @@ struct svc_serv *  svc_create_pooled(struct 
> svc_program *prog,
>  				     struct svc_stat *stats,
>  				     unsigned int bufsize,
>  				     int (*threadfn)(void *data));
> -int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *, 
> int);
> -int		   svc_set_num_threads(struct svc_serv *, int);
> +int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *, 
> int, unsigned int);
> +int		   svc_set_num_threads(struct svc_serv *, int, unsigned int);
>  int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
>  void		   svc_process(struct svc_rqst *rqstp);
>  void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 
> 8cd45f62ef74af6e0826b8f13cc903b0962af5e0..dc818158f8529b62dcf96c91bd9a9d4ab21df91f 
> 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -821,6 +821,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct 
> svc_pool *pool, int nrservs)
>   * @serv: RPC service to adjust
>   * @pool: Specific pool from which to choose threads
>   * @nrservs: New number of threads for @serv (0 or less means kill all 
> threads)
> + * @min_threads: minimum number of threads per pool (0 means set to 
> same as nrservs)
>   *
>   * Create or destroy threads in @pool to bring it to @nrservs.
>   *
> @@ -831,12 +832,22 @@ svc_stop_kthreads(struct svc_serv *serv, struct 
> svc_pool *pool, int nrservs)
>   * starting a thread.
>   */
>  int
> -svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int 
> nrservs)
> +svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int 
> nrservs,
> +		     unsigned int min_threads)
>  {
>  	if (!pool)
>  		return -EINVAL;
> 
>  	pool->sp_nrthrmax = nrservs;
> +	if (min_threads) {
> +		if (pool->sp_nrthreads > nrservs) {
> +			// fallthrough to update nrservs
> +		} else if (pool->sp_nrthreads < min_threads) {
> +			nrservs = min_threads;

Nit: The mixed sign types here gives me hives. Can you think of
a reason nrservs is a signed int rather than unsigned?


> +		} else {
> +			return 0;
> +		}
> +	}
>  	nrservs -= pool->sp_nrthreads;
> 
>  	if (nrservs > 0)
> @@ -851,6 +862,7 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
>   * svc_set_num_threads - adjust number of threads in serv
>   * @serv: RPC service to adjust
>   * @nrservs: New number of threads for @serv (0 or less means kill all 
> threads)
> + * @min_threads: minimum number of threads per pool (0 means set to 
> same as nrservs)
>   *
>   * Create or destroy threads in @serv to bring it to @nrservs. If there
>   * are multiple pools then the new threads or victims will be 
> distributed
> @@ -863,20 +875,23 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
>   * starting a thread.
>   */
>  int
> -svc_set_num_threads(struct svc_serv *serv, int nrservs)
> +svc_set_num_threads(struct svc_serv *serv, int nrservs, unsigned int 
> min_threads)
>  {
>  	int base = nrservs / serv->sv_nrpools;
>  	int remain = nrservs % serv->sv_nrpools;
>  	int i, err;
> 
>  	for (i = 0; i < serv->sv_nrpools; ++i) {
> +		struct svc_pool *pool = &serv->sv_pools[i];
>  		int threads = base;
> 
>  		if (remain) {
>  			++threads;
>  			--remain;
>  		}
> -		err = svc_set_pool_threads(serv, &serv->sv_pools[i], threads);
> +
> +		pool->sp_nrthrmin = min_threads;
> +		err = svc_set_pool_threads(serv, pool, threads, min_threads);
>  		if (err)
>  			break;
>  	}
>
> -- 
> 2.52.0

-- 
Chuck Lever

