Return-Path: <linux-nfs+bounces-10513-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78889A5514B
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 17:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2CAA189995D
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Mar 2025 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60994241C80;
	Thu,  6 Mar 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXm5tbxM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B1A220686;
	Thu,  6 Mar 2025 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741278489; cv=none; b=O3jI98qVOqouoFAT83uG/b/UkVwF1s4jXr/N9YsptRK1s1cYZ0wrAdlUGyOmVd6pjKLAWnviDDQZyIptVQcQ5mpOyAjeZ/ETvIZe2zYxfj2SrSS9H8qiLyRb4XHBqMAJihgbXtktkN0pM/tojbuKV2CAxm8EwPkTQVLDnG1fGyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741278489; c=relaxed/simple;
	bh=vC+UtXWtIQEEiE+/DZw9GH2tEoqrQp35D7/Fi7zAK7g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u15h02HQjSyxtrrtDgdH5zz4Z9blDmUM8LyfZ+/iAs8bbH8e5ieVBs2drQX0s5bcnW3C5L0J+oDm6i+YQuDgWqPeO/ClrUK0KB+EOw4Y0MjRU9v7FtuloXW4ovOn1RcTVOzSv7spRHRBCgwWS5Z0upHpB/t9CmP+1C0RkorW1bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXm5tbxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDAAC4CEEA;
	Thu,  6 Mar 2025 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741278488;
	bh=vC+UtXWtIQEEiE+/DZw9GH2tEoqrQp35D7/Fi7zAK7g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=HXm5tbxMYV3nhjVZongn3Q61Ir1PJU5zs06IXwCdV0tXM4WHDrGnCdd9lmlXeybem
	 ywVSpzX+pAX+7C0r8AW9Lvc0BHa4KFeHS7MRbuSEQYsv3v30jlQ2xxsckL1R8piWA1
	 UOFm2mgba7c9aJRp+Wk2YfctiNt3X6LH0NdJUdxHUNpjECVjrci/pDrtn/KzDspPRV
	 LwHuxCi58aFXr8UTudEF9hUtbR6yQcyd2U7TbOV/a9z422v07hNyDljylfPXCDTe6G
	 b+PvXopwjioJDVAIRyS2IJVdFj2PskktqOQfZARYj6sR5a9iyP52rPtQUBp7vaJ6pC
	 8MeDndnY5ikOg==
Message-ID: <e3155f911895be8384b8d522738d8a8e95c8ced5.camel@kernel.org>
Subject: Re: [PATCH 3/4] nfsd: add some stub tracepoints around key vfs
 functions
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, "David S. Miller"	 <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski	 <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman	 <horms@kernel.org>
Cc: Sargun Dillon <sargun@meta.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 06 Mar 2025 11:28:06 -0500
In-Reply-To: <43efb87e-348c-4ad5-84a1-7e30479264bc@oracle.com>
References: <20250306-nfsd-tracepoints-v1-0-4405bf41b95f@kernel.org>
	 <20250306-nfsd-tracepoints-v1-3-4405bf41b95f@kernel.org>
	 <43efb87e-348c-4ad5-84a1-7e30479264bc@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-03-06 at 09:29 -0500, Chuck Lever wrote:
> On 3/6/25 7:38 AM, Jeff Layton wrote:
> > Sargun set up kprobes to add some of these tracepoints. Convert them to
> > simple static tracepoints. These are pretty sparse for now, but they
> > could be expanded in the future as needed.
>=20
> I have mixed feelings about this.
>=20
> - Probably tracepoints should replace the existing dprintk call sites.
>   dprintk is kind of useless for heavy traffic.
>=20

I'm fine with removing dprintks as we go.

> - Seems like other existing tracepoints could report most of the same
>   information. fh_verify, for example, has a tracepoint that reports
>   the file handle. There's an svc proc tracepoint, and an NFSv4 COMPOUND
>   tracepoint that can report XID and procedure.
>=20

The problem there is the lack of context. Yes, I can see that
fh_verify() got called, but on a busy server it can be hard to tell why
it got called. I see things like the fh_verify() tracepoint working in
conjunction with these new tracepoints. IOW, you could match up the
xids and see which fh_verify() was called for which operation.


If you like, I could drop the fh hash from these tracepoints, and just
print xid and net namespace?
=20
> - If the tracepoint is passed an @rqstp, it should also record the
>   nfsd namespace number.
>=20

Thanks, I'll plan to add that.

> I'd like to know more about what exactly you were hoping to extract,
> and which tracepoint(s) were most helpful for you.
>=20

Sargun, you're probably best equipped to answer this question. What's
most useful to you in these tracepoints?

