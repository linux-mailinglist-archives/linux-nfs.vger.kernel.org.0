Return-Path: <linux-nfs+bounces-9483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F5A198E6
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 19:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2CA188DAF5
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 18:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3E72153EA;
	Wed, 22 Jan 2025 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+96csh3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D702B9A4
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737572323; cv=none; b=ApgrY4k/ERh6dLDQqymQV9I9LDUfqN+0t3qKGKCmI9hhUrkqQZ+xwzTm04SovTp0nw22RAuWV+9q1HZp+g+kYUgkl8xm13BSxM3SR8seMZujn5P8h5wxmEncNpncLdQuc7j/Xbfdwpw0HTVBs6VJsLgnkloxuwYdzk80mKJwTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737572323; c=relaxed/simple;
	bh=B4UTUZ135X/6abbrfZqOdCGIpRja+SUSGEm+V+pteM4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=twE0OllXzPm09gtsvQnszCXAtObZAs/CkUcQIFO4yMdF6fHBQDCi+T417OHAX7xqtlfUquP81SbCPSGRmVL09e4px5d2fNEd6RmZhqrXfpIpOmwTqS0lITQTd/IEQXv3ZnzlCxNHkEzFfZFSOzjYiHov/YDwxGaMjv4FWHjjg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+96csh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB43C4CED2;
	Wed, 22 Jan 2025 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737572322;
	bh=B4UTUZ135X/6abbrfZqOdCGIpRja+SUSGEm+V+pteM4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=N+96csh3EyBvWh7lrg6SH8Ohi3pKMeCZ5apCSWpNruv1dXblOcxUE10HSeyAcPyzK
	 Ft7X5g1cjV5M4NNJHgY+EmdQeR2UCca1n957Xs5wmccpgc5AHVNijEMnCF6QOEjmha
	 hkV4NVJpDFZ50ZtqY7P8ki8DHotIOUY9Q7yE5OxneeGTARrWjH5o45LIN9hTfOi75r
	 5EmOfn47hy8fIzCY+L4I7Hapuj973mxNdKBsedfKiu2RVNJ6qR2vnxApjdXEPhNQ7U
	 xu+fwFaCeTlf6Pe0W9W51jT/7nQv9TUAexT/Q9Bx9vigAZ7khkI5F1+aMcKK5bWT1o
	 vYDAS4oi4WnCg==
Message-ID: <fca52938a01a6ae8016e416f46a73dc2c62bf72d.camel@kernel.org>
Subject: Re: [PATCH 2/4] nfsd: filecache: move globals nfsd_file_lru and
 nfsd_file_shrinker to be per-net
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Wed, 22 Jan 2025 13:58:40 -0500
In-Reply-To: <20250122035615.2893754-3-neilb@suse.de>
References: <20250122035615.2893754-1-neilb@suse.de>
	 <20250122035615.2893754-3-neilb@suse.de>
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

