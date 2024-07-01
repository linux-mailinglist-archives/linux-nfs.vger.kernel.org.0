Return-Path: <linux-nfs+bounces-4486-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2D591DDB9
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42288B24007
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D306A1F949;
	Mon,  1 Jul 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZ6Nhm+k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACABD1F937
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 11:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719832881; cv=none; b=QQML49Rj/9hgpUt+ZVLTSMMdLH+V3BqOnT5lw8f+MluqDZ3sjIckXSD38BMoCMForV9TSEKh7UK8IhRphN8z1+LcuzOGHIjs1ZOKFR6BGW2Hxruvxgp489xTNHKLJRovIk8M4U9gjvRAlaPqT1aTjc0fEjCq2mDz9MJxvI5hcbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719832881; c=relaxed/simple;
	bh=am03F3nivNYDVGAbmZ+Zi1JYKdM3kVa/XPmqj6c4Q8M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=racWqEd9iSfhXka5ypcu237u+UEZe4W/U+xzbiLqW51SjVXp3/pkWKlQUw1MGyzK+ja+mno2T7kaYwRjfOt0v5Q5JvUx+VN7lilxMMMZ3WlUougZtPHDXxbsQqSZLZ7sY8Z3/T+KcYk9VuPf37fSUXXzXi6ipYBoTitofla47pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZ6Nhm+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F417C116B1;
	Mon,  1 Jul 2024 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719832881;
	bh=am03F3nivNYDVGAbmZ+Zi1JYKdM3kVa/XPmqj6c4Q8M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=CZ6Nhm+kCqQBmLXiSoAUYyPHPcxT4E9+JZcxJqOR2M0NOzbKWC4jJsVuGna/aBFsh
	 xQ7D3em4jfQI/MV4IN4KOce3EeXLwouLAvt68XfHiZ9sKvW8z//ZgBK5Vzq33EtXis
	 AFJ+Mkmp3fWBuRineXE5tt8ZwfEmdEQgQfFPpkthnk0MrPFf6OJlGVM9FpDBOjYjzK
	 pJG28Qx4bxYUUPSu1CgpRtRpFqvBFF+mvuchKY5ncW0xhdlehDhUm9Cyb5kQOSCfZS
	 8v9Lc2FEMJksN4CJ3VFitwHHAQBZloJf1NXeqvu3cPNny/gxmgmBdBunAaiWZNfaOq
	 Ryohb29LShCaA==
Message-ID: <a97c04d1166243f758ad5e3f2cc267aa9360b3f8.camel@kernel.org>
Subject: Re: [PATCH 6/6] nfsd: add nfsd_file_acquire_local().
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mike Snitzer
	 <snitzer@kernel.org>
Date: Mon, 01 Jul 2024 07:21:19 -0400
In-Reply-To: <20240701025802.22985-7-neilb@suse.de>
References: <20240701025802.22985-1-neilb@suse.de>
	 <20240701025802.22985-7-neilb@suse.de>
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

