Return-Path: <linux-nfs+bounces-11207-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F470A95347
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 17:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFC3ADED9
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0434A78F4A;
	Mon, 21 Apr 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gat0yL7i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5F33086
	for <linux-nfs@vger.kernel.org>; Mon, 21 Apr 2025 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247908; cv=none; b=AvN27WYi3/KPlIWWpBjTsv1KKh1xSx3yBghwSE+iUIB8+Wy/ISTuMa1LoD4FiS5YhddGScK7b9zJgr3agLzK+2j6DYhJr+gRLLDAaYmLE8avj5Cggs+/225yyv4WCHijsDMcrcu5xpEL1zJrY6EkFkfkUno2R8qfiU6la7ccIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247908; c=relaxed/simple;
	bh=OBE/OdWdHtz1EXfR06sXrZqwHUNrtsx2D6S2v62QX48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GidisPY5MbyBJXvBUhxdqJ5vnGZN3hQgSzfBsonnvwN0MI/ajDzhxXhvqOJFax2o0Nx/1wJQQBPXDup4dfoTBRa5aQiWzc+QFaaFBOXN6l8vmsw2cm1r5wgcxFwjUSgE/Fw5uO+XMxL+i+wSsktqaACR4BUFoj4TC0mLdbt3w/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gat0yL7i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA40C4CEE4;
	Mon, 21 Apr 2025 15:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247908;
	bh=OBE/OdWdHtz1EXfR06sXrZqwHUNrtsx2D6S2v62QX48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gat0yL7i9O2Us3eAOYyTiI6/dEKeHmwGbPlirXiny8gMCeJzl15Eq8PdZILw4wCCX
	 7ShifSt5GYENcUq6y82G1Ik5XUm/CiD9v/vERdWqkwEBm/TzGvJA+dPH5wb1B46jjE
	 ZU2Yovg33mU5GytxRW3I1wg+fcpVt1ub0ZEU5L9xMjySHxagxSPIc+m3u/vEytPsmM
	 wSXm66oMbtqUyv0ynWG3N5wnmg8WOL9SRvllwqJ5lmrETlP3TXqLkGkF3LSvtlOiZe
	 s4YNdsCcqH49//SVTQGbzxo00JYNBgMdYtqf8rVPxv1w5JacCuw/9XEnR8Jeax+7Ju
	 Juwd0XCkc96Bg==
Message-ID: <a7b5d1e0-2994-40c8-abe4-56b7cefe6695@kernel.org>
Date: Mon, 21 Apr 2025 11:05:06 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] sunrpc: Replace the rq_vec array with
 dynamically-allocated memory
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250419172818.6945-1-cel@kernel.org>
 <20250419172818.6945-5-cel@kernel.org>
 <4f3228ee1730142246c23fd694128488157a9fa7.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <4f3228ee1730142246c23fd694128488157a9fa7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 8:22 AM, Jeff Layton wrote:
> On Sat, 2025-04-19 at 13:28 -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> As a step towards making NFSD's maximum rsize and wsize variable at
>> run-time, replace the fixed-size rq_vec[] array in struct svc_rqst
>> with a chunk of dynamically-allocated memory.
>>
>> The rq_vec array is sized assuming request processing will need at
>> most one kvec per page in a maximum-sized RPC message.
>>
>> On a system with 8-byte pointers and 4KB pages, pahole reports that
>> the rq_vec[] array is 4144 bytes. Replacing it with a single
>> pointer reduces the size of struct svc_rqst to about 5400 bytes.
> 
> nit: so I guess the current struct is ~9k or so?

11K plus, on my test system.


> If you're going to
> post numbers here, they should probably refer to the same thing.
> 
> I'm lazy -- don't make me do math.

Well it's a running total. Each patch in this part of the series reduces
the size of struct svc_rqst.

But I can update the descriptions. What math were you attempting to do?


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4proc.c         | 1 -
>>  fs/nfsd/vfs.c              | 2 +-
>>  include/linux/sunrpc/svc.h | 2 +-
>>  net/sunrpc/svc.c           | 8 +++++++-
>>  4 files changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index b397246dae7b..d1be58b557d1 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -1228,7 +1228,6 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  	write->wr_how_written = write->wr_stable_how;
>>  
>>  	nvecs = svc_fill_write_vector(rqstp, &write->wr_payload);
>> -	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
>>  
>>  	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
>>  				write->wr_offset, rqstp->rq_vec, nvecs, &cnt,
>> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
>> index 9abdc4b75813..4eaac3aa7e15 100644
>> --- a/fs/nfsd/vfs.c
>> +++ b/fs/nfsd/vfs.c
>> @@ -1094,7 +1094,7 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
>>  		++v;
>>  		base = 0;
>>  	}
>> -	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
>> +	WARN_ON_ONCE(v > rqstp->rq_maxpages);
>>  
>>  	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
>>  	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 96ac12dbb04d..72d016772711 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -207,7 +207,7 @@ struct svc_rqst {
>>  	struct page *		*rq_page_end;  /* one past the last page */
>>  
>>  	struct folio_batch	rq_fbatch;
>> -	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
>> +	struct kvec		*rq_vec;
>>  	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
>>  
>>  	__be32			rq_xid;		/* transmission id */
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index 682e11c9be36..5808d4b97547 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -675,6 +675,7 @@ static void
>>  svc_rqst_free(struct svc_rqst *rqstp)
>>  {
>>  	folio_batch_release(&rqstp->rq_fbatch);
>> +	kfree(rqstp->rq_vec);
>>  	svc_release_buffer(rqstp);
>>  	if (rqstp->rq_scratch_page)
>>  		put_page(rqstp->rq_scratch_page);
>> @@ -713,6 +714,11 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
>>  	if (!svc_init_buffer(rqstp, serv, node))
>>  		goto out_enomem;
>>  
>> +	rqstp->rq_vec = kcalloc_node(rqstp->rq_maxpages, sizeof(struct kvec),
>> +				      GFP_KERNEL, node);
>> +	if (!rqstp->rq_vec)
>> +		goto out_enomem;
>> +
>>  	rqstp->rq_err = -EAGAIN; /* No error yet */
>>  
>>  	serv->sv_nrthreads += 1;
>> @@ -1750,7 +1756,7 @@ unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
>>  		++pages;
>>  	}
>>  
>> -	WARN_ON_ONCE(i > ARRAY_SIZE(rqstp->rq_vec));
>> +	WARN_ON_ONCE(i > rqstp->rq_maxpages);
>>  	return i;
>>  }
>>  EXPORT_SYMBOL_GPL(svc_fill_write_vector);
> 


-- 
Chuck Lever

