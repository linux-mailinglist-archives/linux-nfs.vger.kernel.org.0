Return-Path: <linux-nfs+bounces-7938-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98AB9C79AE
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 18:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABD2B241B0
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B18B1632E5;
	Wed, 13 Nov 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xq5pzEcQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFA1494CC
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516522; cv=none; b=TFoJ0aik/6Wf8ZXqushahRnH+TNGS1FsL7zKGYOaSzwJkMUnbXTcz4OUBswd+cmn51m/EljKUooKNr/4wsI1Z2gRTG7bYJQU0Fbsd+TJCOW6GyPQfcupgJZcNATbVJ/E1b2QpWqiki4QrBVXyy9M5SdgrqGuu73b2o9QkOZzCqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516522; c=relaxed/simple;
	bh=Ttzcmz59EuQuJWgWPnZxmcyEtNf0NBZ/i1YIkBXtQEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IoVYhffl0w68Ev0ibVr9eYKP35/961lNFyVsg2iG5EPofEhVHINtYY+UAkNbNglELcw/gxjvD3WGvsSRWWQiHQpPA88V7cdyoRFxK11dpdLLMgylDAlieB7Vc/rS5W1mVj4nG+XlAUpp95Xpz3HMFWfSRekQBstPQORmahijDdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xq5pzEcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B08EC4CECD;
	Wed, 13 Nov 2024 16:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731516519;
	bh=Ttzcmz59EuQuJWgWPnZxmcyEtNf0NBZ/i1YIkBXtQEw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Xq5pzEcQqgpFqFWYm7jcWr7tYk71jd83Ha3NacQK7ACtZW81Xa8NcgsVvxewyNDJ4
	 HghPVYfWTTbYXxo8mJn+7+fgOHax5p45btksxMyY5U7mYhx3ynv5hXNQa7CYSfvKHv
	 SBO5s8JTp0VgY/DtW18GsVscUeCwesXmv4dTDKYQ9jCSDS960uDZMo8AQ77Q7C9AEW
	 Znz6h104zhsniEw0tntZnlkLu/kRSx7ZnPGSZV7ZM8l6g7J3irrGlIcsVQJwqTIIiZ
	 vX1RUdrblwB5/7+5YPiNB1UituZI17sn2SV0tCd9i4Bg6/K6eHFA60LY+rwQJH+Nvu
	 PS3a0iAC5zsDw==
Message-ID: <1db227ccb347c7877998ab20a609bc3a9896c7db.camel@kernel.org>
Subject: Re: [PATCH 1/4] nfsd: remove artificial limits on the session-based
 DRC
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Wed, 13 Nov 2024 11:48:38 -0500
In-Reply-To: <20241113055345.494856-2-neilb@suse.de>
References: <20241113055345.494856-1-neilb@suse.de>
	 <20241113055345.494856-2-neilb@suse.de>
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

