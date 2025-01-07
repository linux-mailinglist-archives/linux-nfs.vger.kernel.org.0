Return-Path: <linux-nfs+bounces-8959-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB2BA04B6F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63BCE3A4AB2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28971F708C;
	Tue,  7 Jan 2025 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="ikrfl9dm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2861F471C
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 21:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284486; cv=none; b=bI3vHJ+zXRPV1vqEA6Mrd56fAUsEQv20ORQE0hiOTvQx64OcVoJxUnM2ikgj7mKHwkaJcK5RSup6wMVlZrgKSYZI7syq5M11CeZ+UUup1qRx79yPWCUDlIhU6tsuwhbSqSNupeXn999vVIPB+bM9QKRZqrqq21Q+aiOq7ysTO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284486; c=relaxed/simple;
	bh=9/xSQ2zC05FlS/28M4eEqUc3w/Q9QItPn+/pClhbBm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONkeRu524ZB+RWYqVHFJ4GyadTpn19CCsfrO6uTWrNUtMQt/u7GQPYpNwUP8NeOA7CqtOWLe8uhM1h/wsj6veAeZ3xoBORLGT/w7JWNP9h9L9JsNUbZqrqneZ0oCcDEg/eEgWHRsJORb1t+oM0pY4TH3Xn6h1PbUPsASILx/QjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=ikrfl9dm; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736279640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KAYX1aI2hzwKdsgMiNOaPNb+BYcXBADvrZH3lnq0Qlg=;
	b=ikrfl9dmOq5K37FnnLnOHPhSsYqEw9lqdyM/hQ2wWdqgMCfAGGEbkGAkc2E5Ng+Ww2yxq5
	QQZzl45ekcLiu2Erw4EzNFLusQSJDQvXnceW/bN8B6/FginCar0MJi3M+9JbTcReNGcNr/
	76w6zYD5G+3ll8mXBNjhgEYt8s5EF8qDLcX/pjkgFZMPw2Iky8SrkmtiiGUGenKnAvTYOc
	+lPdAiX3zNla+P+M+imwuXvOX7TXzeVgqZUIHjm/+t6xNT7ZksuzOa3CaXfdO54tn8VmNI
	sP4B9Xt8zALv4J/rRJyLD0V/eUmA2tRw3ja1149ac2ureAnbZv7Jy/6R2t+bag==
Message-ID: <ad8a8180-382e-49fe-a928-504235fc76be@hyub.org>
Date: Tue, 7 Jan 2025 21:14:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Steve Dickson <steved@redhat.com>, neilb@suse.de
Cc: linux-nfs@vger.kernel.org, neilb@suse.de, steved@redhat.com
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
 <3e4f1b57-6d68-4209-9c00-d37bb81b5bc1@hyub.org>
 <38bab9bf-7ccc-46fd-9612-8af229b16eee@redhat.com>
 <f31f0238-18b1-49dc-9e38-4c8fe5642cd5@hyub.org>
 <1d3d62e4-9ded-4d8b-bb24-804be117cd43@redhat.com>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <1d3d62e4-9ded-4d8b-bb24-804be117cd43@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I believe Neil is assuming realpath is called after the entry has been 
concatenated to the rootdir. But this is not the case. realpath is 
called on the exportent path before the concatenation happens. Which is 
a huge flaw.

