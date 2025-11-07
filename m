Return-Path: <linux-nfs+bounces-16181-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F87EC4097B
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DF2427DAB
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67532C317;
	Fri,  7 Nov 2025 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C7t2i4LI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43E532B9A1
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529392; cv=none; b=b0Nb8j8dYqq1jZLWalJeSAftJTmTSR3c5f9HKtYeqU6sYMfgXliXbddwzYDNSkBvJv9+xDOrBIKLJLVdPiGKopqZSS1unh4xaUeiwni+walghqXhYHgJ8mt4EVM0OCWdRdSyVhUy+vaMBxMxRQwdhDC4AYhBAGsA5KQKNNMPStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529392; c=relaxed/simple;
	bh=gZPlPSTv4vUyBBKISFo8sFZRf2QEvSnaZwZGnwk9Sc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G3iGQ9c9fJWY6QKLQxlw1iK39S6mKg5RWHC4P75lgXGbDVVIYlw9wZaxKx0jzk73JssAIwyOosbjexqMSMlq2KWvOOoagefv/Qx3PIB/ZPIDYM7iM8Qx+LGjvKZbKto30lwzMEYxlxdixe7pmNPe7Tcknair/Ya2ApeLMVJSALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C7t2i4LI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3Mftqoo7XND7Ve8PKUbtrIiDL8rjATRc0VLCfWEb4ds=; b=C7t2i4LIMt8vsLmy+2K+AZ65HV
	I2dwCtwNsOwwFX33KFlhgLSib0hmRNpZmCqEXSBTsyr+SN14wnGW99QcV0JlkVT6URlMgSuG/2uMs
	G1YYe9e599MwjiMRTH85ytbMwTHZGllaHVYQMvZHaDqx5L7ekkQcHCNDn6DbK0+Va6h4rZ6x+PEVA
	EVljb5O0RBgiSS5TzFW46KAVOYIwiFF5Jwp6qHsEtj+29DHBWpYotD3X9LYdv37atBHL2dCbUz+Dg
	KyWg74ZfvCwNWx84zn7oKenSOm2MDeBHjx+IwBsWYeQn17ztugtMqkteXjIyoIf4loZkKS77XQq90
	RdBx1cZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOPO-0000000HaP7-29Jo;
	Fri, 07 Nov 2025 15:29:50 +0000
Date: Fri, 7 Nov 2025 07:29:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 1/3] NFSD: avoid DONTCACHE for misaligned ends of
 misaligned DIO WRITE
Message-ID: <aQ4Qbn5ViHnrVz07@infradead.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-2-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105174210.54023-2-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 05, 2025 at 12:42:08PM -0500, Mike Snitzer wrote:
> NFSD_IO_DIRECT can easily improve streaming misaligned WRITE
> performance if it uses buffered IO (without DONTCACHE) for the
> misaligned end segment(s) and O_DIRECT for the aligned middle
> segment's IO.
> 
> On one capable testbed, this commit improved streaming 47008 byte
> write performance from 0.3433 GB/s to 1.26 GB/s.

When you say "improved streaming 47008 byte write performance" do you
mean the application on the client doing writes of 47008 bytes for
each syscall, probably synchronous?  Why is a workload that matters?
How do the numbers look for normal writes that are aligned to a power
of two, and especially the preferred write size exposed by the client
in st_blksize?


