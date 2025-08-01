Return-Path: <linux-nfs+bounces-13371-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C835B1820A
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 15:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21A816E1E4
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A2D35942;
	Fri,  1 Aug 2025 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ3iNrHw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76A1798F
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 13:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053220; cv=none; b=tcpb9loUeVz33X0IL/SAZeYxLtX6SUNf9CuiB+mOENaIGXvZgiUJF7MKwmPNCrzSStOPvQ8GxKdaHDdzL/zhf/ie8YjdtmTsm9UWniDoEKylzTGcmyn6PwweRKdUXuf23HA127s2NOFC0ZKqlxq3Mf+mOG339zeO5022qSZJG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053220; c=relaxed/simple;
	bh=66ImouuYZxssdSQTKDy3O3rzC5NA86d7SYjK75bxNDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bu/tKViwc9WopyzDndoAZgSLfyeAonH/Jkx0BRA038+ak6wnXXGS5rOnAr+Bwkn2FtAHlWiYwwRseBj4tqw6Fxf+C/WmwjjxVJoTnWVzdyJP+TqHl/xyFD9A6owSn1mGqxw7lRRDQCRoWvSaolcBR1AjjwtGsWszOqfd+EwaTO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ3iNrHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD67C4CEE7;
	Fri,  1 Aug 2025 13:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754053219;
	bh=66ImouuYZxssdSQTKDy3O3rzC5NA86d7SYjK75bxNDA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=LQ3iNrHwD9Xbkyzd31a5RFA7TZ2lC61pJLLMCQH7MOSWtZlZJEyvPsx5I0rfmyO+h
	 I0zPLyHHbOytkVyqJVsrsAE8mWr6MODorFdJ0Q90SaPZns2iNiE0xDrSS0lfa6Hsb3
	 GyMo2thokSIBXBFPzyqU1BvEd1imka1pDe5KNRZFMsqcZbPXJqLZWN42iZCXvN/3s6
	 SJuGndO2QnijJN8oplZWv+dN7KJa5IW3JAURiQtaYJZ97bQnNIuTxOezKubpwgo72M
	 R9f/ZAAeZHJ2zWiwyB3nwW9iSGUC8b48dgLKXQ6kWGiUFC07mmBuCl8me6cGu6bYgT
	 YXk0XDJrkGjig==
Message-ID: <eb9c1264445f41da4f5a4b6e0492d74fd4f1987a.camel@kernel.org>
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
From: Jeff Layton <jlayton@kernel.org>
To: Scott Mayhew <smayhew@redhat.com>, chuck.lever@oracle.com
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com, 	linux-nfs@vger.kernel.org
Date: Fri, 01 Aug 2025 09:00:17 -0400
In-Reply-To: <20250731211441.1908508-1-smayhew@redhat.com>
References: <20250731211441.1908508-1-smayhew@redhat.com>
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

