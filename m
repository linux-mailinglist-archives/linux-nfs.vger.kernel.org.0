Return-Path: <linux-nfs+bounces-17075-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4D0CBB2AD
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 20:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00862300B2B9
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7324B2FB093;
	Sat, 13 Dec 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgs3dNy5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5BD2E8B98
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765654188; cv=none; b=VEiBrl0at+8uyoMAgDMw61ANml3TMCQoAHBMtco3R6xZAESjOgil+283aaMNlcotG98vEtDO4D9nwzkc95MiMv/B8he5vDtsn6CMrwghnIQpvXYnHUElhEGJQvG2BCbmWgJr3Eh7mqVnwNmdWnY4iobnbA6qMEft+6ScgHuFzdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765654188; c=relaxed/simple;
	bh=stCe8K3IoCHf6uw39LIQ26Ggv9yVK6scW0iXsoKmITI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uWvTbeE81KPfFErfx2xE4tChvchKrvYODUrr3f9vfmBkNRHHUwIl5xtJkJrt7ZNdAhsBRUmP6X1pUaJE6B0P8KUo+1Iql40jD7idSIPuJp8X5ZFdZdriar6UdeSEbRs7aqtxfYhUm5hFdJPFs0K8owespBvCWQpPb/pJ7iiOv3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgs3dNy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E426C4CEF7;
	Sat, 13 Dec 2025 19:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765654187;
	bh=stCe8K3IoCHf6uw39LIQ26Ggv9yVK6scW0iXsoKmITI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Dgs3dNy5+Bm+7Dw2QwIlR4i6Bg28ig0lQwcXTtmYduWcUVFtl68C94CA0lQHozDb6
	 Vk4EoPbv0G3rhtOYXKgOARN2VJETzDzfvTnfnu2vZ9bb8MvN2ruu46GMQ44gfCgzNH
	 6/9SOQL2wpsB2ZLuxYhsG43kFJTTx3POsTUdDZSpgtNcCodlG/i1Uf30VqIyTRbvY5
	 Z5y14ZizyO6vKCmwcoM6eePnLMCLTYvnb6fv5swqz4yaELB7BMnZLksOmzBU/w1fNA
	 tWtf7lMtLj5u6S9l2d1MIDY4tXXGgPjvDfhaksQl81GeSppu0sQi1PvJApG+6ggEdb
	 0j0uVgXDUQI5g==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7785AF40077;
	Sat, 13 Dec 2025 14:29:46 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Sat, 13 Dec 2025 14:29:46 -0500
X-ME-Sender: <xms:qr49aTlV55kbfKweOdIhS0xDzNbeBM5g91XOcyw2x0xKQx26CMFWNg>
    <xme:qr49aRpTKzgmGkiRJKX-OoMZQo40ZOUGLzbQd29l_-aRPBG1WQ6NQQv12VHYgS3B4
    7Yh0aDU0LHvim_e-h5SVBfN0_f2VXlOHorQl3Q2aawbXBmqCkCUSr8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudeltdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:qr49abwu1U0D1FH8dARxULsc4zcL-pZtKOOo7XH5nZ-f0QbaZ1noqA>
    <xmx:qr49aZRFFKLyjYl6iPJPLOqq10YlSp9FFx18EWAWnbXaOSm_9ZT6tg>
    <xmx:qr49aQIBVUnrs_uEcPu9BgZeUA0E003pupCB9RJorwyytRHB6WI5gA>
    <xmx:qr49aYVKYwStS9COTEg6FAaWe6ijKwptqWoFfGt6JFbsVdQKOycLzA>
    <xmx:qr49acT6UKV2AwilmlsTYyh5-LC-cULpekVU63q5wXBbAjTycv8SEbwu>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 56C9A78006C; Sat, 13 Dec 2025 14:29:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Aqo9qCY41197
Date: Sat, 13 Dec 2025 14:29:07 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>,
 "Chuck Lever" <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <587f5358-fdb2-4834-b50e-6d48c9b43214@app.fastmail.com>
In-Reply-To: <20251213-nfsd-dynathread-v1-1-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
 <20251213-nfsd-dynathread-v1-1-de755e59cbc4@kernel.org>
