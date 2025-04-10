Return-Path: <linux-nfs+bounces-11093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB1A84D9B
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 21:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEABA1B61A43
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Apr 2025 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D01957FF;
	Thu, 10 Apr 2025 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPI3Nywp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F831C6BE
	for <linux-nfs@vger.kernel.org>; Thu, 10 Apr 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315024; cv=none; b=WQb93jYIRo1V7LbgeZCA3Bwy4ES6f71L8KD5cmERS6kW5gnFile+LUg3AnazoPiYlshHbA7sqOArDJ1bQkFX1760saK911uMeiovH2AYQ3l+pmOPR+oTSOKVk5/ZiXq6fy2m6lo0rP8rDXI2zMQX09jwfoYzS/piGBrJwcK1b8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315024; c=relaxed/simple;
	bh=X8jJSv8YtLsk+uRZvmlk+T9lGMYS+7g/yS/ABILlk8o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g3zBRbxyATkoXsWDMl3RIGh7jwSoEGlDgGhf13dq2ezoC1LtCMn8tHcpF4Ylk+qDBvtaHQe5SZF7xcvVcMEud1PXKpyyFSFSxW2JnJN2qSCYwgb/7XOoM1vFLWcd1O8MkFke87EVoigINaaqW3Hli5J7zXfNkxNJK+bafhq/Cak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPI3Nywp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC04C4CEDD;
	Thu, 10 Apr 2025 19:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744315024;
	bh=X8jJSv8YtLsk+uRZvmlk+T9lGMYS+7g/yS/ABILlk8o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jPI3NywpkFaALqExKKFg4g+DA6es7QkSDbRQzwb3Na/cQnENi9CB93IHlzhS/gbvC
	 uYhOXYX2ZPOxBmV6PR5NXtYtaHVI0JicJYd3p4ApgV4n7vn/ik7aEGPpekWh0eW/sK
	 jIQJ6Y3P44UxB08wiIsF94RDjjr5NV3LVFdQkPF+kqjFgJkHH1c5PhH0xhyWvL4Sms
	 7ACjBEa5YjJWr2VXbKINEcrtUekkNALBiqJN2DHTjC5cjoiboSWITOLNMmnAtPT03J
	 DIHDtiirS9KwQfcmiKv33sqt5JoVBVeRZSzZQhKvm0+f8yBHTM3DdsT0nxQ8sTC7bM
	 99H7tE2J/9vhA==
Message-ID: <1f720a61aa08a22f27172ebfa988b62238bcfaf2.camel@kernel.org>
Subject: Re: [PATCH 2/2] nfs: move the nfs4_data_server_cache into struct
 nfs_net
From: Jeff Layton <jlayton@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>, Trond Myklebust
	 <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, Sargun Dillon <sargun@sargun.me>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.keornel.org
Date: Thu, 10 Apr 2025 15:57:02 -0400
In-Reply-To: <64123840-4fd7-4d76-ae99-c92138d20a4a@oracle.com>
References: <20250410-nfs-ds-netns-v1-0-cc6236e84190@kernel.org>
	 <20250410-nfs-ds-netns-v1-2-cc6236e84190@kernel.org>
	 <64123840-4fd7-4d76-ae99-c92138d20a4a@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-10 at 15:39 -0400, Anna Schumaker wrote:
