Return-Path: <linux-nfs+bounces-16214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF391C42EE7
	for <lists+linux-nfs@lfdr.de>; Sat, 08 Nov 2025 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37998188BE5B
	for <lists+linux-nfs@lfdr.de>; Sat,  8 Nov 2025 15:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D121E00B4;
	Sat,  8 Nov 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwCt5SIp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1E018C2C;
	Sat,  8 Nov 2025 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762616976; cv=none; b=XfqMqCeZTHzQTDys4AsYtm4lDhmHExgfBc10HWtRDqKQUoAEjzG4avQhQ7Dl8/67+2aYocN/opw2L+Zze0rKJ4egeuzF+jjnkGgBnLZ8tqgmfDD5GYkKIyBO4kp4inAyybJP/jBZ2rcqRXSwYVXLZDYzpsKH7+yAKH0/T6EVJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762616976; c=relaxed/simple;
	bh=JGBD1WdpR8se7blVNwDS5FftBsn8t1gjcXcszTpasAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPTdDmYu1P8/hwALTRcKUuux+C4y9xkaUqq0kcjhIXtA1xinsLPR1aKuWN05vaaYWi4FVC6yUe9BszSWSYE1P8wA//FR0/l22QNzIVAcY1gJPGvW92E0oUOBhAPKQfxnPP+1R3f/p7r9yXpzQjBhjOv5SHcRV1nZvrR3cE5X+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwCt5SIp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E170C4AF0B;
	Sat,  8 Nov 2025 15:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762616976;
	bh=JGBD1WdpR8se7blVNwDS5FftBsn8t1gjcXcszTpasAY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OwCt5SIpd4Er9Bc0PQNRfhsPYi9ze7G64zt//RkuKncDUjAy9IOhBxi7EEl0yFc2R
	 1UDzbCMx7s5Z9NJPKEYpdKpY0SVXHkfxkmrg5PSuY70U952B5LTTNe3EntEKBnAIK3
	 vyF76WDtlDcRFQ6g9fu5aOX83IfUYKlc5uDjwXqy6443IxTmE4f/acuqgWRf4qHjPo
	 mqUEhYCUZf4RdZyAawEoWtpLKZ21vT63hEAkdBp0O0Jh8zRVJZJteu/U5DtccXEN40
	 bfvBmecnsRUlV46CrRN/bIV0l2ipoYQM0U2PZDeSM5I3FBR1pEH+ZbSH8iIu0XprG1
	 l6weoFL+5bkLA==
Message-ID: <cf9573c2-5fb7-4417-8ff0-eef4172621fb@kernel.org>
Date: Sat, 8 Nov 2025 10:49:34 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
To: NeilBrown <neil@brown.name>, David Laight <david.laight.linux@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Laight <David.Laight@ACULAB.COM>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
 <37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
 <20251106192210.1b6a3ca0@pumpkin>
 <176251424056.634289.13464296772500147856@noble.neil.brown.name>
 <20251107114324.33fd69f3@pumpkin>
 <176255578949.634289.10177595719141795960@noble.neil.brown.name>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <176255578949.634289.10177595719141795960@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/25 5:49 PM, NeilBrown wrote:
> On Fri, 07 Nov 2025, David Laight wrote:
>> On Fri, 07 Nov 2025 22:17:20 +1100
>> NeilBrown <neilb@ownmail.net> wrote:
>>
>>> On Fri, 07 Nov 2025, David Laight wrote:
>>>> On Thu, 6 Nov 2025 09:33:28 -0500
>>>> Chuck Lever <cel@kernel.org> wrote:
>>>>   
>>>>> FYI
>>>>>
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=220745  
>>>>
>>>> Ugg - that code is horrid.
>>>> It seems to have got deleted since, but it is:
>>>>
>>>> 	u32 slotsize = slot_bytes(ca);
>>>> 	u32 num = ca->maxreqs;
>>>> 	unsigned long avail, total_avail;
>>>> 	unsigned int scale_factor;
>>>>
>>>> 	spin_lock(&nfsd_drc_lock);
>>>> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
>>>> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
>>>> 	else
>>>> 		/* We have handed out more space than we chose in
>>>> 		 * set_max_drc() to allow.  That isn't really a
>>>> 		 * problem as long as that doesn't make us think we
>>>> 		 * have lots more due to integer overflow.
>>>> 		 */
>>>> 		total_avail = 0;
>>>> 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
>>>> 	/*
>>>> 	 * Never use more than a fraction of the remaining memory,
>>>> 	 * unless it's the only way to give this client a slot.
>>>> 	 * The chosen fraction is either 1/8 or 1/number of threads,
>>>> 	 * whichever is smaller.  This ensures there are adequate
>>>> 	 * slots to support multiple clients per thread.
>>>> 	 * Give the client one slot even if that would require
>>>> 	 * over-allocation--it is better than failure.
>>>> 	 */
>>>> 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
>>>>
>>>> 	avail = clamp_t(unsigned long, avail, slotsize,
>>>> 			total_avail/scale_factor);
>>>> 	num = min_t(int, num, avail / slotsize);
>>>> 	num = max_t(int, num, 1);
>>>>
>>>> Lets rework it a bit...
>>>> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
>>>> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
>>>> 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
>>>> 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
>>>> 	} else {
>>>> 		total_avail = 0;
>>>> 		avail = 0;
>>>> 		avail = clamp(0, n + sizeof(xxx), 0);
>>>> 	}
>>>>
>>>> Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
>>>> with 'lo <= hi' otherwise the result is dependant on the order of the
>>>> comparisons.
>>>> The compiler sees the second one and rightly bleats.  
>>>
>>> In fact only gcc-9 bleats.
>>
>> That is probably why it didn't get picked up earlier.
>>
>>> gcc-7 gcc-10 gcc-13 gcc-15
>>> all seem to think it is fine.
>>
>> Which, of course, it isn't...
> 
> I've now had a proper look at your analysis of the code - thanks.
> 
> I agree that the code is unclear (at best) and that if it were still
> upstream I would want to fix it.  However is does function correctly.
> 
> As you say, when min > max, the result of clamp(val, min, max) depends
> on the order of comparison, and we know what the order of comparison is
> because we can look at the code for clamp().
> 
> Currently it is 
> 
> 	((val) >= (hi) ? (hi) : ((val) <= (lo) ? (lo) : (val)))
> 
> which will use max when max is below val and min.
> Previously it was 
> 	min((typeof(val))max(val, lo), hi)
> which also will use max when it is below val and min
> 
> Before that it was 
> #define clamp_t(type, val, min, max) ({                \
>        type __val = (val);                     \
>        type __min = (min);                     \
>        type __max = (max);                     \
>        __val = __val < __min ? __min: __val;   \
>        __val > __max ? __max: __val; })
> 
> which also uses max when that is less that val and min.
> 
> So I think the nfsd code has always worked correctly.  That is not
> sufficient for mainline - there we want it to also be robust and
> maintainable. But for stable kernels it should be sufficient.
> Adding a patch to "stable" kernels which causes working code to fail to
> compile does not seem, to me, to be in the spirit of "stability".
> (Have the "clamp" checking in mainline, finding problems there,
> and backporting the fixes to stable seems to me to be the best way
> to use these checking improvements to improve "stable").

I agree with Neil. The LTS code was building and working rather
universally until recently. The less risky approach is to leave this
code unchanged and seek another remedy for the OP.


-- 
Chuck Lever

