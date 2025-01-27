Return-Path: <linux-nfs+bounces-9707-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE31EA2004B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 23:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C6827A1975
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 22:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1C1D9694;
	Mon, 27 Jan 2025 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="z5G3wiq+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iAtC1ORf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HUtV3woO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pgwxm/RS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB471D932F;
	Mon, 27 Jan 2025 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015898; cv=none; b=sDeeO810ax42M9M31FcXRzdb/ZcXvsNZhQUcO3jqMrmYcE2lgmQaPQ3i6ywAQq/AaeqIlMEDQIYe0dgeTbkg2DWdDMSetgUhI0EysWV1cVSi6txf9+7uRLH46EE/tyaqry3VNBumdsshfvdQxPAwf7CtPnOxPqhN4pk0Tp5nbUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015898; c=relaxed/simple;
	bh=Sm3MNotWdP4qjElp6CpmzgV/ggHNOqJNGDuootXWB7c=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qmJB3HtsUqC0uBy4+tcx7ahX3TSxziDsRMQAGwmTTgz2AaCUbc/o5OQfKckYeRO9x2nTJaDmQ//bCyRE3qG7WPdPNO8h/GWIHMnkiFCPCQS5Jqx9sT7mWOMlbd2ABHzVv8l2Nif72S/OW0OGUSqHsb7UGiRoYiOz+dAgFAYaftM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=z5G3wiq+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iAtC1ORf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HUtV3woO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pgwxm/RS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EC3C21F383;
	Mon, 27 Jan 2025 22:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738015894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux6bbQMknY1nZfU1zHI6e0Omw/BQphoaBkuzylykwjQ=;
	b=z5G3wiq+lmZXXnPFQ3wcFR5QgtM0jJamhDfSZUXfNpkGb8dZUvUWaJox/fB3H0UCc1OnDL
	cCQ5c8/nFM9TUQAceMbbTo9/JiP1LGGfmgCNWLdAtu/QxmscX5ZwWpCD5fdA/IaptxU+8Y
	ZePGf/8j/e/tYZkf7JZcBfY+kOP3zls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738015894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux6bbQMknY1nZfU1zHI6e0Omw/BQphoaBkuzylykwjQ=;
	b=iAtC1ORf8FS5jLfvLyBlOKnU1Fl/tq3O6g7IN/KlctcbuZ2jXNbmcK3J+DSyopVZe08JSu
	gsBYnuJ9UITizBDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738015893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux6bbQMknY1nZfU1zHI6e0Omw/BQphoaBkuzylykwjQ=;
	b=HUtV3woOxMz4nALdBEDb/cSb0TJyY6QVyAWV+tPHD3JbjufMWt0kq7XK9MoEyPqU5P+2Ru
	s8KAbAWLJ1ca6io934EqTgR3b11LBX8JQXMh+1ABoO6VnzgEvwGBBNhjDi5icioHAi2kuQ
	g+5NaElNXQPTJp9VbNqv6fDBGyN7beM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738015893;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ux6bbQMknY1nZfU1zHI6e0Omw/BQphoaBkuzylykwjQ=;
	b=pgwxm/RS43FnSPbUZoI0h0qrsftXQfEWi0rLzM5ar56hPbU6x6X0O9Q7uHgZryCKv3+xMW
	45txsuUSTKLBM5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E601E137C0;
	Mon, 27 Jan 2025 22:11:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /9NcJpIEmGe9SwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 22:11:30 +0000
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
In-reply-to: <b582a2aba4abf425b533637bd2ab8546d49784ae.camel@kernel.org>
References: <>, <b582a2aba4abf425b533637bd2ab8546d49784ae.camel@kernel.org>
Date: Tue, 28 Jan 2025 09:11:23 +1100
Message-id: <173801588328.22054.10387428932651764809@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On Tue, 28 Jan 2025, Jeff Layton wrote:
> On Mon, 2025-01-27 at 09:03 -0500, Chuck Lever wrote:
> > On 1/27/25 8:39 AM, Chuck Lever wrote:
> > > On 1/27/25 8:32 AM, Jeff Layton wrote:
> > > > On Mon, 2025-01-27 at 08:22 -0500, Chuck Lever wrote:
> > > > > On 1/27/25 8:07 AM, Jeff Layton wrote:
> > > > > > On Mon, 2025-01-27 at 11:15 +1100, NeilBrown wrote:
> > > > > > > On Mon, 27 Jan 2025, Jeff Layton wrote:
> > > > > > > > On Mon, 2025-01-27 at 08:53 +1100, NeilBrown wrote:
> > > > > > > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > > > > > > On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
> > > > > > > > > > > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > > > > > > > > > > nfsd_file_dispose_list_delayed can be called from the=
 filecache
