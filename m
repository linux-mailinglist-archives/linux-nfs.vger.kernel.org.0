Return-Path: <linux-nfs+bounces-4641-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C950928A75
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 16:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8D71C20DC5
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Jul 2024 14:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7AD14A08B;
	Fri,  5 Jul 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cryv6cZP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C7146A69
	for <linux-nfs@vger.kernel.org>; Fri,  5 Jul 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188947; cv=none; b=AgHRMm15yhbt9GigbOdsbT0qAJJkXtuawgX2qaGoyIVye7qjDcZd0mxNb1zYdt5tz2iscSBFjQNTRZo46ReUWKf+B4+872rq2IwbtbvAaW6zXQgiWLwyW48BtqKYfvFFwXNBqxoqZE1FkyH7/1Rk9Y0CrjGD6U0MDcUlR6oDuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188947; c=relaxed/simple;
	bh=1T/Trj9bwCworsC2SIOFCU683E2UnRW2hVO161Txw8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Jd62BTeA/ZUX2icIDhfBX45Akc3CtWcFKGSSbMUCHYDMXc6wtcBJMQW8h+tC8sbtbb3cGLmSTT4v14DcfYNbJp0GieyUXmDwBlgZwLwJHofdMcNNen4Q+6MI8wR780R7Pidhr6g8Ivhsp7jXu6vQImdM1o23blbRzmAEYgGLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cryv6cZP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B673C116B1;
	Fri,  5 Jul 2024 14:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720188947;
	bh=1T/Trj9bwCworsC2SIOFCU683E2UnRW2hVO161Txw8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cryv6cZP3fZevG8kpm6htYncTuaWsOrmGmhwLiADDw/QU9h1v3eiczVA04gKsVfRu
	 PGXjs4gt3sp+NEtryWjH+2jFalMCt0kIbuj/Zh3kSKf+qWH+cjK+V+5iu6LCSkaiit
	 AgMGSoYumivco3F3BIrHMOuS/z7GUbUteO67kw4wFOT9yftduk38rxmpE9lJWfapjq
	 QMCW299PyiMugpK0TRiG7oLyVGocwkTU8iwB8uezmfk/ULcoo9R2DZR4LgFirHnnfi
	 B7lGUtuFDSLnT7S7OYvIIjI4R8d9YsQHdiEbo64xSC9a+nnNkaud3PTqJEJrxdMqYJ
	 kuCiM9MNwIslg==
Date: Fri, 5 Jul 2024 10:15:46 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Neil Brown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZogAEqYvJaYLVyKj@kernel.org>
References: <ZoVdP-S01NOyZqlQ@infradead.org>
 <ZoVqN7J6vbl0BzIl@kernel.org>
 <ZoVrqp-EpkPAhTGs@infradead.org>
 <F1585F6E-8C41-4361-B4FA-F9BD6E26F3A9@oracle.com>
 <ZoVv4IVNC2dP1EaM@kernel.org>
 <4486ee80a487c174ec88c7e12705d99e22ae812a.camel@kernel.org>
 <ZoY6e-BmRJFLkziG@infradead.org>
 <ZobqkgBeQaPwq7ly@kernel.org>
 <ZoeCFwzmGiQT4V0a@infradead.org>
 <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57C1CB2B-3B46-48F3-A095-417845001C3E@oracle.com>

On Fri, Jul 05, 2024 at 01:35:18PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 5, 2024, at 1:18 AM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > On Thu, Jul 04, 2024 at 02:31:46PM -0400, Mike Snitzer wrote:
> >> Some new layout misses the entire point of having localio work for
> >> NFSv3 and NFSv4.  NFSv3 is very ubiquitous.
> > 
> > I'm getting tird of bringing up this "oh NFSv3" again and again without
> > any explanation of why that matters for communication insides the
> > same Linux kernel instance with a kernel that obviously requires
> > patching.  Why is running an obsolete protocol inside the same OS
> > instance required.  Maybe it is, but if so it needs a very good
> > explanation.
> 
> I agree: I think the requirement for NFSv3 in this situation
> needs a clear justification. Both peers are recent vintage
> Linux kernels; both peers can use NFSv4.x, there's no
> explicit need for backwards compatibility in the use cases
> that have been provided so far.
> 
> Generally I do agree with Neil's "why not NFSv3, we still
> support it" argument. But with NFSv4, you get better locking
> semantics, delegation, pNFS (possibly), and proper protocol
> extensibility. There are really strong reasons to restrict
> this facility to NFSv4.

NFSv3 is needed because NFSv3 is used to initiate IO to NFSv3 knfsd on
the same host.

