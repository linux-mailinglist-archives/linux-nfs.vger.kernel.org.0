Return-Path: <linux-nfs+bounces-7103-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C289F99ADC5
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 22:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E531C1C225F7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED531CC162;
	Fri, 11 Oct 2024 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IuxCROuK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NRveVY7B";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IuxCROuK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NRveVY7B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC50199231
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728680029; cv=none; b=cCUFFIdt/SoOldQwO7VHFN9zCrs2vtC7n2Bz6NwjI/MTCnGcEKuGNEGXlhNLsKFmCB+C29C1npElUg9rlZtDoAfhA4B8w8cPfWbd1P7oUy+zHWTru7nzlrmgIcn+T6qaTvs2jYjXPLEHfC4ITfqO/HUlxhYQrynrnQjoAJZ59p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728680029; c=relaxed/simple;
	bh=NoYEfmTD4phn0/IehKrG3Y2ICDZo90kIccp3DcR6Bf0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JXqUQSSvF5khe76/EduM5bp7b58SNlZaJQHE0OsdOr0/fMWWMS4ImU65pGhyE4vhLNuSIqfhOuGUySSfg27Tpy4plyMpU2lKd/mcvti/NynrTw1nbtsCLPw2NraRuU9GhASAj1Tv3kHVRcoTkSLgkXAUEGliucQSXqiYRflLqV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IuxCROuK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NRveVY7B; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IuxCROuK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NRveVY7B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9220F21941;
	Fri, 11 Oct 2024 20:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728680025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be2DRoTi+EafOf5v2RMfTTTCoM+cZto2gec82nKTI1s=;
	b=IuxCROuKg4jrMFm5QYSTVJrZsPf4L3a7sbYOYz8oRfb9Lbf2dhubzPhY/SNP0ClnxZhQ57
	CoWSGcNJZvlT0iif2H4j2/QinewdH+HRi7KIt3PzhdzG0ibnaQmyrg2CmNBBfcl/BBNIta
	b47o472N5kjzVgCNipP+SUDnS+e5SE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728680025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be2DRoTi+EafOf5v2RMfTTTCoM+cZto2gec82nKTI1s=;
	b=NRveVY7B50vu/SOKp1WOSe6IkiWmMmZoay5xPbaysknNUknJBkNFJ5YXAmuaO0Whc7Ix27
	PfIEufNY2aZyo1BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728680025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be2DRoTi+EafOf5v2RMfTTTCoM+cZto2gec82nKTI1s=;
	b=IuxCROuKg4jrMFm5QYSTVJrZsPf4L3a7sbYOYz8oRfb9Lbf2dhubzPhY/SNP0ClnxZhQ57
	CoWSGcNJZvlT0iif2H4j2/QinewdH+HRi7KIt3PzhdzG0ibnaQmyrg2CmNBBfcl/BBNIta
	b47o472N5kjzVgCNipP+SUDnS+e5SE8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728680025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=be2DRoTi+EafOf5v2RMfTTTCoM+cZto2gec82nKTI1s=;
	b=NRveVY7B50vu/SOKp1WOSe6IkiWmMmZoay5xPbaysknNUknJBkNFJ5YXAmuaO0Whc7Ix27
	PfIEufNY2aZyo1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D87E136E0;
	Fri, 11 Oct 2024 20:53:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rmrhNFaQCWeBBAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 11 Oct 2024 20:53:42 +0000
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
Cc: cel@kernel.org, "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH] NFSD: Replace use of NFSD_MAY_LOCK in nfsd4_lock()
In-reply-to: <Zwkx54LAxJuuxTWv@tissot.1015granger.net>
References: <>, <Zwkx54LAxJuuxTWv@tissot.1015granger.net>
Date: Sat, 12 Oct 2024 07:53:34 +1100
Message-id: <172868001492.34603.7415839336713873165@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat, 12 Oct 2024, Chuck Lever wrote:
> On Fri, Oct 11, 2024 at 07:54:12AM +1100, NeilBrown wrote:
> > On Fri, 11 Oct 2024, cel@kernel.org wrote:
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >=20
> > > NFSv4 LOCK operations should not avoid the set of authorization
> > > checks that apply to all other NFSv4 operations. Also, the
> > > "no_auth_nlm" export option should apply only to NLM LOCK requests.
> > > It's not necessary or sensible to apply it to NFSv4 LOCK operations.
> > >=20
> > > The replacement MAY bit mask,
> > > "NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE", comes from the access
> > > bits that are set in nfsd_permission() when the caller has set
> > > NFSD_MAY_LOCK.
> > >=20
> > > Reported-by: NeilBrown <neilb@suse.de>
> > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > ---
> > >  fs/nfsd/nfs4state.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > index 9c2b1d251ab3..3f2c11414390 100644
> > > --- a/fs/nfsd/nfs4state.c
> > > +++ b/fs/nfsd/nfs4state.c
> > > @@ -7967,11 +7967,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4=
_compound_state *cstate,
> > >  	if (check_lock_length(lock->lk_offset, lock->lk_length))
> > >  		 return nfserr_inval;
> > > =20
> > > -	if ((status =3D fh_verify(rqstp, &cstate->current_fh,
> > > -				S_IFREG, NFSD_MAY_LOCK))) {
> > > -		dprintk("NFSD: nfsd4_lock: permission denied!\n");
> > > +	status =3D fh_verify(rqstp, &cstate->current_fh, S_IFREG,
> > > +			   NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE);
> > > +	if (status !=3D nfs_ok)
> > >  		return status;
> > > -	}
> >=20
> > Reviewed-by: NeilBrown <neilb@suse.de>
> >=20
> > though I think we want a follow-on patch which uses NFSD_MAY_WRITE for
> > write locks for consistency with check_fmode_for_setlk().
>=20
> I think this patch might introduce a behavior regression, then.
> Instead of a follow-on, I need a v2 of this patch.

This is not a regression - it has always been this way (since 2.3.42).
And both NLM and v4 suffer - I was wrong about NLM.

If MAY_LOCK is set, then any MAY_READ or MAY_WRITE flag is ignored, and
the 'acc' passed to inode_permission() is only MAY_READ |
MAY_OWNER_OVERRIDE

So any locking over nfsd currently requires ownership or READ access to
the inode.  This is slightly different behaviour to local filesystems
and it might be nice to fix but I don't think it is an important
difference.  Importantly your patch doesn't change this behaviour at all.

Thanks,
NeilBrown


>=20
>=20
> > And I'm wondering about NFSD_MAY_OWNER_OVERRIDE ...  that is really an
> > NFSv3 thing.  For NFSv4 we should be checking permission at "open" time,
> > recording that in the state (both of which we do) and then performing
> > permission checks against the state rather than against the inode.
> > But that is a whole different can of worms.
>=20
> I see several sites in NFSv4 land that assert OWNER_OVERRIDE. But
> point taken on taking the permissions from the state ID instead of
> using a fixed mask.
>=20
>=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> > >  	sb =3D cstate->current_fh.fh_dentry->d_sb;
> > > =20
> > >  	if (lock->lk_is_new) {
> > > --=20
> > > 2.46.2
> > >=20
> > >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20


