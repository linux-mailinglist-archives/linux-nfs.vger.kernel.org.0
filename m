Return-Path: <linux-nfs+bounces-8131-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8F19D2FF2
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 22:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF461F23605
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Nov 2024 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA7F1D14F3;
	Tue, 19 Nov 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpccpaMM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6901A9B2A
	for <linux-nfs@vger.kernel.org>; Tue, 19 Nov 2024 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051028; cv=none; b=oJTz7cg+WBq3S3gG+vWSRhmCzYwH/X561QXT9dF1Z5654/2JY0qy6lJJCWUlWd5QniWuRbfiMPNJHzgF7FhbTuE7eRdSV7SKKey1s4vnzLL234rObel/a7M4bgJYclrE3YyRMh5UvGAoS++cH2d0S0/DpxQI9HuxxcJWsGdN4o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051028; c=relaxed/simple;
	bh=ccD0uaW0LQIHYV5MrHIaH9gBjR35IrAXl1aZY+pQQ6I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gl0YFiwDQFyEtwJ05OE+cPL+uovK3bhk6PIQEsuxehL7fQoQlJkfY5ykPsnvY1yOxNwpewpgYlH65LUI0JMsTYkJVE7xLkpdbTocIYXugdZAZYxGBa0qdjNiMB9Cgt1u2xh6wUNfPDmcKjDq8xB1upQYwmoEiIix1oZj6BiDxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpccpaMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ECDC4CECF;
	Tue, 19 Nov 2024 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732051028;
	bh=ccD0uaW0LQIHYV5MrHIaH9gBjR35IrAXl1aZY+pQQ6I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EpccpaMMHhU+VHq/xhpG81qhYVq88fiMumdIi8asiYuqz16ga2uxnc+kAi3szWx8E
	 0MXxwiNYfxF4I4PK2MZSeG0CVADLpUcfSh1XNkzNrsd+IXzk/M6f0dw4SriVRaQxtM
	 agHIAH2op+KuasRKqcP9bujG/88Zrpc0bRUI5ARCwTK+bKEWRllVxl84Vf+0+lJhTR
	 oldTCaZyhvjjwAfYMS8Y91Lc0WgwjZcFrzBoxRRDxO0f+MP3FwpaBqfkPAnC6BbvKY
	 FH0Vk091L1RxiaPH+AEuexz973APJ/h3Cc7VjDwFzIhBHHYr84oSjhJnexkBJRau5w
	 KRSv77C4e0YXA==
Message-ID: <468675e119863804dfe585c08cd87c9510af5afa.camel@kernel.org>
Subject: Re: [PATCH 6/6] nfsd: add shrinker to reduce number of slots
 allocated per session
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Tue, 19 Nov 2024 16:17:06 -0500
In-Reply-To: <20241119004928.3245873-7-neilb@suse.de>
References: <20241119004928.3245873-1-neilb@suse.de>
	 <20241119004928.3245873-7-neilb@suse.de>
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

