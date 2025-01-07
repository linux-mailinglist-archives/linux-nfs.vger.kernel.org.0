Return-Path: <linux-nfs+bounces-8957-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FDDA04B57
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC63A1459
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F3718E02A;
	Tue,  7 Jan 2025 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XdNqxUrZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0818C035
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736283867; cv=none; b=SbpzfOoHdhXE9uUt4cFgRk9HT5iDJxpwaKMaKJjB0Hbamr+ZIwhr36ikbAnuctEvIUOHTb2C4ZrTjy+3wNSufUvkZhhg5wn18FHjswqthFghyBgMzglJ5hc7EaglS8IbIqUkwKo6B3LoCBE7MpdPbrDA9pDplZIFetTG5domRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736283867; c=relaxed/simple;
	bh=BDgbZkNFJebu88Ffdo+BpkfCFy8uUskMuDF9Nk+v6oY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VADkK3M+g7LYNhKkOLGTZOm8Zl3WDzmxlrwrGIsL+PXBqvBV9d+22SCrc1Er68Ggyyi6amx7aJRGxmvmMceIHCmkRoO2vVqaor7qix/fVfJafYSCwHbWzsh+6qGkrbC6jCMFh5JOB4LblVfc3qBWnBm3sOyjnbfFU2mV1Udh9qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XdNqxUrZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736283864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=voDKMLzqUZ4TR5NEr7OMzhF85qAGWHtMdfN862+Pfmc=;
	b=XdNqxUrZACzYknPd/jCjWG1LdStbpF6nNQW4D6WPG/cSFMkgm8b2/DiNHqqBtvh/sKv/Ma
	fXiCwm5xVSubZ1JEaaDO+VAva+Dl4DrsRdjhWaNTlPBG6uCO7ihD9ctKt9Jv8pbBk0FEbF
	hv3ttjvjm6myCJ5O2KCSxvNasvbBWE0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-LxFWQ8QFNwaDw5068ZcQ9Q-1; Tue, 07 Jan 2025 16:04:23 -0500
X-MC-Unique: LxFWQ8QFNwaDw5068ZcQ9Q-1
X-Mimecast-MFC-AGG-ID: LxFWQ8QFNwaDw5068ZcQ9Q
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d88833dffcso215011166d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jan 2025 13:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736283861; x=1736888661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=voDKMLzqUZ4TR5NEr7OMzhF85qAGWHtMdfN862+Pfmc=;
        b=pABmKbncQoaoHs1LqPjuoXc75suoADnxzRPg1hgockqMTp5/NHFrbbtcIn4Vu2+fFa
         TFm58sTCuO8QtOyVQEVaZC8PF2Da0aaDiMLJXWzJJpRK9L4ltRAHhMipuQDPoxgeKE3o
         rDaPHHWFxHcndVMIYYc4CaRPgGRJGHt45gcWG04s1KBpgL7xwkfRHZaFY5LDuugZX6DU
         j8lDzlhga0L8TcVuXEpOkq0YHv1BcAHuyPXfl6PzesKwbHxhcafVD1Wrm5p1v3BLuR6p
         5cggiDHh4x4dgAY5Aqq5ePek0E9GAtmYGGDHb7GNBh9+afDoOpaLrGTHlxOSa0HDIEkt
         0Npg==
X-Gm-Message-State: AOJu0YwVSGHze4goEUGUSgymHoMkfKfCOAmO88W9x58FgNavwNu03z94
	LUyhj3cmw1jp4KRoRA7VdwHop4b4S81eE4dsVJPf0JUBL9Yz307jJPECM+fcUs6H8Qm3E2ABg8d
	uSMhgu1iuDEx71//eTGac+NjIPnDTg0V16VunBCV1jiy/fzwxLwra/0ywIw==
