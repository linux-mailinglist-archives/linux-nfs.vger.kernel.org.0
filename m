Return-Path: <linux-nfs+bounces-8378-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B09E66E3
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 06:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E9E1884ED5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 05:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1EA193426;
	Fri,  6 Dec 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQGuBJ6c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D2198E8C
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463014; cv=none; b=NDPLElNCmtsxyNctmSqWlecHNhk8WCrx9Gbyky8n/TRj1A+oTPHYbStOvUhBlYkyz85Z8Q6wCT+AXPa+CweiNiNIUU2MRmYTZyzfMN84Bl6XcjiMBa+GSDoGoJZgOM0IqFeRz1L8cZsUaK9QGpHfQlgPFAwSooXoyKEEW0bYYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463014; c=relaxed/simple;
	bh=HbcoDoZW2j8668llZSs0Br21N6igzL0ugGDiAm3bGFM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SxEthITJGtvZMMyV3dlaSsCoHl8HttLPwuN1tF4RVxlTD7fS6dMXUSCFjUCb+da2aOrLGQJNmxMLNsXKNyYaBgkrOgGSVGRZcgx+1uudCdMdiVCaFbANUbrXR/36lQ16ENvj/NFqV/v8v+if0XnGKNo4Jqv+bVccl+cRHbH+iEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQGuBJ6c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A835C4CED1;
	Fri,  6 Dec 2024 05:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733463014;
	bh=HbcoDoZW2j8668llZSs0Br21N6igzL0ugGDiAm3bGFM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mQGuBJ6cM96qi2kQApW9wuJ9yJrTprUjSACav7v/3tFJMHE4vbWbhkOWz/hwq69EA
	 KR/RxExoOEyDXQgwdJy/ijdplfD/8bIDK65rU0Kuwb3vT/8IzD7RLPlCK2XHj50zgL
	 wTNwdY/4l6O42c5Zlo9J2Tbnwm7cXexLgqFw5jtvAdERxk/NUaksqCMHuO6zPYK3fK
	 aryvRqMlEUq6ZmNCxQhsdPVNCfuRZ8gSoQLWm9PO9VHKRDzOyis33xY1LRC0Cnbxms
	 iEX31jurF2+R5ysHKuyT1DIHMIYz6ULorxKkYAN6lR6C/ax0yJwtpcbiDdXE6eOEOo
	 nH7cSDAbJ4oRA==
Message-ID: <fc4542f333779947144c19024bbb924a82932bff.camel@kernel.org>
Subject: Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC
 slots
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Thu, 05 Dec 2024 21:30:13 -0800
In-Reply-To: <20241206004829.3497925-6-neilb@suse.de>
References: <20241206004829.3497925-1-neilb@suse.de>
	 <20241206004829.3497925-6-neilb@suse.de>
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

