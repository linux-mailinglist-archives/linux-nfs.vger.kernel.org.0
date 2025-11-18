Return-Path: <linux-nfs+bounces-16496-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2573C6B7D9
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 20:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6669428D47
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Nov 2025 19:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A03928C87C;
	Tue, 18 Nov 2025 19:51:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2ECBA3D;
	Tue, 18 Nov 2025 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763495496; cv=none; b=JzLef7jZ3pu8JWhVsaRB95WCsNHhXOJKiVRIXhrsaq9w27MHJze0ruDvJvGtgSIVhqSUOqZK0OBZIWVpojlwnmr15OG6aTz1ylmbZCa7zpPdKxOAV550NijULqzi/jBp2moLMRPLSa+1tCt92y4GF2o6yUuLRqKm/UYd6gybbzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763495496; c=relaxed/simple;
	bh=xhodetud9+cR1zDKjIDe6PdmUMM+XghJjZVVEMlocaw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=Q3kWkAzU17yfteBRiW40Dk13EI/n1HG+3T59wQhXR1LB2g0EmO8vImsz2NlggHMhMr+QXwdnCZNSNluPz20pd2uE6VLGcIsP7t/n/SM/bBUlGE1CqHZtIPjagxOrl+Tg4W/QlidiMET1knpRaLFjk/2lhS6BC2GAa4xUERWij0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.2.104] (213.87.158.194) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 18 Nov
 2025 22:51:10 +0300
Message-ID: <f89eaa5c-886e-4dc1-ac69-27ff6fdcff6e@omp.ru>
Date: Tue, 18 Nov 2025 22:51:09 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH v3] NFSv4: prevent integer overflow while calling
 nfs4_set_lease_period()
To: David Laight <david.laight.linux@gmail.com>
CC: <linux-nfs@vger.kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, <linux-kernel@vger.kernel.org>
References: <e0d1a313-f359-4ad0-bee3-3fcf0ffc0cda@omp.ru>
 <20251113224113.4f752ccc@pumpkin>
Content-Language: en-US
Organization: Open Mobile Platform
In-Reply-To: <20251113224113.4f752ccc@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 11/18/2025 19:40:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 198206 [Nov 18 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 77 0.3.77
 32e48053defa8195f3a40f668b6fa713f8e2761b
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.158.194 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 213.87.158.194 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;213.87.158.194:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 213.87.158.194
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/18/2025 19:42:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 11/18/2025 5:32:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 11/14/25 1:41 AM, David Laight wrote:
[...]

>> The nfs_client::cl_lease_time field (as well as the jiffies variable it's
>> used with) is declared as *unsigned long*, which is 32-bit type on 32-bit
>> arches and 64-bit type on 64-bit arches. When nfs4_set_lease_period() that
>> sets nfs_client::cl_lease_time is called, 32-bit nfs_fsinfo::lease_time
>> field is multiplied by HZ -- that might overflow before being implicitly
>> cast to *unsigned long*. Actually, there's no need to multiply by HZ at all
>> the call sites of nfs4_set_lease_period() -- it makes more sense to do that
>> once, inside that function, calling check_mul_overflow() and falling back
>> to 1 hour on an actual overflow...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Cc: stable@vger.kernel.org

[...]>> Index: linux-nfs/fs/nfs/nfs4renewd.c
>> ===================================================================
>> --- linux-nfs.orig/fs/nfs/nfs4renewd.c
>> +++ linux-nfs/fs/nfs/nfs4renewd.c
>> @@ -137,11 +137,15 @@ nfs4_kill_renewd(struct nfs_client *clp)
>>   * nfs4_set_lease_period - Sets the lease period on a nfs_client
>>   *
>>   * @clp: pointer to nfs_client
>> - * @lease: new value for lease period
>> + * @period: new value for lease period (in seconds)
>>   */
>> -void nfs4_set_lease_period(struct nfs_client *clp,
>> -		unsigned long lease)
>> +void nfs4_set_lease_period(struct nfs_client *clp, u32 period)
>>  {
>> +	unsigned long lease;
>> +
>> +	if (check_mul_overflow(period, HZ, &lease))
>> +		lease = 60UL * 60UL * HZ; /* one hour */
> 
> That isn't good enough, just a few lines higher there is:
> 	timeout = (2 * clp->cl_lease_time) / 3 + (long)clp->cl_last_renewal
> 		- (long)jiffies;
   Indeed, I should have probably capped period at 3600 secs as well...

> So the value has to be multipliable by 2 without overflowing.
> I also suspect the modulo arithmetic also only works if the values
> are 'much smaller than long'.

   You mean the jiffies-relative math? I think it should work with any
values, with either 32- or 64-bit *unsigned long*...

> With HZ = 1000 and a requested period of 1000 hours the multiply (just)
> fits in 32 bits - but none of the code is going to work at all.
> 
> It would be simpler and safer to just put a sanity upper limit on period.

   Yes.

> I've no idea what normal/sane values are (lower as well as upper).

   The RFCs don't have any, it seems...

> But perhaps you want:
> 	/* For sanity clamp between 10 mins and 100 hours */
> 	lease = clamp(period, 10 * 60, 100 * 60 * 60) * HZ;

   Trond was talking about 1-hour period... And I don't think we need the
lower bound (except maybe 1 second?)...

>> +
>>  	spin_lock(&clp->cl_lock);
>>  	clp->cl_lease_time = lease;
>>  	spin_unlock(&clp->cl_lock);
> 
> Do I see a lock that doesn't?

   Doesn't do anything useful, you mean? :-)

[...]

MBR, Sergey

