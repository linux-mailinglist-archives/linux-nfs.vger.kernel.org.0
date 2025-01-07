Return-Path: <linux-nfs+bounces-8956-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18798A04B0A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EB23A472F
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 20:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C891DF99B;
	Tue,  7 Jan 2025 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b="t5XT2lrH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from hyub.org (hyub.org [45.33.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8748819C566
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.94.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282192; cv=none; b=nQtbdegWYyhMKvz81HBSbfdXbHcplVcNxhdsgV8YCwSfq7c/5hL+6w0EdDJvHYWSZmuHMkurPJpX/i2x9v5Ir30deLUqdpJTnjfKxCKVNxyPNf1PNWyo9R0MhMtmXGbOUl5+UQ0rIGWUD49kNq+JSoqZpKmHpmii8Tr2woWDpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282192; c=relaxed/simple;
	bh=VqRMKscBZ1fLlXzReiedvE390HtlphaiNEW10jtAATs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZsgB4lXzC+WZ4+w6aZMAf3P2SRvNFzi9t66a1951Xr3RkjVGSAhjyBk6exN2i0GHyr0IdmKEeWU33vxHb3BOGZ2ucH0MgqG0FJwHhJmwP04MJJnotTU7AD0E3DPH40PawZLdnA7BnHsL3Hg+G1e4Ne6RlzgnmbAaXNpk/pPQG6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org; spf=pass smtp.mailfrom=hyub.org; dkim=pass (2048-bit key) header.d=hyub.org header.i=@hyub.org header.b=t5XT2lrH; arc=none smtp.client-ip=45.33.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hyub.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hyub.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hyub.org; s=dkim;
	t=1736277346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tidZ1DBvYCATkGd77GJOkRuj0guqfrgu6uNToFZFOzQ=;
	b=t5XT2lrH/u6w10m2SSjeIC+Xiuo8VIna5rv3etSCbLGlRgmSjn1R/svbqdW1rluEezfolM
	etcFo6M5r1AfZT9stJIzPal/jH19llF2KJ27MYUcmp3vVW1fjFIJ5V+VkNLXaCYMjinJDv
	AgALY5krbS/g3a0R/q7JnziFUxU3YT5FzUFTVj3sMuKIsT5folqzh6smW6CHXIW8TZDDP9
	P/Z6IjeNay3osCDigd+GOdxfRzseXf5cOoc/vALFFAH51+kjnWjuQ5tRJy/iHcqRaZh83I
	L5SG9XcFBItpyvpbtqzawaev4SM0VSw4Mi4I5F6kZuXRFf1t0JRZkxz1qUJ0cw==
Message-ID: <f31f0238-18b1-49dc-9e38-4c8fe5642cd5@hyub.org>
Date: Tue, 7 Jan 2025 20:36:00 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org, neilb@suse.de
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
 <3e4f1b57-6d68-4209-9c00-d37bb81b5bc1@hyub.org>
 <38bab9bf-7ccc-46fd-9612-8af229b16eee@redhat.com>
From: Christopher Bii <christopherbii@hyub.org>
In-Reply-To: <38bab9bf-7ccc-46fd-9612-8af229b16eee@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

When I said in this version of the submission I meant the previous one 
that I already submitted. I can send it again but I would just be 
removing the last commit in the chain. Should I resubmit it that way or?

Commit hash with correct fix: 0969665e8e2586179efc9366f7e4506ccc72189c
Or 4/5 in the email chain.

Thanks

