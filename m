Return-Path: <linux-nfs+bounces-4925-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6639316D8
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4C01F22469
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B063B18C17B;
	Mon, 15 Jul 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9nUZH/w"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B656433B3
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053987; cv=none; b=iqm4tEAK69FVm7y7hpMCqjO7rNdPqGL+9AsKX0RA1l4Z+efQgAQ3+ztWRSUc3AybpwSDisrSYHaiR/HuFjm+LLFFRcnOJwbDB5+qenEygcgQgNbsNHGaZwUH61iiQWr0BkLert/puVpex9zAdrl3GGIfAtBo0VA2qSQuSB0QDUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053987; c=relaxed/simple;
	bh=vcc2V+hN/aBT9IbtHvkRdJGUyCQUmXGC20uEltFRKek=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1fhmMheohOKbd0UpAojbd+lq6erd6obyBWi0vjk80HctnP4SfQcTlSiKsEGGNpcEgCsHGEpeZT4zZUkeUTvSOwNa8zId09uvbz+3M28/coC5l0ba1LXE/8AH8buDqE24YQmmeJ3dsPWgrsAlK+GpDlmW6LbFRXbAe8PRRtgkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9nUZH/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DFC32782;
	Mon, 15 Jul 2024 14:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721053987;
	bh=vcc2V+hN/aBT9IbtHvkRdJGUyCQUmXGC20uEltFRKek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=B9nUZH/w7eNLDCj5y/HdlLaE2I0ZAEW9efQ8v9a3ARn4k6mq1KH1oTkF6H8ab3kif
	 dMAIBEqWz6x63HOSMhOTzUNO1kfHulevL1AzXU4NHPwQYVyqB7d5c2nS+7eXmTWJa0
	 3Nec8U9biIzYiJ2R3byVjb/pO4tWKcrQbofJl8ej0GSAtX+V0TI8rIExKwbbcvVYqZ
	 BnaD93WMTG6Tn1n8uoNnGdnCFC8oe9ti84ff4IyGtkajP8I01mD1yXuoSMkbodLYZq
	 FuTlPnTqjOaa2LBQ/ThxRxpDtVEAED6pJPvLafaWmp+V0ROBIgGzbDr6+Vnc3YYsKo
	 nvE6f9iYTdUpg==
Message-ID: <4b252735acae35757f778772503b21c75565139c.camel@kernel.org>
Subject: Re: [PATCH 05/14] sunrpc: change sp_nrthreads from atomic_t to
 unsigned int.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Steve Dickson
	 <steved@redhat.com>
Date: Mon, 15 Jul 2024 10:33:05 -0400
In-Reply-To: <cf8d0e7e1ddaa4d8e1923be8274ff0679713e471.camel@kernel.org>
References: <20240715074657.18174-1-neilb@suse.de>
	 <20240715074657.18174-6-neilb@suse.de>
	 <cf8d0e7e1ddaa4d8e1923be8274ff0679713e471.camel@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-15 at 10:12 -0400, Jeff Layton wrote:
