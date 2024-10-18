Return-Path: <linux-nfs+bounces-7273-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B048C9A3F34
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 15:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91381C219BE
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 13:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95DD288BD;
	Fri, 18 Oct 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YI+ay3sH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B387A44C8F
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257050; cv=none; b=V6VWnkv70c5dNZjt/evNiv3sc7bNaGFQ/ijqokegc2WafGudSHgfpLlheQvPGDg/W0u8BdCMX+H8UmeLbVdj5HE8jsDgiOo9XX+JpH8nVB++M07Dy5todY55/d/Vxl5i7wqYkY8rwfg41jjL0Xnibcp/v+/iCYU1e40ziH85qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257050; c=relaxed/simple;
	bh=/Pp5FlStmP2YZTH+h5ERqQyidBtcl/xodyopHTOi3eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HuBn/wxxTHNLjP7+0q3s7PVmeuplo8f/V7zAsVfjW7eE5sWreDhIJ6FliWrAd9y5KWX++Z79/3HK1MhNc54U7dQkhp0qc3nwJzkRG5G0nMyeopEhEaVRXYSKsVwgKKmIFOhCoMBAwQOnRmlI4csrVheWSaglV4N8iHeEbwlgefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YI+ay3sH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729257047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wqhXRO+1eSCcoHkP1OqD27rk4TerdzSMI6XgQJqAMkM=;
	b=YI+ay3sH2koVf0I0QmyONKjN5GA234BjP8A7gnO/JCdcFA+a2m//tmpK1iPIWbC9RBTDoR
	7TxoeLAIAvBkr0ibAHAVUmzBIRUZBN/vcctiNVxP9M7hAKEvBeE3rQO9mZqfy9LtbigHWe
	EhXP4jQqD7poPVVws3jL0SnVyEmmKK4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-oXX_5FNRMeyoVC8bSjtmgw-1; Fri, 18 Oct 2024 09:10:46 -0400
X-MC-Unique: oXX_5FNRMeyoVC8bSjtmgw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6cbd12b8b60so62965006d6.0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 06:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729257045; x=1729861845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqhXRO+1eSCcoHkP1OqD27rk4TerdzSMI6XgQJqAMkM=;
        b=XDqERpw0L3KwxRVRN0ZCssqGf3dgkl5Kf5YMGN4+vIMr9Bg6kjN1cM+mEBvkbsUVHD
         afBFYlGRliNJWdbodkdQQk0v5KGblB2TFL+ZLETx1bi5KwrBeIQ4SdQdk4x7om3ZFYzt
         o3A3GAHO91q/+TYq8gx2PbCz3BXeVZUiBSjhvWLE3p0N4HhNreIHcWbGf4mAvb1aAUft
         ZKajm9j12hAr6EBF4qz//kE1iF2ab8C7eLoOKGMse4eEagavuRl8UTIZztDYpESodOeE
         utg2exegzKF6rJBXGvMkq+ChmfzLR4qg+VoGh2kZmGH0mqd31zf42ZWybtvbMNIgETQp
         vmNw==
X-Forwarded-Encrypted: i=1; AJvYcCUVcPqUzrznKdl9jXqqh2ziAuogFJhsW52HmP81QDP0f//y7FY54lU+W17xB04Fwc9bSIjOsUGba2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRwr4dSRp+ZChWG7Zkdghks1SwiQYIn06vxFSnfvtQQeb0dv4U
	Et4Ja1gxQQj6f+r6uiYCVU1FtS/x/H2MJ3uo1iTZhLCtoiMadtpwcmEYaXohNEQhl4ZwYIrhzHl
	UB37X3tNx4iF20BYzkoog4SCfCzlFwnDGQko+I2vfqavfZAzVVV4oKqVPWg==
X-Received: by 2002:a05:6214:310e:b0:6cb:f46:2c53 with SMTP id 6a1803df08f44-6cde18ba1a3mr33539956d6.6.1729257044697;
        Fri, 18 Oct 2024 06:10:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoYw6ekoobeF+JSRXOD7YapmgsB3tsB3Z+YJYFgxbhJO3R1z96h/9NLJxYe2fjLrzkprcR2g==
X-Received: by 2002:a05:6214:310e:b0:6cb:f46:2c53 with SMTP id 6a1803df08f44-6cde18ba1a3mr33539606d6.6.1729257044303;
        Fri, 18 Oct 2024 06:10:44 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.130.195])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cde114d061sm6837566d6.42.2024.10.18.06.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 06:10:43 -0700 (PDT)
Message-ID: <f68e01b2-cd71-41d8-a157-7eeb8f9b6464@redhat.com>
Date: Fri, 18 Oct 2024 09:10:42 -0400
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
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <eae570d0-7639-4467-98c6-b67fc1bdc292@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Ian,

