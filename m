Return-Path: <linux-nfs+bounces-5068-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E82F893D426
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 15:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1101C23988
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 13:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDC17BB0F;
	Fri, 26 Jul 2024 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsT7yAeD"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBC517BB09
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 13:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722000218; cv=none; b=L6krL0lwHbInzMIG+BxLvbQC9BjIbF+jp3rBoMU37nQqRN0aZSSW/7nsG3yaPwrnXGK/LjEKB47NKR6aZaKSURVX0Wgd4N/9DAQHJn94Kah4xrXw9xI3YNgfT+5h+kAeDF324BxJx0v07nT1tg02eCHrdiTC0690VqQj86MyT2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722000218; c=relaxed/simple;
	bh=oPJYSRNOlF/nQiPd6zTb5lzmi07uxiQ6trnzd7XEvgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eEe0Q7lk51ZknApPZsZpw/GcVqTOKNJAGCp1RQEY2Gy1gREM58ZrFrinzIrdPkRqJVBVuojASWRtz7EB45drS4BqTr0sEr+OI9b5lGwAn8NdC/Oy/n24Qby9iMH89Q+8vgblV850oGd367o3pOCDOgAuGJx2RAQ2hw33fCp4MSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsT7yAeD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DCF0C32782;
	Fri, 26 Jul 2024 13:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722000217;
	bh=oPJYSRNOlF/nQiPd6zTb5lzmi07uxiQ6trnzd7XEvgw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EsT7yAeDvHrJCF3KN5Itzf5TXNhetWJmmPqk+LKNYaS1G/IUaoWf+B7YotLElJvsr
	 bCiCgbI9V8pC6OA07hyEX3EJ2rtjTMWfGkXsl9KWFE/9p3Y3zor/Yjnhwc4A3xbcjY
	 aCHpXrPziw2hKIC+b3mJAMd6hNRoComJivGWJRGD0NkCrxSTu9PlSrRBPf+tyzO2NP
	 CvLsBHVWRiRhMGxszi5r6UHI+vp+8nf7AYqUCKqQaEPqifk+N4DefVSBEEUHjBwZdg
	 0wtB7EejEyXNDD8DRG1sYKmzMNH+8gS2/IgPKoSYWUOmE+pu5EZwO8cwu/cwjxxSMU
	 eAr0MKG3dNn0w==
Message-ID: <fef005f0872b0795a5d106fb92ebe7c94c1d2ce9.camel@kernel.org>
Subject: Re: [PATCH rfc 1/2] nfsd: don't assume copy notify when
 preprocessing the stateid