Subject: Re: [PATCH RFC 1/6] sunrpc: split svc_set_num_threads() into two functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> svc_set_num_threads() will set the number of running threads for a given
> pool. If the pool argument is set to NULL however, it will distribute
> the threads among all of the pools evenly.
>
> These divergent codepaths complicate the move to dynamic threading.
> Simplify the API by splitting these two cases into different helpers:
>
> Add a new svc_set_pool_threads() function that sets the number of
> threads in a single, given pool. Modify svc_set_num_threads() to
> distribute the threads evenly between all of the pools and then call
> svc_set_pool_threads() for each.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/lockd/svc.c             |  4 ++--
>  fs/nfs/callback.c          |  8 +++----
>  fs/nfsd/nfssvc.c           | 21 ++++++++----------
>  include/linux/sunrpc/svc.h |  3 ++-
>  net/sunrpc/svc.c           | 54 +++++++++++++++++++++++++++++++++++++---------
>  5 files changed, 61 insertions(+), 29 deletions(-)
>
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 
> d68afa196535a8785bab2931c2b14f03a1174ef9..fbf132b4e08d11a91784c21ee0209fd7c149fd9d 
> 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -340,7 +340,7 @@ static int lockd_get(void)
>  		return -ENOMEM;
>  	}
> 
> -	error = svc_set_num_threads(serv, NULL, 1);
> +	error = svc_set_num_threads(serv, 1);
>  	if (error < 0) {
>  		svc_destroy(&serv);
>  		return error;
> @@ -368,7 +368,7 @@ static void lockd_put(void)
>  	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
>  #endif
> 
> -	svc_set_num_threads(nlmsvc_serv, NULL, 0);
> +	svc_set_num_threads(nlmsvc_serv, 0);
>  	timer_delete_sync(&nlmsvc_retry);
>  	svc_destroy(&nlmsvc_serv);
>  	dprintk("lockd_down: service destroyed\n");
> diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> index 
> c8b837006bb27277ab34fe516f1b63992fee9b7f..44b35b7f8dc022f1d8c069eaf2f7d334c93f77fc 
> 100644
> --- a/fs/nfs/callback.c
> +++ b/fs/nfs/callback.c
> @@ -119,9 +119,9 @@ static int nfs_callback_start_svc(int minorversion, 
> struct rpc_xprt *xprt,
>  	if (serv->sv_nrthreads == nrservs)
>  		return 0;
> 
> -	ret = svc_set_num_threads(serv, NULL, nrservs);
> +	ret = svc_set_num_threads(serv, nrservs);
>  	if (ret) {
> -		svc_set_num_threads(serv, NULL, 0);
> +		svc_set_num_threads(serv, 0);
>  		return ret;
>  	}
>  	dprintk("nfs_callback_up: service started\n");
> @@ -242,7 +242,7 @@ int nfs_callback_up(u32 minorversion, struct 
> rpc_xprt *xprt)
>  	cb_info->users++;
>  err_net:
>  	if (!cb_info->users) {
> -		svc_set_num_threads(cb_info->serv, NULL, 0);
> +		svc_set_num_threads(cb_info->serv, 0);
>  		svc_destroy(&cb_info->serv);
>  	}
>  err_create:
> @@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net 
> *net)
>  	nfs_callback_down_net(minorversion, serv, net);
>  	cb_info->users--;
>  	if (cb_info->users == 0) {
> -		svc_set_num_threads(serv, NULL, 0);
> +		svc_set_num_threads(serv, 0);
>  		dprintk("nfs_callback_down: service destroyed\n");
>  		svc_destroy(&cb_info->serv);
>  	}
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 
> 93f7435cafd2362d9ddb28815277c824067cb370..aafec8ff588b85b0e26d40b76ef00953dc6472b4 
> 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
>  	}
> 
>  	/* Kill outstanding nfsd threads */
> -	svc_set_num_threads(serv, NULL, 0);
> +	svc_set_num_threads(serv, 0);
>  	nfsd_destroy_serv(net);
>  	mutex_unlock(&nfsd_mutex);
>  }
> @@ -702,12 +702,9 @@ int nfsd_set_nrthreads(int n, int *nthreads, 
> struct net *net)
>  	if (nn->nfsd_serv == NULL || n <= 0)
>  		return 0;
> 
> -	/*
> -	 * Special case: When n == 1, pass in NULL for the pool, so that the
> -	 * change is distributed equally among them.
> -	 */
> +	/* Special case: When n == 1, distribute threads equally among pools. */
>  	if (n == 1)
> -		return svc_set_num_threads(nn->nfsd_serv, NULL, nthreads[0]);
> +		return svc_set_num_threads(nn->nfsd_serv, nthreads[0]);
> 
>  	if (n > nn->nfsd_serv->sv_nrpools)
>  		n = nn->nfsd_serv->sv_nrpools;
> @@ -733,18 +730,18 @@ int nfsd_set_nrthreads(int n, int *nthreads, 
> struct net *net)
> 
>  	/* apply the new numbers */
>  	for (i = 0; i < n; i++) {
> -		err = svc_set_num_threads(nn->nfsd_serv,
> -					  &nn->nfsd_serv->sv_pools[i],
> -					  nthreads[i]);
> +		err = svc_set_pool_threads(nn->nfsd_serv,
> +					   &nn->nfsd_serv->sv_pools[i],
> +					   nthreads[i]);
>  		if (err)
>  			goto out;
>  	}
> 
>  	/* Anything undefined in array is considered to be 0 */
>  	for (i = n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> -		err = svc_set_num_threads(nn->nfsd_serv,
> -					  &nn->nfsd_serv->sv_pools[i],
> -					  0);
> +		err = svc_set_pool_threads(nn->nfsd_serv,
> +					   &nn->nfsd_serv->sv_pools[i],
> +					   0);
>  		if (err)
>  			goto out;
>  	}
> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> index 
> 5506d20857c318774cd223272d4b0022cc19ffb8..dd5fbbf8b3d39df6c17a7624edf344557fffd32c 
> 100644
> --- a/include/linux/sunrpc/svc.h
> +++ b/include/linux/sunrpc/svc.h
> @@ -446,7 +446,8 @@ struct svc_serv *  svc_create_pooled(struct 
> svc_program *prog,
>  				     struct svc_stat *stats,
>  				     unsigned int bufsize,
>  				     int (*threadfn)(void *data));
> -int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int);
> +int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *, 
> int);
> +int		   svc_set_num_threads(struct svc_serv *, int);
>  int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
>  void		   svc_process(struct svc_rqst *rqstp);
>  void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> index 
> 4704dce7284eccc9e2bc64cf22947666facfa86a..3fe5a7f8e57e3fa3837265ec06884b357d5373ff 
> 100644
> --- a/net/sunrpc/svc.c
> +++ b/net/sunrpc/svc.c
> @@ -856,15 +856,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct 
> svc_pool *pool, int nrservs)
>  }
> 
>  /**
> - * svc_set_num_threads - adjust number of threads per RPC service
> + * svc_set_pool_threads - adjust number of threads per pool
>   * @serv: RPC service to adjust
> - * @pool: Specific pool from which to choose threads, or NULL
> + * @pool: Specific pool from which to choose threads
>   * @nrservs: New number of threads for @serv (0 or less means kill all 
> threads)
>   *
> - * Create or destroy threads to make the number of threads for @serv 
> the
> - * given number. If @pool is non-NULL, change only threads in that 
> pool;
> - * otherwise, round-robin between all pools for @serv. @serv's
> - * sv_nrthreads is adjusted for each thread created or destroyed.
> + * Create or destroy threads in @pool to bring it to @nrservs.
>   *
>   * Caller must ensure mutual exclusion between this and server startup 
> or
>   * shutdown.
> @@ -873,12 +870,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct 
> svc_pool *pool, int nrservs)
>   * starting a thread.
>   */
>  int
> -svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int 
> nrservs)
> +svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int 
> nrservs)
>  {
>  	if (!pool)
> -		nrservs -= serv->sv_nrthreads;
> -	else
> -		nrservs -= pool->sp_nrthreads;
> +		return -EINVAL;
> +
> +	nrservs -= pool->sp_nrthreads;
> 
>  	if (nrservs > 0)
>  		return svc_start_kthreads(serv, pool, nrservs);
> @@ -886,6 +883,43 @@ svc_set_num_threads(struct svc_serv *serv, struct 
> svc_pool *pool, int nrservs)
>  		return svc_stop_kthreads(serv, pool, nrservs);
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(svc_set_pool_threads);
> +
> +/**
> + * svc_set_num_threads - adjust number of threads in serv
> + * @serv: RPC service to adjust
> + * @nrservs: New number of threads for @serv (0 or less means kill all 
> threads)
> + *
> + * Create or destroy threads in @serv to bring it to @nrservs. If there
> + * are multiple pools then the new threads or victims will be 
> distributed
> + * evenly among them.
> + *
> + * Caller must ensure mutual exclusion between this and server startup 
> or
> + * shutdown.
> + *
> + * Returns zero on success or a negative errno if an error occurred 
> while
> + * starting a thread.
> + */
> +int
> +svc_set_num_threads(struct svc_serv *serv, int nrservs)
> +{
> +	int base = nrservs / serv->sv_nrpools;
> +	int remain = nrservs % serv->sv_nrpools;
> +	int i, err;
> +
> +	for (i = 0; i < serv->sv_nrpools; ++i) {

If sv_nrpools happens to be zero, then the loop doesn't
execute at all, and err is left containing stack garbage.
Is sv_nrpools guaranteed to be non-zero? If not then err
needs to be initialized before the loop runs. I see that
nfsd_set_nrthreads() in fs/nfsd/nfssvc.c has "int err = 0"
for a similar loop pattern.


> +		int threads = base;
> +
> +		if (remain) {
> +			++threads;
> +			--remain;
> +		}
> +		err = svc_set_pool_threads(serv, &serv->sv_pools[i], threads);
> +		if (err)
> +			break;
> +	}
> +	return err;
> +}
>  EXPORT_SYMBOL_GPL(svc_set_num_threads);
> 
>  /**
>
> -- 
> 2.52.0

-- 
Chuck Lever