I would like to get this into the up
coming nfs-utils release for the Bakeathon
next week. Would mind reformatting the
patch (dos2unix didn't work) and
resubmit using "git format-patch"
and "git send-email".

I am assuming the patch is tested ;-)

tia,

steved.

On 10/6/24 7:53 PM, Ian Kent wrote:
> On 6/10/24 20:43, Steve Dickson wrote:
>>
>>
>> On 10/4/24 10:58 PM, Ian Kent wrote:
>>> Here we go again ...
>>>
>>> On 5/10/24 10:47, Ian Kent wrote:
>>>> Umm, let's try that again ...
>>>>
>>>> On 5/10/24 10:41, Ian Kent wrote:
>>>>> Hi Steve,
>>>>>
>>>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>>>> While looking into a problem that turns out to be somewhere else, 
>>>>>>> I noticed that in gssd_proc.c , getpwuid is used. The context is 
>>>>>>> threaded, and I verified with strace that the thread is sharing 
>>>>>>> memory with other threads. I believe this should be changed to 
>>>>>>> getpwuid_r. Similarly the following call to getpwnam.
>>>>>>>
>>>>>>> Is this the right place for reports on nfs-utils?
>>>>>> Yes... but I'm not a fan of change code, that been around
>>>>>> for a while, without fixing a problem... What problem does changing
>>>>>> getpwuid to getpwuid_r fix?
>>>>>>
>>>>>> Patches are always welcome!
>>>>>>
>>>>>> steved.
>>>>>>
>>>>>>
>>>>>
>>>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and presumably 
>>>>> gssd is a service so it
>>>>>
>>>>> could have multiple concurrent callers.
>>>>>
>>>>>
>>>
>>> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
>>>
>>>
>>> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
>>> these functions are not thread safe.
>>>
>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>
>>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>>> index 2ad84c59..2a376b8f 100644
>>> --- a/utils/gssd/gssd_proc.c
>>> +++ b/utils/gssd/gssd_proc.c
>>> @@ -489,7 +489,10 @@ success:
>>>   static int
>>>   change_identity(uid_t uid)
>>>   {
>>> -       struct passwd   *pw;
>>> +       struct passwd  pw;
>>> +       struct passwd *ppw;
>>> +       char *pw_tmp;
>>> +       long tmplen;
>>>          int res;
>>>
>>>          /* drop list of supplimentary groups first */
>>> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>>>                  return errno;
>>>          }
>>>
>>> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>> +       if (tmplen < 0)
>>> +               bufsize = 16384;
>>> +
>>> +       pw_tmp = malloc(tmplen);
>>> +       if (!pw_tmp) {
>>> +               printerr(0, "WARNING: unable to allocate passwd 
>>> buffer\n");
>>> +               return errno ? errno : ENOMEM;
>>> +       }
>>> +
>>>          /* try to get pwent for user */
>>> -       pw = getpwuid(uid);
>>> -       if (!pw) {
>>> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
>>> +       if (!ppw) {
>>>                  /* if that doesn't work, try to get one for "nobody" */
>>> -               errno = 0;
>>> -               pw = getpwnam("nobody");
>>> -               if (!pw) {
>>> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
>>> +               if (!ppw) {
>>>                          printerr(0, "WARNING: unable to determine 
>>> gid for uid %u\n", uid);
>>> -                       return errno ? errno : ENOENT;
>>> +                       free(pw_tmp);
>>> +                       return res ? res : ENOENT;
>>>                  }
>>>          }
>>>
>>> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>>>           * other threads. To bypass this, we have to call syscall() 
>>> directly.
>>>           */
>>>   #ifdef __NR_setresgid32
>>> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw- 
>>> >pw_gid);
>>> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>>>   #else
>>> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw- 
>>> >pw_gid);
>>> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>>>   #endif
>>> +       free(pw_tmp);
>>>          if (res != 0) {
>>> -               printerr(0, "WARNING: failed to set gid to %u!\n", 
>>> pw-  >pw_gid);
>>> +               printerr(0, "WARNING: failed to set gid to %u!\n", 
>>> pw.pw_gid);
>>>                  return errno;
>>>          }
>>>
>>>
>> checking file utils/gssd/gssd_proc.c
>> Hunk #1 FAILED at 489.
>> Hunk #2 FAILED at 502.
>> Hunk #3 FAILED at 521.
>> 3 out of 3 hunks FAILED
>>
>> What branch are you applying this patch to?
>> Maybe it is me copying the patch over...
>>
>> Try git format-patch that seems to work.
> 
> Opps, sorry!
> 
> I thought it was the nfs-utils repo. main branch ...
> 
> 
> Maybe the patch has DOS carriage controls, I see that a lot myself.
> 
> If a simple dos2unix doesn't fix it I'll start checking my end and use the
> 
> "git format-patch", "git send-email" pair.
> 
> 
> Ian
> 


