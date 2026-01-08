Return-Path: <linux-nfs+bounces-17598-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC79D03FEB
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 16:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F4330239C7
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 15:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F23ED124;
	Thu,  8 Jan 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mAQP0quk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354F389E1E
	for <linux-nfs@vger.kernel.org>; Thu,  8 Jan 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864401; cv=none; b=XVV811GeSle82ubKEbwRLHWhB25K8DKFd9vcy6mhUn5A/slCsaW/BgaU2FVKF7z07iVxPK6Ri3OeHWlkkqzY4mo2FIOCeYWpiBCOBCAZz+von9LlJBFWrmttNbcRYtqJlr00TAN2kCCr+ZGqH9trvBBcVEhiBkQ2rrfuxrEdYFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864401; c=relaxed/simple;
	bh=3ENjzjjPPd94IkahyeP0CH1b3olon0SOAtCdPGjP63k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I04mM0/SXcwxx6tBfBZuDb6KnzlK9cEtwlVbvOjyjdfJ5VDK5tuXlP6efEqz9EL2bPjX+R6dqT275nWQnR0ZgTP+aoRukBmw1YKtwAe9euaViCVAGRdE+n5G557LmKnNTJARBAt9HhcmGykRy1JNprne+1l+nQBUwDlfKP64T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mAQP0quk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4RLXqXBKFRlBzUZ5Cyif1n5sbWegRhfwmjKUo2zL7Ag=; b=mAQP0qukxunv17b8O4Ty00zeqd
	TVLc4moedheBFNA21bEGjNoxiNHPHexglr6PsHs4aWjtINejSi90TdXAkDS8l07UC6Nac4m5w7MS3
	uG6fHDt9gR4fnQ5b4J9Z0I9VmAJOnDiQpbC3VH7gav5g/k9FMX4dB7Q0+he58zuzn+GRjgX1lAeAk
	c47sqK3xRBUC9pempb2RwAn18MT55KiNEcrTeJGRbLvTd61O7RnLbCg5/A22laXJE7xhWShb7XCIC
	wFblOxMPqiODtn+QPs5HEW0QNgCGthu3BSBw89dZ4wWX3wiWDleCRx2+1oBJFuiO/A82kOPfQRW/m
	+mIqB3iQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdmHl-0000000GSK2-22Mh;
	Thu, 08 Jan 2026 09:26:29 +0000
Date: Thu, 8 Jan 2026 01:26:29 -0800
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neil@brown.name>
Cc: Chuck Lever <cel@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [PATCH v5] NFSD: Track SCSI Persistent Registration Fencing per
 Client with xarray
Message-ID: <aV94RS0QkITrBdIC@infradead.org>
References: <20251227042437.671409-1-cel@kernel.org>
 <aV6HHwrkoR4OE5qc@infradead.org>
 <9e127bfa-e4c9-4e06-b5ad-bb375e7d8e2b@app.fastmail.com>
 <176783380243.16766.17752014824707434037@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176783380243.16766.17752014824707434037@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 08, 2026 at 11:56:42AM +1100, NeilBrown wrote:
> > > Only in the most abstract way, xa_store actually stores the new
> > > entry/value and returns the old one.  In other words, this does
> > > quite a bit of work for the non-initial GETDEVICEINFO.
> > 
> > The comment is misleading then, and should be clarified.
> > 
> > But should the code use xa_insert instead of xa_store ?
> 
> or xa_cmpxchg() to replace NULL with a value??

xa_insert seems like a lot less heavy handed.

