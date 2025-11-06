Return-Path: <linux-nfs+bounces-16154-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F20C3D407
	for <lists+linux-nfs@lfdr.de>; Thu, 06 Nov 2025 20:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C8E3B3211
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Nov 2025 19:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1512D8798;
	Thu,  6 Nov 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyAtUapj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBF32192EE;
	Thu,  6 Nov 2025 19:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457556; cv=none; b=L0W7xB9G9HPloko5LGrmjjsUv623ClzZK7TPe9/SoPfWoNGaDgagSIRfMJEEJOI/I6v2RW4vKEtcnumT9ICNmoUQckDj4mbOXy0Wez3N7FU0balz9MfhVsad1Q6U7Q+CCCC00Zwpm8M9pvKsfxpiSu5HjapdkRk1C4piixj2P50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457556; c=relaxed/simple;
	bh=wihSTnkFXhy5/fis4z4HZGvN91Ktb4fLONbT7S8xWpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i1Ag5/IlfW+Li5S32NrtnSa+WQT7GICxgsCHeF9jUshC/H02wwpXG9zL0muHhQuYicXWY+j4U6pY9pHYfN0xXkqMxFOfliYkS+epIRA6XQIwyq7CSemN1X1Npv4eUWjr8XK9gpo9o48HjJtSQNMopajnoRcC5LvNl9tgRdq/YIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyAtUapj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A77C116B1;
	Thu,  6 Nov 2025 19:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762457556;
	bh=wihSTnkFXhy5/fis4z4HZGvN91Ktb4fLONbT7S8xWpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OyAtUapjtDpyKFoDldaMJa+VnyboN2vy6fCqEDoy+3nWV13qJej4AVLFxuvU6/1BR
	 04oC11JrryRpjtiol5Gs3KG3uELtZMPOHSsKHVIgVxBFBP+hZTR8nnAhg4d7ej/yTC
	 LkZtEuyjfJA4EfzZx98rcAW23h6A7T2f8RiVVuXh15w4t8lVi3Bno93iGw3pe6Gp6e
	 ePa4/tvq7lDzRi00FD39hWH1qIrudnAZXo7v2FGFn+AogjuKW+k1Dy9hPThTxgd7Sh
	 ykE95u1AfnsJmFCBPFO0br2OJhAOBB9Y8+FPtwq23baxusCKIGZyaUcuGNfbXnTUZx
	 h0SZjegJMEIxw==
Message-ID: <8cf5dc85-dee8-4e83-8f83-6b3411dddbee@kernel.org>
Date: Thu, 6 Nov 2025 14:32:34 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit slotsize
 greater than high limit total_avail/scale_factor
To: David Laight <david.laight.linux@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Laight <David.Laight@ACULAB.COM>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 speedcracker@hotmail.com
References: <bbba88825d7b2b06031c1b085d76787a2502d70e.camel@kernel.org>
 <37bc1037-37d8-4168-afc9-da8e2d1dd26b@kernel.org>
 <20251106192210.1b6a3ca0@pumpkin>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <20251106192210.1b6a3ca0@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/25 2:22 PM, David Laight wrote:
> On Thu, 6 Nov 2025 09:33:28 -0500
> Chuck Lever <cel@kernel.org> wrote:
> 
>> FYI
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=220745
> 
> Ugg - that code is horrid.
> It seems to have got deleted since, but it is:
> 
> 	u32 slotsize = slot_bytes(ca);
> 	u32 num = ca->maxreqs;
> 	unsigned long avail, total_avail;
> 	unsigned int scale_factor;
> 
> 	spin_lock(&nfsd_drc_lock);
> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> 	else
> 		/* We have handed out more space than we chose in
> 		 * set_max_drc() to allow.  That isn't really a
> 		 * problem as long as that doesn't make us think we
> 		 * have lots more due to integer overflow.
> 		 */
> 		total_avail = 0;
> 	avail = min((unsigned long)NFSD_MAX_MEM_PER_SESSION, total_avail);
> 	/*
> 	 * Never use more than a fraction of the remaining memory,
> 	 * unless it's the only way to give this client a slot.
> 	 * The chosen fraction is either 1/8 or 1/number of threads,
> 	 * whichever is smaller.  This ensures there are adequate
> 	 * slots to support multiple clients per thread.
> 	 * Give the client one slot even if that would require
> 	 * over-allocation--it is better than failure.
> 	 */
> 	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
> 
> 	avail = clamp_t(unsigned long, avail, slotsize,
> 			total_avail/scale_factor);
> 	num = min_t(int, num, avail / slotsize);
> 	num = max_t(int, num, 1);
> 
> Lets rework it a bit...
> 	if (nfsd_drc_max_mem > nfsd_drc_mem_used) {
> 		total_avail = nfsd_drc_max_mem - nfsd_drc_mem_used;
> 		avail = min(NFSD_MAX_MEM_PER_SESSION, total_avail);
> 		avail = clamp(avail, n + sizeof(xxx), total_avail/8)
> 	} else {
> 		total_avail = 0;
> 		avail = 0;
> 		avail = clamp(0, n + sizeof(xxx), 0);
> 	}
> 
> Neither of those clamp() are sane at all - should be clamp(val, lo, hi)
> with 'lo <= hi' otherwise the result is dependant on the order of the
> comparisons.
> The compiler sees the second one and rightly bleats.
> I can't even guess what the code is actually trying to calculate!
> 
> Maybe looking at where the code came from, or the current version might help.

