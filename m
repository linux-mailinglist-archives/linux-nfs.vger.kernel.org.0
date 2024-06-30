Return-Path: <linux-nfs+bounces-4443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CCD91D431
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 23:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679771C2074D
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B255441C6D;
	Sun, 30 Jun 2024 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q8UeJCmG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZSJnRMzP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q8UeJCmG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZSJnRMzP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08ADF2C1BA
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 21:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719784473; cv=none; b=ixxqIkgKzgS3/jwv0yDUHnGK80SonLDTh8lR8lu1i1I+CpEFCVoopVSql/25gTIJ4C110rBSn3ff09WjjUicKDbCtEg9SbcphhLL6/2OgxqnS47klVaAOZT5NVaaZxhJD1jA/C+KjnO72NCAAZONxbEMek5HydY33btK9oVu/U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719784473; c=relaxed/simple;
	bh=ILqy/jNmJGY2wkRp69J1H03r12LcH+E1sKaDtipk13g=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Mj6y+ma5jf/xgAYUSp/F17fCbYmjBXaYXyCkncz7FsqJMsNIVRbLDziauDCCqlsHxfB3yg2645GwHTS8LNUUo7IvbEyRf34HnRZDdlx4uwr94ohDLsj8RBtaZXfDunAvO3nisiv2G7KSYheeWKVj4BUGmC/kK2Nh+46NNiHKqgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q8UeJCmG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZSJnRMzP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q8UeJCmG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZSJnRMzP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E5B8219D3;
	Sun, 30 Jun 2024 21:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tobACaXBBtz+vyiG+2ARYHepDnQPdA2XNgyvdE3k54c=;
	b=q8UeJCmG1K/JHwYI24+GdCm4riGJ6pF/Avpo9cBb9O6LgXGuYAEMLDzim0yjY8bbVhfxI5
	tqM2quYUbLy1VekO5MUc7basrETllg88ras5Ffc1gzke/V80O2fbgqitGFGD5MnB+REfLH
	cfPeGDE/0EX5/jWP+tMlNsvJ/fAbK+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tobACaXBBtz+vyiG+2ARYHepDnQPdA2XNgyvdE3k54c=;
	b=ZSJnRMzPUcuZsmeihNbfVE+XMyZhxWcXWAfbClWeQBPOyktrLRBuy9/kBDGUjb66kQRKXJ
	JH+wtqvdbHEETQBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719784469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tobACaXBBtz+vyiG+2ARYHepDnQPdA2XNgyvdE3k54c=;
	b=q8UeJCmG1K/JHwYI24+GdCm4riGJ6pF/Avpo9cBb9O6LgXGuYAEMLDzim0yjY8bbVhfxI5
	tqM2quYUbLy1VekO5MUc7basrETllg88ras5Ffc1gzke/V80O2fbgqitGFGD5MnB+REfLH
	cfPeGDE/0EX5/jWP+tMlNsvJ/fAbK+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719784469;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tobACaXBBtz+vyiG+2ARYHepDnQPdA2XNgyvdE3k54c=;
	b=ZSJnRMzPUcuZsmeihNbfVE+XMyZhxWcXWAfbClWeQBPOyktrLRBuy9/kBDGUjb66kQRKXJ
	JH+wtqvdbHEETQBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16D6C13A7F;
	Sun, 30 Jun 2024 21:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M3IRKhHUgWZWZwAAD6G6ig
	(envelope-from <neilb@suse.de>); Sun, 30 Jun 2024 21:54:25 +0000
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
In-reply-to: <de0cd43fe008c32bfe6e3c983256862fb5ffb9c6.camel@kernel.org>
References: <>, <de0cd43fe008c32bfe6e3c983256862fb5ffb9c6.camel@kernel.org>
Date: Mon, 01 Jul 2024 07:54:16 +1000
Message-id: <171978445670.16071.1689758767313847463@noble.neil.brown.name>
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
> On Sun, 2024-06-30 at 15:55 -0400, Chuck Lever wrote:
> > On Sun, Jun 30, 2024 at 03:52:51PM -0400, Jeff Layton wrote:
> > > On Sun, 2024-06-30 at 15:44 -0400, Mike Snitzer wrote:
> > > > On Sun, Jun 30, 2024 at 10:49:51AM -0400, Chuck Lever wrote:
> > > > > On Sat, Jun 29, 2024 at 06:18:42PM -0400, Chuck Lever wrote:
> > > > > > > +
> > > > > > > +	/* nfs_fh -> svc_fh */
> > > > > > > +	if (nfs_fh->size > NFS4_FHSIZE) {
> > > > > > > +		status =3D -EINVAL;
> > > > > > > +		goto out;
> > > > > > > +	}
> > > > > > > +	fh_init(&fh, NFS4_FHSIZE);
> > > > > > > +	fh.fh_handle.fh_size =3D nfs_fh->size;
> > > > > > > +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> > > > > > > +
> > > > > > > +	if (fmode & FMODE_READ)
> > > > > > > +		mayflags |=3D NFSD_MAY_READ;
> > > > > > > +	if (fmode & FMODE_WRITE)
> > > > > > > +		mayflags |=3D NFSD_MAY_WRITE;
> > > > > > > +
> > > > > > > +	beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > > > > +	if (beres) {
> > > > > > > +		status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > > > > > > +		goto out_fh_put;
> > > > > > > +	}
> > > > > >=20
> > > > > > So I'm wondering whether just calling fh_verify() and then
> > > > > > nfsd_open_verified() would be simpler and/or good enough here. Is
> > > > > > there a strong reason to use the file cache for locally opened
> > > > > > files? Jeff, any thoughts?
> > > > >=20
> > > > > > Will there be writeback ramifications for
> > > > > > doing this? Maybe we need a comment here explaining how these fil=
es
> > > > > > are garbage collected (just an fput by the local I/O client, I wo=
uld
> > > > > > guess).
> > > > >=20
> > > > > OK, going back to this: Since right here we immediately call=20
> > > > >=20
> > > > > 	nfsd_file_put(nf);
> > > > >=20
> > > > > There are no writeback ramifications nor any need to comment about
> > > > > garbage collection. But this still seems like a lot of (possibly
> > > > > unnecessary) overhead for simply obtaining a struct file.
> > > >=20
> > > > Easy enough change, probably best to avoid the filecache but would li=
ke
> > > > to verify with Jeff before switching:
> > > >=20
> > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > index 1d6508aa931e..85ebf63789fb 100644
> > > > --- a/fs/nfsd/localio.c
> > > > +++ b/fs/nfsd/localio.c
> > > > @@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_net,
> > > >         const struct cred *save_cred;
> > > >         struct svc_rqst *rqstp;
> > > >         struct svc_fh fh;
> > > > -       struct nfsd_file *nf;
> > > >         __be32 beres;
> > > >=20
> > > >         if (nfs_fh->size > NFS4_FHSIZE)
> > > > @@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_ne=
t,
> > > >         if (fmode & FMODE_WRITE)
> > > >                 mayflags |=3D NFSD_MAY_WRITE;
> > > >=20
> > > > -       beres =3D nfsd_file_acquire(rqstp, &fh, mayflags, &nf);
> > > > +       beres =3D fh_verify(rqstp, &fh, S_IFREG, mayflags);
> > > >         if (beres) {
> > > >                 status =3D nfs_stat_to_errno(be32_to_cpu(beres));
> > > >                 goto out_fh_put;
> > > >         }
> > > > -       *pfilp =3D get_file(nf->nf_file);
> > > > -       nfsd_file_put(nf);
> > > > +       status =3D nfsd_open_verified(rqstp, &fh, mayflags, pfilp);
> > > >  out_fh_put:
> > > >         fh_put(&fh);
> > > >         nfsd_local_fakerqst_destroy(rqstp);
> > > >=20
> > >=20
> > > My suggestion would be to _not_ do this. I think you do want to use the
> > > filecache (mostly for performance reasons).
> >=20
> > But look carefully:
> >=20
> >  -- we're not calling nfsd_file_acquire_gc() here
> >=20
> >  -- we're immediately calling nfsd_file_put() on the returned nf
> >=20
> > There's nothing left in the file cache when nfsd_open_local_fh()
> > returns. Each call here will do a full file open and a full close.
> >=20
> >=20
>=20
> Good point. This should be calling nfsd_file_acquire_gc(), IMO.=20

Or the client could do a v4 style acquire, and not call nfsd_file_put()
until it was done with the file.  I don't see a specific problem with
_gc, but avoiding the heuristic it implies seems best where possible.

NeilBrown

