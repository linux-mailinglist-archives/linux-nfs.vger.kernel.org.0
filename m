Return-Path: <linux-nfs+bounces-14947-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7DABB627B
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 09:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 798483A7134
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27C1E9B0D;
	Fri,  3 Oct 2025 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ydHri5Cu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEE2F5B
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 07:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759475947; cv=none; b=EuQLPSo3NzB/ov2TbSXSdQ5YwopbD3enW1xPm2VxhHwWYiNZgi9gQa4mHbScsetSUcNoompLC9eYShMMfd4Xs7+ubw/qC8ELK9ojKR7t2JLoGOxFVEsONPpTznqlpY/Xv5XZY6zLHHC01S6q6GV2Efkv2HlsrCJbula4SZUnx0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759475947; c=relaxed/simple;
	bh=5Jx1zEdGeUwxt8e1Dv6s5Is4mDZUh9QrYQF44as9rnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZORqU/60ywBfbSn3YnwNNfnOuyzfz3s6aDPp/W6IAqB+zTWwqNSkq6MW41Enb9XStjDUBjcPtql8rzIL0JqC6Bz83L3t7mxodQRfRs/UWlFk0+TtBbJWaODUv+lyA/v9omLjjqjxvuzcMSCA84Dss8oOVDb187xLRb7saIv/mL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ydHri5Cu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HIYFayyTBDnwMo5w2xOGNEFSTrSYUaaGoE68CR572V0=; b=ydHri5CuO+16Q1Y8fLcCBFPd3c
	Cod7Ux7H47mH2K8rQqi41KOS4LbuWlzSHMiFscdnCH0QTtNKSVd4fN/XEljXCDEyFnVmMgkv3aEdP
	yCdZ9ihReJpPZSalvXOubNAFG79L15IfxS0HUZ5+lkowuATrJetvErPjDJmG0VQtR0G8zqsWWNE/i
	WBucvjHziF2oNY4WSc2mtebvI857kk80WotFnL65sMCn5di5cRj7kWF9ppc2ddfAeNHSIJ8ZRqqpw
	giX6YLGfNr+lpKLtAs62GUbliFeXlcLOLuOjmxDZllpxMBvRYSp+bjoUX44dysE5U+2lRqKEjncLh
	GGAdyKgg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4a4F-0000000Bnu5-0RoA;
	Fri, 03 Oct 2025 07:19:03 +0000
Date: Fri, 3 Oct 2025 00:19:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v5 4/6] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aN9451-HZqvPBrlp@infradead.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929155646.4818-5-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +/*
> + * The byte range of the client's READ request is expanded on both
> + * ends until it meets the underlying file system's direct I/O
> + * alignment requirements. After the internal read is complete, the
> + * byte range of the NFS READ payload is reduced to the byte range
> + * that was originally requested.
> + *
> + * Note that a direct read can be done only when the xdr_buf
> + * containing the NFS READ reply does not already have contents in
> + * its .pages array. This is due to potentially restrictive
> + * alignment requirements on the read buffer. When .page_len and
> + * @base are zero, the .pages array is guaranteed to be page-
> + * aligned.
> + */

Any reason you are not using the full 80 characters available for the
comment?

> +	v = 0;
> +	total = dio_end - dio_start;
> +	while (total && v < rqstp->rq_maxpages &&
> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
> +		len = min_t(size_t, total, PAGE_SIZE);
> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
> +			      len, 0);
> +
> +		total -= len;
> +		++rqstp->rq_next_page;
> +		++v;

I find this loop style very hard to follow.  Why not do something like:

Why not something like:

	for (v = 0; v < rqstp->rq_maxpages; v++) {
		size_t len = min_t(size_t, total, PAGE_SIZE);

		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page, len, 0);
		rqstp->rq_next_page++;
		total -= len;
		if (!total)
			break;
	}

?

> +	case NFSD_IO_DIRECT:
> +		/* When dio_read_offset_align is zero, dio is not supported */
> +		if (nf->nf_dio_read_offset_align &&
> +		    !rqstp->rq_res.page_len)

Nit: the entire if clause fits into a single line.


