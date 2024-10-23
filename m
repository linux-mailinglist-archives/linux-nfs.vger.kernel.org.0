Return-Path: <linux-nfs+bounces-7372-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 140359ABAB8
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 02:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DE91F23FFA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DC41804E;
	Wed, 23 Oct 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmgaWkiz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E591AAC4
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729644701; cv=none; b=RC8dS6z7Z8pGnBkVA+ODYsDEiyePoEdRxNU2aBcKDunfNRQRIjrFSDlhfwFumam2AfUrq2b8kPK2dDt4ImGrxKtrHTopJUvlG0KKMxPR9K1iqhb3ohCh1pZP+kXiuAqW/lDxb62jRmQDdAKC8TW6+4Ty/4biz2wH4+LFOQHLJ+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729644701; c=relaxed/simple;
	bh=qYY5ERu4Xhq38GXBei41tybFxuXs3PfFRK+UZIyhDBo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PTgabdz0zxtdVSeK8WVKpHAuzU4Wqqj+SoEaX1GgfUAwaK74CXqo4+I1gVKeT9JCTFFKrGsVLUEaDriChL5KRB4Otmevcn6+XOX/joChzM4pg6Y2AJMmqFDIT4AOi1sF0STz9ly9p4E5d+WfwKv7HI8xpohv+VcU9N6aKtwsCEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EmgaWkiz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729644697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzX0WcTovPHxD34AKDPuvqrqV/6PJfFnIWDjRBuk+bc=;
	b=EmgaWkizEpVfeWYa9ynO5kXdbYxbK3pXeZ+guaHsh8d7xLiZXRrgyUfOFLDYVIP5kZReFX
	qF+Ve8mjCuXkCE3yWh5geUUIuRAU/FjGJcHGS9a6RCIv7wi04m+8txSzz8v2ngz9mxL2O2
	VLjkUa0ADg+D+LCPg0Tm9eJPwpwjiK0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-6SiAghHXP0Gza7dfzkLv2g-1; Tue, 22 Oct 2024 20:51:36 -0400
X-MC-Unique: 6SiAghHXP0Gza7dfzkLv2g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460b71eb996so57939311cf.3
        for <linux-nfs@vger.kernel.org>; Tue, 22 Oct 2024 17:51:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729644696; x=1730249496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzX0WcTovPHxD34AKDPuvqrqV/6PJfFnIWDjRBuk+bc=;
        b=W9ZiJYcQ/dKhki73bC/SO++Xl4RYGa9yz736IzMp8jcBf5wgeFRb/mYnpRKgImcteO
         8niTYC2eT7/cj8eGx/Vlxw5eS/KrnRncrdaEuBztWE00kXcLhP/S6jbTdzPPcztdO0NF
         PFB28JfiDjb2urwzD3bboJC1l9hj/50A2IXGQNXNGffzSF+2lk7+XK5XKLV/GBT2dn8j
         0EsaTbxLRwCiOJp3BzYJrX/snPrfvAjfjmyi8ricS6Kfdhj1k9mB08+lz6PuM4c370Ie
         fTD2c3iQi4oZ86rU31kMqOWgvecrqmbi57x9/bAVlKHy9f6Op9VyT8rdymuw+bK4ph/p
         jJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVL33cunpcijrhNPa64jbMp0KmOXpPvSRSNth+gkWu30ImYaHRaj6F+v4OPuREdfbxR+aZbbCtXX+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEraovu28YC4+ar1JT3T6Q8YXu74OzsKuEX7pA4Ar1/Vz5rpRL
	6GVjNqM4WpxaBCb+4stwSjqOviDOgOH8MPSEXWhRCCpVcVLmPx34uV5WWh0Pbynd/lnwe+v7zpm
	65D0Ky+fyajICaT3EhrAsnIh5nSYaZ5ALV+5DPZvGamF0hR+USXAW0app+g==
X-Received: by 2002:a05:6214:4403:b0:6c1:6e3a:6d17 with SMTP id 6a1803df08f44-6ce34132c6dmr15577436d6.6.1729644695740;
        Tue, 22 Oct 2024 17:51:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR/G+qFnNxzQoorwaVxLwORuiMyft2N5jCxmvbw/cJIIGjVavNbY+2SW3AmCYRyB31MKHk2g==