> On Mon, 2024-07-15 at 17:14 +1000, NeilBrown wrote:
> > sp_nrthreads is only ever accessed under the service mutex
> > =C2=A0 nlmsvc_mutex nfs_callback_mutex nfsd_mutex
> > so these is no need for it to be an atomic_t.
> >=20
> > The fact that all code using it is single-threaded means that we
> > can
> > simplify svc_pool_victim and remove the temporary elevation of
> > sp_nrthreads.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> > =C2=A0fs/nfsd/nfsctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0fs/nfsd/nfssvc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
> > =C2=A0include/linux/sunrpc/svc.h |=C2=A0 4 ++--
> > =C2=A0net/sunrpc/svc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 31 +++++++++++--------------------
> > =C2=A04 files changed, 15 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> > index 5b0f2e0d7ccf..d85b6d1fa31f 100644
> > --- a/fs/nfsd/nfsctl.c
> > +++ b/fs/nfsd/nfsctl.c
> > @@ -1769,7 +1769,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff
> > *skb, struct genl_info *info)
> > =C2=A0			struct svc_pool *sp =3D &nn->nfsd_serv-
> > >sv_pools[i];
> > =C2=A0
> > =C2=A0			err =3D nla_put_u32(skb,
> > NFSD_A_SERVER_THREADS,
> > -					=C2=A0 atomic_read(&sp-
> > >sp_nrthreads));
> > +					=C2=A0 sp->sp_nrthreads);
> > =C2=A0			if (err)
> > =C2=A0				goto err_unlock;
> > =C2=A0		}
> > diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> > index 4438cdcd4873..7377422a34df 100644
> > --- a/fs/nfsd/nfssvc.c
> > +++ b/fs/nfsd/nfssvc.c
> > @@ -641,7 +641,7 @@ int nfsd_get_nrthreads(int n, int *nthreads,
> > struct net *net)
> > =C2=A0
> > =C2=A0	if (serv)
> > =C2=A0		for (i =3D 0; i < serv->sv_nrpools && i < n; i++)
> > -			nthreads[i] =3D atomic_read(&serv-
> > >sv_pools[i].sp_nrthreads);
> > +			nthreads[i] =3D serv-
> > >sv_pools[i].sp_nrthreads;
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > diff --git a/include/linux/sunrpc/svc.h
> > b/include/linux/sunrpc/svc.h
> > index e4fa25fafa97..99e9345d829e 100644
> > --- a/include/linux/sunrpc/svc.h
> > +++ b/include/linux/sunrpc/svc.h
> > @@ -33,9 +33,9 @@
> > =C2=A0 * node traffic on multi-node NUMA NFS servers.
> > =C2=A0 */
> > =C2=A0struct svc_pool {
> > -	unsigned int		sp_id;	=C2=A0=C2=A0=C2=A0=C2=A0	/* pool id; also
> > node id on NUMA */
> > +	unsigned int		sp_id;		/* pool id; also
> > node id on NUMA */
> > =C2=A0	struct lwq		sp_xprts;	/* pending
> > transports */
> > -	atomic_t		sp_nrthreads;	/* # of threads in
> > pool */
> > +	unsigned int		sp_nrthreads;	/* # of threads in
> > pool */
> > =C2=A0	struct list_head	sp_all_threads;	/* all
> > server threads */
> > =C2=A0	struct llist_head	sp_idle_threads; /* idle server
> > threads */
> > =C2=A0
> > diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
> > index 072ad115ae3d..0d8588bc693c 100644
> > --- a/net/sunrpc/svc.c
> > +++ b/net/sunrpc/svc.c
> > @@ -725,7 +725,7 @@ svc_prepare_thread(struct svc_serv *serv,
> > struct svc_pool *pool, int node)
> > =C2=A0	serv->sv_nrthreads +=3D 1;
> > =C2=A0	spin_unlock_bh(&serv->sv_lock);
> > =C2=A0
> > -	atomic_inc(&pool->sp_nrthreads);
> > +	pool->sp_nrthreads +=3D 1;
> > =C2=A0
> > =C2=A0	/* Protected by whatever lock the service uses when
> > calling
> > =C2=A0	 * svc_set_num_threads()
> > @@ -780,31 +780,22 @@ svc_pool_victim(struct svc_serv *serv, struct
> > svc_pool *target_pool,
> > =C2=A0	struct svc_pool *pool;
> > =C2=A0	unsigned int i;
> > =C2=A0
> > -retry:
> > =C2=A0	pool =3D target_pool;
> > =C2=A0
> > -	if (pool !=3D NULL) {
> > -		if (atomic_inc_not_zero(&pool->sp_nrthreads))
> > -			goto found_pool;
> > -		return NULL;
> > -	} else {
> > +	if (!pool) {
> > =C2=A0		for (i =3D 0; i < serv->sv_nrpools; i++) {
> > =C2=A0			pool =3D &serv->sv_pools[--(*state) % serv-
> > >sv_nrpools];
> > -			if (atomic_inc_not_zero(&pool-
> > >sp_nrthreads))
> > -				goto found_pool;
> > +			if (pool->sp_nrthreads)
> > +				break;
> > =C2=A0		}
> > -		return NULL;
> > =C2=A0	}
> > =C2=A0
> > -found_pool:
> > -	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > -	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > -	if (!atomic_dec_and_test(&pool->sp_nrthreads))
> > +	if (pool && pool->sp_nrthreads) {
> > +		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > +		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > =C2=A0		return pool;
> > -	/* Nothing left in this pool any more */
> > -	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
> > -	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
> > -	goto retry;
> > +	}
> > +	return NULL;
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int
> > @@ -883,7 +874,7 @@ svc_set_num_threads(struct svc_serv *serv,
> > struct svc_pool *pool, int nrservs)
> > =C2=A0	if (!pool)
> > =C2=A0		nrservs -=3D serv->sv_nrthreads;
> > =C2=A0	else
> > -		nrservs -=3D atomic_read(&pool->sp_nrthreads);
> > +		nrservs -=3D pool->sp_nrthreads;
> > =C2=A0
> > =C2=A0	if (nrservs > 0)
> > =C2=A0		return svc_start_kthreads(serv, pool, nrservs);
> > @@ -953,7 +944,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
> > =C2=A0
> > =C2=A0	list_del_rcu(&rqstp->rq_all);
> > =C2=A0
> > -	atomic_dec(&pool->sp_nrthreads);
> > +	pool->sp_nrthreads -=3D 1;
> > =C2=A0
> > =C2=A0	spin_lock_bh(&serv->sv_lock);
> > =C2=A0	serv->sv_nrthreads -=3D 1;
>=20
> I don't think svc_exit_thread is called with the nfsd_mutex held, so
> if
> several threads were exiting at the same time, they could race here.
>=20


Ok, the changelog on #7 might point out why I'm wron here.

nfsd() calls svc_exit_thread when exiting, but I missed that that would
imply that svc_stop_kthreads() is running in another task (and that the
nfsd_mutex would actually be held). It also looks like they do have to
be torn down serially as well, so there should be no race there after
all.

Either way, could I trouble you to add a comment about this above
svc_exit_thread? That's a really subtle interaction and it would be
good to document it.

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>

