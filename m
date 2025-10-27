Return-Path: <linux-nfs+bounces-15684-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3C2C0E981
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A0F3BECB3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB741EEA49;
	Mon, 27 Oct 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ramqz2+6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56C62B9B7
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 14:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575783; cv=none; b=epzr+OznCmO2vJrPRxgWCLwAig4X6+6EiyE/zzMqi+5GTzWU/+YdZabclE+miClDLas/5h0P8Qc5BLZodjUQxKZQeHL1DXUZQja73JR+s0KspWHUaH//5+wa6PGCIQ8aVOmyH2gtWzJ7/LKBEn4l43WOUr19QNDRSo9zmZo/MfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575783; c=relaxed/simple;
	bh=Qoqq8zXtTyx9kxW0XtwmIzSWOozAd9i4Y3lj4WCCA4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY7aRPo1apnsz3LGzEyBGRwfltJAb5IhXnvzAjzZFtdQMkd3LlR3LppIsAe2M2ylRh0Bi/ixBeMcV14i+fO04utWIpVSIfjd5FxBYL2TuKaOMWzHcWHZe5jDTIiOm7Mi5A128sAbqKVkewaJEzckgiRqP3xHbSM4O12i2JzF9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ramqz2+6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L+STrSs349Hln6AySDkX9F3deQVbrYs97msvdinAGVs=; b=ramqz2+6Nk9TaHlHmM8iH5Sosa
	rAZ6k1hlCUGxXnRQ8NXnMapYwM0J7QL0T2ZyigIw4ZT2bz2a9Fs18VEMdFCRnkxmUqN+TgwQ6zcSx
	qTAewRYseCYv1hYaKgNvMVyrn3Xyb1NRNi9jJaiyNPytaFvvCUu21flte/VHwBMah7UDb/vlxK+Kg
	bE56Qai0UIWIrqDlYR5iK/H6nKxlnN4qPKq7tGWEi5p5c8YxYc4IEQ2TjaNIceaw7GXkPnXoYRPHk
	IB2MJa1BtAP0oKuAVJHqd0hTDmIFRIt7EWVl4RUG4L3SIEEtXzSoGG5J0hA6BU7upX2wVkX7HfZZg
	EKrVD8YQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDOKY-0000000E9EW-1Vni;
	Mon, 27 Oct 2025 14:36:18 +0000
Date: Mon, 27 Oct 2025 07:36:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chuck Lever <cel@kernel.org>,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v7 05/14] NFSD: @stable for direct writes is always
 NFS_FILE_SYNC
Message-ID: <aP-DYgcrcd2zSzrI@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-6-cel@kernel.org>
 <aP8n4iqMPie83nYy@infradead.org>
 <3c3774a9-a1f1-46a8-a81f-ebc3dde228c3@kernel.org>
 <aP9zU_9e2VDw4G7I@infradead.org>
 <aP-CW5_egXzHS1jz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aP-CW5_egXzHS1jz@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 10:31:55AM -0400, Mike Snitzer wrote:
> > that.  High-end enough device won't have one, but a lot of devices that
> > people NFS-export do.  For pure overwrites the file system could
> > optimize this way by using the FUA flag, and at least the iomap direct
> > I/O code does implementation that optimization for that particular case.
> 
> NFSD_IO_DIRECT isn't meant to be uniformly better for all types of
> storage.  Any storage that has a volatile write cache is probably best
> served by existing NFSD default (NFSD_IO_BUFFERED).

That's a very odd claim.  Also what does it have to do with the rest of
the discussion here?

> The client doesn't control if/when NFSD would make use of O_DIRECT
> (other than if it sends misaligned IO and NFSD must do what it can to
> ensure it safely hits stable storage).

Sure.

> In addition, the use of NFSD_IO_DIRECT is intended to allow for
> systems large _and_ small to get the advantage of lower memory
> utilization.  Buffered IO is one extreme, but even using a model where
> NFSD were to not impose NFS_FILE_SYNC would create a situation where
> more memory needed batch IO and then wait for client to send COMMIT.

Why?

> The current approach of using IOCB_DSYNC|IOCB_SYNC have performed
> really well on modern NVMe servers.

NVMe does not implement a concept called servers.

