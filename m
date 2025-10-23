Return-Path: <linux-nfs+bounces-15567-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED63C013F4
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48DBB1A04B68
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A504313E1E;
	Thu, 23 Oct 2025 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOiv2QIm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468231076C
	for <linux-nfs@vger.kernel.org>; Thu, 23 Oct 2025 13:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761224446; cv=none; b=WwVUyVucWf+Ds6AGhTTgTAbRzoF7gpdkHqi8JqfMK83HEmfHvbKXMPkf4L+6Y85/oM/mFt+Q8kN0lfF0k6+bXxicCLwimLV94KguqWe9k9MU4RCuvhKN8IFskQqU+gPOJhtgfMn49XNSBuxmswHIrwkdC1F8VMLkeKqZvDsGF1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761224446; c=relaxed/simple;
	bh=ob0uRCH2kARCn32MdbNk9uQi7RwM0zTkL4k8xAG1QYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJyLEdnNLkc3QuxX4h9Be9emtMGFOyuYIYDY+pRSSZaQUznEv08fsX0wKwmO5SvNPJ3LSYo1c5uvROzdlaVfp8AH0Y5ZdMilMPjsqBWfeuKPBX6v2mXnrrclkFdOV/xQneWDXP3Rwv6xy4E+j0VkG3jsPFWA/v/dMs/h/PTk6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOiv2QIm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F5AC4CEE7;
	Thu, 23 Oct 2025 13:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761224445;
	bh=ob0uRCH2kARCn32MdbNk9uQi7RwM0zTkL4k8xAG1QYs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NOiv2QIm8ZKEMREqj6czy97kLfTmGzWGrcezt445wuEHtnCDDT67oMh5AWCTt+Lbk
	 tfXdHst12IHWJTeLDbd2kqCJZvO0ACfHUPJNdh4s06sM0TCdSdw94fTQZzGO0zeTTR
	 Iwpk2MGevguQIRI/CNM6zov6JvzftA20VqSQaBdP+knUaxx11b77mv/qwDc3Nlmvr+
	 dQzIDU7SVmvMq89m9fgPYx0G55xSmmmIFlvNvfTQymMjIZW5bcD7BegHoezdrUsz61
	 Q1ovD9f56VY6jk7DsE1T6DUof0OUfAHyazOYZMGZlF4jjZX7s1ROta0Rx1P9MzjCJo
	 gucJ99n0Whk4A==
Message-ID: <27e75634-03ba-4cfd-b6cc-2b5b903ed3d6@kernel.org>
Date: Thu, 23 Oct 2025 09:00:44 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] svcrdma: Mark Read chunks
To: Mike Snitzer <snitzer@kernel.org>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20251022192208.1682-1-cel@kernel.org>
 <20251022192208.1682-6-cel@kernel.org> <aPlL0_fIfGwNbZBF@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <aPlL0_fIfGwNbZBF@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/25 5:25 PM, Mike Snitzer wrote:
> On Wed, Oct 22, 2025 at 03:22:08PM -0400, Chuck Lever wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> The upper layer may want to know when the receive buffer's .pages
>> array is guaranteed to contain only an opaque payload. This permits
>> the upper layer to optimize its buffer handling.
>>
>> NB: Since svc_rdma_recvfrom.c is under net/, we use the comment
>> style that is preferred in the networking layer.
>>
>> Reviewed-by: Jeff Layton <jlayton@kernel.org>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> index e7e4a39ca6c6..b1a0c72f73de 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
>> @@ -815,6 +815,11 @@ static void svc_rdma_read_complete_one(struct svc_rqst *rqstp,
>>  	buf->page_len = length;
>>  	buf->len += length;
>>  	buf->buflen += length;
>> +
>> +	/* Transport guarantees that only the chunk payload
>> +	 * appears in buf->pages.
>> +	 */
>> +	buf->flags |= XDRBUF_READ;
>>  }
>>  
>>  /* Finish constructing the RPC Call message in rqstp::rq_arg.
>> -- 
>> 2.51.0
>>
>>
> 
> This patch header leaves me unclear on your thinking for upper layer
> optimization that would look for XDRBUF_READ.
> 
> I see rpcrdma_marshal_req() is checking XDRBUF_READ but...
> 
> I'm left hoping for a clearer payoff on this change's benefit (and
> relation to the rest of the patchset).

There's no pay-off yet. You asked me to provide a mechanism that
indicates when the transport is certain that buf.pages contains /only/
the write payload.

That's all that's happening here -- it paves the way for you to
construct the optimization in nfsd_vfs_write(). We don't have to commit
this change until you have a patch that can take advantage of it.

It could be that I misunderstood your request.


-- 
Chuck Lever

