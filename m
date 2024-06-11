Return-Path: <linux-nfs+bounces-3644-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5349D902EC9
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 04:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40B2B2172D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2024 02:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5CA1581E2;
	Tue, 11 Jun 2024 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPfY31rp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56554152161
	for <linux-nfs@vger.kernel.org>; Tue, 11 Jun 2024 02:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718074664; cv=none; b=MrR9TTLBdHjnTYH++K9jmUGjyeDNwAlQIuhseu74JcTsy2k8qnpovoQ694E/97vx3Sewd6mEl2/anvgmSNCLei8H6nHqpk6UKKbKlRCezVv0zRYxoU+4KYvi0fsTokxZYG8xyq5T3a6ybBkaFX7Jk7GNMskhB2aHN+J+hbjYQ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718074664; c=relaxed/simple;
	bh=3QNTsKaokwt4IIJUGdFZscImRcE/zVQl8senqCR5dC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZWrifryVeK9IYaN5SuohI0WcQ+tPY+jY96/4A+s2V3vm7ZOP0O4GU+BFcD6o0IW/6eY+D3/8EdlReWwP/1xaEf2eyHnsa8qGalXbw8iL8h/gfy623XhvZBjFBsgscG1/tYSBpJbA+gz83nX2k5hkhcsxA9QQokxVhQV8zNgsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPfY31rp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5250C2BBFC;
	Tue, 11 Jun 2024 02:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718074663;
	bh=3QNTsKaokwt4IIJUGdFZscImRcE/zVQl8senqCR5dC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPfY31rp9SSOyv1YRfgRmR19m9zK3zyEz68zFcSDwWXxa4tFbAhdgV7XceOxbBzlz
	 KOt4iTc5UVIUboZU5qJJnQlpnHhhnaEVntNQmhYmrZLSM85sdUDDFN4SDLDoEKnoCZ
	 zZN8fBKaRn8MZ0n3OPdsx+hR1cgMORUYiEn6wIO4M8mS43QqE3KF7NjV9ni/p9uybT
	 NOYAPiStVT1pPPno3mwzYgqUw9ilyrluwBboXR61Jb+o+OgKaG4q/3vnGuZc5KxMOH
	 CoLN7mpfJPa0zwA2y2ZVCt0HvD4ryiN9APkvp+psqhaM5Yq30aaZv+AQLq0RkAwGgf
	 Vc9irteQlT0dg==
Date: Mon, 10 Jun 2024 22:57:42 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 04/29] sunrpc: handle NULL req->defer in
 cache_defer_req
Message-ID: <Zme9JgfkefRy9tqZ@kernel.org>
References: <>
 <903610ef28512c03fd8db6b4b57e65b3a8bda8a9.camel@kernel.org>
 <171806779662.14261.6943542763312044917@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171806779662.14261.6943542763312044917@noble.neil.brown.name>

Hi Neil,

On Tue, Jun 11, 2024 at 11:03:16AM +1000, NeilBrown wrote:
> On Mon, 10 Jun 2024, Jeff Layton wrote:
> > On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> > > From: Weston Andros Adamson <dros@primarydata.com>
> > > 
> > > Dont crash with a NULL pointer dereference when req->defer isn't
> > > set. This is needed for the localio path.
> > > 
> > > Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> > > Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
> > > Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> > > Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> > > ---
> > >  net/sunrpc/cache.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
> > > index 95ff74706104..b757b891382c 100644
> > > --- a/net/sunrpc/cache.c
> > > +++ b/net/sunrpc/cache.c
> > > @@ -714,6 +714,8 @@ static bool cache_defer_req(struct cache_req
> > > *req, struct cache_head *item)
> > >  			return false;
> > >  	}
> > >  
> > > +	if (!req->defer)
> > > +		return false;
> > >  	dreq = req->defer(req);
> > >  	if (dreq == NULL)
> > >  		return false;
> > 
> > I've gone over it many times, but I still don't quite "get" the
> > deferral handling code. I think the above is probably safe, but please
> > do Cc Neil Brown on later postings of this series since he has a better
> > grasp of that code.
> > -- 
> > Jeff Layton <jlayton@kernel.org>
> > 
> 
> The patch is bound to be "safe" in a technical sense, but I wonder why
> it is necessary.  And if we add code that isn't necessary we could make
> the result look confusing, which isn't "safe" in a social sense...
> 
> ->defer is always set non-NULL before svc_process() is called, and I
> don't think cache_defer_req() can be reached without svc_process() being
> called.  So I cannot see how ->defer could possibly be NULL.
> 
> Can you remove this patch and see if you can trigger a crash.  If you
> can I'd love to see the kernel stack.

I removed the patch (and also the patch that exported svc_defer) and
I haven't seen any issues.  So I'll drop those 2 patches.

Thanks,
Mike

