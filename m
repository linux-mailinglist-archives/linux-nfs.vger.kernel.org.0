Return-Path: <linux-nfs+bounces-8379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFA59E66F4
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 06:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA60A1884C99
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 05:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCE13DDDD;
	Fri,  6 Dec 2024 05:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz99sNYB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3281AD7
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463638; cv=none; b=Bwnh4vdRXHshjoD3BET6xoY8SGOs6sMTJhjmtNltmPvNftP/Wl2D8o1Tat3Kbunap3pDH+SW2ThQRnQNMgQ6B7OZ3/oxCgKMjIGjRWFHFnlz1MN6PenXKV785sZD6NlOX24qBPeysgE20r4pLjxRfitnNNo0NG7XWu9WLbUD6GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463638; c=relaxed/simple;
	bh=81Vzg3x+oFTXblD5AyM3DKGzK2KumEZhfqowMhRek2I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rIK60y1Tjj2K6BlTSUVd+VZw+i1RueG3wqopGAQH6eefuOSG8mWdHlgRLibiLbDpYOrZxtI5SOQ2WonuZhaajcvdZCQPxEF1RznyBHRIMBBrrP8kja7WTdYMEGhS0oZ/Ru4lpVJH3/GuYW9KaVVgCyBq8P0pK/s0lbb5llDcsFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz99sNYB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72277C4CED1;
	Fri,  6 Dec 2024 05:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733463637;
	bh=81Vzg3x+oFTXblD5AyM3DKGzK2KumEZhfqowMhRek2I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Vz99sNYByg1CzWTCtG5fop0t47SdnndKcy7MTGCutvWbLFhFN85QDHIOWxHTAffdm
	 lv4DUp7R0se9ErHfFDzTVoi8SB0iRA4IX1M0AJai3RnlrGtIx++2oMhjy0ol3qOB0F
	 FYzwwvbkjBE/FH6HVGvqSIERXsJaGsBfWdnFaXnsfAblOZjKyTPy7LcHWjiiJh47Xd
	 8eodNkHKEziELhbnP06yLR6FEIxSeCfHGcWGoGNeVN8Z178IkeKKtmQZhVw1aMZXrJ
	 7gkt4cSqYOWkftnZMq3hwPe0SNVSOva64suVVYW9WEws7sGM5LmsIDbN6roCPfe4Ax
	 uAcVGh+myA/+Q==
Message-ID: <36a543b848e59ddf26c85d0c79b7e377d865a0af.camel@kernel.org>
Subject: Re: [PATCH 1/2] nfsd: use new wake_up_var interfaces.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Thu, 05 Dec 2024 21:40:36 -0800
In-Reply-To: <20241206025723.3537777-2-neilb@suse.de>
References: <20241206025723.3537777-1-neilb@suse.de>
	 <20241206025723.3537777-2-neilb@suse.de>
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

On Fri, 2024-12-06 at 13:55 +1100, NeilBrown wrote:
> The wake_up_var interface is fragile as barriers are sometimes needed.
> There are now new interfaces so that most wake-ups can use an interface
> that is guaranteed to have all barriers needed.
>=20
> This patch changes the wake up on cl_cb_inflight to use
> atomic_dec_and_wake_up().
>=20
> It also changes the wake up on rp_locked to use store_release_wake_up().
> This involves changing rp_locked from atomic_t to int.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4callback.c |  3 +--
>  fs/nfsd/nfs4state.c    | 16 ++++++----------
>  fs/nfsd/state.h        |  2 +-
>  3 files changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
> index 3877b53e429f..a8dc9de2f7fb 100644
> --- a/fs/nfsd/nfs4callback.c
> +++ b/fs/nfsd/nfs4callback.c
> @@ -1036,8 +1036,7 @@ static void nfsd41_cb_inflight_begin(struct nfs4_cl=
ient *clp)
>  static void nfsd41_cb_inflight_end(struct nfs4_client *clp)
>  {
> =20
> -	if (atomic_dec_and_test(&clp->cl_cb_inflight))
> -		wake_up_var(&clp->cl_cb_inflight);
> +	atomic_dec_and_wake_up(&clp->cl_cb_inflight);
>  }
> =20
>  static void nfsd41_cb_inflight_wait_complete(struct nfs4_client *clp)
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 741b9449f727..9fbf7c8f0a3e 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -4739,7 +4739,7 @@ static void init_nfs4_replay(struct nfs4_replay *rp=
)
>  	rp->rp_status =3D nfserr_serverfault;
>  	rp->rp_buflen =3D 0;
>  	rp->rp_buf =3D rp->rp_ibuf;
> -	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> +	rp->rp_locked =3D RP_UNLOCKED;
>  }
> =20
>  static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstat=
e,
> @@ -4747,9 +4747,9 @@ static int nfsd4_cstate_assign_replay(struct nfsd4_=
compound_state *cstate,
>  {
>  	if (!nfsd4_has_session(cstate)) {
>  		wait_var_event(&so->so_replay.rp_locked,
> -			       atomic_cmpxchg(&so->so_replay.rp_locked,
> -					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> -		if (atomic_read(&so->so_replay.rp_locked) =3D=3D RP_UNHASHED)
> +			       cmpxchg(&so->so_replay.rp_locked,
> +				       RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);

nit: try_cmpxchg() generates more efficient assembly. Can we switch to
that here too?

> +		if (so->so_replay.rp_locked =3D=3D RP_UNHASHED)
>  			return -EAGAIN;
>  		cstate->replay_owner =3D nfs4_get_stateowner(so);
>  	}
> @@ -4762,9 +4762,7 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compoun=
d_state *cstate)
> =20
>  	if (so !=3D NULL) {
>  		cstate->replay_owner =3D NULL;
> -		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> -		smp_mb__after_atomic();
> -		wake_up_var(&so->so_replay.rp_locked);
> +		store_release_wake_up(&so->so_replay.rp_locked, RP_UNLOCKED);
>  		nfs4_put_stateowner(so);
>  	}
>  }
> @@ -5069,9 +5067,7 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struct=
 net *net)
>  	 * Some threads with a reference might be waiting for rp_locked,
>  	 * so tell them to stop waiting.
>  	 */
> -	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> -	smp_mb__after_atomic();
> -	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
> +	store_release_wake_up(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
>  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) =3D=3D 2);
> =20
>  	release_all_access(s);
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index e16bb3717fb9..ba30b2335b66 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -505,7 +505,7 @@ struct nfs4_replay {
>  	unsigned int		rp_buflen;
>  	char			*rp_buf;
>  	struct knfsd_fh		rp_openfh;
> -	atomic_t		rp_locked;
> +	int			rp_locked;
>  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
>  };
> =20

Looks good otherwise.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

