Return-Path: <linux-nfs+bounces-9645-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F378A1CF46
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE84165DB1
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 00:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4887517D2;
	Mon, 27 Jan 2025 00:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bUkpRfJP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRwvAZkM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bUkpRfJP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hRwvAZkM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6383610E3;
	Mon, 27 Jan 2025 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737936973; cv=none; b=CCx8AN751HX6uKovWvqFATUCkKUZd76/sDX93Ibru9++BASFLp41fMsOrepmBJF437/eAO1Gtp/J/hKXKKaxMfg3dOXADDJYU1qK5l2GgC5l6ZxiOp1LrBtR8ZFmi6HG91MV+g94jEdFTHf6S3fmYQsDPVoPA+jwi5Ma/V/vz1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737936973; c=relaxed/simple;
	bh=Fsa0pr6mWcIYPIPCCbVhRW2kDXkFubnEgKJ/0y7FV+E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JU6gbDQ8NTek+Y3bmLonqEWJJ1UNnWqdgv0a/BkQhH0hNj8dPjYX8MGb335cMHNZg9cCcap52ymRGJsMd3tjiH5P6u2zzrOdyMN6+nCiVVk0lA0AryC3+FWPyhxfYV7hHQQuxHjuyD8nUtfeg6LkcvFupbRLsYjvnb4ru7XFuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bUkpRfJP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRwvAZkM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bUkpRfJP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hRwvAZkM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 626481F38F;
	Mon, 27 Jan 2025 00:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737936968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEkyjxI7wOT8NfaeOw5cuMNbmp7JtIN8hBzKqRwd4K4=;
	b=bUkpRfJPlY+qO/7yJ0gGgfDdN6oYw2A6bEV5uoopn0dpeYuB1uz0FbAIoPmFNSHoH4R8Vm
	tmTvkpl2mQVorfAH5MkJJdeq/ys+vBMYqd6LsFGr6p3x9VCGUSlRo9H0mYzwBRxnAGpvw4
	6uBDyIu0JLEhaPodPu/aDHwyKpkr/64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737936968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEkyjxI7wOT8NfaeOw5cuMNbmp7JtIN8hBzKqRwd4K4=;
	b=hRwvAZkM5yoGuP6OnnlaaiIXprvV5gFZXZyPx2r8ctsBodXLkZMWIDIyT31Gk9ybFqIYBj
	GOJToJtPGXxgLYDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737936968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEkyjxI7wOT8NfaeOw5cuMNbmp7JtIN8hBzKqRwd4K4=;
	b=bUkpRfJPlY+qO/7yJ0gGgfDdN6oYw2A6bEV5uoopn0dpeYuB1uz0FbAIoPmFNSHoH4R8Vm
	tmTvkpl2mQVorfAH5MkJJdeq/ys+vBMYqd6LsFGr6p3x9VCGUSlRo9H0mYzwBRxnAGpvw4
	6uBDyIu0JLEhaPodPu/aDHwyKpkr/64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737936968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEkyjxI7wOT8NfaeOw5cuMNbmp7JtIN8hBzKqRwd4K4=;
	b=hRwvAZkM5yoGuP6OnnlaaiIXprvV5gFZXZyPx2r8ctsBodXLkZMWIDIyT31Gk9ybFqIYBj
	GOJToJtPGXxgLYDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C59613715;
	Mon, 27 Jan 2025 00:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ek3NE0XQlmfqFgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 00:16:05 +0000
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
Cc: "Chuck Lever" <chuck.lever@oracle.com>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Salvatore Bonaccorso" <carnil@debian.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: validate the nfsd_serv pointer before calling svc_wake_up
In-reply-to: <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
References: <>, <a3ca70c78e48e1a36d29741eb8913ce85e3f51a2.camel@kernel.org>
Date: Mon, 27 Jan 2025 11:15:45 +1100
Message-id: <173793694589.22054.1830112177481945773@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 27 Jan 2025, Jeff Layton wrote:
> On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
> > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
> > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > nfsd_file_dispose_list_delayed can be called from the filecache
> > > > > laundrette, which is shut down after the nfsd threads are shut down=
 and
