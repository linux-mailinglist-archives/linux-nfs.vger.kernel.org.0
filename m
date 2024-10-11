Return-Path: <linux-nfs+bounces-7064-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DA199A3F7
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 14:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD3CB21AFA
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Oct 2024 12:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7091FB3F1;
	Fri, 11 Oct 2024 12:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjn11fZ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F71CDFA6
	for <linux-nfs@vger.kernel.org>; Fri, 11 Oct 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728650112; cv=none; b=RECFT3LPFeOcpa0km5gl7zeItb0mhOG6Yu45kPyWzSMN/peX8q1R9ZwC5g9EHWVJ3+sse2MERdXzEtmHsyb0gc3n6vKim/yDhN5LvdfVJlk4Q4vdA2mMZx8BPm2G8tsQQuZh8yW2+yGi8HGDJqdDwBAHkVVGWF/EKrBDehfPHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728650112; c=relaxed/simple;
	bh=vNjAmJyDkp1XacLAhlPA/FkKiOK40qz1wqtt6b/S5+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P1ogLzjEHVvs2F0wwWNLFOcDtl0S2gPDAgjtOEuURnqDWcwVcwL9XAIXXB3C7DlfLoy6WqJqBHtO7qNYEYy++N+Gj0DS7HMj4DZ9YZjzH7g+Jku2ojdbbbzoR44dGJbcX04JbDWFWk79WgI+PEVaOSfBz8kel5vwDEbaioaQl4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pjn11fZ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41875C4CEC3;
	Fri, 11 Oct 2024 12:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728650111;
	bh=vNjAmJyDkp1XacLAhlPA/FkKiOK40qz1wqtt6b/S5+Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=Pjn11fZ1Gc2Ns2TKBiIdfmw7Sifal7QlDHr9TH1x+/R3k8wsEkGJ2/wGFFuSImKa1
	 8ah0aqBFYfBnhMTpae8lPVYL0DrST7ZHA3EpvW9SFJ3VbJzTehi8cj68nL2i4l/MnU
	 hPnZom44qIiSx6KCsyEx71nRs6t5sZ63poBWXl5dc0LsAwXh34J21uYGeuS1K+n5R4
	 qSNBPx9es8NR0+iITJ+jztSu1/ATjYaX8szHA1soXcnoy0zCq5k4y3KzMYEpuyFMST
	 Mtea+8BNC6+ylWUYCXdj28Gst+vHk2Ph6vGgfFJmUrzucC2hE6Rcyo/glnwg1Vddkc
	 M1aLvDzdwC4Tg==
Message-ID: <7ef7885808d58b7a0f557b047184b18fbc941f73.camel@kernel.org>
Subject: Re: [PATCH nfsd-next] nfsd: refine and rename NFSD_MAY_LOCK
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>, Olga
 Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>, Tom
 Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org
Date: Fri, 11 Oct 2024 08:35:10 -0400
In-Reply-To: <172859586932.444407.11362678410508147927@noble.neil.brown.name>
References: <172859586932.444407.11362678410508147927@noble.neil.brown.name>
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

