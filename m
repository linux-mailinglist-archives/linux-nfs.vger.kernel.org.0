Return-Path: <linux-nfs+bounces-4444-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEC491D433
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 23:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FBCB1F211E3
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3FC2C1BA;
	Sun, 30 Jun 2024 21:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D9mE3C0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xv+0dfHk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="D9mE3C0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xv+0dfHk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741741C6D
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719784606; cv=none; b=Z1FB7ZF0MeK5LoHPKRN3tHKyS85dtL7luLUSiNwOGyH2PVSUBbFrLdkH0u/eaakpq0YQxYmZpc4wxnmqU38u6fxf3mcj0CZEljIfeSP0BMfh6l3Uvnb6MzLB2BTxCsqRTr4lEdFkJweFvJt16ljHoJdCsM4fMB0C60XtiFUdj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719784606; c=relaxed/simple;
	bh=rkNk6d2HugvVKCqtU5CJs/3xB7Cg4amrc+8HL2YDA9g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LUZzrRLJY8mC4kmHI1fSgMnPXw7q/7gQAzjT6xS0Wpw3x0BEOPZeJ2xPcDQRxz+Hb0k/zVa1XpdtaoUN2xRCplJMJvGNL+Te90eHPp2/8eBR+aZefoa5De+1lBRdx1hKzXX0suZ0g3kjc66BAouRkeH13lwo28eDppBy2HCF0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D9mE3C0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xv+0dfHk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=D9mE3C0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xv+0dfHk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87A1A1F88F;
	Sun, 30 Jun 2024 21:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2TFdPx84QKitaV2ELvyqlwq3XweWGnKunW4Thqbxww=;
	b=D9mE3C0KL6kBi/3zy4OghpcP0EftnCXHbZbbJP3nXesB4g76muuhdD1bdY4AaBpawTN2c7
	6/FRKzLNveeVCTrpjHwuYWKgwWjphU37cdFlL5RWA/jFkOxnetwmoCzJjSi2gOMUS43yS+
	8mROI0Bzk1oclKRem1+KHu0halSUAoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2TFdPx84QKitaV2ELvyqlwq3XweWGnKunW4Thqbxww=;
	b=xv+0dfHkrihGAAhCItzFPor1ypyykliI1J8Cqe6UqOu6Kc1QoMJ1Ky9Ev3f1pIPc0BMow+
	XXWkEKvmKXuizgCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2TFdPx84QKitaV2ELvyqlwq3XweWGnKunW4Thqbxww=;
	b=D9mE3C0KL6kBi/3zy4OghpcP0EftnCXHbZbbJP3nXesB4g76muuhdD1bdY4AaBpawTN2c7
	6/FRKzLNveeVCTrpjHwuYWKgwWjphU37cdFlL5RWA/jFkOxnetwmoCzJjSi2gOMUS43yS+
	8mROI0Bzk1oclKRem1+KHu0halSUAoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p2TFdPx84QKitaV2ELvyqlwq3XweWGnKunW4Thqbxww=;
	b=xv+0dfHkrihGAAhCItzFPor1ypyykliI1J8Cqe6UqOu6Kc1QoMJ1Ky9Ev3f1pIPc0BMow+
	XXWkEKvmKXuizgCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A7AB13A7F;
	Sun, 30 Jun 2024 21:56:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q/X1BpLUgWbFZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 30 Jun 2024 21:56:34 +0000
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
In-reply-to: <62ce1426e544778e3c035b26fe8ec7810c43e702.camel@kernel.org>
References: <>, <62ce1426e544778e3c035b26fe8ec7810c43e702.camel@kernel.org>
Date: Mon, 01 Jul 2024 07:56:26 +1000
Message-id: <171978458670.16071.9602917875567248508@noble.neil.brown.name>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
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
X-Spam-Score: -4.30
X-Spam-Level: 

On Mon, 01 Jul 2024, Jeff Layton wrote:
> On Sun, 2024-06-30 at 16:15 -0400, Chuck Lever wrote:
> > On Sun, Jun 30, 2024 at 03:59:58PM -0400, Jeff Layton wrote:
> > > On Sun, 2024-06-30 at 15:55 -0400, Chuck Lever wrote:
> > > > On Sun, Jun 30, 2024 at 03:52:51PM -0400, Jeff Layton wrote:
> > > > > On Sun, 2024-06-30 at 15:44 -0400, Mike Snitzer wrote:
> > > > > > On Sun, Jun 30, 2024 at 10:49:51AM -0400, Chuck Lever wrote:
> > > > > > > On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > > > > > > > > +
> > > > > > > > > +	/* nfs_fh -> svc_fh */
> > > > > > > > > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > > > > > > > > +		status =3D -EINVAL;
> > > > > > > > > +		goto out;
> > > > > > > > > +	}
> > > > > > > > > +	fh_init(&fh, NFS4_FHSIZE);
> > > > > > > > > +	fh.fh_handle.fh_size =3D nfs_fh->size;
> > > > > > > > > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > > > > > > > > +
> > > > > > > > > +	if (fmode & FMODE_READ)
> > > > > > > > > +		mayflags |=3D NFSD_MAY_READ;
> > > > > > > > > +	if (fmode & FMODE_WRITE)
> > > > > > > > > +		mayflags |=3D NFSD_MAY_WRITE;
> > > > > > > > > +
> > > > > > > > > +	beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > > > > > +	if (beres) {
> > > > > > > > > +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > > > > > > > > +		goto out_fh_put;
> > > > > > > > > +	}
> > > > > > > >=20
> > > > > > > > So I'm wondering whether just calling fh_verify() and then
> > > > > > > > nfsd_open_verified() would be simpler and/or good enough here=
. Is
> > > > > > > > there a strong reason to use the file cache for locally opened
> > > > > > > > files? Jeff, any thoughts?
> > > > > > >=20
> > > > > > > > Will there be writeback ramifications for
> > > > > > > > doing this? Maybe we need a comment here explaining how these=
 files
