Return-Path: <linux-nfs+bounces-13289-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F6B13C73
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 16:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFE427A155B
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jul 2025 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9807426658F;
	Mon, 28 Jul 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhf9b50s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73381265CDD
	for <linux-nfs@vger.kernel.org>; Mon, 28 Jul 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753711733; cv=none; b=fU4SNCpmTrPFWqdTy99BagBQ29DEgsYtMCqMmz5f7IFqBebl4wKj2OHNWl6RwRi2UxFNo3A3bMnYHg/9pKI12UBBwyX368bwq+2nhFe48va+pYgGh74JrOOtRVlsQUt9YCWdYCC5WTuesw3616nIx3US7GzSUew4FOmtPBVogf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753711733; c=relaxed/simple;
	bh=8KlG6JWT94Y6kxm+L2AzSNMPbK4WDQpxq9n8qL5AP0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSvxid98IWogs6WuwPIjuDrOBZ58e9ue5gT7PIqZVikReh0txTukEI2OxIJQAptt3N5B8FxImvpH4KmawYxoGbfk3AvZc5GSt2TM/rwRJHEJNn0oyyA2tENALJCK53O/RZgllQGqKOhx0kL5Ow+DBmiFx5WwyN5RGn57GczkX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhf9b50s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C472BC4CEF7;
	Mon, 28 Jul 2025 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753711733;
	bh=8KlG6JWT94Y6kxm+L2AzSNMPbK4WDQpxq9n8qL5AP0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhf9b50sdWwaohDfW/kHn0qqkhWk07S5nSum/gQbE6DfAiUu5Vb5EslQGxXxovF2c
	 SngArASbxZgvLAnYOzcXMkYZNc3i0hIjbhFUwISjHDQboW1wWKYFUXzqp5BOpbGaMa
	 /KNzbYnbz9KOP6qVh23yqpne8ccqzOuiV1RY+vDEbOfTLinWAyIO1Hypp/zrk89xc2
	 akWqZ/x3nKMtwfZ5mkg/6OaocFQNpPTvvlFtGt+0zTPOq8Mf2g7MZgVeFa1tBL5jXu
	 74FHOgjXXNYkR49DhoiTdoeOpTuNScjn575+lcPj69L+qYZP0f3MJobJdYSi2HvRXV
	 m3QbibWS7Kztw==
Date: Mon, 28 Jul 2025 10:08:51 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v5 00/13] NFSD DIRECT and NFS DIRECT
Message-ID: <aIeEc4C-2bMlTfMC@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
 <4db9d3dc-a2a3-4907-83bc-8bc07e38b265@oracle.com>
 <aId-28yBUQ9dBt21@kernel.org>
 <71179dbf-5299-45af-99c9-30b951018553@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71179dbf-5299-45af-99c9-30b951018553@oracle.com>

On Mon, Jul 28, 2025 at 09:48:48AM -0400, Chuck Lever wrote:
> On 7/28/25 9:44 AM, Mike Snitzer wrote:
> > On Sun, Jul 27, 2025 at 11:39:18AM -0400, Chuck Lever wrote:
> >> On 7/24/25 3:30 PM, Mike Snitzer wrote:
> >>> Hi,
> >>>
> >>> Some workloads benefit from NFSD avoiding the page cache, particularly
> >>> those with a working set that is significantly larger than available
> >>> system memory.  This patchset introduces _optional_ support to
> >>> configure the use of O_DIRECT or DONTCACHE for NFSD's READ and WRITE
> >>> support.  The NFSD default to use page cache is left unchanged.
> >>>
> >>> The performance win associated with using NFSD DIRECT was previously
> >>> summarized here:
> >>> https://lore.kernel.org/linux-nfs/aEslwqa9iMeZjjlV@kernel.org/
> >>> This picture offers a nice summary of performance gains:
> >>> https://original.art/NFSD_direct_vs_buffered_IO.jpg
> >>>
> >>> Similarly, NFS and LOCALIO in particular also benefit from avoiding
> >>> the page cache for workloads that have a working set that is
> >>> significantly larger than available system memory. Enter: NFS DIRECT,
> >>> which makes it possible to always enable LOCALIO to use O_DIRECT even
> >>> if the IO is not DIO-aligned.
> >>>
> >>> For this v5 I've combined the NFSD and NFSD patchsets because the NFS
> >>> changes do depend on the the NFSD changes.  In addition, I think it
> >>> makes sense to review/test these changes together.
> >>
> >> I'm ready to pull the six NFSD patches in this series into nfsd-testing.
> >> IMO we want regression and performance testing of NFSD, outside of the
> >> LOCALIO paths, before claiming merge readiness.
> > 
> > Makes sense, the NFSD changes are independent.  LOCALIO's access to
> > the dio alignment attrs in nfsd_file is a convenience.
> 
> As I was drifting off to sleep last night, my mind hallucinated the
> idea that maybe all (three) caching modes should align the READ
> payload. Would that make sense / simplify 06/13 ?

As in nfsd_iter_read() no longer being passed @base?  Sure it'd
simplify things a bit, but not so much that it needs to be done as a
prereq.

Bigger bonus is that it reduces cause for needless inability to use
DIO if/when configured to do so. So in that respect, definitely a good
incremental improvement.

Mike

