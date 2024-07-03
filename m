Return-Path: <linux-nfs+bounces-4599-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1769264D4
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 17:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2919EB255A1
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Jul 2024 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0956917DA20;
	Wed,  3 Jul 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcD587DP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BC17E904
	for <linux-nfs@vger.kernel.org>; Wed,  3 Jul 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020536; cv=none; b=rlZfQ+fdMQg/ZVGob6x91t0w37Br0DXs4bNVfCje7g8bTezcbDOQEqteqJZEdAB/TBPgBxTyHxzUrisop2Njtklki4Ur9F5Lby9zrmW0ahlmCKHBenI6lBWPUTpxypcj/uNTA151rAV6sOf+QdeiO/ls2vQyupP7bWPfLI5gPT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020536; c=relaxed/simple;
	bh=uamJg7AE2nLUeZhQd/dGJD0WXtKbpqECp8TS2b/eHYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN8vxV6eZK8gUqeki9JXoIWWaVQxHfCrwSDeDdtZ5Xf2X6jJgQ8uv5x11MSFnRIWEiVZ6C9WwFU1pESQLQ9fk9prqUR+jgn46T4UnjjIEzGMFfwadQ06zcPrkqUzLMhzaZRkRqmqeK0jZSxHm2VERKEYGJ6CjO2W4hRZZi+C9iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcD587DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34312C2BD10;
	Wed,  3 Jul 2024 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720020536;
	bh=uamJg7AE2nLUeZhQd/dGJD0WXtKbpqECp8TS2b/eHYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WcD587DPqBPSVdKZY9Sb1+oi4a1Jm6tf4BcB3VAkHXfnIE1gA8gU7cg2Xlw2TfrwA
	 IaUHD7K1hmAcgj2ScAD4GqVJpyWlhQ6cAi9XQduCPiGqTgDB5bhfukG+5kmfDhaGJ3
	 USy6H5PLDOCzLW1kywFwEXhKjZsCxOIt3r0LtF8zdiOffBCy362iZXfEqDkQ98mCgF
	 2NbUio3sog80p+/NfrU5uK3yr1FyjznOoOcI4ErvMmnZXzH4S/HqV0ki4ZCCx+vOx5
	 1b4+TZBt3gRtMcb0wZ3uyUxI/UMNUfA2lG93bpY7YbdfDwWU51EuhVE+tPM9HYYcNY
	 ot6S/g0JdnayA==
Date: Wed, 3 Jul 2024 11:28:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, snitzer@hammerspace.com
Subject: Re: [PATCH v11 00/20] nfs/nfsd: add support for localio
Message-ID: <ZoVuN1YbbxA8w0aF@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
 <ZoVrMBmOS9BalBXO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoVrMBmOS9BalBXO@infradead.org>

On Wed, Jul 03, 2024 at 08:16:00AM -0700, Christoph Hellwig wrote:
> I've stated looking a bit at the code, and the architectural model
> confuses me more than a bit.
> 
> A first thing that would be very helpful is an actual problem statement.
> The only mention of a concrete use case is about containers, implying
> that this about a client in one container/namespace with the server
> or the servers in another containers/namespace.  Is that the main use
> case, are there others?

Containers is a significant usecase, but also any client that might
need to access local storage efficiently (e.g. GPU service running NFS
client that needs to access NVMe on same host).

> I kinda deduct from that that the client and server probably do not
> have the same view and access permissions to the underlying file
> systems?  As this would defeat the use of NFS I suspect that is the
> case, but it should probably be stated clearly somewhere.

I can tighten that up in the Documentation.

> Going from there I don't understand why we need multiple layers of
> server bypass.  The normal way to do this in NFSv4 is to use pNFS
> layout.
>
> I.e. you add a pnfs localio layout that just does local reads
> and writes for the I/O path.  We'd still need a way to find a good
> in-kernel way to get the file structure, but compared to the two
> separate layers of bypasses in the current code it should be
> significantly simpler.

Using pNFS layout isn't viable because NFSv3 is very much in the mix
(flexfiles layout) for Hammerspace.

