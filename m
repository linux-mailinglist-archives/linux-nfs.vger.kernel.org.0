Return-Path: <linux-nfs+bounces-2201-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58527871164
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 01:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764661C21032
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 00:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88554170;
	Tue,  5 Mar 2024 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15AMtfzQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiqR1S0o";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="15AMtfzQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tiqR1S0o"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A9317EF
	for <linux-nfs@vger.kernel.org>; Tue,  5 Mar 2024 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597116; cv=none; b=V1lcyYOiRxNEAwiHkHSunYfopxgwXwzoA/HI/Xl/MwmcYvtyIBzHCUu4mIysl4FD0LwYBH6efHY0xnkoomGlkjibhkRFFwyEk/XJ7V4EmlWOv/Y5oejgccv8LTMv7rW+nzRk56MvFsWEIgrbEKK3g8NxF1nhBRAt3KYYQEU3Cq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597116; c=relaxed/simple;
	bh=hNYRmadwUF6sjditdmAjyIg6BTcLuIuOJfZgjqzQVP8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=gV2btCQlv++aOWOYGiMrRnSSKA3UI77NvczmxmYy+cS3MVOGYeXY33dmhxcGywH9avWvKYQ94HyociyJ0QeFyITYltkOQ/tWFQ80TZ7FyQoylrmJYNT4umdOBc4WSTP2LV/xYrHtLLwXfIGqNojMAxe885Ah1n3eU/6BTh47+24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15AMtfzQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiqR1S0o; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=15AMtfzQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tiqR1S0o; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A22DB37532;
	Tue,  5 Mar 2024 00:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709597112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkyeywd7qQYsxq8J8wwA5poW6SgRBiU1sGAjU5y4PUA=;
	b=15AMtfzQgPVId/5XyM9dFUBKCdRTxOypMhou5YZzr/oVxat2O5LBoZdU//Y1hca3/0qOir
	lXJe9a+DRngORJmbVdwmHPcTUy+6IVWqPJh7+bI6NQiEolzE1Y+aW/lzhsAAEx3Bawe+uA
	UtmwzNcrUvy/8Wi5dqoTlk9etDbAxVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709597112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkyeywd7qQYsxq8J8wwA5poW6SgRBiU1sGAjU5y4PUA=;
	b=tiqR1S0oNPwY7V/+974J0IO/N3jueeCcNxqgSP3U0MgZxzkw0+bDeH2vmGd60+YaRLDTgz
	L4j0fQSdKFB1f/Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709597112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkyeywd7qQYsxq8J8wwA5poW6SgRBiU1sGAjU5y4PUA=;
	b=15AMtfzQgPVId/5XyM9dFUBKCdRTxOypMhou5YZzr/oVxat2O5LBoZdU//Y1hca3/0qOir
	lXJe9a+DRngORJmbVdwmHPcTUy+6IVWqPJh7+bI6NQiEolzE1Y+aW/lzhsAAEx3Bawe+uA
	UtmwzNcrUvy/8Wi5dqoTlk9etDbAxVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709597112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fkyeywd7qQYsxq8J8wwA5poW6SgRBiU1sGAjU5y4PUA=;
	b=tiqR1S0oNPwY7V/+974J0IO/N3jueeCcNxqgSP3U0MgZxzkw0+bDeH2vmGd60+YaRLDTgz
	L4j0fQSdKFB1f/Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09F5513ADD;
	Tue,  5 Mar 2024 00:05:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id a08bKLVh5mWfdQAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 05 Mar 2024 00:05:09 +0000
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
In-reply-to: <ZeZZru5hL_77IRP_@manet.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>,
 <20240304044304.3657-4-neilb@suse.de>,
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>,
 <170958874536.24797.2684794071853900422@noble.neil.brown.name>,
 <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>,
 <170959178935.24797.7531672348129457687@noble.neil.brown.name>,
 <ZeZRC21DdOkuKroo@manet.1015granger.net>,
 <477e896777379d9b060a735a3873e2ea3096f76f.camel@kernel.org>,
 <ZeZZru5hL_77IRP_@manet.1015granger.net>