X-Received: by 2002:a05:6214:4403:b0:6c1:6e3a:6d17 with SMTP id 6a1803df08f44-6ce34132c6dmr15577156d6.6.1729644695281;
        Tue, 22 Oct 2024 17:51:35 -0700 (PDT)
Received: from [172.31.1.136] ([70.109.134.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009e11bbsm34687366d6.116.2024.10.22.17.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 17:51:34 -0700 (PDT)
Message-ID: <e7251c22-e7a9-4adf-98a7-efa9d48dec6b@redhat.com>
Date: Tue, 22 Oct 2024 20:51:32 -0400
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
 <950fd50d-1fbd-4c13-a816-78ae949f542e@redhat.com>
 <874fe03a-2ff6-46d5-be11-8954e0c87208@themaw.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <874fe03a-2ff6-46d5-be11-8954e0c87208@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/24 8:46 PM, Ian Kent wrote:
> 
> On 19/10/24 20:40, Steve Dickson wrote:
>>
>>
>> On 10/18/24 7:19 PM, Ian Kent wrote:
>>> On 18/10/24 21:10, Steve Dickson wrote:
>>>> Hey Ian,
>>>>
>>>> I would like to get this into the up
>>>> coming nfs-utils release for the Bakeathon
>>>> next week. Would mind reformatting the
>>>> patch (dos2unix didn't work) and
>>>> resubmit using "git format-patch"
>>>> and "git send-email".
>>>
>>> Sure I can do that.
>>>
>>> I'll do it over the weekend.
>>>
>>>
>>>>
>>>> I am assuming the patch is tested ;-)
>>>
>>> It was just an example so it hasn't been tested.
>> I'm testing it now... it seems stable.
> 
> Right, I say I didn't test it but that means I didn't test the code in
> 
> place. I cut and pasted the bits of it into a simple program and checked
> 
> it did what it was meant to do.
> 
> 
> I didn't feel I could claim I tested it but it should (and sounds like
> 
> it did) work ok because I could have made mistakes with this.
> 
> 
> Ian
> 
>>
>> thanks!
>>
>> steved.
>>>
>>>
>>> It was taken from code that I have in autofs that has been in use for
>>>
>>> many years and I'm pretty sure I saw similar code already in nfs-utils
>>>
>>> so the code pattern is well established. Some care should be sufficient
>>>
>>> to screw it up.
>>>
>>>
>>> Anyway I'll post it so it can be reviewed by others that are familiar
>>>
>>> with the code pattern.
No worries... The new release, which includes the patch is
making it through Bake-a-ton testing with flying colors!

steved.
>>>
>>>
>>> Ian
>>>
>>>> tia,
>>>>
>>>> steved.
>>>>
>>>> On 10/6/24 7:53 PM, Ian Kent wrote:
>>>>> On 6/10/24 20:43, Steve Dickson wrote:
>>>>>>
>>>>>>
>>>>>> On 10/4/24 10:58 PM, Ian Kent wrote:
>>>>>>> Here we go again ...
>>>>>>>
>>>>>>> On 5/10/24 10:47, Ian Kent wrote:
>>>>>>>> Umm, let's try that again ...
>>>>>>>>
>>>>>>>> On 5/10/24 10:41, Ian Kent wrote:
>>>>>>>>> Hi Steve,
>>>>>>>>>
>>>>>>>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>>>>>>>> While looking into a problem that turns out to be somewhere 
>>>>>>>>>>> else, I noticed that in gssd_proc.c , getpwuid is used. The 
>>>>>>>>>>> context is threaded, and I verified with strace that the 
>>>>>>>>>>> thread is sharing memory with other threads. I believe this 
>>>>>>>>>>> should be changed to getpwuid_r. Similarly the following call 
>>>>>>>>>>> to getpwnam.
>>>>>>>>>>>
>>>>>>>>>>> Is this the right place for reports on nfs-utils?
>>>>>>>>>> Yes... but I'm not a fan of change code, that been around
>>>>>>>>>> for a while, without fixing a problem... What problem does 
>>>>>>>>>> changing
>>>>>>>>>> getpwuid to getpwuid_r fix?
>>>>>>>>>>
>>>>>>>>>> Patches are always welcome!
>>>>>>>>>>
>>>>>>>>>> steved.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and 
>>>>>>>>> presumably gssd is a service so it
>>>>>>>>>
>>>>>>>>> could have multiple concurrent callers.
>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>>> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
>>>>>>>
>>>>>>>
>>>>>>> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
>>>>>>> these functions are not thread safe.
>>>>>>>
>>>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>>>>
>>>>>>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>>>>>>> index 2ad84c59..2a376b8f 100644
>>>>>>> --- a/utils/gssd/gssd_proc.c
>>>>>>> +++ b/utils/gssd/gssd_proc.c
>>>>>>> @@ -489,7 +489,10 @@ success:
>>>>>>>   static int
>>>>>>>   change_identity(uid_t uid)
>>>>>>>   {
>>>>>>> -       struct passwd   *pw;
>>>>>>> +       struct passwd  pw;
>>>>>>> +       struct passwd *ppw;
>>>>>>> +       char *pw_tmp;
>>>>>>> +       long tmplen;
>>>>>>>          int res;
>>>>>>>
>>>>>>>          /* drop list of supplimentary groups first */
>>>>>>> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>>>>>>>                  return errno;
>>>>>>>          }
>>>>>>>
>>>>>>> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>>>>> +       if (tmplen < 0)
>>>>>>> +               bufsize = 16384;
>>>>>>> +
>>>>>>> +       pw_tmp = malloc(tmplen);
>>>>>>> +       if (!pw_tmp) {
>>>>>>> +               printerr(0, "WARNING: unable to allocate passwd 
>>>>>>> buffer\n");
>>>>>>> +               return errno ? errno : ENOMEM;
>>>>>>> +       }
>>>>>>> +
>>>>>>>          /* try to get pwent for user */
>>>>>>> -       pw = getpwuid(uid);
>>>>>>> -       if (!pw) {
>>>>>>> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
>>>>>>> +       if (!ppw) {
>>>>>>>                  /* if that doesn't work, try to get one for 
>>>>>>> "nobody" */
>>>>>>> -               errno = 0;
>>>>>>> -               pw = getpwnam("nobody");
>>>>>>> -               if (!pw) {
>>>>>>> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, 
>>>>>>> &ppw);
>>>>>>> +               if (!ppw) {
>>>>>>>                          printerr(0, "WARNING: unable to 
>>>>>>> determine gid for uid %u\n", uid);
>>>>>>> -                       return errno ? errno : ENOENT;
>>>>>>> +                       free(pw_tmp);
>>>>>>> +                       return res ? res : ENOENT;
>>>>>>>                  }
>>>>>>>          }
>>>>>>>
>>>>>>> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>>>>>>>           * other threads. To bypass this, we have to call 
>>>>>>> syscall() directly.
>>>>>>>           */
>>>>>>>   #ifdef __NR_setresgid32
>>>>>>> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, 
>>>>>>> pw- >pw_gid);
>>>>>>> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, 
>>>>>>> pw.pw_gid);
>>>>>>>   #else
>>>>>>> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw- 
>>>>>>> >pw_gid);
>>>>>>> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, 
>>>>>>> pw.pw_gid);
>>>>>>>   #endif
>>>>>>> +       free(pw_tmp);
>>>>>>>          if (res != 0) {
>>>>>>> -               printerr(0, "WARNING: failed to set gid to %u! 
>>>>>>> \n", pw-  >pw_gid);
>>>>>>> +               printerr(0, "WARNING: failed to set gid to %u! 
>>>>>>> \n", pw.pw_gid);
>>>>>>>                  return errno;
>>>>>>>          }
>>>>>>>
>>>>>>>
>>>>>> checking file utils/gssd/gssd_proc.c
>>>>>> Hunk #1 FAILED at 489.
>>>>>> Hunk #2 FAILED at 502.
>>>>>> Hunk #3 FAILED at 521.
>>>>>> 3 out of 3 hunks FAILED
>>>>>>
>>>>>> What branch are you applying this patch to?
>>>>>> Maybe it is me copying the patch over...
>>>>>>
>>>>>> Try git format-patch that seems to work.
>>>>>
>>>>> Opps, sorry!
>>>>>
>>>>> I thought it was the nfs-utils repo. main branch ...
>>>>>
>>>>>
>>>>> Maybe the patch has DOS carriage controls, I see that a lot myself.
>>>>>
>>>>> If a simple dos2unix doesn't fix it I'll start checking my end and 
>>>>> use the
>>>>>
>>>>> "git format-patch", "git send-email" pair.
>>>>>
>>>>>
>>>>> Ian
>>>>>
>>>>
>>>
>>
> 


