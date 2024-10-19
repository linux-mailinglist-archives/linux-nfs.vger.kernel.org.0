Return-Path: <linux-nfs+bounces-7309-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D3D9A4DD2
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 14:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A9AE1C21399
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAB8187561;
	Sat, 19 Oct 2024 12:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IoAUagkf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEFA1E4A4
	for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 12:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729341628; cv=none; b=rbkNvKostS9qD5obI5OrHQjVCbv1BaPVasXG2A2ali7d5N5Q984vXoqi4l66fbYKH3iDTzQiQU9UHF4S/Vn47rsoy87FJg8FgfG7BcLYpp/pn4sqlAs9f4722bTYjMs/bUIE4FpLs25tmJzN1ndXesDTmL8HS+g+kqx0xGH0ZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729341628; c=relaxed/simple;
	bh=DB29yN6LD0bPMsAc0amPu83Z+jC48j9Zb78tSvmx5HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Kj9lN8nth3AJ2a7cFei6mdR9D7Y61KycDCVgCyKZVD3h8PQJQ/cx/1Q8Bqn/5H3mTVh+FFOBCu1l6aBVk8uyToLXmkeDVtd6NBk3+pX6arj7A44naHPJc53KTDg3eCB1ejaqiG5M6mFkCHi1SU/J9qXJ8BORRwGAEm0ItElQ2xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IoAUagkf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729341624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U6KHJcbN41zywFofsB9xy9gnJvpO1iQGZHBJq0Ez1qo=;
	b=IoAUagkf47esRrC3BisOrfJnfisAhGz7Pj2Dc1G8d+bRHvIDI49dpR2ouUrwDPn4vCi0gu
	WOjGFfc2Xl80S6DbccQSAFTW2a2wzkmFO8iPv2R2svTs49BO5TQW+Il4b8isQii3Ws95Xe
	SzK7fnqP/OSgWPGpSDMlsTIEZyXJ2QY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-K1868GF1OZWi9K3KNaACtQ-1; Sat, 19 Oct 2024 08:40:23 -0400
X-MC-Unique: K1868GF1OZWi9K3KNaACtQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6cde363fdf7so25097876d6.1
        for <linux-nfs@vger.kernel.org>; Sat, 19 Oct 2024 05:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729341622; x=1729946422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U6KHJcbN41zywFofsB9xy9gnJvpO1iQGZHBJq0Ez1qo=;
        b=exXAF94v4bT1IJxQ+/0xhCMFduZvm3Rkx0AUoK3CJhpEchUWJ99JP2Ue9Qb6UxlFkN
         DUwWeaQ3NNLymy1k4AKAwkaQZ+3xinmsJAfHNnJu9dOUU+F95Mc+ubSgna3ziJ0Oh0GJ
         7EJZFEvy/vyeWl9xfaosCth0HTMxhHu5giCUe2svgmU5rE7Dc5I/h1GDNc2gpAXvkY6F
         o50T6GcO14ZJTey+acX04bddNwdATpFoTg28klZmU6HD56xQdSB4KiYsXOUmGc7bCxfH
         4TV+4WY6e+JCyXu/WgCvxxlMiduMvRAyugZKpTakmFp7wS0F/nXS6fDTL8z7j/oHVRg0
         MFFg==
X-Forwarded-Encrypted: i=1; AJvYcCWkf0eibK1Eu+rdP80mKIVGlYPUVzfc1Z1MhPs3pw9cByHaSvGRv9lkciJ034m8PYe1IiVO/RtklM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwigsU9ot1nmPREZ6I2R87IDeSKWOtPe5MKwHrvLt5UqNsKxi
	dtxjB3HWax0eQb+Xnzv9DLNWbmSlpgvAbYcjr8LmobPcUvGwEsSQTmjyPwpxbkf2HEsL0NnrPdP
	Yma/Nsuft5gGCSAR+cPMAKUFS249YMkPGBZcIxc61hZ3TjpbUFXdqykLYeuzPC0XAXQ==
