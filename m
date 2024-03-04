Return-Path: <linux-nfs+bounces-2195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E378710DD
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Mar 2024 00:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49501F22F00
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Mar 2024 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785257B3FA;
	Mon,  4 Mar 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UxgsVTiM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nh7fGYIP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UxgsVTiM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nh7fGYIP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A27CF33
	for <linux-nfs@vger.kernel.org>; Mon,  4 Mar 2024 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593471; cv=none; b=CzqGkCNln/zEZRDfOazIyM1KaMlC8024KE86MI5MxrBKn13dehrTryFZhCeG74+KwfzD50xJAuue0+Q78/VMiCBJDcJfMWbBPhDs3H3Pz6IhyOOdAIuKTXRmAsv7iNkufE/1zhKqT+Fdt9HO44gfMUeO4Nbh4WsO9J1tf7NYaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593471; c=relaxed/simple;
	bh=BaaD8ZdYhwFaSoUS/ScvpBwDr0+6F6rLHlfWJtiwVZs=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R4NsPbuY2UFBGB4LhI2xIv/STn3i3UtAFxLNauNJsFtu08lIiGBfaG62fE356kAaAyorFi3Jpq8oNpeksGWuQI6ty8J31u2cpgXzebJAWANpPVJwTnlSUPkMk4A1sMZy9mXFvb2D5WjrHxe94TMozMhdS4I2xMK4FlFT0cIsnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UxgsVTiM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nh7fGYIP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UxgsVTiM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nh7fGYIP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9BCEF20F5D;
	Mon,  4 Mar 2024 23:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709593467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKCLpTBmuhgBGmM9bm6FwvZ/eGDMQY1HC2iOH9CO0DI=;
	b=UxgsVTiMV+nS3lxFN64uZ46NoHLSQSAVnhXkTPZAzv8Qo2i8IGtrhU+TIr9znFvR8T+uGM
	bnoJYgkb5GbsZZh92CtEYwuWINc/TGIi9QoRGZbRrlc+x8KiWlK3uqaBZN+75ctw5psvoo
	3Dm+8gNrL2pbVMA0juowdApOHAFgJ1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709593467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKCLpTBmuhgBGmM9bm6FwvZ/eGDMQY1HC2iOH9CO0DI=;
	b=Nh7fGYIPCT/7eXstvpnfYMFJrZHPLdVj7TTHayB70V6sE24p0z582vyjU6PC+TkTUurxj/
	3FnbK6sAQrZd1CDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709593467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKCLpTBmuhgBGmM9bm6FwvZ/eGDMQY1HC2iOH9CO0DI=;
	b=UxgsVTiMV+nS3lxFN64uZ46NoHLSQSAVnhXkTPZAzv8Qo2i8IGtrhU+TIr9znFvR8T+uGM
	bnoJYgkb5GbsZZh92CtEYwuWINc/TGIi9QoRGZbRrlc+x8KiWlK3uqaBZN+75ctw5psvoo
	3Dm+8gNrL2pbVMA0juowdApOHAFgJ1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709593467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKCLpTBmuhgBGmM9bm6FwvZ/eGDMQY1HC2iOH9CO0DI=;
	b=Nh7fGYIPCT/7eXstvpnfYMFJrZHPLdVj7TTHayB70V6sE24p0z582vyjU6PC+TkTUurxj/
	3FnbK6sAQrZd1CDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE84D13A5B;
	Mon,  4 Mar 2024 23:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sZG5I3hT5mVPZgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 04 Mar 2024 23:04:24 +0000
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
In-reply-to: <ZeZRC21DdOkuKroo@manet.1015granger.net>
References: <20240304044304.3657-1-neilb@suse.de>,
 <20240304044304.3657-4-neilb@suse.de>,
 <ZeXWGJqreYH8aayB@klimt.1015granger.net>,
 <170958874536.24797.2684794071853900422@noble.neil.brown.name>,
 <ZeZFGdOD3KWkF1Zf@manet.1015granger.net>,
 <170959178935.24797.7531672348129457687@noble.neil.brown.name>,
 <ZeZRC21DdOkuKroo@manet.1015granger.net>
Date: Tue, 05 Mar 2024 10:04:21 +1100
Message-id: <170959346119.24797.15961118462834814770@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
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

