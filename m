Return-Path: <linux-nfs+bounces-7186-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F394C99F5E0
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 20:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2279D1C21283
	for <lists+linux-nfs@lfdr.de>; Tue, 15 Oct 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5872036ED;
	Tue, 15 Oct 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBJmpaKT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0822036E2;
	Tue, 15 Oct 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017732; cv=none; b=Do9I1MNULB6K404HSwC8YfkoAIOOHCLgezqISlWPG3aYjQARhJA76+VMw+oSHgMyQZD/HWt10rEiKY44sS0VrxcVZ23n+HSBFQDVxAB1dfZQxwbc0P0BNq/yIEpJeJ6gY4fzmvll7klDCQOFAm+WlabSD2PHvftqL7nALuL+/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017732; c=relaxed/simple;
	bh=topu4CucnY26+98rvpr6B1++4mRDeJMpDEPo/n8m79Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyIC9tMCeC916iPvifjNptlqxuw1ix+mnlt9GMInNz+W7yJZzDqIuWabfV3AwTeG6lpJn9XbFiJi1oxK0lAYs6n/OSDcBDK+aXbfD1dHB1bUCnH1+BlbIBG6scQY7SDkUjMgvYUlUE6kDXNCvL97kptqBrzE6ZDbyqCJMaw5Quw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBJmpaKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A688C4CEC6;
	Tue, 15 Oct 2024 18:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729017732;
	bh=topu4CucnY26+98rvpr6B1++4mRDeJMpDEPo/n8m79Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HBJmpaKTmGbx1F0U+2F/mFBoxa93vHz9iMDZY6bTqXWgFfLiXAjSpRQmnjT3+k84q
	 T4ZgRKXUkow2lC/mwSzvbqw2j6h/SJ+auus7+ZHzHwiT/IHZUFuIxl3ZqE2WQuwvp7
	 rS8qsNTfi5jhWrnam9+BCfnBrTzwESvmUC2UuX7KYpJNqGndILaw/bWRqYpoY5qLi0
	 O5dA+9m4hCwPOoGY2kTZls/mcdjw2IK8BToxnz/QAPAW9rZSZC3qV+o27BYBL82mnJ
	 4uv3jxIvWJsww93C3e/ecM54eB9uJ6JjkPkxGLJFhQ7SHQNiRboivk/eAcAAEaW+7R
	 bZN78kBr0OBcA==
Message-ID: <a70e34202c13ef2ac69f04a153268950b485781a.camel@kernel.org>
Subject: Re: [PATCH 1/6] nfsd: drop inode parameter from
 nfsd4_change_attribute()
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <okorniev@redhat.com>, Dai
 Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Jonathan Corbet
 <corbet@lwn.net>,  Trond Myklebust <trondmy@kernel.org>, Anna Schumaker
 <anna@kernel.org>, Thomas Haynes <loghyr@gmail.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org
Date: Tue, 15 Oct 2024 14:42:10 -0400
In-Reply-To: <Zw60mgZaLZtGWWil@tissot.1015granger.net>
References: <20241014-delstid-v1-0-7ce8a2f4dd24@kernel.org>
	 <20241014-delstid-v1-1-7ce8a2f4dd24@kernel.org>
	 <Zw60mgZaLZtGWWil@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-10-15 at 14:29 -0400, Chuck Lever wrote:
> Hey Jeff -
>=20
> On Mon, Oct 14, 2024 at 03:26:49PM -0400, Jeff Layton wrote:
> > Fix up nfs4_delegation_stat() to fetch STATX_MODE,
>=20
> The patch description isn't clear about why this change is needed.
> After reading through the other patches, I'm not sure I'm any more
> enlightened about it ;-)
>=20

My original thinking was that this patch was just a cleanup and
simplification, but now that I look, I think the inode we were passing
to this function in nfs4_open_delegation was wrong and that could throw
off the result in some cases.

Maybe we should add a Fixes: tag for this:

    bf92e5008b17 nfsd: fix initial getattr on write delegation

...since that should have fixed this call as well.

>=20
> > and then drop the
> > inode parameter from nfsd4_change_attribute(), since it's no longer
> > needed.
>=20
> Since nfsd4_change_attribute() expects @stat to be filled in by the
> caller, it needs a kdoc-style comment that documents that part of
> the API contract.
>=20

Agreed. It needs STATX_MODE and STATX_CTIME. It can also make use of
STATX_CHANGE_COOKIE if present.

> I can add one when applying this patch, unless you would like to
> resend this one or send me something to squash into this change.
>=20

That sounds great. A kdoc comment over that is a good idea.

