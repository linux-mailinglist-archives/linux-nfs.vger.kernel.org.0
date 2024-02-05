Return-Path: <linux-nfs+bounces-1798-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB46884A777
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 22:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3531F2A855
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Feb 2024 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDF823BC;
	Mon,  5 Feb 2024 19:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WOr7N31U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bn/aymVO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WOr7N31U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bn/aymVO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598882D81
	for <linux-nfs@vger.kernel.org>; Mon,  5 Feb 2024 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162626; cv=none; b=Y1cAsiComtGniDarUi1zJ2Yi62V86kAvP3sxXul9tHPYth4hpSxIVP0+TloHZNlX8Y3OIJbDYG/xmILEuNbNO9BxicJb6CewtJEv6wqiQpoTXi25RnQnP4IXP7A49/SvUZlWlpfGILlmj2m09hRq9RZdEzss/K819t9LniN/UXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162626; c=relaxed/simple;
	bh=t2LP7dAU/lcXcpfQagpCVokAbAUZAfMPMC4osvLset8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=jqaW2m3dWd8pBgkcR6SjhlfVPXsH2otJ3953L9dlc+m68yD+7t6tbyXysCaCcgpnIKjp2yr2LrBQ3M8tVtE+newksyLAXuS68eClBL0NotzObUcau/QyJ8yBefSH8Nixkw9TjP0aruJwhuRGCSObD3MPmAGhQAKIfPscV6d3FiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WOr7N31U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bn/aymVO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WOr7N31U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bn/aymVO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A244A22042;
	Mon,  5 Feb 2024 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707162622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJR+O55nZuLpM/DEXQAa7pKhYjQvBItzOx0NxCuto98=;
	b=WOr7N31Uax9WodiAYdyH/f4goDLdM6bCwcAdhmcKzbDeTqj1TQBThaadLUXA36YKtkXXtG
	n8yreso1mvdezpAxBc2YToiGASAPzwBgt3KsRX9hx72mQBrGvhXrDCZ9VieBHSkQ3s4Sh9
	chD1rvz+BOsUbxINo2xAdBkij+CyRH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707162622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJR+O55nZuLpM/DEXQAa7pKhYjQvBItzOx0NxCuto98=;
	b=Bn/aymVOfadsSswYtxRxjHQyc4ErnIxm5fR50sHSghsPlFyZdxqpCtHXoeYz0Xb6T8rIK8
	sVEhgyfzDMw3LoCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707162622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJR+O55nZuLpM/DEXQAa7pKhYjQvBItzOx0NxCuto98=;
	b=WOr7N31Uax9WodiAYdyH/f4goDLdM6bCwcAdhmcKzbDeTqj1TQBThaadLUXA36YKtkXXtG
	n8yreso1mvdezpAxBc2YToiGASAPzwBgt3KsRX9hx72mQBrGvhXrDCZ9VieBHSkQ3s4Sh9
	chD1rvz+BOsUbxINo2xAdBkij+CyRH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707162622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJR+O55nZuLpM/DEXQAa7pKhYjQvBItzOx0NxCuto98=;
	b=Bn/aymVOfadsSswYtxRxjHQyc4ErnIxm5fR50sHSghsPlFyZdxqpCtHXoeYz0Xb6T8rIK8
	sVEhgyfzDMw3LoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 951FC136F5;
	Mon,  5 Feb 2024 19:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nU8gE/w7wWXUQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 05 Feb 2024 19:50:20 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Tom Talpey" <tom@talpey.com>,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: don't take fi_lock in nfsd_break_deleg_cb()
In-reply-to: <ZcD9tiK5FDcOH0P+@tissot.1015granger.net>
References: <170709975922.13976.3341850918979137018@noble.neil.brown.name>,
 <ZcD9tiK5FDcOH0P+@tissot.1015granger.net>
Date: Tue, 06 Feb 2024 06:50:17 +1100
Message-id: <170716261771.13976.14660106666976655215@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.996];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