> > > > > > > > are garbage collected (just an fput by the local I/O client, =
I would
> > > > > > > > guess).
> > > > > > >=20
> > > > > > > OK, going back to this: Since right here we immediately call=20
> > > > > > >=20
> > > > > > > 	nfsd_file_put(nf);
> > > > > > >=20
> > > > > > > There are no writeback ramifications nor any need to comment ab=
out
> > > > > > > garbage collection. But this still seems like a lot of (possibly
> > > > > > > unnecessary) overhead for simply obtaining a struct file.
> > > > > >=20
> > > > > > Easy enough change, probably best to avoid the filecache but woul=
d like
> > > > > > to verify with Jeff before switching:
> > > > > >=20
> > > > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > > > index 1d6508aa931e..85ebf63789fb 100644
> > > > > > --- a/fs/nfsd/localio.c
> > > > > > +++ b/fs/nfsd/localio.c
> > > > > > @@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_=
net,
> > > > > >         const struct cred *save_cred;
> > > > > >         struct svc_rqst *rqstp;
> > > > > >         struct svc_fh fh;
> > > > > > -       struct nfsd_file *nf;
> > > > > >         __be32 beres;
> > > > > >=20
> > > > > >         if (nfs_fh->size > NFS4_FHSIZE)
> > > > > > @@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssv=
c_net,
> > > > > >         if (fmode & FMODE_WRITE)
> > > > > >                 mayflags |=3D NFSD_MAY_WRITE;
> > > > > >=20
> > > > > > -       beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > > +       beres =3D fh_verify(rqstp, &fh, S_IFREG, mayflags);
> > > > > >         if (beres) {
> > > > > >                 status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > > > > >                 goto out_fh_put;
> > > > > >         }
> > > > > > -       *pfilp =3D get_file(nf->nf_file);
> > > > > > -       nfsd_file_put(nf);
> > > > > > +       status =3D nfsd_open_verified(rqstp, &fh, mayflags, pfilp=
);
> > > > > >  out_fh_put:
> > > > > >         fh_put(&fh);
> > > > > >         nfsd_local_fakerqst_destroy(rqstp);
> > > > > >=20
> > > > >=20
> > > > > My suggestion would be to _not_ do this. I think you do want to use=
 the
> > > > > filecache (mostly for performance reasons).
> > > >=20
> > > > But look carefully:
> > > >=20
> > > >  -- we're not calling nfsd_file_acquire_gc() here
> > > >=20
> > > >  -- we're immediately calling nfsd_file_put() on the returned nf
> > > >=20
> > > > There's nothing left in the file cache when nfsd_open_local_fh()
> > > > returns. Each call here will do a full file open and a full close.
> > >=20
> > > Good point. This should be calling nfsd_file_acquire_gc(), IMO.=20
> >=20
> > So that goes to my point yesterday about writeback ramifications.
> >=20
> > If these open files linger in the file cache, then when will they
> > get written back to storage and by whom? Is it going to be an nfsd
> > thread writing them back as part of garbage collection?
> >=20
>=20
> Usually the client is issuing regular COMMITs. If that doesn't happen,
> then the flusher threads should get the rest.
>=20
> Side note: I don't guess COMMIT goes over the localio path yet, does
> it? Maybe it should. It would be nice to not tie up an nfsd thread with
> writeback.

The documentation certainly claims that COMMIT uses the localio path.  I
haven't double checked the code but I'd be very surprised if it didn't.

NeilBrown


>=20
> > So, you're saying that the local I/O client will always behave like
> > NFSv3 in this regard, and open/read/close, open/write/close instead
> > of hanging on to the open file? That seems... suboptimal... and not
> > expected for a local file. That needs to be documented in the
> > LOCALIO design doc.
> >=20
>=20
> I imagine so, which is why I suggest using the filecache. If we get one
> READ or WRITE for the file via localio, we're pretty likely to get
> more. Why not amortize that file open over several operations?
> =20
> > I'm also concerned about local applications closing a file but
> > having an open file handle linger in the file cache -- that can
> > prevent other accesses to the file until the GC ejects that open
> > file, as we've seen in the field.
> >=20
> > IMHO nfsd_file_acquire_gc() is going to have some unwanted side
> > effects.
> >=20
>=20
> Typically, the client issues COMMIT calls when the client-side fd is
> closed (for CTO). While I think we do need to be able to deal with
> flushing files with dirty data that are left "hanging", that shouldn't
> be the common case. Most of the time, the client is going to be issuing
> regular COMMITs so that it can clean its pages.
>=20
> IOW, I don't see how localio is any different than the case of normal
> v3 IO in this respect.
> --=20
> Jeff Layton <jlayton@kernel.org>
>=20


