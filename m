Return-Path: <linux-nfs+bounces-15176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D46CBD32FD
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 15:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E033A63AB
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Oct 2025 13:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA22FBE17;
	Mon, 13 Oct 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goVBYkq6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8686261B9C
	for <linux-nfs@vger.kernel.org>; Mon, 13 Oct 2025 13:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361934; cv=none; b=Hzb35IIzSiyANf/QcKlVQwZe8t4PYLN9B34QGmoCClaBwIIs6Bu/pNLUQWe8rozNwOipNP9Ld9a9Imim85ZeND5vwtFRkl399Wjv7EI0zJQ5o9NYzuCilXBD5VV42zK09b9HjbJcCWee4aEgqHF+la6/3ddjMdrgUJcq8wl8k+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361934; c=relaxed/simple;
	bh=EemHrgFM9EF3aOV46AkAA3LATYYifipQuuMW0ks3AZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ST8taGRzEYo33Y4LYs7gV2C+Wg1viHkWopOhRF/PeAiAUcR1KcI6d/Ctoeb9g6WJZ38dliV1t1aeTvn/3cgyzDKYTOMqt9rczkFiIEsh8rV8gHtWRJacWvB9Ohc0+Ua2AOkJSYkJwO00/IOFsdtlw3oasuzr+p3DJNOBor9QDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goVBYkq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B32A7C4CEE7;
	Mon, 13 Oct 2025 13:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760361934;
	bh=EemHrgFM9EF3aOV46AkAA3LATYYifipQuuMW0ks3AZM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=goVBYkq6sbrmZt1tKe4l4m+ACjfcnmqoJgBOJEZoiI67PUl9ACOB6PBVKihKqw2v6
	 dwBGDEXmRFsflb9loQKSD6H3kUutLDwslByI/VgZFpGW7/1U9I6by+ce+N6b2I6/NY
	 xiZd7/79Edaex9BUjScCoHlSVvRuG30bFp/sa+/3Jn3qwYhMa0YTheKb7Jgnv9VQjv
	 KBiKAZhotezazoJj2MK5Gk7Af9gOnOeTQbShjbu0CeJQbEDg/sjRpEd5dV18EcE4zd
	 eKMpWeOIXe6MbTd6GkuP2q1uKqZ5YwhLNCcAmxXE6pQFjNckrKgkTJ+KMOWfrVIekn
	 Y0gnRM3eoC7gg==
Message-ID: <c67cb4e6-11c9-4a4a-99c5-a1721ca7542e@kernel.org>
Date: Mon, 13 Oct 2025 09:25:32 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] NFSD: Fix the "is this a solo SEQUENCE" predicate
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251012170746.9381-1-cel@kernel.org>
 <20251012170746.9381-4-cel@kernel.org>
 <176033061350.1793333.14824740301723157290@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <176033061350.1793333.14824740301723157290@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 12:43 AM, NeilBrown wrote:
> On Mon, 13 Oct 2025, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The logic in nfsd4_is_solo_sequence() is incorrect: it checks the
>> current operation index, not the total count of operations in the
>> COMPOUND. If the SEQUENCE operation, which is always operation 1,
>> fails in a multi-operation compound, resp->opcnt is always 1. Thus
>> when a SEQUENCE operation fails, nfsd4_is_solo_sequence() always
>> returns true.
>>
>> Note that, because nfsd4_is_solo_sequence() is called only by
>> nfsd4_store_cache_entry(), it is assured that the first operation
>> in the COMPOUND being checked is a SEQUENCE op. Thus the opnum
>> check is redundant.
> 
> It is also assured that the SEQUENCE op didn't fail, so the distinction
> between resp->opcnt and args->opcnt is moot.
> 
> I don't think nfsd4_is_solo_sequence() serves any useful purpose.
> The only case were the result has any effect, the effect is to set
> NFSD4_SLOT_CACHED, and to set sl_datalen to zero.
> 
> I would prefer that the code didn't pretend that solo sequence requests
> were cached - they aren't.  They are simply performed again when needed.
> But that can be for another day.

One wonders why the comments take such pains to call out "caching solo
sequence" operations if these operations aren't actually cached. Perhaps
I should replace this patch with one that removes
nfsd4_is_solo_sequence() .

Here's why this is relevant:

 941 static inline bool nfsd4_cache_this(struct nfsd4_compoundres *resp)

 942 {

 943         return (resp->cstate.slot->sl_flags & NFSD4_SLOT_CACHETHIS)

 944                 || nfsd4_is_solo_sequence(resp);

 945 }

If nfsd4_is_solo_sequence always returns true, then so does
nfsd4_cache_this, it looks like.


> I don't think this patch achieves anything useful, but I don't object to
> it.
> 
> NeilBrowjn
> 
> 
> 
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  fs/nfsd/xdr4.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
>> index ee0570cbdd9e..d4548a16a36e 100644
>> --- a/fs/nfsd/xdr4.h
>> +++ b/fs/nfsd/xdr4.h
>> @@ -926,7 +926,8 @@ struct nfsd4_compoundres {
>>  static inline bool nfsd4_is_solo_sequence(struct nfsd4_compoundres *resp)
>>  {
>>  	struct nfsd4_compoundargs *args = resp->rqstp->rq_argp;
>> -	return resp->opcnt == 1 && args->ops[0].opnum == OP_SEQUENCE;
>> +
>> +	return args->opcnt == 1;
>>  }
>>  
>>  /*
>> -- 
>> 2.51.0
>>
>>
> 


-- 
Chuck Lever

