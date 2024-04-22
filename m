Return-Path: <linux-nfs+bounces-2924-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAC88AD933
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Apr 2024 01:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8B41F2195A
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Apr 2024 23:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40BD446B6;
	Mon, 22 Apr 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EiOSOu2s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q5iuHFZS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EiOSOu2s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q5iuHFZS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9FC446AB
	for <linux-nfs@vger.kernel.org>; Mon, 22 Apr 2024 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713828841; cv=none; b=rfNEhhqln/lm3EkvWAmaGh8JmlAdDX08OW3ba67kn0hH2rSdYFB6FjEyuDzTpRGmqBwO34aGsrnysXELwwvrAaBgZBEDF/KauRSNC8S1BYrnoClQBHjSWEd3t6dK2qTnj8FGpM98tRBHYGdGzfMJG/ZFoknzwlCocP6xftmJgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713828841; c=relaxed/simple;
	bh=fpGgvDFcTGxOJfEDZRdvfbafIRIpc/azfYK80wkPtWg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Tof3xnS13fYQzq4KxVYIq19URUjQyHyJk7OZDIwBjRJ6gpWbhDrXhBcuRpIF9r+RIE7dXYkMarh0rL5xlLUo3tTPQJVu3/P4i5170W1y3HRh5dnFRe6crkz7naDbawYrrSSqxSrPrbbPolaLzJKuu3WrwkxRZktUqZmczCiKnOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EiOSOu2s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q5iuHFZS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EiOSOu2s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q5iuHFZS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9F6065D7E8;
	Mon, 22 Apr 2024 23:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713828835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JpRhoZUAhc9sSYX5E/g39gvezvWI69GZ8oxTSLMv8o=;
	b=EiOSOu2s019j0U1Y6PhSstlWw8vLSgtBfeaTCHjXbkwp97wNxTQlSqy4FXk0xYDDNLKYlc
	EfNc6rzGpsgJsmJRJFhZOgAhqWqNMDd/WXI8UpOQT0B3YrrfbbSBgmVBpIBCOqDkKNm44G
	xqyxk80tslzeH6jY93ndpHFiohy23iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713828835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JpRhoZUAhc9sSYX5E/g39gvezvWI69GZ8oxTSLMv8o=;
	b=Q5iuHFZSirsCcY4HlvnwmSKuhbsehLHZYP6oioL2vFQfBxbcwgDChszH4TwCFHANGGXV3P
	wgImGFwpromKLmBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EiOSOu2s;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Q5iuHFZS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713828835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JpRhoZUAhc9sSYX5E/g39gvezvWI69GZ8oxTSLMv8o=;
	b=EiOSOu2s019j0U1Y6PhSstlWw8vLSgtBfeaTCHjXbkwp97wNxTQlSqy4FXk0xYDDNLKYlc
	EfNc6rzGpsgJsmJRJFhZOgAhqWqNMDd/WXI8UpOQT0B3YrrfbbSBgmVBpIBCOqDkKNm44G
	xqyxk80tslzeH6jY93ndpHFiohy23iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713828835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0JpRhoZUAhc9sSYX5E/g39gvezvWI69GZ8oxTSLMv8o=;
	b=Q5iuHFZSirsCcY4HlvnwmSKuhbsehLHZYP6oioL2vFQfBxbcwgDChszH4TwCFHANGGXV3P
	wgImGFwpromKLmBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 967DE136ED;
	Mon, 22 Apr 2024 23:33:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PKDfDeDzJmYufgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 22 Apr 2024 23:33:52 +0000
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
Cc: "Jeff Layton" <jlayton@kernel.org>, "Olga Kornievskaia" <kolga@netapp.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Petr Vorel" <pvorel@suse.cz>, linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH] nfsd: don't fail OP_SETCLIENTID when there are lots of clients.
In-reply-to: <ZiZnbV+htcvGuGQl@tissot.1015granger.net>
References: <171375175915.7600.6526208866216039031@noble.neil.brown.name>,
 <ZiZnbV+htcvGuGQl@tissot.1015granger.net>
Date: Tue, 23 Apr 2024 09:33:46 +1000
Message-id: <171382882695.7600.8486072164212452863@noble.neil.brown.name>
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9F6065D7E8
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]

On Mon, 22 Apr 2024, Chuck Lever wrote:
> On Mon, Apr 22, 2024 at 12:09:19PM +1000, NeilBrown wrote:
> > The calculation of how many clients the nfs server can manage is only an
> > heuristic.  Triggering the laundromat to clean up old clients when we
> > have more than the heuristic limit is valid, but refusing to create new
> > clients is not.  Client creation should only fail if there really isn't
> > enough memory available.
> >=20
> > This is not known to have caused a problem is production use, but
> > testing of lots of clients reports an error and it is not clear that
> > this error is justified.
>=20
> It is justified, see 4271c2c08875 ("NFSD: limit the number of v4
> clients to 1024 per 1GB of system memory"). In cases like these,
> the recourse is to add more memory to the test system.

Does each client really need 1MB?
Obviously we don't want all memory to be used by client state....

>=20
> However, that commit claims that the client is told to retry; I
> don't expect client creation to fail outright. Can you describe the
> failure mode you see?

The failure mode is repeated client retries that never succeed.  I think
an outright failure would be preferable - it would be more clear than
memory must be added.

The server has N active clients and M courtesy clients.
Triggering reclaim when N+M exceeds a limit and M>0 makes sense.
A hard failure (NFS4ERR_RESOURCE) when N exceeds a limit makes sense.
A soft failure (NFS4ERR_DELAY) while reclaim is running makes sense.

I don't think a retry while N exceeds the limit makes sense.

Do we have a count of active vs courtesy clients?

>=20
> Meanwhile, we need to have broader and more regular testing of NFSD
> on memory-starved systems. That's a long-term project.

:-)

Thanks,
NeilBrown


>=20
>=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfsd/nfs4state.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index daf83823ba48..8a40bb6a4a67 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -2223,10 +2223,9 @@ static struct nfs4_client *alloc_client(struct xdr=
_netobj name,
> >  	struct nfs4_client *clp;
> >  	int i;
> > =20
> > -	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients) {
> > +	if (atomic_read(&nn->nfs4_client_count) >=3D nn->nfs4_max_clients)
> >  		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> > -		return NULL;
> > -	}
> > +
> >  	clp =3D kmem_cache_zalloc(client_slab, GFP_KERNEL);
> >  	if (clp =3D=3D NULL)
> >  		return NULL;
> > --=20
> > 2.44.0
> >=20
> >=20
>=20
> --=20
> Chuck Lever
>=20


