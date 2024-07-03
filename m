Return-Path: <linux-nfs+bounces-4577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1713D924D18
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 03:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DA21C20FB3
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 01:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C12765C;
	Wed,  3 Jul 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZY0O+g7r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5E621
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 01:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719969212; cv=none; b=qWKigscnqPHG1AvyoDkO5Hrlvnl/3Ig4GSvHIoAzO/MC9Lkwpn7aeAcIObyHrEB3A4qX5vsRxb4NQ7ALWgloqRMm9Zb5MRcM0xwdoXECAA/rghpjynY2q/5Taqnl3Fru2gl1k48Z1qfBMyYoEvk9C2wcj6ebJWd1Usf8mnpKPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719969212; c=relaxed/simple;
	bh=R6d5v0vZpWmpj4/9i7cPNGr8Ws4qaHtkmMu0hPtCy5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Djj9Wpego7VTpxTZRBoVN++uSJ1FPALSD54jSxnvwKVSAlDNbHmsW/g2VQARTVBCbJA6mCNel+bNumkOqdWBp5Cf1NxtYZNRCAgK/FWsorV9hFxPSt1/dWspY1aP2e6pmOFYX7TFiPtRvozFWFjcBNdEAvNGX8qfv9Au2cwChpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZY0O+g7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD5BC116B1;
	Wed,  3 Jul 2024 01:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719969212;
	bh=R6d5v0vZpWmpj4/9i7cPNGr8Ws4qaHtkmMu0hPtCy5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZY0O+g7rRyRSgqEqO/t0IQLL1cFfnZzn6TelAy5y0egO3mBWCcOdkzsJgrGEXdDDz
	 bcN7ZZlxrZ/B90tCBGsvlbM1ytybs30QYjrWeYl+RzZr4bY0G56B0cYLBKrcaQArc8
	 epf6pBneY6WWiOtBLBwfZ7ezKrACAUhU4DvM/s1ZpJzO+xNJ4is+XKOh8mTk6YMfT+
	 1W7/b/KP3I9Lasaz87R8/RjEGzhDtsSVyBBfdr6J1HUszEmEv2bhvxsBxSexjVm+zp
	 G16vo3syL9qkuMHbjGph5exHniSlJvRPllmh2Bi+R+yU+ciGDPzcSoS3/x6aEOPBOl
	 anFaTnOfKZwUw==
Date: Tue, 2 Jul 2024 21:13:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Chuck Lever III <chuck.lever@oracle.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoSlu2FTOArSF4dM@kernel.org>
References: <>
 <ZoRHt3ArlhbzqERr@kernel.org>
 <171996794099.16071.9277779562259336249@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171996794099.16071.9277779562259336249@noble.neil.brown.name>

On Wed, Jul 03, 2024 at 10:52:20AM +1000, NeilBrown wrote:
> On Wed, 03 Jul 2024, Mike Snitzer wrote:
> > 
> > Maybe Neil will post a fully working v12 rebased on his changes.
> 
> Maybe I will, but it won't be before Friday.

No problem!  I can also just run with the first patchset you provided.

But hopeful you're OK with us doing incremental changes to this "v11"
baseline?:
https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

Please see the other reply I just sent for more context on why I hope
this works for you.  Happy to do a final rebase once the code is
settled.

> I too wonder about the unusual expectation of haste, and what its real
> source is.

Desire to settle approach is all, to allow settling development and
ultimately move on to developing something else in NFS.

Mike