Steve Dickson wrote:
> 
> 
> On 1/7/25 3:36 PM, Christopher Bii wrote:
>> When I said in this version of the submission I meant the previous one 
>> that I already submitted. I can send it again but I would just be 
>> removing the last commit in the chain. Should I resubmit it that way or?
>>
>> Commit hash with correct fix: 0969665e8e2586179efc9366f7e4506ccc72189c
>> Or 4/5 in the email chain.
> What I'm concerned about is
>    * Neal's concern this is not a problem
>    * When one starts pulling patches out of a
>      patch set... doesn't that invalid the testing
>      that has been done.
> 
> So I would like you to address Neil's concerns and
> post a V2 patch after the patch test is tested
> w/out that patch.
> 
> thanks!
> 
> steved.
> 
>>
>> Thanks
>>
>> Steve Dickson wrote:
>>>
>>>
>>> On 1/7/25 3:08 PM, Christopher Bii wrote:
>>>> Hi Steve,
>>>>
>>>> Thank you for the reply. I made sure to separate the patch on this 
>>>> version of my submission. Patch 4/5 changes no logic, it is only 
>>>> patch 5/5 that changes the failure handling. If you guys would like 
>>>> to test that patch independently, I believe it will do the trick.
>>> Good ahead and make a V2 of the patch set so we can review it.
>>>
>>> thanks!
>>>
>>> steved.
>>>>
>>>> Thanks,
>>>> Christopher Bii
>>>>
>>>> Steve Dickson wrote:
>>>>> Hello,
>>>>>
>>>>> On 12/6/24 5:11 PM, Christopher Bii wrote:
>>>>>> Hello,
>>>>>>
>>>>>> It is hinted in the configuration files that an attacker could 
>>>>>> gain access
>>>>>> to arbitrary folders by guessing symlink paths that match exported 
>>>>>> dirs,
>>>>>> but this is not the case. They can get access to the root export with
>>>>>> certainty by simply symlinking to "../../../../../../../", which will
>>>>>> always return "/".
>>>>>>
>>>>>> This is due to realpath() being called in the main thread which isn't
>>>>>> chrooted, concatenating the result with the export root to create the
>>>>>> export entry's final absolute path which the kernel then exports.
>>>>>>
>>>>>> PS: I already sent this patch to the mailing list about the same 
>>>>>> subject
>>>>>> but it was poorly formatted. Changes were merged into a single 
>>>>>> commit. I
>>>>>> have broken it up into smaller commits and made the patch into a 
>>>>>> single
>>>>>> thread. Pardon the mistake, first contribution.
>>>>> First of all thank you this contribution... but :-)
>>>>> the patch makes an assumption that is incorrect.
>>>>> An export directory has to exist when exported.
>>>>>
>>>>> The point being... even though the export does not
>>>>> exist when exported... it can in the future due
>>>>> to mounting races. This is a change NeilBrown
>>>>> made a few years back...
>>>>>
>>>>> Which means the following fails which does not
>>>>> with the original code
>>>>>
>>>>> exportfs -ua
>>>>> exportfs -vi *:/not_exist
>>>>> exportfs: Failed to stat /not_exist: No such file or directory
>>>>> (which is a warning, not an error meaning /not_exist is still 
>>>>> exported)
>>>>>
>>>>> With these patches this valid export fails
>>>>> exportfs -vi *:/export_test fails with
>>>>> exportfs: nfsd_realpath(): unable to resolve path /not_exist
>>>>>
>>>>> because /not_exist is exported (aka in /var/lib/nfs/etab)
>>>>> so the failure is not correct because /not_exist could
>>>>> exist in the future.
>>>>>
>>>>> Thank you Yongcheng Yang for this test which points
>>>>> out the problem.
>>>>>
>>>>> Here is part of the patch that needs work
>>>>> in getexportent:
>>>>>
>>>>>       /* resolve symlinks */
>>>>> -    if (realpath(ee.e_path, rpath) != NULL) {
>>>>> -        rpath[sizeof (rpath) - 1] = '\0';
>>>>> -        strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
>>>>> -        ee.e_path[sizeof (ee.e_path) - 1] = '\0';
>>>>> -    }
>>>>> +    if (nfsd_realpath(ee.e_path, rpath) == NULL) {
>>>>> +                xlog(L_ERROR, "nfsd_realpath(): unable to resolve 
>>>>> path %s", ee.e_path);
>>>>> +                goto out;
>>>>> +        };
>>>>>
>>>>> the current code ignores the realpath() failure... your patch does 
>>>>> not.
>>>>>
>>>>>
>>>>> I would like to fix the symlink vulnerability you have pointed
>>>>> out... but stay with the assumptions of the original code.
>>>>> I'll be more than willing to work with you to make this happen!
>>>>>
>>>>> steved.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Christopher Bii (5):
>>>>>>    nfsd_path.h - nfsd_path.c: - Configured export rootdir must now 
>>>>>> be an
>>>>>>      absolute path - Rootdir is into a global variable what will 
>>>>>> also be
>>>>>>      used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
>>>>>>      simplified with nfsd_path_rootdir   which returns the global var
>>>>>>      rather than reprobing config for rootdir   entry
>>>>>>    nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
>>>>>>    nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, 
>>>>>> const
>>>>>>      char*) -> nfsd_path_prepend_root(const char*)
>>>>>>    NFS export symlink vulnerability fix - Replaced dangerous use of
>>>>>>      realpath within support/nfs/export.c with   nfsd_realpath 
>>>>>> variant
>>>>>>      that is executed within the chrooted thread   rather than main
>>>>>>      thread. - Implemented nfsd_path.h methods to work securely 
>>>>>> within
>>>>>>      chrooted thread   using nfsd_run_task() helper
>>>>>>    support/nfs/exports.c - Small changes
>>>>>>
>>>>>>   support/export/export.c     |  17 +-
>>>>>>   support/include/nfsd_path.h |   9 +-
>>>>>>   support/misc/nfsd_path.c    | 362 +++++++++++ 
>>>>>> +------------------------
>>>>>>   support/nfs/exports.c       |  49 ++---
>>>>>>   4 files changed, 151 insertions(+), 286 deletions(-)
>>>>>>
>>>>>
>>>>
>>>
>>>
>>
> 