> Hi Jeff,
>=20
> On 4/10/25 2:12 PM, Jeff Layton wrote:
> > Since struct nfs4_pnfs_ds should not be shared between net namespaces,
> > move from a global list of objects to a per-netns list and spinlock.
> >=20
> > Tested-by: Sargun Dillon <sargun@sargun.me>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfs/client.c   |  4 ++++
> >  fs/nfs/inode.c    |  3 +++
> >  fs/nfs/netns.h    |  6 +++++-
> >  fs/nfs/pnfs_nfs.c | 31 +++++++++++++++++--------------
> >  4 files changed, 29 insertions(+), 15 deletions(-)
> >=20
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 9500b46005b0148a5a9a7d464095ca944de06bb5..81c0f780ff82c8a020fafdb=
3df72552c8e6e535f 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -1199,6 +1199,10 @@ void nfs_clients_init(struct net *net)
> >  	INIT_LIST_HEAD(&nn->nfs_volume_list);
> >  #if IS_ENABLED(CONFIG_NFS_V4)
> >  	idr_init(&nn->cb_ident_idr);
> > +#if IS_ENABLED(CONFIG_NFS_V4_1)
> > +	INIT_LIST_HEAD(&nn->nfs4_data_server_cache);
> > +	spin_lock_init(&nn->nfs4_data_server_lock);
> > +#endif
> >  #endif
> >  	spin_lock_init(&nn->nfs_client_lock);
> >  	nn->boot_time =3D ktime_get_real();
> > diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> > index 119e447758b994b34e55e7b28fd4f34fa089e2e1..ee796a726a1e4b0dfbd199c=
c62176c6802692671 100644
> > --- a/fs/nfs/inode.c
> > +++ b/fs/nfs/inode.c
> > @@ -2559,6 +2559,9 @@ static int nfs_net_init(struct net *net)
> > =20
> >  static void nfs_net_exit(struct net *net)
> >  {
> > +	struct nfs_net *nn =3D net_generic(net, nfs_net_id);
> > +
> > +	WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
>=20
> nfs4_data_server_cache is defined under an #if IS_ENABLED(CONFIG_NFS_V4_1=
) block,
> so the compiler complains if this isn't enabled:
>=20
> fs/nfs/inode.c:2564:32: error: no member named 'nfs4_data_server_cache' i=
n 'struct nfs_net'
>  2564 |         WARN_ON_ONCE(!list_empty(&nn->nfs4_data_server_cache));
>=20
> Anna
>=20

Good catch. I'll send v2 with that fixed.

Thanks!

