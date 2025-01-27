Return-Path: <linux-nfs+bounces-9710-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C92ABA2012F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 23:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4C441885C2E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300051991BF;
	Mon, 27 Jan 2025 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dqxbCAVm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U7wWxV42";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dqxbCAVm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="U7wWxV42"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1E1AAC9
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738018639; cv=none; b=u6754plpk8AYIVnqXLs/wtVKuNJ/Zutk9LHwcBiYJAFrIYPtpUDSP5DmK7PVU9c13jT1vmpegYUOVXc6t0SxjnCnu2zWnDWCfpGEFOY0aqfB3vdTdWeCoP8afhSDRoYJFUMArL348UcNYVODEYMk6o2KF/oqxhLLLlWa0b4ifn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738018639; c=relaxed/simple;
	bh=HVgv7cQvqRHE78GekbZIxPPLmRrGGJf8fmlSK83eFeI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qlvtfoxeV7o57DdkRHFB2+nX28dAX/tzjOJbBAp7z/6UnUvni7v4h1xGj6GwbFmOcnBbrL0XRags0mzqWBCJkyyCxqVFt3S3sEJN782w45xHQ+dFkf/hcP0s0L40cRQ3Tczoex/OQ+0onp2oeGPMaf+iOJXBHDatSxO+tdALQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dqxbCAVm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U7wWxV42; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dqxbCAVm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=U7wWxV42; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A219321102;
	Mon, 27 Jan 2025 22:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738018632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ell52aaqrxG4WqiLiniF17Yvkg/xHhcm8KZygeJ2YWg=;
	b=dqxbCAVmcvOTaxRV3+6PSosIqJ5DTtKekWTex4E7Hi2ufDjBLLk3QSGn3PqfOZnA6Gr/Ka
	4hHosjYXCWWaIcDtOKuqtrA+3G4dfFjO4Gvp0u0UeXSYNLQ1aecW/A7wHSTRzsxMnBuXRF
	0JwIl2kjxYI/MovqjRYiR+ykGv98SgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738018632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ell52aaqrxG4WqiLiniF17Yvkg/xHhcm8KZygeJ2YWg=;
	b=U7wWxV42QQ6cQzFEY5J6f2uMMpxNIrHF+yEgPbnkZQhuzS+eKFIiqevHS8c1lXXWC/9AW0
	UNsnBwrUiMhRmBDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738018632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ell52aaqrxG4WqiLiniF17Yvkg/xHhcm8KZygeJ2YWg=;
	b=dqxbCAVmcvOTaxRV3+6PSosIqJ5DTtKekWTex4E7Hi2ufDjBLLk3QSGn3PqfOZnA6Gr/Ka
	4hHosjYXCWWaIcDtOKuqtrA+3G4dfFjO4Gvp0u0UeXSYNLQ1aecW/A7wHSTRzsxMnBuXRF
	0JwIl2kjxYI/MovqjRYiR+ykGv98SgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738018632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ell52aaqrxG4WqiLiniF17Yvkg/xHhcm8KZygeJ2YWg=;
	b=U7wWxV42QQ6cQzFEY5J6f2uMMpxNIrHF+yEgPbnkZQhuzS+eKFIiqevHS8c1lXXWC/9AW0
	UNsnBwrUiMhRmBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3245713715;
	Mon, 27 Jan 2025 22:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kNlWNUUPmGfjIwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 22:57:09 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Chuck Lever" <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Jeff Layton" <jlayton@kernel.org>
Subject:
 Re: [PATCH 5/6] nfsd: add support for freeing unused session-DRC slots
