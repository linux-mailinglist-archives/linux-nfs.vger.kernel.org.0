Return-Path: <linux-nfs+bounces-15530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50436BFDE21
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 20:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F094534E434
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4AD34DCCE;
	Wed, 22 Oct 2025 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4R0Pw4Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA56A34D4CE
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158372; cv=none; b=BBzw/5+c4thUCdjSeW83RsNdM/Hvg+wzLz71Zk+vlkZPTMBPksX72IIn0ajpJrbd4KuLWYIUZ/E8VtCPpT/c+8+Y5lKlMMzgUBQeWlww6atXF1bdkcuDb7DNCO4+Yypg2YT0mHXb+l7niutkefoq7gM4KfGdHh4GS1NjG0K6TkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158372; c=relaxed/simple;
	bh=jXb1y2G4IGUVwg06cMQeMu1rZ393ryy3gHMnTiySGzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMrpGIMIe1eUJH7yMFb1EcCm/KavIMxQ/B53YyYfhTOU9flDrlMU/U9W6N7DKhdWcF2rzP/L4gLuklC4wYeoalVay85/c7DZqmkgp5qKJ05zGoaSKHHOv/KqU5bUL3rcJLueeZoUd87zn7CPBwvMUa5U5w9OH34w3VUGyC3IHW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4R0Pw4Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A681C113D0;
	Wed, 22 Oct 2025 18:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158371;
	bh=jXb1y2G4IGUVwg06cMQeMu1rZ393ryy3gHMnTiySGzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4R0Pw4Y5KrhlzpFpWlRQ/sCu5ITTV9MlZCWOqoyhyDVK2wLIts+2pLhynPUaTYzp
	 2U0KB5qHIIMFdC2m2vxz5Gdtbf67MStrnlDDm7SbTD5WTKPF4EooPh+JcmRAYC/+UI
	 CPkVEA5wQlP2xa0SuKZ4sDq7+m/52GVpbdrTjxlmJZJwDB8fpbmXQ/3l3iLr/TSYkn
	 pMoTysPRAKam4EjGBOZNxiKhByhWCmmVbExcrkqHjkIojHwAii2h9LXEjr7rzyqTSn
	 R7I9i5caZ3nrb4E6ktF+3duX+JztR+cCHIXtAsCIwlz9F2pU3+weUl0DMy7JEBaaUg
	 JXk8DX92G93SQ==
Date: Wed, 22 Oct 2025 14:39:30 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Tom Talpey <tom@talpey.com>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [RFC PATCH] NFSD: Make FILE_SYNC WRITEs comply with spec
Message-ID: <aPkk4qNNqGKKDiog@kernel.org>
References: <20251022162237.26727-1-cel@kernel.org>
 <63c79d16-fec8-47f2-ace3-0b8fd4f41528@talpey.com>
 <aPkYedLyruWyCO0o@kernel.org>
 <2d204966-abd4-4aa2-90ed-ffd69f059384@talpey.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d204966-abd4-4aa2-90ed-ffd69f059384@talpey.com>

On Wed, Oct 22, 2025 at 02:25:42PM -0400, Tom Talpey wrote:
> On 10/22/2025 1:46 PM, Mike Snitzer wrote:
> > On Wed, Oct 22, 2025 at 01:22:52PM -0400, Tom Talpey wrote:
> > > There needs to be some statement of the performance consequences of
> > > removing this "optimization". I'm going to predict it's significant
> > > on rotating media, and should not go unmeasured.
> > 
> > I agree that rotational storage will likely see an impact.  But
> > Linux's more recent (now like 14 years ago) FLUSH+FUA rework really
> > helped improve things -- that was a major undertaking where Christoph,
> > Jens and others really did a fantastic job of breathing new life into
> > Linux performance on modern rotational storage.
> 
> I agree, but I think honesty requires it to be measured. Writing
> the metadata has to wait for the data to make it to the same storage,
> this can roughly double the total latency. If it's small (NVMe), great.
> 
> This kind of "optimization" was tried by pretty much every server
> vendor in the early NFSv3 days, I recall many amusing scenes at
> old Connectathons where the schemes, or completely unaware servers
> were exposed. There was no place to hide when operation latencies
> were measured in tens of milliseconds. Same game today, just shifted.
> 
> > Related blast from the past: https://lwn.net/Articles/457667/
> > 
> > My point: may not be as grim as we think...
> > but there is a difference between SATA rotational storage and
> > "enterprise" rotational storage (e.g. NetApp or EMC fronted by
> > elaborate caching that is configured to report wbc=0 because they have
> > battery backed cache)
> 
> Yep. But this is upstream, right? It can't assume.

Correct, but catering to really old and slow rotational storage isn't
(or shouldn't be) a priority.

> To be clear - I totally agree with the change. Only concern is
> stating why it's so important, in the face of performance.

Yes.  In the end, data safety is priority 1, eeking out best
performance is secondary. I think all of us can agree on that (even
those who have really old/slow rotational storage that will get
whiplash from this change).

Mike

