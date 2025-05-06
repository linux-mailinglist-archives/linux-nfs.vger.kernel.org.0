Return-Path: <linux-nfs+bounces-11493-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799CCAAC6A0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 15:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EDA3A56D0
	for <lists+linux-nfs@lfdr.de>; Tue,  6 May 2025 13:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3827FB25;
	Tue,  6 May 2025 13:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TC70gPVX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4640227AC41;
	Tue,  6 May 2025 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746538828; cv=none; b=fhjSDrJwnnDWOp12BwoVKp7wgT8aOI7VcrKqi3X0xEShrdW4BY9PAJIQbPbbPOd0F28meXW+iOldVQipVmoWROD+zqFzQciU/VBURLTshy9jcRy6tA+ALHUu/kIecg5r/ybwH8N87xzyZ88OFeNwQY8an/lu81fLM9Kxt5povuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746538828; c=relaxed/simple;
	bh=1zjTLK63V2Ly7bx3Q/E7Vzg7xAAvcPokC8T4CDUcy3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1QwN1z+S4MZNxoAgvR6NoODBtJgrytFfCZsY+R9yGllSdZoEWlFfTLUWAF18D7CNrf7EkV/31/RtMjVGtfI2IKPz5cIZHwZQVUcefsA7+Tb7nvEUZFR99xy0eKRDs9TUp6WIxFEqP/qmew8hmvJhZbyV4IDN3XK2s2XDJnvONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TC70gPVX; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c2SOTMJ0TvnsU5H5ZpqvHpJ8VE0VKBYcdS/tN9TcOUQ=; b=TC70gPVXgn+Ul/EcL4xSAJeBGn
	+IA6b0BznH+JCuxyKTn90aWRjx+Y2guQ9QdkRXtXp+RrqRK4EWfRrCcH7BQ/FPpnuihnkIZiRHfaT
	28r0a1CuLBSqmR6QFKN6jSlaoOwXe1IGN/ctJIx2N8aAPP0udUAk5gn6hcyJ3uRS+BMool7v3RJi/
	rAgJJknWkQOA0bNJNBhhBkkOYl1cW5IG+LuUrYw+T97BRH6OuiGVg6ewGwHNYYIAuvJKxiCWj038e
	cYznJ6q/rePHATshXOT+CGE0C2ce44ExauC+MQusq05IWpB+wtmu9YpyNC12AGJH9dp2B5wo8hbYx
	/9vJdepw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCIX3-0000000CAWG-0IZI;
	Tue, 06 May 2025 13:40:25 +0000
Date: Tue, 6 May 2025 06:40:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@infradead.org>, cel@kernel.org,
	NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-rdma@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v4 01/14] svcrdma: Reduce the number of rdma_rw contexts
 per-QP
Message-ID: <aBoRSeERzax5lTvH@infradead.org>
References: <20250428193702.5186-1-cel@kernel.org>
 <20250428193702.5186-2-cel@kernel.org>
 <aBoJ64qDSp7U3twh@infradead.org>
 <20250506131722.GG2260621@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506131722.GG2260621@ziepe.ca>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 06, 2025 at 10:17:22AM -0300, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 06:08:59AM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 28, 2025 at 03:36:49PM -0400, cel@kernel.org wrote:
> > > qp_attr.cap.max_rdma_ctxs. The QP's actual Send Queue length is on
> > > the order of the sum of qp_attr.cap.max_send_wr and a factor times
> > > qp_attr.cap.max_rdma_ctxs. The factor can be up to three, depending
> > > on whether MR operations are required before RDMA Reads.
> > > 
> > > This limit is not visible to RDMA consumers via dev->attrs. When the
> > > limit is surpassed, QP creation fails with -ENOMEM. For example:
> > 
> > Can we find a way to expose this limit from the HCA drivers and the
> > RDMA core?
> 
> Shouldn't it be max_qp_wr?

Does that allow for arbitrary combination of different WRs?  If so
we'd just need a RW API helper to calculate how many WRs it needs
for each operation for the given device and flags and compare to that,
yes.

(unless my memory is rusty, it's been a while since I touched RDMA code)