On Mon, 2024-07-01 at 12:53 +1000, NeilBrown wrote:
> nfsd_file_acquire_local() can be used to look up a file by filehandle
> without having a struct rqst.=C2=A0 This can be used by NFS LOCALIO to al=
low
> the NFS client to by the NFS protocol to directly access a file provided
> by the NFS server which is running in the same kernel.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/filecache.c | 54 ++++++++++++++++++++++++++++++++++++++++--=
---
> =C2=A0fs/nfsd/filecache.h |=C2=A0 4 ++++
> =C2=A0fs/nfsd/nfsfh.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/nfsd/nfsfh.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A04 files changed, 59 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index ad9083ca144b..87f965d2574b 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -977,7 +977,10 @@ nfsd_file_is_cached(struct inode *inode)
> =C2=A0}
> =C2=A0
> =C2=A0static __be32
> -nfsd_file_do_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +nfsd_file_do_acquire(struct svc_rqst *rqstp, struct nfsd_net *nn,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_cred *cred, int nfs_vers,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 struct auth_domain *client,
> +		=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_fh *fhp,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int may_flags, struct file *fil=
e,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 struct nfsd_file **pnf, bool want_gc)
> =C2=A0{
> @@ -991,7 +994,7 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> =C2=A0	int ret;
> =C2=A0
> =C2=A0retry:
> -	status =3D fh_verify(rqstp, fhp, S_IFREG,
> +	status =3D __fh_verify(rqstp, nn, cred, nfs_vers, client, fhp, S_IFREG,
> =C2=A0				may_flags|NFSD_MAY_OWNER_OVERRIDE);
> =C2=A0	if (status !=3D nfs_ok)
> =C2=A0		return status;
> @@ -1139,7 +1142,8 @@ __be32
> =C2=A0nfsd_file_acquire_gc(struct svc_rqst *rqstp, struct svc_fh *fhp,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int may_flags, struct nfsd_file=
 **pnf)
> =C2=A0{
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, true);
> +	return nfsd_file_do_acquire(rqstp, NULL, NULL, 0, NULL,
> +				=C2=A0=C2=A0=C2=A0 fhp, may_flags, NULL, pnf, true);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -1163,7 +1167,46 @@ __be32
> =C2=A0nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
> =C2=A0		=C2=A0 unsigned int may_flags, struct nfsd_file **pnf)
> =C2=A0{
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, NULL, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, NULL, NULL, 0, NULL, fhp,
> +				=C2=A0=C2=A0=C2=A0 may_flags, NULL, pnf, false);
> +}
> +
> +/**
> + * nfsd_file_acquire_local - Get a struct nfsd_file with an open file fo=
r localio
> + * @nn: The nfsd network namespace in which to perform a lookup
> + * @cred: the user credential with which to validate access
> + * @nfs_vers: NFS version number to assume for request
> + * @client: the auth_domain for LOCALIO lookup
> + * @fhp: the NFS filehandle of the file to be opened
> + * @may_flags: NFSD_MAY_ settings for the file
> + * @pnf: OUT: new or found "struct nfsd_file" object
> + *
> + * This file lookup interface provide access to a file given the
> + * filehandle and credential.=C2=A0 No connection-based authorisation
> + * is performed and in that way it is quite different to other
> + * file access mediated by nfsd.=C2=A0 It allows a kernel module such as=
 the NFS
> + * client to reach across network and filesystem namespaces to access
> + * a file.=C2=A0 The security implications of this should be carefully
> + * considered before use.
> + *
> + * The nfsd_file_object returned by this API is reference-counted
> + * but not garbage-collected. The object is unhashed after the
> + * final nfsd_file_put().
> + *
> + * Return values:
> + *=C2=A0=C2=A0 %nfs_ok - @pnf points to an nfsd_file with its reference
> + *=C2=A0=C2=A0 count boosted.
> + *
> + * On error, an nfsstat value in network byte order is returned.
> + */
> +__be32
> +nfsd_file_acquire_local(struct nfsd_net *nn, struct svc_cred *cred,
> +			int nfs_vers, struct auth_domain *client,
> +			struct svc_fh *fhp,
> +			unsigned int may_flags, struct nfsd_file **pnf)
> +{
> +	return nfsd_file_do_acquire(NULL, nn, cred, nfs_vers, client,
> +				=C2=A0=C2=A0=C2=A0 fhp, may_flags, NULL, pnf, false);

It still seems to me like these should be garbage-collected.

Neil, in an earlier email you mentioned that the client could hold onto
the nfsd_file reference over several operations and then put it. That
would be fine too, but I'm unclear on how the client will manage this.
Does the client have a way to keep track of the nfsd_file over several
operations to the same inode?

Even then, I still think we're probably better off just garbage
collecting thse, since it seems likely that they will end up being
reused in many cases.

> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -1189,7 +1232,8 @@ nfsd_file_acquire_opened(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
> =C2=A0			 unsigned int may_flags, struct file *file,
> =C2=A0			 struct nfsd_file **pnf)
> =C2=A0{
> -	return nfsd_file_do_acquire(rqstp, fhp, may_flags, file, pnf, false);
> +	return nfsd_file_do_acquire(rqstp, NULL, NULL, 0, NULL,
> +				=C2=A0=C2=A0=C2=A0 fhp, may_flags, file, pnf, false);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
> index c61884def906..d179dbae98e3 100644
> --- a/fs/nfsd/filecache.h
> +++ b/fs/nfsd/filecache.h
> @@ -65,5 +65,9 @@ __be32 nfsd_file_acquire(struct svc_rqst *rqstp, struct=
 svc_fh *fhp,
> =C2=A0__be32 nfsd_file_acquire_opened(struct svc_rqst *rqstp, struct svc_=
fh *fhp,
> =C2=A0		=C2=A0 unsigned int may_flags, struct file *file,
> =C2=A0		=C2=A0 struct nfsd_file **nfp);
> +__be32 nfsd_file_acquire_local(struct nfsd_net *nn, struct svc_cred *cre=
d,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int nfs_vers, struct auth_domain=
 *client,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct svc_fh *fhp,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int may_flags, struct n=
fsd_file **pnf);
> =C2=A0int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
> =C2=A0#endif /* _FS_NFSD_FILECACHE_H */
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index fb5a23060a4c..fa7e358d91ab 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -328,7 +328,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct nfsd_net *nn,
> =C2=A0 * @access is formed from the NFSD_MAY_* constants defined in
> =C2=A0 * fs/nfsd/vfs.h.
> =C2=A0 */
> -static __be32
> +__be32
> =C2=A0__fh_verify(struct svc_rqst *rqstp,
> =C2=A0	=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn, struct svc_cred *cred,
> =C2=A0	=C2=A0=C2=A0=C2=A0 int nfs_vers, struct auth_domain *client,
> diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
> index 6ebdf7ea27bf..a2d9962f1bf8 100644
> --- a/fs/nfsd/nfsfh.h
> +++ b/fs/nfsd/nfsfh.h
> @@ -214,7 +214,12 @@ extern char * SVCFH_fmt(struct svc_fh *fhp);
> =C2=A0/*
> =C2=A0 * Function prototypes
> =C2=A0 */
> +struct nfsd_net;
> =C2=A0__be32	fh_verify(struct svc_rqst *, struct svc_fh *, umode_t, int);
> +__be32	__fh_verify(struct svc_rqst *rqstp,
> +		=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn, struct svc_cred *cred,
> +		=C2=A0=C2=A0=C2=A0 int nfs_vers, struct auth_domain *client,
> +		=C2=A0=C2=A0=C2=A0 struct svc_fh *fhp, umode_t type, int access);
> =C2=A0__be32	fh_compose(struct svc_fh *, struct svc_export *, struct dent=
ry *, struct svc_fh *);
> =C2=A0__be32	fh_update(struct svc_fh *);
> =C2=A0void	fh_put(struct svc_fh *);

--=20
Jeff Layton <jlayton@kernel.org>