On Tue, 2024-11-19 at 11:41 +1100, NeilBrown wrote:
> Add a shrinker which frees unused slots and may ask the clients to use
> fewer slots on each session.
>=20
> Each session now tracks se_client_maxreqs which is the most recent
> max-requests-in-use reported by the client, and se_target_maxreqs which
> is a target number of requests which is reduced by the shrinker.
>=20
> The shrinker iterates over all sessions on all client in all
> net-namespaces and reduces the target by 1 for each.  The shrinker may
> get called multiple times to reduce by more than 1 each.
>=20
> If se_target_maxreqs is above se_client_maxreqs, those slots can be
> freed immediately.  If not the client will be ask to reduce its usage
> and as the usage goes down slots will be freed.
>=20
> Once the usage has dropped to match the target, the target can be
> increased if the client uses all available slots and if a GFP_NOWAIT
> allocation succeeds.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 72 ++++++++++++++++++++++++++++++++++++++++++---
>  fs/nfsd/state.h     |  1 +
>  2 files changed, 69 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 0625b0aec6b8..ac49c3bd0dcb 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1909,6 +1909,16 @@ gen_sessionid(struct nfsd4_session *ses)
>   */
>  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> =20
> +static struct shrinker *nfsd_slot_shrinker;
> +static DEFINE_SPINLOCK(nfsd_session_list_lock);
> +static LIST_HEAD(nfsd_session_list);
> +/* The sum of "target_slots-1" on every session.  The shrinker can push =
this
> + * down, though it can take a little while for the memory to actually
> + * be freed.  The "-1" is because we can never free slot 0 while the
> + * session is active.
> + */
> +static atomic_t nfsd_total_target_slots =3D ATOMIC_INIT(0);
> +
>  static void
>  free_session_slots(struct nfsd4_session *ses, int from)
>  {
> @@ -1931,11 +1941,14 @@ free_session_slots(struct nfsd4_session *ses, int=
 from)
>  		kfree(slot);
>  	}
>  	ses->se_fchannel.maxreqs =3D from;
> -	if (ses->se_target_maxslots > from)
> -		ses->se_target_maxslots =3D from;
> +	if (ses->se_target_maxslots > from) {
> +		int new_target =3D from ?: 1;

Let's make that "from ? from : 1". The above is a non-standard gcc-ism
(AIUI).

> +		atomic_sub(ses->se_target_maxslots - new_target, &nfsd_total_target_sl=
ots);
> +		ses->se_target_maxslots =3D new_target;
> +	}
>  }
> =20
> -static int __maybe_unused
> +static int
>  reduce_session_slots(struct nfsd4_session *ses, int dec)
>  {
>  	struct nfsd_net *nn =3D net_generic(ses->se_client->net,
> @@ -1948,6 +1961,7 @@ reduce_session_slots(struct nfsd4_session *ses, int=
 dec)
>  		return ret;
>  	ret =3D min(dec, ses->se_target_maxslots-1);
>  	ses->se_target_maxslots -=3D ret;
> +	atomic_sub(ret, &nfsd_total_target_slots);
>  	ses->se_slot_gen +=3D 1;
>  	if (ses->se_slot_gen =3D=3D 0) {
>  		int i;
> @@ -2006,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct n=
fsd4_channel_attrs *fattrs,
>  	fattrs->maxreqs =3D i;
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
>  	new->se_target_maxslots =3D i;
> +	atomic_add(i - 1, &nfsd_total_target_slots);
>  	new->se_cb_slot_avail =3D ~0U;
>  	new->se_cb_highest_slot =3D min(battrs->maxreqs - 1,
>  				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2130,6 +2145,36 @@ static void free_session(struct nfsd4_session *ses=
)
>  	__free_session(ses);
>  }
> =20
> +static unsigned long
> +nfsd_slot_count(struct shrinker *s, struct shrink_control *sc)
> +{
> +	unsigned long cnt =3D atomic_read(&nfsd_total_target_slots);
> +
> +	return cnt ? cnt : SHRINK_EMPTY;
> +}
> +
> +static unsigned long
> +nfsd_slot_scan(struct shrinker *s, struct shrink_control *sc)
> +{
> +	struct nfsd4_session *ses;
> +	unsigned long scanned =3D 0;
> +	unsigned long freed =3D 0;
> +
> +	spin_lock(&nfsd_session_list_lock);
> +	list_for_each_entry(ses, &nfsd_session_list, se_all_sessions) {
> +		freed +=3D reduce_session_slots(ses, 1);
> +		scanned +=3D 1;
> +		if (scanned >=3D sc->nr_to_scan) {
> +			/* Move starting point for next scan */
> +			list_move(&nfsd_session_list, &ses->se_all_sessions);
> +			break;
> +		}
> +	}
> +	spin_unlock(&nfsd_session_list_lock);
> +	sc->nr_scanned =3D scanned;
> +	return freed;
> +}
> +
>  static void init_session(struct svc_rqst *rqstp, struct nfsd4_session *n=
ew, struct nfs4_client *clp, struct nfsd4_create_session *cses)
>  {
>  	int idx;
> @@ -2154,6 +2199,10 @@ static void init_session(struct svc_rqst *rqstp, s=
truct nfsd4_session *new, stru
>  	list_add(&new->se_perclnt, &clp->cl_sessions);
>  	spin_unlock(&clp->cl_lock);
> =20
> +	spin_lock(&nfsd_session_list_lock);
> +	list_add_tail(&new->se_all_sessions, &nfsd_session_list);
> +	spin_unlock(&nfsd_session_list_lock);
> +
>  	{
>  		struct sockaddr *sa =3D svc_addr(rqstp);
>  		/*
> @@ -2223,6 +2272,9 @@ unhash_session(struct nfsd4_session *ses)
>  	spin_lock(&ses->se_client->cl_lock);
>  	list_del(&ses->se_perclnt);
>  	spin_unlock(&ses->se_client->cl_lock);
> +	spin_lock(&nfsd_session_list_lock);
> +	list_del(&ses->se_all_sessions);
> +	spin_unlock(&nfsd_session_list_lock);
>  }
> =20
>  /* SETCLIENTID and SETCLIENTID_CONFIRM Helper functions */
> @@ -4335,6 +4387,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  	slot->sl_seqid =3D seq->seqid;
>  	slot->sl_flags &=3D ~NFSD4_SLOT_REUSED;
>  	slot->sl_flags |=3D NFSD4_SLOT_INUSE;
> +	slot->sl_generation =3D session->se_slot_gen;
>  	if (seq->cachethis)
>  		slot->sl_flags |=3D NFSD4_SLOT_CACHETHIS;
>  	else
> @@ -4371,6 +4424,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  		if (slot && !xa_is_err(xa_store(&session->se_slots, s, slot,
>  						GFP_ATOMIC))) {
>  			session->se_fchannel.maxreqs +=3D 1;
> +			atomic_add(session->se_fchannel.maxreqs - session->se_target_maxslots=
,
> +				   &nfsd_total_target_slots);
>  			session->se_target_maxslots =3D session->se_fchannel.maxreqs;
>  		} else {
>  			kfree(slot);
> @@ -8779,7 +8834,6 @@ nfs4_state_start_net(struct net *net)
>  }
> =20
>  /* initialization to perform when the nfsd service is started: */
> -
>  int
>  nfs4_state_start(void)
>  {
> @@ -8789,6 +8843,15 @@ nfs4_state_start(void)
>  	if (ret)
>  		return ret;
> =20
> +	nfsd_slot_shrinker =3D shrinker_alloc(0, "nfsd-DRC-slot");
> +	if (!nfsd_slot_shrinker) {
> +		rhltable_destroy(&nfs4_file_rhltable);
> +		return -ENOMEM;
> +	}
> +	nfsd_slot_shrinker->count_objects =3D nfsd_slot_count;
> +	nfsd_slot_shrinker->scan_objects =3D nfsd_slot_scan;
> +	shrinker_register(nfsd_slot_shrinker);
> +
>  	set_max_delegations();
>  	return 0;
>  }
> @@ -8830,6 +8893,7 @@ void
>  nfs4_state_shutdown(void)
>  {
>  	rhltable_destroy(&nfs4_file_rhltable);
> +	shrinker_free(nfsd_slot_shrinker);
>  }
> =20
>  static void
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index ea6659d52be2..0e320ba097f2 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -345,6 +345,7 @@ struct nfsd4_session {
>  	bool			se_dead;
>  	struct list_head	se_hash;	/* hash by sessionid */
>  	struct list_head	se_perclnt;
> +	struct list_head	se_all_sessions;/* global list of sessions */
>  	struct nfs4_client	*se_client;
>  	struct nfs4_sessionid	se_sessionid;
>  	struct nfsd4_channel_attrs se_fchannel;

--=20
Jeff Layton <jlayton@kernel.org>

