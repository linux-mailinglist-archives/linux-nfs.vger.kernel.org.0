Return-Path: <linux-nfs+bounces-6886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9B799187B
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 18:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A34701F22027
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Oct 2024 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D31586FE;
	Sat,  5 Oct 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qs4loj+u"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8E81586CB;
	Sat,  5 Oct 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728147093; cv=none; b=ULBdqKpUotAtOMp2MgkMe9uDZGT4qe8B6+yRAf6yx8dF1Tmps8vBzUwFm9wzmW3zb0Z7au6SO1KpHkh2hD6h4wv1bp9Ix8m6Aam0sOha6xYOWLrs1gm/VSxbzx4rVQwAFV044GIz/rFEzrNyxdBKOsGe30+AyA1UeIXg9YDP3w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728147093; c=relaxed/simple;
	bh=lv9FJ2ihL0f8Ras7fIMkp1jlnJLE7EEmHyQP4/u5aV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgkbZs/V7p4Pnz7Speb0se8oOD6QZVkeNdSN/0L7fFuf0Dkt34rqChL56zg6yTKP3IBNR1iCcYaV7qN5du+7zbOlQeFTKarMW24HwXldMNFBcwaGUDqSUtSn7+TPkPxFOWqCE0C9XC7OtHvaWCkR+g95WvEmR/B+ASjaYXPvm68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qs4loj+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130A3C4CEC2;
	Sat,  5 Oct 2024 16:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728147092;
	bh=lv9FJ2ihL0f8Ras7fIMkp1jlnJLE7EEmHyQP4/u5aV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qs4loj+ufWd0oXjRpaQfmji2TH/AzIeSI/2vQOpEP3prkn8kj5rFj/Xv9slsjG5jk
	 DgKNEyLxeMGBjcpHvoAkAOsibqPrGBjBBJoOEc7uqMOXdEzxsY8OkFKmniTKWyqAvT
	 /muTH7giy1R/nWV1ue0/0VJw8+4B2Tw2pklqXDNElgj+4aajCho5VxolCHQinkI10n
	 MeuDgF/JR85BIo1Po29yUiI2uGZJuXEyjYjLSa2qmdGcDy/46mRIw8odFqjJb4dAF0
	 ROCh5bqnG1MX7eLrDj4iB2jzr1CbL4UJbHXW7Ea6v97LSTegy6jiXtbAztwa3FfGbf
	 wRA0cHV3ep3Uw==
Received: by pali.im (Postfix)
	id C76B1648; Sat,  5 Oct 2024 18:51:25 +0200 (CEST)
Date: Sat, 5 Oct 2024 18:51:25 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: NeilBrown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Message-ID: <20241005165125.rbtgxzz4olvv4sqn@pali>
References: <20240912225320.24178-1-pali@kernel.org>
 <172618264559.17050.3120241812160491786@noble.neil.brown.name>
 <20240912232207.p3gzw744bwtdmghp@pali>
 <20240912232820.245scfexopvxylee@pali>
 <ZuN6ah3nI0giafGl@tissot.1015granger.net>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuN6ah3nI0giafGl@tissot.1015granger.net>
User-Agent: NeoMutt/20180716

On Thursday 12 September 2024 19:34:02 Chuck Lever wrote:
> On Fri, Sep 13, 2024 at 01:28:20AM +0200, Pali Rohár wrote:
> > On Friday 13 September 2024 01:22:07 Pali Rohár wrote:
> > > On Friday 13 September 2024 09:10:45 NeilBrown wrote:
> > > > On Fri, 13 Sep 2024, Pali Rohár wrote:
> > > > > NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> > > > > original Sun implementation is used for RPC loopback callbacks from statd
> > > > > to lockd services. Linux does not use nor does not implement NLMv2.
> > > > > 
> > > > > Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> > > > > compatible with NLMv1. Fix comment.
> > > > > 
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > >  fs/lockd/clntxdr.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> > > > > index a3e97278b997..81ffa521f945 100644
> > > > > --- a/fs/lockd/clntxdr.c
> > > > > +++ b/fs/lockd/clntxdr.c
> > > > > @@ -3,7 +3,9 @@
> > > > >   * linux/fs/lockd/clntxdr.c
> > > > >   *
> > > > >   * XDR functions to encode/decode NLM version 3 RPC arguments and results.
> > > > > - * NLM version 3 is backwards compatible with NLM versions 1 and 2.
> > > > > + * NLM version 3 is backwards compatible with NLM version 1.
> > > > > + * NLM version 2 is different protocol used only for RPC loopback callbacks
> > > > > + * from statd to lockd and is not implemented on Linux.
> > > > >   *
> > > > >   * NLM client-side only.
> > > > >   *
> > > > 
> > > > Reviewed-by: NeilBrown <neilb@suse.de>
> > > > 
> > > > Do you have a reference for that info about v2?  I hadn't heard of it
> > > > before.
> > > > 
> > > > NeilBrown
> > > 
> > > I have just this information in my notes. I guess it should be possible
> > > to gather more information about v2 from released Sun/Solaris source
> > > code via OpenSolaris / Illumos projects.
> > 
> > Just very quickly I found this Illumos XDR file for NLM:
> > https://github.com/illumos/illumos-gate/blob/master/usr/src/uts/common/rpcsvc/nlm_prot.x
> > 
> > And it defines NLMv2 with two procedures numbered 17 and 18, plus there
> > is a comment in file header about v2.
> > 
> > So probably the best reference would be the Illumos source code.
> 
> What you see in the Illumos code is not something that is part
> of the standard NLM protocol, but rather a private upcall protocol
> between the kernel and user space that is special sauce added
> by each implementation of NLM/NSM.

Ok. But this applies for v2, no?

> Also note the way NLMv3 is defined in this file: it defines only
> a handful of new operations. The other operations are inherited
> from NLMv1.

Yes, v3 is there and is inherited from v1. This is also what I pointed
in the comment. That v3 inherits from v1, not v2.

In header file of that nlm_prot.x is written:

 * There are currently 3 versions of the protocol in use.  Versions 1
 * and 3 are used with NFS version 2.  Version 4 is used with NFS
 * version 3.
 *
 * (Note: there is also a version 2, but it defines an orthogonal set of
 * procedures that the status monitor uses to notify the lock manager of
 * changes in monitored systems.)

Which sounds like version 3 has nothing with version 2.

My understanding of that comment is that version 2 contains only those
private upcall protocol between kernel and userspace about which you
wrote, and therefore version 3 is not backward compatible with version 2.

> IMO the comment is accurate and does not warrant a change.