>=20
> > Cc: Sargun Dillon <sargun@meta.com>
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  fs/nfsd/nfs3proc.c |  3 +++
> >  fs/nfsd/nfs4proc.c |  2 ++
> >  fs/nfsd/nfsproc.c  |  2 ++
> >  fs/nfsd/trace.h    | 35 +++++++++++++++++++++++++++++++++++
> >  fs/nfsd/vfs.c      | 26 ++++++++++++++++++++++++++
> >  5 files changed, 68 insertions(+)
> >=20
> > diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> > index 372bdcf5e07a5c835da240ecebb02e3576eb2ca6..2a56cae4c78a7ca66d56963=
7e9f0e7c0fdcfb826 100644
> > --- a/fs/nfsd/nfs3proc.c
> > +++ b/fs/nfsd/nfs3proc.c
> > @@ -14,6 +14,7 @@
> >  #include "xdr3.h"
> >  #include "vfs.h"
> >  #include "filecache.h"
> > +#include "trace.h"
> > =20
> >  #define NFSDDBG_FACILITY		NFSDDBG_PROC
> > =20
> > @@ -69,6 +70,8 @@ nfsd3_proc_getattr(struct svc_rqst *rqstp)
> >  	struct nfsd_fhandle *argp =3D rqstp->rq_argp;
> >  	struct nfsd3_attrstat *resp =3D rqstp->rq_resp;
> > =20
> > +	trace_nfsd_getattr(rqstp, &argp->fh);
> > +
> >  	dprintk("nfsd: GETATTR(3)  %s\n",
> >  		SVCFH_fmt(&argp->fh));
> > =20
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index c20f1abcb94f131b1ec898860ba2c394b22e61e1..87d241ff91920317e0122a5=
8bf0cf71c5b28d264 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -876,6 +876,8 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct nfsd4_=
compound_state *cstate,
> >  	struct nfsd4_getattr *getattr =3D &u->getattr;
> >  	__be32 status;
> > =20
> > +	trace_nfsd_getattr(rqstp, &cstate->current_fh);
> > +
> >  	status =3D fh_verify(rqstp, &cstate->current_fh, 0, NFSD_MAY_NOP);
> >  	if (status)
> >  		return status;
> > diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> > index 6dda081eb24c00b834ab0965c3a35a12115bceb7..9563372f0826b9580299144=
069f57664dbd2a079 100644
> > --- a/fs/nfsd/nfsproc.c
> > +++ b/fs/nfsd/nfsproc.c
> > @@ -54,6 +54,8 @@ nfsd_proc_getattr(struct svc_rqst *rqstp)
> >  	struct nfsd_fhandle *argp =3D rqstp->rq_argp;
> >  	struct nfsd_attrstat *resp =3D rqstp->rq_resp;
> > =20
> > +	trace_nfsd_getattr(rqstp, &argp->fh);
> > +
> >  	dprintk("nfsd: GETATTR  %s\n", SVCFH_fmt(&argp->fh));
> > =20
> >  	fh_copy(&resp->fh, &argp->fh);
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 117f7e1fd66a4838a048cc44bd5bf4dd8c6db958..d4a78fe1bab24b594b96cca=
8611c439da9ed6926 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -2337,6 +2337,41 @@ DEFINE_EVENT(nfsd_copy_async_done_class,		\
> >  DEFINE_COPY_ASYNC_DONE_EVENT(done);
> >  DEFINE_COPY_ASYNC_DONE_EVENT(cancel);
> > =20
> > +DECLARE_EVENT_CLASS(nfsd_vfs_class,
> > +	TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp),
> > +	TP_ARGS(rqstp, fhp),
> > +	TP_STRUCT__entry(
> > +		__field(u32, xid)
> > +		__field(u32, fh_hash)
> > +	),
> > +	TP_fast_assign(
> > +		__entry->xid =3D be32_to_cpu(rqstp->rq_xid);
> > +		__entry->fh_hash =3D knfsd_fh_hash(&fhp->fh_handle);
> > +	),
> > +	TP_printk("xid=3D0x%08x fh_hash=3D0x%08x",
> > +		  __entry->xid, __entry->fh_hash)
> > +);
> > +
> > +#define DEFINE_NFSD_VFS_EVENT(name)                                   =
     \