> > > > > the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then the=
re
> > > > > are no threads to wake.
> > > > >=20
> > > > > Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> > > > > svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since t=
he
> > > > > svc_serv is not freed until after the filecache laundrette is cance=
lled.
> > > > >=20
> > > > > Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a =
work queue")
> > > > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > > Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9935a47e1=
d405643220d7946.camel@kernel.org/
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > > This is only lightly tested, but I think it will fix the bug that
> > > > > Salvatore reported.
> > > > > ---
> > > > >  fs/nfsd/filecache.c | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2=
dd750f43239b4af6d37b0 100644
> > > > > --- a/fs/nfsd/filecache.c
> > > > > +++ b/fs/nfsd/filecache.c
> > > > > @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_he=
ad *dispose)
> > > > >  						struct nfsd_file, nf_gc);
> > > > >  		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > > > >  		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > > > > +		struct svc_serv *serv;
> > > > > =20
> > > > >  		spin_lock(&l->lock);
> > > > >  		list_move_tail(&nf->nf_gc, &l->freeme);
> > > > >  		spin_unlock(&l->lock);
> > > > > -		svc_wake_up(nn->nfsd_serv);
> > > > > +
> > > > > +		/*
> > > > > +		 * The filecache laundrette is shut down after the
> > > > > +		 * nn->nfsd_serv pointer is cleared, but before the
> > > > > +		 * svc_serv is freed.
> > > > > +		 */
> > > > > +		serv =3D nn->nfsd_serv;
> > > >=20
> > > > I wonder if this should be READ_ONCE() to tell the compiler that we
> > > > could race with clearing nn->nfsd_serv.  Would the comment still be
> > > > needed?
> > > >=20
> > >=20
> > > I think we need a comment at least. The linkage between the laundrette
> > > and the nfsd_serv being set to NULL is very subtle. A READ_ONCE()
> > > doesn't convey that well, and is unnecessary here.
> >=20
> > Why do you say "is unnecessary here" ?
> > If the code were
> >    if (nn->nfsd_serv)
> >             svc_wake_up(nn->nfsd_serv);
> > that would be wrong as nn->nfds_serv could be set to NULL between the
> > two.
> > And the C compile is allowed to load the value twice because the C memory
> > model declares that would have the same effect.
> > While I doubt it would actually change how the code is compiled, I think
> > we should have READ_ONCE() here (and I've been wrong before about what
> > the compiler will actually do).
> >=20
> >=20
>=20
> It's unnecessary because the outcome of either case is acceptable.
>=20
> When racing with shutdown, either it's NULL and the laundrette won't
> call svc_wake_up(), or it's non-NULL and it will. In the non-NULL case,
> the call to svc_wake_up() will be a no-op because the threads are shut
> down.
>=20
> The vastly common case in this code is that this pointer will be non-
> NULL, because the server is running (i.e. not racing with shutdown). I
> don't see the need in making all of those accesses volatile.

One of us is confused.  I hope it isn't me.

The hypothetical problem I see is that the C compiler could generate
code to load the value "nn->nfsd_serv" twice.  The first time it is not
NULL, the second time it is NULL.
The first is used for the test, the second is passed to svc_wake_up().

Unlikely though this is, it is possible and READ_ONCE() is designed
precisely to prevent this.
To quote from include/asm-generic/rwonce.h it will
 "Prevent the compiler from merging or refetching reads"

A "volatile" access does not add any cost (in this case).  What it does
is break any aliasing that the compile might have deduced.
Even if the compiler thinks it has "nn->nfsd_serv" in a register, it
won't think it has the result of READ_ONCE(nn->nfsd_serv) in that register.
And if it needs the result of a previous READ_ONCE(nn->nfsd_serv) it
won't decide that it can just read nn->nfsd_serv again.  It MUST keep
the result of READ_ONCE(nn->nfsd_serv) somewhere until it is not needed
any more.

NeilBrown