On Wed, 2024-11-13 at 16:38 +1100, NeilBrown wrote:
> Rather than guessing how much space it might be safe to use for the DRC,
> simply try allocating slots and be prepared to accept failure.
>=20
> The first slot for each session is allocated with GFP_KERNEL which is
> unlikely to fail.  Subsequent slots are allocated with the addition of
> __GFP_NORETRY which is expected to fail if there isn't much free memory.
>=20
> This is probably too aggressive but clears the way for adding a
> shrinker interface to free extra slots when memory is tight.
>=20
> Also *always* allow NFSD_MAX_SLOTS_PER_SESSION slot pointers per
> session.  This allows the session to be allocated before we know how
> many slots we will successfully allocate, and will be useful when we
> starting dynamically increasing the number of allocated slots.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 91 +++++++--------------------------------------
>  fs/nfsd/nfsd.h      |  3 --
>  fs/nfsd/nfssvc.c    | 32 ----------------
>  fs/nfsd/state.h     |  2 +-
>  4 files changed, 14 insertions(+), 114 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 551d2958ec29..2dcba0c83c10 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1935,59 +1935,6 @@ static inline u32 slot_bytes(struct nfsd4_channel_=
attrs *ca)
>  	return size + sizeof(struct nfsd4_slot);
>  }
> =20
> -/*
> - * XXX: If we run out of reserved DRC memory we could (up to a point)
> - * re-negotiate active sessions and reduce their slot usage to make
> - * room for new connections. For now we just fail the create session.
> - */
> -static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd=
_net *nn)
> -{
> -	u32 slotsize =3D slot_bytes(ca);
> -	u32 num =3D ca->maxreqs;
> -	unsigned long avail, total_avail;
> -	unsigned int scale_factor;
> -
> -	spin_lock(&nfsd_drc_lock);
> -	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> -		total_avail =3D nfsd_drc_max_mem - nfsd_drc_mem_used;
> -	else
> -		/* We have handed out more space than we chose in
> -		 * set_max_drc() to allow.  That isn't really a
> -		 * problem as long as that doesn't make us think we
> -		 * have lots more due to integer overflow.
> -		 */
> -		total_avail =3D 0;
> -	avail =3D min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> -	/*
> -	 * Never use more than a fraction of the remaining memory,
> -	 * unless it's the only way to give this client a slot.
> -	 * The chosen fraction is either 1/8 or 1/number of threads,
> -	 * whichever is smaller.  This ensures there are adequate
> -	 * slots to support multiple clients per thread.
> -	 * Give the client one slot even if that would require
> -	 * over-allocation--it is better than failure.
> -	 */
> -	scale_factor =3D max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> -
> -	avail =3D clamp_t(unsigned long, avail, slotsize,
> -			total_avail/scale_factor);
> -	num =3D min_t(int, num, avail / slotsize);
> -	num =3D max_t(int, num, 1);
> -	nfsd_drc_mem_used +=3D num * slotsize;
> -	spin_unlock(&nfsd_drc_lock);
> -
> -	return num;
> -}
> -
> -static void nfsd4_put_drc_mem(struct nfsd4_channel_attrs *ca)
> -{
> -	int slotsize =3D slot_bytes(ca);
> -
> -	spin_lock(&nfsd_drc_lock);
> -	nfsd_drc_mem_used -=3D slotsize * ca->maxreqs;
> -	spin_unlock(&nfsd_drc_lock);
> -}
> -
>  static struct nfsd4_session *alloc_session(struct nfsd4_channel_attrs *f=
attrs,
>  					   struct nfsd4_channel_attrs *battrs)
>  {
> @@ -1996,26 +1943,27 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
>  	struct nfsd4_session *new;
>  	int i;
> =20
> -	BUILD_BUG_ON(struct_size(new, se_slots, NFSD_MAX_SLOTS_PER_SESSION)
> -		     > PAGE_SIZE);
> +	BUILD_BUG_ON(sizeof(new) > PAGE_SIZE);
> =20
> -	new =3D kzalloc(struct_size(new, se_slots, numslots), GFP_KERNEL);
> +	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
>  	if (!new)
>  		return NULL;
>  	/* allocate each struct nfsd4_slot and data cache in one piece */
> -	for (i =3D 0; i < numslots; i++) {
> -		new->se_slots[i] =3D kzalloc(slotsize, GFP_KERNEL);
> +	new->se_slots[0] =3D kzalloc(slotsize, GFP_KERNEL);
> +	if (!new->se_slots[0])
> +		goto out_free;
> +
> +	for (i =3D 1; i < numslots; i++) {
> +		new->se_slots[i] =3D kzalloc(slotsize, GFP_KERNEL | __GFP_NORETRY);
>  		if (!new->se_slots[i])
> -			goto out_free;
> +			break;
>  	}
> -
> +	fattrs->maxreqs =3D i;
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>  	memcpy(&new->se_bchannel, battrs, sizeof(struct nfsd4_channel_attrs));
> =20
>  	return new;
>  out_free:
> -	while (i--)
> -		kfree(new->se_slots[i]);
>  	kfree(new);
>  	return NULL;
>  }
> @@ -2128,7 +2076,6 @@ static void __free_session(struct nfsd4_session *se=
s)
>  static void free_session(struct nfsd4_session *ses)
>  {
>  	nfsd4_del_conns(ses);
> -	nfsd4_put_drc_mem(&ses->se_fchannel);
>  	__free_session(ses);
>  }
> =20
> @@ -3748,17 +3695,6 @@ static __be32 check_forechannel_attrs(struct nfsd4=
_channel_attrs *ca, struct nfs
>  	ca->maxresp_cached =3D min_t(u32, ca->maxresp_cached,
>  			NFSD_SLOT_CACHE_SIZE + NFSD_MIN_HDR_SEQ_SZ);
>  	ca->maxreqs =3D min_t(u32, ca->maxreqs, NFSD_MAX_SLOTS_PER_SESSION);
> -	/*
> -	 * Note decreasing slot size below client's request may make it
> -	 * difficult for client to function correctly, whereas
> -	 * decreasing the number of slots will (just?) affect
> -	 * performance.  When short on memory we therefore prefer to
> -	 * decrease number of slots instead of their size.  Clients that
> -	 * request larger slots than they need will get poor results:
> -	 * Note that we always allow at least one slot, because our
> -	 * accounting is soft and provides no guarantees either way.
> -	 */
> -	ca->maxreqs =3D nfsd4_get_drc_mem(ca, nn);
> =20
>  	return nfs_ok;
>  }
> @@ -3836,11 +3772,11 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>  		return status;
>  	status =3D check_backchannel_attrs(&cr_ses->back_channel);
>  	if (status)
> -		goto out_release_drc_mem;
> +		goto out_err;
>  	status =3D nfserr_jukebox;
>  	new =3D alloc_session(&cr_ses->fore_channel, &cr_ses->back_channel);
>  	if (!new)
> -		goto out_release_drc_mem;
> +		goto out_err;
>  	conn =3D alloc_conn_from_crses(rqstp, cr_ses);
>  	if (!conn)
>  		goto out_free_session;
> @@ -3950,8 +3886,7 @@ nfsd4_create_session(struct svc_rqst *rqstp,
>  		expire_client(old);
>  out_free_session:
>  	__free_session(new);
> -out_release_drc_mem:
> -	nfsd4_put_drc_mem(&cr_ses->fore_channel);
> +out_err:
>  	return status;
>  }
> =20
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4b56ba1e8e48..3eb21e63b921 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -88,9 +88,6 @@ struct nfsd_genl_rqstp {
>  extern struct svc_program	nfsd_programs[];
>  extern const struct svc_version	nfsd_version2, nfsd_version3, nfsd_versi=
on4;
>  extern struct mutex		nfsd_mutex;
> -extern spinlock_t		nfsd_drc_lock;
> -extern unsigned long		nfsd_drc_max_mem;
> -extern unsigned long		nfsd_drc_mem_used;
>  extern atomic_t			nfsd_th_cnt;		/* number of available threads */
> =20
>  extern const struct seq_operations nfs_exports_op;
> diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
> index 49e2f32102ab..3dbaefc96608 100644
> --- a/fs/nfsd/nfssvc.c
> +++ b/fs/nfsd/nfssvc.c
> @@ -70,16 +70,6 @@ static __be32			nfsd_init_request(struct svc_rqst *,
>   */
>  DEFINE_MUTEX(nfsd_mutex);
> =20
> -/*
> - * nfsd_drc_lock protects nfsd_drc_max_pages and nfsd_drc_pages_used.
> - * nfsd_drc_max_pages limits the total amount of memory available for
> - * version 4.1 DRC caches.
> - * nfsd_drc_pages_used tracks the current version 4.1 DRC memory usage.
> - */
> -DEFINE_SPINLOCK(nfsd_drc_lock);
> -unsigned long	nfsd_drc_max_mem;
> -unsigned long	nfsd_drc_mem_used;
> -
>  #if IS_ENABLED(CONFIG_NFS_LOCALIO)
>  static const struct svc_version *localio_versions[] =3D {
>  	[1] =3D &localio_version1,
> @@ -575,27 +565,6 @@ void nfsd_reset_versions(struct nfsd_net *nn)
>  		}
>  }
> =20
> -/*
> - * Each session guarantees a negotiated per slot memory cache for replie=
s
> - * which in turn consumes memory beyond the v2/v3/v4.0 server. A dedicat=
ed
> - * NFSv4.1 server might want to use more memory for a DRC than a machine
> - * with mutiple services.
> - *
> - * Impose a hard limit on the number of pages for the DRC which varies
> - * according to the machines free pages. This is of course only a defaul=
t.
> - *
> - * For now this is a #defined shift which could be under admin control
> - * in the future.
> - */
> -static void set_max_drc(void)
> -{
> -	#define NFSD_DRC_SIZE_SHIFT	7
> -	nfsd_drc_max_mem =3D (nr_free_buffer_pages()
> -					>> NFSD_DRC_SIZE_SHIFT) * PAGE_SIZE;
> -	nfsd_drc_mem_used =3D 0;
> -	dprintk("%s nfsd_drc_max_mem %lu \n", __func__, nfsd_drc_max_mem);
> -}
> -
>  static int nfsd_get_default_max_blksize(void)
>  {
>  	struct sysinfo i;
> @@ -678,7 +647,6 @@ int nfsd_create_serv(struct net *net)
>  	nn->nfsd_serv =3D serv;
>  	spin_unlock(&nfsd_notifier_lock);
> =20
> -	set_max_drc();
>  	/* check if the notifier is already set */
>  	if (atomic_inc_return(&nfsd_notifier_refcount) =3D=3D 1) {
>  		register_inetaddr_notifier(&nfsd_inetaddr_notifier);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index 35b3564c065f..c052e9eea81b 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -310,7 +310,7 @@ struct nfsd4_session {
>  	struct list_head	se_conns;
>  	u32			se_cb_prog;
>  	u32			se_cb_seq_nr;
> -	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
> +	struct nfsd4_slot	*se_slots[NFSD_MAX_SLOTS_PER_SESSION];	/* forward cha=
nnel slots */
>  };
> =20
>  /* formatted contents of nfs4_sessionid */

I like this patch overall. One thing we could consider is allocating
slots aggressively with GFP_KERNEL up to a particular threshold, and
then switch to GFP_NOWAIT, but this seems like a reasonable place to
start.
=20
--=20
Jeff Layton <jlayton@kernel.org>