On Tue, 06 Feb 2024, Chuck Lever wrote:
> On Mon, Feb 05, 2024 at 01:22:39PM +1100, NeilBrown wrote:
> >=20
> > A recent change to check_for_locks() changed it to take ->flc_lock while
> > holding ->fi_lock.  This creates a lock inversion (reported by lockdep)
> > because there is a case where ->fi_lock is taken while holding
> > ->flc_lock.
> >=20
> > ->flc_lock is held across ->fl_lmops callbacks, and
> > nfsd_break_deleg_cb() is one of those and does take ->fi_lock.  However
> > it doesn't need to.
> >=20
> > Prior to v4.17-rc1~110^2~22 ("nfsd: create a separate lease for each
> > delegation") nfsd_break_deleg_cb() would walk the ->fi_delegations list
> > and so needed the lock.  Since then it doesn't walk the list and doesn't
> > need the lock.
> >=20
> > Two actions are performed under the lock.  One is to call
> > nfsd_break_one_deleg which calls nfsd4_run_cb().  These doesn't act on
> > the nfs4_file at all, so don't need the lock.
> >=20
> > The other is to set ->fi_had_conflict which is in the nfs4_file.
> > This field is only ever set here (except when initialised to false)
> > so there is no possible problem will multiple threads racing when
> > setting it.
> >=20
> > The field is tested twice in nfs4_set_delegation().  The first test does
> > not hold a lock and is documented as an opportunistic optimisation, so
> > it doesn't impose any need to hold ->fi_lock while setting
> > ->fi_had_conflict.
> >=20
> > The second test in nfs4_set_delegation() *is* make under ->fi_lock, so
> > removing the locking when ->fi_had_conflict is set could make a change.
> > The change could only be interesting if ->fi_had_conflict tested as
> > false even though nfsd_break_one_deleg() ran before ->fi_lock was
> > unlocked.  i.e. while hash_delegation_locked() was running.
> > As hash_delegation_lock() doesn't interact in any way with nfs4_run_cb()
> > there can be no importance to this interaction.
> >=20
> > So this patch removes the locking from nfsd_break_one_deleg() and moves
> > the final test on ->fi_had_conflict out of the locked region to make it
> > clear that locking isn't important to the test.  It is still tested
> > *after* vfs_setlease() has succeeded.  This might be significant and as
> > vfs_setlease() takes ->flc_lock, and nfsd_break_one_deleg() is called
> > under ->flc_lock this "after" is a true ordering provided by a spinlock.
> >=20
> > Fixes: edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER")
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index 12534e12dbb3..8b112673d389 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5154,10 +5154,8 @@ nfsd_break_deleg_cb(struct file_lock *fl)
> >  	 */
> >  	fl->fl_break_time =3D 0;
> > =20
> > -	spin_lock(&fp->fi_lock);
> >  	fp->fi_had_conflict =3D true;
> >  	nfsd_break_one_deleg(dp);
> > -	spin_unlock(&fp->fi_lock);
> >  	return false;
> >  }
> > =20
> > @@ -5771,13 +5769,14 @@ nfs4_set_delegation(struct nfsd4_open *open, stru=
ct nfs4_ol_stateid *stp,
> >  	if (status)
> >  		goto out_unlock;
> > =20
> > +	status =3D -EAGAIN;
> > +	if (fp->fi_had_conflict)
> > +		goto out_unlock;
> > +
> >  	spin_lock(&state_lock);
> >  	spin_lock(&clp->cl_lock);
> >  	spin_lock(&fp->fi_lock);
> > -	if (fp->fi_had_conflict)
> > -		status =3D -EAGAIN;
> > -	else
> > -		status =3D hash_delegation_locked(dp, fp);
> > +	status =3D hash_delegation_locked(dp, fp);
> >  	spin_unlock(&fp->fi_lock);
> >  	spin_unlock(&clp->cl_lock);
> >  	spin_unlock(&state_lock);
> > --=20
> > 2.43.0
>=20
> Thanks for jumping on this issue.
>=20
> This version of the fix does not apply to nfsd-fixes since the
> ADMIN_REVOKED changes in nfsd-next also touch this part of
> nfs4_set_delegation().
>=20
> Because edcf9725150e ("nfsd: fix RELEASE_LOCKOWNER") is now applied
> in v6.8-rc3, v6.7.y, v6.6.y, and probably v6.1.y, I've reworked this
> fix slightly to apply on nfsd-fixes and have started a round of
> testing there.

Thanks.
I see the conflict comes from the addition of ->cl_lock in=20

    nfsd: hold ->cl_lock for hash_delegation_locked()

I guess that could go to -stable, but maybe not needed.

NeilBrown

