Return-Path: <linux-nfs+bounces-13052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BED8AB041E4
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 16:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AA64A2111
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jul 2025 14:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6725744D;
	Mon, 14 Jul 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUbo93lO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE8E2561D1
	for <linux-nfs@vger.kernel.org>; Mon, 14 Jul 2025 14:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503828; cv=none; b=VnaDikkwb4HIcbx/wP28ZxpX3AY82vFQZVsij2CvwAcJojMV9doKVTzcK0hmUMSbAFHd9JGwYtBCYBAn/a9BI7+zmMkypPEwBi91ToNhtsASsOoACKYh6x2YEcvxVOZd34DcjWWudMPrslBp0G8OzjIgQGX9JwWQT2cWMb4L8CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503828; c=relaxed/simple;
	bh=21XZ3riQtYxdqcJeJOimcaBH789K+gWXp6n6zdf4dec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyhQeiS41xFsf1jAas/rNqekl1lmLcYKGS4sYWIPTnf1b0HpdnSmXkWtKXOw9cSM652YodAxEhRDjCUugZipz2b1M02Ml0jMY3DG7c00ySkZq752uAY2iPxB/U3g49Mi+MU8TuxHRZ+FHn6d7rppeSEXGBGJNHCiIVV558t8saw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUbo93lO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DE6C4CEED;
	Mon, 14 Jul 2025 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752503828;
	bh=21XZ3riQtYxdqcJeJOimcaBH789K+gWXp6n6zdf4dec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUbo93lOYS+W3XuPE72ZH8mcpi0qp3wPP6/VMisjzte8zU7Ak2yNVvFqczOsfwbIJ
	 z90S5EkIkeoXC2KHan8hvrvmFc+MDEQ7MC5J0NiL278W7s6O+0cuobObXEuVyf1yC7
	 uyB9UXFTYbhuaBlWzKy3kcTDBes3pohuMy332GMaVlV1jSTXiAxMPPdvfAYmiQ4l0S
	 IrHYhwKUL5lupdxOGc/1fsj6EwcP2YvRhiVAiS5LbCuqYwZ8TXbhZu3rvzTy1vrRUK
	 iyt5xJ/WNDNhfGibaIeJYnTYl1V2GMlBvArmYCXq+5ccN6mZ4jKF9bOrYzURPGXyjK
	 JFFdZfZOiZEhg==
Date: Mon, 14 Jul 2025 10:37:07 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [for-6.16-final PATCH 8/9] nfs/localio: avoid bouncing LOCALIO
 if nfs_client_is_local()
Message-ID: <aHUWE5WEFKS8SrQQ@kernel.org>
References: <20250714031359.10192-1-snitzer@kernel.org>
 <20250714031359.10192-9-snitzer@kernel.org>
 <175246677378.2234665.12729957094794033029@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175246677378.2234665.12729957094794033029@noble.neil.brown.name>

On Mon, Jul 14, 2025 at 02:19:33PM +1000, NeilBrown wrote:
> On Mon, 14 Jul 2025, Mike Snitzer wrote:
> > From: Mike Snitzer <snitzer@hammerspace.com>
> > 
> > Previously nfs_local_probe() was made to disable and then attempt to
> > re-enable LOCALIO (via LOCALIO protocol handshake) if/when it was
> > called and LOCALIO already enabled.
> > 
> > Vague memory for _why_ this was the case is that this was useful
> > if/when a local NFS server were to be restarted with a local NFS
> > client connected to it.
> > 
> > But as it happens this causes an absurd amount of LOCALIO flapping
> > which has a side-effect of too much IO being needlessly sent to NFSD
> > (using RPC over the loopback network interface).  This is the
> > definition of "serious performance loss" (that negates the point of
> > having LOCALIO).
> > 
> > So remove this mis-optimization for re-enabling LOCALIO if/when an NFS
> > server is restarted (which is an extremely rare thing to do).  Will
> > revisit testing that scenario again but in the meantime this patch
> > restores the full benefit of LOCALIO.
> > 
> > Fixes: 56bcd0f07fdb ("nfs: implement client support for NFS_LOCALIO_PROGRAM")
> > Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> 
> I cannot see any justification for probing if localio is currently
> thought to be working.  If for some reason it doesn't work, then when we
> notice that is a good time to disable - which it what this patch does.

Thanks for the review!

> However...
> 
> > ---
> >  fs/nfs/localio.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
> > index a4bacd9a5052..e3ae003118cb 100644
> > --- a/fs/nfs/localio.c
> > +++ b/fs/nfs/localio.c
> > @@ -180,10 +180,8 @@ static void nfs_local_probe(struct nfs_client *clp)
> >  		return;
> >  	}
> >  
> > -	if (nfs_client_is_local(clp)) {
> > -		/* If already enabled, disable and re-enable */
> > -		nfs_localio_disable_client(clp);
> > -	}
> > +	if (nfs_client_is_local(clp))
> > +		return;
> >  
> >  	if (!nfs_uuid_begin(&clp->cl_uuid))
> >  		return;
> > @@ -241,7 +239,8 @@ __nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
> >  		case -ENOMEM:
> >  		case -ENXIO:
> >  		case -ENOENT:
> > -			/* Revalidate localio, will disable if unsupported */
> > +			/* Revalidate localio */
> > +			nfs_localio_disable_client(clp);
> >  			nfs_local_probe(clp);
> 
> Shouldn't that be nfs_local_probe_async() ????  I wonder why that wasn't
> changed in 
>   Commit 1ff4716f420b ("NFS: always probe for LOCALIO support asynchronously")

Creates the potential for many files being opened and each triggering
their own async probe.  I reasoned it best to make this error path
wait.  In practice that has worked reasonably...

Mike

