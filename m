Return-Path: <linux-nfs+bounces-13429-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20571B1B693
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 16:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDCAC3B40C5
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA94B22F74D;
	Tue,  5 Aug 2025 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcMkpF6K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E9622F74A
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404346; cv=none; b=UKVKGUGY/Z+OVZlTIqw3FFyRpyySzcxU09KQQphyHv9HbCBKhAZ3qm7MALdiXYU+WwaXx2BMmcYLXx79AcCP9x0x0TfmSyXiIWepts6pXKs8dx5OBt1lhsKnLM/Q0xV8qBXWOj5gI9fQTUDURipe8SKNzzBTJeyUE1yH9dPlfF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404346; c=relaxed/simple;
	bh=Oa5dBFqE7zozaqo/gxMCig8/KlU5zR4ylaGk/AcSczQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdCMowPR4mXMccI/LAT3bR2DlcWO1GOODjjzi0bKRMH9DCTlmFlC24WYzfDhwEfy5UBsd3IOxE7+5DPJbbj2JTOsoX1Pcp6ANYx02WO6Pw4LhSrUXDuxciSCgcjJrP9wTPOGhVdlPRY9y+m50bFMX4qWnfkXx+OYKtZtlKR4/dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcMkpF6K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754404343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vuz+2MBlUbvPWZfVMpblLhvpLoCaY0PoqM4u8GaYGXo=;
	b=PcMkpF6KccDPpCbWit8hIm8rOWhRYEYEeNMHJJR4YFldcFnWmE/o65qsmzKU92rYpp2/bE
	tV2C4kvNGGgS4TFEoMC1G+3ECNUekXtP6Txvi3TdqEgKSukMDjRo3+vv9pLe7TxgmQMxlO
	llxBlnv7prVElchBVb1+y1kbQscnV7I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-gYpRAh6VN8StuAX_0Uoj9g-1; Tue,
 05 Aug 2025 10:32:18 -0400
X-MC-Unique: gYpRAh6VN8StuAX_0Uoj9g-1
X-Mimecast-MFC-AGG-ID: gYpRAh6VN8StuAX_0Uoj9g_1754404333
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F7B019774F3;
	Tue,  5 Aug 2025 14:32:10 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4021B1954B0E;
	Tue,  5 Aug 2025 14:32:10 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id B1E3535ECC3; Tue, 05 Aug 2025 10:32:08 -0400 (EDT)
Date: Tue, 5 Aug 2025 10:32:08 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
Message-ID: <aJIV6I5MNYOU1YQC@aion>
References: <20250731211441.1908508-1-smayhew@redhat.com>
 <3cd2b16e-d264-48e0-ba20-0c666d88d39c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cd2b16e-d264-48e0-ba20-0c666d88d39c@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, 01 Aug 2025, Chuck Lever wrote:

> On 7/31/25 5:14 PM, Scott Mayhew wrote:
> > A while back I had reported that an NFSv3 client could successfully
> > mount using '-o xprtsec=none' an export that had been exported with
> > 'xprtsec=tls:mtls'.  By "successfully" I mean that the mount command
> > would succeed and the mount would show up in /proc/mounts.  Attempting
> > to do anything futher with the mount would be met with NFS3ERR_ACCES.
> 
> I agree, though it doesn't compromise access to file data, that's not
> the most desirable behavior.
> 
> Can you find your report on lore, and a Link: to it here in the patch
> description?

