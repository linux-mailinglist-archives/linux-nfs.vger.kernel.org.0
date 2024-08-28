Return-Path: <linux-nfs+bounces-5860-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7D896291D
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 15:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4055BB21839
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7C52628C;
	Wed, 28 Aug 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLPDAvrH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C4E241E7
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852715; cv=none; b=I7n1KfezzqOVeN5BCsQynL5GN0oPVh/9vaDy3m6XmakWYM0+OTixFkYE3IbNLaAztZs43i90NF5E6EWiVyrlyWgJPaP9rSr++ppCnejyiYY5YY4p8GTyB2RBnS7nAshpRvcD/yLaz4I4e4SFSjHyWXVBYp8TXefvQ+bEGRqydi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852715; c=relaxed/simple;
	bh=T34Ox5ZbPRD07ytmd2ULWfqctE9/Zpr6ak3kk2IXVl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R/5ntUZB3M/SAfC86A8ravcWA1DnbuK2l3Vc9a07oWb1w103gJXraWydgIvScOizoeTuUVkCjrkg6uC/OYw8t8H6bA3jT0Ioh0FMgy2FIlcNwGu77GIh5MUSoHeii4ddtUXC+O7RaZF5MUzicOAGVqdNoWULBVakIhe/IGti3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLPDAvrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501EDC4FF6E;
	Wed, 28 Aug 2024 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724852714;
	bh=T34Ox5ZbPRD07ytmd2ULWfqctE9/Zpr6ak3kk2IXVl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLPDAvrHiKnTbAzTCdYJgIXNd+1wy4UMPmq4/u6mkwsPnhuCOEMCYuwfdtOb1+89z
	 /REUYgWd8kcNmPMCxjaZ6eyfaL1M7dZn+M/hXJtQ73R1SqUsdRKnFc2ghU/ztNMj+V
	 DJzwzLqZrDcGdNywtzXuTpNIK0Y4j/poaJu9vBtaM6t6NMLPoAy8Csl1ffyzU2PQN6
	 +6Qbq4jy4XVLGUa5HDBXh6sX3VMZAzrsgdOfnDkLO+sMM2dUFbtWPZe1cMS2Kn358e
	 n05MwKbHzuJ4bUFC4wcdp4xI0kx/r1/G1Vt+5wCvAre9eWuVSRuQiAcatcKweHItWx
	 DGKgKWiirKEdA==
Date: Wed, 28 Aug 2024 09:45:13 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: cel@kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in
 check_nfsd_access()
Message-ID: <Zs8p6ej4K0CLcmt0@kernel.org>
References: <>
 <Zs6SxCUgv8yl9aqg@kernel.org>
 <172482660567.4433.10002819732828170761@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172482660567.4433.10002819732828170761@noble.neil.brown.name>