Date: Tue, 05 Mar 2024 11:05:05 +1100
Message-id: <170959710598.24797.9018033751808386090@noble.neil.brown.name>
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
> On Mon, Mar 04, 2024 at 06:11:24PM -0500, Jeff Layton wrote:
> > On Mon, 2024-03-04 at 17:54 -0500, Chuck Lever wrote:
> > > On Tue, Mar 05, 2024 at 09:36:29AM +1100, NeilBrown wrote:
> > > > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > > > On Tue, Mar 05, 2024 at 08:45:45AM +1100, NeilBrown wrote:
> > > > > > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > > > > > On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> > > > > > > > move_to_close_lru() waits for sc_count to become zero while h=
olding
> > > > > > > > rp_mutex.  This can deadlock if another thread holds a refere=
nce and is
> > > > > > > > waiting for rp_mutex.
> > > > > > > >=20
> > > > > > > > By the time we get to move_to_close_lru() the openowner is un=
hashed and
> > > > > > > > cannot be found any more.  So code waiting for the mutex can =
safely
> > > > > > > > retry the lookup if move_to_close_lru() has started.
> > > > > > > >=20
> > > > > > > > So change rp_mutex to an atomic_t with three states:
> > > > > > > >=20
> > > > > > > >  RP_UNLOCK   - state is still hashed, not locked for reply
> > > > > > > >  RP_LOCKED   - state is still hashed, is locked for reply
> > > > > > > >  RP_UNHASHED - state is not hashed, no code can get a lock.
> > > > > > > >=20
> > > > > > > > Use wait_var_event() to wait for either a lock, or for the ow=
ner to be
> > > > > > > > unhashed.  In the latter case, retry the lookup.
> > > > > > > >=20
> > > > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > > > ---
> > > > > > > >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++----=
---
> > > > > > > >  fs/nfsd/state.h     |  2 +-
> > > > > > > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > > > index 690d0e697320..47e879d5d68a 100644
> > > > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > > > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net=
 *nn)
> > > > > > > >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> > > > > > > >  }
> > > > > > > > =20
> > > > > > > > +enum rp_lock {
> > > > > > > > +	RP_UNLOCKED,
> > > > > > > > +	RP_LOCKED,
> > > > > > > > +	RP_UNHASHED,
> > > > > > > > +};
> > > > > > > > +
> > > > > > > >  static void init_nfs4_replay(struct nfs4_replay *rp)
> > > > > > > >  {
> > > > > > > >  	rp->rp_status =3D nfserr_serverfault;
> > > > > > > >  	rp->rp_buflen =3D 0;
> > > > > > > >  	rp->rp_buf =3D rp->rp_ibuf;
> > > > > > > > -	mutex_init(&rp->rp_mutex);
> > > > > > > > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > > > > > > >  }
> > > > > > > > =20
> > > > > > > > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound=
_state *cstate,
> > > > > > > > -		struct nfs4_stateowner *so)
> > > > > > > > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_=
state *cstate,
> > > > > > > > +				      struct nfs4_stateowner *so)
> > > > > > > >  {
> > > > > > > >  	if (!nfsd4_has_session(cstate)) {
> > > > > > > > -		mutex_lock(&so->so_replay.rp_mutex);
> > > > > > > > +		wait_var_event(&so->so_replay.rp_locked,
> > > > > > > > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > > > > > > > +					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> > > > > > >=20
> > > > > > > What reliably prevents this from being a "wait forever" ?
> > > > > >=20
> > > > > > That same thing that reliably prevented the original mutex_lock f=
rom
> > > > > > waiting forever.
>=20
> Note that this patch fixes a deadlock here. So clearly, there /were/
> situations where "waiting forever" was possible with the mutex version
> of this code.
>=20
>=20
> > > > > > It waits until rp_locked is set to RP_UNLOCKED, which is precisel=
y when
> > > > > > we previously called mutex_unlock.  But it *also* aborts the wait=
 if
> > > > > > rp_locked is set to RP_UNHASHED - so it is now more reliable.
> > > > > >=20
> > > > > > Does that answer the question?
> > > > >=20
> > > > > Hm. I guess then we are no worse off with wait_var_event().
> > > > >=20
> > > > > I'm not as familiar with this logic as perhaps I should be. How long
> > > > > does it take for the wake-up to occur, typically?
> > > >=20
> > > > wait_var_event() is paired with wake_up_var().
> > > > The wake up happens when wake_up_var() is called, which in this code =
is
> > > > always immediately after atomic_set() updates the variable.
> > >=20
> > > I'm trying to ascertain the actual wall-clock time that the nfsd thread
> > > is sleeping, at most. Is this going to be a possible DoS vector? Can
> > > it impact the ability for the server to shut down without hanging?
> >=20
> > Prior to this patch, there was a mutex in play here and we just released
> > it to wake up the waiters. This is more or less doing the same thing, it
> > just indicates the resulting state better.
>=20
> Well, it adds a third state so that a recovery action can be taken
> on wake-up in some cases. That avoids a deadlock, so this does count
> as a bug fix.
>=20
>=20
> > I doubt this will materially change how long the tasks are waiting.
>=20
> It might not be a longer wait, but it still seems difficult to prove
> that the wait_var_event() will /always/ be awoken somehow.

Proving locks are free from possible deadlock is notoriously difficult.=20
That is why we have lockdep.
Maybe the first step in this series should have been to add some lockdep
annotations to sc_count so that it could report the possible deadlock.
That would look like a readlock when sc_count is incremented,
readunlock when it is decremented, and a writelock when we wait in
move_to_close_lru.  Or something like that.  If we could demonstrate
that easily triggers a lockdep warning, then demonstrate the warning is
gone after the patch series, that would be a good thing.

I might try that, but not today.

>=20
> Applying for now.
>=20

Thanks,
NeilBrown

>=20
> --=20
> Chuck Lever
>=20


