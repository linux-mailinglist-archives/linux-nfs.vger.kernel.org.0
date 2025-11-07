Return-Path: <linux-nfs+bounces-16191-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F822C40A1D
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07CC1887EF0
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB98328B56;
	Fri,  7 Nov 2025 15:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s6lK+y4J"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C301C2D373F
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529971; cv=none; b=D3qXzV6ZMCwFzXO+BZFTWL8FIFtjq3lRxxIxLRDmlSTUuwIGnM7EtlJhoUtZxhOGIAI1kCfykkiD9J0tE3ah1+xdM+BnrFU8JVdQu/TyxLoRPJ63iat5CZ/M4CBh28HbuWyu8Ke8NOxn3LuAuSvJpLq0ZvNV6P0GFkIzds8/ar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529971; c=relaxed/simple;
	bh=/1BQZ5eBZShmt6K2XU9LlKiuhcxHmxwWEhD4UWVtSRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4qyYM7HjfwNjA1G/udOeEHkeUm6v6BxA/xx3TiCue6q103Ww7+O8sEDEJBGMt9HMrNQ19CEAQtNd507Q3RPTSX9TELf7CAPKk8rFMzLuwS2AcRtSLw3v0DZ2gv28fn9ReJ2hm3HelV+RMp9MpCoBpIk+Db8sgVIOKY45I2DoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s6lK+y4J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ByXNYdELe2aXmuAJj9FyoNtHXYsSl3jWrQxouy5AWnY=; b=s6lK+y4JFNEKivLSNX5a/Q6e1P
	gIKvcc8X/xbAU62qBhV6YUGAxNyieoTfjrBiJG77fLB17JM4Qa8Z9mtRAfDmQ6XVE3bKdkyPKanL9
	ZQzN8kTDTPBEo40Ki/Qh7szbEInwvPzR4W2AOcprKJrUI9Sjwif3Dc1O2ENJmlxPqhUgG0fECgpOG
	dkVuOYCcE46VQZVsHrEKS4eMeDg3kMyzBkebnQrhhQKFr9GJi2GpiYm74Ptf3ziGUsfnbCP+PXS5F
	vJZ3saJ+7viaXihUyp7afWV/TJMgyCESLx/u/sFgPCSGHpwj9vpvbnNCfUPGxpxH0j3P47pnbyhXC
	tMuFL8hg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOYh-0000000Havk-06Jq;
	Fri, 07 Nov 2025 15:39:27 +0000
Date: Fri, 7 Nov 2025 07:39:27 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v11 2/3] NFSD: Implement NFSD_IO_DIRECT for NFS WRITE
Message-ID: <aQ4Sr5M9dk2jGS0D@infradead.org>
References: <20251107153422.4373-1-cel@kernel.org>
 <20251107153422.4373-3-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107153422.4373-3-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 07, 2025 at 10:34:21AM -0500, Chuck Lever wrote:
> +no_dio:
> +	/*
> +	 * No DIO alignment possible - pack into single non-DIO segment.
> +	 * IOCB_DONTCACHE preserves the intent of NFSD_IO_DIRECT.
> +	 */
> +	nfsd_write_dio_seg_init(&segments[0], bvec, nvecs, total, 0,
> +				total, iocb);

I'd like to sort out the discussion on why to set IOCB_DONTCACHE when
nothing is aligned, but not for the non-aligned parts as that is
extremely counter-intuitive.  From the other thread it might be because
the test case used to justify it is very unaligned and caching partial
pages is helpful, but if that is indeed the case the right check would
be for writes that are file offset unaligned vs the page or max folio
size and not about being able to do parts of it as direct I/O.

Either way a tweak to suddenly use cached buffered I/O when the mode
asks for direct should have a comment explaining the justification
and explain the rationale instead of rushing it in.

The rest of the patch looks good to me.