On Thu, 2025-07-31 at 17:14 -0400, Scott Mayhew wrote:
> A while back I had reported that an NFSv3 client could successfully
> mount using '-o xprtsec=3Dnone' an export that had been exported with
> 'xprtsec=3Dtls:mtls'.  By "successfully" I mean that the mount command
> would succeed and the mount would show up in /proc/mounts.  Attempting
> to do anything futher with the mount would be met with NFS3ERR_ACCES.
>=20
> This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
> NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
> subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
> NLM under XPRTSEC policies").
>=20
> Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
> so they shouldn't be conflated when determining whether the access
> checks can be bypassed.
>=20
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/export.c   | 60 ++++++++++++++++++++++++++++++++++++----------
>  fs/nfsd/export.h   |  1 +
>  fs/nfsd/nfs4proc.c |  6 ++++-
>  fs/nfsd/nfs4xdr.c  |  3 +++
>  fs/nfsd/nfsfh.c    |  8 +++++++
>  fs/nfsd/vfs.c      |  3 +++
>  6 files changed, 67 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..bc54b01bb516 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1082,19 +1082,27 @@ static struct svc_export *exp_find(struct cache_d=
etail *cd,
>  }
> =20
>  /**
> - * check_nfsd_access - check if access to export is allowed.
> + * check_xprtsec_policy - check if access to export is permitted by the
> + * 			  xprtsec policy
>   * @exp: svc_export that is being accessed.
>   * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO)=
.
> - * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * This logic should not be combined with check_nfsd_access, as the rule=
s
> + * for bypassing GSS are not the same as for bypassing the xprtsec polic=
y
> + * check:
> + * 	- NFSv3 FSINFO and GETATTR can bypass the GSS for the root dentry,
> + * 	  but that doesn't mean they can bypass the xprtsec poolicy check

nit: "policy"

> + * 	- NLM can bypass the GSS check on exports exported with the
> + * 	  NFSEXP_NOAUTHNLM flag
> + * 	- NLM can always bypass the xprtsec policy check since TLS isn't
> + * 	  implemented for the sidecar protocols
>   *
>   * Return values:
>   *   %nfs_ok if access is granted, or
> - *   %nfserr_wrongsec if access is denied
> + *   %nfserr_acces or %nfserr_wrongsec if access is denied
>   */
> -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> -			 bool may_bypass_gss)
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqs=
tp)
>  {
> -	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavors;
>  	struct svc_xprt *xprt;
> =20
>  	/*
> @@ -1110,22 +1118,49 @@ __be32 check_nfsd_access(struct svc_export *exp, =
struct svc_rqst *rqstp,
> =20
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
>  		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
>  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>  		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
>  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
>  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
>  		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> -			goto ok;
> +			return nfs_ok;
>  	}
> -	if (!may_bypass_gss)
> -		goto denied;
> =20
> -ok:
> +	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> +}
> +
> +/**
> + * check_nfsd_access - check if access to export is allowed.
> + * @exp: svc_export that is being accessed.
> + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO)=
.
> + * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * Return values:
> + *   %nfs_ok if access is granted, or
> + *   %nfserr_wrongsec if access is denied
> + */
> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> +			 bool may_bypass_gss)
> +{
> +	struct exp_flavor_info *f, *end =3D exp->ex_flavors + exp->ex_nflavors;
> +	struct svc_xprt *xprt;
> +
> +	/*
> +	 * If rqstp is NULL, this is a LOCALIO request which will only
> +	 * ever use a filehandle/credential pair for which access has
> +	 * been affirmed (by ACCESS or OPEN NFS requests) over the
> +	 * wire. So there is no need for further checks here.
> +	 */
> +	if (!rqstp)
> +		return nfs_ok;
> +
> +	xprt =3D rqstp->rq_xprt;
> +
>  	/* legacy gss-only clients are always OK: */
>  	if (exp->ex_client =3D=3D rqstp->rq_gssclient)
>  		return nfs_ok;
> @@ -1167,7 +1202,6 @@ __be32 check_nfsd_access(struct svc_export *exp, st=
ruct svc_rqst *rqstp,
>  		}
>  	}
> =20
> -denied:
>  	return nfserr_wrongsec;
>  }
> =20
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index b9c0adb3ce09..c5a45f4b72be 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -101,6 +101,7 @@ struct svc_expkey {
> =20
>  struct svc_cred;
>  int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqs=
tp);
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  			 bool may_bypass_gss);
> =20
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..71e9a170f7bf 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2902,8 +2902,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				clear_current_stateid(cstate);
> =20
>  			if (current_fh->fh_export &&
> -					need_wrongsec_check(rqstp))
> +					need_wrongsec_check(rqstp)) {
> +				op->status =3D check_xprtsec_policy(current_fh->fh_export, rqstp);
> +				if (op->status)
> +					goto encode_op;
>  				op->status =3D check_nfsd_access(current_fh->fh_export, rqstp, false=
);
> +			}
>  		}
>  encode_op:
>  		if (op->status =3D=3D nfserr_replay_me) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..48d55c13c918 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3859,6 +3859,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd,=
 const char *name,
>  			nfserr =3D nfserrno(err);
>  			goto out_put;
>  		}
> +		nfserr =3D check_xprtsec_policy(exp, cd->rd_rqstp);
> +		if (nfserr)
> +			goto out_put;
>  		nfserr =3D check_nfsd_access(exp, cd->rd_rqstp, false);
>  		if (nfserr)
>  			goto out_put;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 74cf1f4de174..1ffc33662582 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -364,6 +364,14 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
> =20
> +	if (access & NFSD_MAY_NLM)
> +		/* NLM is allowed to bypass the xprtssec policy check */
> +		goto out;
> +
> +	error =3D check_xprtsec_policy(exp, rqstp);
> +	if (error)
> +		goto out;
> +
>  	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
>  		/* NLM is allowed to fully bypass authentication */
>  		goto out;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 98ab55ba3ced..1b66aff1d750 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -323,6 +323,9 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fh=
p, const char *name,
>  	err =3D nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
>  	if (err)
>  		return err;
> +	err =3D check_xprtsec_policy(exp, rqstp);
> +	if (err)
> +		goto out;
>  	err =3D check_nfsd_access(exp, rqstp, false);
>  	if (err)
>  		goto out;

The rest looks fine to me (though I wouldn't object to adding a helper
that calls both functions, like Neil suggested).

Reviewed-by: Jeff Layton <jlayton@kernel.org>