> > > > > > > > > > > > laundrette, which is shut down after the nfsd threads=
 are shut=20
> > > > > > > > > > > > down and
> > > > > > > > > > > > the nfsd_serv pointer is cleared. If nn->nfsd_serv is=
 NULL=20
> > > > > > > > > > > > then there
> > > > > > > > > > > > are no threads to wake.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Ensure that the nn->nfsd_serv pointer is non-NULL bef=
ore calling
> > > > > > > > > > > > svc_wake_up in nfsd_file_dispose_list_delayed. This i=
s safe=20
> > > > > > > > > > > > since the
> > > > > > > > > > > > svc_serv is not freed until after the filecache laund=
rette is=20
> > > > > > > > > > > > cancelled.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Fixes: ffb402596147 ("nfsd: Don't leave work of closi=
ng files=20
> > > > > > > > > > > > to a work queue")
> > > > > > > > > > > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > > > > > > > > > > Closes: https://lore.kernel.org/linux-=20
> > > > > > > > > > > > nfs/7d9f2a8aede4f7ca9935a47e1d405643220d7946.camel@ke=
rnel.org/
> > > > > > > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > > > > > > ---
> > > > > > > > > > > > This is only lightly tested, but I think it will fix =
the bug that
> > > > > > > > > > > > Salvatore reported.
> > > > > > > > > > > > ---
> > > > > > > > > > > > =C2=A0=C2=A0 fs/nfsd/filecache.c | 11 ++++++++++-
> > > > > > > > > > > > =C2=A0=C2=A0 1 file changed, 10 insertions(+), 1 dele=
tion(-)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > > > > > > > > > index=20
> > > > > > > > > > > > e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a=
3c077de2dd750f43239b4af6d37b0 100644
> > > > > > > > > > > > --- a/fs/nfsd/filecache.c
> > > > > > > > > > > > +++ b/fs/nfsd/filecache.c
> > > > > > > > > > > > @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(=
struct=20
> > > > > > > > > > > > list_head *dispose)
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file, nf_gc);
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct nfsd_net *nn =3D net_generic(nf->nf_net,=20
> > > > > > > > > > > > nfsd_net_id);
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sv=
c_serv *serv;
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 spin_lock(&l->lock);
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 list_move_tail(&nf->nf_gc, &l->freeme);
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 spin_unlock(&l->lock);
> > > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 svc_wake_=
up(nn->nfsd_serv);
> > > > > > > > > > > > +
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * T=
he filecache laundrette is shut down after the
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * n=
n->nfsd_serv pointer is cleared, but before the
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * s=
vc_serv is freed.
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 serv =3D =
nn->nfsd_serv;
> > > > > > > > > > >=20
> > > > > > > > > > > I wonder if this should be READ_ONCE() to tell the comp=
iler=20
> > > > > > > > > > > that we
> > > > > > > > > > > could race with clearing nn->nfsd_serv.=C2=A0 Would the=
 comment=20
