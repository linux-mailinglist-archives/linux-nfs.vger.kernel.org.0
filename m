Return-Path: <linux-nfs+bounces-15623-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E1BC08140
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 22:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3E744E2BD2
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 20:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D32F616B;
	Fri, 24 Oct 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVxjMRL/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5711C2F60DF
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761338253; cv=none; b=q+tEB7xv+Wy9RNN0yMAT0z63FNYg14lw1ucTMDEdeo2blC83CM5EFEDnEviaB4OjD3RLx5buJ4F/+pX67Acs/yyjVEQJPS9jv+v9CEl9m5X3YR7akJEQfLW6yZsnlscz1YJYsdn5yAfdVXoLcoZIQ93eOgUOWOQQmD6dKhv38Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761338253; c=relaxed/simple;
	bh=q7wOtUQ3w/xyhiTk/FxfT6i7WPIIu7UijsYHUvqAWOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZ8nog/kWMMIzyTrEkN+PYOWqYqdfMpVWhZx22VRBGQ9hqurOy9JsyQ+xTgkDnHN1oLY8LJF3EdxwAvv4tvvqNNF81A7kYL7dyqZdjl2vvrXbhcYfgWfSKsTzJhiHC5nbP8OpLKwGom6xEkRrpWnLq61qdO6CeJfJ15EFv8eLEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVxjMRL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89506C4CEF1;
	Fri, 24 Oct 2025 20:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761338252;
	bh=q7wOtUQ3w/xyhiTk/FxfT6i7WPIIu7UijsYHUvqAWOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVxjMRL//Z+ZAiLF2YNIzp5ninMCHaRXuAmh2+Yeu3P5T1SR8SYcLARTYUFB1qiZl
	 Gqrf9D6xWYeOb0ruHj6EK8dRwqBzqtp8jLVF0o6cS/KUhrktii9tjgCqNLGB4+gsE5
	 MFWu0afvjV/zdsLIkYApr8Lt+IcDtNBuHjEU4y4LHkYABxvVEx5kUBKWvcbQZWgkQU
	 4aZP2jc71/fQLETjzumMovs4ar23ny6O/bqhuDqegVfgg7IqAIXjI4Otvf9jLqQa/0
	 xhBVSXhTBxzYFZ6dsaMvBqPTdEvlqAALYQt0JTovL7uGaaH3o9NhchVMqZEtAYdXV7
	 yQY0p7mR1I9fA==
Date: Fri, 24 Oct 2025 16:37:31 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aPvjiwF9vcawuHzi@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>

On Fri, Oct 24, 2025 at 03:34:00PM -0400, Chuck Lever wrote:
> On 10/24/25 2:13 PM, Mike Snitzer wrote:
> >>  	/*
> >> -	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should persist
> >> -	 * both written data and dirty time stamps.
> >> -	 *
> >> -	 * When falling back to buffered I/O or handling the unaligned
> >> -	 * first and last segments, the data and time stamps must be
> >> -	 * durable before nfsd_vfs_write() returns to its caller, matching
> >> -	 * the behavior of direct I/O.
> >> +	 * IOCB_SYNC + IOCB_DIRECT requests that iter_write should
> >> +	 * persist both written data and dirty time stamps.
> >>  	 */
> >> -	kiocb->ki_flags |= IOCB_SYNC | IOCB_DSYNC;
> >> +	args.flags_direct = kiocb->ki_flags | IOCB_SYNC | IOCB_DIRECT;
> > AFAIK we still need: IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC
> > 
> > IOCB_DIRECT | IOCB_DSYNC was recently put under a microscope relative
> > to XFS performance and the resulting improvement was merged for 6.18
> > with commit c91d38b57f ("xfs: rework datasync tracking and execution")
> 
> This looks like an xfs-specific fix. I'm reluctant to apply a fix for
> a specific file system implementation in what's supposed to be generic
> code.
> 
> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
> systems, then it needs an explanatory code comment, which I'm not yet
> qualified to write. I don't see any textual material in previous
> incarnations of this code that might help get me started.

The XFS specific performance improvement isn't the point.  The point
is that applications (like I think DB2 is what started all this with
Jan Kara and the XFS filesystem) results in the use of
O_DIRECT+O_DSYNC.

It is a clear reality that other filesystems are catering to
O_DIRECT+O_DSYNC. And given our findings with Christoph that buffered
IO needs O_DSYNC+O_SYNC, I'd rather we not expose ourselves to not
having O_DSYNC set.

Particularly because any filesystem NFSD is writing to _can_ also
fallback to using buffered IO if O_DIRECT set (NFSD is doing exactly
that). Which we _know_ (from Christoph) that having O_DSYNC set is
important when we fallback to using buffered IO (like we do for the
misaligned head and/or tail).

Please let's not make the same mistake twice.

