Return-Path: <linux-nfs+bounces-5840-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8D961C6E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 05:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC4F7B210D5
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 03:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3F288D1;
	Wed, 28 Aug 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWP4t0PL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56743288B1
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724814022; cv=none; b=l9glSUZV9Ae4yZWQkEOrbQdHo9Fg1dgT0WSx87eJuwsKU25/9C50p7NuakpVc4ZMGjNLMnjJutMVdMmWa1h/JiW4dHSHSOBq62isczelPabQKMSOuIE6eVe737Ejhpr9Q4kMUv2w/YaFzZ3zFhxLqDbHRTjkn43UPysDvcc2nEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724814022; c=relaxed/simple;
	bh=x9Th5t55BfK0FLs+SFSYEWomuqk2VYx3zDleSLEw/sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVXPOZULaU1sOrg+GHieN93g0u2y/KJPRuTd2y3jmNfM9k59AklPc6oN26cUyWYhDvzIFxILKtABSWO5fym3Is2m7IvXBcXOkU0oe2dwqIbrDrU5WTmYJZVjlpWmp4mZR3xwjl17qPt+YZtGwPmpbinLocVAg7UtvYDsVI4Lp+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWP4t0PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A6CC4DE12;
	Wed, 28 Aug 2024 03:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724814021;
	bh=x9Th5t55BfK0FLs+SFSYEWomuqk2VYx3zDleSLEw/sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bWP4t0PLQ/yEmMWIVx/+6GtzQDFTyu41EZ6IQzgIV6JczXciM5MqkTK8fhO+XHBR1
	 XSYKPUXxYlumsC5tsdUm8OAe9m7AUlObPU5bn+V+ZHpmPVT7SVZ9TJxzWgow6PoSle
	 BRKKEHWrtBO+Sfe9fOMvoi8nkHGJkfhyrz6x2aOSH4jzuPaxVgwnLlocyYGTbuzB/B
	 np5M1eh7OepsOgF8NuqSqicrfPKZ9y3jJ5CZG54gCepAj3GU54lON5EKD+oXp5u5/J
	 /3Ms1w/P+RFY3n0kg6NHHFNgri0+8/EekhCHZ7d8xQPjFn3v46OYH1pjLv4bDiDEx1
	 7kKd/QeqK7nhw==
Date: Tue, 27 Aug 2024 23:00:20 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in
 check_nfsd_access()
Message-ID: <Zs6SxCUgv8yl9aqg@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
 <20240828004445.22634-2-cel@kernel.org>
 <172480752028.4433.11727348270307536121@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172480752028.4433.11727348270307536121@noble.neil.brown.name>

On Wed, Aug 28, 2024 at 11:12:00AM +1000, NeilBrown wrote:
> On Wed, 28 Aug 2024, cel@kernel.org wrote:
> > From: NeilBrown <neilb@suse.de>
> > 
> > LOCALIO-initiated open operations are not running in an nfsd thread
> > and thus do not have an associated svc_rqst context.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  fs/nfsd/export.c | 29 ++++++++++++++++++++++++-----
> >  1 file changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 7bb4f2075ac5..46a4d989c850 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -1074,10 +1074,29 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> >  	return exp;
> >  }
> >  
> > +/**
> > + * check_nfsd_access - check if access to export is allowed.
> > + * @exp: svc_export that is being accessed.
> > + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> > + *
> > + * Return values:
> > + *   %nfs_ok if access is granted, or
> > + *   %nfserr_wrongsec if access is denied
> > + */
> >  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> >  {
> >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> > -	struct svc_xprt *xprt = rqstp->rq_xprt;
> > +	struct svc_xprt *xprt;
> > +
> > +	/*
> > +	 * The target use case for rqstp being NULL is LOCALIO, which
> > +	 * currently only supports AUTH_UNIX. The behavior for LOCALIO
> > +	 * is therefore the same as the AUTH_UNIX check below.
> 
> The "AUTH_UNIX check below" only applies if exp->ex_flavours == 0.
> To make "rqstp == NULL" mean "treat like AUTH_UNIX" I think we need
> to confirm that 
>   exp->ex_xprtsec_mods & NFSEXP_XPRTSEC_NONE
> and either
>   exp->ex_nflavours == 0
> or
>   one for the exp->ex_flavors->pseudoflavor values is RPC_AUTH_UNIX
> 
> I'm not sure that is all really necessary, but if not then we probably
> need a better comment...

Think extra checks aren't needed (unless you think a NULL rqstp
_without_ the use of LOCALIO possible?  which could trigger a false
positive granting of access? seems unlikely but...)

Mike

