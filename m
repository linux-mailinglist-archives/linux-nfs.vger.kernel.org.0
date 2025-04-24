Return-Path: <linux-nfs+bounces-11270-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3555BA9B352
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 18:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BED792453F
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Apr 2025 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1B627F4CB;
	Thu, 24 Apr 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmLHfkoc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58D127D78C
	for <linux-nfs@vger.kernel.org>; Thu, 24 Apr 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510644; cv=none; b=EgJQALlckliZnQNu9OZpZAuuJGQyrNDB/f1Jm1XjGEgn+NR/0hz9v1dv3iRbBtPbTgKeFAgazV7gUAisM6RGb5AUwwvc1+E4hAh6UR80D6EYXdEL7BCul0A6dyxgaWwu+0oR9HJuc+cA0hacM0aJpHfO6VFaAdb+tsJYOFIAG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510644; c=relaxed/simple;
	bh=kPbgEDerKFrVnDh8srs9BatqxUMaUKo73Q4nQx493mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JU6+zT7pdPx0gQEJEex7p9XQv1gxpGINq0qhUKnh8EmQl/8JQOwweZeRnq/6i3xcLdLK6XC26oQZeHcDQIYQUHvZwL7nUcEYsqlU7LVe1UbHR4j7S/hWyPDiOTdRY3i6IN6ssZBbDTDKsG9LwTPHLLReKW/+UiB/o325bdl/hLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmLHfkoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9E2C4CEE8;
	Thu, 24 Apr 2025 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745510644;
	bh=kPbgEDerKFrVnDh8srs9BatqxUMaUKo73Q4nQx493mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmLHfkocP1N4nOSKOTivkdQBQo4BtSkZOcHIyJ1ms1Xhi5CA+8l1XAmwSWq5ZCu1c
	 1KeCellQYOXCAHr+dd89s+pCooQ2EfQd+tISTog9zEg/6PXC0rCP/eUeavxBmnlAE7
	 PZmR+vpPob08VMCFqnETbbQY19Hl8AU8bh51a/D1k82OQCXpZUGj2hkbft6VFOt7db
	 0UAIfeVBqsWgeJ7dnM4tQZh9bHcfBJeVVM4fCQ4mIOWboo7TL2GXYS9gkHXYL4JdW7
	 baG+9EmWQn3Q13nNGi0a7mNVyIn5+50EQEuKRyWKRK+Ud233j1MjxZyOz3cVmYwVjG
	 nbt1CDYnJ1i4w==
Date: Thu, 24 Apr 2025 12:04:03 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Subject: Re: [PATCH v2] nfs: add dummy definition for nfsd_file
Message-ID: <aApg86mNKak2e--H@kernel.org>
References: <>
 <8c67a295-8caa-4e53-a764-f691657bbe62@wanadoo.fr>
 <174539938027.500591.1190076221216165031@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174539938027.500591.1190076221216165031@noble.neil.brown.name>

On Wed, Apr 23, 2025 at 07:09:40PM +1000, NeilBrown wrote:
> On Wed, 23 Apr 2025, Vincent Mailhol wrote:
> > On 23/04/2025 at 09:32, NeilBrown wrote:
> > > On Wed, 23 Apr 2025, Pali Rohár wrote:
> > >> On Wednesday 23 April 2025 07:54:40 NeilBrown wrote:
> > >>> On Wed, 23 Apr 2025, Pali Rohár wrote:
> > 
> > (...)
> > 
> > >>> Actually I do object to this fix (though I've been busy and hadn't had
> > >>> much change to look at it properly).
> > >>> The fix is ugly.  At the very least it should be wrapping in an 
> > >>>    #if  GCC_VERSION  < whatever
> > 
> > I acknowledge that the fix is a bit ugly, but Mike is the only one who
> > has proposed a solution so far.
> 
> FYI here is my current patch which fixes this problem and a few other
> problems, but doesn't fix everything I (think I) have found, and may
> introduce some problems because some of the interactions are subtle and
> need careful review.
> 
> Once I'm confident of it I hope to break it up into individual patches
> and submit.

Thanks for working through it (and sorry for the troubles...).

This was where we last discussed the need for my hack (I actually
thought it was older RCU implementation in 5.15 that was the issue):
https://lore.kernel.org/all/Zsyhco1OrOI_uSbd@kernel.org/
(somehow it morphed into blaming vintage compilers, e.g. RHEL8's gcc
8.5 or whatever).

We have stable@ kernels to be concerned about.  But hopefully you
carry forward with splitting up the patches like you've planned, they
all make sense and they all get marked for stable@ (6.14+).  Saves the
make-work of effectively implementing the fixes twice (purely for
stable's benefit, by needing to pull your subtle rcu race fixes to the
front).

Thanks,
Mike

