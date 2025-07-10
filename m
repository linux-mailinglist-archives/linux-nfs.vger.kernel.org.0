Return-Path: <linux-nfs+bounces-12971-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C29AFFB50
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2BF67BDEA1
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DF31C32FF;
	Thu, 10 Jul 2025 07:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wghbmiB0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF91F1313;
	Thu, 10 Jul 2025 07:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133555; cv=none; b=HVById0vfkwe1BGPDz6UMqIXWsXLZeRi/8wEXjXq7qIAAnWS01s9ufz/rFY13MvU1up8jLqQSqmMo6Jc93pAhMmN4IFZLtcAqB3hHUppHfJRAgJJoo8x6Uh4yXb0aKnqe8r/Ckv2agVcFajN36VyJyLkvfTC4oBIgpqPc8Ayd6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133555; c=relaxed/simple;
	bh=gCMkem5d/A7doCxfWVmIjW6YQ5Y9nQRnMwEoUb76CGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOUyuK1FvV88G1dyxTtklQLt0i5ZP5rJ4zzDTZT37Ue4Vwdaggt8y9q8RH+eyM5d0kIjCTYnkGgJmBJjOdk7wJ41PVovifKk8BYkzIfD+PVgy8IbXIPxU2hSp/eRT/vbhyqCLIMF+hQNvBF5ieaRTVWRDgYLtpGTRncur6a8pVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wghbmiB0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BstXHFPzZY6XduNwyFp1PorJGHzUJRaM8ppmM07cprM=; b=wghbmiB0g6NRKGfuTY4cDq7XYt
	IJYT79+STGOFxWqSk8GTcAYtZ6VKVCeMpvym7Bj8n2b/VZh6EV3vDS2iwusPoenEFO20VuTvoPGc4
	LTQCH0jpsuRox5gd4wxEeSbteKDWDCtz0nL0BpQz3r73SOS8+8rkPtjiR2HLx4R4+YzUQ05nf8OjY
	FuEDA4BWoAE9KAfjDJApOUKp9L+QHrUHNW9tUL2Ek4vs+YfZX69Ew07B1Bjl3n6udGq8LXC6wr2si
	Cz55RU/cuZqih8XCOI+j5lhoAe/y1vQBJuQVvudrHvPCsI1chBpDyOHev+8vzOc9BxTuyY/NMi8cG
	e3zhud1Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZlya-0000000B3uj-10gE;
	Thu, 10 Jul 2025 07:45:52 +0000
Date: Thu, 10 Jul 2025 00:45:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 3/8] NFSD: filecache: add STATX_DIOALIGN and
 STATX_DIO_READ_ALIGN support
Message-ID: <aG9vsPCSv0nQ5Bk8@infradead.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-4-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160619.64800-4-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 08, 2025 at 12:06:14PM -0400, Mike Snitzer wrote:
> Use STATX_DIOALIGN and STATX_DIO_READ_ALIGN to get and store DIO
> alignment attributes from underlying filesystem in associated
> nfsd_file.  This is done when the nfsd_file is first opened for
> a regular file.

Just as a little warning: these are unfortunately only supported by
very few file systems right now.  For someone with a little bit of
time on their hand it would be nice to do a pass to set them for
all remaining direct I/O supporting file systems, which is only about
a dozen anyway.


