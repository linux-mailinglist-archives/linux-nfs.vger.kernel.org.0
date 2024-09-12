Return-Path: <linux-nfs+bounces-6435-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CCA977590
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 01:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD53FB23B9B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE251C3F10;
	Thu, 12 Sep 2024 23:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ex5zgFGl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B391C2DA6;
	Thu, 12 Sep 2024 23:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183705; cv=none; b=u2RO5qzwUPW1KqaDtnveBNZ42EEEVpKY4DMOmd2taqPkU3gD7PcGNWP9Ma4Fcc/7BZ3EAI2qAbiyRuBuc8GjSzT2kdH2ZtyJp9VYQVsx2aevKnDWD8ZPJQQOnPYl4lCmI/as/cDoL/oogCpXnhPnbCFTmj4nvw258y5cwPc2+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183705; c=relaxed/simple;
	bh=OQT70pSYO5v0hWLwrpDC0ceEmD6XlYeaOPou2gZHco0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We1Z0RWc7KbK8BxNpZlsmBth5T69hAFk5UadwGsrXN6eVfePXl/Gcnp8Uwa35AiK5HI4LgK+zCWA/fROt33DuYvLSnatlb8jK16x0rjITV2J9Vc1jR//uGbqgFcj99GM5emcj4lq83VtfyDfMYGgEs6s+bhbmTyckjY1v5E5MA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ex5zgFGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C39C4CEC3;
	Thu, 12 Sep 2024 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726183705;
	bh=OQT70pSYO5v0hWLwrpDC0ceEmD6XlYeaOPou2gZHco0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ex5zgFGlBBVdHLeqaDc2AbgtacfnTa8rEOQdB1nUE8/hF8qA/By/RjDD9kQlVtA8G
	 aTuuijzK3VhnGQ2z9nINxD9mKWsLh3z5csukrUxxxXoPFx1n5ows9XoyAmezG6OsTU
	 0+sxuJNQbMy6GD3DxsoHs8WEkq8REsNdc25azqDl2fgA6rM+vCnZv3IwIavK+KxZkp
	 K5dD2RJk0JPnCp8Ch9jKqFL2q2W1ze4wBF+dpfTqAxbsWBLxlVDYZTecXqfNdhqCSr
	 1DcKS58uosFOj/1GcczwpiqzGtSfzQg5kF6b4t6eQlxXmmBl+eXRnh4Mk2mVNTWdDY
	 g6C0BHgjOwFSQ==
Received: by pali.im (Postfix)
	id 8C0335E9; Fri, 13 Sep 2024 01:28:20 +0200 (CEST)
Date: Fri, 13 Sep 2024 01:28:20 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Message-ID: <20240912232820.245scfexopvxylee@pali>
References: <20240912225320.24178-1-pali@kernel.org>
 <172618264559.17050.3120241812160491786@noble.neil.brown.name>
 <20240912232207.p3gzw744bwtdmghp@pali>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912232207.p3gzw744bwtdmghp@pali>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 01:22:07 Pali Rohár wrote:
> On Friday 13 September 2024 09:10:45 NeilBrown wrote:
> > On Fri, 13 Sep 2024, Pali Rohár wrote:
> > > NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> > > original Sun implementation is used for RPC loopback callbacks from statd
> > > to lockd services. Linux does not use nor does not implement NLMv2.
> > > 
> > > Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> > > compatible with NLMv1. Fix comment.
> > > 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  fs/lockd/clntxdr.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> > > index a3e97278b997..81ffa521f945 100644
> > > --- a/fs/lockd/clntxdr.c
> > > +++ b/fs/lockd/clntxdr.c
> > > @@ -3,7 +3,9 @@
> > >   * linux/fs/lockd/clntxdr.c
> > >   *
> > >   * XDR functions to encode/decode NLM version 3 RPC arguments and results.
> > > - * NLM version 3 is backwards compatible with NLM versions 1 and 2.
> > > + * NLM version 3 is backwards compatible with NLM version 1.
> > > + * NLM version 2 is different protocol used only for RPC loopback callbacks
> > > + * from statd to lockd and is not implemented on Linux.
> > >   *
> > >   * NLM client-side only.
> > >   *
> > 
> > Reviewed-by: NeilBrown <neilb@suse.de>
> > 
> > Do you have a reference for that info about v2?  I hadn't heard of it
> > before.
> > 
> > NeilBrown
> 
> I have just this information in my notes. I guess it should be possible
> to gather more information about v2 from released Sun/Solaris source
> code via OpenSolaris / Illumos projects.

Just very quickly I found this Illumos XDR file for NLM:
https://github.com/illumos/illumos-gate/blob/master/usr/src/uts/common/rpcsvc/nlm_prot.x

And it defines NLMv2 with two procedures numbered 17 and 18, plus there
is a comment in file header about v2.

So probably the best reference would be the Illumos source code.

