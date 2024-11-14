Return-Path: <linux-nfs+bounces-7987-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AFE9C91EC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 19:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 494FBB2841E
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA819939D;
	Thu, 14 Nov 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7AqF4dK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7E17A583
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731610430; cv=none; b=MdhKGpthabPHSoAG/CJjFbqfJ7Yli6iYt9RdpsU8Q1YmweUO8JtP3+HGyIz9TkaKPPfS3FO5PisFE3uMBt7n0b3rDdSG6gr97qIPUfEIienxWx5w1O4icgUmW2b/KGNVNZaccLADXOXqrtQaHd+CKRxa43FFV35YK/EuM90L990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731610430; c=relaxed/simple;
	bh=yJVAZbcTWALRyv6fCCv6ZbsVPwmZ+38T7lXI/NbvqLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uPYDWyfC6bGPKA83nMJkT+L1mmvUQ2jh7TsiTlkdOEdKmMe+psw9HcEbj7UFj9e1zFKioZx161M9yCmPCoUZQ9lCewVnDvblnmNcfQuQf+viMFPyeM5mYvrxypiPtQ/wCFgE414Zbto+MHRiAdXTFJsbWmWakU6CahA2PdWzqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7AqF4dK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740B2C4CECD;
	Thu, 14 Nov 2024 18:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731610430;
	bh=yJVAZbcTWALRyv6fCCv6ZbsVPwmZ+38T7lXI/NbvqLo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T7AqF4dKbMZGt5qUx+DqXjWa33DSoas6aMnBimKVZj/at2rcTL/Cx70A3Dmc37gOG
	 inkiFEDrSPhpzDG/O+RDplBs1mCujFi5ORWcbidaOxZnObKZEJ37HM1sRP5vmdb3vJ
	 plNQxXu2A6ZOTkLUhIz8htgS5lV3owZoMwir92Itchy1gEp3OWTwGDVNoNuTffVhpx
	 uWRDogM4znRiWx3o49Epc7g3uAbpj19zNNUyFldCVaU34wSqomdARfO6mN3jOCz77k
	 vGk455U2aNSSLeGNC2QactzYJrnSM9k+68lurOkOb4dqT6U1CPxAPnSZ1TQc3NSwAV
	 Us4qRfLmGKRCA==
Message-ID: <07c4b3f29094b4ce88da382586e822133eabdec9.camel@kernel.org>
Subject: Re: [for-6.13 PATCH v2 11/15] nfs_common: track all open nfsd_files
 per LOCALIO nfs_client
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>, Trond Myklebust
 <trondmy@hammerspace.com>,  Chuck Lever <chuck.lever@oracle.com>, NeilBrown
 <neilb@suse.de>
Date: Thu, 14 Nov 2024 13:53:48 -0500
In-Reply-To: <20241114035952.13889-12-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
	 <20241114035952.13889-12-snitzer@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-13 at 22:59 -0500, Mike Snitzer wrote:
