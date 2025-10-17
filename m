Return-Path: <linux-nfs+bounces-15345-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F7BEBF18
	for <lists+linux-nfs@lfdr.de>; Sat, 18 Oct 2025 00:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C1ED3567CC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Oct 2025 22:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AA52D7803;
	Fri, 17 Oct 2025 22:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvtMbox+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F332D739F
	for <linux-nfs@vger.kernel.org>; Fri, 17 Oct 2025 22:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760741387; cv=none; b=oi7WUS4glRsCa0cAqXZ5jh2X2AKPkVCjeIN2Q0e9iVsbQNs03SVk0Wwi4DHPYd69bvRS3X7UGM2NQw3mImFa9UAKoWmlEolpkfzyhTndJ+tEY4O4y5/mT3ytb5MSJVMw9Ctxj+YHaR6n/CyFIYg/w0UrMjN5bYkodNuPGzD1CTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760741387; c=relaxed/simple;
	bh=S/M3LdyAaPxr053xuE52QlA84N1NHRBmDzqwY30KeuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IM040h1WrV5S+wj5PaHQHyXF6FPr6R/86fmDHIKPVk0B+r+Jx3s6KgGvf7Bv6j4Fg8P5rvrFTiaOeIHSvXBOyYAh8sfNOlcNvvQww8XsqOst1ZuOAnynACTd1ZiMqfkz/TGL9GvGq7so/pJXPLrRVGzkEvYXiyka6yHy3z1p628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvtMbox+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AED8C4CEE7;
	Fri, 17 Oct 2025 22:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760741386;
	bh=S/M3LdyAaPxr053xuE52QlA84N1NHRBmDzqwY30KeuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VvtMbox+fkkayu2cRk73+kDlZfD+ifsC6wHP0snr8aMtuB5uzyutH3EXe65krAHa7
	 30FcQ9g/lJI2EpTrmqvPEmBsi0Sm0m8U3afCumQa96C3dewsLQCR8aVTTdfZlM34zH
	 hqvW1twFRKT05H7wLkQnTtCsa4X/1/u1Irc6kU7uzO9v9ywehJMfuIInDnxUwOviWK
	 aIybHeh/m07pW58Gu/O4/iyxJziNFyKs+A1PwX97r2U86YuEALryZ7ySjM3xD8fsZF
	 UF8CUjxjmlHTYI7ZNhI2PBYbxoC6eJRE7RKfD+T6S6zIVbM44lK3KJ+VJ32wjgQoml
	 L3EI2QDdoa/Lg==
Date: Fri, 17 Oct 2025 18:49:45 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aPLICbfqb3AHAKEy@kernel.org>
References: <20251013190113.252097-1-cel@kernel.org>
 <aPAci7O_XK1ljaum@kernel.org>
 <2e353615-bb40-437b-83ea-e541493f026c@kernel.org>
 <aPKvGynfz0n84Ldm@kernel.org>
 <5bf67a27-8a1c-4771-aeba-625bb20ec45f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bf67a27-8a1c-4771-aeba-625bb20ec45f@kernel.org>

On Fri, Oct 17, 2025 at 05:54:00PM -0400, Chuck Lever wrote:
> On 10/17/25 5:03 PM, Mike Snitzer wrote:
> > On Fri, Oct 17, 2025 at 10:13:14AM -0400, Chuck Lever wrote:
> >> On 10/15/25 6:13 PM, Mike Snitzer wrote:
> 
> >>> +	*cnt = 0;
> >>> +	for (int i = 0; i < n_iters; i++) {
> >>> +		if (iter_is_dio_aligned[i])
> >>> +			kiocb->ki_flags |= IOCB_DIRECT;
> >>> +		else
> >>> +			kiocb->ki_flags &= ~IOCB_DIRECT;
> >>> +
> >>> +		host_err = vfs_iocb_iter_write(file, kiocb, &iter[i]);
> >>> +		if (host_err < 0) {
> >>> +			/*
> >>> +			 * VFS will return -ENOTBLK if DIO WRITE fails to
> >>> +			 * invalidate the page cache. Retry using buffered IO.
> >>> +			 */
> >>
> >> I'm debating with myself whether, now that NFSD is using DIO, nfserrno
> >> should get a mapping from ENOTBLK to nfserr_serverfault or nfserr_io,
> >> simply as a defensive measure.
> >>
> >> I kind of like the idea that we get a warning in nfserrno: "hey, I
> >> didn't expect ENOTBLK here" so I'm leaning towards leaving it as is
> >> for now.
> > 
> > While ENOTBLK isn't expected, it is a real possibility from the MM
> > subsystem's inability invalidate the page cache ("for reasons").
> > 
> > So it isn't that NFSD would've done anything wrong.. it just needs to
> > deal with the possibility (as should any other DIO write in kernel).
>
> Well my point is that if the MM/VFS can return this on a buffered write,
> should NFSD be prepared to deal with it in other places besides this
> path? I think it's handling ENOTBLK correctly here. Just wondering about
> elsewhere.
> 
> This is something we can set aside and worry about after merge. It
> actually has more to do with the existing parts of NFSD, not the new
> direct write code path.

I'm only aware of MM returning ENOTBLK in response to a DIO write that
it couldn't invalidate the page cache for.

So existing NFSD code shouldn't be exposed AFAIK.  But yeah, worth
another look.

> I'll repost the "stable_how" patch and this one together in a new
> series, for Christoph, and pull that series into nfsd-testing.

Awesome, thanks.

