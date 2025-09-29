Return-Path: <linux-nfs+bounces-14760-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DDBA83ED
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24D86189ACD7
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 07:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CC22BF017;
	Mon, 29 Sep 2025 07:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="z02L8yR9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954272BEC3A
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 07:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759130945; cv=none; b=HddqAwv9BxBygHxXr15sB+3/6A6v3Dlrcx5pX7rseHotkVJoeDS54iXArfXHIks0JjdkOV5Q6OFG/z1cVNptawgr/PlSH24GKB6lcy/2wxLaA7DA4d+z9yFAsSwiIrH1fAhp6YpzhMJTZS1QZRCNq10kA+eqCFrtm+Ju9SEAn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759130945; c=relaxed/simple;
	bh=7wFPbaIiEehcXp/k52LzpzjdNpYFR36FQpJBetwS98U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb1lG561p4dlnWfGAj9Y9ewX+/9sKZzTkbOYEuEl0drKFAFF/czU25TZHX2tbY4dVEMP8ShRLMxtWXwN6yDIl7mDzBB6JTzVwCbqyFcTsi5tFLNuDKAeJGi4ypDqCKrrm9e+p3ajJ7Hd7/uEYnLmv9LYbOqypYOjaWUH/XIN7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=z02L8yR9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UY+vi8r8SZ+aRqopPJzJbEqimdol6GXTSPUvGnBxMQs=; b=z02L8yR9s0B1MPBsaATXDy59lf
	goLA7k7awH6UwVYv2ONaj4ueyVZl9xEyUOp1lMPKtbod69xEFNIhqehrfKUq9rF/wzxWiXeuvZDOr
	ys1A5ehYJ5b0jn9VZsr3F1xEJQQ3YR9Ge+csg0v93OFMIrOJBZnB6X4B1cNot0ueqsWLMuHWgOjAg
	SZQaGcQhYKmHNF4I0TSYOYtfDyb+ai1mX7JWk/wWLifZFVRutE8tb7lWpFfUklijv709xoFBnaCgG
	/+KY0O0wSCuHImDBBAnq3c/13vmXnKvk76UH+QqUI2FQtLsh/sYrq6ybJGrnV1A53VNgMZQTGknL4
	jNBM+2Zg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v38Jh-00000001c1v-0ScL;
	Mon, 29 Sep 2025 07:29:01 +0000
Date: Mon, 29 Sep 2025 00:29:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <cel@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Message-ID: <aNo1PdbeHsd_rpgl@infradead.org>
References: <20250926145151.59941-1-cel@kernel.org>
 <20250926145151.59941-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926145151.59941-5-cel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 26, 2025 at 10:51:51AM -0400, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Add an experimental option that forces NFS READ operations to use
> direct I/O instead of reading through the NFS server's page cache.
> 
> There are already other layers of caching:
>  - The page cache on NFS clients
>  - The block device underlying the exported file system

What layer of caching is in the "block device" ?

> +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
> +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
> +		 u32 *eof)
> +{
> +	loff_t dio_start, dio_end;
> +	unsigned long v, total;
> +	struct iov_iter iter;
> +	struct kiocb kiocb;
> +	ssize_t host_err;
> +	size_t len;
> +
> +	init_sync_kiocb(&kiocb, nf->nf_file);
> +	kiocb.ki_flags |= IOCB_DIRECT;
> +
> +	/* Read a properly-aligned region of bytes into rq_bvec */
> +	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
> +	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
> +
> +	kiocb.ki_pos = dio_start;
> +
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
> +	}
> +
> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v,
> +		      dio_end - dio_start - total);
> +
> +	host_err = vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
> +	if (host_err >= 0) {
> +		unsigned int pad = offset - dio_start;
> +
> +		/* The returned payload starts after the pad */
> +		rqstp->rq_res.page_base = pad;
> +
> +		/* Compute the count of bytes to be returned */
> +		if (host_err > pad + *count) {
> +			host_err = *count;
> +		} else if (host_err > pad) {
> +			host_err -= pad;
> +		} else {
> +			host_err = 0;
> +		}

No need for the braces here.

> +	} else if (unlikely(host_err == -EINVAL)) {
> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n");
> +		host_err = -ESERVERFAULT;
> +	}

You'll probably want to print s_id to identify the file syste for which
this happened.  What is -ESERVERFAULT supposed to mean, btw?

> +	case NFSD_IO_DIRECT:
> +		if (nf->nf_dio_read_offset_align &&

I guess this is the "is direct I/O actually supported" check?  I guess
it'll work, but will underreport as very few file system actually
report the requirement at the moment.  Can you add a comment explaining
the check?