> > +	DEFINE_EVENT(nfsd_vfs_class, nfsd_##name,                           \
> > +		     TP_PROTO(struct svc_rqst *rqstp, struct svc_fh *fhp), \
> > +		     TP_ARGS(rqstp, fhp))
> > +
> > +DEFINE_NFSD_VFS_EVENT(lookup);
> > +DEFINE_NFSD_VFS_EVENT(lookup_dentry);
> > +DEFINE_NFSD_VFS_EVENT(create_locked);
> > +DEFINE_NFSD_VFS_EVENT(create);
> > +DEFINE_NFSD_VFS_EVENT(access);
> > +DEFINE_NFSD_VFS_EVENT(create_setattr);
> > +DEFINE_NFSD_VFS_EVENT(readlink);
> > +DEFINE_NFSD_VFS_EVENT(symlink);
> > +DEFINE_NFSD_VFS_EVENT(link);
> > +DEFINE_NFSD_VFS_EVENT(rename);
> > +DEFINE_NFSD_VFS_EVENT(unlink);
> > +DEFINE_NFSD_VFS_EVENT(readdir);
> > +DEFINE_NFSD_VFS_EVENT(statfs);
> > +DEFINE_NFSD_VFS_EVENT(getattr);
> > +
> >  #define show_ia_valid_flags(x)					\
> >  	__print_flags(x, "|",					\
> >  			{ ATTR_MODE, "MODE" },			\
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index d755cc87a8670c491e55194de266d999ba1b337d..772a4d32b09a4bd217a9258=
ec803c06618cf13c8 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -244,6 +244,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> >  	struct dentry		*dentry;
> >  	int			host_err;
> > =20
> > +	trace_nfsd_lookup(rqstp, fhp);
> > +
> >  	dprintk("nfsd: nfsd_lookup(fh %s, %.*s)\n", SVCFH_fmt(fhp), len,name)=
;
> > =20
> >  	dparent =3D fhp->fh_dentry;
> > @@ -313,6 +315,8 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *=
fhp, const char *name,
> >  	struct dentry		*dentry;
> >  	__be32 err;
> > =20
> > +	trace_nfsd_lookup(rqstp, fhp);
> > +
> >  	err =3D fh_verify(rqstp, fhp, S_IFDIR, NFSD_MAY_EXEC);
> >  	if (err)
> >  		return err;
> > @@ -794,6 +798,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *=
fhp, u32 *access, u32 *suppor
> >  	u32			query, result =3D 0, sresult =3D 0;
> >  	__be32			error;
> > =20
> > +	trace_nfsd_create(rqstp, fhp);
> > +
> >  	error =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP);
> >  	if (error)
> >  		goto out;
> > @@ -1401,6 +1407,8 @@ nfsd_create_setattr(struct svc_rqst *rqstp, struc=
t svc_fh *fhp,
> >  	struct iattr *iap =3D attrs->na_iattr;
> >  	__be32 status;
> > =20
> > +	trace_nfsd_create_setattr(rqstp, fhp);
> > +
> >  	/*
> >  	 * Mode has already been set by file creation.
> >  	 */
> > @@ -1467,6 +1475,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> >  	__be32		err;
> >  	int		host_err;
> > =20
> > +	trace_nfsd_create_locked(rqstp, fhp);
> > +
> >  	dentry =3D fhp->fh_dentry;
> >  	dirp =3D d_inode(dentry);
> > =20
> > @@ -1557,6 +1567,8 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh=
 *fhp,
> >  	__be32		err;
> >  	int		host_err;
> > =20
> > +	trace_nfsd_create(rqstp, fhp);
> > +
> >  	if (isdotent(fname, flen))
> >  		return nfserr_exist;
> > =20
> > @@ -1609,6 +1621,8 @@ nfsd_readlink(struct svc_rqst *rqstp, struct svc_=
fh *fhp, char *buf, int *lenp)
> >  	DEFINE_DELAYED_CALL(done);
> >  	int len;
> > =20
> > +	trace_nfsd_readlink(rqstp, fhp);
> > +
> >  	err =3D fh_verify(rqstp, fhp, S_IFLNK, NFSD_MAY_NOP);
> >  	if (unlikely(err))
> >  		return err;
> > @@ -1657,6 +1671,8 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_f=
h *fhp,
> >  	__be32		err, cerr;
> >  	int		host_err;
> > =20
> > +	trace_nfsd_symlink(rqstp, fhp);
> > +
> >  	err =3D nfserr_noent;
> >  	if (!flen || path[0] =3D=3D '\0')
> >  		goto out;
> > @@ -1725,6 +1741,8 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *=
ffhp,
> >  	__be32		err;
> >  	int		host_err;
> > =20
> > +	trace_nfsd_link(rqstp, ffhp);
> > +
> >  	err =3D fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_CREATE);
> >  	if (err)
> >  		goto out;
> > @@ -1842,6 +1860,8 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh=
 *ffhp, char *fname, int flen,
> >  	int		host_err;
> >  	bool		close_cached =3D false;
> > =20
> > +	trace_nfsd_rename(rqstp, ffhp);
> > +
> >  	err =3D fh_verify(rqstp, ffhp, S_IFDIR, NFSD_MAY_REMOVE);
> >  	if (err)
> >  		goto out;
> > @@ -2000,6 +2020,8 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, int type,
> >  	__be32		err;
> >  	int		host_err;
> > =20
> > +	trace_nfsd_unlink(rqstp, fhp);
> > +
> >  	err =3D nfserr_acces;
> >  	if (!flen || isdotent(fname, flen))
> >  		goto out;
> > @@ -2222,6 +2244,8 @@ nfsd_readdir(struct svc_rqst *rqstp, struct svc_f=
h *fhp, loff_t *offsetp,
> >  	loff_t		offset =3D *offsetp;
> >  	int             may_flags =3D NFSD_MAY_READ;
> > =20
> > +	trace_nfsd_readdir(rqstp, fhp);
> > +
> >  	err =3D nfsd_open(rqstp, fhp, S_IFDIR, may_flags, &file);
> >  	if (err)
> >  		goto out;
> > @@ -2288,6 +2312,8 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, struct kstatfs *stat, in
> >  {
> >  	__be32 err;
> > =20
> > +	trace_nfsd_statfs(rqstp, fhp);
> > +
> >  	err =3D fh_verify(rqstp, fhp, 0, NFSD_MAY_NOP | access);
> >  	if (!err) {
> >  		struct path path =3D {
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

