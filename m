Return-Path: <linux-nfs+bounces-9642-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FF2A1CEE9
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E6118879BC
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jan 2025 21:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412D14A0A3;
	Sun, 26 Jan 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1RZx7Fb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t0642llk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1RZx7Fb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t0642llk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96B86AE3;
	Sun, 26 Jan 2025 21:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737928451; cv=none; b=sPnUe50wmd/aaZsPN5yZvU7gT/iswH/TO19mpj7KHk69kKZGhuCyxQQvdGmRS/46eLBmBND1cIJkNPYf3ZHoP+1OEUD7Tu2jxh4NGONBhpYpNrXByFgDryqf02yX12r1Ro7Mlw/X05aUPAAzCz83YOm1Scf+6E2u31dLgYGrmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737928451; c=relaxed/simple;
	bh=wClFcHnplJgnQMoNYLeqeMTC4VdAJigHhIDtFcloTag=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=f8BByJrBcK6YNFp/3XhM3gnjw+SgkJKynPibHdAxcYbaCBdNR8VA2qJ0UT9gj325U7gJVmFRGrl1K0LrPUe1mVowLxvju6jx9u40p55tdoGBzHf+jHcTMzTTFFJQJ1m94OgVqgfwYTrUccICSQ6Qp2lUHObjsRaXjAwWpc27UUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1RZx7Fb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t0642llk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1RZx7Fb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=t0642llk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B5BD1F38F;
	Sun, 26 Jan 2025 21:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737928447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DvkS2LGbHPK2c81mWTuMagsQQwBmOufy4uD2JrfRTs=;
	b=o1RZx7Fbz7oZNf2tHuI6jbNlDwatAQvSSB9SwIrBlpV6dKY0Zhy96GgIA8AthN1cXep9/4
	Cz2KPFlyHcPb5f9Xtyd4umUk3c6dSMmpdd9FpY4JryAx0CUXM3x9MX3/rBYg8+Hfe38Oup
	0Y3Ig08wyW5dB4DQ/1R0utne0Fqr2Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737928447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DvkS2LGbHPK2c81mWTuMagsQQwBmOufy4uD2JrfRTs=;
	b=t0642llkhh9YPMCYSyT54VRI3lifhUsr9rIN6AWsnS1DA2rOj5UOoRNMNq2seoa76LZS86
	pX1YgaQxuyLLx1Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737928447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DvkS2LGbHPK2c81mWTuMagsQQwBmOufy4uD2JrfRTs=;
	b=o1RZx7Fbz7oZNf2tHuI6jbNlDwatAQvSSB9SwIrBlpV6dKY0Zhy96GgIA8AthN1cXep9/4
	Cz2KPFlyHcPb5f9Xtyd4umUk3c6dSMmpdd9FpY4JryAx0CUXM3x9MX3/rBYg8+Hfe38Oup
	0Y3Ig08wyW5dB4DQ/1R0utne0Fqr2Ys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737928447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+DvkS2LGbHPK2c81mWTuMagsQQwBmOufy4uD2JrfRTs=;
	b=t0642llkhh9YPMCYSyT54VRI3lifhUsr9rIN6AWsnS1DA2rOj5UOoRNMNq2seoa76LZS86
	pX1YgaQxuyLLx1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D85313A60;
	Sun, 26 Jan 2025 21:54:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /DrrCPyulmc1RwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 26 Jan 2025 21:54:04 +0000
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
In-reply-to: <02eefb82ddff92f3797c346033300b7d259267d6.camel@kernel.org>
References: <>, <02eefb82ddff92f3797c346033300b7d259267d6.camel@kernel.org>
Date: Mon, 27 Jan 2025 08:53:56 +1100
Message-id: <173792843626.22054.10399301406267899224@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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

On Sun, 26 Jan 2025, Jeff Layton wrote:
> On Sun, 2025-01-26 at 13:39 +1100, NeilBrown wrote:
> > On Sun, 26 Jan 2025, Jeff Layton wrote:
> > > nfsd_file_dispose_list_delayed can be called from the filecache
> > > laundrette, which is shut down after the nfsd threads are shut down and
> > > the nfsd_serv pointer is cleared. If nn->nfsd_serv is NULL then there
> > > are no threads to wake.
> > >=20
> > > Ensure that the nn->nfsd_serv pointer is non-NULL before calling
> > > svc_wake_up in nfsd_file_dispose_list_delayed. This is safe since the
> > > svc_serv is not freed until after the filecache laundrette is cancelled.
> > >=20
> > > Fixes: ffb402596147 ("nfsd: Don't leave work of closing files to a work=
 queue")
> > > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > > Closes: https://lore.kernel.org/linux-nfs/7d9f2a8aede4f7ca9935a47e1d405=
643220d7946.camel@kernel.org/
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > This is only lightly tested, but I think it will fix the bug that
> > > Salvatore reported.
> > > ---
> > >  fs/nfsd/filecache.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > index e91c164b5ea21507659904690533a19ca43b1b64..fb2a4469b7a3c077de2dd75=
0f43239b4af6d37b0 100644
> > > --- a/fs/nfsd/filecache.c
> > > +++ b/fs/nfsd/filecache.c
> > > @@ -445,11 +445,20 @@ nfsd_file_dispose_list_delayed(struct list_head *=
dispose)
> > >  						struct nfsd_file, nf_gc);
> > >  		struct nfsd_net *nn =3D net_generic(nf->nf_net, nfsd_net_id);
> > >  		struct nfsd_fcache_disposal *l =3D nn->fcache_disposal;
> > > +		struct svc_serv *serv;
> > > =20
> > >  		spin_lock(&l->lock);
> > >  		list_move_tail(&nf->nf_gc, &l->freeme);
> > >  		spin_unlock(&l->lock);
> > > -		svc_wake_up(nn->nfsd_serv);
> > > +
> > > +		/*
> > > +		 * The filecache laundrette is shut down after the
> > > +		 * nn->nfsd_serv pointer is cleared, but before the
> > > +		 * svc_serv is freed.
> > > +		 */
> > > +		serv =3D nn->nfsd_serv;
> >=20
> > I wonder if this should be READ_ONCE() to tell the compiler that we
> > could race with clearing nn->nfsd_serv.  Would the comment still be
> > needed?
> >=20
>=20
> I think we need a comment at least. The linkage between the laundrette
> and the nfsd_serv being set to NULL is very subtle. A READ_ONCE()
> doesn't convey that well, and is unnecessary here.

Why do you say "is unnecessary here" ?
If the code were
   if (nn->nfsd_serv)
            svc_wake_up(nn->nfsd_serv);
that would be wrong as nn->nfds_serv could be set to NULL between the
two.
And the C compile is allowed to load the value twice because the C memory
model declares that would have the same effect.
While I doubt it would actually change how the code is compiled, I think
we should have READ_ONCE() here (and I've been wrong before about what
the compiler will actually do).

Thanks,
NeilBrown

