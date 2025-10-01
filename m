Return-Path: <linux-nfs+bounces-14835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA6BB071C
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Oct 2025 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D17517AB70
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Oct 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609C62E8B62;
	Wed,  1 Oct 2025 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jf95CZ6p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E82980A8
	for <linux-nfs@vger.kernel.org>; Wed,  1 Oct 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324574; cv=none; b=W1Ac6X0HhJdjIF2J/olz5sgKU3skJGRkqf6srLTp/V6xphXM4ZNnR0x+iKLRYcnNwIzq9GIrpf8DzlrimLep7HvuXCDpQwd7FAw9e8dhOAIGfdTaEzTKK8WSANdGkdP1o65g3c3XHXJ9CxgRV4LE/EklSyC9wY2U5nWju1kSX44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324574; c=relaxed/simple;
	bh=Dk4M5JSgy/c/K5deG53JQg3lDhVersRHB4c5pBEuTjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9C5BCLry6WmIIUSfZhIhYnj3Mlx+O/dDfgKsng7DZdWfkKN3DAq9hPRxhJc2qpG4eml1H202n4L74sJ7/+CPt6x3qTXiN0WLu8jcZAMmvDAX2Nu8vW0czCbeuDfQ3jSTFjUUY5axOB4SVdIL7KRUrbvO/W5qiWQYFkpOwdPSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jf95CZ6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEECC4CEF4;
	Wed,  1 Oct 2025 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759324573;
	bh=Dk4M5JSgy/c/K5deG53JQg3lDhVersRHB4c5pBEuTjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Jf95CZ6p/DDNSu7MmPVO9Xx6D9JDzoBqekB19gDdkcyLk/o4uScPu7RHovTdEiPI3
	 M7AdHbNPMTnM224xsB70pOC8J/azknw0GyzltVdOIuJgWT2p91NKqF4ft+GSNLcErB
	 6HqUM7K+rqHoguuJAyhmJoim6kNyY9vM29RnvVOokJ/ePgEcjlob4NLvcy14m/Ngg3
	 0NvSzVKbv3Ksirl0IwZb9yVf281kdki7HvclhXAHQxQnGkQ3aMguaajdYmZy6Lec80
	 /JodrEoB1Yvx/wKwaIUoQlJ2qOhkePA6sP5B73Oos3947mzSx/qdyxKrxy7jKy9kLF
	 eLlaHioWk9DdA==
Message-ID: <57b7be9c-dcbb-477d-b453-736fa7ddcfe4@kernel.org>
Date: Wed, 1 Oct 2025 09:16:12 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] NFSD: Fix crash in nfsd4_read_release()
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250930140520.2947-1-cel@kernel.org>
 <175928003792.1696783.17556773248679753110@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <175928003792.1696783.17556773248679753110@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/25 8:53 PM, NeilBrown wrote:
> On Wed, 01 Oct 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> When tracing is enabled, the trace_nfsd_read_done trace point
>> crashes during the pynfs read.testNoFh test.
>>
>> Fixes: 87c5942e8fae ("nfsd: Add I/O trace points in the NFSv4 read proc")
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/nfs4proc.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
>> index e466cf52d7d7..f9aeefc0da73 100644
>> --- a/fs/nfsd/nfs4proc.c
>> +++ b/fs/nfsd/nfs4proc.c
>> @@ -988,10 +988,11 @@ nfsd4_read(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
>>  static void
>>  nfsd4_read_release(union nfsd4_op_u *u)
>>  {
>> -	if (u->read.rd_nf)
>> +	if (u->read.rd_nf) {
>> +		trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> +				     u->read.rd_offset, u->read.rd_length);
>>  		nfsd_file_put(u->read.rd_nf);
>> -	trace_nfsd_read_done(u->read.rd_rqstp, u->read.rd_fhp,
>> -			     u->read.rd_offset, u->read.rd_length);
>> +	}
>>  }
> 
> I must say this looks a bit weird.  rd_nf isn't used in the trace but if
> it isn't set, you say the trace crashes...
> 
> That is because rd_fhp being NULL (because there is no current_fh) is
> one thing that results in rd_nf being NULL.  Seems a bit indirect.

When rd_nf is NULL, no file or file handle is present. That's really all
there is to it. You can read it as "when rd_nf is NULL, no processing is
needed".

The other read trace points are already skipped in this case as well, so
there is no need to protect them.


> Did you consider
>    if (u->read.rd_fhp)
>        trace .....
>    if (u->read.rd_nf)
>        nfsd_file_put....
> 
> ??

I can't think of a legitimate case where fhp is not NULL but nf is
NULL. Or vice versa.


> Or maybe
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -444,7 +444,7 @@ DECLARE_EVENT_CLASS(nfsd_io_class,
>  	),
>  	TP_fast_assign(
>  		__entry->xid = be32_to_cpu(rqstp->rq_xid);
> -		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
> +		__entry->fh_hash = fhp ? 0 : knfsd_fh_hash(&fhp->fh_handle);
>  		__entry->offset = offset;
>  		__entry->len = len;
>  	),
> 
> 
> That would make all IO event trace points robust.
> I'm almost tempted to suggest knfsd_fh_hash() be changed to receive a
> svc_fh and test for NULL, but there are 2 places where there isn't a
> svc_fh handy.
> 
> NeilBrown
> 


-- 
Chuck Lever