The current upstream code is part of a new feature that is not
appropriate to backport to LTS kernels. I consider that code out of
play.

The compiler error showed up in 6.1.y with the recent minmax.h
changes -- there have been no reported problems in any of the LTS
kernels until now, including with 32-bit builds.

The usual guidelines about regressions suggest that the most recent
backports (ie, minmax.h) are the ones that should be removed or reworked
to address the compile breakage. I don't think we should address this by
writing special clean-ups to code that wasn't broken before the minmax.h
changes. Cleaning that code up is more likely to introduce bugs than
reverting the minmax.h changes.


> It MIGHT be that the 'lo' of slotsize was an attempt to ensure that
> the following 'avail / slotsize' was as least one.
> Some software archaeology might show that the 'num = max(num, 1)' was added
> because the code above didn't work.
> In that case the clamp can be clamp(avail, 0, total_avail/scale_factor)
> which is just min(avail, total_avail/scale_factor).
> 
> The person who rewrote it between 6.1 and 6.18 might now more.
> 
> 	David
> 	
>>
>>
>> -------- Forwarded Message --------
>> Subject: Re: Compile Error fs/nfsd/nfs4state.o - clamp() low limit
>> slotsize greater than high limit total_avail/scale_factor
>> Date: Thu, 06 Nov 2025 07:29:25 -0500
>> From: Jeff Layton <jlayton@kernel.org>
>> To: Mike-SPC via Bugspray Bot <bugbot@kernel.org>, cel@kernel.org,
>> neilb@ownmail.net, trondmy@kernel.org, linux-nfs@vger.kernel.org,
>> anna@kernel.org, neilb@brown.name
>>
>> On Thu, 2025-11-06 at 11:30 +0000, Mike-SPC via Bugspray Bot wrote:
>>> Mike-SPC writes via Kernel.org Bugzilla:
>>>
>>> (In reply to Bugspray Bot from comment #5)  
>>>> Chuck Lever <cel@kernel.org> replies to comment #4:
>>>>
>>>> On 11/5/25 7:25 AM, Mike-SPC via Bugspray Bot wrote:  
>>>>> Mike-SPC writes via Kernel.org Bugzilla:
>>>>>   
>>>>>> Have you found a 6.1.y kernel for which the build doesn't fail?  
>>>>>
>>>>> Yes. Compiling Version 6.1.155 works without problems.
>>>>> Versions >= 6.1.156 aren't.  
>>>>
>>>> My analysis yesterday suggests that, because the nfs4state.c code hasn't
>>>> changed, it's probably something elsewhere that introduced this problem.
>>>> As we can't reproduce the issue, can you use "git bisect" between
>>>> v6.1.155 and v6.1.156 to find the culprit commit?
>>>>
>>>> (via https://msgid.link/ab235dbe-7949-4208-a21a-2cdd50347152@kernel.org)  
>>>
>>>
>>> Yes, your analysis is right (thanks for it).
>>> After some investigation, the issue appears to be caused by changes introduced in
>>> include/linux/minmax.h.
>>>
>>> I verified this by replacing minmax.h in 6.1.156 with the version from 6.1.155,
>>> and the kernel then compiles successfully.
>>>
>>> The relevant section in the 6.1.156 changelog (https://cdn.kernel.org/pub/linux/kernel/v6.x/ChangeLog-6.1.156) shows several modifications to minmax.h (notably around __clamp_once() and the use of
>>> BUILD_BUG_ON_MSG(statically_true(ulo > uhi), ...)), which seem to trigger a compile-time assertion when building NFSD.
>>>
>>> Replacing the updated header with the previous one resolves the issue, so this appears
>>> to be a regression introduced by the new clamp() logic.
>>>
>>> Could you please advise who is the right person or mailing list to report this issue to
>>> (minmax.h maintainers, kernel core, or stable tree)?
>>>   
>>
>> I'd let all 3 know, and I'd include the author of the patches that you
>> suspect are the problem. They'll probably want to revise the one that's
>> a problem.
>>
>> Cheers,
> 


-- 
Chuck Lever