On Wed, 2025-01-22 at 14:54 +1100, NeilBrown wrote:
> The final freeing of nfsd files is done by per-net nfsd threads (which
> call nfsd_file_net_dispose()) so it makes some sense to make more of the
> freeing infrastructure to be per-net - in struct nfsd_fcache_disposal.
>=20
> This is a step towards replacing the list_lru with simple lists which
> each share the per-net lock in nfsd_fcache_disposal and will require
> less list walking.
>=20
> As the net is always shutdown before there is any chance that the rest
> of the filecache is shut down we can removed the tests on
> NFSD_FILE_CACHE_UP.
>=20
> For the filecache stats file, which assumes a global lru, we keep a
> separate counter which includes all files in all netns lrus.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 125 ++++++++++++++++++++++++--------------------
>  1 file changed, 68 insertions(+), 57 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index d8f98e847dc0..4f39f6632b35 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -63,17 +63,19 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_evicti=
ons);
> =20
>  struct nfsd_fcache_disposal {
>  	spinlock_t lock;
> +	struct list_lru file_lru;
>  	struct list_head freeme;
> +	struct delayed_work filecache_laundrette;
> +	struct shrinker *file_shrinker;
>  };
> =20
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
> -static struct list_lru			nfsd_file_lru;
>  static unsigned long			nfsd_file_flags;
>  static struct fsnotify_group		*nfsd_file_fsnotify_group;
> -static struct delayed_work		nfsd_filecache_laundrette;
>  static struct rhltable			nfsd_file_rhltable
>  						____cacheline_aligned_in_smp;
> +static atomic_long_t			nfsd_lru_total =3D ATOMIC_LONG_INIT(0);
> =20
>  static bool
>  nfsd_match_cred(const struct cred *c1, const struct cred *c2)
> @@ -109,11 +111,18 @@ static const struct rhashtable_params nfsd_file_rha=
sh_params =3D {
>  };
> =20
>  static void
> -nfsd_file_schedule_laundrette(void)
> +nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
>  {
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> -				   NFSD_LAUNDRETTE_DELAY);
> +	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
> +			   NFSD_LAUNDRETTE_DELAY);
> +}
> +
> +static void
> +nfsd_file_schedule_laundrette_net(struct net *net)
> +{
> +	struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
> +
> +	nfsd_file_schedule_laundrette(nn->fcache_disposal);
>  }
> =20
>  static void
> @@ -318,11 +327,14 @@ nfsd_file_check_writeback(struct nfsd_file *nf)
>  		mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
>  }
> =20
> -
>  static bool nfsd_file_lru_add(struct nfsd_file *nf)
>  {
> +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
>  	set_bit(NFSD_FILE_REFERENCED, &nf->nf_flags);
> -	if (list_lru_add_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	if (list_lru_add_obj(&l->file_lru, &nf->nf_lru)) {
> +		atomic_long_inc(&nfsd_lru_total);
>  		trace_nfsd_file_lru_add(nf);
>  		return true;
>  	}
> @@ -331,7 +343,11 @@ static bool nfsd_file_lru_add(struct nfsd_file *nf)
> =20
>  static bool nfsd_file_lru_remove(struct nfsd_file *nf)
>  {
> -	if (list_lru_del_obj(&nfsd_file_lru, &nf->nf_lru)) {
> +	struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> +	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> +
> +	if (list_lru_del_obj(&l->file_lru, &nf->nf_lru)) {
> +		atomic_long_dec(&nfsd_lru_total);
>  		trace_nfsd_file_lru_del(nf);
>  		return true;
>  	}
> @@ -373,7 +389,7 @@ nfsd_file_put(struct nfsd_file *nf)
>  		if (nfsd_file_lru_add(nf)) {
>  			/* If it's still hashed, we're done */
>  			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
> -				nfsd_file_schedule_laundrette();
> +				nfsd_file_schedule_laundrette_net(nf->nf_net);
>  				return;
>  			}
> =20
> @@ -539,18 +555,18 @@ nfsd_file_lru_cb(struct list_head *item, struct lis=
t_lru_one *lru,
>  }
> =20
>  static void
> -nfsd_file_gc(void)
> +nfsd_file_gc(struct nfsd_fcache_disposal *l)
>  {
> -	unsigned long remaining =3D list_lru_count(&nfsd_file_lru);
> +	unsigned long remaining =3D list_lru_count(&l->file_lru);
>  	LIST_HEAD(dispose);
>  	unsigned long ret;
> =20
>  	while (remaining > 0) {
>  		unsigned long num_to_scan =3D min(remaining, NFSD_FILE_GC_BATCH);
> =20
> -		ret =3D list_lru_walk(&nfsd_file_lru, nfsd_file_lru_cb,
> +		ret =3D list_lru_walk(&l->file_lru, nfsd_file_lru_cb,
>  				    &dispose, num_to_scan);
> -		trace_nfsd_file_gc_removed(ret, list_lru_count(&nfsd_file_lru));
> +		trace_nfsd_file_gc_removed(ret, list_lru_count(&l->file_lru));
>  		nfsd_file_dispose_list_delayed(&dispose);
>  		remaining -=3D num_to_scan;
>  	}
> @@ -559,32 +575,36 @@ nfsd_file_gc(void)
>  static void
>  nfsd_file_gc_worker(struct work_struct *work)
>  {
> -	nfsd_file_gc();
> -	if (list_lru_count(&nfsd_file_lru))
> -		nfsd_file_schedule_laundrette();
> +	struct nfsd_fcache_disposal *l =3D container_of(
> +		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
> +	nfsd_file_gc(l);
> +	if (list_lru_count(&l->file_lru))
> +		nfsd_file_schedule_laundrette(l);
>  }
> =20
>  static unsigned long
>  nfsd_file_lru_count(struct shrinker *s, struct shrink_control *sc)
>  {
> -	return list_lru_count(&nfsd_file_lru);
> +	struct nfsd_fcache_disposal *l =3D s->private_data;
> +
> +	return list_lru_count(&l->file_lru);
>  }
> =20
>  static unsigned long
>  nfsd_file_lru_scan(struct shrinker *s, struct shrink_control *sc)
>  {
> +	struct nfsd_fcache_disposal *l =3D s->private_data;
> +
>  	LIST_HEAD(dispose);
>  	unsigned long ret;
> =20
> -	ret =3D list_lru_shrink_walk(&nfsd_file_lru, sc,
> +	ret =3D list_lru_shrink_walk(&l->file_lru, sc,
>  				   nfsd_file_lru_cb, &dispose);
> -	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&nfsd_file_lru));
> +	trace_nfsd_file_shrinker_removed(ret, list_lru_count(&l->file_lru));
>  	nfsd_file_dispose_list_delayed(&dispose);
>  	return ret;
>  }
> =20
> -static struct shrinker *nfsd_file_shrinker;
> -
>  /**
>   * nfsd_file_cond_queue - conditionally unhash and queue a nfsd_file
>   * @nf: nfsd_file to attempt to queue
> @@ -764,29 +784,10 @@ nfsd_file_cache_init(void)
>  		goto out_err;
>  	}
> =20
> -	ret =3D list_lru_init(&nfsd_file_lru);
> -	if (ret) {
> -		pr_err("nfsd: failed to init nfsd_file_lru: %d\n", ret);
> -		goto out_err;
> -	}
> -
> -	nfsd_file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
> -	if (!nfsd_file_shrinker) {
> -		ret =3D -ENOMEM;
> -		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> -		goto out_lru;
> -	}
> -
> -	nfsd_file_shrinker->count_objects =3D nfsd_file_lru_count;
> -	nfsd_file_shrinker->scan_objects =3D nfsd_file_lru_scan;
> -	nfsd_file_shrinker->seeks =3D 1;
> -
> -	shrinker_register(nfsd_file_shrinker);
> -
>  	ret =3D lease_register_notifier(&nfsd_file_lease_notifier);
>  	if (ret) {
>  		pr_err("nfsd: unable to register lease notifier: %d\n", ret);
> -		goto out_shrinker;
> +		goto out_err;
>  	}
> =20
>  	nfsd_file_fsnotify_group =3D fsnotify_alloc_group(&nfsd_file_fsnotify_o=
ps,
> @@ -799,17 +800,12 @@ nfsd_file_cache_init(void)
>  		goto out_notifier;
>  	}
> =20
> -	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
>  out:
>  	if (ret)
>  		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
>  	return ret;
>  out_notifier:
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
> -out_shrinker:
> -	shrinker_free(nfsd_file_shrinker);
> -out_lru:
> -	list_lru_destroy(&nfsd_file_lru);
>  out_err:
>  	kmem_cache_destroy(nfsd_file_slab);
>  	nfsd_file_slab =3D NULL;
> @@ -861,13 +857,36 @@ nfsd_alloc_fcache_disposal(void)
>  	if (!l)
>  		return NULL;
>  	spin_lock_init(&l->lock);
> +	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
>  	INIT_LIST_HEAD(&l->freeme);
> +	l->file_shrinker =3D shrinker_alloc(0, "nfsd-filecache");
> +	if (!l->file_shrinker) {
> +		pr_err("nfsd: failed to allocate nfsd_file_shrinker\n");
> +		kfree(l);
> +		return NULL;
> +	}
> +	l->file_shrinker->count_objects =3D nfsd_file_lru_count;
> +	l->file_shrinker->scan_objects =3D nfsd_file_lru_scan;
> +	l->file_shrinker->seeks =3D 1;
> +	l->file_shrinker->private_data =3D l;
> +
> +	if (list_lru_init(&l->file_lru)) {
> +		pr_err("nfsd: failed to init nfsd_file_lru\n");
> +		shrinker_free(l->file_shrinker);
> +		kfree(l);
> +		return NULL;
> +	}
> +
> +	shrinker_register(l->file_shrinker);
>  	return l;
>  }
> =20
>  static void
>  nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>  {
> +	cancel_delayed_work_sync(&l->filecache_laundrette);
> +	shrinker_free(l->file_shrinker);
> +	list_lru_destroy(&l->file_lru);
>  	nfsd_file_dispose_list(&l->freeme);
>  	kfree(l);
>  }
> @@ -899,8 +918,7 @@ void
>  nfsd_file_cache_purge(struct net *net)
>  {
>  	lockdep_assert_held(&nfsd_mutex);
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
> -		__nfsd_file_cache_purge(net);
> +	__nfsd_file_cache_purge(net);
>  }
> =20
>  void
> @@ -920,14 +938,7 @@ nfsd_file_cache_shutdown(void)
>  		return;
> =20
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
> -	shrinker_free(nfsd_file_shrinker);
> -	/*
> -	 * make sure all callers of nfsd_file_lru_cb are done before
> -	 * calling nfsd_file_cache_purge
> -	 */
> -	cancel_delayed_work_sync(&nfsd_filecache_laundrette);
>  	__nfsd_file_cache_purge(NULL);
> -	list_lru_destroy(&nfsd_file_lru);
>  	rcu_barrier();
>  	fsnotify_put_group(nfsd_file_fsnotify_group);
>  	nfsd_file_fsnotify_group =3D NULL;
> @@ -1298,7 +1309,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
>  		struct bucket_table *tbl;
>  		struct rhashtable *ht;
> =20
> -		lru =3D list_lru_count(&nfsd_file_lru);
> +		lru =3D atomic_long_read(&nfsd_lru_total);
> =20
>  		rcu_read_lock();
>  		ht =3D &nfsd_file_rhltable.ht;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