>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs4state.c |  5 ++---
> >  fs/nfsd/nfs4xdr.c   |  2 +-
> >  fs/nfsd/nfsfh.c     | 11 ++++-------
> >  fs/nfsd/nfsfh.h     |  3 +--
> >  4 files changed, 8 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> > index d753926db09eedf629fc3e0938f10b1a6fdb0245..2961a277a79c1f4cdb8c29a=
7c19abcb3305b61a1 100644
> > --- a/fs/nfsd/nfs4state.c
> > +++ b/fs/nfsd/nfs4state.c
> > @@ -5953,7 +5953,7 @@ nfs4_delegation_stat(struct nfs4_delegation *dp, =
struct svc_fh *currentfh,
> >  	path.dentry =3D file_dentry(nf->nf_file);
> > =20
> >  	rc =3D vfs_getattr(&path, stat,
> > -			 (STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> > +			 (STATX_MODE | STATX_SIZE | STATX_CTIME | STATX_CHANGE_COOKIE),
> >  			 AT_STATX_SYNC_AS_STAT);
> > =20
> >  	nfsd_file_put(nf);
> > @@ -6037,8 +6037,7 @@ nfs4_open_delegation(struct nfsd4_open *open, str=
uct nfs4_ol_stateid *stp,
> >  		}
> >  		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_WRITE;
> >  		dp->dl_cb_fattr.ncf_cur_fsize =3D stat.size;
> > -		dp->dl_cb_fattr.ncf_initial_cinfo =3D
> > -			nfsd4_change_attribute(&stat, d_inode(currentfh->fh_dentry));
> > +		dp->dl_cb_fattr.ncf_initial_cinfo =3D nfsd4_change_attribute(&stat);
> >  		trace_nfsd_deleg_write(&dp->dl_stid.sc_stateid);
> >  	} else {
> >  		open->op_delegate_type =3D NFS4_OPEN_DELEGATE_READ;
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 6286ad2afa069f5274ffa352209b7d3c8c577dac..da7ec663da7326ad5c68a9c=
738b12d09cfcdc65a 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3621,7 +3621,7 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struc=
t xdr_stream *xdr,
> >  		args.change_attr =3D ncf->ncf_initial_cinfo;
> >  		nfs4_put_stid(&dp->dl_stid);
> >  	} else {
> > -		args.change_attr =3D nfsd4_change_attribute(&args.stat, d_inode(dent=
ry));
> > +		args.change_attr =3D nfsd4_change_attribute(&args.stat);
> >  	}
> > =20
> >  	if (err)
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 4c5deea0e9535f2b197aa6ca1786d61730d53c44..453b7b52317d538971ce41f=
7e0492e5ab28b236d 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -670,20 +670,18 @@ fh_update(struct svc_fh *fhp)
> >  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp)
> >  {
> >  	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
> > -	struct inode *inode;
> >  	struct kstat stat;
> >  	__be32 err;
> > =20
> >  	if (fhp->fh_no_wcc || fhp->fh_pre_saved)
> >  		return nfs_ok;
> > =20
> > -	inode =3D d_inode(fhp->fh_dentry);
> >  	err =3D fh_getattr(fhp, &stat);
> >  	if (err)
> >  		return err;
> > =20
> >  	if (v4)
> > -		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat, inode);
> > +		fhp->fh_pre_change =3D nfsd4_change_attribute(&stat);
> > =20
> >  	fhp->fh_pre_mtime =3D stat.mtime;
> >  	fhp->fh_pre_ctime =3D stat.ctime;
> > @@ -700,7 +698,6 @@ __be32 __must_check fh_fill_pre_attrs(struct svc_fh=
 *fhp)
> >  __be32 fh_fill_post_attrs(struct svc_fh *fhp)
> >  {
> >  	bool v4 =3D (fhp->fh_maxsize =3D=3D NFS4_FHSIZE);
> > -	struct inode *inode =3D d_inode(fhp->fh_dentry);
> >  	__be32 err;
> > =20
> >  	if (fhp->fh_no_wcc)
> > @@ -716,7 +713,7 @@ __be32 fh_fill_post_attrs(struct svc_fh *fhp)
> >  	fhp->fh_post_saved =3D true;
> >  	if (v4)
> >  		fhp->fh_post_change =3D
> > -			nfsd4_change_attribute(&fhp->fh_post_attr, inode);
> > +			nfsd4_change_attribute(&fhp->fh_post_attr);
> >  	return nfs_ok;
> >  }
> > =20
> > @@ -824,13 +821,13 @@ enum fsid_source fsid_source(const struct svc_fh =
*fhp)
> >   * assume that the new change attr is always logged to stable storage =
in some
> >   * fashion before the results can be seen.
> >   */
> > -u64 nfsd4_change_attribute(const struct kstat *stat, const struct inod=
e *inode)
> > +u64 nfsd4_change_attribute(const struct kstat *stat)
> >  {
> >  	u64 chattr;
> > =20
> >  	if (stat->result_mask & STATX_CHANGE_COOKIE) {
> >  		chattr =3D stat->change_cookie;
> > -		if (S_ISREG(inode->i_mode) &&
> > +		if (S_ISREG(stat->mode) &&
> >  		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
> >  			chattr +=3D (u64)stat->ctime.tv_sec << 30;
> >  			chattr +=3D stat->ctime.tv_nsec;
> > diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> > index 5b7394801dc4270dbd5236f3e2f2237130c73dad..876152a91f122f83fb94ffd=
fb0eedf8fca56a20c 100644
> > --- a/fs/nfsd/nfsfh.h
> > +++ b/fs/nfsd/nfsfh.h
> > @@ -297,8 +297,7 @@ static inline void fh_clear_pre_post_attrs(struct s=
vc_fh *fhp)
> >  	fhp->fh_pre_saved =3D false;
> >  }
> > =20
> > -u64 nfsd4_change_attribute(const struct kstat *stat,
> > -			   const struct inode *inode);
> > +u64 nfsd4_change_attribute(const struct kstat *stat);
> >  __be32 __must_check fh_fill_pre_attrs(struct svc_fh *fhp);
> >  __be32 fh_fill_post_attrs(struct svc_fh *fhp);
> >  __be32 __must_check fh_fill_both_attrs(struct svc_fh *fhp);
> >=20
> > --=20
> > 2.47.0
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

