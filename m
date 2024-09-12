Return-Path: <linux-nfs+bounces-6431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF96A9774A2
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 01:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD2EB283B4D
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F5261922F8;
	Thu, 12 Sep 2024 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXRgIaUj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266A349654;
	Thu, 12 Sep 2024 23:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726182042; cv=none; b=dgG8sqFfySTVE9uT7Nhuub+eiq91VL0Vul26A6J9TvRt4dWvOBNXoQRFTXKRxvIj9BTr3a3Sd5wVM37dFynV4afVDzgAQ5YrvVYvTNwH0besToLC994zk7Gh2iQouJyA2GCLUOsAzqasRI08RfwdW4ktuxF8ZVG13CEbdQSajsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726182042; c=relaxed/simple;
	bh=5G7Sw6ERStMHnSLRyYxx+raV/wyRkcgxVGGq0VejuL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+vovb7B4eHgHAadSKstDeKf1m2Qjp639h+7t3EAmaqwQTvCl2gQoNNmblxc583p0p4/kK4HKyqUFlkJ/E1X+74QCgcwNwKaRHTwt4L9mdYRTT1Sd7VaXR6ZsWaygQa8XakdU+Nv+PFr+FWoBbLY/q9xZoS5wib53muXNTJNwzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXRgIaUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A256C4CEC3;
	Thu, 12 Sep 2024 23:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726182040;
	bh=5G7Sw6ERStMHnSLRyYxx+raV/wyRkcgxVGGq0VejuL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LXRgIaUjpCig52vk2laI+f6MurUxCc9bqdnn8jaR1R+x8Z7mr3CkgDV3bsK4fSr74
	 81NQ4zQiBpK+sbGQZ2QtjnUPrbseIaOJ50EJSjcCSXiq1jH1C1SE67fGup6NuL05EH
	 MhMMrC47/HsKG8PZPW5cDXPpv61WgH4hNCVTSxf6hayARwHPULWloZiOaA7p5oDwUI
	 BG+rD3FpBhRnm8scFwv1acu93r5wX9XYc4bvLbTiT9cO2bcUlCw1N3paKWajeU7Gls
	 aTQ4z6+wtLsJdXruKvalINi+gEO52flOQmi126brIi0Bx9llCqlExQaq2vZURNzUBL
	 A3raH3JQ4Ab8Q==
Received: by pali.im (Postfix)
	id 7D9A25E9; Fri, 13 Sep 2024 01:00:35 +0200 (CEST)
Date: Fri, 13 Sep 2024 01:00:35 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfsd: Fix NFSD_MAY_BYPASS_GSS and
 NFSD_MAY_BYPASS_GSS_ON_ROOT
Message-ID: <20240912230035.2u6ymgrp326u4rid@pali>
References: <20240912221917.23802-1-pali@kernel.org>
 <172618154004.17050.11278438613021939772@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172618154004.17050.11278438613021939772@noble.neil.brown.name>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 08:52:20 NeilBrown wrote:
> On Fri, 13 Sep 2024, Pali Rohár wrote:
> > Currently NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT do not bypass
> > only GSS, but bypass any authentication method. This is problem specially
> > for NFS3 AUTH_NULL-only exports.
> > 
> > The purpose of NFSD_MAY_BYPASS_GSS_ON_ROOT is described in RFC 2623,
> > section 2.3.2, to allow mounting NFS2/3 GSS-only export without
> > authentication. So few procedures which do not expose security risk used
> > during mount time can be called also with AUTH_NONE or AUTH_SYS, to allow
> > client mount operation to finish successfully.
> > 
> > The problem with current implementation is that for AUTH_NULL-only exports,
> > the NFSD_MAY_BYPASS_GSS_ON_ROOT is active also for NFS3 AUTH_UNIX mount
> > attempts which confuse NFS3 clients, and make them think that AUTH_UNIX is
> > enabled and is working. Linux NFS3 client never switches from AUTH_UNIX to
> > AUTH_NONE on active mount, which makes the mount inaccessible.
> > 
> > Fix the NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT implementation
> > and really allow to bypass only exports which have some GSS auth flavor
> > enabled.
> > 
> > The result would be: For AUTH_NULL-only export if client attempts to do
> > mount with AUTH_UNIX flavor then it will receive access errors, which
> > instruct client that AUTH_UNIX flavor is not usable and will either try
> > other auth flavor (AUTH_NULL if enabled) or fails mount procedure.
> > 
> > This should fix problems with AUTH_NULL-only or AUTH_UNIX-only exports if
> > client attempts to mount it with other auth flavor (e.g. with AUTH_NULL for
> > AUTH_UNIX-only export, or with AUTH_UNIX for AUTH_NULL-only export).
> 
> The MAY_BYPASS_GSS flag currently also bypasses TLS restrictions.  With
> your change it doesn't.  I don't think we want to make that change.

Ok. But this is not obvious really obvious ass the option has GSS in its name.

