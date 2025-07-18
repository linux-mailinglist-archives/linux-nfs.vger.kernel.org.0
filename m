Return-Path: <linux-nfs+bounces-13156-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDDFB0A66D
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 16:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745AE168803
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Jul 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFB2BD590;
	Fri, 18 Jul 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGNrccuR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B578217B425
	for <linux-nfs@vger.kernel.org>; Fri, 18 Jul 2025 14:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849375; cv=none; b=bl6AaLk+LGZ0n8Cyb6zM06hWGdBFSskOR3S3/HsXS+TExcTkfiD7rj/CTA0PY0Bz4ZlQE00I5hbKdP1QpxtKgZ0ckif5x6Jbxoz+540c5jtyoNUXjn+hulwkpuISBrfi69n4CAhanIPcJqsxlTp8Mp3MiyooR5ypZpQkgdKm6xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849375; c=relaxed/simple;
	bh=fpZuy32gvshuxFRqPNqMR1wMMTI6FEsizZPGBFaB1NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3wPgqp5jeaHuVnztnrCq66V2zr7qXOub90zWLlLg3Ap8Zoz2EwzkAQdE3JXJP+g1/n3+qK6L7Sr659YpOD6CR4L0YRKJ4L2HuTAe4fhx5BofmNeNyxX8w+8URQv2l1voIVze399T3Bp7YSE2BzH3aQ2kqV6Zx7mG3ozT9RBNfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGNrccuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B79CC4CEEB;
	Fri, 18 Jul 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752849375;
	bh=fpZuy32gvshuxFRqPNqMR1wMMTI6FEsizZPGBFaB1NA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGNrccuR8ph/yTHgFyaX4sVfEp/J1gtnhcUoxbiC3gosqnpvW646xSYbzUk8oqzPd
	 RhOecAb6pfYb3Ev/WLrolHlRDdw3G5hDG2Ctq1SUVMaq7+vBEkhLf2xRg5DNWwHdTb
	 E5O5wj+q4Dpiob3+4KStP4XKtm8YmjikuGMQkcC1QgGs2Y+QzDNu1TR5wrel2Vix0x
	 cA9PGjOj0arnTjSpedf1jVrpsnWY4LqteHQgmeI149OAyqHk3cO+86BnywyJxzL2es
	 /NowD6BDkLd/JBraOTCY745pDLYjsIKVubjYODDo9TLjpJIXUR5IWjHoS343ZOu9hi
	 nVpzYstZRYl1w==
Date: Fri, 18 Jul 2025 10:36:13 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/2 RFT] nfsd: fix another problem with recent localio
 changes
Message-ID: <aHpb3Yd5XuTl622Y@kernel.org>
References: <20250718012831.2187613-1-neil@brown.name>
 <175284851548.1668994.14828037670346771563.b4-ty@oracle.com>
 <aHpZt4U38tcc5X89@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHpZt4U38tcc5X89@kernel.org>

On Fri, Jul 18, 2025 at 10:27:03AM -0400, Mike Snitzer wrote:
> On Fri, Jul 18, 2025 at 10:25:26AM -0400, Chuck Lever wrote:
> > From: Chuck Lever <chuck.lever@oracle.com>
> > 
> > On Fri, 18 Jul 2025 11:26:13 +1000, NeilBrown wrote:
> > > Mike reports ongoing problem with leakage of refcounts for the net in
> > > nfsd when localio is used.  I believe the first patch fixes one possible
> > > cause.  The second patch removes some related dead code.
> > > 
> > > Mike: thanks for your testing so far.  Hopefully you could find time to
> > > test this one too?
> > > 
> > > [...]
> > 
> > Applied to nfsd-testing, thanks!
> > 
> > I assume 1/2 should be expedited? If so, I can add a Cc: stable and
> > get it into v6.17-rc.
> 
> Yes, it should be expedited.

BTW, Neil's LOCALIO changes that were merged during 6.16 merge window
have dependencies on his generic wait_on_var advances.  So all these
LOCALIO 6.16 changes won't have an easy time of getting back to 6.12
stable@ for example.

But given the Fixes: in the LOCALIO changes that were merged to 6.16
I'd imagine 6.14 stable@ _could_ pick them up... so explicitly tagging
this fix with "Cc: stable" likely makes sense.  But had they picked up
the 6.16 patches for 6.14 stable@ then they should know to pick up
this fix anyway (as side-effect of Neil's Fixes: tag).

Chuck, pretty certain you know all this.. I'm just sharing what I know
for others' benefit.