On Fri, 2024-10-11 at 08:31 +1100, NeilBrown wrote:
> NFSD_MAY_LOCK means a few different things.
> - it means that GSS is not required.
> - it means that with NFSEXP_NOAUTHNLM, authentication is not required
> - it means that OWNER_OVERRIDE is allowed.
>=20
> None of these are specific to locking, they are specific to the NLM
> protocol.
> So:
>  - rename to NFSD_MAY_NLM
>  - set NFSD_MAY_OWNER_OVERRIDE and NFSD_MAY_BYPASS_GSS in nlm_fopen()
>    so that NFSD_MAY_NLM doesn't need to imply these.
>  - move the test on NFSEXP_NOAUTHNLM out of nfsd_permission() and
>    into fh_verify() where other special-case tests on the MAY flags
>    happen.  nfsd_permission() can be called from other places than
>    fh_verify(), but none of these will have NFSD_MAY_NLM.
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
>  fs/nfsd/lockd.c | 13 +++++++++++--
>  fs/nfsd/nfsfh.c | 12 ++++--------
>  fs/nfsd/trace.h |  2 +-
>  fs/nfsd/vfs.c   | 12 +-----------
>  fs/nfsd/vfs.h   |  2 +-
>  5 files changed, 18 insertions(+), 23 deletions(-)
>=20
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 46a7f9b813e5..edc9f75dc75c 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -38,11 +38,20 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, s=
truct file **filp,
>  	memcpy(&fh.fh_handle.fh_raw, f->data, f->size);
>  	fh.fh_export =3D NULL;
> =20
> +	/*
> +	 * Allow BYPASS_GSS as some client implementations use AUTH_SYS
> +	 * for NLM even when GSS is used for NFS.
> +	 * Allow OWNER_OVERRIDE as permission might have been changed
> +	 * after the file was opened.
> +	 * Pass MAY_NLM so that authentication can be completely bypassed
> +	 * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
> +	 * for NLM requests.
> +	 */
>  	access =3D (mode =3D=3D O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
> -	access |=3D NFSD_MAY_LOCK;
> +	access |=3D NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GS=
S;
>  	nfserr =3D nfsd_open(rqstp, &fh, S_IFREG, access, filp);
>  	fh_put(&fh);
> - 	/* We return nlm error codes as nlm doesn't know
> +	/* We return nlm error codes as nlm doesn't know
>  	 * about nfsd, but nfsd does know about nlm..
>  	 */
>  	switch (nfserr) {
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 4c5deea0e953..885a58ca33d8 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -363,13 +363,10 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;From 226d19d36029605a16d837d1a94a6f81b6e06681 Mon Sep 17 00:0=
0:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Fri, 11 Oct 2024 08:23:08 +1100
>=20
^^^
This patch appears to be mangled.

>=20
> =20
> -	/*
> -	 * pseudoflavor restrictions are not enforced on NLM,
> -	 * which clients virtually always use auth_sys for,
> -	 * even while using RPCSEC_GSS for NFS.
> -	 */
> -	if (access & NFSD_MAY_LOCK)
> -		goto skip_pseudoflavor_check;
> +	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
> +		/* NLM is allowed to fully bypass authentication */
> +		goto out;
> +
>  	if (access & NFSD_MAY_BYPASS_GSS)
>  		may_bypass_gss =3D true;
>  	/*
> @@ -385,7 +382,6 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
> =20
> -skip_pseudoflavor_check:
>  	/* Finally, check access permissions. */
>  	error =3D nfsd_permission(cred, exp, dentry, access);
>  out:
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index c625966cfcf3..b7abf1cba9e2 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -79,7 +79,7 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_READ,		"READ" },		\
>  		{ NFSD_MAY_SATTR,		"SATTR" },		\
>  		{ NFSD_MAY_TRUNC,		"TRUNC" },		\
> -		{ NFSD_MAY_LOCK,		"LOCK" },		\
> +		{ NFSD_MAY_NLM,			"NLM" },		\
>  		{ NFSD_MAY_OWNER_OVERRIDE,	"OWNER_OVERRIDE" },	\
>  		{ NFSD_MAY_LOCAL_ACCESS,	"LOCAL_ACCESS" },	\
>  		{ NFSD_MAY_BYPASS_GSS_ON_ROOT,	"BYPASS_GSS_ON_ROOT" },	\
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 51f5a0b181f9..2610638f4301 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -2509,7 +2509,7 @@ nfsd_permission(struct svc_cred *cred, struct svc_e=
xport *exp,
>  		(acc & NFSD_MAY_EXEC)?	" exec"  : "",
>  		(acc & NFSD_MAY_SATTR)?	" sattr" : "",
>  		(acc & NFSD_MAY_TRUNC)?	" trunc" : "",
> -		(acc & NFSD_MAY_LOCK)?	" lock"  : "",
> +		(acc & NFSD_MAY_NLM)?	" nlm"  : "",
>  		(acc & NFSD_MAY_OWNER_OVERRIDE)? " owneroverride" : "",
>  		inode->i_mode,
>  		IS_IMMUTABLE(inode)?	" immut" : "",
> @@ -2534,16 +2534,6 @@ nfsd_permission(struct svc_cred *cred, struct svc_=
export *exp,
>  	if ((acc & NFSD_MAY_TRUNC) && IS_APPEND(inode))
>  		return nfserr_perm;
> =20
> -	if (acc & NFSD_MAY_LOCK) {
> -		/* If we cannot rely on authentication in NLM requests,
> -		 * just allow locks, otherwise require read permission, or
> -		 * ownership
> -		 */
> -		if (exp->ex_flags & NFSEXP_NOAUTHNLM)
> -			return 0;
> -		else
> -			acc =3D NFSD_MAY_READ | NFSD_MAY_OWNER_OVERRIDE;
> -	}
>  	/*
>  	 * The file owner always gets access permission for accesses that
>  	 * would normally be checked at open time. This is to make
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 854fb95dfdca..f9b09b842856 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -20,7 +20,7 @@
>  #define NFSD_MAY_READ			0x004 /* =3D=3D MAY_READ */
>  #define NFSD_MAY_SATTR			0x008
>  #define NFSD_MAY_TRUNC			0x010
> -#define NFSD_MAY_LOCK			0x020
> +#define NFSD_MAY_NLM			0x020 /* request is from lockd */
>  #define NFSD_MAY_MASK			0x03f
> =20
>  /* extra hints to permission and open routines: */
>=20
> base-commit: 144cb1225cd863e1bd3ae3d577d86e1531afd932
> prerequisite-patch-id: 7a049ff3732fdc61d6d4ff6f916f35341eddfa04

The patch itself makes sense though.
--=20
Jeff Layton <jlayton@kernel.org>

