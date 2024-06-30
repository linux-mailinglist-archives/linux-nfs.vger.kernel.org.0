Return-Path: <linux-nfs+bounces-4442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291C91D41B
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC541C20853
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 21:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE64487A5;
	Sun, 30 Jun 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+T2Spna"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE182AE68
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781625; cv=none; b=XX1mspLSOaEE9Io7eegTQeTyPth3Ictd9Er67QJ4vBlNvxR9FB2bVULGKY0zqRYIeJO6EGOa2SoKbTumGr7BoOFM2sYPL0ugm3wgxBBltAX00b5CNCcalt+lvh4HCu9D/bXbfct3+uQ795qFPYgbnFrlCRd20jWhLRfyZ4ncQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781625; c=relaxed/simple;
	bh=76lmGSIs3+IrgZcj/sM6RbwFw1jNWB7oRAqoVgCglJs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPos66RwvhbZjHX4qTUktmVCzPgKFyzuTGU7MzuY/ZdiVS7SNfHdTVH2G3Sy7Q85C9HW0R5vrLHIjw6jqMfkxzAmN+qgvQbw+nUr7rNpiu85kcE/vodgYGB/rfh0eCy1dalkYpoVOtzZv3kR7Bi/Ur1d78jP1FSA4M3V32ILowE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+T2Spna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778D9C2BD10;
	Sun, 30 Jun 2024 21:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719781625;
	bh=76lmGSIs3+IrgZcj/sM6RbwFw1jNWB7oRAqoVgCglJs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O+T2SpnaFM/ushEzhfLsu8R583dbgV2y6t/HMYJsDnYC09xJ8FvdUkTK6mFa7gH9V
	 G3BcdAJbm+tCxyXLNIrIUbRCBfQCX1TDci/iUhoNPli5Vt39uwKpQqOFwJoupUhgQZ
	 6Y7gs2LsY/0tmFSwcTXCYdA/yB3zha6jdlzTiW2ND5KwKZMrozlb/X8nEpN52IgEeI
	 jtyhJqb5d+/6CbPXIp4kB+wSUExn2LcyRtYHkvmulnt+ReJpPZUSv8TcPVadZ+rKsb
	 kkEI17Mpt/PiJi4vBoAvgL7HuPK0mu4QnrsrlY+aGvWTRW4rhXwyhdu2IfAS53qXHv
	 eOhDu6974cztw==
Message-ID: <62ce1426e544778e3c035b26fe8ec7810c43e702.camel@kernel.org>
Subject: Re: [PATCH v9 13/19] nfsd: add "localio" support
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org, Anna
 Schumaker <anna@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>,
 NeilBrown <neilb@suse.de>,  snitzer@hammerspace.com
Date: Sun, 30 Jun 2024 17:07:03 -0400
In-Reply-To: <ZoG8/pVzArlbowM+@tissot.1015granger.net>
References: <20240628211105.54736-1-snitzer@kernel.org>
	 <20240628211105.54736-14-snitzer@kernel.org>
	 <ZoCIQjxougYwplsp@tissot.1015granger.net>
	 <ZoFwj0gkBf3Pr1RI@tissot.1015granger.net> <ZoG1pF_sgAUDoH-n@kernel.org>
	 <359d5b252f6f5a7eb348c79beb00a9e6594b743c.camel@kernel.org>
	 <ZoG4QOGLTy/0zsS0@tissot.1015granger.net>
	 <de0cd43fe008c32bfe6e3c983256862fb5ffb9c6.camel@kernel.org>
	 <ZoG8/pVzArlbowM+@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-06-30 at 16:15 -0400, Chuck Lever wrote:
> On Sun, Jun 30, 2024 at 03:59:58PM -0400, Jeff Layton wrote:
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
> > > > > > > nfsd_open_verified() would be simpler and/or good enough here=
. Is
> > > > > > > there a strong reason to use the file cache for locally opene=
d
> > > > > > > files? Jeff, any thoughts?
> > > > > >=20
> > > > > > > Will there be writeback ramifications for
> > > > > > > doing this? Maybe we need a comment here explaining how these=
 files
> > > > > > > are garbage collected (just an fput by the local I/O client, =
I would
> > > > > > > guess).
> > > > > >=20
> > > > > > OK, going back to this: Since right here we immediately call=
=20
> > > > > >=20
> > > > > > 	nfsd_file_put(nf);
> > > > > >=20
> > > > > > There are no writeback ramifications nor any need to comment ab=
out
> > > > > > garbage collection. But this still seems like a lot of (possibl=
y
> > > > > > unnecessary) overhead for simply obtaining a struct file.
> > > > >=20
> > > > > Easy enough change, probably best to avoid the filecache but woul=
d like
> > > > > to verify with Jeff before switching:
> > > > >=20
> > > > > diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> > > > > index 1d6508aa931e..85ebf63789fb 100644
> > > > > --- a/fs/nfsd/localio.c
> > > > > +++ b/fs/nfsd/localio.c
> > > > > @@ -197,7 +197,6 @@ int nfsd_open_local_fh(struct net *cl_nfssvc_=
net,
> > > > >         const struct cred *save_cred;
> > > > >         struct svc_rqst *rqstp;
> > > > >         struct svc_fh fh;
> > > > > -       struct nfsd_file *nf;
> > > > >         __be32 beres;
> > > > >=20
> > > > >         if (nfs_fh->size > NFS4_FHSIZE)
> > > > > @@ -235,13 +234,12 @@ int nfsd_open_local_fh(struct net *cl_nfssv=
c_net,
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
> > > > > +       status =3D nfsd_open_verified(rqstp, &fh, mayflags, pfilp=
);
> > > > >  out_fh_put:
> > > > >         fh_put(&fh);
> > > > >         nfsd_local_fakerqst_destroy(rqstp);
> > > > >=20
> > > >=20
> > > > My suggestion would be to _not_ do this. I think you do want to use=
 the
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
> >=20
> > Good point. This should be calling nfsd_file_acquire_gc(), IMO.=20
>=20
> So that goes to my point yesterday about writeback ramifications.
>=20
> If these open files linger in the file cache, then when will they
> get written back to storage and by whom? Is it going to be an nfsd
> thread writing them back as part of garbage collection?
>=20

Usually the client is issuing regular COMMITs. If that doesn't happen,
then the flusher threads should get the rest.

Side note: I don't guess COMMIT goes over the localio path yet, does
it? Maybe it should. It would be nice to not tie up an nfsd thread with
writeback.

> So, you're saying that the local I/O client will always behave like
> NFSv3 in this regard, and open/read/close, open/write/close instead
> of hanging on to the open file? That seems... suboptimal... and not
> expected for a local file. That needs to be documented in the
> LOCALIO design doc.
>=20

I imagine so, which is why I suggest using the filecache. If we get one
READ or WRITE for the file via localio, we're pretty likely to get
more. Why not amortize that file open over several operations?
=20
> I'm also concerned about local applications closing a file but
> having an open file handle linger in the file cache -- that can
> prevent other accesses to the file until the GC ejects that open
> file, as we've seen in the field.
>=20
> IMHO nfsd_file_acquire_gc() is going to have some unwanted side
> effects.
>=20

Typically, the client issues COMMIT calls when the client-side fd is
closed (for CTO). While I think we do need to be able to deal with
flushing files with dirty data that are left "hanging", that shouldn't
be the common case. Most of the time, the client is going to be issuing
regular COMMITs so that it can clean its pages.

IOW, I don't see how localio is any different than the case of normal
v3 IO in this respect.
--=20
Jeff Layton <jlayton@kernel.org>