> I think that what you want to do makes sense.  Higher security can be
> downgraded to AUTH_UNIX, but AUTH_NULL mustn't be upgraded to to
> AUTH_UNIX.
> 
> Maybe that needs to be explicit in the code.  The bypass is ONLY allowed
> for AUTH_UNIX and only if something other than AUTH_NULL is allowed.

Ok, this sound good.

> Thanks,
> NeilBrown
> 
> 
> 
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  fs/nfsd/export.c   | 19 ++++++++++++++++++-
> >  fs/nfsd/export.h   |  2 +-
> >  fs/nfsd/nfs4proc.c |  2 +-
> >  fs/nfsd/nfs4xdr.c  |  2 +-
> >  fs/nfsd/nfsfh.c    | 12 +++++++++---
> >  fs/nfsd/vfs.c      |  2 +-
> >  6 files changed, 31 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 50b3135d07ac..eb11d3fdffe1 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1074,7 +1074,7 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> >  	return exp;
> >  }
> >  
> > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss)
> >  {
> >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> >  	struct svc_xprt *xprt = rqstp->rq_xprt;
> > @@ -1120,6 +1120,23 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> >  	if (nfsd4_spo_must_allow(rqstp))
> >  		return 0;
> >  
> > +	/* Some calls may be processed without authentication
> > +	 * on GSS exports. For example NFS2/3 calls on root
> > +	 * directory, see section 2.3.2 of rfc 2623.
> > +	 * For "may_bypass_gss" check that export has really
> > +	 * enabled some GSS flavor and also check that the
> > +	 * used auth flavor is without auth (none or sys).
> > +	 */
> > +	if (may_bypass_gss && (
> > +	     rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
> > +	     rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)) {
> > +		for (f = exp->ex_flavors; f < end; f++) {
> > +			if (f->pseudoflavor == RPC_AUTH_GSS ||
> > +			    f->pseudoflavor >= RPC_AUTH_GSS_KRB5)
> > +				return 0;
> > +		}
> > +	}
> > +
> >  denied:
> >  	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> >  }
> > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> > index ca9dc230ae3d..dc7cf4f6ac53 100644
> > --- a/fs/nfsd/export.h
> > +++ b/fs/nfsd/export.h
> > @@ -100,7 +100,7 @@ struct svc_expkey {
> >  #define EX_WGATHER(exp)		((exp)->ex_flags & NFSEXP_GATHERED_WRITES)
> >  
> >  int nfsexp_flags(struct svc_rqst *rqstp, struct svc_export *exp);
> > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp);
> > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp, bool may_bypass_gss);
> >  
> >  /*
> >   * Function declarations
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 2e39cf2e502a..0f67f4a7b8b2 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2791,7 +2791,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> >  
> >  			if (current_fh->fh_export &&
> >  					need_wrongsec_check(rqstp))
> > -				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
> > +				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> >  		}
> >  encode_op:
> >  		if (op->status == nfserr_replay_me) {
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index 97f583777972..b45ea5757652 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3775,7 +3775,7 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
> >  			nfserr = nfserrno(err);
> >  			goto out_put;
> >  		}
> > -		nfserr = check_nfsd_access(exp, cd->rd_rqstp);
> > +		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
> >  		if (nfserr)
> >  			goto out_put;
> >  
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index dd4e11a703aa..ed0eabfa3cb0 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -329,6 +329,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> >  {
> >  	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
> >  	struct svc_export *exp = NULL;
> > +	bool may_bypass_gss = false;
> >  	struct dentry	*dentry;
> >  	__be32		error;
> >  
> > @@ -375,8 +376,13 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> >  	 * which clients virtually always use auth_sys for,
> >  	 * even while using RPCSEC_GSS for NFS.
> >  	 */
> > -	if (access & NFSD_MAY_LOCK || access & NFSD_MAY_BYPASS_GSS)
> > +	if (access & NFSD_MAY_LOCK)
> >  		goto skip_pseudoflavor_check;
> > +	/*
> > +	 * NFS4 PUTFH may bypass GSS (see nfsd4_putfh() in nfs4proc.c).
> > +	 */
> > +	if (access & NFSD_MAY_BYPASS_GSS)
> > +		may_bypass_gss = true;
> >  	/*
> >  	 * Clients may expect to be able to use auth_sys during mount,
> >  	 * even if they use gss for everything else; see section 2.3.2
> > @@ -384,9 +390,9 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
> >  	 */
> >  	if (access & NFSD_MAY_BYPASS_GSS_ON_ROOT
> >  			&& exp->ex_path.dentry == dentry)
> > -		goto skip_pseudoflavor_check;
> > +		may_bypass_gss = true;
> >  
> > -	error = check_nfsd_access(exp, rqstp);
> > +	error = check_nfsd_access(exp, rqstp, may_bypass_gss);
> >  	if (error)
> >  		goto out;
> >  
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 29b1f3613800..b2f5ea7c2187 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -320,7 +320,7 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> >  	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> >  	if (err)
> >  		return err;
> > -	err = check_nfsd_access(exp, rqstp);
> > +	err = check_nfsd_access(exp, rqstp, false);
> >  	if (err)
> >  		goto out;
> >  	/*
> > -- 
> > 2.20.1
> > 
> > 
> 

