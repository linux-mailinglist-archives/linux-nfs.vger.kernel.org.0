Return-Path: <linux-nfs+bounces-14579-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03848B869B4
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C139F1C86E61
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Sep 2025 19:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BFD15853B;
	Thu, 18 Sep 2025 19:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cy41kApT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38D60DCF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Sep 2025 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758222103; cv=none; b=AQrxpbXSCFg4yWSaQJYICm7WCIz6JtedPV5fxAqqmnzmamVR7fRxgQNrhOfdslqa1694OaUhN/BAl5mFQd/xjxFR0oXrioR5hWvN21gSz4yJTy15sOJNlLJu1Rst0hczULDEaGFNQ0JjGZ2B9QOm4lBcXSNldyVQM3wNDZdM+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758222103; c=relaxed/simple;
	bh=+ESVb4jmyCzpLiW7gx640EQnRqFnUZVFevwy/myerKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMCCJdBefLYvSq4pVt5uX3iffdW8hFzysXVEkC4tcjXBA1bta/FGFc4g7ItqmCGLa4piVZ2xW1kNJypviwzY7DXmicsajWERr1Dk6+j0D6R3gK2ykPXpquHIGA5hUJjY/rilAgCYvA9OpNGIJFSYiw3qTeUzv/D51N53Pg9Utu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cy41kApT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE18C4CEE7;
	Thu, 18 Sep 2025 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758222102;
	bh=+ESVb4jmyCzpLiW7gx640EQnRqFnUZVFevwy/myerKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cy41kApTqWn6VIUqppUgXpWs/ksin04cBM5a+19DwMvI6CdnnZ+QYeYZR9kF2QE6M
	 5Ty7nZnoHlVUegpj2H/xxnrV/npBCYxPulux77brMQJseaFwk1bs9KTv+EAZrOg2+H
	 yo2aDuD5ii71xXbXhB69sHzYL+ZOrf409ilAjhoOZaIcMXqhUz1aE4e3qstiF81+Wb
	 Nm+I0zgZcvI9rR8EpPgW+5JIiNOyrHucZlV12yFuoL8/A6RhzxYr4daV1H/e8fLio4
	 vD91eHJieExAMWO8jBppo2AUlEnIug3X1ffWRPfpnyvMbggB3mWxG3X1anpxXpepym
	 f2gvAUvG0+SvQ==
Date: Thu, 18 Sep 2025 15:01:41 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, jlayton@kernel.org, okorniev@redhat.com,
	dai.ngo@oracle.com, tom@talpey.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aMxXFcJuTKYbixFB@kernel.org>
References: <175811882632.19474.8126763744508709520.stgit@91.116.238.104.host.secureserver.net>
 <175811952039.19474.5813875056701985362.stgit@91.116.238.104.host.secureserver.net>
 <175815178827.1696783.10535533600809037950@noble.neil.brown.name>
 <0ab1138f-9085-444a-9e8a-822c29e404bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ab1138f-9085-444a-9e8a-822c29e404bd@kernel.org>

On Thu, Sep 18, 2025 at 11:42:03AM -0700, Chuck Lever wrote:
> On 9/17/25 4:29 PM, NeilBrown wrote:
> >> +/*
> >> + * The byte range of the client's READ request is expanded on both
> >> + * ends until it meets the underlying file system's direct I/O
> >> + * alignment requirements. After the internal read is complete, the
> >> + * byte range of the NFS READ payload is reduced to the byte range
> >> + * that was originally requested.
> >> + *
> >> + * Note that a direct read can be done only when the xdr_buf
> >> + * containing the NFS READ reply does not already have contents in
> >> + * its .pages array. This is due to potentially restrictive
> >> + * alignment requirements on the read buffer. When .page_len and
> >> + * @base are zero, the .pages array is guaranteed to be page-
> >> + * aligned.
> > This para is confusing.
> > It starts talking about the xdr_buf not having any contents.  Then it
> > transitions to a guarantee of page alignment.
> > 
> > If the start of the read requests isn't sufficiently aligned then a gap
> > will be created in the xdr_buf and that can only be handled at the start
> > (using page_base).
> > 
> > So as you say we need page_len to be zero.  But nowhere in the code is
> > this condition tested.
> 
> Despite what the comment claims, I had thought that things would work if
> the payload started at a page boundary in xdr_buf.pages. But I can see
> that page_offset applies only to the first entry in xdr_buf.pages.
> 
> So xdr_buf.page_len does need to be zero. That check can be added in
> nfsd_iter_read().

I had a look at trying to do that, it wasn't obvious given
fs/nfsd/vfs.c doesn't have any direct access or need for xdr_buf.

But I agree just adding that is ideal at this point.

> I prefer this approach over more elaborate checking against the
> dio_mem_alignment parameter because for the overwhelmingly common cases
> of both NFSv3 READ and NFSv4 COMPOUND with one READ operation, page_len
> will be zero. The extra complication is hard to unit-test and will
> almost never be used.

Extra checking might be interesting so nfsd_iov_iter_aligned_bvec()
is used (I've found its needed for the WRITE support).  Maybe an
additional CONFIG_NFSD_DIRECT_VERIFY_DIO_ALIGNMENT option? -- might
seem overkill but I've found the iov_iter checking to really save me.
One of those things that you really only need during development, to
verify you didn't somehow miss something. But for release we don't
need/want it.

Anyway, just a "futures" tangent.. nothing actionable for this patch ;)

Mike

