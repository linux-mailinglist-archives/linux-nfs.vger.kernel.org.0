Return-Path: <linux-nfs+bounces-16192-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E65C40A26
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1805A34B25F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5861B2D373F;
	Fri,  7 Nov 2025 15:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TfOsekXH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1277B1E0DD9
	for <linux-nfs@vger.kernel.org>; Fri,  7 Nov 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530013; cv=none; b=WTVp6ObIo9yq/VizLgfI9Go98PjFs2oxMkJArXzc/HE8okeT+ag17VLqeOSPQUTn2BGBCaqJ57z/u7D8aldfeZVp4h9lqPmOgfeAkjMzgvWxFMT7Oux8GOZu3TenVOjpV/rXJAeb1Vqoty15BTD3K+wypi9n/bTdP9r5kkdiWVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530013; c=relaxed/simple;
	bh=J6u1rzw6Q+m9vVsWYik2lrZD6Q8raYqrGFLtgeps3EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kld8CNVRVDwSxhaD3tEIaoeBw2A+KIhZDCE5gElMdExM8KXJ2DYVkDfeDPXFTh7EB/VNMMBYxVVG5OAiB1UacKxmWw7itEkxtAEHRQzs9VbTy09fQ8fDgRSDWzjoGo/vS5ppUFsAQwaIAhIWK305aYfN+h56m9n6Ajz8rggiF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TfOsekXH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0IkrYGTxpC+vmQ3LYlIz56Ri3Z/xo4gfZagZY/7BA2A=; b=TfOsekXHSw4Vh4ns0gFXe+6rTm
	3Ulr+xqi5NOzkywmuxg1qKMrtSwG170dyXAq+GUwLSbpi7krBSdARM/onS6Ttz7Yg2qJaHJBcz72m
	p724c1DxB7nJcHyN2PK72kxKsTq92Uh8EkwAdgwq2Dw6fu9JwZvkkJ5TL8WY2ZYIo9MAPS0c1gZjz
	/9ay0ylUt8KgDflIlTYWoSxN2U58P+12qUegyo4Ur+Q4R9PrV3Tc1R70TrOPMzKyBrTypnVn3rO8o
	SC0bhTF2+kgg7x0T06CUUxoLWQZu9kOVQongELieKK2WhSCwqdu4YKDJl3VwyzdKpt6MI3K/tE1Iz
	yaqvpYIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHOZP-0000000HayF-1suB;
	Fri, 07 Nov 2025 15:40:11 +0000
Date: Fri, 7 Nov 2025 07:40:11 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v4 2/3] NFSD: add new NFSD_IO_DIRECT variants that may
 override stable_how
Message-ID: <aQ4S2z0wSfeqq1pQ@infradead.org>
References: <20251105174210.54023-1-snitzer@kernel.org>
 <20251105174210.54023-3-snitzer@kernel.org>
 <c1f4d144-826e-4c27-821c-47652a7b67d2@oracle.com>
 <aQ0CUPcYYg6-5IJ1@kernel.org>
 <7d9bcc0c-d997-4fb9-aa0c-831b8f08a9b0@oracle.com>
 <aQ0noN473a-QFqpz@kernel.org>
 <aQ4RftwuYIxwvLgb@infradead.org>
 <543c9183-40eb-459b-81bd-078e6ecb7687@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <543c9183-40eb-459b-81bd-078e6ecb7687@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Nov 07, 2025 at 10:35:52AM -0500, Chuck Lever wrote:
> > Yes, BDI congestion is gone, mostly because it didn't really work.
> > I'm also not sure how it could have solved deadlocks.
> > 
> > I feel a little out of the loops, though - what are the NFS-level
> > write throttling needs to start with?
> > 
> 
> Let's not go down this path right now. I'd like to stay focused on
> getting the direct WRITE work merged.

I'm just curious what the discussion is about at all.


