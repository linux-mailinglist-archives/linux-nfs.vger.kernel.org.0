Return-Path: <linux-nfs+bounces-4323-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B141A9187F3
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2A51F2441E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F018F2CB;
	Wed, 26 Jun 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNZsl43W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A341F94C
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420819; cv=none; b=beCKI1/9pktpJ7Z2UozNU1+s+Vp6X/7/Yahy6L42Rt00iupcq8Bc0FGrC0IcUYLNJmYNWbnWzTmDxA+o5C/tzKSdZleIOaavKZrDnk6gMOiFCkarHx9DEtnt5HIf79J1UswaLT4Z0fv9y7HGvCabmtNkO3EO3befZGTvNtT+dvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420819; c=relaxed/simple;
	bh=zLUM6/AzWderXTozcsj7yoSjy0qP1I0kO02XTUcveBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+b9z2vKgmXcjGSA8PRIDxVcsJ8DeghP2HkLtRrMBoXsFjRJe8HPWrxviXAYT5U6m8ivY4ffmxSyKtRjxnV/YTcbf6TlJwCiNAhL9IiXoLyd2ef+JkFxUvMWb0go+m66q001F5PC9ZSbjOAuUyJYhtqBH0awns6XIKdgNxo42pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNZsl43W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E695C116B1;
	Wed, 26 Jun 2024 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420819;
	bh=zLUM6/AzWderXTozcsj7yoSjy0qP1I0kO02XTUcveBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oNZsl43WaA0VyuiSgmUH/kJDnYD6So31LIF/UNAUwlCWM5Wg1Hmc+NsuWqntPrE/T
	 8l+ksVT4+pno9tRDCaOCr7UJ0aDrIgKxCOp8hsZxZEOyNzw5jyhsgpp0yWEpYYPjDx
	 DdlYZx00ppWtsTW5Nw4XYYGNwjcnQ3q4KJVp3zZ0oMd683PicxUpvq9X9MOxPZ3zcu
	 1jtWUzxZ6vgKvQFDI/uu6/FvK16r7nVRcSvvnomctF/hv7XSbf/3M7ZaSBJsKvLuSz
	 Y3lbsVBvR3kwkYJNKkenGvQ7CVGa96zbPu9mDxPFojA+s2ASzUIxpJlOVgIUf8PC1G
	 dgm9hanMuagkA==
Date: Wed, 26 Jun 2024 12:53:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [PATCH v7 12/20] SUNRPC: remove call_allocate() BUG_ON if
 p_arglen=0 to allow RPC with void arg
Message-ID: <ZnxHks6wbbP3SK_I@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
 <20240624162741.68216-13-snitzer@kernel.org>
 <171935758342.14261.11602150947088793458@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171935758342.14261.11602150947088793458@noble.neil.brown.name>

On Wed, Jun 26, 2024 at 09:19:43AM +1000, NeilBrown wrote:
> On Tue, 25 Jun 2024, Mike Snitzer wrote:
> > This is needed for the LOCALIO protocol's GETUUID RPC which takes a
> > void arg.  The LOCALIO protocol spec in rpcgen syntax is:
> > 
> > /* raw RFC 9562 UUID */
> > typedef u8 uuid_t<UUID_SIZE>;
> > 
> > program NFS_LOCALIO_PROGRAM {
> >     version LOCALIO_V1 {
> >         void
> >             NULL(void) = 0;
> > 
> >         uuid_t
> >             GETUUID(void) = 1;
> >     } = 1;
> > } = 400122;
> > 
> > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > ---
> >  net/sunrpc/clnt.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > index cfd1b1bf7e35..2d7f96103f08 100644
> > --- a/net/sunrpc/clnt.c
> > +++ b/net/sunrpc/clnt.c
> > @@ -1894,7 +1894,6 @@ call_allocate(struct rpc_task *task)
> >  		return;
> >  
> >  	if (proc->p_proc != 0) {
> > -		BUG_ON(proc->p_arglen == 0);
> >  		if (proc->p_decode != NULL)
> >  			BUG_ON(proc->p_replen == 0);
> >  	}
> 
> I would be in favour get rid of all 5 lines.
> I wonder if p_decode is ever NULL.  It would cause
> rpcauth_unwrap_resp_decode() problems.

OK, but that broader cleanup can happen with an incremental follow-up
patch.

