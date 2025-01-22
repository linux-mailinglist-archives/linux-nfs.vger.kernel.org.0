Return-Path: <linux-nfs+bounces-9508-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97679A19B45
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 00:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5568C188D5DB
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9CB1C54BF;
	Wed, 22 Jan 2025 23:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/2gKH10"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593C21C4A02
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737586934; cv=none; b=Yj76l0og488RloYEQ9YCt2KxBHUIZjLaeSLApmp0pH8i1541DOAV1XX9a9oC5l0V3/FffjDIs+7cupy0obTc4vX9Ab0YHQQSbbufxHgIj/jEWLCiv1+/rS8/pcKWElnKopzcJTKMhu4mSsHnrsRmhBMaH4GEld3h3JnNBdf9DhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737586934; c=relaxed/simple;
	bh=KaZlTvIPdvtcyiqJTb0H5sNbKS2ijhgp3gfBGSMp+j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXeZjAIh8Wdh99VFZBtuQGukwkBwbab1qMGjaabvBDUFg3LF+BTPf+BVmr97HBjSXiWqnQWmX/y1eJ95grKAXXV+KJQZJVcvm/x9llFKr76ShjOlTQdwT9rjpwjofpv8cpyM6g6bmIEbzW58bbRXRnIerD8kbODlQcXTJBtPrvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/2gKH10; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737586931;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+HSyUlDWACkG+soFDDKY+wDMzodl21lxsUABOOkCKI=;
	b=P/2gKH10IQZlWW1rQ9ycSm89TzJlDZmLMhGORCBXPakcato10QDEaS53BiznePfV0h5NP4
	Guc9a1HHDExK/MGXDaIracj3qLtQVX4GPHg0aViEzTzALDfIa8uSK7oAJ10lrKyq6b2N8z
	zkby98HtFWGQ0737QcKD7bNmIO7kTFw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-N4UcOU6LPUyT6iYDLNOnpQ-1; Wed, 22 Jan 2025 18:02:09 -0500
X-MC-Unique: N4UcOU6LPUyT6iYDLNOnpQ-1
X-Mimecast-MFC-AGG-ID: N4UcOU6LPUyT6iYDLNOnpQ
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7bcdb02f43cso27793085a.3
        for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 15:02:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737586929; x=1738191729;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+HSyUlDWACkG+soFDDKY+wDMzodl21lxsUABOOkCKI=;
        b=CxWEY95ujaoVESP6zFXB36iGv/ix3QpfzUjWsWhDXIN9lK5Z58w2OzGiGa2qbGFZ0Z
         pbCB3sMFTW0ObB7kGS7kpyXKAoYwE94UjUVI+UEJ3HD6R0GPH7xkYLX2Q6Lz9QllgK0r
         xy2LI6aNtMpdXGxmxKXqblTXja04ymHXHuo+fwpMQPbpICT8108JsL313N+ydnveuTxp
         CZNcU1Eb7a9KfMuKI+TGu4Xbn9q55OkMt/lPAIR5nLUAYudfGio3TIduVJeu9W+gwzdL
         20tGmrXtOYrPJdGwFxuymUbfw5NZd/pzKZ17DygT0Bhlvle/KlV5oznIaSYSydc1Ltqa
         HWmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD0E/07icysxwDGZuN3uPkr1B855G34+avrhlgB1K1qg5fTchgqs8YNsV66riyX33g3T/crfL9pkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfdDH5RYgTRNoJWNJoL3W5z9W2Ee101qvx0WcpLN/5PGihwInb
	1HiAz+xTOV7WMRFQheb4xdG5MVzKEaLoE4d+mCVQGOT+7BON/xn7iZlrPmxhyEt6h3c3Q5QaDEg
	gzBIRkUT9Ch4U9WLxapvEvRk5w497rA5ei6IgZuxc/+RSyXm5uiix2lKplQ==
X-Gm-Gg: ASbGnctdJWc2ChF+FivSPcBW9sh4+3ryxsOTAK6IpIe9yBgknwECM7snogtSh5OV2M4
	O78E9Tn3IQtPok3B/pJ7LbPA6eo5fkuI/Ck24vfT92d0fHIM/r4KXj0vMsXi+tReL3B4eoz+YBm
	l0SsECxPhyVKO4qy2VNTRotqfuv43K/iZEB7hWUH80YOoqNpUqiDntfWL/GJzZq20vAvzfeBOGY
	g5wwtKC6tUMd0V45qnq8NpjjhYpIVrOtdbaWeeQB6+Ui4g25F2ThFSWdNt7nxhHVeVWAZhMx4mN
	RE46nb43wPlZaduitgPBOJtvvhSwqcXl2Q==
X-Received: by 2002:a05:620a:2705:b0:7b6:7618:d7ce with SMTP id af79cd13be357-7be631e7286mr3215345985a.10.1737586928845;
        Wed, 22 Jan 2025 15:02:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYZwN+yBKoUx963m3Hczo7Uw36iMkWH3AYHfz5PDfRsDo3mFvmKfsH84cRkAgEQygDPmnAgg==
X-Received: by 2002:a05:620a:2705:b0:7b6:7618:d7ce with SMTP id af79cd13be357-7be631e7286mr3215342585a.10.1737586928505;
        Wed, 22 Jan 2025 15:02:08 -0800 (PST)
Received: from [172.16.0.69] (c-98-227-24-213.hsd1.il.comcast.net. [98.227.24.213])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614d9989sm706013085a.83.2025.01.22.15.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 15:02:07 -0800 (PST)
Message-ID: <345e5521-2429-471e-b282-87e39a89d5f7@redhat.com>
Date: Wed, 22 Jan 2025 17:02:06 -0600
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: sorenson@redhat.com
Subject: Re: [nfs-utils PATCH] mountstats/nfsiostat: when parsing the
 mountstats file, only keep the nfs mounts