X-Received: by 2002:a05:6214:5983:b0:6cb:d4ed:aa59 with SMTP id 6a1803df08f44-6cde14c6225mr80416326d6.4.1729341622058;
        Sat, 19 Oct 2024 05:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoauyHEOHKu6bmvTjUjAG/Z75BiXVpq4yQAgQKhZTVoAdNX0Ihki10wZt6g9wcNzeEbtxfJA==
X-Received: by 2002:a05:6214:5983:b0:6cb:d4ed:aa59 with SMTP id 6a1803df08f44-6cde14c6225mr80416016d6.4.1729341621629;
        Sat, 19 Oct 2024 05:40:21 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.244.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde111c630sm17878016d6.22.2024.10.19.05.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 05:40:20 -0700 (PDT)
Message-ID: <950fd50d-1fbd-4c13-a816-78ae949f542e@redhat.com>
Date: Sat, 19 Oct 2024 08:40:19 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable big in nfs-utils
To: Ian Kent <raven@themaw.net>, Charles Hedrick <hedrick@rutgers.edu>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
References: <PH0PR14MB5493F5F79BCAE03BF2C25ED6AA722@PH0PR14MB5493.namprd14.prod.outlook.com>
 <0654ecc2-74fa-4e50-8878-bf37f17a5748@redhat.com>
 <209f2590-9bc6-4c01-a14b-87b7575a6f20@themaw.net>
 <fb80e74f-177f-4ff8-8987-8d4d313286cc@themaw.net>
 <b6744232-7d0b-4278-a71a-b9d744b8372d@themaw.net>
 <ef43bc4b-c445-4a0e-aaac-6cb57aca7c35@redhat.com>
 <eae570d0-7639-4467-98c6-b67fc1bdc292@themaw.net>
 <f68e01b2-cd71-41d8-a157-7eeb8f9b6464@redhat.com>
 <e62ae2f3-56eb-4c21-b625-36decbe31036@themaw.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <e62ae2f3-56eb-4c21-b625-36decbe31036@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/18/24 7:19 PM, Ian Kent wrote:
> On 18/10/24 21:10, Steve Dickson wrote:
>> Hey Ian,
>>
>> I would like to get this into the up
>> coming nfs-utils release for the Bakeathon
>> next week. Would mind reformatting the
>> patch (dos2unix didn't work) and
>> resubmit using "git format-patch"
>> and "git send-email".
> 
> Sure I can do that.
> 
> I'll do it over the weekend.
> 
> 
>>
>> I am assuming the patch is tested ;-)
> 
> It was just an example so it hasn't been tested.
I'm testing it now... it seems stable.

thanks!

