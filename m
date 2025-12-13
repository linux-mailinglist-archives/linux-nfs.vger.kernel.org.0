Return-Path: <linux-nfs+bounces-17084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D927CBB450
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8E6B630010D0
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 21:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3909B30ACF1;
	Sat, 13 Dec 2025 21:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU8QHQLL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0D426FDBF;
	Sat, 13 Dec 2025 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765662958; cv=none; b=hU754Urd3unR8OsDAptjzXt04JHwNHmhv6JKsFmEXNcSZoEzvrn8Z+Z8yf89/nVL4FmK/bAzmnRYPpxPWVWqhyCOfN5DMmjwQShb+Tkwj6nGp90PJISrIvzm+pqS8aFNVlTFeF3LOgCTmrMnJs/tRP8p6hJm0Ecb1HkwJ+3825M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765662958; c=relaxed/simple;
	bh=2xXDN5GQtvuUy7mVsijHOan3JazOdGgX6Y1+ikFCXH4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bt4w5mNmNn1v04bY4eb99B18Nwm1HTJj8EJzFgzX4rY9xXg8aystowrY/IMaSgprssLAAasMncUKoZMsRvyrKUuqWXcyg1i0GyPRNhO0ciJyNo/E+OClvXunNfmfYhbZh7txOSbDfY5dRVON8YUUPzny0VDjaxPwKpA/lzIZxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU8QHQLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4AAC4CEF7;
	Sat, 13 Dec 2025 21:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765662957;
	bh=2xXDN5GQtvuUy7mVsijHOan3JazOdGgX6Y1+ikFCXH4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cU8QHQLLGZ8wh8sPIw7E0u+YqjPxa8+96Arv2e1uCfBzT/AxAw0IZjhxpygAEIc5Y
	 lChQ5emIns0cyJwpTc8OunmNFMUA4EOYQmyW2Gfvylq5vQaQUfzsd7CGRXVBwThZ0l
	 KjjOkcIfO/J5+nPMbDvqx63ywqHY4LGfi/PWiNW99s6vvatsKYyrUpmud/GV2ePQEz
	 kZ6VKWe/Y5H+gujGTaIzc4Q+tUWROJTF4Kjls7hwSJ4YgxUY0BXgljcvK+fsi0k3/0
	 fRqXj5n0juF3kZCfm5xol1kiFP3xNH0adm7NARaI4B78obpz127hh8kPqv60GrhTmT
	 nKyFvi3fFaHhw==
Message-ID: <a5e0fbe428b85327793cac81207042b7d1d3f455.camel@kernel.org>
Subject: Re: [PATCH RFC 1/6] sunrpc: split svc_set_num_threads() into two
 functions
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <cel@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>,  Tom Talpey <tom@talpey.com>, Trond Myklebust
 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 14 Dec 2025 06:55:53 +0900
In-Reply-To: <587f5358-fdb2-4834-b50e-6d48c9b43214@app.fastmail.com>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
	 <20251213-nfsd-dynathread-v1-1-de755e59cbc4@kernel.org>
	 <587f5358-fdb2-4834-b50e-6d48c9b43214@app.fastmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-12-13 at 14:29 -0500, Chuck Lever wrote:
