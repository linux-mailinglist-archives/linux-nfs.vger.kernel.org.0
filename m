Return-Path: <linux-nfs+bounces-10984-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBA3A78529
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Apr 2025 01:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF11188FDBA
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Apr 2025 23:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089EE20AF8B;
	Tue,  1 Apr 2025 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ir9hIGMC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lHbrDYAX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dDzxKyHt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CogpxF1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED861A5BB0
	for <linux-nfs@vger.kernel.org>; Tue,  1 Apr 2025 23:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743549493; cv=none; b=qAZV9X/WKZcGNtqWpSG97xB5XXp5xewaUXOoHtrMgSxo8rxeKn22J+y87wOxjV8JTLMq51+3TBqW8DpPG7xmUsRymxuQF3VBOqDrlxohVx/YeyViqcwS1UIObMkBQlbGHXnWyEzNh7tqHzpLODqHYFmuj9FJq2hoeNViwY6IUgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743549493; c=relaxed/simple;
	bh=zm3UvZRWuY8coWnGnq/u5apI25a6ef1r+tstwXTdMCo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=WNf8gXRogVr3i/8C8RobwUJKbgwiXxaSlQR4esl9c5hP1m2J961WSMeq40+d+Z/Uq0fXtJTnh2O0OO/HE0m8KPXFv5yuLt5tZq7IGoigI4Rr4Gy2S9SbMZJzs0kQKnq2eewMkgkIF53yFqRIUM9L1ok2WWLnCuBpinWTY80RwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ir9hIGMC; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lHbrDYAX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dDzxKyHt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CogpxF1W; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A19861F38E;
	Tue,  1 Apr 2025 23:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743549489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm5C72z3RH2q7Y8vAz4x18DvzxAaOC6KOY4KbGDz5bY=;
	b=ir9hIGMC+iTuxQ/qW61dvcqhez9wjZrv6XNZAphlGwGt4VspdbjIEiPSu8J/QsPJL3gWPP
	zgx+earUFsXbqFWKavQrZs4qjdiKsJTy9KVH4bR8O8/mh3SZtBBh9S97gthbLPsgfeymsX
	M2Ciugr8os6VlZBbKhd6Qk5rDZV/Irs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743549489;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm5C72z3RH2q7Y8vAz4x18DvzxAaOC6KOY4KbGDz5bY=;
	b=lHbrDYAXLZDHWXU49ZWmzBNDHlpLIUi3znZbYOgJloyvE2eLQeulEW8VcNNYHP9wyiW/hM
	8b1Lq3dgbaDdJ3Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743549488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm5C72z3RH2q7Y8vAz4x18DvzxAaOC6KOY4KbGDz5bY=;
	b=dDzxKyHtF344+ltdCia8OfUXRbUlHN9wBFLo4mVFxTDM1l/R+eEVIV6eVGMIKzqeBaKaF9
	JIBTOPjT9OX5y5Ud6jNkeSW+d5aS+AtS5KjkUFCrMVIBkzJ5yurVCTx7MhFK4InjVu9EzV
	1iuXT4R7FiL/ysABLu+G20Drppxhchc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743549488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cm5C72z3RH2q7Y8vAz4x18DvzxAaOC6KOY4KbGDz5bY=;
	b=CogpxF1Wc7nrgxdC1UyClELsZTJY0Qd4u6aIhjhy7PA+vrHl2EySgEMP/8gZ35fP8b49P7
	ci1kvftVBKSBLfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E0A913691;
	Tue,  1 Apr 2025 23:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LrBhOS107GebewAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 01 Apr 2025 23:18:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Olga Kornievskaia" <aglo@umich.edu>
Cc: "Olga Kornievskaia" <okorniev@redhat.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, jlayton@kernel.org,
 linux-nfs@vger.kernel.org, Dai.Ngo@oracle.com, tom@talpey.com
Subject:
 Re: [PATCH 3/3] nfsd: reset access mask for NLM calls in nfsd_permission
In-reply-to:
 <CAN-5tyG+RGh9aO1R8XYwymP20X0xERvaARhgnQQ0--8o6wk3_Q@mail.gmail.com>
References:
 <>, <CAN-5tyG+RGh9aO1R8XYwymP20X0xERvaARhgnQQ0--8o6wk3_Q@mail.gmail.com>
Date: Wed, 02 Apr 2025 10:18:03 +1100
Message-id: <174354948303.9342.13148054985288264939@noble.neil.brown.name>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, 02 Apr 2025, Olga Kornievskaia wrote:
> On Tue, Apr 1, 2025 at 6:24=E2=80=AFPM NeilBrown <neilb@suse.de> wrote:
> >
> > On Tue, 01 Apr 2025, Olga Kornievskaia wrote:
> > > On Mon, Mar 31, 2025 at 10:49=E2=80=AFAM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> > > >
> > > > On 3/30/25 8:10 PM, NeilBrown wrote:
> > > > > On Mon, 31 Mar 2025, Olga Kornievskaia wrote:
> > > > >>
> > > > >> This code would also make the behaviour consistent with prior to
> > > > >> 4cc9b9f2bf4d. But now I question whether or not the new behaviour =
is
> > > > >> what is desired going forward or not?
> > > > >>
> > > > >> Here's another thing to consider: the same command done over nfsv4
> > > > >> returns an error. I guess nobody ever complained that flock over v3
> > > > >> was successful but failed over v4?
> > > > >
> > > > > That is useful.  Given that:
> > > > >  - exclusive flock without write access over v4 never worked
> > > > >  - As Tom notes, new man pages document that exclusive flock withou=
t write access
> > > > >    isn't expected to work over NFS
> > > > >  - it is hard to think of a genuine use case for exclusive flock wi=
thout
> > > > >    write access
> > > > >
> > > > > I'm inclined to leave this code as it is and declare your failing t=
est
> > > > > to no longer be invalid.
> > > >
> > > > For the record, which test exactly is failing? Is there a BugLink?
> > >
> > > Test is just an flock()?
> > >
> >
> > But what motivated you to perform that specific test:
> >   exclusive flock over NFSv3 on a file you didn't have write permission to
> > ??
> >
> > Is it part of a test suite? Or is it done by some application? or ....
>=20
> A long story. It started with xfstest failing for sec=3Dtls policy (ie
> thus the other 2 patches in the series). But I saw that it's just an
> flock that was failing so I stopped doing xfstest and just using an
> flock. But as I started digging into the bisected patch I was trying
> to understand the code and thus started using other export policies.

That all makes perfect sense - thanks.

So the fact that you noticed was primarily based on code inspection and
does not suggest that other people might also notice the change and see
it as a regression.

That strengthens my feeling that the change should be seen as a bug-fix,
not as a regression.  So we don't need to "fix" it.

Thanks,
NeilBrown