steved.
> 
> 
> It was taken from code that I have in autofs that has been in use for
> 
> many years and I'm pretty sure I saw similar code already in nfs-utils
> 
> so the code pattern is well established. Some care should be sufficient
> 
> to screw it up.
> 
> 
> Anyway I'll post it so it can be reviewed by others that are familiar
> 
> with the code pattern.
> 
> 
> Ian
> 
>> tia,
>>
>> steved.
>>
>> On 10/6/24 7:53 PM, Ian Kent wrote:
>>> On 6/10/24 20:43, Steve Dickson wrote:
>>>>
>>>>
>>>> On 10/4/24 10:58 PM, Ian Kent wrote:
>>>>> Here we go again ...
>>>>>
>>>>> On 5/10/24 10:47, Ian Kent wrote:
>>>>>> Umm, let's try that again ...
>>>>>>
>>>>>> On 5/10/24 10:41, Ian Kent wrote:
>>>>>>> Hi Steve,
>>>>>>>
>>>>>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>>>>>> While looking into a problem that turns out to be somewhere 
>>>>>>>>> else, I noticed that in gssd_proc.c , getpwuid is used. The 
>>>>>>>>> context is threaded, and I verified with strace that the thread 
>>>>>>>>> is sharing memory with other threads. I believe this should be 
>>>>>>>>> changed to getpwuid_r. Similarly the following call to getpwnam.
>>>>>>>>>
>>>>>>>>> Is this the right place for reports on nfs-utils?
>>>>>>>> Yes... but I'm not a fan of change code, that been around
>>>>>>>> for a while, without fixing a problem... What problem does changing
>>>>>>>> getpwuid to getpwuid_r fix?
>>>>>>>>
>>>>>>>> Patches are always welcome!
>>>>>>>>
>>>>>>>> steved.
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and 
>>>>>>> presumably gssd is a service so it
>>>>>>>
>>>>>>> could have multiple concurrent callers.
>>>>>>>
>>>>>>>
>>>>>
>>>>> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
>>>>>
>>>>>
>>>>> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
>>>>> these functions are not thread safe.
>>>>>
>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>>
>>>>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>>>>> index 2ad84c59..2a376b8f 100644
>>>>> --- a/utils/gssd/gssd_proc.c
>>>>> +++ b/utils/gssd/gssd_proc.c
>>>>> @@ -489,7 +489,10 @@ success:
>>>>>   static int
>>>>>   change_identity(uid_t uid)
>>>>>   {
>>>>> -       struct passwd   *pw;
>>>>> +       struct passwd  pw;
>>>>> +       struct passwd *ppw;
>>>>> +       char *pw_tmp;
>>>>> +       long tmplen;
>>>>>          int res;
>>>>>
>>>>>          /* drop list of supplimentary groups first */
>>>>> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>>>>>                  return errno;
>>>>>          }
>>>>>
>>>>> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>>> +       if (tmplen < 0)
>>>>> +               bufsize = 16384;
>>>>> +
>>>>> +       pw_tmp = malloc(tmplen);
>>>>> +       if (!pw_tmp) {
>>>>> +               printerr(0, "WARNING: unable to allocate passwd 
>>>>> buffer\n");
>>>>> +               return errno ? errno : ENOMEM;
>>>>> +       }
>>>>> +
>>>>>          /* try to get pwent for user */
>>>>> -       pw = getpwuid(uid);
>>>>> -       if (!pw) {
>>>>> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
>>>>> +       if (!ppw) {
>>>>>                  /* if that doesn't work, try to get one for 
>>>>> "nobody" */
>>>>> -               errno = 0;
>>>>> -               pw = getpwnam("nobody");
>>>>> -               if (!pw) {
>>>>> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
>>>>> +               if (!ppw) {
>>>>>                          printerr(0, "WARNING: unable to determine 
>>>>> gid for uid %u\n", uid);
>>>>> -                       return errno ? errno : ENOENT;
>>>>> +                       free(pw_tmp);
>>>>> +                       return res ? res : ENOENT;
>>>>>                  }
>>>>>          }
>>>>>
>>>>> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>>>>>           * other threads. To bypass this, we have to call 
>>>>> syscall() directly.
>>>>>           */
>>>>>   #ifdef __NR_setresgid32
>>>>> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw- 
>>>>> >pw_gid);
>>>>> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, 
>>>>> pw.pw_gid);
>>>>>   #else
>>>>> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw- 
>>>>> >pw_gid);
>>>>> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>>>>>   #endif
>>>>> +       free(pw_tmp);
>>>>>          if (res != 0) {
>>>>> -               printerr(0, "WARNING: failed to set gid to %u!\n", 
>>>>> pw-  >pw_gid);
>>>>> +               printerr(0, "WARNING: failed to set gid to %u!\n", 
>>>>> pw.pw_gid);
>>>>>                  return errno;
>>>>>          }
>>>>>
>>>>>
>>>> checking file utils/gssd/gssd_proc.c
>>>> Hunk #1 FAILED at 489.
>>>> Hunk #2 FAILED at 502.
>>>> Hunk #3 FAILED at 521.
>>>> 3 out of 3 hunks FAILED
>>>>
>>>> What branch are you applying this patch to?
>>>> Maybe it is me copying the patch over...
>>>>
>>>> Try git format-patch that seems to work.
>>>
>>> Opps, sorry!
>>>
>>> I thought it was the nfs-utils repo. main branch ...
>>>
>>>
>>> Maybe the patch has DOS carriage controls, I see that a lot myself.
>>>
>>> If a simple dos2unix doesn't fix it I'll start checking my end and 
>>> use the
>>>
>>> "git format-patch", "git send-email" pair.
>>>
>>>
>>> Ian
>>>
>>
> 


