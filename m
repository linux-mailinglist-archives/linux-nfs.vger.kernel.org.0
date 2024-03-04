Return-Path: <linux-nfs+bounces-2150-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B717486F7F3
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 01:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264AD1F2119A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 00:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3267119A;
	Mon,  4 Mar 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="keAsWpSt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XxhjqwyB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="keAsWpSt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XxhjqwyB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372AD10F2
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709510967; cv=none; b=VMwTRajsVGLTYzsovzJJDA3ChXpTEA5QePQyGnNC5LFKTQJC7Z4NnUI2ZPHC7PNXfp18xyBDLYkkMqS61GO5+UdzugHNmweyvSw9mLzSNNmLJjY9NVKOWEL66Op8/z5NLjjbsuW5+gT3kOCe988gIngtR2UsC/rDfg+BGgsmVjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709510967; c=relaxed/simple;
	bh=JmFwk5OWNAybNnk8tM1c7poNjdftIL2FNXcAqbtWWEc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Nfu1eUICTvYf8kQaFuBmpfUcZ62nGfHyD7R6wkDTBW7x4RdPfGXH7r3VuB4RAh6OoCisth/L65Piwv5bQfruBEp+0EPBeyr+a7xaXhKuxyeG93tAzzAzwfeXG+krvpZ55VBzOHKqG4XhxZfaBKq/TfKxuQVRK7dRYXeq4lWNmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=keAsWpSt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XxhjqwyB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=keAsWpSt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XxhjqwyB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7215F4D228;
	Mon,  4 Mar 2024 00:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709510963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9cY9iaDa6uDNG5S02lzFNE4GQYO8VPBUWEgJApkreU=;
	b=keAsWpStETdKsavqzmsPmtOKSpsv1mTLKomfDDQuOaS1njd5zsHEBF2yv7uIiry1H+OPvt
	ZlA1jBPzQYtd3mE761MBdF2LGh57I5BVzhlCcFwmY50g+UTZVHxjDM2GNEvl0nitWhUt3U
	v5M0XVDlKOTAHvqghNhg0PakXkcyJ4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709510963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9cY9iaDa6uDNG5S02lzFNE4GQYO8VPBUWEgJApkreU=;
	b=XxhjqwyBebFEvr0Ogpggr+GHXwQo5zyxeHAl5B7dFEWa2v32k42+tyaNwwKPy32vq74Fyb
	tFMAlGS21Xx9VEBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709510963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9cY9iaDa6uDNG5S02lzFNE4GQYO8VPBUWEgJApkreU=;
	b=keAsWpStETdKsavqzmsPmtOKSpsv1mTLKomfDDQuOaS1njd5zsHEBF2yv7uIiry1H+OPvt
	ZlA1jBPzQYtd3mE761MBdF2LGh57I5BVzhlCcFwmY50g+UTZVHxjDM2GNEvl0nitWhUt3U
	v5M0XVDlKOTAHvqghNhg0PakXkcyJ4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709510963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l9cY9iaDa6uDNG5S02lzFNE4GQYO8VPBUWEgJApkreU=;
	b=XxhjqwyBebFEvr0Ogpggr+GHXwQo5zyxeHAl5B7dFEWa2v32k42+tyaNwwKPy32vq74Fyb
	tFMAlGS21Xx9VEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF75813A9F;
	Mon,  4 Mar 2024 00:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hKVTHDAR5WV0eAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 00:09:20 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Chuck Lever" <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 2/3] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
In-reply-to: <0554a33c0f3e15c24dc6dbe41287febac394dec0.camel@kernel.org>
References: <20240301000950.2306-1-neilb@suse.de>,
 <20240301000950.2306-3-neilb@suse.de>,
 <0554a33c0f3e15c24dc6dbe41287febac394dec0.camel@kernel.org>
Date: Mon, 04 Mar 2024 11:09:17 +1100
Message-id: <170951095708.24797.14749102448540249432@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.28
X-Spamd-Result: default: False [-1.28 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.82)[0.940];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Sat, 02 Mar 2024, Jeff Layton wrote:
> On Fri, 2024-03-01 at 11:07 +1100, NeilBrown wrote:
> > move_to_close_lru() waits for sc_count to become zero while holding
> > rp_mutex.  This can deadlock if another thread holds a reference and is
> > waiting for rp_mutex.
> >=20
> > By the time we get to move_to_close_lru() the openowner is unhashed and
> > cannot be found any more.  So code waiting for the mutex can safely
> > retry the lookup if move_to_close_lru() has started.
> >=20
> > So change rp_mutex to an atomic_t with three states:
> >=20
> >  RP_UNLOCK   - state is still hashed, not locked for reply
> >  RP_LOCKED   - state is still hashed, is locked for reply
> >  RP_UNHASHED - state is now hashed, no code can get a lock.
> >=20
>=20
> "is now unhashed", I think...

 or "state is not hashed".  s/now/not/.