X-Gm-Gg: ASbGncslYGS1f6jQOvQRAFriGVVQxavGZUOgxYbkREB75Yvo665M6sSB+Rqn87AaFnt
	IiVCbMPqWwdmsV28gDlesVf32AglJZnURnK34hpkMGyOoZSWJ5dW+eh/SH0MW6DE7SPlm33hpoN
	yIdkHMkZtQJPDR2JTc9qEVG39TPVYIaA+m5LxyREHPejupuWXovPOFz/nzZLoE7hup7LGiP6e7S
	EfYHCS7thcUPGT1p7KNQDaLOMwa8LkN1TKD0N0s9ks3waBuTVaYRhzA
X-Received: by 2002:a05:6214:3a08:b0:6d8:a1fe:72a2 with SMTP id 6a1803df08f44-6df9b2d62a7mr7810186d6.44.1736283861480;
        Tue, 07 Jan 2025 13:04:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDYLbtzIDpsfUJiKkMBTa2k6KzR2Xe2QRrzQ2SiUbLdUddS/lUnKh7UbbhUL2cuGKcAj/Ykw==
X-Received: by 2002:a05:6214:3a08:b0:6d8:a1fe:72a2 with SMTP id 6a1803df08f44-6df9b2d62a7mr7809736d6.44.1736283861109;
        Tue, 07 Jan 2025 13:04:21 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181c05f7sm184126516d6.90.2025.01.07.13.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 13:04:19 -0800 (PST)
Message-ID: <1d3d62e4-9ded-4d8b-bb24-804be117cd43@redhat.com>
Date: Tue, 7 Jan 2025 16:04:18 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Christopher Bii <christopherbii@hyub.org>
Cc: linux-nfs@vger.kernel.org, neilb@suse.de
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
 <3e4f1b57-6d68-4209-9c00-d37bb81b5bc1@hyub.org>
 <38bab9bf-7ccc-46fd-9612-8af229b16eee@redhat.com>
 <f31f0238-18b1-49dc-9e38-4c8fe5642cd5@hyub.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <f31f0238-18b1-49dc-9e38-4c8fe5642cd5@hyub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/7/25 3:36 PM, Christopher Bii wrote:
> When I said in this version of the submission I meant the previous one 
> that I already submitted. I can send it again but I would just be 
> removing the last commit in the chain. Should I resubmit it that way or?
> 
> Commit hash with correct fix: 0969665e8e2586179efc9366f7e4506ccc72189c
> Or 4/5 in the email chain.
What I'm concerned about is
   * Neal's concern this is not a problem
   * When one starts pulling patches out of a
     patch set... doesn't that invalid the testing
     that has been done.

So I would like you to address Neil's concerns and
post a V2 patch after the patch test is tested
w/out that patch.

thanks!

steved.

