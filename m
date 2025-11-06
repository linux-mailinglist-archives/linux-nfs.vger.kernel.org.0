Return-Path: <linux-nfs+bounces-16159-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91861C3DB46
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 23:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8BAB54E4207
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 22:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD222F6919;
	Thu,  6 Nov 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzkUpt6F"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4BC2EAB81
	for <linux-nfs@vger.kernel.org>; Thu,  6 Nov 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762469794; cv=none; b=Ho6fLFKfzOXdrbnGpfpd0uxzBVOMCdcLIpedl4Nr9MiOUirpkupBFWtomT+9RCNox8ECCUbx9Ae4C09YbTxU+50BiaauaTqXNad4rob0B88Ie7g1jks5UmaXddZODCOLQ31ZTUFWh6wrjEKnfxVrQdxRs+5oVH408+iQsW496Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762469794; c=relaxed/simple;
	bh=2A5iBHpiYPmIh/4JcpYoqer/v+lNQ7PrcTeYNgmgDK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJP1NcjbuMI2dtS2K6pyy44fm3srB8FmTup1rR+S9A/f1cvr6+iiz0+kZu8CHu53/Bc3FjUIvnsYrxAAeO1E4wQ75P7Bo/rk8UmDXF7jUJSLDVVcL1VSBltKloTgg1qussaVQTwdwV6/aBgjZoepa0x0pygSCpveFuHkQhAf+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzkUpt6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7C8C4CEF7;
	Thu,  6 Nov 2025 22:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762469794;
	bh=2A5iBHpiYPmIh/4JcpYoqer/v+lNQ7PrcTeYNgmgDK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GzkUpt6F0cgQmL5ArvY3iLVVbUtrMq7tXUUTalEwarVGjm2G2SV08MtngO59UDueF
	 1x2NRyv0bpYxgR5L0Hvqx5IdN5UjXY7YZEN8/v2IF746d4R1iNgJcd0ZLUvGOM8YnM
	 lHDaYeM1Wa6xNdw+adh5BjrQgiQhDd+JunJmBKjJCnU3RAnCza4R+XPNnjhWj++CZL
	 32eAD9htzPeDY+6wEbZ3la7ldav2UU3+qj5K+rm7sGupu4M2q16QJRVbRkLrnzF3mo
	 V1e7y1tXrbo2+epaDl0uFV9SNdiC9wOjZhXtiX+qOHJ8NpIUIPnI+R5+qwIpewgkUV
	 8UiGfhHI+tPBA==
Date: Thu, 6 Nov 2025 17:56:32 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
Message-ID: <aQ0noN473a-QFqpz@kernel.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
 <aQ0CUPcYYg6-5IJ1@kernel.org>
 <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>

On Thu, Nov 06, 2025 at 03:35:29PM -0500, Chuck Lever wrote:
> On 11/6/25 3:17 PM, Mike Snitzer wrote:
> >> I asked for the use of a file_sync export option because we need to test
> >> the BUFFERED cache mode as well as DIRECT. So, continue to experiment
> >> with this one, but I don't plan to merge it for now.
> > Doesn't the client have the ability to control NFS_UNSTABLE,
> > NFS_DATA_SYNC and NFS_FILE_SYNC already?  What experiment are you
> > looking to run?
> > 
> > If just looking to compare NFS_FILE_SYNC performance of
> > NFSD_IO_BUFFERED versus NFSD_IO_DIRECT then using the client control
> > is fine right?
> 
> Not necessarily. You can mount with "sync" but for large application
> write requests, that might still generate UNSTABLE + immediate COMMIT.

OK, I'll take a closer look at NFS client controls for stable_how,
because NFSD clearly handles NFS_DATA_SYNC and NFS_FILE_SYNC so I just
assumed its because the client does actually send them.

> > Anyway, maybe I'm just being overly concerned about the permanence of
> > an export option.  I thought it best to avoid export for now given we
> > do seem to have adequate controls for a NFS_FILE_SYNC performance
> > bakeoff.
> 
> I agree on not rushing another administrative API change. I was thinking
> you would be prototyping some of this stuff first and playing with it
> for a little while before it goes upstream.
> 
> It feels like it would be much more straightforward to implement an
> export option that applies to all cache modes rather than gluing it to
> DIRECT.

OK, I'll carry the patch in Hammerspace kernel for the time being so
Jon Flynn can test whenever he has availability,

> And as I said above, "no plan to merge it for now," meaning it's still
> on the table for sometime down the road. I have some other ideas I'm
> cooking up, such as using BDI congestion to control NFS WRITE
> throttling.

Hmm, I thought the BDI congestion infra got killed (by Jan Kara and
others).. which made me sad because when it was first introduced it
was amazing at solving some complex deadlocks (but we're talking 20
years ago now).  So I haven't kept my finger on the pulse of what is
still available to us relative to BDI congestion.

Another possiblity is the PSI data, that infra was put in place by
Meta to deal with exactly the sitution we're confronting: take
action(s) when pressure builds to a particular threshold.

> But let's get the base direct WRITE stuff finished.

Yes.