> >  	rpc_proc_unregister(net, "nfs");
> >  	nfs_fs_proc_net_exit(net);
> >  	nfs_clients_exit(net);
> > diff --git a/fs/nfs/netns.h b/fs/nfs/netns.h
> > index a68b21603ea9a867ba513e2a667b08fbc6d80dd8..557cf822002663b79571946=
10d103210b159e5c4 100644
> > --- a/fs/nfs/netns.h
> > +++ b/fs/nfs/netns.h
> > @@ -31,7 +31,11 @@ struct nfs_net {
> >  	unsigned short nfs_callback_tcpport;
> >  	unsigned short nfs_callback_tcpport6;
> >  	int cb_users[NFS4_MAX_MINOR_VERSION + 1];
> > -#endif
> > +#if IS_ENABLED(CONFIG_NFS_V4_1)
> > +	struct list_head nfs4_data_server_cache;
> > +	spinlock_t nfs4_data_server_lock;
> > +#endif /* CONFIG_NFS_V4_1 */
> > +#endif /* CONFIG_NFS_V4 */
> >  	struct nfs_netns_client *nfs_client;
> >  	spinlock_t nfs_client_lock;
> >  	ktime_t boot_time;
> > diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> > index 2ee20a0f0b36d3b38e35c4cad966b9d58fa822f4..91ef486f40b943a1dc55164=
e610378ef73781e55 100644
> > --- a/fs/nfs/pnfs_nfs.c
> > +++ b/fs/nfs/pnfs_nfs.c
> > @@ -16,6 +16,7 @@
> >  #include "nfs4session.h"
> >  #include "internal.h"
> >  #include "pnfs.h"
> > +#include "netns.h"
> > =20
> >  #define NFSDBG_FACILITY		NFSDBG_PNFS
> > =20
> > @@ -504,14 +505,14 @@ EXPORT_SYMBOL_GPL(pnfs_generic_commit_pagelist);
> >  /*
> >   * Data server cache
> >   *
> > - * Data servers can be mapped to different device ids.
> > - * nfs4_pnfs_ds reference counting
> > + * Data servers can be mapped to different device ids, but should
> > + * never be shared between net namespaces.
> > + *
> > + * nfs4_pnfs_ds reference counting:
> >   *   - set to 1 on allocation
> >   *   - incremented when a device id maps a data server already in the =
cache.
> >   *   - decremented when deviceid is removed from the cache.
> >   */
> > -static DEFINE_SPINLOCK(nfs4_ds_cache_lock);
> > -static LIST_HEAD(nfs4_data_server_cache);
> > =20
> >  /* Debug routines */
> >  static void
> > @@ -604,12 +605,12 @@ _same_data_server_addrs_locked(const struct list_=
head *dsaddrs1,
> >   * Lookup DS by addresses.  nfs4_ds_cache_lock is held
> >   */
> >  static struct nfs4_pnfs_ds *
> > -_data_server_lookup_locked(const struct net *net, const struct list_he=
ad *dsaddrs)
> > +_data_server_lookup_locked(const struct nfs_net *nn, const struct list=
_head *dsaddrs)
> >  {
> >  	struct nfs4_pnfs_ds *ds;
> > =20
> > -	list_for_each_entry(ds, &nfs4_data_server_cache, ds_node)
> > -		if (ds->ds_net =3D=3D net && _same_data_server_addrs_locked(&ds->ds_=
addrs, dsaddrs))
> > +	list_for_each_entry(ds, &nn->nfs4_data_server_cache, ds_node)
> > +		if (_same_data_server_addrs_locked(&ds->ds_addrs, dsaddrs))
> >  			return ds;
> >  	return NULL;
> >  }
> > @@ -653,10 +654,11 @@ static void destroy_ds(struct nfs4_pnfs_ds *ds)
> > =20
> >  void nfs4_pnfs_ds_put(struct nfs4_pnfs_ds *ds)
> >  {
> > -	if (refcount_dec_and_lock(&ds->ds_count,
> > -				&nfs4_ds_cache_lock)) {
> > +	struct nfs_net *nn =3D net_generic(ds->ds_net, nfs_net_id);
> > +
> > +	if (refcount_dec_and_lock(&ds->ds_count, &nn->nfs4_data_server_lock))=
 {
> >  		list_del_init(&ds->ds_node);
> > -		spin_unlock(&nfs4_ds_cache_lock);
> > +		spin_unlock(&nn->nfs4_data_server_lock);
> >  		destroy_ds(ds);
> >  	}
> >  }
> > @@ -718,6 +720,7 @@ nfs4_pnfs_remotestr(struct list_head *dsaddrs, gfp_=
t gfp_flags)
> >  struct nfs4_pnfs_ds *
> >  nfs4_pnfs_ds_add(const struct net *net, struct list_head *dsaddrs, gfp=
_t gfp_flags)
> >  {
> > +	struct nfs_net *nn =3D net_generic(net, nfs_net_id);
> >  	struct nfs4_pnfs_ds *tmp_ds, *ds =3D NULL;
> >  	char *remotestr;
> > =20
> > @@ -733,8 +736,8 @@ nfs4_pnfs_ds_add(const struct net *net, struct list=
_head *dsaddrs, gfp_t gfp_fla
> >  	/* this is only used for debugging, so it's ok if its NULL */
> >  	remotestr =3D nfs4_pnfs_remotestr(dsaddrs, gfp_flags);
> > =20
> > -	spin_lock(&nfs4_ds_cache_lock);
> > -	tmp_ds =3D _data_server_lookup_locked(net, dsaddrs);
> > +	spin_lock(&nn->nfs4_data_server_lock);
> > +	tmp_ds =3D _data_server_lookup_locked(nn, dsaddrs);
> >  	if (tmp_ds =3D=3D NULL) {
> >  		INIT_LIST_HEAD(&ds->ds_addrs);
> >  		list_splice_init(dsaddrs, &ds->ds_addrs);
> > @@ -743,7 +746,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list=
_head *dsaddrs, gfp_t gfp_fla
> >  		INIT_LIST_HEAD(&ds->ds_node);
> >  		ds->ds_net =3D net;
> >  		ds->ds_clp =3D NULL;
> > -		list_add(&ds->ds_node, &nfs4_data_server_cache);
> > +		list_add(&ds->ds_node, &nn->nfs4_data_server_cache);
> >  		dprintk("%s add new data server %s\n", __func__,
> >  			ds->ds_remotestr);
> >  	} else {
> > @@ -755,7 +758,7 @@ nfs4_pnfs_ds_add(const struct net *net, struct list=
_head *dsaddrs, gfp_t gfp_fla
> >  			refcount_read(&tmp_ds->ds_count));
> >  		ds =3D tmp_ds;
> >  	}
> > -	spin_unlock(&nfs4_ds_cache_lock);
> > +	spin_unlock(&nn->nfs4_data_server_lock);
> >  out:
> >  	return ds;
> >  }
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

