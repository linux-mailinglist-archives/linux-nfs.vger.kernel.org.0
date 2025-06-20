Return-Path: <linux-nfs+bounces-12597-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 073ABAE1B63
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 15:01:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 968E41671E9
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jun 2025 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53D184;
	Fri, 20 Jun 2025 13:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kah18TiI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98E630E84D
	for <linux-nfs@vger.kernel.org>; Fri, 20 Jun 2025 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424495; cv=none; b=K3YAOeQfOC/zGIh67nJl/Yxwm3eu7gLH34OvTbE+aIkO3s3hXeHqD9NvV8buB7qQvEsiRoSctC9E5heJAp16jR5SFZSfUB1XVt3mZvDjOJfyvAwRFXNb8QwkBoyqLoZCsL0ZDIuGaNpv+18w4aatRhmzkKof541BXIZinNoxoo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424495; c=relaxed/simple;
	bh=eVqBbIF3dQET76AVKE50plce4ukm0p3LV+SDjYOmqys=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=miWE1hatoXl3711lrToCBkYjutOV+LVrqxwh6Ce5FBgxW4/g3BZ3VPU6+Lv+0Igk42dIGXJ5qKGRHE4MlexH8ZbNBcRr4abEAjKA1/mBXg03+N6lQ4YCv4ZPCDWhVqfDRhXRkx8vxAI5G/0qeBxHEYfeE7ivmNdOTxqiyocmL7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kah18TiI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C799EC4CEE3;
	Fri, 20 Jun 2025 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750424495;
	bh=eVqBbIF3dQET76AVKE50plce4ukm0p3LV+SDjYOmqys=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kah18TiIIZcVK+NCSo3YX/XanERV5/89P07dgDMwsAL9E+so4AOu+GuerNTbvNO4x
	 RjotmBiZfCidjAmxuB9+MNK9o0zGsXBg8+woN3mV3pyWu8obB0DA33Da+5Jn5NJQp8
	 8isjm+tgaD2nlMW6yTFoXTMjq+gWC+zA1wSbbuKCurNcT3cYMA7Vu4a7VvxzoD5idw
	 5EZGwt/vIDbaMgrYNiZGnutDULumWjoMVJ0whbEM9DWjalmXAlPA1aP9Qsnp9zDi+L
	 rvJmtxksBMun8CZkJN38zbfkRXAUTjLVvHdoQB2HpMkiSiG5WrgGQ54vkQUR6J7Zdt
	 nIGzgAajOcY6Q==
Message-ID: <67b8eb3390347fac8080c7c008e58c6896e6a1d4.camel@kernel.org>
Subject: Re: [PATCH 2/3] nfsd: use kref and new mutex for global config
 management
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neil@brown.name>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Li Lingfeng	
 <lilingfeng3@huawei.com>
Date: Fri, 20 Jun 2025 09:01:33 -0400
In-Reply-To: <20250618213347.425503-3-neil@brown.name>
References: <20250618213347.425503-1-neil@brown.name>
	 <20250618213347.425503-3-neil@brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-19 at 07:31 +1000, NeilBrown wrote:
> nfsd_mutex is used for two quite different things:
> 1/ it prevents races when start/stoping global resources:
>    the filecache and the v4 state table
> 2/ it prevents races for per-netns config, typically
>    ensure config changes are synchronised w.r.t. server
>    startup/shutdown.
>=20
> This patch splits out the first used.  A subsequent patch improves the
> second.
>=20
> "nfsd_users" is changed to a kref which is can be taken to delay

Changelog nits:

s/which is/which/

> the shutdown of global services.  nfsd_startup_get(), it is succeeds,

nit: "if it succeeds"

> ensure the global services will remain until nfsd_startup_put().

"ensures"

>=20
> The new mutex, nfsd_startup_mutex, is only take for startup and

"only taken"

> shutdown.  It is not needed to protect the kref.
>=20
> The locking needed by nfsd_file_cache_purge() is now provided internally
> by that function so calls don't need to be concerned.
>=20
> This replaces NFSD_FILE_CACHE_UP which is effective just a flag which

