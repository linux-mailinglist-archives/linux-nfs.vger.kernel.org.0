Return-Path: <linux-nfs+bounces-12468-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6EADA74B
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 07:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CCF16DEC4
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Jun 2025 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4D6262A6;
	Mon, 16 Jun 2025 05:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wTxKHjjf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E3811713
	for <linux-nfs@vger.kernel.org>; Mon, 16 Jun 2025 05:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750050031; cv=none; b=REfvXtOdAkWnkRD+2FfasIpC2YYNKIlFvIzUYinu8WPU2hfWnBMvKkkIEkaqr4GRfKyIdry284NBzC3Vu9LfvoC376IyeIZKUyAse6DPbyjRf4JEYmRuHrbL/A848I9uQgIiNI4B0gLK9QMtbj8VID7Bi+ndaLozlL7zvjOGebU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750050031; c=relaxed/simple;
	bh=alZmYTZyIBEOihfUN1k9WnEmTfBB7fv7twYf5iOuc9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UogH3Sya/zMJUChKP4MePZVo8xHsEHJcMKN90FweFuyLGD7+keg0B/wW57U9IXC/kCYNW1rUG/RFRzoHliWr5L2QbixQuGz7tB/sVf7KXohK/aF9QQvXLnoE64avIQgaq2aEg+igKjNCAhp+PSLcfULOmWLOOK+bJaLTErGSrrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wTxKHjjf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5u6FqCI3HZfTV8mHD3eSFTSMLKLbfrfM93hNt+TwUxw=; b=wTxKHjjfHmOfqwsSihxRGIYNJ7
	MWJhz5lwHM4EiPuebafpDo8kBhEbPt6bLiuQbmylZ8p77zsHskHbKkKQrIPsWn/LJJ1sQkhkfpI74
	T+pXwxJflQDYRYt2Fhu3/UTDTssfSa6TSG4zuV2vq62/4aXmyn2RICCTA50grHqxtf31dKrxyznK0
	NrvJxo2FpJ6hNyleRy1p7WY1xVWiOjvYbRlVB2j4sYz6FgURQB5ZeHfK1H4ynlsDD95TE1XNoqxxO
	ieMMAFUTwzvXFHpN0Gq4vIAbKscyU/lplUcloExxo+kUyX/1ONRZzbRAMODHz6jQeIFMTlUXm/U0q
	hp22TCVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR1xH-00000003Ne8-0aJK;
	Mon, 16 Jun 2025 05:00:23 +0000
Date: Sun, 15 Jun 2025 22:00:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH v2 1/2] NFSD: Use vfs_iocb_iter_read()
Message-ID: <aE-k56uvVsWqdLb0@infradead.org>
References: <20250613200847.7155-1-cel@kernel.org>
 <20250613200847.7155-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613200847.7155-2-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Jun 13, 2025 at 04:08:46PM -0400, Chuck Lever wrote:
> +	init_sync_kiocb(&kiocb, file);
> +	kiocb.ki_pos = offset;
> +	kiocb.ki_flags = 0;

ki_flags is already cleared by init_sync_kiocb, so the line doing that
can be dropped.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


