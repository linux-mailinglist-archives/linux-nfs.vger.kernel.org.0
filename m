Return-Path: <linux-nfs+bounces-9682-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA18A1D88D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 15:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B13A3C1E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 14:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB6D757F3;
	Mon, 27 Jan 2025 14:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xs5LJS0t"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD45E6F30F
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988751; cv=none; b=c5buLmULmrDM8JiwBX/EWE2PfI87JbcVF4rOxlm7B0hXxfB6bAezPQrEX7FuA/JwMi3WEHrfqU7cEwpdByIrCypogZQ6XXUYQBE96Bby83C+ewNPjusdOyKJPYDkERiE3MEAhNhpJttGJ+VMeEITZap52veOu2LgRaupUcZBdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988751; c=relaxed/simple;
	bh=p4gLaNHRawYXb54OD27ZHGjc582vr6PGPZj7IZDyCKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2eC6XwfJn+WsTwEdxDVCUkPDye2w+LmSMe8tK6GtUuS0aUfRqoPS4il9Jz/3ZUc+c5k2ubKDzZxFkC4tX8UY/jk57piQ58/E4p2T+bfnvJCBSjxro3XJiCtOLC3/3TAt9kuAyr2X7+2Z7i9koolap6Z51Ebat4Ukn8zRF6dc7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xs5LJS0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F4C4CED2;
	Mon, 27 Jan 2025 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737988751;
	bh=p4gLaNHRawYXb54OD27ZHGjc582vr6PGPZj7IZDyCKI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Xs5LJS0twt7azjVGRQDZEq3gTPfrSwk0EyMwRr6dfEaAp+cqp/351N9zhsg1CC/+z
	 GIkZIA/dp2riG1k/zCNKRSIIXRkT+BlGY0jDszajAkZVP5HjhubwUKwCjYqO3hNsXS
	 wtBqVNaR8xNvWzoGkHlXMYn6gldjiIUM4DUjiu8AeZcOzTkxzBcUOhzY6QKdvIsdT6
	 3Gh/bjjMbNkTkilMu6r+a28uwqzNy8M2554VceMn5qMYNeY8U0xLaUanN2s6Pjsx5n
	 47cn+5+NFRUx69cm7F/DI6DI7Apsfg/3epB+lNCHFuUerCja7ZLf+bb10spoGoiu1x
	 0v3SNOmzOFWxA==
Message-ID: <7735374ea376d966042160332bb8e9012a54187e.camel@kernel.org>
Subject: Re: [PATCH 6/7] nfsd: filecache: change garbage collection to a
 timer.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Dave Chinner	
 <david@fromorbit.com>
Date: Mon, 27 Jan 2025 09:39:09 -0500
In-Reply-To: <20250127012257.1803314-7-neilb@suse.de>
References: <20250127012257.1803314-1-neilb@suse.de>
	 <20250127012257.1803314-7-neilb@suse.de>
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