>=20
> On Fri, Dec 12, 2025, at 5:39 PM, Jeff Layton wrote:
> > svc_set_num_threads() will set the number of running threads for a give=
n
> > pool. If the pool argument is set to NULL however, it will distribute
> > the threads among all of the pools evenly.
> >=20
> > These divergent codepaths complicate the move to dynamic threading.
> > Simplify the API by splitting these two cases into different helpers:
> >=20
> > Add a new svc_set_pool_threads() function that sets the number of
> > threads in a single, given pool. Modify svc_set_num_threads() to
> > distribute the threads evenly between all of the pools and then call
> > svc_set_pool_threads() for each.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/lockd/svc.c             |  4 ++--
> >  fs/nfs/callback.c          |  8 +++----
> >  fs/nfsd/nfssvc.c           | 21 ++++++++----------
> >  include/linux/sunrpc/svc.h |  3 ++-
> >  net/sunrpc/svc.c           | 54 +++++++++++++++++++++++++++++++++++++-=
--------
> >  5 files changed, 61 insertions(+), 29 deletions(-)
> >=20
> > diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> > index=20
> > d68afa196535a8785bab2931c2b14f03a1174ef9..fbf132b4e08d11a91784c21ee0209=
fd7c149fd9d=20
> > 100644
> > --- a/fs/lockd/svc.c
> > +++ b/fs/lockd/svc.c
> > @@ -340,7 +340,7 @@ static int lockd_get(void)
> >  		return -ENOMEM;
> >  	}
> >=20
> > -	error =3D svc_set_num_threads(serv, NULL, 1);
> > +	error =3D svc_set_num_threads(serv, 1);
> >  	if (error < 0) {
> >  		svc_destroy(&serv);
> >  		return error;
> > @@ -368,7 +368,7 @@ static void lockd_put(void)
> >  	unregister_inet6addr_notifier(&lockd_inet6addr_notifier);
> >  #endif
> >=20
> > -	svc_set_num_threads(nlmsvc_serv, NULL, 0);
> > +	svc_set_num_threads(nlmsvc_serv, 0);
> >  	timer_delete_sync(&nlmsvc_retry);
> >  	svc_destroy(&nlmsvc_serv);
> >  	dprintk("lockd_down: service destroyed\n");
> > diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
> > index=20
> > c8b837006bb27277ab34fe516f1b63992fee9b7f..44b35b7f8dc022f1d8c069eaf2f7d=
334c93f77fc=20
> > 100644
> > --- a/fs/nfs/callback.c
> > +++ b/fs/nfs/callback.c
> > @@ -119,9 +119,9 @@ static int nfs_callback_start_svc(int minorversion,=
=20
> > struct rpc_xprt *xprt,
> >  	if (serv->sv_nrthreads =3D=3D nrservs)
> >  		return 0;
> >=20
> > -	ret =3D svc_set_num_threads(serv, NULL, nrservs);
> > +	ret =3D svc_set_num_threads(serv, nrservs);
> >  	if (ret) {
> > -		svc_set_num_threads(serv, NULL, 0);
> > +		svc_set_num_threads(serv, 0);
> >  		return ret;
> >  	}
> >  	dprintk("nfs_callback_up: service started\n");
> > @@ -242,7 +242,7 @@ int nfs_callback_up(u32 minorversion, struct=20
> > rpc_xprt *xprt)
> >  	cb_info->users++;
> >  err_net:
> >  	if (!cb_info->users) {
> > -		svc_set_num_threads(cb_info->serv, NULL, 0);
> > +		svc_set_num_threads(cb_info->serv, 0);
> >  		svc_destroy(&cb_info->serv);
> >  	}
> >  err_create:
> > @@ -268,7 +268,7 @@ void nfs_callback_down(int minorversion, struct net=
=20
> > *net)
> >  	nfs_callback_down_net(minorversion, serv, net);
> >  	cb_info->users--;
> >  	if (cb_info->users =3D=3D 0) {
> > -		svc_set_num_threads(serv, NULL, 0);
> > +		svc_set_num_threads(serv, 0);
> >  		dprintk("nfs_callback_down: service destroyed\n");
> >  		svc_destroy(&cb_info->serv);
> >  	}
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index=20
> > 93f7435cafd2362d9ddb28815277c824067cb370..aafec8ff588b85b0e26d40b76ef00=
953dc6472b4=20
> > 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -594,7 +594,7 @@ void nfsd_shutdown_threads(struct net *net)
> >  	}
> >=20
> >  	/* Kill outstanding nfsd threads */
> > -	svc_set_num_threads(serv, NULL, 0);
> > +	svc_set_num_threads(serv, 0);
> >  	nfsd_destroy_serv(net);
> >  	mutex_unlock(&nfsd_mutex);
> >  }
> > @@ -702,12 +702,9 @@ int nfsd_set_nrthreads(int n, int *nthreads,=20
> > struct net *net)
> >  	if (nn->nfsd_serv =3D=3D NULL || n <=3D 0)
> >  		return 0;
> >=20
> > -	/*
> > -	 * Special case: When n =3D=3D 1, pass in NULL for the pool, so that =
the
> > -	 * change is distributed equally among them.
> > -	 */
> > +	/* Special case: When n =3D=3D 1, distribute threads equally among po=
ols. */
> >  	if (n =3D=3D 1)
> > -		return svc_set_num_threads(nn->nfsd_serv, NULL, nthreads[0]);
> > +		return svc_set_num_threads(nn->nfsd_serv, nthreads[0]);
> >=20
> >  	if (n > nn->nfsd_serv->sv_nrpools)
> >  		n =3D nn->nfsd_serv->sv_nrpools;
> > @@ -733,18 +730,18 @@ int nfsd_set_nrthreads(int n, int *nthreads,=20
> > struct net *net)
> >=20
> >  	/* apply the new numbers */
> >  	for (i =3D 0; i < n; i++) {
> > -		err =3D svc_set_num_threads(nn->nfsd_serv,
> > -					  &nn->nfsd_serv->sv_pools[i],
> > -					  nthreads[i]);
> > +		err =3D svc_set_pool_threads(nn->nfsd_serv,
> > +					   &nn->nfsd_serv->sv_pools[i],
> > +					   nthreads[i]);
> >  		if (err)
> >  			goto out;
> >  	}
> >=20
> >  	/* Anything undefined in array is considered to be 0 */
> >  	for (i =3D n; i < nn->nfsd_serv->sv_nrpools; ++i) {
> > -		err =3D svc_set_num_threads(nn->nfsd_serv,
> > -					  &nn->nfsd_serv->sv_pools[i],
> > -					  0);
> > +		err =3D svc_set_pool_threads(nn->nfsd_serv,
> > +					   &nn->nfsd_serv->sv_pools[i],
> > +					   0);
> >  		if (err)
> >  			goto out;
> >  	}
> > diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
> > index=20
> > 5506d20857c318774cd223272d4b0022cc19ffb8..dd5fbbf8b3d39df6c17a7624edf34=
4557fffd32c=20
> > 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -446,7 +446,8 @@ struct svc_serv *  svc_create_pooled(struct=20
> > svc_program *prog,
> >  				     struct svc_stat *stats,
> >  				     unsigned int bufsize,
> >  				     int (*threadfn)(void *data));
> > -int		   svc_set_num_threads(struct svc_serv *, struct svc_pool *, int)=
;
> > +int		   svc_set_pool_threads(struct svc_serv *, struct svc_pool *,=20
> > int);
> > +int		   svc_set_num_threads(struct svc_serv *, int);
> >  int		   svc_pool_stats_open(struct svc_info *si, struct file *file);
> >  void		   svc_process(struct svc_rqst *rqstp);
> >  void		   svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp);
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index=20
> > 4704dce7284eccc9e2bc64cf22947666facfa86a..3fe5a7f8e57e3fa3837265ec06884=
b357d5373ff=20
> > 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -856,15 +856,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct=
=20
> > svc_pool *pool, int nrservs)
> >  }
> >=20
> >  /**
> > - * svc_set_num_threads - adjust number of threads per RPC service
> > + * svc_set_pool_threads - adjust number of threads per pool
> >   * @serv: RPC service to adjust
> > - * @pool: Specific pool from which to choose threads, or NULL
> > + * @pool: Specific pool from which to choose threads
> >   * @nrservs: New number of threads for @serv (0 or less means kill all=
=20
> > threads)
> >   *
> > - * Create or destroy threads to make the number of threads for @serv=
=20
> > the
> > - * given number. If @pool is non-NULL, change only threads in that=20
> > pool;
> > - * otherwise, round-robin between all pools for @serv. @serv's
> > - * sv_nrthreads is adjusted for each thread created or destroyed.
> > + * Create or destroy threads in @pool to bring it to @nrservs.
> >   *
> >   * Caller must ensure mutual exclusion between this and server startup=
=20
> > or
> >   * shutdown.
> > @@ -873,12 +870,12 @@ svc_stop_kthreads(struct svc_serv *serv, struct=
=20
> > svc_pool *pool, int nrservs)
> >   * starting a thread.
> >   */
> >  int
> > -svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int=
=20
> > nrservs)
> > +svc_set_pool_threads(struct svc_serv *serv, struct svc_pool *pool, int=
=20
> > nrservs)
> >  {
> >  	if (!pool)
> > -		nrservs -=3D serv->sv_nrthreads;
> > -	else
> > -		nrservs -=3D pool->sp_nrthreads;
> > +		return -EINVAL;
> > +
> > +	nrservs -=3D pool->sp_nrthreads;
> >=20
> >  	if (nrservs > 0)
> >  		return svc_start_kthreads(serv, pool, nrservs);
> > @@ -886,6 +883,43 @@ svc_set_num_threads(struct svc_serv *serv, struct=
=20
> > svc_pool *pool, int nrservs)
> >  		return svc_stop_kthreads(serv, pool, nrservs);
> >  	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(svc_set_pool_threads);
> > +
> > +/**
> > + * svc_set_num_threads - adjust number of threads in serv
> > + * @serv: RPC service to adjust
> > + * @nrservs: New number of threads for @serv (0 or less means kill all=
=20
> > threads)
> > + *
> > + * Create or destroy threads in @serv to bring it to @nrservs. If ther=
e
> > + * are multiple pools then the new threads or victims will be=20
> > distributed
> > + * evenly among them.
> > + *
> > + * Caller must ensure mutual exclusion between this and server startup=
=20
> > or
> > + * shutdown.
> > + *
> > + * Returns zero on success or a negative errno if an error occurred=
=20
> > while
> > + * starting a thread.
> > + */
> > +int
> > +svc_set_num_threads(struct svc_serv *serv, int nrservs)
> > +{
> > +	int base =3D nrservs / serv->sv_nrpools;
> > +	int remain =3D nrservs % serv->sv_nrpools;
> > +	int i, err;
> > +
> > +	for (i =3D 0; i < serv->sv_nrpools; ++i) {
>=20
> If sv_nrpools happens to be zero, then the loop doesn't
> execute at all, and err is left containing stack garbage.
> Is sv_nrpools guaranteed to be non-zero? If not then err
> needs to be initialized before the loop runs. I see that
> nfsd_set_nrthreads() in fs/nfsd/nfssvc.c has "int err =3D 0"
> for a similar loop pattern.
>=20

sv_nrpools should always be non-zero. There are many places in the rpc
layer that depend on having at least one pool. From __svc_create:

        serv->sv_nrpools =3D npools;
        serv->sv_pools =3D
                kcalloc(serv->sv_nrpools, sizeof(struct svc_pool),
                        GFP_KERNEL);
        if (!serv->sv_pools) {
                kfree(serv);
                return NULL;
        }

I think kcalloc returns NULL if you pass it 0 for "n", so creation
should fail if that happens. None of the in-tree callers ever pass in 0
for the npools, but maybe that's worth an explicit check in
__svc_create(). I can add one.

>=20
> > +		int threads =3D base;
> > +
> > +		if (remain) {
> > +			++threads;
> > +			--remain;
> > +		}
> > +		err =3D svc_set_pool_threads(serv, &serv->sv_pools[i], threads);
> > +		if (err)
> > +			break;
> > +	}
> > +	return err;
> > +}
> >  EXPORT_SYMBOL_GPL(svc_set_num_threads);
> >=20
> >  /**
> >=20
> > --=20
> > 2.52.0

--=20
Jeff Layton <jlayton@kernel.org>

