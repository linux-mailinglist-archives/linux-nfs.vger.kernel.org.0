Return-Path: <linux-nfs+bounces-13221-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB2B0FB33
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 21:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8F1B1CC1CE3
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060AF219A9B;
	Wed, 23 Jul 2025 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8C5cb+h"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D021E5B63
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753300577; cv=none; b=TqM2FcTNhmfy/2zSDqj+xQ/dOTgqB3OdJvEp0jKjWUAKKvV3Kao/hIT2jo2lBGze5XxzXcJaFT9TMVUfTPNt5U2st/sFOx41xr2uD5eNyxRCwfNkONcSpsxkvdGe8w0MCLffxg+nFgmzR9Wt1mmcJigGdGbdVp/64K1Qeq7oT24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753300577; c=relaxed/simple;
	bh=ikcQM9chvdO+Xm5iOcK6Fzci6gioylM1TtvCQJmbpQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVuU4B7TnMnREjpHo3un2fem5Mls5pY/9aCYHoZd0ZFcm2nzd7UkpH3ObY8npwO8FUEi24GMvfhbXO8jIM4ID5wjk40Kv+JWkTOKaai4a5vocvPfm8MmdBo0rqE5d5ppmjJGZGEMg35x/O6hILGGZhMu02xV0oIzj44/yxZTFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8C5cb+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A96FC4CEE7;
	Wed, 23 Jul 2025 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753300577;
	bh=ikcQM9chvdO+Xm5iOcK6Fzci6gioylM1TtvCQJmbpQQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j8C5cb+hnqNDXV7MIPhxoPxKBU5+BracLTOZKPDAle+p6Vl9f4JRcsuLEpoFpovzG
	 1nOHY72mwXBciaXJvJ3BFR45efyfPaPJzJ4Ct4eUvA1MqZHSEMlFzrSVFqrOHSgXMs
	 pueq9apJ5hwlvGYeqCxZXazRkxs3+HVZVz1yx4pxOREdJGI97uH0LBSBho3q7L0CpH
	 sohryt1pSzAiyYjJnnvsX7UnubbXTm+n+ns1ZD2QRZTPCKuko/Rr7SESpCBFKbDa+q
	 Mg6DvXY27cytyaPO6K12SPytVPPBtTvep1l/QRPJzJSaieeWczEZfR/hs6Y5v0Fww+
	 KmlG6UqPyDFew==
Message-ID: <00b0b5cffec55c28c95441107b55fcd16ef73297.camel@kernel.org>
Subject: Re: [PATCH v4 1/5] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
From: Jeff Layton <jlayton@kernel.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Date: Wed, 23 Jul 2025 15:56:15 -0400
In-Reply-To: <aIE7ezLZSNVCJgS4@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
	 <20250723154351.59042-2-snitzer@kernel.org>
	 <41640810d384003d1e5ac5c9833d44fab7f101ab.camel@kernel.org>
	 <aIEymBV9tIynQIE9@kernel.org> <aIE7ezLZSNVCJgS4@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 15:43 -0400, Mike Snitzer wrote:
> On Wed, Jul 23, 2025 at 03:06:00PM -0400, Mike Snitzer wrote:
> > On Wed, Jul 23, 2025 at 02:58:19PM -0400, Jeff Layton wrote:
> > > On Wed, 2025-07-23 at 11:43 -0400, Mike Snitzer wrote:
> > > > Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
> > > > alignment attributes from underlying filesystem in associated
> > > > nfsd_file.  This is done when the nfsd_file is first opened for
> > > > a regular file.
> > > >=20
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > ---
> > > >  fs/nfsd/filecache.c | 32 ++++++++++++++++++++++++++++++++
> > > >  fs/nfsd/filecache.h |  4 ++++
> > > >  fs/nfsd/nfsfh.c     |  4 ++++
> > > >  3 files changed, 40 insertions(+)
> > > >=20
> > > > diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> > > > index 8581c131338b..5447dba6c5da 100644
> > > > --- a/fs/nfsd/filecache.c
> > > > +++ b/fs/nfsd/filecache.c
> > > > @@ -231,6 +231,9 @@ nfsd_file_alloc(struct net *net, struct inode *=
inode, unsigned char need,
> > > >  	refcount_set(&nf->nf_ref, 1);
> > > >  	nf->nf_may =3D need;
> > > >  	nf->nf_mark =3D NULL;
> > > > +	nf->nf_dio_mem_align =3D 0;
> > > > +	nf->nf_dio_offset_align =3D 0;
> > > > +	nf->nf_dio_read_offset_align =3D 0;
> > > >  	return nf;
> > > >  }
> > > > =20
> > > > @@ -1048,6 +1051,33 @@ nfsd_file_is_cached(struct inode *inode)
> > > >  	return ret;
> > > >  }
> > > > =20
> > > > +static __be32
> > > > +nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
> > > > +{
> > > > +	struct inode *inode =3D file_inode(nf->nf_file);
> > > > +	struct kstat stat;
> > > > +	__be32 status;
> > > > +
> > > > +	/* Currently only need to get DIO alignment info for regular file=
s */
> > > > +	if (!S_ISREG(inode->i_mode))
> > > > +		return nfs_ok;
> > > > +
> > > > +	status =3D fh_getattr(fhp, &stat);
> > > > +	if (status !=3D nfs_ok)
> > > > +		return status;
> > > > +
> > > > +	if (stat.result_mask & STATX_DIOALIGN) {
> > > > +		nf->nf_dio_mem_align =3D stat.dio_mem_align;
> > > > +		nf->nf_dio_offset_align =3D stat.dio_offset_align;
> > > > +	}
> > > > +	if (stat.result_mask & STATX_DIO_READ_ALIGN)
> > > > +		nf->nf_dio_read_offset_align =3D stat.dio_read_offset_align;
> > > > +	else
> > > > +		nf->nf_dio_read_offset_align =3D nf->nf_dio_offset_align;
> > > > +
> > > > +	return status;
> > > > +}
> > > > +
> > > >  static __be32
> > > >  nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
> > > >  		     struct svc_cred *cred,
> > > > @@ -1166,6 +1196,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, =
struct net *net,
> > > >  			}
> > > >  			status =3D nfserrno(ret);
> > > >  			trace_nfsd_file_open(nf, status);
> > > > +			if (status =3D=3D nfs_ok)
> > > > +				status =3D nfsd_file_getattr(fhp, nf);
> > >=20
> > >=20
> > > Doing a getattr alongside every open could be expensive in some
> > > configurations (like reexported NFS). We may want to skip doing this
> > > getattr this if O_DIRECT isn't is use. Is that possible?
> >=20
> > Good point, yes, should be easy enough.  Will depend on the debugfs
> > knobs, so will tack a patch on at the end.
>=20
> What is the best way to check for NFSD reexporting NFS?

> I've done stuff like that as a side-effect of setting/checking a
> particular flag, e.g. commit 5cca2483b9fd ("nfsd: disallow file
> locking and delegations for NFSv4 reexport")
>=20
> But not immediately seeing a more generic way to do the check...
>=20

I don't think there is a reliable method, and we probably wouldn't want
to just limit this to NFS. Other filesystems might have similar
limitations (e.g. Ceph or Lustre).

I'd probably just base this on whether support is enabled in debugfs.
If it is, then do the getattr. If that slows down reexports then we can
figure out what to do then. If and when we get to converting this to an
export option, we may need to do something more elaborate, but I
wouldn't bother for now.
--=20
Jeff Layton <jlayton@kernel.org>

