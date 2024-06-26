Return-Path: <linux-nfs+bounces-4320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7EA9187CE
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179C41F2428C
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5C18FDCD;
	Wed, 26 Jun 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBVkMqC3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B2418FDC8
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420342; cv=none; b=TtP+F/b1Pmvd43AArxLU3kxwYmsyviTIAMCKHyzsqtOgkn2ERce1opPh8ooY3I2qtO80tO4F9rezpY2QrjBAshEl65Y34nxkafw2vWTeq5HHyRvXAaAyjKit4E2CbRn3lVRWLMETjZ9ZyBw82YDhBkQ8YuFVZTS9xPFJthe94Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420342; c=relaxed/simple;
	bh=mMD0ik06RyHy/I9CsAzq7J0jz0mJXWekY64TWihP910=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaoKSpNV8Yo4ww+k3SpTWYRJDGP6+dw+e+q71ds41U4XwO7S6a+A89JZNWGuxQjmmd3t23DHXX2+eQzfVQUhxjR+w75CAy7wIaICZQdgWm4SRpaemDqJCy/islwCUwozyzXUOWA2bVB2T20QBiE8FIecikyOwS0MkPozqyzDJgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBVkMqC3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BA7C116B1;
	Wed, 26 Jun 2024 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420342;
	bh=mMD0ik06RyHy/I9CsAzq7J0jz0mJXWekY64TWihP910=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBVkMqC3Fbe3bpAx3WcdYFIftQVrCfA+cv0e+qewZBAkDzooh4sqwmz9+y/oAUbVv
	 RzUV0jOrGfBSKaG+AznQt/qkRnB25OV7vNNMNZs1CTXeRoAgheV8TCMV//vYcgTNrP
	 fuXHymiaB2+JXz5o5MDkgufG3HppRX95q/xK7EquICKMFspL/1vV/DuJk1HjkBnxAI
	 tfOWq3ZfQzySuQydRQUtsmGrf0l5ZrlbnjPmPPs2sTrhksFztD3DrzODAeSh5CvnsY
	 YiSmYdh27JLM/zsiqjZUYnkpw3R2MCaRpv1G2gLQ8itbn3G4zKR4NFJseiwE9pHbu0
	 bvxLjWSOae2bg==
Date: Wed, 26 Jun 2024 12:45:40 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 13/20] nfs: implement client support for
 NFS_LOCALIO_PROGRAM
Message-ID: <ZnxFtGtANMJ821Sl@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-14-snitzer@kernel.org>
 <171935766072.14261.2299610894569720025@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171935766072.14261.2299610894569720025@noble.neil.brown.name>

On Wed, Jun 26, 2024 at 09:21:00AM +1000, NeilBrown wrote:
> On Tue, 25 Jun 2024, Mike Snitzer wrote:
> > LOCALIOPROC_GETUUID allows a client to discover the server's uuid.
> > 
> > nfs_local_probe() will retrieve server's uuid via LOCALIO protocol and
> > verify the server with that uuid it is known to be local. This ensures
> > client and server 1: support localio 2: are local to each other.
> > 
> > All the knowledge of the LOCALIO RPC protocol is in fs/nfs/localio.c
> > which implements just a single version (1) that is used independently
> > of what NFS version is used.
> > 
> > Get nfsd_open_local_fh and store it in rpc_client during client
> > creation, put the symbol during nfs_local_disable -- which is also
> > called during client destruction.
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > [neilb: factored out and simplified single localio protocol]
> > Co-developed-by: NeilBrown <neilb@suse.de>
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/nfs/client.c     |   6 +-
> >  fs/nfs/localio.c    | 159 +++++++++++++++++++++++++++++++++++++++++---
> >  include/linux/nfs.h |   7 ++
> >  3 files changed, 161 insertions(+), 11 deletions(-)
> > 
> > diff --git a/fs/nfs/client.c b/fs/nfs/client.c
> > index 1300c388f971..6faa9fdc444d 100644
> > --- a/fs/nfs/client.c
> > +++ b/fs/nfs/client.c
> > @@ -434,8 +434,10 @@ struct nfs_client *nfs_get_client(const struct nfs_client_initdata *cl_init)
> >  			list_add_tail(&new->cl_share_link,
> >  					&nn->nfs_client_list);
> >  			spin_unlock(&nn->nfs_client_lock);
> > -			nfs_local_probe(new);
> > -			return rpc_ops->init_client(new, cl_init);
> > +			new = rpc_ops->init_client(new, cl_init);
> > +			if (!IS_ERR(new))
> > +				 nfs_local_probe(new);
> > +			return new;
> 
> I would fold this back into the earlier patch that introduced
> nfs_local_probe().  It makes this patch ugly.
> But I won't insist.

I cleaned it up a bit so that this patch is cleaner, but I'd prefer to
leave it split out.

Thanks.
Mike