On Tue, 05 Mar 2024, Chuck Lever wrote:
> On Tue, Mar 05, 2024 at 09:36:29AM +1100, NeilBrown wrote:
> > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > On Tue, Mar 05, 2024 at 08:45:45AM +1100, NeilBrown wrote:
> > > > On Tue, 05 Mar 2024, Chuck Lever wrote:
> > > > > On Mon, Mar 04, 2024 at 03:40:21PM +1100, NeilBrown wrote:
> > > > > > move_to_close_lru() waits for sc_count to become zero while holdi=
ng
> > > > > > rp_mutex.  This can deadlock if another thread holds a reference =
and is
> > > > > > waiting for rp_mutex.
> > > > > >=20
> > > > > > By the time we get to move_to_close_lru() the openowner is unhash=
ed and
> > > > > > cannot be found any more.  So code waiting for the mutex can safe=
ly
> > > > > > retry the lookup if move_to_close_lru() has started.
> > > > > >=20
> > > > > > So change rp_mutex to an atomic_t with three states:
> > > > > >=20
> > > > > >  RP_UNLOCK   - state is still hashed, not locked for reply
> > > > > >  RP_LOCKED   - state is still hashed, is locked for reply
> > > > > >  RP_UNHASHED - state is not hashed, no code can get a lock.
> > > > > >=20
> > > > > > Use wait_var_event() to wait for either a lock, or for the owner =
to be
> > > > > > unhashed.  In the latter case, retry the lookup.
> > > > > >=20
> > > > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > > > ---
> > > > > >  fs/nfsd/nfs4state.c | 38 +++++++++++++++++++++++++++++++-------
> > > > > >  fs/nfsd/state.h     |  2 +-
> > > > > >  2 files changed, 32 insertions(+), 8 deletions(-)
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > > > > > index 690d0e697320..47e879d5d68a 100644
> > > > > > --- a/fs/nfsd/nfs4state.c
> > > > > > +++ b/fs/nfsd/nfs4state.c
> > > > > > @@ -4430,21 +4430,32 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
> > > > > >  	atomic_set(&nn->nfsd_courtesy_clients, 0);
> > > > > >  }
> > > > > > =20
> > > > > > +enum rp_lock {
> > > > > > +	RP_UNLOCKED,
> > > > > > +	RP_LOCKED,
> > > > > > +	RP_UNHASHED,
> > > > > > +};
> > > > > > +
> > > > > >  static void init_nfs4_replay(struct nfs4_replay *rp)
> > > > > >  {
> > > > > >  	rp->rp_status =3D nfserr_serverfault;
> > > > > >  	rp->rp_buflen =3D 0;
> > > > > >  	rp->rp_buf =3D rp->rp_ibuf;
> > > > > > -	mutex_init(&rp->rp_mutex);
> > > > > > +	atomic_set(&rp->rp_locked, RP_UNLOCKED);
> > > > > >  }
> > > > > > =20
> > > > > > -static void nfsd4_cstate_assign_replay(struct nfsd4_compound_sta=
te *cstate,
> > > > > > -		struct nfs4_stateowner *so)
> > > > > > +static int nfsd4_cstate_assign_replay(struct nfsd4_compound_stat=
e *cstate,
> > > > > > +				      struct nfs4_stateowner *so)
> > > > > >  {
> > > > > >  	if (!nfsd4_has_session(cstate)) {
> > > > > > -		mutex_lock(&so->so_replay.rp_mutex);
> > > > > > +		wait_var_event(&so->so_replay.rp_locked,
> > > > > > +			       atomic_cmpxchg(&so->so_replay.rp_locked,
> > > > > > +					      RP_UNLOCKED, RP_LOCKED) !=3D RP_LOCKED);
> > > > >=20
> > > > > What reliably prevents this from being a "wait forever" ?
> > > >=20
> > > > That same thing that reliably prevented the original mutex_lock from
> > > > waiting forever.
> > > > It waits until rp_locked is set to RP_UNLOCKED, which is precisely wh=
en
> > > > we previously called mutex_unlock.  But it *also* aborts the wait if
> > > > rp_locked is set to RP_UNHASHED - so it is now more reliable.
> > > >=20
> > > > Does that answer the question?
> > >=20
> > > Hm. I guess then we are no worse off with wait_var_event().
> > >=20
> > > I'm not as familiar with this logic as perhaps I should be. How long
> > > does it take for the wake-up to occur, typically?
> >=20
> > wait_var_event() is paired with wake_up_var().
> > The wake up happens when wake_up_var() is called, which in this code is
> > always immediately after atomic_set() updates the variable.
>=20
> I'm trying to ascertain the actual wall-clock time that the nfsd thread
> is sleeping, at most. Is this going to be a possible DoS vector? Can
> it impact the ability for the server to shut down without hanging?

Certainly the wall-clock sleep time is no more than it was before this
patch.
At most it is the time it takes for some other request running in some
other nfsd thread to complete.

Well.... technically if there were a large number of concurrent requests
from a client that all required claiming this lock, one of the threads
might be blocked while all the others threads get a turn.  There is no
fairness guarantee with this style of waiting.  So one thread might be
blocked indefinitely while other threads take turns taking the lock.
It's not really a DoS vector as the client is only really denying
service to itself by keeping the server excessively busy.  Other
clients will still get a reasonable turn.

NeilBrown

>=20
>=20
> --=20
> Chuck Lever
>=20


