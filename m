Return-Path: <linux-nfs+bounces-5318-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 784E294EF74
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 636E728397D
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3055317F394;
	Mon, 12 Aug 2024 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aakzWAZg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C25716C440
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 14:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472734; cv=none; b=eA3NtV9ipPjKOHxd4HzPkFloqvqGgdw+Jfj0xOWD8Afhx9mTEbmAQERYhDUflqDR5DDfxucHBFxVzDZT8AgkgVoPrJKGE6dCk4gfO40hvwVE0G0mR2OAZNjzjw20Bow0yYeqapzrXLvknZJxP9I0UIYfQqLtjJt7yv9tcAXpKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472734; c=relaxed/simple;
	bh=lE6iSdwd1ZnspWrqrScZmYQCOvFNcrESGrRF9lPq280=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vCnpQAO5cGmC6MNRkz/dQWybyZvrIchMqGjPl7nAlXSvAKFGpr+z4KtS176HrVcAnuHE9jI/2wCnWtuQyEmyVAGlEvetyOfzmABIE64IFRdMexLOf12v2otf7Hd1MgPjv4EwithiUWKBoYxftRbICGgzLghEefJwyb8nRm/o67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aakzWAZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B53EC32782;
	Mon, 12 Aug 2024 14:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723472733;
	bh=lE6iSdwd1ZnspWrqrScZmYQCOvFNcrESGrRF9lPq280=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aakzWAZgm3kzzJwxolabT5JNQBC9ALvsnEQTNrapC45KsrN1pE5CX0vMcvMUtY6JF
	 Tzrm4s4+Yewl9pcn5c9PNwLyb06ydJaE+aWI/0zISKMZHszwwU8fkDIRgf8b/USH15
	 3S1h409bxQtmuB0hvCvR1xPsCVovuIZ+pR8r5mjEymxUYvCXG7nSQ2L4X2tLbltzRJ
	 Jfr0yoRNUPzKf2OtJxnFblmIrW+dsT7JzWlSlW2uccTWmNJ8aro/gHtxo3wnxqYcP6
	 1kxSb70c3db9ACfE3xWL2u4Y3J5Ys6ATBcZI3fL4OCieapxIoU0Eao8WGlu0w/6vNf
	 mfhm+95xepCnw==
