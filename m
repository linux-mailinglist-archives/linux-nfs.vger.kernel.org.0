Return-Path: <linux-nfs+bounces-4451-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261C691D5C6
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 03:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A91C20831
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 01:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4D4C69;
	Mon,  1 Jul 2024 01:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ERm+Rt/N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVl3Kq39";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ERm+Rt/N";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NVl3Kq39"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC54A0F
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 01:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797376; cv=none; b=tG01nfmeGaWsFDiRnc2tkwBCA7cXAWhWs5OCS41XQtF/YM/jlL5pVmm8AHrYeiua74oeuoLL04GWUasnV00WCTbJHAVZ4HbcY2WYeffXIXuaLIRSGsqZS4XBff4ExsDv9fjOjxoJAoM4YJwRr6UqsyfmdoUjA5dTVYypKD82o0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797376; c=relaxed/simple;
	bh=YYUq9YzFtYKShLiHP8V9zsQ9/vx0j+Rz/JNsfrvzGlo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=h1R1p6DVL0rZTJCawbS8M0gupAsAFNuNpogEFYTMo88I3N7JHKWo20La01fDwACYVWnU+FugAZL99OtpMggBCvyfHTr09qVIy7FgbZws6hGZ2r6NxMQpVfTZvWzA8aYJSb53l0HuJ041QJF7j4lq/s8LiIVo/VzyklelNUPqaf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ERm+Rt/N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVl3Kq39; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ERm+Rt/N; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NVl3Kq39; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D4EE219EB;
	Mon,  1 Jul 2024 01:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719797371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jjUjmO96SRnhyFC+9/3Eulycj5E0yUvbyW+TPU/U9w=;
	b=ERm+Rt/NTYn2BBTbdRvSlfUf+tbuNs//BRTWggP7oL8/C2YGrzv1AFnyoVVnz/1GRkq4zv
	gCLtkLq43x39EbSV1eUV1uYL9YRxqvcmaAIcyDBygOE3pq+n9QOrc8TRn0Hw4dGJEtVOqM
	JpKgc/9wf56Jpb+IQuu+5tjhsnLtbEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719797371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jjUjmO96SRnhyFC+9/3Eulycj5E0yUvbyW+TPU/U9w=;
	b=NVl3Kq39k/sFNtuSoETybmftBHDSKdX49Vp598d3P8OgaFAtEtyofz4XdrrIatE/5lWcrE
	OTjXVZrQs26NMRCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719797371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jjUjmO96SRnhyFC+9/3Eulycj5E0yUvbyW+TPU/U9w=;
	b=ERm+Rt/NTYn2BBTbdRvSlfUf+tbuNs//BRTWggP7oL8/C2YGrzv1AFnyoVVnz/1GRkq4zv
	gCLtkLq43x39EbSV1eUV1uYL9YRxqvcmaAIcyDBygOE3pq+n9QOrc8TRn0Hw4dGJEtVOqM
	JpKgc/9wf56Jpb+IQuu+5tjhsnLtbEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719797371;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7jjUjmO96SRnhyFC+9/3Eulycj5E0yUvbyW+TPU/U9w=;
	b=NVl3Kq39k/sFNtuSoETybmftBHDSKdX49Vp598d3P8OgaFAtEtyofz4XdrrIatE/5lWcrE
	OTjXVZrQs26NMRCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DE571340C;
	Mon,  1 Jul 2024 01:29:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C7+KDHgGgma3GgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 01 Jul 2024 01:29:28 +0000
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
 "Mike Snitzer" <snitzer@kernel.org>, linux-nfs@vger.kernel.org,
 "Anna Schumaker" <anna@kernel.org>,
 "Trond Myklebust" <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
In-reply-to: <171978445670.16071.1689758767313847463@noble.neil.brown.name>
References: <>, <de0cd43fe008c32bfe6e3c983256862fb5ffb9c6.camel@kernel.org>,
 <171978445670.16071.1689758767313847463@noble.neil.brown.name>
Date: Mon, 01 Jul 2024 11:29:20 +1000
Message-id: <171979736048.16071.3809088390447928718@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
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
X-Spam-Score: -4.30
X-Spam-Level: 

