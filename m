Return-Path: <linux-nfs+bounces-8187-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A25629D54A3
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 22:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25E771F2190F
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Nov 2024 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3812D4502F;
	Thu, 21 Nov 2024 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iBeannph";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+a3opeRF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UP0wa5UO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JNZH+/lk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F71C8FCF
	for <linux-nfs@vger.kernel.org>; Thu, 21 Nov 2024 21:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224022; cv=none; b=VxVUp6dxj1a6P55AtLeZHiG0kRcTfHCVduug2rSvSjoGV3Mik+lnb7x/B1hH9KJTDskYrUUYmwBztzSOLWkgSTkY3xoTulzHOqSGTYuh2PInLnM25AQ5JbbgWHy9Q46/44au7OD7tH3TpwqqmDMiaXtnhJmceDJdUD/7zT7KVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224022; c=relaxed/simple;
	bh=qUcVfwKeq4VObfXxXOz5I3sRgOgL4tJ1y8maFSZ12FM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=ZiLstLk0hpOKwViW3ix+UI0wZsriqu92m67LCBN51S081c9QKy7y3aHEZljcmdgHue3+dMktJVqKg5nGs/DLwyZQgEZnREFfcrlanmT++WgSyAbKMrzUjlhysVQOKmlx68vXnq8rjaQ1sPG2QaLYy14U76nuL8dHy+5bU4wcw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iBeannph; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+a3opeRF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UP0wa5UO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JNZH+/lk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED1111F82D;
	Thu, 21 Nov 2024 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732224018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYTpIl5DtwllPPguV60jerFQ4A/Ltw6QZwuUu7ZI358=;
	b=iBeannpha5rgIvXXuE2IVEV90jy/05Fglm7L4kwJ+Q0iOg4qO7fn2GBxhxHbCrMF/xzwI2
	eRr/HYwKsrMZ9iEglZFJWFnu5JveTPNbtEr5IUOMefjpjVTUWC4hGuhvcnnaJzkVEWw/VU
	EmcLZoTUpyTPiVVP4G266dq3JCez3TI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732224018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYTpIl5DtwllPPguV60jerFQ4A/Ltw6QZwuUu7ZI358=;
	b=+a3opeRFZ2sn2ttUeB8XTtVNzX1BUVAZvZEuAH9/czEp0UkFbUEvb8XvYQ3TQ+6/dxnEUp
	tH+g3ycWgqyXIhAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UP0wa5UO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="JNZH+/lk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1732224017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYTpIl5DtwllPPguV60jerFQ4A/Ltw6QZwuUu7ZI358=;
	b=UP0wa5UOGAL3r5PqlxFVuzWmJjE6pM/C3AXpgFAYy5+bxIn4E+Zi/vJAWATD3rvnMSAx/S
	z2PImSPesY+SXqlcizmaxPX/V4loeqjuAEq7gjozXNVRZ+orFhBHpK9AuPRIJPVZpBdUON
	slVk6ErU7wGOtqfHpWfayg1e4Rf1E3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1732224017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cYTpIl5DtwllPPguV60jerFQ4A/Ltw6QZwuUu7ZI358=;
	b=JNZH+/lkR04eO379GHTrs+ZPZqgelijblfj0q8h4RAtmdTh41RFHG0n6SNW5Zn3jI62y4b
	ybi3wO1gn5yCxpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66908137CF;
	Thu, 21 Nov 2024 21:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eg/+Ag+kP2eFMAAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 21 Nov 2024 21:20:15 +0000
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
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 4/6] nfsd: allocate new session-based DRC slots on demand.
In-reply-to: <Zz0uAZQpR4LG/gvi@tissot.1015granger.net>
References: <>, <Zz0uAZQpR4LG/gvi@tissot.1015granger.net>
Date: Fri, 22 Nov 2024 08:20:11 +1100
Message-id: <173222401180.1734440.2984878938745010890@noble.neil.brown.name>
X-Rspamd-Queue-Id: ED1111F82D
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 20 Nov 2024, Chuck Lever wrote:
> On Wed, Nov 20, 2024 at 09:27:51AM +1100, NeilBrown wrote:
> > On Wed, 20 Nov 2024, Chuck Lever wrote:
> > > On Tue, Nov 19, 2024 at 11:41:31AM +1100, NeilBrown wrote:
> > > > If a client ever uses the highest available slot for a given session,
> > > > attempt to allocate another slot so there is room for the client to u=
se
> > > > more slots if wanted.  GFP_NOWAIT is used so if there is not plenty of
> > > > free memory, failure is expected - which is what we want.  It also
> > > > allows the allocation while holding a spinlock.
> > > >=20
> > > > We would expect to stablise with one more slot available than the cli=
ent
> > > > actually uses.
> > >=20
> > > Which begs the question "why have a 2048 slot maximum session slot
> > > table size?" 1025 might work too. But is there a need for any
> > > maximum at all, or is this just a sanity check?
> >=20
> > Linux NFS presumably isn't the only client, and it might change in the
> > future.  Maybe there is no need for a maximum.  It was mostly as a
> > sanity check.
> >=20
> > It wouldn't take much to convince me to remove the limit.
>=20
> What's the worse that might happen if there is no cap? Can this be
> used as a DoS vector?

It depends on how much you trust the clients that you have decided to
trust.  Probably we want the option of a "public" NFS server (read only
probably) so we cannot assume much trust in the implementation of the
client.

Certainly a client could only ever use the highest slot number available
- though the RFC prefers lowest - and that could push allocating through
the roof.  We could defend against that in more subtle ways, but a hard
upper limit is easy.

>=20
> If a maximum should be necessary, its value should be clearly
> labeled as "not an architectural limit -- for sanity checking only".

That is certainly sensible.

>=20
>=20
> > > > Now that we grow the slot table on demand we can start with a smaller
> > > > allocation.  Define NFSD_MAX_INITIAL_SLOTS and allocate at most that
> > > > many when session is created.
> > >=20
> > > Maybe NFSD_DEFAULT_INITIAL_SLOTS is more descriptive?
> >=20
> > I don't think "DEFAULT" is the right word.  The client requests a number
> > of slots.  That is the "Default".  The server can impose a limit - a
> > maximum.
> > Maybe we don't need a limit here either?
>=20
> I see. Well I don't think there needs to be a "maximum" number of
> initial slots. NFSD can try to allocate the number the client
> requested as best it can, until it hits our sane maximum above.

Given that we have a shrinker to discard them if they ever become a
problem, that makes sense.

>=20
> I think sessions should have a minimum number of slots to guarantee
> forward progress (or IOW prevent a deadlock). I would say that
> number should be larger than 1 -- perhaps 2 or even 4.

I think one is enough to ensure forward progress.  Otherwise the RFC
would have something to say about this.

>=20
> The problem with a small initial slot count is that means the
> session has a slow start heuristic. That might or might not be
> desirable here.

The question of how quickly to increase slot count can be relevant at
any time, not just at session creation time.  If there is a bust of
activity after a quite time during which the shrinker discarded a lot of
slots - how quickly should we rebuild?
My current approach is effectively one new slot per requests round-trip.
So there might be 1 request in flight.  Then 2.  Then 3. etc.

We could aim for exponential rather than linear growth.  Maybe when the
highest slot is used, add 20% of the current number of slots - rounded
up.
So 1,2,3,4,5,6,8,10,12,15,18,22,26,31,37,44,52,62,74,88,105,126,

??

Thanks,
NeilBrown

