Return-Path: <linux-nfs+bounces-4484-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB76391DD65
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 13:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EED631C21E81
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 11:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338EA7BB06;
	Mon,  1 Jul 2024 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwG72G1C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E87579B7E
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831758; cv=none; b=a+ISVPLLPbM5gBt9oAUqRzp16xe+9PT7cdrDTFTSlZ/HbqulpiqBJxz8HdIHGfkAJSGSIENpHtwhTzmfr8hyE6dJeRWGHbEQkL7RcQx5hS6gP37/scL54HKs4osVwmOn8wzjwAlkduH6gxPApkGZs/GsAJMxVAW2pkWjmtKd7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831758; c=relaxed/simple;
	bh=BFPfDZDRnlSGD4CqQUX6RHGCQbZo5jRDq68j/0XvWvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fSzT8rYuS2gEsnuwpjWWCPPQWKwurTKoPF72u3UYIVwH21PynrjKvde2BmEzGF9QllhzRY2oxYyiYVC8DiVD+0nt4X8Tg35gvRgYoVWrRHOofEiXAeU6QE33TKVO/qrnR/qGBdgmAEpeYYAzUhkpDWZvnztYJy/9TdNrc6ZY7No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwG72G1C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60F1C32786;
	Mon,  1 Jul 2024 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719831757;
	bh=BFPfDZDRnlSGD4CqQUX6RHGCQbZo5jRDq68j/0XvWvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MwG72G1Cze8SS8thj/oK1T0+2zoa/m2BuwDA/Eq0931hAmG/bz8C4bnIoM5j0JsSH
	 Qc7KsMhYyj+izchMW0k7s+rVMBKprj/x2fIbjzNRBUZSO7Lzx1vWRWhyjg86xU/ROU
	 7NLguR0ZV1vXVte3QbZxbxsc51MhVx5qvrW04OBV32f2nyWY51vITp/sPf79TZzqhn
	 qw/VSfNnHzkbHa5aBj5X56ogSv0JWc6ib7hKQR1hLyTLTl/Ldsag3Zs8zdsnh0w09I
	 efiqwxbp5s3wqhniWjVnuBjW3QZsSPVwxXa7/jzv+Z1Yw1UqWxWH+E2Q5PlaIFJxM0
	 i9wia449uz7Eg==
Message-ID: <eba7b47914674cd50b452e65be8188e42bdac95d.camel@kernel.org>
Subject: Re: [PATCH 2/6] nfsd: add cred parameter to __fh_verify()
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	 <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Mike Snitzer
	 <snitzer@kernel.org>
Date: Mon, 01 Jul 2024 07:02:35 -0400
In-Reply-To: <20240701025802.22985-3-neilb@suse.de>
References: <20240701025802.22985-1-neilb@suse.de>
	 <20240701025802.22985-3-neilb@suse.de>
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
> __fh_verify() now takes a 'cred' parameter and never dereferences
> rqstp->rq_cred.
>=20
> nfsd_permission(), nfsd_setuser() and nfsexp_flags() only never needed

"only ever"

