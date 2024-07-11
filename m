Return-Path: <linux-nfs+bounces-4837-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8552992EEB5
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 20:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0332D1F229D4
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 18:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A516DEC1;
	Thu, 11 Jul 2024 18:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry/JgySD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717016DC30;
	Thu, 11 Jul 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722017; cv=none; b=mQIYn1a0vHsWnt1gtON/g2sIPqU+2Hcw/lvHpPNOGuJJoj3QVaDnMF4kRqH4+X6SrBLnDbxwXJ99v35dR8v+FTDVzQzDUMAp5NDiGeWOs4lr2vanEBQ81+gsrDo1wE2jJeYU41+nDbuCt4DUvyT1C+P+P9Ee5WqgS4dM9qeA2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722017; c=relaxed/simple;
	bh=BwtKKuGG+KAGYojkzRg+plCNMfPy+VwWCQn81e2kjlk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GXoC5NVJAUITDYP//3EyShwRkwsiyeBB59aWamN2LWFK8pkVXvKJfMhbaLvlomm8ITKkW5osoEnxx1n0/jFJgo6DzEYHi9MDd+lEETCb4UOLLOiqrP4I5G1Cr1PZyloUGeUnJpDiMSGDdhNGmwyjpyb0rI9fsQohiD+CjXarmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry/JgySD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE29C116B1;
	Thu, 11 Jul 2024 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720722016;
	bh=BwtKKuGG+KAGYojkzRg+plCNMfPy+VwWCQn81e2kjlk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ry/JgySDXIxZnii43HzeySZPabhcql3VGmTqXFqpkFc1KLH1B2Pov444C0kYZK24a
	 8EHwlxGmVOyK1DU6fTAcr5nKSqufJfrQvYtxSihVByNZikkzqzeF5INJ7CsQm4v9p1
	 0uRJkeDp9dyDXAbzOKKhnuKLE0a9KIaMilQBOVZqoIfjrDIMa43kfKnM5SYX1Sbv3r
	 UZ9nRy24Ax3yl7jv799w0BwaHKtKaBNHWF+hcMHeNax/2f/SILYYAxl2h2kyi78obm
	 naCXD9Cm1fSBWTHAaVehv2c+EVyRQJfxFQv9tpNl6lAp6c5Z6pKX2FAdKy7daNCB4V
	 Xyttby2wezCkw==
Message-ID: <0b2fe3a733119b84baf0d65c097f4d716d4c9040.camel@kernel.org>
Subject: Re: [PATCH 1/3] nfsd: fix refcount leak when failing to hash
 nfsd_file
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>, Youzhong Yang
 <youzhong@gmail.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai
 Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Linux NFS Mailing
 List <linux-nfs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Thu, 11 Jul 2024 14:20:14 -0400
In-Reply-To: <1874B388-3A15-4D06-A328-C8581F5FE896@oracle.com>
References: <20240710-nfsd-next-v1-0-21fca616ac53@kernel.org>
	 <20240710-nfsd-next-v1-1-21fca616ac53@kernel.org>
	 <CADpNCvYknMBXf+V=vBLkjOMhTFRN-3o2R9A2c5J4POuaD49kMw@mail.gmail.com>
	 <50afe4a63be26a946257c335188e230c86beb148.camel@kernel.org>
	 <1874B388-3A15-4D06-A328-C8581F5FE896@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 18:16 +0000, Chuck Lever III wrote:
>=20
>=20
> > On Jul 11, 2024, at 1:53=E2=80=AFPM, Jeff Layton <jlayton@kernel.org>
> > wrote:
> >=20
> > On Thu, 2024-07-11 at 13:05 -0400, Youzhong Yang wrote:
> > > Shouldn't we have fh_put(fhp) before 'retry'?
> > >=20
> >=20
> > A subtle question, actually...
> >=20
> > It probably wouldn't hurt to do that, but I don't think it's
> > required.
> >=20
> > The main reason we call fh_put is to force a second call to
> > nfsd_set_fh_dentry. IOW, we want to redo the lookup by filehandle
> > and
> > find the inode.
> >=20
> > In the EEXIST case, presumably we have found the inode but we raced
> > with another task in setting an nfsd_file for it in the hash.
> > That's
> > different from the case where the thing was unhashed or we got an
> > EOPENSTALE.=C2=A0 So, I think we probably don't require refinding the
> > inode
> > in that case.
> >=20
> > More pointedly, I'm not sure this particular case is actually
> > possible.
> > The entries are hashed on the inode pointer value, and we're
> > searching
> > and inserting into the hash under the i_lock.
> >=20
> > Chuck, thoughts?
>=20
> Is the question whether we want to dput() the dentry that
> is attached to the fhp ? fh_verify's API contract says:
>=20
> 310=C2=A0 * Regardless of success or failure of fh_verify(), fh_put()
> should be
> 311=C2=A0 * called on @fhp when the caller is finished with the
> filehandle.=20
>=20
> It looks like none of nfsd_file_acquire's callers do an
> fh_put() in their error flows.
>=20
> But maybe I've misunderstood the issue.
>=20

Note that this API is weird and doesn't conform to typical get/put
semantics.

The fhp is instantiated before nfsd_file_do_acquire is called, and all
of the callers that I can see do eventually call fh_put on it. fh_put
is idempotent, so there should be no harm in calling it multiple times.

My question here though was more about this EEXIST case. Should we even
bother checking for that? I don't see how it's possible.

>=20
> > > On Wed, Jul 10, 2024 at 9:06=E2=80=AFAM Jeff Layton <jlayton@kernel.o=
rg>
> > > wrote:
> > > >=20
> > > > At this point, we have a new nf that we couldn't properly
> > > > insert
> > > > into
> > > > the hashtable. Just free it before retrying, since it was never
> > > > hashed.
> > > >=20
> > > > Fixes: c6593366c0bf ("nfsd: don't kill nfsd_files because of
> > > > lease
> > > > break error")
> > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > ---
> > > > =C2=A0fs/nfsd/filecache.c | 4 +++-
> > > > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index f84913691b78..4fb5e8546831 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -1038,8 +1038,10 @@ nfsd_file_do_acquire(struct svc_rqst
> > > > *rqstp,
> > > > struct svc_fh *fhp,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (likely(ret =3D=3D 0)=
)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto open_file;
> > > >=20
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EEXIST)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EEXIST) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 nfsd_file_free(nf);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 goto retry;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nfsd_file_insert_e=
rr(rqstp, inode, may_flags,
> > > > ret);
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 status =3D nfserr_jukebo=
x;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto construction_err;
> > > >=20
> > > > --
> > > > 2.45.2
> > > >=20
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
>=20
>=20
> --
> Chuck Lever
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

