Return-Path: <linux-nfs+bounces-15747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A7C18B62
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 08:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE5D44E8ACB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Oct 2025 07:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D21284662;
	Wed, 29 Oct 2025 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zovNCDkP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A82D97AA
	for <linux-nfs@vger.kernel.org>; Wed, 29 Oct 2025 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761723127; cv=none; b=OC4mW/Ucrw/F1uV1KdpMasiFK34FSCh9ugK43534QXZaitNQV+mjDJESo0ivd9Tj0p4lnMeXrxOv683rvdUxTFi5qUOCZV9pkjCnLpTp4Ord7/isKHjPRt1wRwTwXsZ2MMiaWBGJOaRYmd9yHA4vfh3Bc1vWb5X+mKNxh3aOPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761723127; c=relaxed/simple;
	bh=cOnh0mcW4tBO8MFO9XFluGJnR8nCfRD9eS1zB0t6G6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4B35urAsIiJE0V1J/KXofZDGwc1NeE9EipoSczPPBzlHe3BFFaFDfPxKsSLpg0z6KTRMVur5JFxBRP0z26kWMwgElwdxNKtjIqhVI277Ta8mKZuln3zUV/p/mqJMqOMqBB7hc66RLfGsYo+GJ80UlbB+XNFGu3tVKzgM6r/swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zovNCDkP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZpKT+I1HLBjxppzlqJ7grLP/xwS4Mqx5x8ViuJ67iwk=; b=zovNCDkPUZbX1tUhIuAmojsxPr
	KNct8N83zkV6VomZQWS8Ogq0uDCfOd2Wg1g0NcJG7ltQGRPr4skpDCu1pgmlO1xLC5za1YsVheWGm
	9GLOZqWMjPsZFO/84KuQwdPDblIY0qiOBnG/j3F4UwrgKw5H0WgX1SlGboUKBMraFmx7h5xl019Sd
	XpbwVqVWoV5zo0jASRT0W7POegdYe3wVHT2JYHvF6ph75nusZ1HwsxR84vB6JUabJru6tZL7KxFHT
	yAo2dvusNRe2tv2J0sl5DWxSzr3ZXqvDpM8mHv23WgxiikN+g9GOeD4TS6mzdz2TKepecSRFwvegm
	d1/o1BDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0f3-000000006mH-3gwW;
	Wed, 29 Oct 2025 07:32:01 +0000
Date: Wed, 29 Oct 2025 00:32:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 14/14] NFSD: Initialize separate ki_flags
Message-ID: <aQHC8bR_P6ojXP9C@infradead.org>
References: <aPvBtWOIe9hJBrKC@kernel.org>
 <ab3fbc43-864a-49b1-b3fd-ba9034d0c0d2@kernel.org>
 <aPvjiwF9vcawuHzi@kernel.org>
 <5017c8dc-9c14-4a92-a259-6e4cdc67d250@kernel.org>
 <aPwSS9NlfqPFqfn2@kernel.org>
 <aP8qPlA7BEN3nlN8@infradead.org>
 <5a2e4884bb6b31b0443bdac6174c77f7273e92b1.camel@kernel.org>
 <aP-YV2i8Y9jsrPF9@kernel.org>
 <a221755a-0868-477d-b978-d2c045011977@kernel.org>
 <aQA4AkzjlDybKzCR@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQA4AkzjlDybKzCR@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 11:26:58PM -0400, Mike Snitzer wrote:
> But none of that matters if the only safe way to implement mixing
> buffered and direct IO is by waiting for the DIO to succeed and with
> it any associated page cache invalidation (and associated possible
> failure to invalidate the page handled with using buffered IO fallback
> by underlying filesystem).

Why do you think it is the only safe way?  (The above seems to imply
that to, or maybe it is a question?)

> 
> Any buffered or direct IO associated with the misaligned DIO WRITE
> handling, in terms of 3 segments, must use IOCB_DSYNC.

Can you explain why exactly.  If that's is indeed the case, it is a
very important point we clearly need to document.

> But the entire intent behind NFSD's O_DIRECT support is to ensure IO
> is on stable storage when it replies to the client.

Is it?  This is the first time I read that this is the "entire point".
I though the main reason was to stop wasting memory on the server
and reduce memory copies.  If the entire intent is to to commit to
stable storage only, there is no need for all the direct I/O games,
and you can just use RWF_DSYNC only.

> The client isn't
> meant to get involved with driving the correctness of NFSD's O_DIRECT
> support (by requiring the client set NFS_FILE_SYNC for the benefit of
> a feature it doesn't know enabled in the server).

Of course the client should not care about the servers implementation
detail.  But I don't see how this is relevant here at all.

> IOCB_DIRECT without IOCB_DSYNC isn't an option because we must ensure
> the data is ondisk.

Why?

> The only related bake-off would be:
> 1) IOCB_DIRECT | IOCB_DSYNC with UNSTABLE 
>  vs
> 2) IOCB_DIRECT | IOCB_DSYNC | IOCBD_SYNC with NFS_FILE_SYNC
> 
> (but on esoteric enterprise storage: there is no difference)

What are you talking about? With any Linux file system on any storage
it does make a huge difference except for the corner case of pure
overwrites of fully allocated ranges.