> This tracking enables __nfsd_file_cache_purge() to call
> nfs_localio_invalidate_clients(), upon shutdown or export change, to
> nfs_close_local_fh() all open nfsd_files that are still cached by the
> LOCALIO nfs clients associated with nfsd_net that is being shutdown.
>=20
> Now that the client must track all open nfsd_files there was more work
> than necessary being done with the global nfs_uuids_lock contended.
> This manifested in various RCU issues, e.g.:
>  hrtimer: interrupt took 47969440 ns
>  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>=20
> Use nfs_uuid->lock to protect all nfs_uuid_t members, instead of
> nfs_uuids_lock, once nfs_uuid_is_local() adds the client to
> nn->local_clients.
>=20
> Also add 'local_clients_lock' to 'struct nfsd_net' to protect
> nn->local_clients.  And store a pointer to spinlock in the 'list_lock'
> member of nfs_uuid_t so nfs_localio_disable_client() can use it to
> avoid taking the global nfs_uuids_lock.
>=20
> In combination, these split out locks eliminate the use of the single
> nfslocalio.c global nfs_uuids_lock in the IO paths (open and close).
>=20
> Also refactored associated fs/nfs_common/nfslocalio.c methods' locking
> to reduce work performed with spinlocks held in general.
>=20
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/nfs_common/nfslocalio.c | 166 +++++++++++++++++++++++++++----------
>  fs/nfsd/filecache.c        |   9 ++
>  fs/nfsd/localio.c          |   1 +
>  fs/nfsd/netns.h            |   1 +
>  fs/nfsd/nfsctl.c           |   4 +-
>  include/linux/nfslocalio.h |   8 +-
>  6 files changed, 143 insertions(+), 46 deletions(-)
>=20
> diff --git a/fs/nfs_common/nfslocalio.c b/fs/nfs_common/nfslocalio.c
> index 5fa3f47b442e9..e5c0912b9a025 100644
> --- a/fs/nfs_common/nfslocalio.c
> +++ b/fs/nfs_common/nfslocalio.c
> @@ -23,27 +23,49 @@ static DEFINE_SPINLOCK(nfs_uuids_lock);
>   */
>  static LIST_HEAD(nfs_uuids);
> =20
> +/*
> + * Lock ordering:
> + * 1: nfs_uuid->lock
> + * 2: nfs_uuids_lock
> + * 3: nfs_uuid->list_lock (aka nn->local_clients_lock)
> + *
> + * May skip locks in select cases, but never hold multiple
> + * locks out of order.
> + */
> +
>  void nfs_uuid_init(nfs_uuid_t *nfs_uuid)
>  {
>  	nfs_uuid->net =3D NULL;
>  	nfs_uuid->dom =3D NULL;
> +	nfs_uuid->list_lock =3D NULL;
>  	INIT_LIST_HEAD(&nfs_uuid->list);
> +	INIT_LIST_HEAD(&nfs_uuid->files);
>  	spin_lock_init(&nfs_uuid->lock);
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_init);
> =20
>  bool nfs_uuid_begin(nfs_uuid_t *nfs_uuid)
>  {
> +	spin_lock(&nfs_uuid->lock);
> +	if (nfs_uuid->net) {
> +		/* This nfs_uuid is already in use */
> +		spin_unlock(&nfs_uuid->lock);
> +		return false;
> +	}
> +
>  	spin_lock(&nfs_uuids_lock);
> -	/* Is this nfs_uuid already in use? */
>  	if (!list_empty(&nfs_uuid->list)) {
> +		/* This nfs_uuid is already in use */
>  		spin_unlock(&nfs_uuids_lock);
> +		spin_unlock(&nfs_uuid->lock);
>  		return false;
>  	}
> -	uuid_gen(&nfs_uuid->uuid);
>  	list_add_tail(&nfs_uuid->list, &nfs_uuids);
>  	spin_unlock(&nfs_uuids_lock);
> =20
> +	uuid_gen(&nfs_uuid->uuid);
> +	spin_unlock(&nfs_uuid->lock);
> +
>  	return true;
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_begin);
> @@ -51,11 +73,15 @@ EXPORT_SYMBOL_GPL(nfs_uuid_begin);
>  void nfs_uuid_end(nfs_uuid_t *nfs_uuid)
>  {
>  	if (nfs_uuid->net =3D=3D NULL) {
> -		spin_lock(&nfs_uuids_lock);
> -		if (nfs_uuid->net =3D=3D NULL)
> +		spin_lock(&nfs_uuid->lock);
> +		if (nfs_uuid->net =3D=3D NULL) {
> +			/* Not local, remove from nfs_uuids */
> +			spin_lock(&nfs_uuids_lock);
>  			list_del_init(&nfs_uuid->list);
> -		spin_unlock(&nfs_uuids_lock);
> -	}
> +			spin_unlock(&nfs_uuids_lock);
> +		}
> +		spin_unlock(&nfs_uuid->lock);
> +        }
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_end);
> =20
> @@ -73,28 +99,39 @@ static nfs_uuid_t * nfs_uuid_lookup_locked(const uuid=
_t *uuid)
>  static struct module *nfsd_mod;
> =20
>  void nfs_uuid_is_local(const uuid_t *uuid, struct list_head *list,
> -		       struct net *net, struct auth_domain *dom,
> -		       struct module *mod)
> +		       spinlock_t *list_lock, struct net *net,
> +		       struct auth_domain *dom, struct module *mod)
>  {
>  	nfs_uuid_t *nfs_uuid;
> =20
>  	spin_lock(&nfs_uuids_lock);
>  	nfs_uuid =3D nfs_uuid_lookup_locked(uuid);
> -	if (nfs_uuid) {
> -		kref_get(&dom->ref);
> -		nfs_uuid->dom =3D dom;
> -		/*
> -		 * We don't hold a ref on the net, but instead put
> -		 * ourselves on a list so the net pointer can be
> -		 * invalidated.
> -		 */
> -		list_move(&nfs_uuid->list, list);
> -		rcu_assign_pointer(nfs_uuid->net, net);
> -
> -		__module_get(mod);
> -		nfsd_mod =3D mod;
> +	if (!nfs_uuid) {
> +		spin_unlock(&nfs_uuids_lock);
> +		return;
>  	}
> +
> +	/*
> +	 * We don't hold a ref on the net, but instead put
> +	 * ourselves on @list (nn->local_clients) so the net
> +	 * pointer can be invalidated.
> +	 */
> +	spin_lock(list_lock); /* list_lock is nn->local_clients_lock */
> +	list_move(&nfs_uuid->list, list);
> +	spin_unlock(list_lock);
> +
>  	spin_unlock(&nfs_uuids_lock);
> +	/* Once nfs_uuid is parented to @list, avoid global nfs_uuids_lock */
> +	spin_lock(&nfs_uuid->lock);
> +
> +	__module_get(mod);
> +	nfsd_mod =3D mod;
> +
> +	nfs_uuid->list_lock =3D list_lock;
> +	kref_get(&dom->ref);
> +	nfs_uuid->dom =3D dom;
> +	rcu_assign_pointer(nfs_uuid->net, net);
> +	spin_unlock(&nfs_uuid->lock);
>  }
>  EXPORT_SYMBOL_GPL(nfs_uuid_is_local);
> =20
> @@ -108,55 +145,96 @@ void nfs_localio_enable_client(struct nfs_client *c=
lp)
>  }
>  EXPORT_SYMBOL_GPL(nfs_localio_enable_client);
> =20
> -static void nfs_uuid_put_locked(nfs_uuid_t *nfs_uuid)
> +/*
> + * Cleanup the nfs_uuid_t embedded in an nfs_client.
> + * This is the long-form of nfs_uuid_init().
> + */
> +static void nfs_uuid_put(nfs_uuid_t *nfs_uuid)
>  {
> -	if (!nfs_uuid->net)
> +	LIST_HEAD(local_files);
> +	struct nfs_file_localio *nfl, *tmp;
> +
> +	spin_lock(&nfs_uuid->lock);
> +	if (unlikely(!nfs_uuid->net)) {
> +		spin_unlock(&nfs_uuid->lock);
>  		return;
> -	module_put(nfsd_mod);
> +	}
>  	RCU_INIT_POINTER(nfs_uuid->net, NULL);
> =20
>  	if (nfs_uuid->dom) {
>  		auth_domain_put(nfs_uuid->dom);
>  		nfs_uuid->dom =3D NULL;
>  	}
> -	list_del_init(&nfs_uuid->list);
> +
> +	list_splice_init(&nfs_uuid->files, &local_files);
> +	spin_unlock(&nfs_uuid->lock);
> +
> +	/* Walk list of files and ensure their last references dropped */
> +	list_for_each_entry_safe(nfl, tmp, &local_files, list) {
> +		nfs_close_local_fh(nfl);
> +		cond_resched();
> +	}
> +
> +	spin_lock(&nfs_uuid->lock);
> +	BUG_ON(!list_empty(&nfs_uuid->files));
> +
> +	/* Remove client from nn->local_clients */
> +	if (nfs_uuid->list_lock) {
> +		spin_lock(nfs_uuid->list_lock);
> +		BUG_ON(list_empty(&nfs_uuid->list));
> +		list_del_init(&nfs_uuid->list);
> +		spin_unlock(nfs_uuid->list_lock);
> +		nfs_uuid->list_lock =3D NULL;
> +	}
> +
> +	module_put(nfsd_mod);
> +	spin_unlock(&nfs_uuid->lock);
>  }
> =20
>  void nfs_localio_disable_client(struct nfs_client *clp)
>  {
> -	nfs_uuid_t *nfs_uuid =3D &clp->cl_uuid;
> +	nfs_uuid_t *nfs_uuid =3D NULL;
> =20
> -	spin_lock(&nfs_uuid->lock);
> +	spin_lock(&clp->cl_uuid.lock); /* aka &nfs_uuid->lock */
>  	if (test_and_clear_bit(NFS_CS_LOCAL_IO, &clp->cl_flags)) {
> -		spin_lock(&nfs_uuids_lock);
> -		nfs_uuid_put_locked(nfs_uuid);
> -		spin_unlock(&nfs_uuids_lock);
> +		/* &clp->cl_uuid is always not NULL, using as bool here */
> +		nfs_uuid =3D &clp->cl_uuid;
>  	}
> -	spin_unlock(&nfs_uuid->lock);
> +	spin_unlock(&clp->cl_uuid.lock);
> +
> +	if (nfs_uuid)
> +		nfs_uuid_put(nfs_uuid);
>  }
>  EXPORT_SYMBOL_GPL(nfs_localio_disable_client);
> =20
> -void nfs_localio_invalidate_clients(struct list_head *cl_uuid_list)
> +void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
> +				    spinlock_t *nn_local_clients_lock)
>  {
> +	LIST_HEAD(local_clients);
>  	nfs_uuid_t *nfs_uuid, *tmp;
> +	struct nfs_client *clp;
> =20
> -	spin_lock(&nfs_uuids_lock);
> -	list_for_each_entry_safe(nfs_uuid, tmp, cl_uuid_list, list) {
> -		struct nfs_client *clp =3D
> -			container_of(nfs_uuid, struct nfs_client, cl_uuid);
> -
> +	spin_lock(nn_local_clients_lock);
> +	list_splice_init(nn_local_clients, &local_clients);
> +	spin_unlock(nn_local_clients_lock);
> +	list_for_each_entry_safe(nfs_uuid, tmp, &local_clients, list) {
> +		if (WARN_ON(nfs_uuid->list_lock !=3D nn_local_clients_lock))
> +			break;
> +		clp =3D container_of(nfs_uuid, struct nfs_client, cl_uuid);
>  		nfs_localio_disable_client(clp);
>  	}
> -	spin_unlock(&nfs_uuids_lock);
>  }
>  EXPORT_SYMBOL_GPL(nfs_localio_invalidate_clients);
> =20
>  static void nfs_uuid_add_file(nfs_uuid_t *nfs_uuid, struct nfs_file_loca=
lio *nfl)
>  {
> -	spin_lock(&nfs_uuids_lock);
> -	if (!nfl->nfs_uuid)
> +	/* Add nfl to nfs_uuid->files if it isn't already */
> +	spin_lock(&nfs_uuid->lock);
> +	if (list_empty(&nfl->list)) {
>  		rcu_assign_pointer(nfl->nfs_uuid, nfs_uuid);
> -	spin_unlock(&nfs_uuids_lock);
> +		list_add_tail(&nfl->list, &nfs_uuid->files);
> +	}
> +	spin_unlock(&nfs_uuid->lock);
>  }
> =20
>  /*
> @@ -217,14 +295,16 @@ void nfs_close_local_fh(struct nfs_file_localio *nf=
l)
>  	ro_nf =3D rcu_access_pointer(nfl->ro_file);
>  	rw_nf =3D rcu_access_pointer(nfl->rw_file);
>  	if (ro_nf || rw_nf) {
> -		spin_lock(&nfs_uuids_lock);
> +		spin_lock(&nfs_uuid->lock);
>  		if (ro_nf)
>  			ro_nf =3D rcu_dereference_protected(xchg(&nfl->ro_file, NULL), 1);
>  		if (rw_nf)
>  			rw_nf =3D rcu_dereference_protected(xchg(&nfl->rw_file, NULL), 1);
> =20
> +		/* Remove nfl from nfs_uuid->files list */
>  		rcu_assign_pointer(nfl->nfs_uuid, NULL);
> -		spin_unlock(&nfs_uuids_lock);
> +		list_del_init(&nfl->list);
> +		spin_unlock(&nfs_uuid->lock);
>  		rcu_read_unlock();
> =20
>  		if (ro_nf)
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ab9942e420543..c9ab64e3732ce 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -39,6 +39,7 @@
>  #include <linux/fsnotify.h>
>  #include <linux/seq_file.h>
>  #include <linux/rhashtable.h>
> +#include <linux/nfslocalio.h>
> =20
>  #include "vfs.h"
>  #include "nfsd.h"
> @@ -836,6 +837,14 @@ __nfsd_file_cache_purge(struct net *net)
>  	struct nfsd_file *nf;
>  	LIST_HEAD(dispose);
> =20
> +#if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	if (net) {
> +		struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +		nfs_localio_invalidate_clients(&nn->local_clients,
> +					       &nn->local_clients_lock);
> +	}
> +#endif
> +

