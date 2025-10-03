Return-Path: <linux-nfs+bounces-14963-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B56BB7491
	for <lists+linux-nfs@lfdr.de>; Fri, 03 Oct 2025 17:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC93C1899048
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Oct 2025 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79A219309C;
	Fri,  3 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cV/UeOLR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C379C42A80
	for <linux-nfs@vger.kernel.org>; Fri,  3 Oct 2025 15:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759504011; cv=none; b=pn3LomSmMUR1a6LZgpNEKVOSIcB61miftt0QxVrUAijORjEvTOnnfYXgKMqILBdvZAdOINAqeCpu8KDBuS0U4qKx4FKXiS8Z4FaQoceEuayqJi+Pd3omRU90Gh9eF2j7Q0G3M0omb5wdnmKTNR/8gYVLJIy8woIpk8np+fNlIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759504011; c=relaxed/simple;
	bh=SQ56yhSrAquwUSK9yYZ7oMHQsSi8y5PDM5PjbiqxsJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRQJXd6canEPabwrCh5zdni484czgFfWfcqQeTm2vO2H8AFfbsUJPYM/GUPBSR6LJchBHJcPMGaQEZoPJwRpz2D1Vj1lg0qLxWo0/sPYA0R91sVpalUeiwGZuWa/wfJdRpJMTjoKXU3O5Sk+KURJi0JDNLt6y0ngo0+JNIkjGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cV/UeOLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2035C4CEF5;
	Fri,  3 Oct 2025 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759504011;
	bh=SQ56yhSrAquwUSK9yYZ7oMHQsSi8y5PDM5PjbiqxsJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cV/UeOLREZOmfVeVl/h2yHajk9u0uQYRj1IwYeUtj5D0tQHPK2TuiIC899i2Gxsu7
	 D9ByZSyPNiu5bBX9K1Vj/yUZNNQaWVKQW+ndHfRRVINLgeED+LN7KxyNvZcw4YpdGJ
	 ewwatlOCTw4n2hD041lu/7P8izPvGjuJDt5gDYGNK7RgSU4pCQdWzhGJAWS39Z8//K
	 ZPo9dFKFs1zfhAQwaYQb022WOHRsTeYhmu/GYlrtqCaiSpF/9CrjxIId/oPCRH+jsC
	 EbiHwiM2OA5IVDkViwysa+/PNmhcnKPXSlO1llBcxNXkuYFXRhztlzHH2ERjnRm1ZV
	 3Q7mJSh9UFuAg==
Message-ID: <96f1a103-6b8c-4281-8450-68ab14219518@kernel.org>
Date: Fri, 3 Oct 2025 11:06:49 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
 <20250929155646.4818-5-cel@kernel.org> <aN9451-HZqvPBrlp@infradead.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aN9451-HZqvPBrlp@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/3/25 3:19 AM, Christoph Hellwig wrote:
>> +/*
>> + * The byte range of the client's READ request is expanded on both
>> + * ends until it meets the underlying file system's direct I/O
>> + * alignment requirements. After the internal read is complete, the
>> + * byte range of the NFS READ payload is reduced to the byte range
>> + * that was originally requested.
>> + *
>> + * Note that a direct read can be done only when the xdr_buf
>> + * containing the NFS READ reply does not already have contents in
>> + * its .pages array. This is due to potentially restrictive
>> + * alignment requirements on the read buffer. When .page_len and
>> + * @base are zero, the .pages array is guaranteed to be page-
>> + * aligned.
>> + */
> 
> Any reason you are not using the full 80 characters available for the
> comment?

Yep: I find comment blocks that fill the whole line more difficult
to read because my eyes are gray and bent. :-)


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
> 
> I find this loop style very hard to follow.  Why not do something like:
> 
> Why not something like:
> 
> 	for (v = 0; v < rqstp->rq_maxpages; v++) {
> 		size_t len = min_t(size_t, total, PAGE_SIZE);
> 
> 		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page, len, 0);
> 		rqstp->rq_next_page++;
> 		total -= len;
> 		if (!total)
> 			break;
> 	}
> 
> ?

We copied this loop from nfsd_iter_read(), where we just reworked it
because there are several conditions that need to terminate the loop:

- There are no more bytes to process
- There are no more pages available in rq_pages
- There are no more entries in rq_bvec

Your proposed rewrite drops the array bounds checking that we just
added, IIUC. Neil doesn't like adding termination conditions at the end
of a loop.

I'm open to utilizing for() instead of while() but I didn't find that
writing it as for() improved legibility.

(Yes this is duplicate code, which I'm OK with until we have optimized
direct reads properly and have nailed down exactly when NFSD will employ
them).


>> +	case NFSD_IO_DIRECT:
>> +		/* When dio_read_offset_align is zero, dio is not supported */
>> +		if (nf->nf_dio_read_offset_align &&
>> +		    !rqstp->rq_res.page_len)
> 
> Nit: the entire if clause fits into a single line.
> 

I'll fix that; an additional check was removed during the last
revision, and that shortened the second line.


-- 
Chuck Lever

