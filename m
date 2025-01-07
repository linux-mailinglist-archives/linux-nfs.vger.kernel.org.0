Return-Path: <linux-nfs+bounces-8954-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24BC3A04AC6
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12F887A1764
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 20:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFEA18A6B5;
	Tue,  7 Jan 2025 20:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlxzNAHW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFFE12B93
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736280981; cv=none; b=OXRPz6wTTschFIKOkP7oHjh9AR9/pWCGU//5ujyihP5b347EWxGZNYy28I+r2s4N6UU+y/hftZDl0eCYDOWY5dESWAqjEO51Z+S8WAtxiiw/nv4pGlL4RsYPyzo43Vh3V8egP9sfpWbTTrxHHFRlwxvC+Fu6u8rSiSE1z6fpsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736280981; c=relaxed/simple;
	bh=xnHCHb4s+BFKKXBfF4vpZOYqgQ8MS60A6LNyLrk3KVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GI43WHDAt8P/yUFs9hAp0rssn1yNhmu3e/jrJdC5MyVeJrtxFU37PkD8QP/2au1LXIh4oFvg1wJtlCIQPbak+epmnrpaAyMGiR6KWmZlevLfjToJkeUN1NBsGClnK399wjCHoeKsIqPzGoWy9sx+/YYBqP/57qQ+2wYwlLsRiRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlxzNAHW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736280978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcwu2spZSqoU1LFIs60/bJwj02r+ug+2zjcaqpgHQEI=;
	b=TlxzNAHWr4drDThYRhEC6JPZlysYjK1wvkOPiEoN/9IH3m2/h7XrgED727iRjFG0KRNaup
	bUNuzdxdxeJ/Om2CocsoF0yTUfKUP33ysOFU7VnlKYsD7LZduR2H25BxIRJiStCn66YcAb
	cmYvB2m3pa2qfxoVqpv4rZckRs2D+io=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-zO0UY56uPFCUWqDq7cK6KA-1; Tue, 07 Jan 2025 15:16:17 -0500
X-MC-Unique: zO0UY56uPFCUWqDq7cK6KA-1
X-Mimecast-MFC-AGG-ID: zO0UY56uPFCUWqDq7cK6KA
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b6eabd51cfso2538278785a.0
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jan 2025 12:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736280976; x=1736885776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bcwu2spZSqoU1LFIs60/bJwj02r+ug+2zjcaqpgHQEI=;
        b=EY/ymFfNqS3jrcGg0m0msZ58l57sSo6RnghZgdfsa+0ba6Qqfa/6+aDYNFFEZJrdC6
         QIy/EAGYVu8iUOu0e5m+Z49Fp91d1GcbeCQNAyoQmHOuoL4GuwC3ALI80H5vNY2u4HFM
         LHKldYxyGbngcTdMX15FLeqtmUkva1pW23wkFppaeGuyUfla4n+N5gfybrbcOIgaxAHD
         P3aPeZpkGSoZPK2QOoN7TWm1J4ExIhZ4Rpufvw2Kxse0Uu4oARM3CZ5A0N5hoIKdwkco
         crPdmNAK8IlcXoexfpywy0OM1qx17O3Quj9DiOlWaVh5zEzgqUg7NsLc1BGggxHWxeSZ
         2Few==
X-Gm-Message-State: AOJu0YzcJGK0XLFNEjw5NeOiEhDm1i6395hEjKk45DSFaWyDoJfUmcOd
	ptUo0+VEuMx3ag+PpKr6MtadIVNHDxYyqiarxdaWwJdj/njrSAQ6SMekFkPFBlSn91CFHw1irGt
	4i4270q3rFcYtv2MFebLTXjg6P1DTIotrHmJLH11iO62LMeIOW+1WTOZUVOJCQlWiBQ==
X-Gm-Gg: ASbGncv9EW3WOFLp+JEXdw2fZHFawuXt9VQXq2HmGqZDrlDmFFycSoxCMNz4VXUW2Hz
	2wa8/07bVYoHQlMHs+xGwhf5AIq5S621IBDrzNjJkTtxOIouySFFI0Ia7L8oXyBlbOxBnWPqXRU
	EoisvoQ58dr1O+Q1Imoi9LnWXUK5y+ZuzF2ATO1dITRtbtvLp92rPUrcOiBfOEokgcoX50WQYUh
	Bvill3TXadwei33QiAqPjvMLBKDPh1OMCV28nE+nlDQ+BMbQG09kHLE
X-Received: by 2002:ad4:5c88:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6df9b2d5b97mr7354156d6.36.1736280976063;
        Tue, 07 Jan 2025 12:16:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU8qsl+zc9rqdMo4xa9y372Cap5T2RL4sWWMxqVlyqGTxO87cn+HRol/piOefvPFpnBJRyoA==
X-Received: by 2002:ad4:5c88:0:b0:6d8:a8e1:b57b with SMTP id 6a1803df08f44-6df9b2d5b97mr7352846d6.36.1736280974705;
        Tue, 07 Jan 2025 12:16:14 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd1813857asm182784856d6.56.2025.01.07.12.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 12:16:13 -0800 (PST)
