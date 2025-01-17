Return-Path: <linux-nfs+bounces-9342-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63998A152DE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 16:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC5443A95FF
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 15:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9939418784A;
	Fri, 17 Jan 2025 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GR6LbE6r"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B44189F3F
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737127737; cv=none; b=ji1hzB/3eyAIDEV/MgU0YQjXAOq2AGUdI078zSGGe+Ov2PHaIoZ+fkn/8SX/UtCe8rKDP5HJoA93C2sGQyKaOyzFBV6ne7ldSjjjwd3bXlyYv6bvU6thIJoRCIULVfNcPJUG1srzKVTPrWzL4acRsODBiKsijfEW4ezBDFFcTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737127737; c=relaxed/simple;
	bh=WsrrcTq4XMkrK9FSS16dXn9C63pdgklJYCuQr4YiNa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d7QOzreNiTBpM96+HMo4mpDKQIQg2PMefmqw/kHeeENFQGajGDe9ghuXQWzq7qbGeK4WDcmiI4ToO7vDfvrvfQM2an4OwFZQOLdAPDuWklJp3ZWMbKORyJRRlQwCCUNXknF7tbQW97ZO0uUvzLNcD4NS6jM4Sxim5+4E5IC8z0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GR6LbE6r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737127734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57dslpuOjBVpRX6bN/0VuVY/222mpppFXPogBJ94/SM=;
	b=GR6LbE6rNGZwpAv6oBSfVzUdbVG+4c7Do7nnDyOrNi0Xz9ACv+b6rgnypummBsg8ar6SmB
	jPMpX0aZlp1Yp66/5AnzA6hdjY4KDzs51yMsButdBSv081UYn9ByD4y1vsWmO0u5INMX10
	iwRd/g+5FM6dFE+39qwtTX3HF5BJvrk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-ei0uicEGOwG15PR-mfy_PA-1; Fri, 17 Jan 2025 10:28:53 -0500
X-MC-Unique: ei0uicEGOwG15PR-mfy_PA-1
X-Mimecast-MFC-AGG-ID: ei0uicEGOwG15PR-mfy_PA
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2162f80040aso40461055ad.1
        for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 07:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737127732; x=1737732532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57dslpuOjBVpRX6bN/0VuVY/222mpppFXPogBJ94/SM=;
        b=N00bqEoPC8Dtpd6SBb5saHPHV6iavljjZt4WWfKQMqpWVI/E08Aq+lQrlMAf3Ih4Kh
         w0Pf4FZ02uDq4+F6LaTHPIn78RrFWus6Sm+b35ZD3DVK0xA12IY1VKOpbLfazgdUuLhm
         b9/PCujYuEyFoewdAZbK+FkA9ek7BM02o2qnKKDCk1cIQLmvCgmemmVZrOLnLABfHlto
         9mGG9Tnhw9Ubtdnr3WEjbyNT/CUhpJ6Nvf0sKxhvCzTGuL7zjq1F1YwafAlRovx1z1SJ
         vJyxreRdH0bKQmbr/c5v5fUZnfzAZ0gk3mWoiPHjsx07inaiWUAKY1nBUIg1SkBQoJiq
         9zPA==
X-Gm-Message-State: AOJu0Yyn2Y8iTSAxA62kE2UQ/RVCZLdaBLgGBLlQHqcSe4q9kBBDjHBQ
	gLM1JwAMXdigxcdGl9nIfrzg+w7ui57VYc4KVHAl5v4efvH0OOpNPfPVS8IC8fczfd6wta8QnPj
	uqq44N36c9pnH9+1F/CwNnMEtCkq4WZkiFL5xIy2y+a8xDcwyGleDs8DE/A==
X-Gm-Gg: ASbGnctgyrfvZwmLuOoyjklg2roOePu8n+zDtahxHvEJypOe6eqodMCHul4tki6yTzr
	XhQha2lKx5x03wjG45ILLZ2F9cYbdvJeythhiaRy8yVTx1NG2NqTaBl9CW6cCGUJbPZ8yGWv5KV
	cf6yJgUN2Av6eQ0jm/MirvGVdhjSp27q4woPSWcCl7jvX7FIYE2BTrTNqk1MdlKSc6Qa90867SH
	X+XtTb65oTiaSAoPSDeoQ4jQ8JPbz662C/dfyKt+Be+eQNPrhCXkkRU
X-Received: by 2002:a17:902:e743:b0:215:a039:738 with SMTP id d9443c01a7336-21c352de481mr55139135ad.5.1737127732438;
        Fri, 17 Jan 2025 07:28:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV9PVmi/oDcVxZXN9PRaP2MU17fEHsuLFWwWyee3iQiauSiTnSRX/fF1h3aM8+jY0IdfX+2Q==
X-Received: by 2002:a17:902:e743:b0:215:a039:738 with SMTP id d9443c01a7336-21c352de481mr55138595ad.5.1737127732029;
        Fri, 17 Jan 2025 07:28:52 -0800 (PST)
Received: from [172.31.1.150] ([70.109.132.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3e8081sm17376515ad.185.2025.01.17.07.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 07:28:51 -0800 (PST)
Message-ID: <07ff2558-6d9f-4b3a-9845-4c4e4d48fbb8@redhat.com>
Date: Fri, 17 Jan 2025 10:28:49 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] nfs export symlink vulnerability fix (duplicate(ish))
To: Christopher Bii <christopherbii@hyub.org>
Cc: linux-nfs@vger.kernel.org, Yongcheng Yang <yongcheng.yang@gmail.com>,
 Neil Brown <neilb@suse.de>
References: <20241206221202.31507-1-christopherbii@hyub.org>
 <987a603b-bbe5-488e-8f00-947c79bc3685@redhat.com>
 <2305be45-74e4-4a34-a8d3-1dc6b8cae103@hyub.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <2305be45-74e4-4a34-a8d3-1dc6b8cae103@hyub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/8/25 1:25 PM, Christopher Bii wrote:
> Hello Steve,
> 
> I would like to bring into question the reason why the failure case is 
> ignored in the current implementation. Whenever a rootdir is set,
> realpath would previously fail if the path didn't exist. So ignoring it
> indeed made sense, as a blanket solution.
> 
> But was pre-exporting really a feature? I find the risks to greatly
> outweigh the benefits. Should a non-existant dir be pre-exported,
> someone could, maliciously or accidentally, symlink to any arbitrary
> directory on the fly without warning, possibly compromising the system.
> 
> I think this should be reconsidered as there is no longer functionality
> requiring us to ignore the failure of export path resolution via
> realpath.
I have... the latest patch seems to work as expected... thanks!

steved.

> 
> Thank you,
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


