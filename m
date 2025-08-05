Return-Path: <linux-nfs+bounces-13431-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE39B1B6E4
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 16:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 760F17A8119
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 14:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E9B25D1E5;
	Tue,  5 Aug 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTxTo3dj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D212264A0
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754405517; cv=none; b=ZxerzIkNMyQwO3nWpBvxPpXKGdFB0Y4r/tmqt5ueXND3W46yZ/Vqpby3NdCfdFeC7/gowwANdfVJ072Hcp8YwlcE4Roso8cePMcWWNP3sQw9RSPZ/nktC4jkOLYBIq9pHJtXgFY1uyHVytpN3j9mociqG+Q4yu0/02jWD/qHTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754405517; c=relaxed/simple;
	bh=1ShUpsqeRjNqXWO2kqU50HHgMfb2r0X3hmaBpIEvcco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCfna0U0+4EQnO9/EUZ5/4L2iLYy2eVRL+sjzADzg9oS6XwePFfaJIJ/1jDp2GslYGjPzgUW+rrp3TQfX02TmvUxpF3RElgexsnVwYMyfcf2bAUUW6J2wE/nFITG2TLc2vEEHHNEuT+JXZzI1Ghr2xZTEFnCSJ8aFKaTX9bSI24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTxTo3dj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754405515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDJC/DX10QnqtvwgZsy+DQWYCyAa3GWiCR1DDsDbUWg=;
	b=DTxTo3djDU8R1bHlln2VsY6P/QwfVTPM1Me9f+1kexo2+wVEqbJkSSHfu0PPLiYxYwnqBs
	nRAdOjXWTRSQSnvswyxLL8HCggW+M0KWORCNlFvUsT+5RVdSXSsI+rQA4uZFF0M8KrvQtJ
	UfmP2i8z3MYsYwbRbtvmGg0ibGoOOVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-XmZ7gbMPOOC1OxVgBcaLaA-1; Tue,
 05 Aug 2025 10:51:51 -0400
X-MC-Unique: XmZ7gbMPOOC1OxVgBcaLaA-1
X-Mimecast-MFC-AGG-ID: XmZ7gbMPOOC1OxVgBcaLaA_1754405510
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D27D2195608F;
	Tue,  5 Aug 2025 14:51:49 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.50])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 812101954B11;
	Tue,  5 Aug 2025 14:51:49 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 7AC0E35ED91; Tue, 05 Aug 2025 10:51:47 -0400 (EDT)
Date: Tue, 5 Aug 2025 10:51:47 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: jlayton@kernel.org, neil@brown.name, okorniev@redhat.com,
	Dai.Ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nfsd: decouple the xprtsec policy check from
 check_nfsd_access()
Message-ID: <aJIag6X9YdeebM-s@aion>
References: <20250731211441.1908508-1-smayhew@redhat.com>
 <3cd2b16e-d264-48e0-ba20-0c666d88d39c@oracle.com>
 <aJIV6I5MNYOU1YQC@aion>
 <ba8cc0ad-29f7-4064-8405-95f17ac46c64@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8cc0ad-29f7-4064-8405-95f17ac46c64@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, 05 Aug 2025, Chuck Lever wrote:

> On 8/5/25 10:32 AM, Scott Mayhew wrote:
> > On Fri, 01 Aug 2025, Chuck Lever wrote:
> > 
> >> On 7/31/25 5:14 PM, Scott Mayhew wrote:
> 
> >>> +}
> >>> +
> >>> +/**
> >>> + * check_nfsd_access - check if access to export is allowed.
> >>> + * @exp: svc_export that is being accessed.
> >>> + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> >>> + * @may_bypass_gss: reduce strictness of authorization check
> >>> + *
> >>> + * Return values:
> >>> + *   %nfs_ok if access is granted, or
> >>> + *   %nfserr_wrongsec if access is denied
> >>> + */
> >>> +__be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> >>> +			 bool may_bypass_gss)
> >>> +{
> >>> +	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> >>> +	struct svc_xprt *xprt;
> >>> +
> >>> +	/*
> >>> +	 * If rqstp is NULL, this is a LOCALIO request which will only
> >>> +	 * ever use a filehandle/credential pair for which access has
> >>> +	 * been affirmed (by ACCESS or OPEN NFS requests) over the
> >>> +	 * wire. So there is no need for further checks here.
> >>> +	 */
> >>> +	if (!rqstp)
> >>> +		return nfs_ok;
> >>
> >> Is this true of all of check_nfsd_access's callers, or only of
> >> __fh_verify ?
> >>
> > Looking at the commit where this check was added, and looking at the
> > other callers, it looks like this is only true of __fh_verify().
> > 
> > I'm splitting up check_nfsd_access() into two helpers has you suggested,
> > having __fh_verify() call the helpers directly while having the other
> > callers continue to use check_nfsd_access().
> > 
> > Should I add an argument to the helpers indicate when they have been
> > called directly?  Something like 'bool maybe_localio', which can
> > then be incorporated into the above check, e.g.
> > 
> >         if (!rqstp) {
> >                 if (maybe_localio) {
> >                         return nfs_ok;
> >                 } else {
> >                         WARN_ON_ONCE(1);
> >                         return nfserr_wrongsec;
> >                 }
> >         }
> 
> If __fh_verify is the only call site that can invoke these helpers with
> rqstp == NULL, then __fh_verify seems like the place to do this check,
> not in the helpers. But maybe I've misunderstood something?

No, that makes sense.  Thanks.
> 
> 
> >>> +
> >>> +	xprt = rqstp->rq_xprt;
> >>> +
> >>>  	/* legacy gss-only clients are always OK: */
> >>>  	if (exp->ex_client == rqstp->rq_gssclient)
> >>>  		return nfs_ok;
> >>> @@ -1167,7 +1202,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
> >>>  		}
> >>>  	}
> >>>  
> >>> -denied:
> >>>  	return nfserr_wrongsec;
> >>>  }
> >>>  
> 
> 
> -- 
> Chuck Lever
> 


