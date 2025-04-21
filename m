Return-Path: <linux-nfs+bounces-11206-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4CA95335
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9FE189527E
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 14:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8289812C470;
	Mon, 21 Apr 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmCC3gG7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD50CA5E
	for <linux-nfs@vger.kernel.org>; Mon, 21 Apr 2025 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745247549; cv=none; b=habSkQEa0zJj7oDLMuREfgi9dGaKr5i2lGQQksO8TzWJvhXGFL8Bel2BXlzq3WEiheUWLMTyjAEruw9qQnu1tXiCMd1tirh9DUrVb7XOC+nx2vidFy8EwFrVarqVNEj1BnHIBnM6nyo1FTmqwNNgTDbjpyjqxfJrcdH0BAAzns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745247549; c=relaxed/simple;
	bh=5Peo2jbXxX3d6wXZHjdHPzwV8nx/g61rDZf9OyuHVTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwYbaponbhR6Ovg8PUMG40JN/3t1/nUdwxX1Yuv8ITpeDvLgEaxp4EECohVUI6KiBp1neqoYb5nP7hpcJLES11YRlwtu2dvK200PQbNOwv7cn6xq30uk0LT7+W5X2fnJ81kqBC622ZkuXjir6xmXSDQKE80JkFq7d0P+V8ZKq0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmCC3gG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37363C4CEE4;
	Mon, 21 Apr 2025 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745247548;
	bh=5Peo2jbXxX3d6wXZHjdHPzwV8nx/g61rDZf9OyuHVTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WmCC3gG7FMLBkxxwG8APcQTIwcABhrNlfzLK0RznKTGWW1BVuoWUwILfgm0kZ07E4
	 LxBhbrdeFkiL++Bwib+Xc+xUe6yA3hcuBSceAz/dN5m0GSuZA9c2kvLVUON58YSwx2
	 v5QqfHl5QR7qMSaDxIbTaeVyrZuNIN7yj/BoF+HgVvw0Y0+eCqwfmcUmmjHc0NTK46
	 6ClSBeppnkpVmRDXCRwJ1+VOr9ETh8B90Z7rOxuZiyRYxKqhTabBnwreAPUPLr+LXz
	 JG8si6naksTmrQ6iRUJ1pY3T1RGcKsk18EBkmwiUtIqTpZ0wJT8BhjfZrWO6o+MEjz
	 EEiPub671QG1A==
Message-ID: <0202b574-19b4-4e06-9966-0cded6ff6c11@kernel.org>
Date: Mon, 21 Apr 2025 10:59:07 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] sunrpc: Remove backchannel check in
 svc_init_buffer()
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
References: <20250419172818.6945-1-cel@kernel.org>
 <20250419172818.6945-2-cel@kernel.org>
 <1263daf84321d07574a05e3cbda66ecf3716a4bc.camel@kernel.org>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <1263daf84321d07574a05e3cbda66ecf3716a4bc.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/21/25 8:16 AM, Jeff Layton wrote:
> On Sat, 2025-04-19 at 13:28 -0400, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> A backchannel service might use forechannel send and receive
>> buffers, but svc_recv() still calls svc_alloc_arg() on backchannel
>> svc_rqsts, so it will populate the svc_rqst's rq_pages[] array
>> anyway. The "is backchannel" check in svc_init_buffer() saves us
>> nothing.
>>
>> In a moment, I plan to replace the rq_pages[] array with a
>> dynamically-allocated piece of memory, and svc_init_buffer() is
>> where that memory will get allocated. Backchannel requests actually
>> do use that array, so it has to be available to handle those
>> requests without a segfault.
>>
>> XXX: Or, make svc_alloc_arg() ignore backchannel requests too?
>>      Could set rqstp->rq_maxpages to zero.
>>
> 
> Maybe I'm confused here, but the backchannel still needs some pages to
> do its thing? I guess the main change here is that the pages are
> allocated at svc_create time instead of waiting until later?

The backchannel does not use the pages in svc_rqst::rq_pages, it's
rq_arg::pages comes from the RPC client's page allocator. Currently,
svc_init_buffer() skips allocating pages in rq_pages for that reason.

Except that, svc_rqst::rq_pages is filled anyway when a backchannel
svc_rqst is passed to svc_recv() -> and then to svc_alloc_arg().

This isn't really a problem at the moment, except that these pages are
allocated but then never used AFAICT.

The problem is that in 03/10, in addition to populating rq_pages[],
svc_init_buffer() also now allocates the rq_pages array itself. If
that is skipped, then svc_alloc_args() chases a NULL pointer.

As I mentioned in the patch description, there are two or three ways to
handle this. I'm not sure the way proposed here is best, but it does
avoid introducing extra conditional logic in svc_alloc_args(), which is
a hot path.

Let me know if you have a better idea. I will try to bolster the patch
description here as well.


>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  net/sunrpc/svc.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
>> index e7f9c295d13c..8ce3e6b3df6a 100644
>> --- a/net/sunrpc/svc.c
>> +++ b/net/sunrpc/svc.c
>> @@ -640,10 +640,6 @@ svc_init_buffer(struct svc_rqst *rqstp, unsigned int size, int node)
>>  {
>>  	unsigned long pages, ret;
>>  
>> -	/* bc_xprt uses fore channel allocated buffers */
>> -	if (svc_is_backchannel(rqstp))
>> -		return true;
>> -
>>  	pages = size / PAGE_SIZE + 1; /* extra page as we hold both request and reply.
>>  				       * We assume one is at most one page
>>  				       */
> 
> Acked-by: Jeff Layton <jlayton@kernel.org>


-- 
Chuck Lever

