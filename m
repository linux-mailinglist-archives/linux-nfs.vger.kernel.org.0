Return-Path: <linux-nfs+bounces-6434-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3171897758A
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Sep 2024 01:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFFCB23480
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2024 23:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6041C331F;
	Thu, 12 Sep 2024 23:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCnggZGX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B71C2DC3;
	Thu, 12 Sep 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183333; cv=none; b=Ydk9O7KHhcLpjmKvJ6faoIqRSLaiuMI5MT0xMzLJqh7UB9AHFXizwzm1QBqpml8Efvg3PgzdhQ442/hbbGXmw9JT4Dis42Nj6c3pIo+B+u4d6lijjsnpkXSpMbZEO6+vAr0wEEy6Mm1uTVJx3Mlno4qHlanlC/nULtU15weJ5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183333; c=relaxed/simple;
	bh=WQmuXeRVsUseob7bWpije6swmo5Cx+SwWJv7SQ6xblA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LadHC0nQFuTJsoBR/NwjndSgeC/LrlQYUhSRRRHrMmbhIhzU/oCRfCfyQNscyXqHQkA7d/kolrijDXidJHTz/3g3ZMSLRW81J9dZsa7zP5BfzbB7bUxcPIFx0vGaHCbFjcymraAW4V5kDizChkuaWwybF1M12xitp+On9Rsa/dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCnggZGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B618C4CEC3;
	Thu, 12 Sep 2024 23:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726183332;
	bh=WQmuXeRVsUseob7bWpije6swmo5Cx+SwWJv7SQ6xblA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCnggZGX9M5Pry6RBukSrTpk3FgzcgEbQjScCVQ/4+oc8BRleOHOffaej/rM3/17r
	 pUe/WbUltTK/icXH6mxX5IkxISZq8nWMf1f/ZTI5h8nGNKGcprUifjtcTL+RPwMvzV
	 QY9P0cqmeGUN0HBKFIuQktaAHJqWrV4w7nGmJ3Nm6OamQ6eO0nNNXc459AlARQAo4u
	 FCrb/gTc6Ft0USHr+xkjyh2igYsbeT21iAB2wq7a8+sc1dQ+Z4MAw7KwkucaSDslGV
	 7zMQsbp4mpOuZNYwA51SpPsgjT13GQ7OiiWyA6EoQ0ZjyaDtAti1U5QAj3LrWBYN3G
	 8hUrqnln6u2Mg==
Received: by pali.im (Postfix)
	id 790F05E9; Fri, 13 Sep 2024 01:22:07 +0200 (CEST)
Date: Fri, 13 Sep 2024 01:22:07 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockd: Fix comment about NLMv3 backwards compatibility
Message-ID: <20240912232207.p3gzw744bwtdmghp@pali>
References: <20240912225320.24178-1-pali@kernel.org>
 <172618264559.17050.3120241812160491786@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <172618264559.17050.3120241812160491786@noble.neil.brown.name>
User-Agent: NeoMutt/20180716

On Friday 13 September 2024 09:10:45 NeilBrown wrote:
> On Fri, 13 Sep 2024, Pali Rohár wrote:
> > NLMv2 is completely different protocol than NLMv1 and NLMv3, and in
> > original Sun implementation is used for RPC loopback callbacks from statd
> > to lockd services. Linux does not use nor does not implement NLMv2.
> > 
> > Hence, NLMv3 is not backward compatible with NLMv2. But NLMv3 is backward
> > compatible with NLMv1. Fix comment.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  fs/lockd/clntxdr.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/lockd/clntxdr.c b/fs/lockd/clntxdr.c
> > index a3e97278b997..81ffa521f945 100644
> > --- a/fs/lockd/clntxdr.c
> > +++ b/fs/lockd/clntxdr.c
> > @@ -3,7 +3,9 @@
> >   * linux/fs/lockd/clntxdr.c
> >   *
> >   * XDR functions to encode/decode NLM version 3 RPC arguments and results.
> > - * NLM version 3 is backwards compatible with NLM versions 1 and 2.
> > + * NLM version 3 is backwards compatible with NLM version 1.
> > + * NLM version 2 is different protocol used only for RPC loopback callbacks
> > + * from statd to lockd and is not implemented on Linux.
> >   *
> >   * NLM client-side only.
> >   *
> 
> Reviewed-by: NeilBrown <neilb@suse.de>
> 
> Do you have a reference for that info about v2?  I hadn't heard of it
> before.
> 
> NeilBrown

I have just this information in my notes. I guess it should be possible
to gather more information about v2 from released Sun/Solaris source
code via OpenSolaris / Illumos projects.