Will do.
> 
> 
> > This was fixed (albeit accidentally) by bb4f07f2409c ("nfsd: Fix
> > NFSD_MAY_BYPASS_GSS and NFSD_MAY_BYPASS_GSS_ON_ROOT") and was
> > subsequently re-broken by 0813c5f01249 ("nfsd: fix access checking for
> > NLM under XPRTSEC policies").
> > 
> > Transport Layer Security isn't an RPC security flavor or pseudo-flavor,
> > so they shouldn't be conflated when determining whether the access
> > checks can be bypassed.
> 
> Fixes: 9280c5774314 ("NFSD: Handle new xprtsec= export option")
> 
> 
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> >  fs/nfsd/export.c   | 60 ++++++++++++++++++++++++++++++++++++----------
> >  fs/nfsd/export.h   |  1 +
> >  fs/nfsd/nfs4proc.c |  6 ++++-
> >  fs/nfsd/nfs4xdr.c  |  3 +++
> >  fs/nfsd/nfsfh.c    |  8 +++++++
> >  fs/nfsd/vfs.c      |  3 +++
> >  6 files changed, 67 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index cadfc2bae60e..bc54b01bb516 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1082,19 +1082,27 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> >  }
> >  
> >  /**
> > - * check_nfsd_access - check if access to export is allowed.
> > + * check_xprtsec_policy - check if access to export is permitted by the
> > + * 			  xprtsec policy
> >   * @exp: svc_export that is being accessed.
> >   * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> > - * @may_bypass_gss: reduce strictness of authorization check
> > + *
> > + * This logic should not be combined with check_nfsd_access, as the rules
> > + * for bypassing GSS are not the same as for bypassing the xprtsec policy
> > + * check:
> > + * 	- NFSv3 FSINFO and GETATTR can bypass the GSS for the root dentry,
> > + * 	  but that doesn't mean they can bypass the xprtsec poolicy check
> > + * 	- NLM can bypass the GSS check on exports exported with the
> > + * 	  NFSEXP_NOAUTHNLM flag
> > + * 	- NLM can always bypass the xprtsec policy check since TLS isn't
> > + * 	  implemented for the sidecar protocols
> >   *
> >   * Return values:
> >   *   %nfs_ok if access is granted, or
> > - *   %nfserr_wrongsec if access is denied
> > + *   %nfserr_acces or %nfserr_wrongsec if access is denied
> >   */
> > -__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> > -			 bool may_bypass_gss)
> > +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp)
> >  {
> > -	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> >  	struct svc_xprt *xprt;
> >  
> >  	/*
> > @@ -1110,22 +1118,49 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> >  
> >  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
> >  		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
> > -			goto ok;
> > +			return nfs_ok;
> >  	}
> >  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_TLS) {
> >  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
> >  		    !test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> > -			goto ok;
> > +			return nfs_ok;
> >  	}
> >  	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_MTLS) {
> >  		if (test_bit(XPT_TLS_SESSION, &xprt->xpt_flags) &&
> >  		    test_bit(XPT_PEER_AUTH, &xprt->xpt_flags))
> > -			goto ok;
> > +			return nfs_ok;
> >  	}
> > -	if (!may_bypass_gss)
> > -		goto denied;
> >  
> > -ok:
> > +	return rqstp->rq_vers < 4 ? nfserr_acces : nfserr_wrongsec;
> 
> We recently spilled a lot of electrons trying to get these version
> checks out of the generic security checking paths. For one thing, this
> particular check is valid only for the NFS program.
> 
> Returning nfserr_wrongsec unconditionally, as check_nfsd_access now
> does, should be sufficient.

Okay.
> 
> 
> > +}
> > +
> > +/**
> > + * check_nfsd_access - check if access to export is allowed.
> > + * @exp: svc_export that is being accessed.
> > + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> > + * @may_bypass_gss: reduce strictness of authorization check
> > + *
> > + * Return values:
> > + *   %nfs_ok if access is granted, or
> > + *   %nfserr_wrongsec if access is denied
> > + */
> > +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> > +			 bool may_bypass_gss)
> > +{
> > +	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> > +	struct svc_xprt *xprt;
> > +
> > +	/*
> > +	 * If rqstp is NULL, this is a LOCALIO request which will only
> > +	 * ever use a filehandle/credential pair for which access has
> > +	 * been affirmed (by ACCESS or OPEN NFS requests) over the
> > +	 * wire. So there is no need for further checks here.
> > +	 */
> > +	if (!rqstp)
> > +		return nfs_ok;
> 
> Is this true of all of check_nfsd_access's callers, or only of
> __fh_verify ?
> 
Looking at the commit where this check was added, and looking at the
other callers, it looks like this is only true of __fh_verify().

I'm splitting up check_nfsd_access() into two helpers has you suggested,
having __fh_verify() call the helpers directly while having the other
callers continue to use check_nfsd_access().

Should I add an argument to the helpers indicate when they have been
called directly?  Something like 'bool maybe_localio', which can
then be incorporated into the above check, e.g.

        if (!rqstp) {
                if (maybe_localio) {
                        return nfs_ok;
                } else {
                        WARN_ON_ONCE(1);
                        return nfserr_wrongsec;
                }
        }



> 
> > +
> > +	xprt = rqstp->rq_xprt;
> > +
> >  	/* legacy gss-only clients are always OK: */
> >  	if (exp->ex_client == rqstp->rq_gssclient)
> >  		return nfs_ok;
> > @@ -1167,7 +1202,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> >  		}
> >  	}
> >  
> > -denied:
> >  	return nfserr_wrongsec;
> >  }
> >  
> > diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
> > index b9c0adb3ce09..c5a45f4b72be 100644
> > --- a/fs/nfsd/export.h
> > +++ b/fs/nfsd/export.h
> > @@ -101,6 +101,7 @@ struct svc_expkey {
> >  
> >  struct svc_cred;
> >  int nfsexp_flags(struct svc_cred *cred, struct svc_export *exp);
> > +__be32 check_xprtsec_policy(struct svc_export *exp, struct svc_rqst *rqstp);
> >  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> >  			 bool may_bypass_gss);
> >  
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index 71b428efcbb5..71e9a170f7bf 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -2902,8 +2902,12 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
> >  				clear_current_stateid(cstate);
> >  
> >  			if (current_fh->fh_export &&
> > -					need_wrongsec_check(rqstp))
> > +					need_wrongsec_check(rqstp)) {
> > +				op->status = check_xprtsec_policy(current_fh->fh_export, rqstp);
> > +				if (op->status)
> > +					goto encode_op;
> >  				op->status = check_nfsd_access(current_fh->fh_export, rqstp, false);
> > +			}
> >  		}
> >  encode_op:
> >  		if (op->status == nfserr_replay_me) {
> > diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> > index ea91bad4eee2..48d55c13c918 100644
> > --- a/fs/nfsd/nfs4xdr.c
> > +++ b/fs/nfsd/nfs4xdr.c
> > @@ -3859,6 +3859,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
> >  			nfserr = nfserrno(err);
> >  			goto out_put;
> >  		}
> > +		nfserr = check_xprtsec_policy(exp, cd->rd_rqstp);
> > +		if (nfserr)
> > +			goto out_put;
> >  		nfserr = check_nfsd_access(exp, cd->rd_rqstp, false);
> >  		if (nfserr)
> >  			goto out_put;
> > diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
> > index 74cf1f4de174..1ffc33662582 100644
> > --- a/fs/nfsd/nfsfh.c
> > +++ b/fs/nfsd/nfsfh.c
> > @@ -364,6 +364,14 @@ __fh_verify(struct svc_rqst *rqstp,
> >  	if (error)
> >  		goto out;
> >  
> > +	if (access & NFSD_MAY_NLM)
> > +		/* NLM is allowed to bypass the xprtssec policy check */
> 		/* because lockd currently does not support xprtsec */> +		goto out;
> Every check_xprtsec_policy / check_nfsd_access call site now has two
> function calls, resulting in duplicate code.
> 
> Why not leave check_nfsd_access() in place, but replace it's guts with
> two helpers, and then call the two helpers directly here in __fh_verify?

I'll create the two helpers as you suggest.

I'll still need to check the access flags for NFSD_MAY_NLM before
calling the xprtsec helper though (I'll make sure I do it in the right
place this time).

-Scott
> 
> 
> > +
> > +	error = check_xprtsec_policy(exp, rqstp);
> > +	if (error)
> > +		goto out;
> > +
> >  	if ((access & NFSD_MAY_NLM) && (exp->ex_flags & NFSEXP_NOAUTHNLM))
> >  		/* NLM is allowed to fully bypass authentication */
> >  		goto out;
> > diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> > index 98ab55ba3ced..1b66aff1d750 100644
> > --- a/fs/nfsd/vfs.c
> > +++ b/fs/nfsd/vfs.c
> > @@ -323,6 +323,9 @@ nfsd_lookup(struct svc_rqst *rqstp, struct svc_fh *fhp, const char *name,
> >  	err = nfsd_lookup_dentry(rqstp, fhp, name, len, &exp, &dentry);
> >  	if (err)
> >  		return err;
> > +	err = check_xprtsec_policy(exp, rqstp);
> > +	if (err)
> > +		goto out;
> >  	err = check_nfsd_access(exp, rqstp, false);
> >  	if (err)
> >  		goto out;
> 
> 
> -- 
> Chuck Lever
> 