On Wed, Aug 28, 2024 at 04:30:05PM +1000, NeilBrown wrote:
> On Wed, 28 Aug 2024, Mike Snitzer wrote:
> > On Wed, Aug 28, 2024 at 11:12:00AM +1000, NeilBrown wrote:
> > > On Wed, 28 Aug 2024, cel@kernel.org wrote:
> > > > From: NeilBrown <neilb@suse.de>
> > > > 
> > > > LOCALIO-initiated open operations are not running in an nfsd thread
> > > > and thus do not have an associated svc_rqst context.
> > > > 
> > > > Signed-off-by: NeilBrown <neilb@suse.de>
> > > > Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> > > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > > > ---
> > > >  fs/nfsd/export.c | 29 ++++++++++++++++++++++++-----
> > > >  1 file changed, 24 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > > > index 7bb4f2075ac5..46a4d989c850 100644
> > > > --- a/fs/nfsd/export.c
> > > > +++ b/fs/nfsd/export.c
> > > > @@ -1074,10 +1074,29 @@ static struct svc_export *exp_find(struct cache_detail *cd,
> > > >  	return exp;
> > > >  }
> > > >  
> > > > +/**
> > > > + * check_nfsd_access - check if access to export is allowed.
> > > > + * @exp: svc_export that is being accessed.
> > > > + * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
> > > > + *
> > > > + * Return values:
> > > > + *   %nfs_ok if access is granted, or
> > > > + *   %nfserr_wrongsec if access is denied
> > > > + */
> > > >  __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
> > > >  {
> > > >  	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
> > > > -	struct svc_xprt *xprt = rqstp->rq_xprt;
> > > > +	struct svc_xprt *xprt;
> > > > +
> > > > +	/*
> > > > +	 * The target use case for rqstp being NULL is LOCALIO, which
> > > > +	 * currently only supports AUTH_UNIX. The behavior for LOCALIO
> > > > +	 * is therefore the same as the AUTH_UNIX check below.
> > > 
> > > The "AUTH_UNIX check below" only applies if exp->ex_flavours == 0.
> > > To make "rqstp == NULL" mean "treat like AUTH_UNIX" I think we need
> > > to confirm that 
> > >   exp->ex_xprtsec_mods & NFSEXP_XPRTSEC_NONE
> > > and either
> > >   exp->ex_nflavours == 0
> > > or
> > >   one for the exp->ex_flavors->pseudoflavor values is RPC_AUTH_UNIX
> > > 
> > > I'm not sure that is all really necessary, but if not then we probably
> > > need a better comment...
> > 
> > Think extra checks aren't needed (unless you think a NULL rqstp
> > _without_ the use of LOCALIO possible?  which could trigger a false
> > positive granting of access? seems unlikely but...)
> > 
> 
> I agree they aren't needed.  I think we need to have a clear
> understanding of why that aren't needed, and to write that understanding
> down.  So that if some day someone wants to change this code, they can
> understand the consequences.
> 
> Maybe the answer is that LOCALIO would never ask for access that isn't
> allowed, so there is no need to check.
> 
> Maybe the client can determine the relevant xpt_flags from the client
> end of the session, so it can pass them reliably to check_nfsd_access().
> 
> I don't know what is best, but I think we should have a comment
> justifying the short-circuit, and I don't think the current proposed
> comment does that correctly.

Just to recap, this is what you had originally, which Chuck correctly
said needed improvement:

 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
        struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
        struct svc_xprt *xprt;

        if (!rqstp)
                /* Always allow LOCALIO */
                return 0;

I offered my suggestion and Chuck then tweaked it:

 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
        struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
        struct svc_xprt *xprt;

-       if (!rqstp) {
-               /*
-                * The target use case for rqstp being NULL is LOCALIO,
-                * which only supports AUTH_UNIX, so always allow LOCALIO
-                * because the other checks below aren't applicable.
-                */
-               return 0;
-       }
+       /*
+        * The target use case for rqstp being NULL is LOCALIO, which
+        * currently only supports AUTH_UNIX. The behavior for LOCALIO
+        * is therefore the same as the AUTH_UNIX check below.
+        */
+       if (!rqstp)
+               return nfs_ok;

Now you're saying that comment needs to be more precise... ;)

localio only supports AUTH_UNIX, and the client verifies that is the
method being used:

void nfs_local_probe(struct nfs_client *clp)
{
        nfs_uuid_t nfs_uuid;

        /* Disallow localio if disabled via sysfs or AUTH_SYS isn't used */
        if (!localio_enabled ||
            clp->cl_rpcclient->cl_auth->au_flavor != RPC_AUTH_UNIX) {
                nfs_local_disable(clp);
                return;
        }
	...

So I honestly feel like Chuck's latest revision is perfectly fine.
I disagree that "The behavior for LOCALIO is therefore the same as
the AUTH_UNIX check below." is inaccurate.  The precondition from the
client (used to establish localio and cause rqstp to be NULL in
check_nfsd_access) is effectively comparable no?

