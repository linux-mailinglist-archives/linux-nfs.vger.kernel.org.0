Return-Path: <linux-nfs+bounces-15650-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C994EC0C420
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 09:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74ACC345C85
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 08:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CE424E4BD;
	Mon, 27 Oct 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uqVG721R"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C52E88A7
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761552847; cv=none; b=Xld+NQtNE/IeBSxzWDPwvCxWODZ4EKMiayhuH7GbI37h8kOlRRiG86nlc63zN6CbTibb3KO6fjHG+SdC7nljaM5Jrp816ZcwOLboA1z6XRwxwOlV4zAs2wgbmAOAFy8EE0CT9wgwQMM1V8QmXiOR4BAmN9yBxpif3nqlBJY+Q4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761552847; c=relaxed/simple;
	bh=zeyTZpMznlOHRFFkZzvUVcB/vrezPLFDlpYnnjnpC6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nbkuTtkAN2kTYyDXubZ6UvRkOzFS/H7oT8cmX37SF3JzjZJPDZic0uvugTkwV+3APKnWQ4yzEcTEE7hi/bvcw9IL7clJUhZFTWyacPZWxyUXiMVvbrqgp1zi4jii0xr6OD9vfIhWeRk2J9s315kRzcfFYBPfflSKWpJqKOgs4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uqVG721R; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DmDZzJBMn2K26k1b9Xq8OOnLWqHx6fOLD+CasJ2tmlg=; b=uqVG721RFgTB9KFxSd+/FCnUnA
	yWl2uWFHY6QE8FCuOJiE3W+uJpVSXY2HFlslru+cIoWOgQMOVlpsB7dyN33cCx5ByyziYhEDiyYnJ
	byIF2ZF7ohUkNb6lrmVZJWdQT2J0TSeqSCQU6WQtLjJUSg3NkaXhUSCSkCpTYs7XzC8rnFX9R7CMw
	JhGjzHeb8wmucyXGwj9EZSmULhxnfDrZtpuhZyhfD5l18nAHgbLZgQ1zKhGGrILc3a8D/OW1cxNAV
	pz1XhGzxjVWMXS1MBXZ3aIweAILgepPS8oSJx6oYlmq62xtNsbwvE4fRxQDYy568Ap8J0gHFiobP0
	f6viiuUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDIMd-0000000DKf5-1mEc;
	Mon, 27 Oct 2025 08:14:03 +0000
Date: Mon, 27 Oct 2025 01:14:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP8pyxcuX72SSxIj@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvjiwF9vcawuHzi@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 24, 2025 at 04:37:31PM -0400, Mike Snitzer wrote:
> Particularly because any filesystem NFSD is writing to _can_ also
> fallback to using buffered IO if O_DIRECT set (NFSD is doing exactly
> that). Which we _know_ (from Christoph) that having O_DSYNC set is
> important when we fallback to using buffered IO (like we do for the
> misaligned head and/or tail).

No, I still don't know why any sync behavior is needed.  I've been
explaining how the sync behavior works at lot lately, but I still
don't understand why we think we need it.


