Return-Path: <linux-nfs+bounces-11230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB47CA98AA0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0008C443F6D
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F4442049;
	Wed, 23 Apr 2025 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdDUH2uN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141262940B
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 13:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745414182; cv=none; b=scb7SywpM73+Q1xTb7xi2coN0PTTvKOq7fysrZ/3xuscHA6NSDEQtvJBUYDLhKtUu9s9mSsLFTx0J54tiusb5va4IVRHII4Fxaxnr0XuUvdnTcHRuUv64DYI4HAjIwxUuAUDnkSyXqQvSYza4CxPSnDfQQkU3o0qkLDMVNtUZTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745414182; c=relaxed/simple;
	bh=XZf0mTGmnUHhWIcOWViah+LNH77pFqgZHEAI1lqFr4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gegyVMyaonsNUbee2gBDJo7tlNqYVaIGFv2QGNAybsY7SPdFfvFeR6FA15uT6G6T//eXokfF25Cs5csRodT/9BKZN376qK1GZ7WFfIbsvbtRjf5Kw/ZurDg52uhDcZeD7tGcRLytn73cTPL4Yeu6zYwREAjfqneBfetvP3tH6rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdDUH2uN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF671C4CEE2;
	Wed, 23 Apr 2025 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414181;
	bh=XZf0mTGmnUHhWIcOWViah+LNH77pFqgZHEAI1lqFr4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VdDUH2uNt2JsZ2DbQHlCwMLYbtYNu59W9qO/FlBoJYgY2h2sd8G0SmLl4bJqLZ2Nu
	 9eb1lwGxirR65yzMLEgcu6GWp/Huzup5Pt7cpdhXPDuPDU5aWTBsLaJmUZmdo5q6WD
	 sjoLKkZs1DrVg4zpTW7x5OMaqKNRswfiRJjCQnu+npaj2dG/psMhQv6QMkRdKmMvn4
	 VdOuqFWhJSWBKEE41QUsP0p5Ws70TBOEFLVOLrx/CL8xK9Z4/whiBxNTA28CUPzxr6
	 bLRCDn7Za6dQxM6FeDZV5EOOemIQjBpook/eRjUuydcKd7LtdiLZAxCORVrvK4t+oD
	 Y2XE4jZiaVJMQ==
Message-ID: <26a95e24-edc0-4a66-a54f-1a116cdea976@kernel.org>
Date: Wed, 23 Apr 2025 09:16:19 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] sunrpc: Add a helper to derive maxpages from
 sv_max_mesg
To: NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <dai.ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, linux-nfs@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>
References: <20250419172818.6945-1-cel@kernel.org>
 <20250419172818.6945-3-cel@kernel.org>
 <174535491846.500591.11542398392986089529@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <174535491846.500591.11542398392986089529@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/22/25 4:48 PM, NeilBrown wrote:
> On Sun, 20 Apr 2025, cel@kernel.org wrote:
>> From: Chuck Lever <chuck.lever@oracle.com>
>>
>> This page count is to be used to allocate various arrays of pages,
>> bio_vecs, and kvecs, replacing the fixed RPCSVC_MAXPAGES value.
>>
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>>  include/linux/sunrpc/svc.h | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
>> index 74658cca0f38..5b879c31d7b8 100644
>> --- a/include/linux/sunrpc/svc.h
>> +++ b/include/linux/sunrpc/svc.h
>> @@ -159,6 +159,18 @@ extern u32 svc_max_payload(const struct svc_rqst *rqstp);
>>  #define RPCSVC_MAXPAGES		((RPCSVC_MAXPAYLOAD+PAGE_SIZE-1)/PAGE_SIZE \
>>  				+ 2 + 1)
>>  
>> +/**
>> + * svc_serv_maxpages - maximum pages/kvecs needed for one RPC message
>> + * @serv: RPC service context
>> + *
>> + * Returns a count of pages or vectors that can hold the maximum
>> + * size RPC message for @serv.
>> + */
>> +static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
>> +{
>> +	return ((serv->sv_max_mesg + PAGE_SIZE - 1) >> PAGE_SHIFT) + 2 + 1;
>> +}
>> +
> 
> This looks like it should be
>      DIV_ROUND_UP(serv->sv_max_mesg, PAGE_SIZE) + 2

Fair enough! I had forgotten about that macro.


> Could we document what the "+ 2" is for??

10/10 in this series moves an existing documenting comment for that
purpose. I've relocated that hunk to this patch, but I think the text
needs to be revisited because it ignores NFSv4 COMPOUNDs that may
carry multiple payloads.

I plan to post a v3 of this series soon.


> Thanks,
> NeilBrown
> 
> 
>>  /*
>>   * The context of a single thread, including the request currently being
>>   * processed.
>> -- 
>> 2.49.0
>>
>>
> 


-- 
Chuck Lever

