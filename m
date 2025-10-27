Return-Path: <linux-nfs+bounces-15672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EBDC0E0B6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 14:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C758918956E6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 13:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079F81EA7CF;
	Mon, 27 Oct 2025 13:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SwZALdpX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8931E32B7
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571815; cv=none; b=RSH3ulLgDXfBwmTziYuA3tO1vkm436a7fJG9B2NkdKI93NmLH/OWymL6JJF8IdeKGSPVn5Mnw6p+Q7CbEnMUahUvqTAywWvNlpU1Yr4XxtG7U28aQXhC6KdGn/DRyeyXlD9V/+MHOV+B4Pk32p8sV7NPU44pnXQ7cIk846qLpXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571815; c=relaxed/simple;
	bh=FINzWhMVEI2ULtnPDn9QWHTXvDKrH9rEkWp9E4VGa+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/GbubnkLH6pIn4MfRJ5xqnXs988VZiNC834ixcJnbt/MA2mZYDwYTfJxk9qe4QErC9rgiCwuFevVeEdEHP4TqNfbb0EhwEYicb1twwf0jwpFPkomPna7YOg9TJaHogKtJCbi+GnkHUpbLTgiqVhruF7Leq4TY/9Jeiy1XKRxyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SwZALdpX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xUUsqlXWWT1oseLGH6PDUso4rZkFY8DUgeO73dpRo4g=; b=SwZALdpX0NdSL5Fj5NrHUWVSRi
	1gijeIGvry9L2q8EbZQCO6tblsZnsqgQ6at+KZ2HxwZN3g2uUrJ2eg48EGnV/MF2ZAHqut2wbJVJ5
	mKVEI6E2hoxzG07SEz/UWE7UaG2l6Kt8hcUAoHXj6dFiu8hQoaTMRRJ8BIjXAZhT9jv4CnMgAXRIQ
	U+vrAwta4yMK9nhdWWZD1B2902P52ICNSBKASzWNsoAN1zl+AHI/PTZakYFNo/QUB/KYjU7XdBBSB
	9KBL3Qn4CN2l5YvSBxSfsm/ohyukryI/lzps/68FGH5Ndl5yh0htKBWLCkg90bwwhcnTN4hxWgvNq
	H7hW2b2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDNIa-0000000E1t0-1eHH;
	Mon, 27 Oct 2025 13:30:12 +0000
Date: Mon, 27 Oct 2025 06:30:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 08/14] NFSD: Remove alignment size checking
Message-ID: <aP9z5GmW24WNAFUb@infradead.org>
References: <20251024144306.35652-1-cel@kernel.org>
 <20251024144306.35652-9-cel@kernel.org>
 <aP8otlrPH3DerSR-@infradead.org>
 <8aab9213-b334-4c87-8fa4-efabb5daeeb3@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aab9213-b334-4c87-8fa4-efabb5daeeb3@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 09:25:49AM -0400, Chuck Lever wrote:
> > XFS does, although your won't find production hardware with > 4k
> > blocks as far as I can tell.  The reason to drop this check was
> > to not arbitrarily exclude them for no reason.
> 
> IIRC there is a reason: NFSD_IO_DIRECT writes won't be able to align
> on larger than a page (for the memory buffers).

That could be fixed with > 0 order folio allocations, but..

> But perhaps the
> alignment constraint that was removed applied only to the file
> offset.

I think and I need to double check.  If not we can add the check
back, but then please document exactly why it is there.


