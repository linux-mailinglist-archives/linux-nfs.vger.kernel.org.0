Return-Path: <linux-nfs+bounces-12352-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EB7AD6862
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 09:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537693AB9FD
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Jun 2025 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286211E9B1C;
	Thu, 12 Jun 2025 07:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mzlLHLLu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7A1F584C;
	Thu, 12 Jun 2025 07:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749711616; cv=none; b=uvZhc6jsOS5oztJRaIfsrNI6h0/7qmLG/TrNrjpcjAyek7R0HJYPdUw5U8w+nJVWktwvTh9GULt9EpOLTrzlYGTMrVuhpMy/O/uw+grq5voebx7PoNYdelxM/ik7j9ToMMICQpzU9502qUEFXv68boAeWi1otgQNm7H1N6UuVIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749711616; c=relaxed/simple;
	bh=HKy4RhO/f30fuWKplqdgBDzy4f1K2ZRcUZPcWRoHj6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL0dOVCFHBz94/oZhebhiZvZc9J2Akz+YMop2tUSjcragPISRsCmCu4JLAt0ezqZF1Hh+sbF7S14AbO8ybKRD+nF3jGVrfuE0m1PjzDGUF3N3Gx7Rx6pBQr3jus58+983vnkciXuLmaz2snpS8bKc3uNdBTINa9t2zw2yHq9WNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mzlLHLLu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tz9am5faii+nuBWNYAlA+3Nf4ynU5EK4Nwn62GVL+i8=; b=mzlLHLLuiuC/62rADqheNR6Dtj
	XTbzwnl89L6yDXp698likphQbptd7uHHpbVjKQZ1uZDR+yGdnC/xhplXbGr5mZXVnRucJmRYJs+Ks
	yslmI02OdVjyDuPd1czc5ZLI3wAeHYsdAlco7ZEN4yM3duv/8RWFfRoQL+lhYs0AktmfnvCEwOYhT
	QvE4we0CicdAy3Tv1qS3mFlUti/vCz6LJTMIF49g3UTGrfvwaGt8Dwzx9NXBZsy/9cXjFtCwFpJTB
	EK7PCAT7jqBKgzSBTtnPzSiQ/YCn0jHlChghyo3n8ptZ8dG0PihJ2CG+dkvSpHXEM6kl8dN1oSg8x
	h16XbFlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPbuz-0000000CNtv-1S58;
	Thu, 12 Jun 2025 07:00:09 +0000
Date: Thu, 12 Jun 2025 00:00:09 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2] nfsd: Use correct error code when decoding extents
Message-ID: <aEp6-T8Oqe2dI7of@infradead.org>
References: <20250611205504.19276-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611205504.19276-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 11:55:02PM +0300, Sergey Bashirov wrote:
>  	if (nr_iomaps < 0)
> -		return nfserrno(nr_iomaps);
> +		return cpu_to_be32(-nr_iomaps);

This still feels like an odd calling convention.  Maybe we should just
change the calling convention to return the __be32 encoded nfs errno
and have a separate output argument for the number of iomaps?

Chuck, any preference?


