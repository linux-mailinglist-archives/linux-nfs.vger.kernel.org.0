Return-Path: <linux-nfs+bounces-15674-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D309C0E152
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F5F419C009C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D1A1F428C;
	Mon, 27 Oct 2025 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B4ZuQZhR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B441E1DEC
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571894; cv=none; b=Kdl+NMQixzJujzMTAHP/74HNUFPZv/CsCBFSBvhVRXWq1+VJd8Vk4vcyr7F9iZVX1qoGaYvkziEl99/DFYgQHlLK1V2OIDvp8KQTc/62M/WLIGh+tRTzhfjlto0UwqMsb1UWmxBmYi1ZGj2AbLPtB3mZZgB1lNQQLKcqB3TYOq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571894; c=relaxed/simple;
	bh=scOlAiyX+CiIaVP+88maJ8d1fjXS4tXuBZ9FWYm9Pps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNgEtp+Mia+MPFH7LXdfLudhMGOrsEr1Gvy/PXblOXdmIV4rC6eCXSejd2nrA3hwn7wF/shHuhoFDvEQCJHbQhftXJLv+BBEL0PzgxO3lREG98xZCb0i0GxcGXdLBx6NMK99zV7x8zEAloHsasZJIR2JhM/nKORBI8NKmCdrHqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=B4ZuQZhR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RDm4cbH4/wkQbp2RI++MByGQUZdICOfVbgfRTrGqvyE=; b=B4ZuQZhRHRCiK5Qo8r/kc3JKkn
	uz5dcIOeP74xs90QE4MmCO3UwKnegwnIcfTEqd+TCrUwvFCb4Lv+qtMryg5kO7jtCWu8KWs7RKBTI
	PWZNt/uQZ8eCtkSQbQTGExFePCAKKp4mSEP+BO9ffZkSaOCw4KqVVgzcrW0dCynRSP5uIrFlybOdv
	q0o0g6sR/aZG96t3RalQub557Nre66lsQy8HCP/VOzUzWyzZ1DYHsBQGTlluP4n9b9oA93sxUwB0e
	wVQnSpylDPFE6wNANRin8kGASCWyj1PBrQkDWeIgk0Byp1LJwVZ5dayYhnE/Q/7V4i9QRIngMonXn
	m6eKbP1g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDNJp-0000000E2kQ-2zqc;
	Mon, 27 Oct 2025 13:31:29 +0000
Date: Mon, 27 Oct 2025 06:31:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aP90McGd2O49RBn2@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-15-cel@kernel.org>
 <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aP8pfpm6jb-Hj92B@infradead.org>
 <d56f3b5c-2628-4714-8e77-7e904c169e90@kernel.org>
 <7d70c343-2630-46ed-9568-0cbe6d289827@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d70c343-2630-46ed-9568-0cbe6d289827@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:30:25AM -0400, Chuck Lever wrote:
> >>> If (IOCB_DIRECT | IOCB_DSYNC | IOCB_SYNC) /is/ correct for all file
> >>> systems, then it needs an explanatory code comment, which I'm not yet
> >>> qualified to write. I don't see any textual material in previous
> >>> incarnations of this code that might help get me started.
> >>
> >> IOCB_SYNC always needs IOCB_DSYNC as I explained three times now,
> > 
> > It wasn't clear to me until now that:
> > 
> > a. The reason to add SYNC in this case was only for DSYNC
> 
> I might have gotten that backwards. The only reason to add DSYNC was
> that SYNC doesn't make sense without it.

Yes.  That's something where the IOCB_ flags made the pre-existing
O_ flag magic even more awkward.