Message-ID: <0ee6c6a21615023f14da9423f8a18a0900e218b5.camel@kernel.org>
Subject: Re: [PATCH] SQUASH: nfsd: move error choice for incorrect object
 types to version-specific code.
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Date: Mon, 12 Aug 2024 10:25:27 -0400
In-Reply-To: <172343558582.6062.9756574878881138559@noble.neil.brown.name>
References: <172343558582.6062.9756574878881138559@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 14:06 +1000, NeilBrown wrote:
>=20
> [This should be squashed into the existing patch for the same name,
> with this commit message used instead of the current one.=C2=A0 It addres=
ses
> the pynfs failures that Jeff found]
>=20
> If an NFS operation expects a particular sort of object (file, dir, link,
> etc) but gets a file handle for a different sort of object, it must
> return an error.=C2=A0 The actual error varies among NFS version in non-t=
rivial
> ways.
>=20
> For v2 and v3 there are ISDIR and NOTDIR errors and, for NFSv4 only,
> INVAL is suitable.
>=20
> For v4.0 there is also NFS4ERR_SYMLINK which should be used if a SYMLINK
> was found when not expected.=C2=A0 This take precedence over NOTDIR.
>=20
> For v4.1+ there is also NFS4ERR_WRONG_TYPE which should be used in
> preference to EINVAL when none of the specific error codes apply.
>=20
> When nfsd_mode_check() finds a symlink where it expected a directory it
> needs to return an error code that can be converted to NOTDIR for v2 or
> v3 but will be SYMLINK for v4.=C2=A0 It must be different from the error
> code returns when it finds a symlink but expects a regular file - that
> must be converted to EINVAL or SYMLINK.
>=20
> So we introduce an internal error code nfserr_symlink_not_dir which each
> version converts as appropriate.
>=20
> nfsd_check_obj_isreg() is similar to nfsd_mode_check() except that it is
> only used by NFSv4 and only for OPEN.=C2=A0 NFSERR_INVAL is never a suita=
ble
> error if the object is the wrong time.=C2=A0 For v4.0 we use nfserr_symli=
nk
> for non-dirs even if not a symlink.=C2=A0 For v4.1 we have nfserr_wrong_t=
ype.
> To handle this difference we introduce an internal status code
> nfserr_wrong_type_open.
>=20
> As a result of these changes, nfsd_mode_check() doesn't need an rqstp
> arg any more.
>=20
> Note that NFSv4 operations are actually performed in the xdr code(!!!)
> so to the only place that we can map the status code successfully is in
> nfsd4_encode_operation().
>=20
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---
> =C2=A0fs/nfsd/nfs4proc.c | 21 +--------------------
> =C2=A0fs/nfsd/nfs4xdr.c=C2=A0 | 26 ++++++++++++++++++++++++++
> =C2=A0fs/nfsd/nfsd.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A03 files changed, 33 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 2e355085e443..e010d627d545 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -168,7 +168,7 @@ static __be32 nfsd_check_obj_isreg(struct svc_fh *fh)
> =C2=A0		return nfserr_isdir;
> =C2=A0	if (S_ISLNK(mode))
> =C2=A0		return nfserr_symlink;
> -	return nfserr_wrong_type;
> +	return nfserr_wrong_type_open;
> =C2=A0}
> =C2=A0
> =C2=A0static void nfsd4_set_open_owner_reply_cache(struct nfsd4_compound_=
state *cstate, struct nfsd4_open *open, struct svc_fh *resfh)
> @@ -179,23 +179,6 @@ static void nfsd4_set_open_owner_reply_cache(struct =
nfsd4_compound_state *cstate
> =C2=A0			&resfh->fh_handle);
> =C2=A0}
> =C2=A0
> -static __be32 nfsd4_map_status(__be32 status, u32 minor)
> -{
> -	switch (status) {
> -	case nfs_ok:
> -		break;
> -	case nfserr_wrong_type:
> -		/* RFC 8881 - 15.1.2.9 */
> -		if (minor =3D=3D 0)
> -			status =3D nfserr_inval;
> -		break;
> -	case nfserr_symlink_not_dir:
> -		status =3D nfserr_symlink;
> -		break;
> -	}
> -	return status;
> -}
> -
> =C2=A0static inline bool nfsd4_create_is_exclusive(int createmode)
> =C2=A0{
> =C2=A0	return createmode =3D=3D NFS4_CREATE_EXCLUSIVE ||
> @@ -2815,8 +2798,6 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> =C2=A0			nfsd4_encode_replay(resp->xdr, op);
> =C2=A0			status =3D op->status =3D op->replay->rp_status;
> =C2=A0		} else {
> -			op->status =3D nfsd4_map_status(op->status,
> -						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cstate->minorversion);
> =C2=A0			nfsd4_encode_operation(resp, op);
> =C2=A0			status =3D op->status;
> =C2=A0		}
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 42b41d55d4ed..a0c1fc19aea4 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -5729,6 +5729,30 @@ __be32 nfsd4_check_resp_size(struct nfsd4_compound=
res *resp, u32 respsize)
> =C2=A0	return nfserr_rep_too_big;
> =C2=A0}
> =C2=A0
> +static __be32 nfsd4_map_status(__be32 status, u32 minor)
> +{
> +	switch (status) {
> +	case nfs_ok:
> +		break;
> +	case nfserr_wrong_type:
> +		/* RFC 8881 - 15.1.2.9 */
> +		if (minor =3D=3D 0)
> +			status =3D nfserr_inval;
> +		break;
> +	case nfserr_wrong_type_open:
> +		/* RFC 7530 - 16.16.6 */
> +		if (minor =3D=3D 0)
> +			status =3D nfserr_symlink;
> +		else
> +			status =3D nfserr_wrong_type;
> +		break;
> +	case nfserr_symlink_not_dir:
> +		status =3D nfserr_symlink;
> +		break;
> +	}
> +	return status;
> +}
> +
> =C2=A0void
> =C2=A0nfsd4_encode_operation(struct nfsd4_compoundres *resp, struct nfsd4=
_op *op)
> =C2=A0{
> @@ -5796,6 +5820,8 @@ nfsd4_encode_operation(struct nfsd4_compoundres *re=
sp, struct nfsd4_op *op)
> =C2=A0						so->so_replay.rp_buf, len);
> =C2=A0	}
> =C2=A0status:
> +	op->status =3D nfsd4_map_status(op->status,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resp->cstate.minorversion);
> =C2=A0	*p =3D op->status;
> =C2=A0release:
> =C2=A0	if (opdesc && opdesc->op_release)
> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
> index 4ccbf014a2c7..b4503e698ffd 100644
> --- a/fs/nfsd/nfsd.h
> +++ b/fs/nfsd/nfsd.h
> @@ -359,6 +359,12 @@ enum {
> =C2=A0 */
> =C2=A0	NFSERR_SYMLINK_NOT_DIR,
> =C2=A0#define	nfserr_symlink_not_dir	cpu_to_be32(NFSERR_SYMLINK_NOT_DIR)
> +
> +/* non-{reg,dir,symlink} found by open - handled differently
> + * in v4.0 than v4.1.
> + */
> +	NFSERR_WRONG_TYPE_OPEN,
> +#define	nfserr_wrong_type_open	cpu_to_be32(NFSERR_WRONG_TYPE_OPEN)
> =C2=A0};
> =C2=A0
> =C2=A0/* Check for dir entries '.' and '..' */

Much better! I ran it through pynfs and everything passed.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