> > > > > > > > > > > still be
> > > > > > > > > > > needed?
> > > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > I think we need a comment at least. The linkage between t=
he=20
> > > > > > > > > > laundrette
> > > > > > > > > > and the nfsd_serv being set to NULL is very subtle. A REA=
D_ONCE()
> > > > > > > > > > doesn't convey that well, and is unnecessary here.
> > > > > > > > >=20
> > > > > > > > > Why do you say "is unnecessary here" ?
> > > > > > > > > If the code were
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 if (nn->nfsd_serv)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 svc_wake_up(nn->nfsd_serv);
> > > > > > > > > that would be wrong as nn->nfds_serv could be set to NULL b=
etween=20
> > > > > > > > > the
> > > > > > > > > two.
> > > > > > > > > And the C compile is allowed to load the value twice becaus=
e the=20
> > > > > > > > > C memory
> > > > > > > > > model declares that would have the same effect.
> > > > > > > > > While I doubt it would actually change how the code is comp=
iled,=20
> > > > > > > > > I think
> > > > > > > > > we should have READ_ONCE() here (and I've been wrong before=
 about=20
> > > > > > > > > what
> > > > > > > > > the compiler will actually do).
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > >=20
> > > > > > > > It's unnecessary because the outcome of either case is accept=
able.
> > > > > > > >=20
> > > > > > > > When racing with shutdown, either it's NULL and the laundrett=
e won't
> > > > > > > > call svc_wake_up(), or it's non-NULL and it will. In the non-=
NULL=20
> > > > > > > > case,
> > > > > > > > the call to svc_wake_up() will be a no-op because the threads=
 are=20
> > > > > > > > shut
> > > > > > > > down.
> > > > > > > >=20
> > > > > > > > The vastly common case in this code is that this pointer will=
 be non-
> > > > > > > > NULL, because the server is running (i.e. not racing with=20
> > > > > > > > shutdown). I
> > > > > > > > don't see the need in making all of those accesses volatile.
> > > > > > >=20
> > > > > > > One of us is confused.=C2=A0 I hope it isn't me.
> > > > > > >=20
> > > > > >=20
> > > > > > It's probably me. I think you have a much better understanding of
> > > > > > compiler design than I do. Still...
> > > > > >=20
> > > > > > > The hypothetical problem I see is that the C compiler could gen=
erate
> > > > > > > code to load the value "nn->nfsd_serv" twice.=C2=A0 The first t=
ime it is=20
> > > > > > > not
> > > > > > > NULL, the second time it is NULL.
> > > > > > > The first is used for the test, the second is passed to svc_wak=
e_up().
> > > > > > >=20
> > > > > > > Unlikely though this is, it is possible and READ_ONCE() is desi=
gned
> > > > > > > precisely to prevent this.
> > > > > > > To quote from include/asm-generic/rwonce.h it will
> > > > > > > =C2=A0=C2=A0 "Prevent the compiler from merging or refetching r=
eads"
> > > > > > >=20
> > > > > > > A "volatile" access does not add any cost (in this case).=C2=A0=
 What it=20
