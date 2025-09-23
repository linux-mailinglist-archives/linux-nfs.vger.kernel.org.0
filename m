Return-Path: <linux-nfs+bounces-14634-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BDAB97D33
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Sep 2025 01:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2613AF004
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Sep 2025 23:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA7813B284;
	Tue, 23 Sep 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRvEncs3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248972F5B
	for <linux-nfs@vger.kernel.org>; Tue, 23 Sep 2025 23:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671552; cv=none; b=FFE6HCfNrxbQ0gk2i1cZpaNx1glpDwPuIt/BDxZNb6FJphne8OiM2JhKl6PlWNO/Q8RwOC9KLLHFnrR/ePgvtv/sADBG8olYZ1JjOxE50HGwttGv96p9h4oZ1Mke54XFf7Q933vdzJiLjZuyzVjsGusRRfVNCjGu8YjY2QD48QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671552; c=relaxed/simple;
	bh=fkd9htPypwYm8WAU6FPsEMmdaS3zxtbo6ZHj9fcWGtY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBUR+lAklYJH3qFyflEiXjDy6UwN5wNk2AmmlEELtnaxwMlEUcHV1MFDQkfRxj6qRZ1SxULsDmtXqhnhvRlQyc21ND1v5dHdvKG56m4NSXrLFqi2atof94TKPChsy9vx1K3RkPH8lbo5/6R+FxgbLUjj/TjOSbp34lB82vQhpqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRvEncs3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F8C4CEF5;
	Tue, 23 Sep 2025 23:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758671551;
	bh=fkd9htPypwYm8WAU6FPsEMmdaS3zxtbo6ZHj9fcWGtY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WRvEncs3qWK1LMGjWxNeQbzSIHA9qGpO5ZtuY9Aa2rzoMRhiuQA+FQGFaEimpemol
	 4XUXzgcggQbMKCc1j9a+WnTrUk4X/yrECmct/8h6z31kL5KkWi7TMkuf1AowPTe18v
	 XS5fFlz/ZVoViF9xWDXud2eTpcGBTsw0qI52RPQQJ9CopwRNRc1o+1/6NWmBwLcAao
	 HAz8ZN2HbMlVKU/xpTRcZuLdVrAoMq/98MnCj9SzTYfThgXDYmhCRtkXY0uz/l0QZb
	 zpoWNW3Kp61FDQDYLH+VkIc2tutFD9wsTt8KhhZMEJgoxlPatndGgNPmWD3ZHKiz9I
	 lAQE58O02ZflA==
Message-ID: <60960803-80b3-4ca1-9fd3-16bc1bd1dbd4@kernel.org>
Date: Tue, 23 Sep 2025 19:52:30 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] NFSD: Implement NFSD_IO_DIRECT for NFS READ
To: NeilBrown <neil@brown.name>
Cc: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250922141137.632525-1-cel@kernel.org>
 <20250922141137.632525-4-cel@kernel.org> <aNMei7Ax5CbsR_Qz@kernel.org>
 <19eef754-57d9-4fe4-a6e6-a481dcec470e@kernel.org>
 <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175867132212.1696783.15488731457039328170@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/23/25 4:48 PM, NeilBrown wrote:
