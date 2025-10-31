Return-Path: <linux-nfs+bounces-15842-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE59CC25378
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 14:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659C7188837F
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Oct 2025 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F561B78F3;
	Fri, 31 Oct 2025 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zDF/a/VV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D678A19A288
	for <linux-nfs@vger.kernel.org>; Fri, 31 Oct 2025 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761916592; cv=none; b=OvJQpPf9ATMzxjSy/CwFD5P6tBnIG9W1Gx7Lo9XnR47/WRzAaRIdPJbyryazs78xCoWWyuDZaYFDEKqVK86UzTyq0R5ssN2LCprPe81Pwdx4JsbFYobOBB1+Me+hMH+XBgmmHy1FXE99o2bzxmqPteQKGNaPdRM/9VtHeegXhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761916592; c=relaxed/simple;
	bh=v0WcN2Pw0mT5HJ8u8agLEk1eK8nwU4MEnGxP8iB739A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VppC2RrVK4mp/ePgEX62Gt00kbueM/jwbcMP9WroiaU+PHWKgY7RtzfxM9GF9xjtnZBeCDx+IywbmUKNgJKU0SKlfCVIUYL8urBwbU73UMwc4MEiH1qFC8gGAdHtmpOqfgx+jgv/LnMedvqiaaDfRgTos6v13G/M00KqJjNFDBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zDF/a/VV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uP1j0lOFL5ryRBHhO5yPNa62wU0lkNXpGXrz/qFHn10=; b=zDF/a/VVADEV7xTzj7SLJASlMy
	BBnVh7tsH+himj20L4QPbCFXn2uNlTjfrZygDP6rEVrxxgOfbAPvsRdaBWz+1lo2mRCVO6PhtcfIe
	p6lLed/Ff5uMA4TBlfsjd3UTtZvj1C2Pc+g44jxkr8FDGTfLkV9MwAvGt2KTjm0O2omQ+C7AaZEOv
	DpFLfGSV0VC19nmapgambp7+pv01X57Obwh4h7Hp0e5LAKJ5AEf3vjn9JZL7rZhLvr7Cwm8uNCNnl
	Ovp5pYLpbRafAfASYBW8cenlzfTZ7WNsSAGynsEUhOsJmBx2OOwp5stWb5wRsqKyuo8YL6h4PDyTY
	JSCai/Iw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEozU-000000069V5-0uxO;
	Fri, 31 Oct 2025 13:16:28 +0000
Date: Fri, 31 Oct 2025 06:16:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v8 08/12] NFSD: Simplify nfsd_iov_iter_aligned_bvec()
Message-ID: <aQS2rLPSik2mlDg8@infradead.org>
References: <20251027154630.1774-1-cel@kernel.org>
 <20251027154630.1774-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027154630.1774-9-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 27, 2025 at 11:46:26AM -0400, Chuck Lever wrote:
> +/*
> + * Check if the bvec iterator is aligned for direct I/O.
> + *
> + * bvecs generated from RPC receive buffers are contiguous: After the first
> + * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
> + * Therefore, only the first bvec is checked.
> + */
>  static bool
>  nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
>
>
>
>  {
>  	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
>  	const struct bio_vec *bvec = i->bvec;
>  
> +	return !((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask);

Nice simplification!

But this entirely helper feels a bit pointless now vs just open coding
two lines in the caller.


