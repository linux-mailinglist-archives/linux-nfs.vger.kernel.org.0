Return-Path: <linux-nfs+bounces-12963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D10E6AFFAC0
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AD9581E7B
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C422882B9;
	Thu, 10 Jul 2025 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VWo8+NIg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC23D2882AB
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 07:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752132217; cv=none; b=JShidwdeyM/tkAQhDIQgGxJk2GUCoy6RulY4lp3ZEhodMGPBiFHb1/hcYPuiuhaI83syJXI57u9FGTms5zCnEpgIg36DlG/kvHnr8PSSRlClx1hZCWC4j0NDiP24MvjQrshDBFN8QGYeMHzIT3WuJ3NDtmyVAYee8+GXpuao4t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752132217; c=relaxed/simple;
	bh=CyDo4VAQWqgN3LWyq+HoNsOnKOEgWUy3yGjSgFO0HB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mCFdALSbl73FBKtmgUS+zKgb2IT7o6BkEHLnsLZ9XGEN93yh7FbGi7Ud0g4J0lsXMyJpSVs3xjCeak6nPxVmM1lerMZkZczR0JQz+66sZ2nlcm6EHns6+hSnvuUhfeNcJQat/rEN+kvHbQdSOF6kskuIOSreiveq4ZVoYkHSsd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VWo8+NIg; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zhu51UN/dIOWH2MNWrYJCb741UxI9vwxs34TA90lO3c=; b=VWo8+NIg0PFiW8xMbqfSHlWbrU
	YaLL/PCKSjNT0vPlssuANGvxbewXbGrrYTYWpz3L5yMWCdHCcNiLpLB5p9LZYRnc4Q9/VwNmTDlem
	OdEkgY3bDQlmGVxv/jRv3z8/dWlpML/Hw7sYnhtB2fsC8MRjGQGamAWMT6KbbopsCdoJGhxh23O0A
	tGh94V53Pfnfjq4SNjo7khZJ7ia7LS2mPKhUKTbxz0Ihn1ERZOYMh2Spp5FOn3mCcnCAJKuP4uEO2
	kP5Y3fU8IVIJ7h6CfeIv9A8MRP4/WRvjqlnRoTdgarJ0hDewffoBvCjhrvSXj32hlPP2pn5mEEu7R
	JcsO/W2g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZld1-0000000Azix-1lNE;
	Thu, 10 Jul 2025 07:23:35 +0000
Date: Thu, 10 Jul 2025 00:23:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	linux-nfs@vger.kernel.org, Mike Snitzer <snitzer@hammerspace.com>
Subject: Re: [RFC PATCH 5/6] nfs/localio: refactor iocb initialization
Message-ID: <aG9qd8hwXpUlaqTS@infradead.org>
References: <20250708162047.65017-1-snitzer@kernel.org>
 <20250708162047.65017-6-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708162047.65017-6-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +	// FIXME: would do well to allocate memory based on NUMA node.
> +	iocb->bvec = kmalloc_array(hdr->page_array.npages,
> +				   sizeof(struct bio_vec), flags);

I don't think that's a "FIXME".  Either do it or leave it, but given
that memory is allocated on the local node by default I can't see why
that would be useful here for a short lived allocation.