> > > > > > > does
> > > > > > > is break any aliasing that the compile might have deduced.
> > > > > > > Even if the compiler thinks it has "nn->nfsd_serv" in a registe=
r, it
> > > > > > > won't think it has the result of READ_ONCE(nn->nfsd_serv) in th=
at=20
> > > > > > > register.
> > > > > > > And if it needs the result of a previous READ_ONCE(nn->nfsd_ser=
v) it
> > > > > > > won't decide that it can just read nn->nfsd_serv again.=C2=A0 I=
t MUST keep
> > > > > > > the result of READ_ONCE(nn->nfsd_serv) somewhere until it is no=
t=20
> > > > > > > needed
> > > > > > > any more.
> > > > > >=20
> > > > > > I'm mainly just considering the resulting pointer. There are two
> > > > > > possible outcomes to the fetch of nn->nfsd_serv. Either it's a va=
lid
> > > > > > pointer that points to the svc_serv, or it's NULL. The resulting =
code
> > > > > > can handle either case, so it doesn't seem like adding READ_ONCE(=
) will
> > > > > > create any material difference here.
> > > > > >=20
> > > > > > Maybe I should ask it this way: What bad outcome could result if =
we
> > > > > > don't add READ_ONCE() here?
> > > > >=20
> > > > > Neil just described it. The compiler would generate two load operat=
ions,
> > > > > one for the test and one for the function call argument. The first =
load
> > > > > can retrieve a non-NULL address, and the second a NULL address.
> > > > >=20
> > > > > I agree a READ_ONCE() is necessary.
> > > > >=20
> > > > >=20
> > > >=20
> > > > Now I'm confused:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_serv *serv;
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [...]
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The filecache laundrette is shut down aft=
er the
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * nn->nfsd_serv pointer is cleared, but bef=
ore the
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * svc_serv is freed.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 serv =3D nn->nfsd_serv;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (serv)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
vc_wake_up(serv);
> > > >=20
> > > > This code is explicitly asking to fetch nn->nfsd_serv into the serv
> > > > variable, and then is testing that copy of the pointer and passing it
> > > > into svc_wake_up().
> > > >=20
> > > > How is the compiler allowed to suddenly refetch a NULL pointer into
> > > > serv after testing that serv is non-NULL?
> > >=20
> > > There's nothing here that tells the compiler it is not allowed to
> > > optimize this into two separate fetches if it feels that is better
> > > code. READ_ONCE is what tells the compiler we do not want that re-
> > > organization /ever/.
> > >=20
> > >=20
> >=20
> > Well, I think you can argue that even if the compiler does split this
> > code into two reads of nn->nfsd_serv, it is guaranteed that the read
> > value is always the same both times -- I guess that's that the comment
> > is arguing, yes?
> >=20
>=20
> Exactly. That's why I didn't just do:
>=20
> if (nn->nfsd_serv)
> 	svc_destroy(nn->nfsd_serv);
>=20
> We just have to ensure that we don't pass a NULL pointer to
> svc_destroy() and that should be guaranteed by fetching it into an
> interim variable.=C2=A0
>=20
> A READ_ONCE() doesn't buy us anything extra in this situation. It
> ensures that it doesn't use a cached version of nn->nfsd_serv when it
> does the fetch, but using a cached version is harmless here. Either way
> will still work.

Yes, READ_ONCE() ensures we don't use a cached version but, as you say,
that is not relevant here.  But that is not the ONLY thing that
READ_ONCE() does.
Remember what I quoted from rwonce.h:

 * Prevent the compiler from merging or refetching reads or writes.
                                     ^^^^^^^^^^^^^

There are 2 things that READ_ONCE() does.=20
1/ it avoids "merging" so a cached value won't be used
2/ it avoids "refetching".  THAT is what we need to ensure.

This is more practically relevant in larger functions.
If I had

 serv =3D nn->nfsd_serv;
 if (serv) {
     /* do lots of other complicated stuff with other
      * fields from nn and probably call some functions, but
      * don't use serv or nn->nfsd_serv
      */
     svc_destroy(serv);
 }

then while compiling that complicated stuff the compiler might find that
it wants to spill the register containing "serv".  But doesn't want to
spill "nn" because that is more actively used.  So instead of spilling
"serv" to the stack it just reuses the register and reloads
nn->nfsd_serv for the final call.  This is perfectly legal in C because
the memory model affirms that memory won't spontaneously change unless
it is marked "volatile" (or unless it is told that memory might have
changed which is that "barrier()" does).

In the particular code in question there isn't any complexity in between
so I cannot imagine the compiler wanting to spill anything.  But maybe
one day the code will be changed.
It is best-practice to use an appropriate accessor for data that might
change in some other thread.  Sometimes that means holding a lock,
sometimes it mean atomic_read or rcu_dereference.  Sometimes it means
READ_ONCE().
Accessing data that can be changed by another thread without something
like that is almost certainly "wrong".

>=20
> Plus, if this had access to a cached version of that variable in a
> register, it avoided a memory fetch. Given that this should almost
> never be NULL, adding READ_ONCE() seems like a waste.

But it doesn't have access to a cached version.  In this code, this is
the first use of nn->nfsd_serv.  So the READ_ONCE() can have no
performance cost at all.  If the code were ever changed to add more uses
for nn->nfsd_serv, that READ_ONCE would serve as a loud reminder that
the value can change and so any new accesses should happen after the
READ_ONCE().

Thanks,
NeilBrown