On Mon, 2025-01-27 at 12:20 +1100, NeilBrown wrote:
> garbage collection never sleeps and no longer walks a list so it runs
> quickly only requiring a spinlock.
>=20
> This means we don't need to use a workqueue, we can use a simple timer
> instead.
>=20
> Rather than taking the lock in the timer callback, which would require
> using _bh locking, simply test a flag and wake an nfsd thread.  That
> thread checks the flag and ages the lists when needed.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/filecache.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 7264faa57280..eb95a53f806f 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -67,10 +67,12 @@ struct nfsd_fcache_disposal {
>  	struct list_head older;	/* haven't been used in last 0-2 seconds */
>  	struct list_head freeme; /* ready to be discarded */
>  	unsigned long num_gc; /* Approximate size of recent plus older */

Dang, adding flags would push this into=20
> -	struct delayed_work filecache_laundrette;
> +	struct timer_list timer;
>  	struct shrinker *file_shrinker;
>  	struct nfsd_net *nn;
> +	unsigned long flags;
>  };
> +#define NFSD_FCACHE_DO_AGE	BIT(0)	/* time to age the lists */
> =20
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
> @@ -115,8 +117,8 @@ static const struct rhashtable_params nfsd_file_rhash=
_params =3D {
>  static void
>  nfsd_file_schedule_laundrette(struct nfsd_fcache_disposal *l)
>  {
> -	queue_delayed_work(system_unbound_wq, &l->filecache_laundrette,
> -			   NFSD_LAUNDRETTE_DELAY);
> +	if (!timer_pending(&l->timer))
> +		mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
>  }
> =20
>  static void
> @@ -521,6 +523,19 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
>  {
>  	struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> =20
> +	if (test_and_clear_bit(NFSD_FCACHE_DO_AGE, &l->flags)) {
> +		spin_lock(&l->lock);
> +		list_splice_init(&l->older, &l->freeme);
> +		list_splice_init(&l->recent, &l->older);
> +		/* We don't know how many were moved to 'freeme' and don't want
> +		 * to waste time counting - guess a half.  This is only used
> +		 * for the shrinker which doesn't need complete precision.
> +		 */
> +		l->num_gc /=3D 2;
> +		if (!list_empty(&l->older) || !list_empty(&l->recent))
> +			mod_timer(&l->timer, jiffies + NFSD_LAUNDRETTE_DELAY);
> +		spin_unlock(&l->lock);
> +	}
>  	if (!list_empty(&l->freeme)) {
>  		LIST_HEAD(dispose);
>  		int i;
> @@ -557,23 +572,13 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
>  }
> =20
>  static void
> -nfsd_file_gc_worker(struct work_struct *work)
> +nfsd_file_gc_worker(struct timer_list *t)
>  {
>  	struct nfsd_fcache_disposal *l =3D container_of(
> -		work, struct nfsd_fcache_disposal, filecache_laundrette.work);
> +		t, struct nfsd_fcache_disposal, timer);
> =20
> -	spin_lock(&l->lock);
> -	list_splice_init(&l->older, &l->freeme);
> -	list_splice_init(&l->recent, &l->older);
> -	/* We don't know how many were moved to 'freeme' and don't want
> -	 * to waste time counting - guess a half.
> -	 */
> -	l->num_gc /=3D 2;
> -	if (!list_empty(&l->freeme))
> -		svc_wake_up(l->nn->nfsd_serv);
> -	if (!list_empty(&l->older) || !list_empty(&l->recent))
> -		nfsd_file_schedule_laundrette(l);
> -	spin_unlock(&l->lock);
> +	set_bit(NFSD_FCACHE_DO_AGE, &l->flags);
> +	svc_wake_up(l->nn->nfsd_serv);

Disregard my earlier comment about the cacheline. It still wouldn't
hurt to do, but since you're not actually taking the lock inside the
timer callback in this version, it's not as big a deal.

This seems better.

>  }
> =20
>  static unsigned long
> @@ -868,7 +873,7 @@ nfsd_alloc_fcache_disposal(void)
>  	if (!l)
>  		return NULL;
>  	spin_lock_init(&l->lock);
> -	INIT_DELAYED_WORK(&l->filecache_laundrette, nfsd_file_gc_worker);
> +	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
>  	INIT_LIST_HEAD(&l->recent);
>  	INIT_LIST_HEAD(&l->older);
>  	INIT_LIST_HEAD(&l->freeme);
> @@ -891,7 +896,7 @@ nfsd_alloc_fcache_disposal(void)
>  static void
>  nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
>  {
> -	cancel_delayed_work_sync(&l->filecache_laundrette);
> +	del_timer_sync(&l->timer);
>  	shrinker_free(l->file_shrinker);
>  	nfsd_file_release_list(&l->recent);
>  	WARN_ON_ONCE(!list_empty(&l->recent));

Reviewed-by: Jeff Layton <jlayton@kernel.org>