If !net in this function, then nfsd is tearing down all the nfsd_files
in the cache. You probably need to issue the above on every net
namespace that is running nfsd in that case.

>  	rhltable_walk_enter(&nfsd_file_rhltable, &iter);
>  	do {
>  		rhashtable_walk_start(&iter);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> index 2ae07161b9195..238647fa379e3 100644
> --- a/fs/nfsd/localio.c
> +++ b/fs/nfsd/localio.c
> @@ -116,6 +116,7 @@ static __be32 localio_proc_uuid_is_local(struct svc_r=
qst *rqstp)
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
>  	nfs_uuid_is_local(&argp->uuid, &nn->local_clients,
> +			  &nn->local_clients_lock,
>  			  net, rqstp->rq_client, THIS_MODULE);
> =20
>  	return rpc_success;
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 8faef59d71229..187c4140b1913 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -220,6 +220,7 @@ struct nfsd_net {
> =20
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  	/* Local clients to be invalidated when net is shut down */
> +	spinlock_t              local_clients_lock;
>  	struct list_head	local_clients;
>  #endif
>  };
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 727904d8a4d01..70347b0ecdc43 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2259,6 +2259,7 @@ static __net_init int nfsd_net_init(struct net *net=
)
>  	seqlock_init(&nn->writeverf_lock);
>  	nfsd_proc_stat_init(net);
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
> +	spin_lock_init(&nn->local_clients_lock);
>  	INIT_LIST_HEAD(&nn->local_clients);
>  #endif
>  	return 0;
> @@ -2283,7 +2284,8 @@ static __net_exit void nfsd_net_pre_exit(struct net=
 *net)
>  {
>  	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> =20
> -	nfs_localio_invalidate_clients(&nn->local_clients);
> +	nfs_localio_invalidate_clients(&nn->local_clients,
> +				       &nn->local_clients_lock);
>  }
>  #endif
> =20
> diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
> index aa2b5c6561ab0..c68a529230c14 100644
> --- a/include/linux/nfslocalio.h
> +++ b/include/linux/nfslocalio.h
> @@ -30,19 +30,23 @@ typedef struct {
>  	/* sadly this struct is just over a cacheline, avoid bouncing */
>  	spinlock_t ____cacheline_aligned lock;
>  	struct list_head list;
> +	spinlock_t *list_lock; /* nn->local_clients_lock */
>  	struct net __rcu *net; /* nfsd's network namespace */
>  	struct auth_domain *dom; /* auth_domain for localio */
> +	/* Local files to close when net is shut down or exports change */
> +	struct list_head files;
>  } nfs_uuid_t;
> =20
>  void nfs_uuid_init(nfs_uuid_t *);
>  bool nfs_uuid_begin(nfs_uuid_t *);
>  void nfs_uuid_end(nfs_uuid_t *);
> -void nfs_uuid_is_local(const uuid_t *, struct list_head *,
> +void nfs_uuid_is_local(const uuid_t *, struct list_head *, spinlock_t *,
>  		       struct net *, struct auth_domain *, struct module *);
> =20
>  void nfs_localio_enable_client(struct nfs_client *clp);
>  void nfs_localio_disable_client(struct nfs_client *clp);
> -void nfs_localio_invalidate_clients(struct list_head *list);
> +void nfs_localio_invalidate_clients(struct list_head *nn_local_clients,
> +				    spinlock_t *nn_local_clients_lock);
> =20
>  /* localio needs to map filehandle -> struct nfsd_file */
>  extern struct nfsd_file *

--=20
Jeff Layton <jlayton@kernel.org>

