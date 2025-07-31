Return-Path: <linux-nfs+bounces-13359-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48837B1786D
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A7B17C1E0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B09F266573;
	Thu, 31 Jul 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bePk/JrV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA225FA00
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753998565; cv=none; b=Rzh5J8gxjwucZSmWuuFBOJnVS5KQc9kcFkKu9O5MHnL8FTwE3kKae3o63XiiIJ92GOrcIE+OycTNfGDwwqQ8zdfQ8ppDrReBrjcI5zQNZpxMiYPCVDv2uXjaapRpIIZIxFj7wNjzySYtBuVkqaCWsAZAvKJl+LRGw6VB79VYXEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753998565; c=relaxed/simple;
	bh=IsrZ9pDzyn2FbFV01R+949d2j3tFDQOKMD0WyfIHQxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFQgoW4pBaybnDp22HtGKval4Xw80xXHV8gwowuOmCj37RvTgqIS6mfPhmksdSQ2mWmYgKA1vQ05sTyH6AsPGrm5LUIOAieNlNDO8AyE67ICZ5tRJA08+I/5GIpFVVMe9NuoPJfzTQJRsqbvvPiltOdNY9Yrv8rpKKJiN2BueEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bePk/JrV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753998562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hHj5xH4R+P37siFUDPZLmpm1nW06q+7WgjWP5fY1b8w=;
	b=bePk/JrVBI9kNmxZTnmYNZI3evUXveR3djvmblOrnBM306vSOV6ypWzDLszpQ6lk12JoWz
	hUAZ+OR5l8VQNiD6wNfHzJ3HdmuODzf1eEYFZOX+/9SFqi1LUdQm9G4eTV0EIbHagm86zk
	vjimuCOLNSU72/xXL2Ujb4JWA2W4bt0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-KoGbl1N8PUG_wWRWlyPkeg-1; Thu,
 31 Jul 2025 17:49:19 -0400
X-MC-Unique: KoGbl1N8PUG_wWRWlyPkeg-1
X-Mimecast-MFC-AGG-ID: KoGbl1N8PUG_wWRWlyPkeg_1753998557
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B82721800446;
	Thu, 31 Jul 2025 21:49:17 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.132])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B1CC3000199;
	Thu, 31 Jul 2025 21:49:17 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 584DF35DA6A; Thu, 31 Jul 2025 17:49:15 -0400 (EDT)
Date: Thu, 31 Jul 2025 17:49:15 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: chuck.lever@oracle.com, jlayton@kernel.org
Cc: neil@brown.name, okorniev@redhat.com, Dai.Ngo@oracle.com,
	tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
Message-ID: <aIvk266w5fxJwUhQ@aion>
References: <20250731211441.1908508-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250731211441.1908508-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, 31 Jul 2025, Scott Mayhew wrote:

> A while back I had reported that an NFSv3 client could successfully
> mount using '-o xprtsec=none' an export that had been exported with
> 'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
> would succeed and the mount would show up in /proc/mounts.  Attempting
> to do anything futher with the mount would be met with NFS3ERR_ACCES.
> 
> This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
> NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
> subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
> NLM under XPRTSEC policies").
> 
> Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
> so they shouldn't be conflated when determining whether the access
> checks can be bypassed.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> ---
>  fs/nfsd/export.c   | 60 ++++++++++++++++++++++++++++++++++++----------
>  fs/nfsd/export.h   |  1 +
>  fs/nfsd/nfs4proc.c |  6 ++++-
>  fs/nfsd/nfs4xdr.c  |  3 +++
>  fs/nfsd/nfsfh.c    |  8 +++++++
>  fs/nfsd/vfs.c      |  3 +++
>  6 files changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> index cadfc2bae60e..bc54b01bb516 100644
> --- a/fs/nfsd/export.c
> +++ b/fs/nfsd/export.c
> @@ -1082,19 +1082,27 @@ static struct svc_export *exp_find(struct cache_detail *cd,
>  }
>  
>  /**
> - * check_nfsd_access - check if access to export is allowed.
> + * check_xprtsec_policy - check if access to export is permitted by the
> + * 			  xprtsec policy
>   * @exp: svc_export that is being accessed.
>   * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> - * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * This logic should not be combined with check_nfsd_access, as the rules
> + * for bypassing GSS are not the same as for bypassing the xprtsec policy
> + * check:
> + * 	- NFSv3 FSINFO and GETATTR can bypass the GSS for the root dentry,
> + * 	  but that doesn't mean they can bypass the xprtsec poolicy check

typo

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
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
>  {
> -	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
>  	struct svc_xprt *xprt;
>  
>  	/*
> @@ -1110,22 +1118,49 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  
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
>  
> -ok:
> +	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> +}
> +
> +/**
> + * check_nfsd_access - check if access to export is allowed.
> + * @exp: svc_export that is being accessed.
> + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> + * @may_bypass_gss: reduce strictness of authorization check
> + *
> + * Return values:
> + *   %nfs_ok if access is granted, or
> + *   %nfserr_wrongsec if access is denied
> + */
> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> +			 bool may_bypass_gss)
> +{
> +	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
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
> +	xprt = rqstp->rq_xprt;
> +
>  	/* legacy gss-only clients are always OK: */
>  	if (exp->ex_client == rqstp->rq_gssclient)
>  		return nfs_ok;
> @@ -1167,7 +1202,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  		}
>  	}
>  
> -denied:
>  	return nfserr_wrongsec;
>  }
>  
> diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> index b9c0adb3ce09..c5a45f4b72be 100644
> --- a/fs/nfsd/export.h
> +++ b/fs/nfsd/export.h
> @@ -101,6 +101,7 @@ struct svc_expkey {
>  
>  struct svc_cred;
>  int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
> +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
>  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
>  			 bool may_bypass_gss);
>  
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index 71b428efcbb5..71e9a170f7bf 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -2902,8 +2902,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  				clear_current_stateid(cstate);
>  
>  			if (current_fh->fh_export &&
> -					need_wrongsec_check(rqstp))
> +					need_wrongsec_check(rqstp)) {
> +				op->status = check_xprtsec_policy(current_fh->fh_export, rqstp);
> +				if (op->status)
> +					goto encode_op;
>  				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> +			}
>  		}
>  encode_op:
>  		if (op->status == nfserr_replay_me) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index ea91bad4eee2..48d55c13c918 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3859,6 +3859,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
>  			nfserr = nfserrno(err);
>  			goto out_put;
>  		}
> +		nfserr = check_xprtsec_policy(exp, cd->rd_rqstp);
> +		if (nfserr)
> +			goto out_put;
>  		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
>  		if (nfserr)
>  			goto out_put;
> diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> index 74cf1f4de174..1ffc33662582 100644
> --- a/fs/nfsd/nfsfh.c
> +++ b/fs/nfsd/nfsfh.c
> @@ -364,6 +364,14 @@ __fh_verify(struct svc_rqst *rqstp,
>  	if (error)
>  		goto out;
>  
> +	if (access & NFSD_MAY_NLM)
> +		/* NLM is allowed to bypass the xprtssec policy check */
> +		goto out;

This would automatically bypass the auth check too.  I'll send a v2.

> +
> +	error = check_xprtsec_policy(exp, rqstp);
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
> @@ -323,6 +323,9 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
>  	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
>  	if (err)
>  		return err;
> +	err = check_xprtsec_policy(exp, rqstp);
> +	if (err)
> +		goto out;
>  	err = check_nfsd_access(exp, rqstp, false);
>  	if (err)
>  		goto out;
> -- 
> 2.48.1
> 
> 