Steve Dickson wrote:
> 
> 
> On 1/7/25 3:08 PM, Christopher Bii wrote:
>> Hi Steve,
>>
>> Thank you for the reply. I made sure to separate the patch on this 
>> version of my submission. Patch 4/5 changes no logic, it is only patch 
>> 5/5 that changes the failure handling. If you guys would like to test 
>> that patch independently, I believe it will do the trick.
> Good ahead and make a V2 of the patch set so we can review it.
> 
> thanks!
> 
> steved.
>>
>> Thanks,
>> Christopher Bii
>>
>> Steve Dickson wrote:
>>> Hello,
>>>
>>> On 12/6/24 5:11 PM, Christopher Bii wrote:
>>>> Hello,
>>>>
>>>> It is hinted in the configuration files that an attacker could gain 
>>>> access
>>>> to arbitrary folders by guessing symlink paths that match exported 
>>>> dirs,
>>>> but this is not the case. They can get access to the root export with
>>>> certainty by simply symlinking to "../../../../../../../", which will
>>>> always return "/".
>>>>
>>>> This is due to realpath() being called in the main thread which isn't
>>>> chrooted, concatenating the result with the export root to create the
>>>> export entry's final absolute path which the kernel then exports.
>>>>
>>>> PS: I already sent this patch to the mailing list about the same 
>>>> subject
>>>> but it was poorly formatted. Changes were merged into a single 
>>>> commit. I
>>>> have broken it up into smaller commits and made the patch into a single
>>>> thread. Pardon the mistake, first contribution.
>>> First of all thank you this contribution... but :-)
>>> the patch makes an assumption that is incorrect.
>>> An export directory has to exist when exported.
>>>
>>> The point being... even though the export does not
>>> exist when exported... it can in the future due
>>> to mounting races. This is a change NeilBrown
>>> made a few years back...
>>>
>>> Which means the following fails which does not
>>> with the original code
>>>
>>> exportfs -ua
>>> exportfs -vi *:/not_exist
>>> exportfs: Failed to stat /not_exist: No such file or directory
>>> (which is a warning, not an error meaning /not_exist is still exported)
>>>
>>> With these patches this valid export fails
>>> exportfs -vi *:/export_test fails with
>>> exportfs: nfsd_realpath(): unable to resolve path /not_exist
>>>
>>> because /not_exist is exported (aka in /var/lib/nfs/etab)
>>> so the failure is not correct because /not_exist could
>>> exist in the future.
>>>
>>> Thank you Yongcheng Yang for this test which points
>>> out the problem.
>>>
>>> Here is part of the patch that needs work
>>> in getexportent:
>>>
>>>       /* resolve symlinks */
>>> -    if (realpath(ee.e_path, rpath) != NULL) {
>>> -        rpath[sizeof (rpath) - 1] = '\0';
>>> -        strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
>>> -        ee.e_path[sizeof (ee.e_path) - 1] = '\0';
>>> -    }
>>> +    if (nfsd_realpath(ee.e_path, rpath) == NULL) {
>>> +                xlog(L_ERROR, "nfsd_realpath(): unable to resolve 
>>> path %s", ee.e_path);
>>> +                goto out;
>>> +        };
>>>
>>> the current code ignores the realpath() failure... your patch does not.
>>>
>>>
>>> I would like to fix the symlink vulnerability you have pointed
>>> out... but stay with the assumptions of the original code.
>>> I'll be more than willing to work with you to make this happen!
>>>
>>> steved.
>>>>
>>>> Thanks
>>>>
>>>> Christopher Bii (5):
>>>>    nfsd_path.h - nfsd_path.c: - Configured export rootdir must now 
>>>> be an
>>>>      absolute path - Rootdir is into a global variable what will 
>>>> also be
>>>>      used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
>>>>      simplified with nfsd_path_rootdir   which returns the global var
>>>>      rather than reprobing config for rootdir   entry
>>>>    nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
>>>>    nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, 
>>>> const
>>>>      char*) -> nfsd_path_prepend_root(const char*)
>>>>    NFS export symlink vulnerability fix - Replaced dangerous use of
>>>>      realpath within support/nfs/export.c with   nfsd_realpath variant
>>>>      that is executed within the chrooted thread   rather than main
>>>>      thread. - Implemented nfsd_path.h methods to work securely within
>>>>      chrooted thread   using nfsd_run_task() helper
>>>>    support/nfs/exports.c - Small changes
>>>>
>>>>   support/export/export.c     |  17 +-
>>>>   support/include/nfsd_path.h |   9 +-
>>>>   support/misc/nfsd_path.c    | 362 +++++++++++ 
>>>> +------------------------
>>>>   support/nfs/exports.c       |  49 ++---
>>>>   4 files changed, 151 insertions(+), 286 deletions(-)
>>>>
>>>
>>
> 
> 