On Mon, 01 Jul 2024, NeilBrown wrote:
> On Mon, 01 Jul 2024, Jeff Layton wrote:
> > On Sun, 2024-06-30 at 15:55 -0400, Chuck Lever wrote:
> > > On Sun, Jun 30, 2024 at 03:52:51PM -0400, Jeff Layton wrote:
> > > > On Sun, 2024-06-30 at 15:44 -0400, Mike Snitzer wrote:
> > > > > On Sun, Jun 30, 2024 at 10:49:51AM -0400, Chuck Lever wrote:
> > > > > > On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > > > > > > > +
> > > > > > > > +	/* nfs_fh -> svc_fh */
> > > > > > > > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > > > > > > > +		status =3D -EINVAL;
> > > > > > > > +		goto out;
> > > > > > > > +	}
> > > > > > > > +	fh_init(&fh, NFS4_FHSIZE);
> > > > > > > > +	fh.fh_handle.fh_size =3D nfs_fh->size;
> > > > > > > > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > > > > > > > +
> > > > > > > > +	if (fmode & FMODE_READ)
> > > > > > > > +		mayflags |=3D NFSD_MAY_READ;
> > > > > > > > +	if (fmode & FMODE_WRITE)
> > > > > > > > +		mayflags |=3D NFSD_MAY_WRITE;
> > > > > > > > +
> > > > > > > > +	beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > > > > +	if (beres) {
> > > > > > > > +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > > > > > > > +		goto out_fh_put;
> > > > > > > > +	}
> > > > > > >=20
> > > > > > > So I'm wondering whether just calling fh_verify() and then
> > > > > > > nfsd_open_verified() would be simpler and/or good enough here. =
Is
> > > > > > > there a strong reason to use the file cache for locally opened
> > > > > > > files? Jeff, any thoughts?
> > > > > >=20
> > > > > > > Will there be writeback ramifications for
> > > > > > > doing this? Maybe we need a comment here explaining how these f=
iles
> > > > > > > are garbage collected (just an fput by the local I/O client, I =
would
> > > > > > > guess).
> > > > > >=20
> > > > > > OK, going back to this: Since right here we immediately call=20
> > > > > >=20
> > > > > > 	nfsd_file_put(nf);
> > > > > >=20
> > > > > > There are no writeback ramifications nor any need to comment about
> > > > > > garbage collection. But this still seems like a lot of (possibly
> > > > > > unnecessary) overhead for simply obtaining a struct file.
> > > > >=20
> > > > > Easy enough change, probably best to avoid the filecache but would =
like
> > > > > to verify with Jeff before switching:
> > > > >=20
> > > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > > index 1d6508aa931e..85ebf63789fb 100644
> > > > > --- a/fs/nfsd/localio.c
> > > > > +++ b/fs/nfsd/localio.c
> > > > > @@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_ne=
t,
> > > > >         const struct cred *save_cred;
> > > > >         struct svc_rqst *rqstp;
> > > > >         struct svc_fh fh;
> > > > > -       struct nfsd_file *nf;
> > > > >         __be32 beres;
> > > > >=20
> > > > >         if (nfs_fh->size > NFS4_FHSIZE)
> > > > > @@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_=
net,
> > > > >         if (fmode & FMODE_WRITE)
> > > > >                 mayflags |=3D NFSD_MAY_WRITE;
> > > > >=20
> > > > > -       beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > +       beres =3D fh_verify(rqstp, &fh, S_IFREG, mayflags);
> > > > >         if (beres) {
> > > > >                 status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > > > >                 goto out_fh_put;
> > > > >         }
> > > > > -       *pfilp =3D get_file(nf->nf_file);
> > > > > -       nfsd_file_put(nf);
> > > > > +       status =3D nfsd_open_verified(rqstp, &fh, mayflags, pfilp);
> > > > >  out_fh_put:
> > > > >         fh_put(&fh);
> > > > >         nfsd_local_fakerqst_destroy(rqstp);
> > > > >=20
> > > >=20
> > > > My suggestion would be to _not_ do this. I think you do want to use t=
he
> > > > filecache (mostly for performance reasons).
> > >=20
> > > But look carefully:
> > >=20
> > >  -- we're not calling nfsd_file_acquire_gc() here
> > >=20
> > >  -- we're immediately calling nfsd_file_put() on the returned nf
> > >=20
> > > There's nothing left in the file cache when nfsd_open_local_fh()
> > > returns. Each call here will do a full file open and a full close.
> > >=20
> > >=20
> >=20
> > Good point. This should be calling nfsd_file_acquire_gc(), IMO.=20
>=20
> Or the client could do a v4 style acquire, and not call nfsd_file_put()
> until it was done with the file.  I don't see a specific problem with
> _gc, but avoiding the heuristic it implies seems best where possible.
>=20

I'm now wondering if this matters at all.
For NFSv4 the client still calls OPEN and CLOSE over the wire, so the
file will be in the cache whenever it is open so the current code is
fine.

For NFSv3 the client will only do the lookup once on the first IO
request.  The struct file is stored in a client data structure and used
subsequently without any interaction with nfsd.
So if the client opens the same file multiple times we might get extra
lookups on the server, but I'm not at all sure that justifies any
complexity.

So my current inclination is to leave this code as is.

NeilBrown