Message-ID: <38bab9bf-7ccc-46fd-9612-8af229b16eee@redhat.com>
Date: Tue, 7 Jan 2025 15:16:12 -0500
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
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <3e4f1b57-6d68-4209-9c00-d37bb81b5bc1@hyub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/7/25 3:08 PM, Christopher Bii wrote:
> Hi Steve,
> 
> Thank you for the reply. I made sure to separate the patch on this 
> version of my submission. Patch 4/5 changes no logic, it is only patch 
> 5/5 that changes the failure handling. If you guys would like to test 
> that patch independently, I believe it will do the trick.
Good ahead and make a V2 of the patch set so we can review it.

thanks!

steved.
> 
> Thanks,
> Christopher Bii
> 
> Steve Dickson wrote:
>> Hello,
>>
>> On 12/6/24 5:11 PM, Christopher Bii wrote:
>>> Hello,
>>>
>>> It is hinted in the configuration files that an attacker could gain 
>>> access
>>> to arbitrary folders by guessing symlink paths that match exported dirs,
>>> but this is not the case. They can get access to the root export with
>>> certainty by simply symlinking to "../../../../../../../", which will
>>> always return "/".
>>>
>>> This is due to realpath() being called in the main thread which isn't
>>> chrooted, concatenating the result with the export root to create the
>>> export entry's final absolute path which the kernel then exports.
>>>
>>> PS: I already sent this patch to the mailing list about the same subject
>>> but it was poorly formatted. Changes were merged into a single commit. I
>>> have broken it up into smaller commits and made the patch into a single
>>> thread. Pardon the mistake, first contribution.
>> First of all thank you this contribution... but :-)
>> the patch makes an assumption that is incorrect.
>> An export directory has to exist when exported.
>>
>> The point being... even though the export does not
>> exist when exported... it can in the future due
>> to mounting races. This is a change NeilBrown
>> made a few years back...
>>
>> Which means the following fails which does not
>> with the original code
>>
>> exportfs -ua
>> exportfs -vi *:/not_exist
>> exportfs: Failed to stat /not_exist: No such file or directory
>> (which is a warning, not an error meaning /not_exist is still exported)
>>
>> With these patches this valid export fails
>> exportfs -vi *:/export_test fails with
>> exportfs: nfsd_realpath(): unable to resolve path /not_exist
>>
>> because /not_exist is exported (aka in /var/lib/nfs/etab)
>> so the failure is not correct because /not_exist could
>> exist in the future.
>>
>> Thank you Yongcheng Yang for this test which points
>> out the problem.
>>
>> Here is part of the patch that needs work
>> in getexportent:
>>
>>       /* resolve symlinks */
>> -    if (realpath(ee.e_path, rpath) != NULL) {
>> -        rpath[sizeof (rpath) - 1] = '\0';
>> -        strncpy(ee.e_path, rpath, sizeof (ee.e_path) - 1);
>> -        ee.e_path[sizeof (ee.e_path) - 1] = '\0';
>> -    }
>> +    if (nfsd_realpath(ee.e_path, rpath) == NULL) {
>> +                xlog(L_ERROR, "nfsd_realpath(): unable to resolve 
>> path %s", ee.e_path);
>> +                goto out;
>> +        };
>>
>> the current code ignores the realpath() failure... your patch does not.
>>
>>
>> I would like to fix the symlink vulnerability you have pointed
>> out... but stay with the assumptions of the original code.
>> I'll be more than willing to work with you to make this happen!
>>
>> steved.
>>>
>>> Thanks
>>>
>>> Christopher Bii (5):
>>>    nfsd_path.h - nfsd_path.c: - Configured export rootdir must now be an
>>>      absolute path - Rootdir is into a global variable what will also be
>>>      used to retrieve   it later on - nfsd_path_nfsd_rootdir(void) is
>>>      simplified with nfsd_path_rootdir   which returns the global var
>>>      rather than reprobing config for rootdir   entry
>>>    nfsd_path.c: - Simplification of nfsd_path_strip_root(char*)
>>>    nfsd_path.h - nfsd_path.c: - nfsd_path_prepend_dir(const char*, const
>>>      char*) -> nfsd_path_prepend_root(const char*)
>>>    NFS export symlink vulnerability fix - Replaced dangerous use of
>>>      realpath within support/nfs/export.c with   nfsd_realpath variant
>>>      that is executed within the chrooted thread   rather than main
>>>      thread. - Implemented nfsd_path.h methods to work securely within
>>>      chrooted thread   using nfsd_run_task() helper
>>>    support/nfs/exports.c - Small changes
>>>
>>>   support/export/export.c     |  17 +-
>>>   support/include/nfsd_path.h |   9 +-
>>>   support/misc/nfsd_path.c    | 362 ++++++++++++------------------------
>>>   support/nfs/exports.c       |  49 ++---
>>>   4 files changed, 151 insertions(+), 286 deletions(-)
>>>
>>
> 


