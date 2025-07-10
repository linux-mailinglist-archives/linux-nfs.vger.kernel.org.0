Return-Path: <linux-nfs+bounces-12973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB4AFFB59
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 09:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723DF7BF65A
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Jul 2025 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CDF286D60;
	Thu, 10 Jul 2025 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2hcSlqLx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C42874FB
	for <linux-nfs@vger.kernel.org>; Thu, 10 Jul 2025 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752133907; cv=none; b=GnU+QOqio88EkpYcRrsr+mQ5X4rwQQOJ0JkBN3rmUgAwWYGCrEZgshWwUEwArW1ntd5xZ50LuPBhEgo1nDFyY50pcJqdyevaWlWHMlZm20LztmlrHVtyQ40UHwbGxReLelncFM01R0rAAhPeHFoiHCK4FjQ1dRb48qR+1lKsu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752133907; c=relaxed/simple;
	bh=9yY/WvH7dQGbSI2N/Q5lhlFuFD5ga8JfAb+4B3jKUX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bs55KM1dIwp1cGAY7iGImC3T7sdvjCv9d32dWTPHNqPkHf1BQ80FCALwR4wYcP4TvIisWgCNpOfsVL4wRUPusYNBofxQMMv3YoQJVg/Jg+j9g3YwqBwKYvkaWjuaeHT9aG9vL7ecC3OG0D7W7FE5+wDPLajZjN5k4P+5C1kbpGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2hcSlqLx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nDZPu0ZiFruAreTK2Fx1Etdv0ZbXac8nfj9wZN830O4=; b=2hcSlqLxeGAWo4IyCR5jfJFHND
	+Xim09ub+Q7T3x7B7Ap9fsNF6NVg8Nvbs7V/0gr7/3ngZVrpLXnrMdalEhKYIkBFscgFEXHvESU6M
	jp0/vP8gOdIqLEDJMew8aZ9gfWWIzgyP5hq8JnasGI0PwVGwGFIX62FV4a5pMOfpZSXlpOSWhRekP
	i5jqsmyaScKEttN9/0WeLIbzW2G2Ne643OLBdbbxSt2mIPBF2nvhVx2tGKnR48LCK45AM/7oi+ANw
	7ho1J1Jeziac9JcnWezClL3uo3y2hvScggUVmbt7+JdovmwbgFxI4hUNti7ISeTJdCCCZ38zitQIR
	AdKS5G3w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZm4E-0000000B4jk-3TOc;
	Thu, 10 Jul 2025 07:51:42 +0000
Date: Thu, 10 Jul 2025 00:51:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v2 8/8] NFSD: issue READs using O_DIRECT even if IO
 is misaligned
Message-ID: <aG9xDqnVeRdn_WPJ@infradead.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
 <20250708160619.64800-9-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708160619.64800-9-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 08, 2025 at 12:06:19PM -0400, Mike Snitzer wrote:
> +static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +				  loff_t offset, __u32 len,
> +				  const u32 dio_blocksize,
> +				  loff_t *start, loff_t *end,
> +				  loff_t *start_extra, loff_t *end_extra)

With this amount of arguments, especially out arguments that return
values the better choice is usually to have a struct.

If not using two-tab ndents at least make it a lot more readable..

> +{
> +	ssize_t host_err = bytes_read;
> +	loff_t v;
> +
> +	/* Must remove first start_extra_page from rqstp->rq_bvec */
> +	if (start_extra_page) {
> +		__free_page(start_extra_page);

I can't really follow the logic here.  Why must it be removed (and
freed)?  Can you write a more detailed comment here as the logic
isn't very obvious.

> +		*rq_bvec_numpages -= 1;
> +		v = *rq_bvec_numpages;
> +		for (int i = 0; i < v; i++) {
> +			struct bio_vec *bv = &rqstp->rq_bvec[i+1];
> +			bvec_set_page(&rqstp->rq_bvec[i], bv->bv_page,
> +				      bv->bv_offset, bv->bv_len);
> +		}

This is basically shifting down the bvecs, right?  Why not simply
use memmove?