> On Wed, 24 Sep 2025, Chuck Lever wrote:
>> On 9/23/25 3:26 PM, Mike Snitzer wrote:
>>> On Mon, Sep 22, 2025 at 10:11:37AM -0400, Chuck Lever wrote:
>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>
>>>> Add an experimental option that forces NFS READ operations to use
>>>> direct I/O instead of reading through the NFS server's page cache.
>>>>
>>>> There are already other layers of caching:
>>>>  - The page cache on NFS clients
>>>>  - The block device underlying the exported file system
>>>>
>>>> The server's page cache, in many cases, is unlikely to provide
>>>> additional benefit. Some benchmarks have demonstrated that the
>>>> server's page cache is actively detrimental for workloads whose
>>>> working set is larger than the server's available physical memory.
>>>>
>>>> For instance, on small NFS servers, cached NFS file content can
>>>> squeeze out local memory consumers. For large sequential workloads,
>>>> an enormous amount of data flows into and out of the page cache
>>>> and is consumed by NFS clients exactly once -- caching that data
>>>> is expensive to do and totally valueless.
>>>>
>>>> For now this is a hidden option that can be enabled on test
>>>> systems for benchmarking. In the longer term, this option might
>>>> be enabled persistently or per-export. When the exported file
>>>> system does not support direct I/O, NFSD falls back to using
>>>> either DONTCACHE or buffered I/O to fulfill NFS READ requests.
>>>>
>>>> Suggested-by: Mike Snitzer <snitzer@kernel.org>
>>>> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
>>>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>> ---
>>>>  fs/nfsd/debugfs.c |  2 ++
>>>>  fs/nfsd/nfsd.h    |  1 +
>>>>  fs/nfsd/trace.h   |  1 +
>>>>  fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
>>>>  4 files changed, 86 insertions(+)
>>>>
>>>> diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
>>>> index ed2b9e066206..00eb1ecef6ac 100644
>>>> --- a/fs/nfsd/debugfs.c
>>>> +++ b/fs/nfsd/debugfs.c
>>>> @@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
>>>>   * Contents:
>>>>   *   %0: NFS READ will use buffered IO
>>>>   *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
>>>> + *   %2: NFS READ will use direct IO
>>>>   *
>>>>   * This setting takes immediate effect for all NFS versions,
>>>>   * all exports, and in all NFSD net namespaces.
>>>> @@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
>>>>  		nfsd_io_cache_read = NFSD_IO_BUFFERED;
>>>>  		break;
>>>>  	case NFSD_IO_DONTCACHE:
>>>> +	case NFSD_IO_DIRECT:
>>>>  		/*
>>>>  		 * Must disable splice_read when enabling
>>>>  		 * NFSD_IO_DONTCACHE.
>>>> diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
>>>> index ea87b42894dd..bdb60ee1f1a4 100644
>>>> --- a/fs/nfsd/nfsd.h
>>>> +++ b/fs/nfsd/nfsd.h
>>>> @@ -157,6 +157,7 @@ enum {
>>>>  	/* Any new NFSD_IO enum value must be added at the end */
>>>>  	NFSD_IO_BUFFERED,
>>>>  	NFSD_IO_DONTCACHE,
>>>> +	NFSD_IO_DIRECT,
>>>>  };
>>>>  
>>>>  extern u64 nfsd_io_cache_read __read_mostly;
>>>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>>>> index 6e2c8e2aab10..bfd41236aff2 100644
>>>> --- a/fs/nfsd/trace.h
>>>> +++ b/fs/nfsd/trace.h
>>>> @@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
>>>>  DEFINE_NFSD_IO_EVENT(read_start);
>>>>  DEFINE_NFSD_IO_EVENT(read_splice);
>>>>  DEFINE_NFSD_IO_EVENT(read_vector);
>>>> +DEFINE_NFSD_IO_EVENT(read_direct);
>>>>  DEFINE_NFSD_IO_EVENT(read_io_done);
>>>>  DEFINE_NFSD_IO_EVENT(read_done);
>>>>  DEFINE_NFSD_IO_EVENT(write_start);
>>>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>>>> index 35880d3f1326..ddcd812f0761 100644
>>>> --- a/fs/nfsd/vfs.c
>>>> +++ b/fs/nfsd/vfs.c
>>>> @@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
>>>>  }
>>>>  
>>>> +/*
>>>> + * The byte range of the client's READ request is expanded on both
>>>> + * ends until it meets the underlying file system's direct I/O
>>>> + * alignment requirements. After the internal read is complete, the
>>>> + * byte range of the NFS READ payload is reduced to the byte range
>>>> + * that was originally requested.
>>>> + *
>>>> + * Note that a direct read can be done only when the xdr_buf
>>>> + * containing the NFS READ reply does not already have contents in
>>>> + * its .pages array. This is due to potentially restrictive
>>>> + * alignment requirements on the read buffer. When .page_len and
>>>> + * @base are zero, the .pages array is guaranteed to be page-
>>>> + * aligned.
>>>> + */
>>>
>>> So this ^ comment (and the related conversation with Neil in a
>>> different thread) says page_len should be 0 on entry to
>>> nfsd_direct_read.
>>>
>>>> @@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>>>  	switch (nfsd_io_cache_read) {
>>>>  	case NFSD_IO_BUFFERED:
>>>>  		break;
>>>> +	case NFSD_IO_DIRECT:
>>>> +		if (nf->nf_dio_read_offset_align &&
>>>> +		    rqstp->rq_res.page_len && !base)
>>>> +			return nfsd_direct_read(rqstp, fhp, nf, offset,
>>>> +						count, eof);
>>>> +		fallthrough;
>>>
>>> Yet the nfsd_iter_read is only calling nfsd_direct_read() if
>>> rqstp->rq_res.page_len is not zero, shouldn't it be
>>> !rqstp->rq_res.page_len ?
>>
>> Oops, yes. I did this work last week, while out of range of my lab.
>>
>>
>>> (testing confirms it should be !rqstp->rq_res.page_len)
>>>
>>> Hopefully with this fix you can have more confidence in staging this
>>> in your nfsd-testing?
>> I'm waiting only for Neil to send an R-b.
> 
> After noticing, like Mike, that the page_len test was inverted I went
> looking to see where page_len was updated, to be sure that a second READ
> request would not try to use DIRECT IO.
> I can see that nfsd_splice_actor() updates page_len, but I cannot see
> where it is updated when nfsd_iter_read() is used.
> 
> What am I missing?

It might be updated while the NFSv4 reply encoder is encoding a
COMPOUND. If the size of the RPC reply so far is larger than the
xdr_buf's .head, the xdr_stream will be positioned somewhere in the
xdr_buf's .pages array.

This is precisely why splice READ can be used only for the first
NFSv4 READ operation in a COMPOUND. Subsequent READ operations
must use nfsd_iter_read().


-- 
Chuck Lever

