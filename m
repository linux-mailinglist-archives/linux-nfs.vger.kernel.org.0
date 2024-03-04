Return-Path: <linux-nfs+bounces-2188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A280387102A
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA2D1F22039
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 22:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FD8F44;
	Mon,  4 Mar 2024 22:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DgQV/E8u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gc90hWHs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DgQV/E8u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gc90hWHs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B73FB07
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 22:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591803; cv=none; b=R1lnSQ37SBCOhK+oGip6JdWtjFtxNtwlot03gQmiSIeoV7Tu9OJDc6PlDCfAj1IUJXgVW1wjoSh3eSaYbbSqJNMXzjwIcl507ugRXVKNTknh4snfV2lMnL2oZK79MMIj8Vql1NoGq/AF/dVuVa6ZsPMIazUHLYs+u8W08j9k3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591803; c=relaxed/simple;
	bh=SHjUE3pl0hpgA9mG2CxiBaQJBis6JIxkUUOIcTSTiVQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ivfvRGdeR8B+EnC1squlkNS38ftSZP8mX+YFiJGrC3itiDLfaRl/bL2C3+HGxvmhjtJX1E8KAu6m1Y7qn7OAbMc+MBiPaa6O95TjySHGA+BnyR2CBbCRiEc2PoNDSL2WPX3d5hj5zKyPjViH2JatI9XraQXiDe6Q57/X5wW4t10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DgQV/E8u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gc90hWHs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DgQV/E8u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gc90hWHs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BCD634ECA;
	Mon,  4 Mar 2024 22:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709591800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufN0HBBZoddJoCs99Vk88c7hCwj7eKr9KL047X63no=;
	b=DgQV/E8uBYYOoWKTNxFFtAqdVbZpLgV+JyeoNJqMM+iAW1q/AQkxBuRIIRYxQiRns1kiIn
	NYjwD7tgLXFBesJEKZUFs5P7b3CGnroCwRGHbCO9BKGjLLTPXLW9hKI9qVWcKKGyZjjrn5
	Mkq0oQlvzRTvGPPdN9RI3Pbc5QU3g58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709591800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufN0HBBZoddJoCs99Vk88c7hCwj7eKr9KL047X63no=;
	b=gc90hWHs/VWZhnEJX+Zn/UfvZeK+GkfSDjrjZJ3XgjfXusdpcQgscLZ63mVe52I9FMKRUM
	mFMnX77opvESm+Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709591800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufN0HBBZoddJoCs99Vk88c7hCwj7eKr9KL047X63no=;
	b=DgQV/E8uBYYOoWKTNxFFtAqdVbZpLgV+JyeoNJqMM+iAW1q/AQkxBuRIIRYxQiRns1kiIn
	NYjwD7tgLXFBesJEKZUFs5P7b3CGnroCwRGHbCO9BKGjLLTPXLW9hKI9qVWcKKGyZjjrn5
	Mkq0oQlvzRTvGPPdN9RI3Pbc5QU3g58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709591800;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bufN0HBBZoddJoCs99Vk88c7hCwj7eKr9KL047X63no=;
	b=gc90hWHs/VWZhnEJX+Zn/UfvZeK+GkfSDjrjZJ3XgjfXusdpcQgscLZ63mVe52I9FMKRUM
	mFMnX77opvESm+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 74AD913A5B;
	Mon,  4 Mar 2024 22:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YzkZBfVM5mV+XwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 22:36:37 +0000
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
In-reply-to: <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>,
 <20240304044304.3657-4-neilb@suse.de>,
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>,
 <170958874536.24797.2684794071853900422@noble.neil.brown.name>,
 <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>
Date: Tue, 05 Mar 2024 09:36:29 +1100
Message-id: <170959178935.24797.7531672348129457687@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.10