To: Chuck Lever <chuck.lever@oracle.com>
Cc: steved@redhat.com, linux-nfs@vger.kernel.org
References: <20250122033408.1586852-1-sorenson@redhat.com>
 <7bc09d3e-ad27-449c-b555-24f2647dc281@oracle.com>
From: Frank Sorenson <sorenson@redhat.com>
Content-Language: en-US
In-Reply-To: <7bc09d3e-ad27-449c-b555-24f2647dc281@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/25 08:30, Chuck Lever wrote:
> Hi Frank -
>
> On 1/21/25 10:34 PM, Frank Sorenson wrote:
>> Don't store the mountstats if the fstype is not nfs
>
> The original intent of mountstats is to be agnostic to the file system
Ah, I see.  Yes, this patch certainly would have taken things the 
opposite direction then.  Thank you for the correction.

This patch would have made fixing some nfs-related bugs easier 
('mountstats iostat' crashes after unmount, and 'nfsiostat' crashes 
after new mount), but it doesn't directly fix either.  I'll re-evaluate 
my approach, and see if I can fix them without making them (at least 
mountstats) nfs-specific.


> type. The description must provide a reason why the proposed change
> needs to be made.
>
> This patch doesn't provide a bug or email link either. There's no
> context we reviewers can use to help understand the purpose of this
> patch.
>
> Generally, a patch description needs to explain, among other things, why
> the change is necessary. The diff already shows /what/ the patch is
> doing, thus a patch description typically does not need to repeat that.
Understood; explain the problem leading to the need for the fix, 
instead.  I failed to do that.

There was a purpose, but I neglected to explain it.  In light of my 
misunderstanding of the intent of mountstats, it's not important at this 
point.

Sorry, I'll do better.

Frank


>
>> Signed-off-by: Frank Sorenson <sorenson@redhat.com>
>> ---
>>   tools/mountstats/mountstats.py | 18 +++++++++++++-----
>>   tools/nfs-iostat/nfs-iostat.py | 16 +++++++++++-----
>>   2 files changed, 24 insertions(+), 10 deletions(-)
>>
>> diff --git a/tools/mountstats/mountstats.py 
>> b/tools/mountstats/mountstats.py
>> index 8e129c83..326b35c3 100755
>> --- a/tools/mountstats/mountstats.py
>> +++ b/tools/mountstats/mountstats.py
>> @@ -783,25 +783,33 @@ def parse_stats_file(f):
>>       """pop the contents of a mountstats file into a dictionary,
>>       keyed by mount point.  each value object is a list of the
>>       lines in the mountstats file corresponding to the mount
>> -    point named in the key.
>> +    point named in the key.  Only return nfs mounts.
>>       """
>>       ms_dict = dict()
>>       key = ''
>> +    fstype = ''
>>         f.seek(0)
>>       for line in f.readlines():
>>           words = line.split()
>>           if len(words) == 0:
>> +            fstype = ''
>> +            continue
>> +        if line.startswith("no device mounted"):
>> +            fstype = ''
>>               continue
>>           if words[0] == 'device':
>> +            if 'with fstype nfs' in line:
>> +                fstype = words[-2]
>> +            else:
>> +                fstype = words[-1]
>> +
>>               key = words[4]
>>               new = [ line.strip() ]
>> -        elif 'nfs' in words or 'nfs4' in words:
>> -            key = words[3]
>> -            new = [ line.strip() ]
>>           else:
>>               new += [ line.strip() ]
>> -        ms_dict[key] = new
>> +        if fstype in ('nfs', 'nfs4'):
>> +            ms_dict[key] = new
>>         return ms_dict
>>   diff --git a/tools/nfs-iostat/nfs-iostat.py 
>> b/tools/nfs-iostat/nfs-iostat.py
>> index 31587370..f97b23c0 100755
>> --- a/tools/nfs-iostat/nfs-iostat.py
>> +++ b/tools/nfs-iostat/nfs-iostat.py
>> @@ -445,27 +445,33 @@ def parse_stats_file(filename):
>>       """pop the contents of a mountstats file into a dictionary,
>>       keyed by mount point.  each value object is a list of the
>>       lines in the mountstats file corresponding to the mount
>> -    point named in the key.
>> +    point named in the key.  Only return nfs mounts.
>>       """
>>       ms_dict = dict()
>>       key = ''
>> +    fstype = ''
>>         f = open(filename)
>>       for line in f.readlines():
>>           words = line.split()
>>           if len(words) == 0:
>> +            fstype = ''
>>               continue
>>           if line.startswith("no device mounted"):
>> +            fstype = ''
>>               continue
>>           if words[0] == 'device':
>> +            if 'with fstype nfs' in line:
>> +                fstype = words[-2]
>> +            else:
>> +                fstype = words[-1]
>> +
>>               key = words[4]
>>               new = [ line.strip() ]
>> -        elif 'nfs' in words or 'nfs4' in words:
>> -            key = words[3]
>> -            new = [ line.strip() ]
>>           else:
>>               new += [ line.strip() ]
>> -        ms_dict[key] = new
>> +        if fstype in ('nfs', 'nfs4'):
>> +            ms_dict[key] = new
>>       f.close
>>         return ms_dict
>
>
-- 
Frank Sorenson
sorenson@redhat.com
Principal Software Maintenance Engineer, filesystems
Red Hat


