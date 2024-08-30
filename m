Return-Path: <linux-nfs+bounces-6052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33696637E
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 15:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B4A6281E07
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2024 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B860C190472;
	Fri, 30 Aug 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Quhot6kF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5F15852C
	for <linux-nfs@vger.kernel.org>; Fri, 30 Aug 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026208; cv=none; b=i4kH5m99hJwUszfXVjjmNWTilEeWhLbIyVJNrR0zlfv6MQ28TUYQuEsFXcX3efVX5U/FY9BW3qkM1vbqiUAhbVD4dK5l1zVVwqdIUXDgADhUZxHXj8wGu0+7hiHRJLKqPqFMcRPZO7M4dFGEWykLmoSZtNbg6ASi/OXeTtNyTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026208; c=relaxed/simple;
	bh=rGu02g96VzzA3kRT/LK87uyxImDvSiqHI+0u1sk7tAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ady1jbb9AkL511UMin5ej7boqM3v1zfINzSvXraIXxmdh0GZHScqjsKA2M6Vb4vVaXcbDN7Av/VeAPd802+fj9YBUXCusb+4YPTKsJZ8gT8yBHfs+b5GToB9wP/C6cyImq0zLM3uvPmVwWcbUTF1N6oOziIwCx/vNVkMcn99KDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Quhot6kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABFC4CEC2;
	Fri, 30 Aug 2024 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725026208;
	bh=rGu02g96VzzA3kRT/LK87uyxImDvSiqHI+0u1sk7tAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Quhot6kFc8+kOuFFwI7pviPoAYFhxYOhy3ozVcgN1b+jBSupmJ9WYR5IdvwSIXksN
	 uVoovwLhz4vA56WR+gNrfnVBDT6pvDghJWvWhWJXoZ5Qho5L4QkWz7kuXl05q9zehw
	 9B2OfEfQMTfLdDT9p7FSRlcayDdVr81iqjjvlBNWF8XhZhar5InTqAfGqi9+XHcXWi
	 +8yRljMLKExzUx/EGGvR5eBTGShDq1skdk6J8CvWAeHLoR4Fim3jw38zmZ7AK/eu4/
	 V7x1rQR3fjpUIvj9P0u3qAbSzx81J1KXXOlumsK1K1NM6wXhssEsHlzGI9n4Spe7Rr
	 Y8vMVuvF2h4xA==
Date: Fri, 30 Aug 2024 09:56:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v14-plus 00/25] Address netns refcount issues for localio
Message-ID: <ZtHPnjnr2knJTPsv@kernel.org>
References: <20240830023531.29421-1-neilb@suse.de>
 <ZtF5E5H53tkNurR3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtF5E5H53tkNurR3@kernel.org>

On Fri, Aug 30, 2024 at 03:47:31AM -0400, Mike Snitzer wrote:
> On Fri, Aug 30, 2024 at 12:20:13PM +1000, NeilBrown wrote:
> > Following are revised versions of 6 patches from the v14 localio series.
> > 
> > The issue addressed is net namespace refcounting.
> > 
> > We don't want to keep a long-term counted reference in the client
> > because that prevents a server container from completely shutting down.
> > 
> > So we avoid taking a reference at all and rely on the per-cpu reference
> > to the server being sufficient to keep the net-ns active.  This involves
> > allowing the net-ns exit code to iterate all active clients and clear
> > their ->net pointers (which they need to find the per-cpu-refcount for
> > the nfs_serv).
> > 
> > So:
> >  - embed nfs_uuid_t in nfs_client.  This provides a list_head that can
> >    be used to find the client.  It does add the actual uuid to nfs_client
> >    so it is bigger than needed.  If that is really a problem we can find
> >    a fix.
> > 
> >  - When the nfs server confirms that the uuid is local, it moves the
> >    nfs_uuid_t onto a per-net-ns list.
> > 
> >  - When the net-ns is shutting down - in a "pre_exit" handler, all these
> >    nfS_uuid_t have their ->net cleared.  There is an rcu_synchronize()
> >    call between pre_exit() handlers and exit() handlers so and caller
> >    that sees ->net as not NULL can safely check the ->counter
> > 
> >  - We now pass the nfs_uuid_t to nfsd_open_local_fh() so it can safely
> >    look at ->net in a private rcu_read_lock() section.
> > 
> > I have compile tested this code but nothing more.
> > 
> > Thanks,
> > NeilBrown
> > 
> >  [PATCH 14/25] nfs_common: add NFS LOCALIO auxiliary protocol
> >  [PATCH 15/25] nfs_common: introduce nfs_localio_ctx struct and
> >  [PATCH 16/25] nfsd: add localio support
> >  [PATCH 17/25] nfsd: implement server support for NFS_LOCALIO_PROGRAM
> >  [PATCH 19/25] nfs: add localio support
> >  [PATCH 23/25] nfs: implement client support for NFS_LOCALIO_PROGRAM
> 
> Hey Neil,
> 
> I attempted to test the kernel with your changes but it crashed with:
> 
> [   55.422564] list_add corruption. next is NULL.
> [   55.423523] ------------[ cut here ]------------
> [   55.424423] kernel BUG at lib/list_debug.c:27!
...
> I'll triple check my melding of your changes and mine in ~7 hours.. I
> may have missed something.

Good news, I was just missing your fs/nfsd/nfsctl.c changes.. works
well with those ;)

Seeing a very slight drop in performance (with my well-worn smoke test
that does 20 secs of aio directio 128K reads with 24 threads on my
testbed).  But I mean slight (~2-3%).  Not worried about it,
correctness trumps performance, but I think reclaiming that
performance will be easy (by avoiding the need for KMEM_CACHE
nfs_localio_ctx_{alloc,free}).

> Note this is _not_ with your other incremental patch (that uses
> __module_get) -- only because I didn't get to that yet.

Moving on to incorporating your nfsd __module_get now.  Then on to the
work of switching from nfs_localio_ctx back to returning nfsd_file.

Mike