On Tue, 05 Mar 2024, Chuck Lever wrote:
> On Tue, Mar 05, 2024 at 08:45:45AM +1100, NeilBrown wrote:
> > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> > > > move_to_close_lru() waits for sc_count to become zero while holding
> > > > rp_mutex.  This can deadlock if another thread holds a reference and =
is
> > > > waiting for rp_mutex.
> > > >=20
> > > > By the time we get to move_to_close_lru() the openowner is unhashed a=
nd
> > > > cannot be found any more.  So code waiting for the mutex can safely
> > > > retry the lookup if move_to_close_lru() has started.
> > > >=20
> > > > So change rp_mutex to an atomic_t with three states:
> > > >=20
> > > >  RP_UNLOCK   - state is still hashed, not locked for reply
> > > >  RP_LOCKED   - state is still hashed, is locked for reply
> > > >  RP_UNHASHED - state is not hashed, no code can get a lock.
> > > >=20
> > > > Use wait_var_event() to wait for either a lock, or for the owner to be
> > > > unhashed.  In the latter case, retry the lookup.
> > > >=20
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > ---
> > > >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
> > > >  fs/nfsd/state.h     |  2 +-
> > > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > > >=20
> > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > index 690d0e697320..47e879d5d68a 100644
> > > > --- a/fs/nfsd/nfs4state.c
> > > > +++ b/fs/nfsd/nfs4state.c
> > > > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> > > >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> > > >  }
> > > > =20
> > > > +enum rp_lock {
> > > > +	RP_UNLOCKED,
> > > > +	RP_LOCKED,
> > > > +	RP_UNHASHED,
> > > > +};
> > > > +
> > > >  static void init_nfs4_replay(struct nfs4_replay *rp)
> > > >  {
> > > >  	rp->rp_status =3D nfserr_serverfault;
> > > >  	rp->rp_buflen =3D 0;
> > > >  	rp->rp_buf =3D rp->rp_ibuf;
> > > > -	mutex_init(&rp->rp_mutex);
> > > > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > > >  }
> > > > =20
> > > > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_state *=
cstate,
> > > > -		struct nfs4_stateowner *so)
> > > > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_state *c=
state,
> > > > +				      struct nfs4_stateowner *so)
> > > >  {
> > > >  	if (!nfsd4_has_session(cstate)) {
> > > > -		mutex_lock(&so->so_replay.rp_mutex);
> > > > +		wait_var_event(&so->so_replay.rp_locked,
> > > > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > > > +					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> > >=20
> > > What reliably prevents this from being a "wait forever" ?
> >=20
> > That same thing that reliably prevented the original mutex_lock from
> > waiting forever.
> > It waits until rp_locked is set to RP_UNLOCKED, which is precisely when
> > we previously called mutex_unlock.  But it *also* aborts the wait if
> > rp_locked is set to RP_UNHASHED - so it is now more reliable.
> >=20
> > Does that answer the question?
>=20
> Hm. I guess then we are no worse off with wait_var_event().
>=20
> I'm not as familiar with this logic as perhaps I should be. How long
> does it take for the wake-up to occur, typically?

wait_var_event() is paired with wake_up_var().
The wake up happens when wake_up_var() is called, which in this code is
always immediately after atomic_set() updates the variable.

>=20
>=20
> > > > +		if (atomic_read(&so->so_replay.rp_locked) =3D=3D RP_UNHASHED)
> > > > +			return -EAGAIN;
> > > >  		cstate->replay_owner =3D nfs4_get_stateowner(so);
> > > >  	}
> > > > +	return 0;
> > > >  }
> > > > =20
> > > >  void nfsd4_cstate_clear_replay(struct nfsd4_compound_state *cstate)
> > > > @@ -4453,7 +4464,8 @@ void nfsd4_cstate_clear_replay(struct nfsd4_com=
pound_state *cstate)
> > > > =20
> > > >  	if (so !=3D NULL) {
> > > >  		cstate->replay_owner =3D NULL;
> > > > -		mutex_unlock(&so->so_replay.rp_mutex);
> > > > +		atomic_set(&so->so_replay.rp_locked, RP_UNLOCKED);
> > > > +		wake_up_var(&so->so_replay.rp_locked);
> > > >  		nfs4_put_stateowner(so);
> > > >  	}
> > > >  }
> > > > @@ -4691,7 +4703,11 @@ move_to_close_lru(struct nfs4_ol_stateid *s, s=
truct net *net)
> > > >  	 * Wait for the refcount to drop to 2. Since it has been unhashed,
> > > >  	 * there should be no danger of the refcount going back up again at
> > > >  	 * this point.
> > > > +	 * Some threads with a reference might be waiting for rp_locked,
> > > > +	 * so tell them to stop waiting.
> > > >  	 */
> > > > +	atomic_set(&oo->oo_owner.so_replay.rp_locked, RP_UNHASHED);
> > > > +	wake_up_var(&oo->oo_owner.so_replay.rp_locked);
> > > >  	wait_event(close_wq, refcount_read(&s->st_stid.sc_count) =3D=3D 2);
> > > > =20
> > > >  	release_all_access(s);
> > > > @@ -5064,11 +5080,15 @@ nfsd4_process_open1(struct nfsd4_compound_sta=
te *cstate,
> > > >  	clp =3D cstate->clp;
> > > > =20
> > > >  	strhashval =3D ownerstr_hashval(&open->op_owner);
> > > > +retry:
> > > >  	oo =3D find_or_alloc_open_stateowner(strhashval, open, cstate);
> > > >  	open->op_openowner =3D oo;
> > > >  	if (!oo)
> > > >  		return nfserr_jukebox;
> > > > -	nfsd4_cstate_assign_replay(cstate, &oo->oo_owner);
> > > > +	if (nfsd4_cstate_assign_replay(cstate, &oo->oo_owner) =3D=3D -EAGAI=
N) {
> > > > +		nfs4_put_stateowner(&oo->oo_owner);
> > > > +		goto retry;
> > > > +	}
> > > >  	status =3D nfsd4_check_seqid(cstate, &oo->oo_owner, open->op_seqid);
> > > >  	if (status)
> > > >  		return status;
> > > > @@ -6828,11 +6848,15 @@ nfs4_preprocess_seqid_op(struct nfsd4_compoun=
d_state *cstate, u32 seqid,
> > > >  	trace_nfsd_preprocess(seqid, stateid);
> > > > =20
> > > >  	*stpp =3D NULL;
> > > > +retry:
> > > >  	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
> > > >  	if (status)
> > > >  		return status;
> > > >  	stp =3D openlockstateid(s);
> > > > -	nfsd4_cstate_assign_replay(cstate, stp->st_stateowner);
> > > > +	if (nfsd4_cstate_assign_replay(cstate, stp->st_stateowner) =3D=3D -=
EAGAIN) {
> > > > +		nfs4_put_stateowner(stp->st_stateowner);
> > > > +		goto retry;
> > > > +	}
> > > > =20
> > > >  	status =3D nfs4_seqid_op_checks(cstate, stateid, seqid, stp);
> > > >  	if (!status)
> > >=20
> > > My tool chain reports that this hunk won't apply to nfsd-next.
> >=20
> > You need better tools :-)
>=20
> <shrug> Essentially it is git, importing an mbox. That kind of thing
> is generally the weakest aspect of all these tools.  Do you know of
> something more robust?

My tool of choice is "wiggle" - which I wrote.
I just put those 4 patches into an mbox and use "git am < mbox" to apply
to nfsd-next.  It hit a problem at this patch - 3/4.
So I ran
   wiggle -mrp .git/rebase-apply/patch

which worked without complaint.  (you might want --no-backup too).
But you probably want to know that the conflict was that "git am" found
and "wiggle" ignored.  So:

  git diff | diff -u -I '^@@' -I '^index' .git/rebase-apply/patch -=20

This shows=20

 +retry:
- 	status =3D nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
+ 	status =3D nfsd4_lookup_stateid(cstate, stateid,
+ 				      typemask, statusmask, &s, nn);


once you have had a bit of practice reading diffs of diffs you can see
that the patch inserts "retry:" before a line which has changed
between the original and new bases.  The difference clearly isn't
important to this patch.

So "git add -u; git am --continue" will accept the wiggle and continue
with the "git am".
Patch 4/4 has one conflict:
        struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
 +      bool need_move_to_close_list;
 =20
-       dprintk("NFSD: nfsd4_close on file %pd\n",=20
+       dprintk("NFSD: nfsd4_close on file %pd\n",
                        cstate->current_fh.fh_dentry);

again - not interesting (white space at end of line changed).

But maybe you would rather avoid that and have submitted base their
patches properly to start with :-)

>=20
>=20
> > > In my copy of fs/nfsd/nfs4state.c, nfs4_preprocess_seqid_op() starts
> > > at line 7180, so something is whack-a-doodle.
> >=20
> > I have been working against master because the old version of the fix
> > was in nfsd-next.  I should have rebased when you removed it from
> > nfsd-next.  I have now and will repost once you confirm you are
> > comfortable with the answer about waiting above.  Would adding a comment
> > there help?
>=20
> The mechanism is clear from the code, so a new comment, if you add
> one, should spell out what condition(s) mark rp_locked as UNLOCKED.
>=20
> But I might be missing something that should be obvious, in which
> case no comment is necessary.
>=20

I've added a comment emphasising that it is much like a mutex, and
pointing to the matching unlocks.

Thanks,
NeilBrown


