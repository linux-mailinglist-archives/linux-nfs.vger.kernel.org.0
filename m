Return-Path: <linux-nfs+bounces-12627-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F5AE3726
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F4D171AD4
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Jun 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C35C1F4295;
	Mon, 23 Jun 2025 07:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdhjn/09"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA411B4240;
	Mon, 23 Jun 2025 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664483; cv=none; b=O+MWK8SJVlKSDhacgtttAxW+q8enJCnk2e1p56Ea2v6/gz9nvEpZIT1d9fWG5oumm4YSSSSDocK7Wr9lOTQs5YmCFVS4qUDcGmxuWEXPVoKX2sr9VaKoEhYRMzcnfHn92vYy04SRaWbwpB7FzEHWqnOKmZTtTP2MW/fVuT7YPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664483; c=relaxed/simple;
	bh=Z/9MS7w56R/vMiyAdvEkwSACvQ3TSY0kpstCQ1Io7ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cl0bmuQ/8ArrJuS+z2mToSOe2P6IASGxZ1Xy0xgijZbw4f0AK6ECUqQ4dq0vjNfMR9o3KCqA211pQKmDNPyEKnwv/9R0l6+Q/Jycgaj8pA52EokB6m5+LrzABX3JRPQcT4qM+L2g5zHW2jMitA0jqmydogzfyty4iV1aaPlQty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gdhjn/09; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q0HgspxTgbKyz77WzB7ZF6p0q1JG7y89FrtAuemlXw0=; b=gdhjn/09sOgZqf9UzjnU6PtgKX
	kVbD4oLhuYv04JDEY1xrjaGF2Y1eI1lwo7Wkq8G0zXwPwi1gJVioWJoiZ3tn6iYCURTP63YoD2eTP
	TdvrCaIDxcSRwFHDUAn2rLSiErtr23h2zVu3rANgsqbDq2DpeBkivZwRqZ+sV92JpOpDAhLWa7p17
	q4QE5UhHdweYdGpzQTl78G/16X6EDuIKl+qZ+9+uzKAlK/cTZuPrgF5T3OjUj3chVEf5f09XU/Y07
	YMLOC2eYjz26h7XV8bF1vAYbvMpNnLA68iLX1W1PtKvRnLV0Ta//zj84x1cbctcx0TQMYZECuUv5a
	CGiY5fdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTbnr-00000001te5-2bMT;
	Mon, 23 Jun 2025 07:41:19 +0000
Date: Mon, 23 Jun 2025 00:41:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v4 2/2] nfsd: Implement large extent array support in pNFS
Message-ID: <aFkFHw0BcRO1i2bG@infradead.org>
References: <20250621165409.147744-1-sergeybashirov@gmail.com>
 <20250621165409.147744-3-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621165409.147744-3-sergeybashirov@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Jun 21, 2025 at 07:52:45PM +0300, Sergey Bashirov wrote:
> +	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));

Nit: using a struct assignment like:

	rqstp->rq_arg = lcp->lc_up_layout;

might be a tad bettet due to type safety here.

> +	memcpy(&rqstp->rq_arg, &lcp->lc_up_layout, sizeof(struct xdr_buf));

Same here.

Otherwise this looks good to me (but I'm not the best reviwer for XDR
code :)):

Reviewed-by: Christoph Hellwig <hch@lst.de>