>=20
> > Use wait_ver_event() to wait for either a lock, or for the owner to be
> > unhashed.  In the latter case, retry the lookup.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 46 ++++++++++++++++++++++++++++++++++++---------
> >  fs/nfsd/state.h     |  2 +-
> >  2 files changed, 38 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index e625f738f7b0..5dab316932d3 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4442,21 +4442,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> >  }
> > =20
> > +enum rp_lock {
> > +	RP_UNLOCKED,
> > +	RP_LOCKED,
> > +	RP_UNHASHED,
> > +};
> > +
> >  static void init_nfs4_replay(struct nfs4_replay *rp)
> >  {
> >  	rp->rp_status =3D nfserr_serverfault;
> >  	rp->rp_buflen =3D 0;
> >  	rp->rp_buf =3D rp->rp_ibuf;
> > -	mutex_init(&rp->rp_mutex);
> > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> >  }
> > =20
> > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *csta=
te,
> > -		struct nfs4_stateowner *so)
> > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *cstat=
e,
> > +				      struct nfs4_stateowner *so)
> >  {
> >  	if (!nfsd4_has_session(cstate)) {
> > -		mutex_lock(&so->so_replay.rp_mutex);
> > +		wait_var_event(&so->so_replay.rp_locked,
> > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > +					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> > +		if (atomic_read(&so->so_replay.rp_locked) =3D=3D RP_UNHASHED)
> > +			return -EAGAIN;
> >  		cstate->replay_owner =3D nfs4_get_stateowner(so);
> >  	}
> > +	return 0;
> >  }
> > =20
> >  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> > @@ -4465,7 +4476,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compoun=
d_state *cstate)
> > =20
> >  	if (so !=3D NULL) {
> >  		cstate->replay_owner =3D NULL;
> > -		mutex_unlock(&so->so_replay.rp_mutex);
> > +		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> > +		wake_up_var(&so->so_replay.rp_locked);
> >  		nfs4_put_stateowner(so);
> >  	}
> >  }
> > @@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, struc=
t net *net)
> >  	 * Wait for the refcount to drop to 2. Since it has been unhashed,
> >  	 * there should be no danger of the refcount going back up again at
> >  	 * this point.
> > +	 * Some threads with a reference might be waiting for rp_locked,
> > +	 * so tell them to stop waiting.
> >  	 */
> > +	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> > +	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
> >  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) =3D=3D 2);
> > =20
> >  	release_all_access(s);
> > @@ -5064,6 +5080,7 @@ nfsd4_process_open1(struct nfsd4_compound_state *cs=
tate,
> >  	clp =3D cstate->clp;
> > =20
> >  	strhashval =3D ownerstr_hashval(&open->op_owner);
> > +retry:
> >  	oo =3D find_openstateowner_str(strhashval, open, clp);
> >  	open->op_openowner =3D oo;
> >  	if (!oo)
> > @@ -5074,17 +5091,24 @@ nfsd4_process_open1(struct nfsd4_compound_state *=
cstate,
> >  		open->op_openowner =3D NULL;
> >  		goto new_owner;
> >  	}
> > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) =3D=3D -EAGAIN) {
> > +		nfs4_put_stateowner(&oo->oo_owner);
> > +		goto retry;
> > +	}
> >  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
> >  	if (status)
> >  		return status;
> >  	goto alloc_stateid;
> >  new_owner:
> >  	oo =3D alloc_init_open_stateowner(strhashval, open, cstate);
> > +	open->op_openowner =3D oo;
> >  	if (oo =3D=3D NULL)
> >  		return nfserr_jukebox;
> > -	open->op_openowner =3D oo;
> > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) =3D=3D -EAGAIN) {
> > +		WARN_ON(1);
>=20
> I don't think you want to WARN here. It seems quite possible for the
> client to send simultaneous opens for different files with the same
> stateowner.

Thanks.  alloc_init_open_stateowner() might not return a newly allocated
state owner, as it include the test "does it already exist" and also
adds it to the hash.  Not what I would expect based on the name.  Maybe
I'll clean up the code.

>=20
>=20
>=20
> > +		nfs4_put_stateowner(&oo->oo_owner);
> > +		goto new_owner;
>=20
> Is "goto new_owner" correct here? We likely raced with another RPC that
> was using the same owner, so ours probably got inserted and the other
> nfsd thread raced in and got the lock before we could. Retrying the
> lookup seems more correct in this situation?
>=20
> That said, it might be best to just call nfsd4_cstate_assign_replay
> before hashing the new owner. If you lose the insertion race at that
> point, you can just clear it and try to assign the one that won.

I did consider that approach but wasn't sure it was worth it.  I'll have
another look.

Thanks for the review.

NeilBrown


>=20
> > +	}
> >  alloc_stateid:
> >  	open->op_stp =3D nfs4_alloc_open_stateid(clp);
> >  	if (!open->op_stp)
> > @@ -6841,11 +6865,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_st=
ate *cstate, u32 seqid,
> >  	trace_nfsd_preprocess(seqid, stateid);
> > =20
> >  	*stpp =3D NULL;
> > +retry:
> >  	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> >  	if (status)
> >  		return status;
> >  	stp =3D openlockstateid(s);
> > -	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> > +	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) =3D=3D -EAGA=
IN) {
> > +		nfs4_put_stateowner(stp->st_stateowner);
> > +		goto retry;
> > +	}
> > =20
> >  	status =3D nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
> >  	if (!status)
> > diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
> > index 41bdc913fa71..6a3becd86112 100644
> > --- a/fs/nfsd/state.h
> > +++ b/fs/nfsd/state.h
> > @@ -446,7 +446,7 @@ struct nfs4_replay {
> >  	unsigned int		rp_buflen;
> >  	char			*rp_buf;
> >  	struct knfsd_fh		rp_openfh;
> > -	struct mutex		rp_mutex;
> > +	atomic_t		rp_locked;
> >  	char			rp_ibuf[NFSD4_REPLAY_ISIZE];
> >  };
> > =20
>=20
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20
>=20