> 
> Thanks
> 
> Steve Dickson wrote:
>>
>>
>> On 1/7/25 3:08 PM, Christopher Bii wrote:
>>> Hi Steve,
>>>
>>> Thank you for the reply. I made sure to separate the patch on this 
>>> version of my submission. Patch 4/5 changes no logic, it is only 
>>> patch 5/5 that changes the failure handling. If you guys would like 
>>> to test that patch independently, I believe it will do the trick.
>> Good ahead and make a V2 of the patch set so we can review it.
>>
>> thanks!
>>
>> steved.
>>>
>>> Thanks,
>>> Christopher Bii
>>>
>>> Steve Dickson wrote:
>>>> Hello,
>>>>
>>>> On 12/6/24 5:11 PM, Christopher Bii wrote:
>>>>> Hello,
>>>>>
>>>>> It is hinted in the configuration files that an attacker could gain 
>>>>> access
>>>>> to arbitrary folders by guessing symlink paths that match exported 
>>>>> dirs,
>>>>> but this is not the case. They can get access to the root export with
>>>>> certainty by simply symlinking to "../../../../../../../", which will
>>>>> always return "/".
>>>>>
>>>>> This is due to realpath() being called in the main thread which isn't
>>>>> chrooted, concatenating the result with the export root to create the
>>>>> export entry's final absolute path which the kernel then exports.
>>>>>
>>>>> PS: I already sent this patch to the mailing list about the same 
>>>>> subject
>>>>> but it was poorly formatted. Changes were merged into a single 
>>>>> commit. I
>>>>> have broken it up into smaller commits and made the patch into a 
>>>>> single
>>>>> thread. Pardon the mistake, first contribution.
>>>> First of all thank you this contribution... but :-)
>>>> the patch makes an assumption that is incorrect.
>>>> An export directory has to exist when exported.
>>>>
>>>> The point being... even though the export does not
>>>> exist when exported... it can in the future due
>>>> to mounting races. This is a change NeilBrown
>>>> made a few years back...
>>>>
>>>> Which means the following fails which does not
>>>> with the original code
>>>>
>>>> exportfs -ua
>>>> exportfs -vi *:/not_exist
>>>> exportfs: Failed to stat /not_exist: No such file or directory
>>>> (which is a warning, not an error meaning /not_exist is still exported)
>>>>
>>>> With these patches this valid export fails
>>>> exportfs -vi *:/export_test fails with
>>>> exportfs: nfsd_realpath(): unable to resolve path /not_exist
>>>>
>>>> because /not_exist is exported (aka in /var/lib/nfs/etab)
>>>> so the failure is not correct because /not_exist could
>>>> exist in the future.
>>>>
>>>> Thank you Yongcheng Yang for this test which points
>>>> out the problem.
>>>>
>>>> Here is part of the patch that needs work
>>>> in getexportent:
>>>>
>>>>       /* resolve symlinks */
>>>> -    if (realpath(ee.e_path, rpath) != NULL) {
>>>> -        rpath[sizeof (rpath) - 1] = '\0';
>>>> -        strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
>>>> -        ee.e_path[sizeof (ee.e_path) - 1] = '\0';
>>>> -    }
>>>> +    if (nfsd_realpath(ee.e_path, rpath) == NULL) {
>>>> +                xlog(L_ERROR, "nfsd_realpath(): unable to resolve 
>>>> path %s", ee.e_path);
>>>> +                goto out;
>>>> +        };
>>>>
>>>> the current code ignores the realpath() failure... your patch does not.
>>>>
>>>>
>>>> I would like to fix the symlink vulnerability you have pointed
>>>> out... but stay with the assumptions of the original code.
>>>> I'll be more than willing to work with you to make this happen!
>>>>
>>>> steved.
>>>>>
>>>>> Thanks
>>>>>
>>>>> Christopher Bii (5):
>>>>>    nfsd_path.h - nfsd_path.c: - Configured export rootdir must now 
>>>>> be an
>>>>>      absolute path - Rootdir is into a global variable what will 
>>>>> also be
>>>>>      used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
>>>>>      simplified with nfsd_path_rootdir   which returns the global var
>>>>>      rather than reprobing config for rootdir   entry
>>>>>    nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
>>>>>    nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, 
>>>>> const
>>>>>      char*) -> nfsd_path_prepend_root(const char*)
>>>>>    NFS export symlink vulnerability fix - Replaced dangerous use of
>>>>>      realpath within support/nfs/export.c with   nfsd_realpath variant
>>>>>      that is executed within the chrooted thread   rather than main
>>>>>      thread. - Implemented nfsd_path.h methods to work securely within
>>>>>      chrooted thread   using nfsd_run_task() helper
>>>>>    support/nfs/exports.c - Small changes
>>>>>
>>>>>   support/export/export.c     |  17 +-
>>>>>   support/include/nfsd_path.h |   9 +-
>>>>>   support/misc/nfsd_path.c    | 362 +++++++++++ 
>>>>> +------------------------
>>>>>   support/nfs/exports.c       |  49 ++---
>>>>>   4 files changed, 151 insertions(+), 286 deletions(-)
>>>>>
>>>>
>>>
>>
>>
> 