From: Jeff Layton <jlayton@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>, Chuck Lever <chuck.lever@oracle.com>
Cc: Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Date: Fri, 26 Jul 2024 09:23:36 -0400
In-Reply-To: <20240724170138.1942307-1-sagi@grimberg.me>
References: <20240724170138.1942307-1-sagi@grimberg.me>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxwn8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1WvegyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqVT2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtVYrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8snVluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQcDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQfCBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sELZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIgUCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOTtmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedY
	xp8+9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPcog7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EBny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTiCThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XRMJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65ke5Ag0ETpXRPAEQAJkVmzCmF+IEenf9a2nZRXMluJohnfl2wCMmw5qNzyk0f+mYuTwTCpw7BE2H0yXk4ZfAuA+xdj14K0A1Dj52j/fKRuDqoNAhQe0b6ipo85Sz98G+XnmQOMeFVp5G1Z7r/QP/nus3mXvtFsu9lLSjMA0cam2NLDt7vx3l9kUYlQBhyIE7/DkKg+3fdqRg7qJoMHNcODtQY+n3hMyaVpplJ/l0DdQDbRSZi5AzDM3DWZEShhuP6/E2LN4O3xWnZukEiz688d1ppl7vBZO9wBql6Ft9Og74diZrTN6lXGGjEWRvO55h6ijMsLCLNDRAVehPhZvSlPldtUuvhZLAjdWpwmzbRIwgoQcO51aWeKthpcpj8feDdKdlVjvJO9fgFD5kqZQiErRVPpB7VzA/pYV5Mdy7GMbPjmO0IpoL0tVZ8JvUzUZXB3ErS/dJflvboAAQeLpLCkQjqZiQ/D
	CmgJCrBJst9Xc7YsKKS379Tc3GU33HNSpaOxs2NwfzoesyjKU+P35czvXWTtj7KVVSj3SgzzFk+gLx8y2Nvt9iESdZ1Ustv8tipDsGcvIZ43MQwqU9YbLg8k4V9ch+Mo8SE+C0jyZYDCE2ZGf3OztvtSYMsTnF6/luzVyej1AFVYjKHORzNoTwdHUeC+9/07GO0bMYTPXYvJ/vxBFm3oniXyhgb5FtABEBAAGJAh8EGAECAAkFAk6V0TwCGwwACgkQAA5oQRlWghXhZRAAyycZ2DDyXh2bMYvI8uHgCbeXfL3QCvcw2XoZTH2l2umPiTzrCsDJhgwZfG9BDyOHaYhPasd5qgrUBtjjUiNKjVM+Cx1DnieR0dZWafnqGv682avPblfi70XXr2juRE/fSZoZkyZhm+nsLuIcXTnzY4D572JGrpRMTpNpGmitBdh1l/9O7Fb64uLOtA5Qj5jcHHOjL0DZpjmFWYKlSAHmURHrE8M0qRryQXvlhoQxlJR4nvQrjOPMsqWD5F9mcRyowOzr8amasLv43w92rD2nHoBK6rbFE/qC7AAjABEsZq8+TQmueN0maIXUQu7TBzejsEbV0i29z+kkrjU2NmK5pcxgAtehVxpZJ14LqmN6E0suTtzjNT1eMoqOPrMSx+6vOCIuvJ/MVYnQgHhjtPPnU86mebTY5Loy9YfJAC2EVpxtcCbx2KiwErTndEyWL+GL53LuScUD7tW8vYbGIp4RlnUgPLbqpgssq2gwYO9m75FGuKuB2+2bCGajqalid5nzeq9v7cYLLRgArJfOIBWZrHy2m0C+pFu9DSuV6SNr2dvMQUv1V58h0FaSOxHVQnJdnoHn13g/CKKvyg2EMrMt/EfcXgvDwQbnG9we4xJiWOIOcsvrWcB6C6lWBDA+In7w7SXnnokkZWuOsJdJQdmwlWC5L5ln9xgfr/4mOY38B0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-24 at 10:01 -0700, Sagi Grimberg wrote:
> Move the stateid handling to nfsd4_copy_notify, if
> nfs4_preprocess_stateid_op
> did not produce an output stateid, error out.
>=20
> Copy notify specifically does not permit the use of special stateids,
> so enforce that outside generic stateid pre-processing.
>=20
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> =C2=A0fs/nfsd/nfs4proc.c=C2=A0 | 4 +++-
> =C2=A0fs/nfsd/nfs4state.c | 6 +-----
> =C2=A02 files changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 46bd20fe5c0f..7b70309ad8fb 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1942,7 +1942,7 @@ nfsd4_copy_notify(struct svc_rqst *rqstp,
> struct nfsd4_compound_state *cstate,
> =C2=A0	struct nfsd4_copy_notify *cn =3D &u->copy_notify;
> =C2=A0	__be32 status;
> =C2=A0	struct nfsd_net *nn =3D net_generic(SVC_NET(rqstp),
> nfsd_net_id);
> -	struct nfs4_stid *stid;
> +	struct nfs4_stid *stid =3D NULL;
> =C2=A0	struct nfs4_cpntf_state *cps;
> =C2=A0	struct nfs4_client *clp =3D cstate->clp;
> =C2=A0
> @@ -1951,6 +1951,8 @@ nfsd4_copy_notify(struct svc_rqst *rqstp,
> struct nfsd4_compound_state *cstate,
> =C2=A0					&stid);
> =C2=A0	if (status)
> =C2=A0		return status;
> +	if (!stid)
> +		return nfserr_bad_stateid;
> =C2=A0
> =C2=A0	cn->cpn_lease_time.tv_sec =3D nn->nfsd4_lease;
> =C2=A0	cn->cpn_lease_time.tv_nsec =3D 0;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 69d576b19eb6..dc61a8adfcd4 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -7020,11 +7020,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst
> *rqstp,
> =C2=A0		*nfp =3D NULL;
> =C2=A0
> =C2=A0	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid)) {
> -		if (cstid)
> -			status =3D nfserr_bad_stateid;
> -		else
> -			status =3D check_special_stateids(net, fhp,
> stateid,
> -
> 									flags);
> +		status =3D check_special_stateids(net, fhp, stateid,
> flags);
> =C2=A0		goto done;
> =C2=A0	}
> =C2=A0

Nice cleanup.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

