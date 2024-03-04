Return-Path: <linux-nfs+bounces-2185-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD54870EAE
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6336A1C23DDB
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 21:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EED1C6AB;
	Mon,  4 Mar 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hoYR78pA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2zP8MCCE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3BvhE1N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GEZNIdwn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38F746BA0
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709588755; cv=none; b=BgTdNBRGI4kIYsDls6Lt4ANQ9nz5WzQMZuKEw5qzIkWA7+6BPT1b0/ahvmQ9MBtNokgonO/Xku531e5l1UWJoRepmITKVwXZ2ER85mYPQaHTPxUTSD3Ky6vaQK3zvIEBgl7NApP+UATqJo0hJ744D00tnKHFcNW/EBrufZBarGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709588755; c=relaxed/simple;
	bh=I2ciVYrGYBMuDrasa2Ymt9LwFkIxbrWoAbLKsi8S8Ls=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=d2qhotOurMSmtAamNqzaBQy4lxHZbDDHr+euxtwBCcNhANRqFaCIxfjjwUuz97g5U3N2LNVCmM+/fJ4HdY09RLCcS+A3tb342HPtB4sK8qnUZo8NVWd3yES2kUF2PKleme4qYLBfDiyWLgBiespxdhZ+8D5gKdluLULrqNWmxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hoYR78pA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2zP8MCCE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3BvhE1N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GEZNIdwn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DC3FD34968;
	Mon,  4 Mar 2024 21:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709588752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ocA9s0uMPK0r07kaxDZ53gJeA1jYUdjxcrljbDEDYE=;
	b=hoYR78pA2fE28aqwGWaZyoc6FBQoON1vQWZyGKRdaDfFoErmA3x+k6+im27GxzLHniir4W
	u8iBqALxpxl2mOFmmA4oiL9otkch5kbCU4vqvZcSokZZYSTls+64WFFm9CqG92NO9+1DhO
	zsGP6+emJPKi7gn0nkBamigYaZtPsgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709588752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ocA9s0uMPK0r07kaxDZ53gJeA1jYUdjxcrljbDEDYE=;
	b=2zP8MCCEy1iBKXdO02Tp43ouq5BQ3mUQI3CeXR3XVOmDZKnNrM+SlPeg3D5tLpYCwWFgJd
	2PZf5qhesDhPLWAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709588751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ocA9s0uMPK0r07kaxDZ53gJeA1jYUdjxcrljbDEDYE=;
	b=t3BvhE1NMhHqgIZ1fNkXzJA55RO+IeG7PhM7sz8leSAArvY1qWDKpMFip2hKoFuQUKWnlE
	7CHo11OI/r8O7shkqVh0ZMayhPdaMX//a5fAds7dFfIii00NjlenW0Ns1VoSAJ13ruX99H
	LF8R/MZZ1eTZ+MPXihkkv7eDJIsnf+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709588751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ocA9s0uMPK0r07kaxDZ53gJeA1jYUdjxcrljbDEDYE=;
	b=GEZNIdwnR5PWpA+YTuiQDz0DGETJI1TrHRH4rur0CeYtXAZkQ2lx9cgJk+EyVxUyCEjwLH
	vrZEoVRhDaFEgiAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4447913A58;
	Mon,  4 Mar 2024 21:45:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TgYdNgxB5mXiUgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 21:45:48 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 3/4] nfsd: replace rp_mutex to avoid deadlock in
 move_to_close_lru()
In-reply-to: <ZeXWGJqreYH8aayB@klimt.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>,
 <20240304044304.3657-4-neilb@suse.de>,
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>
Date: Tue, 05 Mar 2024 08:45:45 +1100
Message-id: <170958874536.24797.2684794071853900422@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=t3BvhE1N;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GEZNIdwn
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -6.51
X-Rspamd-Queue-Id: DC3FD34968
X-Spam-Flag: NO

On Tue, 05 Mar 2024, Chuck Lever wrote:
> On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
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
> >  RP_UNHASHED - state is not hashed, no code can get a lock.
> >=20
> > Use wait_var_event() to wait for either a lock, or for the owner to be
> > unhashed.  In the latter case, retry the lookup.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
> >  fs/nfsd/state.h     |  2 +-
> >  2 files changed, 32 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 690d0e697320..47e879d5d68a 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
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
>=20
> What reliably prevents this from being a "wait forever" ?

That same thing that reliably prevented the original mutex_lock from
waiting forever.
It waits until rp_locked is set to RP_UNLOCKED, which is precisely when
we previously called mutex_unlock.  But it *also* aborts the wait if
rp_locked is set to RP_UNHASHED - so it is now more reliable.

Does that answer the question?

>=20
>=20
> > +		if (atomic_read(&so->so_replay.rp_locked) =3D=3D RP_UNHASHED)
> > +			return -EAGAIN;
> >  		cstate->replay_owner =3D nfs4_get_stateowner(so);
> >  	}
> > +	return 0;
> >  }
> > =20
> >  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> > @@ -4453,7 +4464,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_compoun=
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
> > @@ -5064,11 +5080,15 @@ nfsd4_process_open1(struct nfsd4_compound_state *=
cstate,
> >  	clp =3D cstate->clp;
> > =20
> >  	strhashval =3D ownerstr_hashval(&open->op_owner);
> > +retry:
> >  	oo =3D find_or_alloc_open_stateowner(strhashval, open, cstate);
> >  	open->op_openowner =3D oo;
> >  	if (!oo)
> >  		return nfserr_jukebox;
> > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) =3D=3D -EAGAIN) {
> > +		nfs4_put_stateowner(&oo->oo_owner);
> > +		goto retry;
> > +	}
> >  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
> >  	if (status)
> >  		return status;
> > @@ -6828,11 +6848,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_st=
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
>=20
> My tool chain reports that this hunk won't apply to nfsd-next.

You need better tools :-)

>=20
> In my copy of fs/nfsd/nfs4state.c, nfs4_preprocess_seqid_op() starts
> at line 7180, so something is whack-a-doodle.

I have been working against master because the old version of the fix
was in nfsd-next.  I should have rebased when you removed it from
nfsd-next.  I have now and will repost once you confirm you are
comfortable with the answer about waiting above.  Would adding a comment
there help?

Thanks,
NeilBrown


>=20
>=20
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
> > --=20
> > 2.43.0
> >=20
>=20
> --=20
> Chuck Lever
>=20


