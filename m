Return-Path: <linux-nfs+bounces-14763-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 613DCBA9445
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29C67A827A
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78AD304BB2;
	Mon, 29 Sep 2025 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a71x3X3/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33D0302CD6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759150997; cv=none; b=sPrvqQN+1caVNVOLVcvKzqSrrCgw5wGQtf4QYN9omPDZNzbgneDI+tdDRwxeS49bS/pjlDmGBbuJ69IRxeBuS+YFmFkHjizB1ITQFqT4btdLOQH0+fGW1PeO95iWNcsS6T/+1v03Lb9OT0OGFKP3V9DpeVe+F/AcPoOERaTXlIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759150997; c=relaxed/simple;
	bh=wr/Sx63fwKr4MQou5bF+2j1qOTm0FFAlefFqlUDi0gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTfMURI4WaI0KyKEmI+RuvBiNPHiql+Ha1UNzyYUBF7Va1LT4P1kP3iAkTloxf8AXYhhEptGINo8kBZ47KVAtzo4ZoAxDNa6Olc+wO8swUzCfCKq4lc5+AXO7hStUzTj1jcVO+XMjbNTzQ9CC2F3cpx2gUnwyFOKPK/eWAAdNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a71x3X3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80CF8C4CEF4;
	Mon, 29 Sep 2025 13:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759150994;
	bh=wr/Sx63fwKr4MQou5bF+2j1qOTm0FFAlefFqlUDi0gk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a71x3X3/sWSJ7iEGQPRB4BnxRyTL+RJ5/TSib0dyFbP+m6KHf4mbWgFCNDQ6maMF1
	 291n8WM0QRa1A7bb/phExkYthVF0CJnteYSBtOmYmqnz9BcVPNts1zJAp4k6bZcKFc
	 f/iFA7AVRrdZgHOnAUA1hQYRCzM/ApXEEVRguPi8WbqV2ihRB/A2p7Z6fjL1Axrd5x
	 01F1i7E/erW4cDhq5TixjawtG+QrS70Bwq7qJwp38uxX7BCylOZedagDqBRICY29JZ
	 5WGf2e5Mi+7+UY5XpWiNqTrGlwho81p1R5KPzdnqXVZUTN7rDX8hSYXMVnTVz9FLYD
	 5Y60gNtcOooyA==
Message-ID: <cf8976b6-6a81-44d1-8966-727edf9e1f54@kernel.org>
Date: Mon, 29 Sep 2025 09:03:12 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>
 <20250926145151.59941-5-cel@kernel.org> <aNo1PdbeHsd_rpgl@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aNo1PdbeHsd_rpgl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/25 12:29 AM, Christoph Hellwig wrote:
> On Fri, Sep 26, 2025 at 10:51:51AM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> Add an experimental option that forces NFS READ operations to use
>> direct I/O instead of reading through the NFS server's page cache.
>>
>> There are already other layers of caching:
>>  - The page cache on NFS clients
>>  - The block device underlying the exported file system
> 
> What layer of caching is in the "block device" ?

I wrote this before Damien explained to me that the block devices
generally don't have a very significant cache at all.


>> +nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>> +		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
>> +		 u32 *eof)
>> +{
>> +	loff_t dio_start, dio_end;
>> +	unsigned long v, total;
>> +	struct iov_iter iter;
>> +	struct kiocb kiocb;
>> +	ssize_t host_err;
>> +	size_t len;
>> +
>> +	init_sync_kiocb(&kiocb, nf->nf_file);
>> +	kiocb.ki_flags |= IOCB_DIRECT;
>> +
>> +	/* Read a properly-aligned region of bytes into rq_bvec */
>> +	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
>> +	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
>> +
>> +	kiocb.ki_pos = dio_start;
>> +
>> +	v = 0;
>> +	total = dio_end - dio_start;
>> +	while (total && v < rqstp->rq_maxpages &&
>> +	       rqstp->rq_next_page < rqstp->rq_page_end) {
>> +		len = min_t(size_t, total, PAGE_SIZE);
>> +		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
>> +			      len, 0);
>> +
>> +		total -= len;
>> +		++rqstp->rq_next_page;
>> +		++v;
>> +	}
>> +
>> +	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
>> +	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v,
>> +		      dio_end - dio_start - total);
>> +
>> +	host_err = vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
>> +	if (host_err >= 0) {
>> +		unsigned int pad = offset - dio_start;
>> +
>> +		/* The returned payload starts after the pad */
>> +		rqstp->rq_res.page_base = pad;
>> +
>> +		/* Compute the count of bytes to be returned */
>> +		if (host_err > pad + *count) {
>> +			host_err = *count;
>> +		} else if (host_err > pad) {
>> +			host_err -= pad;
>> +		} else {
>> +			host_err = 0;
>> +		}
> 
> No need for the braces here.
> 
>> +	} else if (unlikely(host_err == -EINVAL)) {
>> +		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n");
>> +		host_err = -ESERVERFAULT;
>> +	}
> 
> You'll probably want to print s_id to identify the file syste for which
> this happened.  What is -ESERVERFAULT supposed to mean, btw?

Note, this is a "should never happen" condition -- so, exceedingly rare.

Clients typically turns NFSERR_SERVERFAULT into -EREMOTEIO.


>> +	case NFSD_IO_DIRECT:
>> +		if (nf->nf_dio_read_offset_align &&
> 
> I guess this is the "is direct I/O actually supported" check?  I guess
> it'll work, but will underreport as very few file system actually
> report the requirement at the moment.  Can you add a comment explaining
> the check?
Well, it's to ensure that the vfs_getattr we did at open time actually
got a valid value. But effectively, yes, it means "is direct I/O
available for this file?"


-- 
Chuck Lever

