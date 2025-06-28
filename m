Return-Path: <linux-nfs+bounces-12811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FAAAECA3B
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jun 2025 22:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5387117BAB5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Jun 2025 20:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A628E22540A;
	Sat, 28 Jun 2025 20:09:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193F11DB13A
	for <linux-nfs@vger.kernel.org>; Sat, 28 Jun 2025 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751141357; cv=none; b=LWPTqN9zNdrd0PHfjvBI/Hp1i25Q23rvKm+q7qMk93EXrFZI3wlaSPQUOP2lCEJ0sAkoQixrRr3jB9yuWptNuqTnrO2aZeKnLRv++blNmVyg1Ge9LfQyCvtGaRTvael1Xq/cyQfCKwDcVOfnFWsc6hSxqU5YWgXqbxhRjAlqlfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751141357; c=relaxed/simple;
	bh=5hWkkrj0Kz+tzvW51IeBJYR498i4gZqIZsFEkkRwr+A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=p+oimJi1QsjmL75pCfIE1guhSvEtrf7VqjGZmcjIOvfCeN/Jbi5zwb6ZEF+E/tHTsuk4euxHfUebESaAxFiCA/l6yMWPm95sBeyPOcOQWLdwJ6UuhaT5TTjI9ngnAJJy0MQ4/PphfdgOFymPMwJoF/ujoEBOAlisDcZE912Pv/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.102] (213.87.128.215) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 28 Jun
 2025 23:08:59 +0300
Message-ID: <fb4e063e-11cd-4e55-a481-41b015d93dcd@omp.ru>
Date: Sat, 28 Jun 2025 23:08:58 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Anna Schumaker <anna.schumaker@oracle.com>, <linux-nfs@vger.kernel.org>,
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
 <7206ed18-0e5b-4306-b451-e7eecde71d9f@oracle.com>
 <a0a1e07a-4116-7768-36ff-4799735b3331@omp.ru>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <a0a1e07a-4116-7768-36ff-4799735b3331@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/28/2025 19:52:16
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 194405 [Jun 28 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.128.215 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.128.215 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.128.215
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/28/2025 19:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/28/2025 6:40:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/18/24 11:52 PM, Sergey Shtylyov wrote:
[...]

>>> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
>>> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
>>> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
>>> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
>>> field is multiplied by HZ -- that might overflow *unsigned long* on 32-bit
>>> arches.  Actually, there's no need to multiply by HZ at all the call sites
>>> of nfs4_set_lease_period() -- it makes more sense to do that once, inside
>>> that function (using mul_u32_u32(), as it produces a better code on 32-bit
>>> x86 arch), also checking for an overflow there and returning -ERANGE if it
>>> does happen (we're also making that function *int* instead of *void* and
>>> adding the result checks to its callers)...
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>>> analysis tool.
>>>
>>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>> Cc: stable@vger.kernel.org
> [...]
> 
>>> Index: linux-nfs/fs/nfs/nfs4renewd.c
>>> ===================================================================
>>> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
>>> +++ linux-nfs/fs/nfs/nfs4renewd.c
>>> @@ -137,15 +137,22 @@ nfs4_kill_renewd(struct nfs_client *clp)
[...]
>>> +	unsigned long lease = result;
>>> +
>>> +	/* First see if period * HZ actually fits into unsigned long... */
>>> +	if (result > ULONG_MAX)
>>> +		return -ERANGE;
>>
>> However, I'm not sold that this should be an error condition. I wonder if it would be better to change the clp->cl_lease_time field to a u64 so it has the same size on 32bit and 64bit architectures?
> 
>    That would be much more invasive change. And pretty fruitless, I think, because nfs_client::cl_lease_time is only involved in the jiffies math,
> and since jiffies is *unsigned long* (i.e. 32-bit on a 32-bit arch), the
> results of our u64 math would get truncated to 32 bits anyway in the end...
>    Looking at time_{after|before}(), I even suspected they could complain
> at compile time -- however I wasn't able to trigger that so far...

   Alternatively, we could set the lease variable on overflow to MAX_JIFFY_OFFSET
which seems to be a max timeout in jiffies...

[...]

MBR, Sergey