"effectively"

> says nfsd_users is non-zero.
>=20
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/export.c    |  6 ------
>  fs/nfsd/filecache.c | 31 +++++++++++--------------------
>  fs/nfsd/nfsd.h      |  3 +++
>  fs/nfsd/nfssvc.c    | 41 +++++++++++++++++++++++++++--------------
>  4 files changed, 41 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..1ea3d72ef5c9 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -243,13 +243,7 @@ static struct cache_head *expkey_alloc(void)
> =20
>  static void expkey_flush(void)
>  {
> -	/*
> -	 * Take the nfsd_mutex here to ensure that the file cache is not
> -	 * destroyed while we're in the middle of flushing.
> -	 */
> -	mutex_lock(&nfsd_mutex);
>  	nfsd_file_cache_purge(current->nsproxy->net_ns);
> -	mutex_unlock(&nfsd_mutex);
>  }
> =20
>  static const struct cache_detail svc_expkey_cache_template =3D {
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index e108b6c705b4..0a9116b7530c 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -50,8 +50,6 @@
> =20
>  #define NFSD_LAUNDRETTE_DELAY		     (2 * HZ)
> =20
> -#define NFSD_FILE_CACHE_UP		     (0)
> -
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
>  #define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALI=
O)
> =20
> @@ -70,7 +68,6 @@ struct nfsd_fcache_disposal {
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
>  static struct list_lru			nfsd_file_lru;
> -static unsigned long			nfsd_file_flags;
>  static struct fsnotify_group		*nfsd_file_fsnotify_group;
>  static struct delayed_work		nfsd_filecache_laundrette;
>  static struct rhltable			nfsd_file_rhltable
> @@ -112,9 +109,12 @@ static const struct rhashtable_params nfsd_file_rhas=
h_params =3D {
>  static void
>  nfsd_file_schedule_laundrette(void)
>  {
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags))
> -		queue_delayed_work(system_unbound_wq, &nfsd_filecache_laundrette,
> +	if (nfsd_startup_get()) {
> +		queue_delayed_work(system_unbound_wq,
> +				   &nfsd_filecache_laundrette,
>  				   NFSD_LAUNDRETTE_DELAY);
> +		nfsd_startup_put();
> +	}
>  }
> =20
>  static void
> @@ -795,10 +795,6 @@ nfsd_file_cache_init(void)
>  {
>  	int ret;
> =20
> -	lockdep_assert_held(&nfsd_mutex);
> -	if (test_and_set_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
> -		return 0;
> -
>  	ret =3D rhltable_init(&nfsd_file_rhltable, &nfsd_file_rhash_params);
>  	if (ret)
>  		goto out;
> @@ -853,8 +849,6 @@ nfsd_file_cache_init(void)
> =20
>  	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
>  out:
> -	if (ret)
> -		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
>  	return ret;
>  out_notifier:
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
> @@ -958,9 +952,10 @@ nfsd_file_cache_start_net(struct net *net)
>  void
>  nfsd_file_cache_purge(struct net *net)
>  {
> -	lockdep_assert_held(&nfsd_mutex);
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1)
> +	if (nfsd_startup_get()) {
>  		__nfsd_file_cache_purge(net);
> +		nfsd_startup_put();
> +	}
>  }
> =20
>  void
> @@ -975,10 +970,6 @@ nfsd_file_cache_shutdown(void)
>  {
>  	int i;
> =20
> -	lockdep_assert_held(&nfsd_mutex);
> -	if (test_and_clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 0)
> -		return;
> -
>  	lease_unregister_notifier(&nfsd_file_lease_notifier);
>  	shrinker_free(nfsd_file_shrinker);
>  	/*
> @@ -1347,8 +1338,7 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
>  	unsigned long lru =3D 0, total_age =3D 0;
> =20
>  	/* Serialize with server shutdown */
> -	mutex_lock(&nfsd_mutex);
> -	if (test_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags) =3D=3D 1) {
> +	if (nfsd_startup_get()) {
>  		struct bucket_table *tbl;
>  		struct rhashtable *ht;
> =20
> @@ -1360,8 +1350,9 @@ int nfsd_file_cache_stats_show(struct seq_file *m, =
void *v)
>  		tbl =3D rht_dereference_rcu(ht->tbl, ht);
>  		buckets =3D tbl->size;
>  		rcu_read_unlock();
> +
> +		nfsd_startup_put();
>  	}
> -	mutex_unlock(&nfsd_mutex);
> =20
>  	for_each_possible_cpu(i) {
>  		hits +=3D per_cpu(nfsd_file_cache_hits, i);
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 1bfd0b4e9af7..8ad9fcc23789 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -80,6 +80,9 @@ extern const struct svc_version	nfsd_version2, nfsd_ver=
sion3, nfsd_version4;
>  extern struct mutex		nfsd_mutex;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
> =20
> +bool nfsd_startup_get(void);
> +void nfsd_startup_put(void);
> +
>  extern const struct seq_operations nfs_exports_op;
> =20
>  /*
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 82b0111ac469..b2080e5a71e6 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -270,38 +270,51 @@ static int nfsd_init_socks(struct net *net, const s=
truct cred *cred)
>  	return 0;
>  }
> =20
> -static int nfsd_users =3D 0;
> +static struct kref nfsd_users =3D KREF_INIT(0);
> +static DEFINE_MUTEX(nfsd_startup_mutex);
> =20
>  static int nfsd_startup_generic(void)
>  {
> -	int ret;
> +	int ret =3D 0;
> =20
> -	if (nfsd_users++)
> +	if (kref_get_unless_zero(&nfsd_users))
>  		return 0;
> +	mutex_lock(&nfsd_startup_mutex);
> +	if (kref_get_unless_zero(&nfsd_users))
> +		goto out_unlock;
> =20
>  	ret =3D nfsd_file_cache_init();
>  	if (ret)
> -		goto dec_users;
> +		goto out_unlock;
> =20
>  	ret =3D nfs4_state_start();
>  	if (ret)
>  		goto out_file_cache;
> -	return 0;
> +	kref_init(&nfsd_users);
> +out_unlock:
> +	mutex_unlock(&nfsd_startup_mutex);
> +	return ret;
> =20
>  out_file_cache:
>  	nfsd_file_cache_shutdown();
> -dec_users:
> -	nfsd_users--;
> -	return ret;
> +	goto out_unlock;
>  }
> =20
> -static void nfsd_shutdown_generic(void)
> +static void nfsd_shutdown_cb(struct kref *kref)
>  {
> -	if (--nfsd_users)
> -		return;
> -
>  	nfs4_state_shutdown();
>  	nfsd_file_cache_shutdown();
> +	mutex_unlock(&nfsd_startup_mutex);
> +}
> +
> +bool nfsd_startup_get(void)
> +{
> +	return kref_get_unless_zero(&nfsd_users);
> +}
> +
> +void nfsd_startup_put(void)
> +{
> +	kref_put_mutex(&nfsd_users, nfsd_shutdown_cb, &nfsd_startup_mutex);
>  }
> =20
>  static bool nfsd_needs_lockd(struct nfsd_net *nn)
> @@ -416,7 +429,7 @@ static int nfsd_startup_net(struct net *net, const st=
ruct cred *cred)
>  		nn->lockd_up =3D false;
>  	}
>  out_socks:
> -	nfsd_shutdown_generic();
> +	nfsd_startup_put();
>  	return ret;
>  }
> =20
> @@ -443,7 +456,7 @@ static void nfsd_shutdown_net(struct net *net)
>  	percpu_ref_exit(&nn->nfsd_net_ref);
> =20
>  	nn->nfsd_net_up =3D false;
> -	nfsd_shutdown_generic();
> +	nfsd_startup_put();
>  }
> =20
>  static DEFINE_SPINLOCK(nfsd_notifier_lock);

I like this approach though. Taking a reference seems much less brittle
than dealing with a global mutex. Other than the changelog nits:

Reviewed-by: Jeff Layton <jlayton@kernel.org>