> the cred out of rqstp, so we now pass in the cred explicitly and not the
> rqstp.
>=20
> nfsd_originating_port_ok() is NOT passed a cred despite that it uses
> one.=C2=A0 This function is not useful when rqstp is NULL and a future pa=
tch
> will address that.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 +++++++-------
> =C2=A0fs/nfsd/auth.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/nfsd/export.h=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A0fs/nfsd/nfs4state.c |=C2=A0 3 ++-
> =C2=A0fs/nfsd/nfsfh.c=C2=A0=C2=A0=C2=A0=C2=A0 | 18 +++++++++++-------
> =C2=A0fs/nfsd/nfsproc.c=C2=A0=C2=A0 |=C2=A0 9 +++++----
> =C2=A0fs/nfsd/vfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++++++++++++=
---------
> =C2=A0fs/nfsd/vfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A08 files changed, 41 insertions(+), 31 deletions(-)
>=20
> diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
> index e6beaaf4f170..93e33d1ee891 100644
> --- a/fs/nfsd/auth.c
> +++ b/fs/nfsd/auth.c
> @@ -5,26 +5,26 @@
> =C2=A0#include "nfsd.h"
> =C2=A0#include "auth.h"
> =C2=A0
> -int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp)
> +int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp)
> =C2=A0{
> =C2=A0	struct exp_flavor_info *f;
> =C2=A0	struct exp_flavor_info *end =3D exp->ex_flavors + exp->ex_nflavors=
;
> =C2=A0
> =C2=A0	for (f =3D exp->ex_flavors; f < end; f++) {
> -		if (f->pseudoflavor =3D=3D rqstp->rq_cred.cr_flavor)
> +		if (f->pseudoflavor =3D=3D cred->cr_flavor)
> =C2=A0			return f->flags;
> =C2=A0	}
> =C2=A0	return exp->ex_flags;
> =C2=A0
> =C2=A0}
> =C2=A0
> -int nfsd_setuser(struct svc_rqst *rqstp, struct svc_export *exp)
> +int nfsd_setuser(struct svc_cred *cred, struct svc_export *exp)
> =C2=A0{
> =C2=A0	struct group_info *rqgi;
> =C2=A0	struct group_info *gi;
> =C2=A0	struct cred *new;
> =C2=A0	int i;
> -	int flags =3D nfsexp_flags(rqstp, exp);
> +	int flags =3D nfsexp_flags(cred, exp);
> =C2=A0
> =C2=A0	/* discard any old override before preparing the new set */
> =C2=A0	revert_creds(get_cred(current_real_cred()));
> @@ -32,10 +32,10 @@ int nfsd_setuser(struct svc_rqst *rqstp, struct svc_e=
xport *exp)
> =C2=A0	if (!new)
> =C2=A0		return -ENOMEM;
> =C2=A0
> -	new->fsuid =3D rqstp->rq_cred.cr_uid;
> -	new->fsgid =3D rqstp->rq_cred.cr_gid;
> +	new->fsuid =3D cred->cr_uid;
> +	new->fsgid =3D cred->cr_gid;
> =C2=A0
> -	rqgi =3D rqstp->rq_cred.cr_group_info;
> +	rqgi =3D cred->cr_group_info;
> =C2=A0
> =C2=A0	if (flags & NFSEXP_ALLSQUASH) {
> =C2=A0		new->fsuid =3D exp->ex_anon_uid;
> diff --git a/fs/nfsd/auth.h b/fs/nfsd/auth.h
> index dbd66424f600..fc75c5d90be4 100644
> --- a/fs/nfsd/auth.h
> +++ b/fs/nfsd/auth.h
> @@ -12,6 +12,6 @@
> =C2=A0 * Set the current process's fsuid/fsgid etc to those of the NFS
> =C2=A0 * client user
> =C2=A0 */
> -int nfsd_setuser(struct svc_rqst *, struct svc_export *);
> +int nfsd_setuser(struct svc_cred *, struct svc_export *);
> =C2=A0
> =C2=A0#endif /* LINUX_NFSD_AUTH_H */
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index 1a54d388d58d..2dbd15704a86 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -99,7 +99,8 @@ struct svc_expkey {
> =C2=A0#define EX_NOHIDE(exp)		((exp)->ex_flags & NFSEXP_NOHIDE)
> =C2=A0#define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
> =C2=A0
> -int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> +struct svc_cred;
> +int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
> =C2=A0__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *r=
qstp);
> =C2=A0
> =C2=A0/*
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..eadb7d1a7f13 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6889,7 +6889,8 @@ nfs4_check_file(struct svc_rqst *rqstp, struct svc_=
fh *fhp, struct nfs4_stid *s,
> =C2=A0
> =C2=A0	nf =3D nfs4_find_file(s, flags);
> =C2=A0	if (nf) {
> -		status =3D nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
> +		status =3D nfsd_permission(&rqstp->rq_cred,
> +					 fhp->fh_export, fhp->fh_dentry,
> =C2=A0				acc | NFSD_MAY_OWNER_OVERRIDE);
> =C2=A0		if (status) {
> =C2=A0			nfsd_file_put(nf);
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index e27ed27054ab..760684fa4b50 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -100,9 +100,10 @@ static bool nfsd_originating_port_ok(struct svc_rqst=
 *rqstp, int flags)
> =C2=A0}
> =C2=A0
> =C2=A0static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
> +					=C2=A0 struct svc_cred *cred,
> =C2=A0					=C2=A0 struct svc_export *exp)
> =C2=A0{
> -	int flags =3D nfsexp_flags(rqstp, exp);
> +	int flags =3D nfsexp_flags(cred, exp);
> =C2=A0
> =C2=A0	/* Check if the request originated from a secure port. */
> =C2=A0	if (!nfsd_originating_port_ok(rqstp, flags)) {
> @@ -113,7 +114,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_=
rqst *rqstp,
> =C2=A0	}
> =C2=A0
> =C2=A0	/* Set user creds for this exportpoint */
> -	return nfserrno(nfsd_setuser(rqstp, exp));
> +	return nfserrno(nfsd_setuser(cred, exp));
> =C2=A0}
> =C2=A0
> =C2=A0static inline __be32 check_pseudo_root(struct svc_rqst *rqstp,
> @@ -152,6 +153,7 @@ static inline __be32 check_pseudo_root(struct svc_rqs=
t *rqstp,
> =C2=A0 * fh_dentry.
> =C2=A0 */
> =C2=A0static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct nfs=
d_net *nn,
> +				 struct svc_cred *cred,
> =C2=A0				 struct svc_fh *fhp)
> =C2=A0{
> =C2=A0	struct knfsd_fh	*fh =3D &fhp->fh_handle;
> @@ -230,7 +232,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct nfsd_net *nn,
> =C2=A0		put_cred(override_creds(new));
> =C2=A0		put_cred(new);
> =C2=A0	} else {
> -		error =3D nfsd_setuser_and_check_port(rqstp, exp);
> +		error =3D nfsd_setuser_and_check_port(rqstp, cred, exp);
> =C2=A0		if (error)
> =C2=A0			goto out;
> =C2=A0	}
> @@ -326,7 +328,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqs=
tp, struct nfsd_net *nn,
> =C2=A0 * fs/nfsd/vfs.h.
> =C2=A0 */
> =C2=A0static __be32
> -__fh_verify(struct svc_rqst *rqstp, struct nfsd_net *nn,
> +__fh_verify(struct svc_rqst *rqstp,
> +	=C2=A0=C2=A0=C2=A0 struct nfsd_net *nn, struct svc_cred *cred,
> =C2=A0	=C2=A0=C2=A0=C2=A0 struct svc_fh *fhp, umode_t type, int access)
> =C2=A0{
> =C2=A0	struct svc_export *exp =3D NULL;
> @@ -334,7 +337,7 @@ __fh_verify(struct svc_rqst *rqstp, struct nfsd_net *=
nn,
> =C2=A0	__be32		error;
> =C2=A0
> =C2=A0	if (!fhp->fh_dentry) {
> -		error =3D nfsd_set_fh_dentry(rqstp, nn, fhp);
> +		error =3D nfsd_set_fh_dentry(rqstp, nn, cred, fhp);
> =C2=A0		if (error)
> =C2=A0			goto out;
> =C2=A0	}
> @@ -363,7 +366,7 @@ __fh_verify(struct svc_rqst *rqstp, struct nfsd_net *=
nn,
> =C2=A0	if (error)
> =C2=A0		goto out;
> =C2=A0
> -	error =3D nfsd_setuser_and_check_port(rqstp, exp);
> +	error =3D nfsd_setuser_and_check_port(rqstp, cred, exp);
> =C2=A0	if (error)
> =C2=A0		goto out;
> =C2=A0
> @@ -393,7 +396,7 @@ __fh_verify(struct svc_rqst *rqstp, struct nfsd_net *=
nn,
> =C2=A0
> =C2=A0skip_pseudoflavor_check:
> =C2=A0	/* Finally, check access permissions. */
> -	error =3D nfsd_permission(rqstp, exp, dentry, access);
> +	error =3D nfsd_permission(cred, exp, dentry, access);
> =C2=A0out:
> =C2=A0	trace_nfsd_fh_verify_err(rqstp, fhp, type, access, error);
> =C2=A0	if (error =3D=3D nfserr_stale)
> @@ -405,6 +408,7 @@ __be32
> =C2=A0fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,=
 int access)
> =C2=A0{
> =C2=A0	return __fh_verify(rqstp, net_generic(SVC_NET(rqstp), nfsd_net_id)=
,
> +			=C2=A0=C2=A0 &rqstp->rq_cred,
> =C2=A0			=C2=A0=C2=A0 fhp, type, access);
> =C2=A0}
> =C2=A0
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 36370b957b63..97aab34593ef 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -331,10 +331,11 @@ nfsd_proc_create(struct svc_rqst *rqstp)
> =C2=A0					 *=C2=A0=C2=A0 echo thing > device-special-file-or-pipe
> =C2=A0					 * by doing a CREATE with type=3D=3D0
> =C2=A0					 */
> -					resp->status =3D nfsd_permission(rqstp,
> -								 newfhp->fh_export,
> -								 newfhp->fh_dentry,
> -								 NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
> +					resp->status =3D nfsd_permission(
> +						&rqstp->rq_cred,
> +						newfhp->fh_export,
> +						newfhp->fh_dentry,
> +						NFSD_MAY_WRITE|NFSD_MAY_LOCAL_ACCESS);
> =C2=A0					if (resp->status && resp->status !=3D nfserr_rofs)
> =C2=A0						goto out_unlock;
> =C2=A0				}
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 29b1f3613800..0862f6ae86a9 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -421,8 +421,9 @@ nfsd_get_write_access(struct svc_rqst *rqstp, struct =
svc_fh *fhp,
> =C2=A0	if (iap->ia_size < inode->i_size) {
> =C2=A0		__be32 err;
> =C2=A0
> -		err =3D nfsd_permission(rqstp, fhp->fh_export, fhp->fh_dentry,
> -				NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERRIDE);
> +		err =3D nfsd_permission(&rqstp->rq_cred,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fhp->fh_export, fhp->fh_dentry,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NFSD_MAY_TRUNC | NFSD_MAY_OWNER_OVERR=
IDE);
> =C2=A0		if (err)
> =C2=A0			return err;
> =C2=A0	}
> @@ -814,7 +815,8 @@ nfsd_access(struct svc_rqst *rqstp, struct svc_fh *fh=
p, u32 *access, u32 *suppor
> =C2=A0
> =C2=A0			sresult |=3D map->access;
> =C2=A0
> -			err2 =3D nfsd_permission(rqstp, export, dentry, map->how);
> +			err2 =3D nfsd_permission(&rqstp->rq_cred, export,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dentry, map->how);
> =C2=A0			switch (err2) {
> =C2=A0			case nfs_ok:
> =C2=A0				result |=3D map->access;
> @@ -1475,7 +1477,8 @@ nfsd_create_locked(struct svc_rqst *rqstp, struct s=
vc_fh *fhp,
> =C2=A0	dirp =3D d_inode(dentry);
> =C2=A0
> =C2=A0	dchild =3D dget(resfhp->fh_dentry);
> -	err =3D nfsd_permission(rqstp, fhp->fh_export, dentry, NFSD_MAY_CREATE)=
;
> +	err =3D nfsd_permission(&rqstp->rq_cred, fhp->fh_export, dentry,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NFSD_MAY_CREATE);
> =C2=A0	if (err)
> =C2=A0		goto out;
> =C2=A0
> @@ -2255,9 +2258,9 @@ nfsd_statfs(struct svc_rqst *rqstp, struct svc_fh *=
fhp, struct kstatfs *stat, in
> =C2=A0	return err;
> =C2=A0}
> =C2=A0
> -static int exp_rdonly(struct svc_rqst *rqstp, struct svc_export *exp)
> +static int exp_rdonly(struct svc_cred *cred, struct svc_export *exp)
> =C2=A0{
> -	return nfsexp_flags(rqstp, exp) & NFSEXP_READONLY;
> +	return nfsexp_flags(cred, exp) & NFSEXP_READONLY;
> =C2=A0}
> =C2=A0
> =C2=A0#ifdef CONFIG_NFSD_V4
> @@ -2501,8 +2504,8 @@ nfsd_setxattr(struct svc_rqst *rqstp, struct svc_fh=
 *fhp, char *name,
> =C2=A0 * Check for a user's access permissions to this inode.
> =C2=A0 */
> =C2=A0__be32
> -nfsd_permission(struct svc_rqst *rqstp, struct svc_export *exp,
> -					struct dentry *dentry, int acc)
> +nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
> +		struct dentry *dentry, int acc)
> =C2=A0{
> =C2=A0	struct inode	*inode =3D d_inode(dentry);
> =C2=A0	int		err;
> @@ -2533,7 +2536,7 @@ nfsd_permission(struct svc_rqst *rqstp, struct svc_=
export *exp,
> =C2=A0	 */
> =C2=A0	if (!(acc & NFSD_MAY_LOCAL_ACCESS))
> =C2=A0		if (acc & (NFSD_MAY_WRITE | NFSD_MAY_SATTR | NFSD_MAY_TRUNC)) {
> -			if (exp_rdonly(rqstp, exp) ||
> +			if (exp_rdonly(cred, exp) ||
> =C2=A0			=C2=A0=C2=A0=C2=A0 __mnt_is_readonly(exp->ex_path.mnt))
> =C2=A0				return nfserr_rofs;
> =C2=A0			if (/* (acc & NFSD_MAY_WRITE) && */ IS_IMMUTABLE(inode))
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 57cd70062048..1565c1dc28b6 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -153,7 +153,7 @@ __be32		nfsd_readdir(struct svc_rqst *, struct svc_fh=
 *,
> =C2=A0__be32		nfsd_statfs(struct svc_rqst *, struct svc_fh *,
> =C2=A0				struct kstatfs *, int access);
> =C2=A0
> -__be32		nfsd_permission(struct svc_rqst *, struct svc_export *,
> +__be32		nfsd_permission(struct svc_cred *, struct svc_export *,
> =C2=A0				struct dentry *, int);
> =C2=A0
> =C2=A0void		nfsd_filp_close(struct file *fp);

Patch itself looks fine though.
--=20
Jeff Layton <jlayton@kernel.org>