On Fri, 2024-12-06 at 11:43 +1100, NeilBrown wrote:
> Reducing the number of slots in the session slot table requires
> confirmation from the client.  This patch adds reduce_session_slots()
> which starts the process of getting confirmation, but never calls it.
> That will come in a later patch.
>=20
> Before we can free a slot we need to confirm that the client won't try
> to use it again.  This involves returning a lower cr_maxrequests in a
> SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> is not larger than we limit we are trying to impose.  So for each slot
> we need to remember that we have sent a reduced cr_maxrequests.
>=20
> To achieve this we introduce a concept of request "generations".  Each
> time we decide to reduce cr_maxrequests we increment the generation
> number, and record this when we return the lower cr_maxrequests to the
> client.  When a slot with the current generation reports a low
> ca_maxrequests, we commit to that level and free extra slots.
>=20
> We use an 8 bit generation number (64 seems wasteful) and if it cycles
> we iterate all slots and reset the generation number to avoid false match=
es.
>=20
> When we free a slot we store the seqid in the slot pointer so that it can
> be restored when we reactivate the slot.  The RFC can be read as
> suggesting that the slot number could restart from one after a slot is
> retired and reactivated, but also suggests that retiring slots is not
> required.  So when we reactive a slot we accept with the next seqid in
> sequence, or 1.
>=20
> When decoding sa_highest_slotid into maxslots we need to add 1 - this
> matches how it is encoded for the reply.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/nfs4state.c | 80 +++++++++++++++++++++++++++++++++++++++------
>  fs/nfsd/nfs4xdr.c   |  5 +--
>  fs/nfsd/state.h     |  4 +++
>  fs/nfsd/xdr4.h      |  2 --
>  4 files changed, 77 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index ec4468ebbd40..e73668462739 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -1910,17 +1910,54 @@ gen_sessionid(struct nfsd4_session *ses)
>  #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> =20
>  static void
> -free_session_slots(struct nfsd4_session *ses)
> +free_session_slots(struct nfsd4_session *ses, int from)
>  {
>  	int i;
> =20
> -	for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> +	if (from >=3D ses->se_fchannel.maxreqs)
> +		return;
> +
> +	for (i =3D from; i < ses->se_fchannel.maxreqs; i++) {
>  		struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> =20
> -		xa_erase(&ses->se_slots, i);
> +		/*
> +		 * Save the seqid in case we reactivate this slot.
> +		 * This will never require a memory allocation so GFP
> +		 * flag is irrelevant
> +		 */
> +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
>  		free_svc_cred(&slot->sl_cred);
>  		kfree(slot);
>  	}
> +	ses->se_fchannel.maxreqs =3D from;
> +	if (ses->se_target_maxslots > from)
> +		ses->se_target_maxslots =3D from;
> +}
> +
> +static int __maybe_unused
> +reduce_session_slots(struct nfsd4_session *ses, int dec)
> +{
> +	struct nfsd_net *nn =3D net_generic(ses->se_client->net,
> +					  nfsd_net_id);
> +	int ret =3D 0;
> +
> +	if (ses->se_target_maxslots <=3D 1)
> +		return ret;
> +	if (!spin_trylock(&nn->client_lock))
> +		return ret;
> +	ret =3D min(dec, ses->se_target_maxslots-1);
> +	ses->se_target_maxslots -=3D ret;
> +	ses->se_slot_gen +=3D 1;
> +	if (ses->se_slot_gen =3D=3D 0) {
> +		int i;
> +		ses->se_slot_gen =3D 1;
> +		for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> +			struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> +			slot->sl_generation =3D 0;
> +		}
> +	}
> +	spin_unlock(&nn->client_lock);
> +	return ret;
>  }
> =20
>  /*
> @@ -1968,6 +2005,7 @@ static struct nfsd4_session *alloc_session(struct n=
fsd4_channel_attrs *fattrs,
>  	}
>  	fattrs->maxreqs =3D i;
>  	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs));
> +	new->se_target_maxslots =3D i;
>  	new->se_cb_slot_avail =3D ~0U;
>  	new->se_cb_highest_slot =3D min(battrs->maxreqs - 1,
>  				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> @@ -2081,7 +2119,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s=
)
> =20
>  static void __free_session(struct nfsd4_session *ses)
>  {
> -	free_session_slots(ses);
> +	free_session_slots(ses, 0);
>  	xa_destroy(&ses->se_slots);
>  	kfree(ses);
>  }
> @@ -2684,6 +2722,9 @@ static int client_info_show(struct seq_file *m, voi=
d *v)
>  	seq_printf(m, "session slots:");
>  	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
>  		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> +	seq_printf(m, "\nsession target slots:");
> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> +		seq_printf(m, " %u", ses->se_target_maxslots);
>  	spin_unlock(&clp->cl_lock);
>  	seq_puts(m, "\n");
> =20
> @@ -3674,10 +3715,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
>  	kfree(exid->server_impl_name);
>  }
> =20
> -static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_inus=
e)
> +static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
>  {
>  	/* The slot is in use, and no response has been sent. */
> -	if (slot_inuse) {
> +	if (flags & NFSD4_SLOT_INUSE) {
>  		if (seqid =3D=3D slot_seqid)
>  			return nfserr_jukebox;
>  		else
> @@ -3686,6 +3727,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slot_=
seqid, bool slot_inuse)
>  	/* Note unsigned 32-bit arithmetic handles wraparound: */
>  	if (likely(seqid =3D=3D slot_seqid + 1))
>  		return nfs_ok;
> +	if ((flags & NFSD4_SLOT_REUSED) && seqid =3D=3D 1)
> +		return nfs_ok;
>  	if (seqid =3D=3D slot_seqid)
>  		return nfserr_replay_cache;
>  	return nfserr_seq_misordered;
> @@ -4236,8 +4279,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
>  	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> =20
>  	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> -	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> -					slot->sl_flags & NFSD4_SLOT_INUSE);
> +	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flags)=
;
>  	if (status =3D=3D nfserr_replay_cache) {
>  		status =3D nfserr_seq_misordered;
>  		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
> @@ -4262,6 +4304,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>  	if (status)
>  		goto out_put_session;
> =20
> +	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
> +	    slot->sl_generation =3D=3D session->se_slot_gen &&
> +	    seq->maxslots <=3D session->se_target_maxslots)
> +		/* Client acknowledged our reduce maxreqs */
> +		free_session_slots(session, session->se_target_maxslots);
> +
>  	buflen =3D (seq->cachethis) ?
>  			session->se_fchannel.maxresp_cached :
>  			session->se_fchannel.maxresp_sz;
> @@ -4272,9 +4320,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>  	svc_reserve(rqstp, buflen);
> =20
>  	status =3D nfs_ok;
> -	/* Success! bump slot seqid */
> +	/* Success! accept new slot seqid */
>  	slot->sl_seqid =3D seq->seqid;
> +	slot->sl_flags &=3D ~NFSD4_SLOT_REUSED;
>  	slot->sl_flags |=3D NFSD4_SLOT_INUSE;
> +	slot->sl_generation =3D session->se_slot_gen;
>  	if (seq->cachethis)
>  		slot->sl_flags |=3D NFSD4_SLOT_CACHETHIS;
>  	else
> @@ -4291,9 +4341,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd=
4_compound_state *cstate,
>  	 * the client might use.
>  	 */
>  	if (seq->slotid =3D=3D session->se_fchannel.maxreqs - 1 &&
> +	    session->se_target_maxslots >=3D session->se_fchannel.maxreqs &&
>  	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
>  		int s =3D session->se_fchannel.maxreqs;
>  		int cnt =3D DIV_ROUND_UP(s, 5);
> +		void *prev_slot;
> =20
>  		do {
>  			/*
> @@ -4307,17 +4359,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
>  			 */
>  			slot =3D kzalloc(slot_bytes(&session->se_fchannel),
>  				       GFP_NOWAIT);
> +			prev_slot =3D xa_load(&session->se_slots, s);
> +			if (xa_is_value(prev_slot) && slot) {
> +				slot->sl_seqid =3D xa_to_value(prev_slot);
> +				slot->sl_flags |=3D NFSD4_SLOT_REUSED;
> +			}
>  			if (slot &&
>  			    !xa_is_err(xa_store(&session->se_slots, s, slot,
>  						GFP_ATOMIC | __GFP_NOWARN))) {
>  				s +=3D 1;
>  				session->se_fchannel.maxreqs =3D s;
> +				session->se_target_maxslots =3D s;
>  			} else {
>  				kfree(slot);
> +				slot =3D NULL;
>  			}
>  		} while (slot && --cnt > 0);
>  	}
> -	seq->maxslots =3D session->se_fchannel.maxreqs;
> +	seq->maxslots =3D max(session->se_target_maxslots, seq->maxslots);
> +	seq->target_maxslots =3D session->se_target_maxslots;
> =20
>  out:
>  	switch (clp->cl_cb_state) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 53fac037611c..4dcb03cd9292 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *ar=
gp,
>  		return nfserr_bad_xdr;
>  	seq->seqid =3D be32_to_cpup(p++);
>  	seq->slotid =3D be32_to_cpup(p++);
> -	seq->maxslots =3D be32_to_cpup(p++);
> +	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
> +	seq->maxslots =3D be32_to_cpup(p++) + 1;
>  	seq->cachethis =3D be32_to_cpup(p);
> =20
>  	seq->status_flags =3D 0;
> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *res=
p, __be32 nfserr,
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
>  	/* sr_target_highest_slotid */
> -	nfserr =3D nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> +	nfserr =3D nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
>  	if (nfserr !=3D nfs_ok)
>  		return nfserr;
>  	/* sr_status_flags */
> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> index aad547d3ad8b..74f2ab3c95aa 100644
> --- a/fs/nfsd/state.h
> +++ b/fs/nfsd/state.h
> @@ -249,7 +249,9 @@ struct nfsd4_slot {
>  #define NFSD4_SLOT_CACHETHIS	(1 << 1)
>  #define NFSD4_SLOT_INITIALIZED	(1 << 2)
>  #define NFSD4_SLOT_CACHED	(1 << 3)
> +#define NFSD4_SLOT_REUSED	(1 << 4)
>  	u8	sl_flags;
> +	u8	sl_generation;
>  	char	sl_data[];
>  };
> =20
> @@ -331,6 +333,8 @@ struct nfsd4_session {
>  	struct list_head	se_conns;
>  	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
>  	struct xarray		se_slots;	/* forward channel slots */
> +	u8			se_slot_gen;
> +	u32			se_target_maxslots;
>  };
> =20
>  /* formatted contents of nfs4_sessionid */
> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> index 382cc1389396..c26ba86dbdfd 100644
> --- a/fs/nfsd/xdr4.h
> +++ b/fs/nfsd/xdr4.h
> @@ -576,9 +576,7 @@ struct nfsd4_sequence {
>  	u32			slotid;			/* request/response */
>  	u32			maxslots;		/* request/response */
>  	u32			cachethis;		/* request */
> -#if 0
>  	u32			target_maxslots;	/* response */
> -#endif /* not yet */
>  	u32			status_flags;		/* response */
>  };
> =20


I don't see where the above "#if 0" gets removed in patch 6. Shouldn't
it be?

While it makes for a larger patch, I think we'd be better served by
squashing 5 and 6 together. It doesn't make sense to add this core
infrastructure without something to call it.
--=20
Jeff Layton <jlayton@kernel.org>

