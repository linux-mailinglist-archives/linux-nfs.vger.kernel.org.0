Return-Path: <linux-nfs+bounces-16182-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8568C4097D
	for <lists+linux-nfs@lfdr.de>; Fri, 07 Nov 2025 16:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD501A42DA7
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Nov 2025 15:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BFD329C58;
	Fri,  7 Nov 2025 15:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0Lu5Biq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34C32D9EC7;
	Fri,  7 Nov 2025 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529422; cv=none; b=Rq5KN6YyHtkN02Tc5AkLDbX9gbh9ybwIu99f9OqG9IfbiwoScudHai9nnyEjZ9mDCjVkkMSQM5/MvrbNpXXpmskMu75thgmV9VjqWFc25TsVOUr7N1Cqah/iZWauFtsPDRfW0mMcsyRxT0sEcTualpVfzYJvQvrU6pMnfyQs1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529422; c=relaxed/simple;
	bh=6c0TOCktv/s7itMgi97b8b3vo3UY9QS0yxrF8I0f0Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oW7+lSEURqzQyTke2rsGDh3JYT4AxKde6IQfmPAZwW+rZuSwdHp7ccqqgC84ylZHxrxbJEFe4nO4odmNIP51A/+uKlzsVNY906QphfDuOnDdiKda8pf3gqKwkIwVvXtmWCH9Rista0xXarfJfOykQLRIMBIPGJz0IrRG/uFCTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0Lu5Biq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C34C4CEF8;
	Fri,  7 Nov 2025 15:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762529422;
	bh=6c0TOCktv/s7itMgi97b8b3vo3UY9QS0yxrF8I0f0Lk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P0Lu5BiqGgfHOP8NycLjcSmZXkMlRAH/cVSxYScBIyD3wQETbqxj4s1IlrWQD8vk/
	 sANJZST6yvKs8tF6fUkMvt98brJT1q1NjQv2Kq9YF2J8j6zPmSFFLTrDneVqTuChBD
	 ifj5Y+pWtNvwUWp7zyOvgq5NRpWQzpWM/uSs46ncN0MMeEqkM+L4mqqG7SLYya0vXB
	 aTztB4wwFnxwbZZukuhQ2p51jGpkwG4EllxwPem1h2UU5OF4RStqkHzSUr74uSMTEE
	 4lf/sRiIv1q+7NKKR1/tOkJGafJ0BVZtbZ8nS+9YHIVH3uOtDNlxxVl1+gYmX3VK4h
	 jVKOzuC7XWiMw==
Message-ID: <5bbbbf82-a44b-4093-9119-c221f9e8f9a1@kernel.org>
Date: Fri, 7 Nov 2025 10:30:20 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] svcrdma: use rc_pageoff for memcpy byte offset
To: Joshua Rogers <reszta@joshua.hu>
Cc: NeilBrown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Joshua Rogers <linux@joshua.hu>
References: <20251107150949.3808-1-cel@kernel.org>
 <fxcda7FkdbPG_fttyXlSupjn11fncefYSlmcpQVVhEqZtDujhBlOxPADG_Havmcju29ZqPMXVwmMI980FtUVWs9jDUYiy-JWbaClISNNwQk=@joshua.hu>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <fxcda7FkdbPG_fttyXlSupjn11fncefYSlmcpQVVhEqZtDujhBlOxPADG_Havmcju29ZqPMXVwmMI980FtUVWs9jDUYiy-JWbaClISNNwQk=@joshua.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 10:23 AM, Joshua Rogers wrote:
> Apologies: is it possible to slightly change the commit msg to include "Found with ZeroPath"? As this bug was, indeed, found with a tool called ZeroPath. If not, it's OK, thought I'd ask.
> 
> Thank you.

Patch description in my tree now reads:

    svcrdma: use rc_pageoff for memcpy byte offset

    svc_rdma_copy_inline_range added rc_curpage (page index) to the page
    base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
    land within the current page.

    Found by ZeroPath (https://zeropath.com)




> On Friday, 7 November 2025 at 23:09, Chuck Lever <cel@kernel.org> wrote:
> 
>>
>>
>> From: Joshua Rogers linux@joshua.hu
>>
>>
>> svc_rdma_copy_inline_range added rc_curpage (page index) to the page
>> base instead of the byte offset rc_pageoff. Use rc_pageoff so copies
>> land within the current page.
>>
>> Fixes: 8e122582680c ("svcrdma: Move svc_rdma_read_info::ri_pageno to struct svc_rdma_recv_ctxt")
>> X-Cc: stable@vger.kernel.org
>> Signed-off-by: Joshua Rogers linux@joshua.hu
>>
>> Signed-off-by: Chuck Lever chuck.lever@oracle.com
>>
>> ---
>> net/sunrpc/xprtrdma/svc_rdma_rw.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> index 661b3fe2779f..945fbb374331 100644
>> --- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> +++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
>> @@ -848,7 +848,7 @@ static int svc_rdma_copy_inline_range(struct svc_rqst *rqstp,
>> head->rc_page_count++;
>>
>>
>> dst = page_address(rqstp->rq_pages[head->rc_curpage]);
>>
>> - memcpy(dst + head->rc_curpage, src + offset, page_len);
>>
>> + memcpy((unsigned char *)dst + head->rc_pageoff, src + offset, page_len);
>>
>>
>> head->rc_readbytes += page_len;
>>
>> head->rc_pageoff += page_len;
>>
>> --
>> 2.51.0
> 


-- 
Chuck Lever