In-reply-to: <8f8b6c70-b920-456a-adbc-7a5f54046a50@oracle.com>
References: <>, <8f8b6c70-b920-456a-adbc-7a5f54046a50@oracle.com>
Date: Tue, 28 Jan 2025 09:57:06 +1100
Message-id: <173801862638.22054.11529946635645633784@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,noble.neil.brown.name:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, 28 Jan 2025, Chuck Lever wrote:
> On 1/26/25 11:08 PM, NeilBrown wrote:
> > On Sun, 19 Jan 2025, Chuck Lever wrote:
> >> On 12/11/24 4:47 PM, NeilBrown wrote:
> >>> Reducing the number of slots in the session slot table requires
> >>> confirmation from the client.  This patch adds reduce_session_slots()
> >>> which starts the process of getting confirmation, but never calls it.
> >>> That will come in a later patch.
> >>>
> >>> Before we can free a slot we need to confirm that the client won't try
> >>> to use it again.  This involves returning a lower cr_maxrequests in a
> >>> SEQUENCE reply and then seeing a ca_maxrequests on the same slot which
> >>> is not larger than we limit we are trying to impose.  So for each slot
> >>> we need to remember that we have sent a reduced cr_maxrequests.
> >>>
> >>> To achieve this we introduce a concept of request "generations".  Each
> >>> time we decide to reduce cr_maxrequests we increment the generation
> >>> number, and record this when we return the lower cr_maxrequests to the
> >>> client.  When a slot with the current generation reports a low
> >>> ca_maxrequests, we commit to that level and free extra slots.
> >>>
> >>> We use an 16 bit generation number (64 seems wasteful) and if it cycles
> >>> we iterate all slots and reset the generation number to avoid false mat=
ches.
> >>>
> >>> When we free a slot we store the seqid in the slot pointer so that it c=
an
> >>> be restored when we reactivate the slot.  The RFC can be read as
> >>> suggesting that the slot number could restart from one after a slot is
> >>> retired and reactivated, but also suggests that retiring slots is not
> >>> required.  So when we reactive a slot we accept with the next seqid in
> >>> sequence, or 1.
> >>>
> >>> When decoding sa_highest_slotid into maxslots we need to add 1 - this
> >>> matches how it is encoded for the reply.
> >>>
> >>> se_dead is moved in struct nfsd4_session to remove a hole.
> >>>
> >>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> >>> Signed-off-by: NeilBrown <neilb@suse.de>
> >>> ---
> >>>    fs/nfsd/nfs4state.c | 94 ++++++++++++++++++++++++++++++++++++++++---=
--
> >>>    fs/nfsd/nfs4xdr.c   |  5 ++-
> >>>    fs/nfsd/state.h     |  6 ++-
> >>>    fs/nfsd/xdr4.h      |  2 -
> >>>    4 files changed, 92 insertions(+), 15 deletions(-)
> >>>
> >>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> >>> index fd9473d487f3..a2d1f97b8a0e 100644
> >>> --- a/fs/nfsd/nfs4state.c
> >>> +++ b/fs/nfsd/nfs4state.c
> >>> @@ -1910,17 +1910,69 @@ gen_sessionid(struct nfsd4_session *ses)
> >>>    #define NFSD_MIN_HDR_SEQ_SZ  (24 + 12 + 44)
> >>>   =20
> >>>    static void
> >>> -free_session_slots(struct nfsd4_session *ses)
> >>> +free_session_slots(struct nfsd4_session *ses, int from)
> >>>    {
> >>>    	int i;
> >>>   =20
> >>> -	for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> >>> +	if (from >=3D ses->se_fchannel.maxreqs)
> >>> +		return;
> >>> +
> >>> +	for (i =3D from; i < ses->se_fchannel.maxreqs; i++) {
> >>>    		struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> >>>   =20
> >>> -		xa_erase(&ses->se_slots, i);
> >>> +		/*
> >>> +		 * Save the seqid in case we reactivate this slot.
> >>> +		 * This will never require a memory allocation so GFP
> >>> +		 * flag is irrelevant
> >>> +		 */
> >>> +		xa_store(&ses->se_slots, i, xa_mk_value(slot->sl_seqid), 0);
> >>>    		free_svc_cred(&slot->sl_cred);
> >>>    		kfree(slot);
> >>>    	}
> >>> +	ses->se_fchannel.maxreqs =3D from;
> >>> +	if (ses->se_target_maxslots > from)
> >>> +		ses->se_target_maxslots =3D from;
> >>> +}
> >>> +
> >>> +/**
> >>> + * reduce_session_slots - reduce the target max-slots of a session if =
possible
> >>> + * @ses:  The session to affect
> >>> + * @dec:  how much to decrease the target by
> >>> + *
> >>> + * This interface can be used by a shrinker to reduce the target max-s=
lots
> >>> + * for a session so that some slots can eventually be freed.
> >>> + * It uses spin_trylock() as it may be called in a context where anoth=
er
> >>> + * spinlock is held that has a dependency on client_lock.  As shrinker=
s are
> >>> + * best-effort, skiping a session is client_lock is already held has no
> >>> + * great coast
> >>> + *
> >>> + * Return value:
> >>> + *   The number of slots that the target was reduced by.
> >>> + */
> >>> +static int __maybe_unused
> >>> +reduce_session_slots(struct nfsd4_session *ses, int dec)
> >>> +{
> >>> +	struct nfsd_net *nn =3D net_generic(ses->se_client->net,
> >>> +					  nfsd_net_id);
> >>> +	int ret =3D 0;
> >>> +
> >>> +	if (ses->se_target_maxslots <=3D 1)
> >>> +		return ret;
> >>> +	if (!spin_trylock(&nn->client_lock))
> >>> +		return ret;
> >>> +	ret =3D min(dec, ses->se_target_maxslots-1);
> >>> +	ses->se_target_maxslots -=3D ret;
> >>> +	ses->se_slot_gen +=3D 1;
> >>> +	if (ses->se_slot_gen =3D=3D 0) {
> >>> +		int i;
> >>> +		ses->se_slot_gen =3D 1;
> >>> +		for (i =3D 0; i < ses->se_fchannel.maxreqs; i++) {
> >>> +			struct nfsd4_slot *slot =3D xa_load(&ses->se_slots, i);
> >>> +			slot->sl_generation =3D 0;
> >>> +		}
> >>> +	}
> >>> +	spin_unlock(&nn->client_lock);
> >>> +	return ret;
> >>>    }
> >>>   =20
> >>>    /*
> >>> @@ -1968,6 +2020,7 @@ static struct nfsd4_session *alloc_session(struct=
 nfsd4_channel_attrs *fattrs,
> >>>    	}
> >>>    	fattrs->maxreqs =3D i;
> >>>    	memcpy(&new->se_fchannel, fattrs, sizeof(struct nfsd4_channel_attrs=
));
> >>> +	new->se_target_maxslots =3D i;
> >>>    	new->se_cb_slot_avail =3D ~0U;
> >>>    	new->se_cb_highest_slot =3D min(battrs->maxreqs - 1,
> >>>    				      NFSD_BC_SLOT_TABLE_SIZE - 1);
> >>> @@ -2081,7 +2134,7 @@ static void nfsd4_del_conns(struct nfsd4_session =
*s)
> >>>   =20
> >>>    static void __free_session(struct nfsd4_session *ses)
> >>>    {
> >>> -	free_session_slots(ses);
> >>> +	free_session_slots(ses, 0);
> >>>    	xa_destroy(&ses->se_slots);
> >>>    	kfree(ses);
> >>>    }
> >>> @@ -2684,6 +2737,9 @@ static int client_info_show(struct seq_file *m, v=
oid *v)
> >>>    	seq_printf(m, "session slots:");
> >>>    	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> >>>    		seq_printf(m, " %u", ses->se_fchannel.maxreqs);
> >>> +	seq_printf(m, "\nsession target slots:");
> >>> +	list_for_each_entry(ses, &clp->cl_sessions, se_perclnt)
> >>> +		seq_printf(m, " %u", ses->se_target_maxslots);
> >>>    	spin_unlock(&clp->cl_lock);
> >>>    	seq_puts(m, "\n");
> >>>   =20
> >>> @@ -3674,10 +3730,10 @@ nfsd4_exchange_id_release(union nfsd4_op_u *u)
> >>>    	kfree(exid->server_impl_name);
> >>>    }
> >>>   =20
> >>> -static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, bool slot_in=
use)
> >>> +static __be32 check_slot_seqid(u32 seqid, u32 slot_seqid, u8 flags)
> >>>    {
> >>>    	/* The slot is in use, and no response has been sent. */
> >>> -	if (slot_inuse) {
> >>> +	if (flags & NFSD4_SLOT_INUSE) {
> >>>    		if (seqid =3D=3D slot_seqid)
> >>>    			return nfserr_jukebox;
> >>>    		else
> >>> @@ -3686,6 +3742,8 @@ static __be32 check_slot_seqid(u32 seqid, u32 slo=
t_seqid, bool slot_inuse)
> >>>    	/* Note unsigned 32-bit arithmetic handles wraparound: */
> >>>    	if (likely(seqid =3D=3D slot_seqid + 1))
> >>>    		return nfs_ok;
> >>> +	if ((flags & NFSD4_SLOT_REUSED) && seqid =3D=3D 1)
> >>> +		return nfs_ok;
> >>>    	if (seqid =3D=3D slot_seqid)
> >>>    		return nfserr_replay_cache;
> >>>    	return nfserr_seq_misordered;
> >>> @@ -4236,8 +4294,7 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfs=
d4_compound_state *cstate,
> >>>    	dprintk("%s: slotid %d\n", __func__, seq->slotid);
> >>>   =20
> >>>    	trace_nfsd_slot_seqid_sequence(clp, seq, slot);
> >>> -	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid,
> >>> -					slot->sl_flags & NFSD4_SLOT_INUSE);
> >>> +	status =3D check_slot_seqid(seq->seqid, slot->sl_seqid, slot->sl_flag=
s);
> >>>    	if (status =3D=3D nfserr_replay_cache) {
> >>>    		status =3D nfserr_seq_misordered;
> >>>    		if (!(slot->sl_flags & NFSD4_SLOT_INITIALIZED))
> >>> @@ -4262,6 +4319,12 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> >>>    	if (status)
> >>>    		goto out_put_session;
> >>>   =20
> >>> +	if (session->se_target_maxslots < session->se_fchannel.maxreqs &&
> >>> +	    slot->sl_generation =3D=3D session->se_slot_gen &&
> >>> +	    seq->maxslots <=3D session->se_target_maxslots)
> >>> +		/* Client acknowledged our reduce maxreqs */
> >>> +		free_session_slots(session, session->se_target_maxslots);
> >>> +
> >>>    	buflen =3D (seq->cachethis) ?
> >>>    			session->se_fchannel.maxresp_cached :
> >>>    			session->se_fchannel.maxresp_sz;
> >>> @@ -4272,9 +4335,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> >>>    	svc_reserve(rqstp, buflen);
> >>>   =20
> >>>    	status =3D nfs_ok;
> >>> -	/* Success! bump slot seqid */
> >>> +	/* Success! accept new slot seqid */
> >>>    	slot->sl_seqid =3D seq->seqid;
> >>> +	slot->sl_flags &=3D ~NFSD4_SLOT_REUSED;
> >>>    	slot->sl_flags |=3D NFSD4_SLOT_INUSE;
> >>> +	slot->sl_generation =3D session->se_slot_gen;
> >>>    	if (seq->cachethis)
> >>>    		slot->sl_flags |=3D NFSD4_SLOT_CACHETHIS;
> >>>    	else
> >>> @@ -4291,9 +4356,11 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nf=
sd4_compound_state *cstate,
> >>>    	 * the client might use.
> >>>    	 */
> >>>    	if (seq->slotid =3D=3D session->se_fchannel.maxreqs - 1 &&
> >>> +	    session->se_target_maxslots >=3D session->se_fchannel.maxreqs &&
> >>>    	    session->se_fchannel.maxreqs < NFSD_MAX_SLOTS_PER_SESSION) {
> >>>    		int s =3D session->se_fchannel.maxreqs;
> >>>    		int cnt =3D DIV_ROUND_UP(s, 5);
> >>> +		void *prev_slot;
> >>>   =20
> >>>    		do {
> >>>    			/*
> >>> @@ -4303,18 +4370,25 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
> >>>    			 */
> >>>    			slot =3D kzalloc(slot_bytes(&session->se_fchannel),
> >>>    				       GFP_NOWAIT);
> >>> +			prev_slot =3D xa_load(&session->se_slots, s);
> >>> +			if (xa_is_value(prev_slot) && slot) {
> >>> +				slot->sl_seqid =3D xa_to_value(prev_slot);
> >>> +				slot->sl_flags |=3D NFSD4_SLOT_REUSED;
> >>> +			}
> >>>    			if (slot &&
> >>>    			    !xa_is_err(xa_store(&session->se_slots, s, slot,
> >>>    						GFP_NOWAIT))) {
> >>>    				s +=3D 1;
> >>>    				session->se_fchannel.maxreqs =3D s;
> >>> +				session->se_target_maxslots =3D s;
> >>>    			} else {
> >>>    				kfree(slot);
> >>>    				slot =3D NULL;
> >>>    			}
> >>>    		} while (slot && --cnt > 0);
> >>>    	}
> >>> -	seq->maxslots =3D session->se_fchannel.maxreqs;
> >>> +	seq->maxslots =3D max(session->se_target_maxslots, seq->maxslots);
> >>> +	seq->target_maxslots =3D session->se_target_maxslots;
> >>>   =20
> >>>    out:
> >>>    	switch (clp->cl_cb_state) {
> >>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> >>> index 53fac037611c..4dcb03cd9292 100644
> >>> --- a/fs/nfsd/nfs4xdr.c
> >>> +++ b/fs/nfsd/nfs4xdr.c
> >>> @@ -1884,7 +1884,8 @@ nfsd4_decode_sequence(struct nfsd4_compoundargs *=
argp,
> >>>    		return nfserr_bad_xdr;
> >>>    	seq->seqid =3D be32_to_cpup(p++);
> >>>    	seq->slotid =3D be32_to_cpup(p++);
> >>> -	seq->maxslots =3D be32_to_cpup(p++);
> >>> +	/* sa_highest_slotid counts from 0 but maxslots  counts from 1 ... */
> >>> +	seq->maxslots =3D be32_to_cpup(p++) + 1;
> >>>    	seq->cachethis =3D be32_to_cpup(p);
> >>>   =20
> >>>    	seq->status_flags =3D 0;
> >>> @@ -4968,7 +4969,7 @@ nfsd4_encode_sequence(struct nfsd4_compoundres *r=
esp, __be32 nfserr,
> >>>    	if (nfserr !=3D nfs_ok)
> >>>    		return nfserr;
> >>>    	/* sr_target_highest_slotid */
> >>> -	nfserr =3D nfsd4_encode_slotid4(xdr, seq->maxslots - 1);
> >>> +	nfserr =3D nfsd4_encode_slotid4(xdr, seq->target_maxslots - 1);
> >>>    	if (nfserr !=3D nfs_ok)
> >>>    		return nfserr;
> >>>    	/* sr_status_flags */
> >>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> >>> index aad547d3ad8b..4251ff3c5ad1 100644
> >>> --- a/fs/nfsd/state.h
> >>> +++ b/fs/nfsd/state.h
> >>> @@ -245,10 +245,12 @@ struct nfsd4_slot {
> >>>    	struct svc_cred sl_cred;
> >>>    	u32	sl_datalen;
> >>>    	u16	sl_opcnt;
> >>> +	u16	sl_generation;
> >>>    #define NFSD4_SLOT_INUSE	(1 << 0)
> >>>    #define NFSD4_SLOT_CACHETHIS	(1 << 1)
> >>>    #define NFSD4_SLOT_INITIALIZED	(1 << 2)
> >>>    #define NFSD4_SLOT_CACHED	(1 << 3)
> >>> +#define NFSD4_SLOT_REUSED	(1 << 4)
> >>>    	u8	sl_flags;
> >>>    	char	sl_data[];
> >>>    };
> >>> @@ -321,7 +323,6 @@ struct nfsd4_session {
> >>>    	u32			se_cb_slot_avail; /* bitmap of available slots */
> >>>    	u32			se_cb_highest_slot;	/* highest slot client wants */
> >>>    	u32			se_cb_prog;
> >>> -	bool			se_dead;
> >>>    	struct list_head	se_hash;	/* hash by sessionid */
> >>>    	struct list_head	se_perclnt;
> >>>    	struct nfs4_client	*se_client;
> >>> @@ -331,6 +332,9 @@ struct nfsd4_session {
> >>>    	struct list_head	se_conns;
> >>>    	u32			se_cb_seq_nr[NFSD_BC_SLOT_TABLE_SIZE];
> >>>    	struct xarray		se_slots;	/* forward channel slots */
> >>> +	u16			se_slot_gen;
> >>> +	bool			se_dead;
> >>> +	u32			se_target_maxslots;
> >>>    };
> >>>   =20
> >>>    /* formatted contents of nfs4_sessionid */
> >>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
> >>> index 382cc1389396..c26ba86dbdfd 100644
> >>> --- a/fs/nfsd/xdr4.h
> >>> +++ b/fs/nfsd/xdr4.h
> >>> @@ -576,9 +576,7 @@ struct nfsd4_sequence {
> >>>    	u32			slotid;			/* request/response */
> >>>    	u32			maxslots;		/* request/response */
> >>>    	u32			cachethis;		/* request */
> >>> -#if 0
> >>>    	u32			target_maxslots;	/* response */
> >>> -#endif /* not yet */
> >>>    	u32			status_flags;		/* response */
> >>>    };
> >>>   =20
> >>
> >> Hi Neil -
> >>
> >> I've found some misbehavior which I've bisected to this commit.
> >=20
> > Hi Chuck,
> >   could you please confirm that it really was this commit that you
> >   bisected to?  Not the next one?
>=20
> It's this one. I included the hunk that introduces the misbehavior
> below. It's when the server starts returning a different value for
> target_highest_slotid in the SEQUENCE result. The target_highest
> is 63 -- the number the server has in its slot table. The maxslots
> value is smaller.
>=20
> In the working case, these two values never differ.
>=20
>=20
> >   Because this commit never reduces ->se_target_maxslots, so the
> >   patch which you say removed the symptom should be a no-op.
>=20
> It's not the reducing of target_highest that's the problem. Rather
> it's that the target_highest and max in-use slot IDs are different
> values for a brief period after a reconnect.
>=20
> That triggers the client to think that the server has reduced its
> slot table size, so the client shrinks its slot table. The server has
> not actually shrunken it, however, so it continues to expect the client
> to use the large slot sequence numbers for those slots.
>=20
> When the client starts to use one of those slots again, it uses a
> sequence number of 1, and that fails.
>=20
>=20
> >   Even if it was the next commit I'm struggling to pin down the
> >   problem.  Here is my current analysis - partly to ensure I can present
> >   it clearly.
> >=20
> >   The evidence suggests that the client has retired a slot that the
> >   server hasn't.  This happens when nfs41_set_server_slotid_locked()
> >   calls nfsd4_shrink_slot_table(), and nothing will happen if any slots
> >   before the new limit are still in use.  If the server reduces
> >   its idea of the target when the client isn't even using that many,
> >   the slots can be freed immediately that the client gets a reply
> >   indicating the new highest_slot number from the server.
> >=20
> >   The server will not free these slots immediately but will wait to get a
> >   confirmation from the client that it has accepted the new limit.  But,
> >   importantly, the server will not increase the limit that it sends to
> >   the client until after it has has a chance to free the retired slots.
> >   If the server doesn't increase the limit, then the client won't try to
> >   use the retired slots...
> >=20
> >   Do you still have the network trace which chows the error?  Would I be
> >   able to look at it?
>=20
> Sending via WeTransfer.

Thanks.  I see the problem clearly now.  It isn't so much that 'high
slot' and 'target' are different, it is that they are both wrong.
'highslot' (which is the max the server will accept) is typically 0 or
4, and 'target' is 63.

The 'highest slot' has been copied from what the client said was the max
currently in use.  I don't know where the 'target' came from, maybe from
the previous reply sent.

This bug was introduced in=20
   nfsd: allocate new session-based DRC slots on demand.
I should have move the seq->maxslots assignment after the "out:", not
before.

I'll send a patch.


>=20
> But also, it's easy enough to reproduce.
>=20
> Build your server with CONFIG_FAIL_SUNRPC set. Reboot into the new
> kernel.
>=20
> Before each test, run this script on the server:
>=20
> #!/usr/bin/bash
>=20
> cd /sys/kernel/debug/fail_sunrpc/
>=20
> echo Y > ignore-cache-wait
> echo Y > ignore-client-disconnect
> echo 24847 > interval
> echo 97 > times
> echo 100 > probability
>=20
> exit 0
>=20
> On the client, run fstests with an NFSv4.1 mount. It will usually hang
> within the first 15 tests.
>=20

I might give that a try - thanks.

NeilBrown

