Return-Path: <linux-nfs+bounces-6541-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34C997C0FE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 22:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 246C31C20D22
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Sep 2024 20:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1381C9ED4;
	Wed, 18 Sep 2024 20:52:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519E6FC5
	for <linux-nfs@vger.kernel.org>; Wed, 18 Sep 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726692766; cv=none; b=LHm/j9xxLGMBF2YrJQCOafPBRY9qB8bFXWGcww3VGEQbLrInzOH/1VDStUnXIrK4UW2Mmfdhl3ttSl2qKlVXake64pn9DzW1xuUhbpdz0MtEeTxR4F7S+igORULM8NuXgDGKxxILFdaszVhLcjmGj5+kADDQy4o6QxHiVJh7zfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726692766; c=relaxed/simple;
	bh=xiEFngcX9il00XFutJv9dqvmDE/VTcYEVdsX4FGnr3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cFKJ24iFBv1CF4BJnIoYq+x+TInA0DO8RAx0SP6BtHW8v2oSxkTCdQEmlug9Upf3eW/FN+fTp4NWnxQSsLZmB8LGmbNYjhY340JsAmFkDPpylb8tyXns7qJsFyOjYetC5/tWC+bTxvAAc130PenNmo8VYwscdvYNnO64IOEmFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.109] (31.173.87.200) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 18 Sep
 2024 23:52:30 +0300
Message-ID: <a0a1e07a-4116-7768-36ff-4799735b3331@omp.ru>
Date: Wed, 18 Sep 2024 23:52:30 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
Content-Language: en-US
To: Anna Schumaker <anna.schumaker@oracle.com>, <linux-nfs@vger.kernel.org>,
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <4904f32e-a392-803b-9766-4aa2d5cee12b@omp.ru>
 <7206ed18-0e5b-4306-b451-e7eecde71d9f@oracle.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
In-Reply-To: <7206ed18-0e5b-4306-b451-e7eecde71d9f@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/18/2024 20:31:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187840 [Sep 18 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.200 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.87.200 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.200
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/18/2024 20:35:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/18/2024 4:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/16/24 22:44, Anna Schumaker wrote:
[...]

>> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
>> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
>> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
>> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
>> field is multiplied by HZ -- that might overflow *unsigned long* on 32-bit
>> arches.  Actually, there's no need to multiply by HZ at all the call sites
>> of nfs4_set_lease_period() -- it makes more sense to do that once, inside
>> that function (using mul_u32_u32(), as it produces a better code on 32-bit
>> x86 arch), also checking for an overflow there and returning -ERANGE if it
>> does happen (we're also making that function *int* instead of *void* and
>> adding the result checks to its callers)...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Cc: stable@vger.kernel.org
[...]

>> Index: linux-nfs/fs/nfs/nfs4renewd.c
>> ===================================================================
>> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
>> +++ linux-nfs/fs/nfs/nfs4renewd.c
>> @@ -137,15 +137,22 @@ nfs4_kill_renewd(struct nfs_client *clp)
>>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
>>   *
>>   * @clp: pointer to nfs_client
>> - * @lease: new value for lease period
>> + * @period: new value for lease period (in seconds)
>>   */
>> -void nfs4_set_lease_period(struct nfs_client *clp,
>> -		unsigned long lease)
>> +int nfs4_set_lease_period(struct nfs_client *clp, u32 period)
>>  {
>> +	u64 result = mul_u32_u32(period, HZ);
> 
> Thanks for the patch! Sorry it took a couple of weeks for me to look at.

   NP, better late than never. :-)

> I do like this change for doing the calculation in a single place, rather
 than relying on callers to do it first.
> 
>> +	unsigned long lease = result;
>> +
>> +	/* First see if period * HZ actually fits into unsigned long... */
>> +	if (result > ULONG_MAX)
>> +		return -ERANGE;
> 
> However, I'm not sold that this should be an error condition. I wonder if it would be better to change the clp->cl_lease_time field to a u64 so it has the same size on 32bit and 64bit architectures?

   That would be much more invasive change. And pretty fruitless, I think, because nfs_client::cl_lease_time is only involved in the jiffies math,
and since jiffies is *unsigned long* (i.e. 32-bit on a 32-bit arch), the
results of our u64 math would get truncated to 32 bits anyway in the end...
   Looking at time_{after|before}(), I even suspected they could complain
at compile time -- however I wasn't able to trigger that so far...

> Thanks,
> Anna

[...]

MBR, Sergey

