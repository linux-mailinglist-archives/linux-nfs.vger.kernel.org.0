Return-Path: <linux-nfs+bounces-12092-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E54ACE0C4
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407463A2473
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jun 2025 14:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CD28F935;
	Wed,  4 Jun 2025 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0S5UW5p4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100AE244676
	for <linux-nfs@vger.kernel.org>; Wed,  4 Jun 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048874; cv=none; b=aJhEJTHCJghpJPEI8xtzDGq8XBmB98pV+w5s9VUmrkTfPAln4LzFEdSHt38vn+SBf7kszRLZYnfLT34XFGfhemeS3Mb+avxhFSOvZ6MJez3hGYTL67J3U3399vsLV5nMJUmzS5UDhul9bT8rgBoY9H9B+TDMCAbdJwZ009LvN1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048874; c=relaxed/simple;
	bh=98dGL3w1ghr8cq0S2008M8idJqDckPvdYvYCGcwZXXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoiUL7GgM1qVy5EJYRjpFbwoQBe7vDyF0RvvG8XOkRaM3RRYgZLUQD8y9KTqYrQcRjJTw4vaeQRrZDPxgjSoL/ZzD0NLr5hWyc5tXnombd/X7Rja+GgPwNIUUeY8T3yLYFg++FMwhp0iYplyH7pwMWe3Jj2IXfql6nlLypb1J9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0S5UW5p4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MHysN7wiyLksp3Ttn/ztmRdlpTFxYwRDOloNEOv436M=; b=0S5UW5p41baSRCY5L2e8HElKHr
	kZcvEubwws7sZAkyF1zR8G4YmfBO96A8sLBD1R6iVbM048XmR6KTpQ2j62dsa9AYbCZFKb734XS/f
	9pu0xRDg8EsO+GNiKjD9ScEnPyYJsRZzLUXcQsQUmtOtF+65s4JP4IEEfs9/qlJ8n2zA6FLeIbPe0
	jM4ADwD2o6U9DdVa7ZZ7UiLdzkBCzksFsMQeXijzVUxrxJcMgfO88tR+5/CNyJw/7jufiVStuHiTZ
	ZdELMWANbbevWLjN5XQBXTleDp0Uy1TNFVxYtt5FTwSMYeOjawew8yTXGV+XKx/RjskyXv5Y3mvLF
	Uc/hQ0Pw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMpVf-0000000DdCP-1lI0;
	Wed, 04 Jun 2025 14:54:31 +0000
Date: Wed, 4 Jun 2025 07:54:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: "J . Bruce Fields" <bfields@fieldses.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH] nfsd: Implement large extent array support in pNFS
Message-ID: <aEBeJ2FoSmLvZlSc@infradead.org>
References: <20250604130809.52931-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604130809.52931-1-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 04, 2025 at 04:07:08PM +0300, Sergey Bashirov wrote:
> When pNFS client in block layout mode sends layoutcommit RPC to MDS,
> a variable length array of modified extents is supplied within request.
> This patch allows NFS server to accept such extent arrays if they do not
> fit within single memory page.

How did you manage to trigger such a workload?

Also you patch doesn't apply to current mainline.

>  	struct iomap *iomaps;
>  	int nr_iomaps;
>  
> -	nr_iomaps = nfsd4_block_decode_layoutupdate(lcp->lc_up_layout,
> -			lcp->lc_up_len, &iomaps, i_blocksize(inode));
> +	nr_iomaps = nfsd4_block_decode_layoutupdate(&lcp->lc_up_layout,
> +						    lcp->lc_up_len,
> +						    &iomaps,
> +						    i_blocksize(inode));

Please drop all the spurious reformatting to a harder to read style.

> +++ b/fs/nfsd/blocklayoutxdr.c
> @@ -103,11 +103,13 @@ nfsd4_block_encode_getdeviceinfo(struct xdr_stream *xdr,
>  }
>  
>  int
> -nfsd4_block_decode_layoutupdate(__be32 *p, u32 len, struct iomap **iomapp,
> -		u32 block_size)
> +nfsd4_block_decode_layoutupdate(struct xdr_buf *buf, u32 len,
> +				struct iomap **iomapp, u32 block_size)
>  {

So if you pass the xdr_buf that already has the length, can't we drop
the len argument?

> +	struct xdr_stream xdr;

Also I'm not the expert on the xdr_stream API, but instead of setting
up a sub-buffer here shouldn't we reuse that from the actual XDR
decoding stage, and if that can't work (Chuck is probably a better
source for know how on that then me), at least initialize it in the
main nfsd layoutcommit handler rather than in the layout drivers.
me we'd probably want that initialized in the core nfsd code and not
the layout driver.

> +		if (xdr_stream_decode_opaque_fixed(&xdr, &bex.vol_id, sizeof(bex.vol_id)) <

Overly long line.

> +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, lcp->lc_up_len))

Same.


