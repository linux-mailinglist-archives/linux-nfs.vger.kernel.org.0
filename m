Return-Path: <linux-nfs+bounces-7315-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B609A584D
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 02:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 057451F20938
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Oct 2024 00:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D63B4C8E;
	Mon, 21 Oct 2024 00:55:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863AFCA64
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 00:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=121.200.0.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729472107; cv=none; b=CziGn11Ihs7O/CIE0Ei3t7rBEt2zTwJ325K5t1N4TDSz09WkrhSB3QI0937R4pPxkPSIm771it0GAoMMw18HMCyJ6XofW1n/pGWbUPXTW5R1aiVwaWGDwQQvEr8hprIVtDIXwIqfH630pk8i4Bd3IMUcmnMTG8hziceUiEMCj9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729472107; c=relaxed/simple;
	bh=VMv8D66npZ5WoOvEOPhr2JE9A/CtQxySGhQkYB6aAl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KrDimvC1EsMBE0LqXE/OJ3BJf831o5JetIMyfGETMMevnRx/TDbV0YwVBEBcIS504zrdt3bcs0J0lMhcPuEMYwEQ37BSmGsDUZjZ7VT35pFdeQ4F5GRjjHj9Bz7Qo26M3F1tGmMDhxqqYYpYfvEorpTGKH9uH1FA0nef/jD8Th0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net; spf=fail smtp.mailfrom=themaw.net; arc=none smtp.client-ip=121.200.0.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=themaw.net
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp01.aussiebb.com.au (Postfix) with ESMTP id 6BFA4100B82
	for <linux-nfs@vger.kernel.org>; Mon, 21 Oct 2024 11:46:39 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
	by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XaQPnFTnhCsg for <linux-nfs@vger.kernel.org>;
	Mon, 21 Oct 2024 11:46:39 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
	id 5933C100B20; Mon, 21 Oct 2024 11:46:39 +1100 (AEDT)
X-Spam-Level: 
Received: from [192.168.68.229] (159-196-82-144.9fc452.per.static.aussiebb.net [159.196.82.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ian146@aussiebb.com.au)
	by smtp01.aussiebb.com.au (Postfix) with ESMTPSA id D28DA100449;
	Mon, 21 Oct 2024 11:46:37 +1100 (AEDT)
Message-ID: <874fe03a-2ff6-46d5-be11-8954e0c87208@themaw.net>
Date: Mon, 21 Oct 2024 08:46:36 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: probable big in nfs-utils
To: Steve Dickson <steved@redhat.com>, Charles Hedrick <hedrick@rutgers.edu>,
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
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net; keydata=
 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
In-Reply-To: <950fd50d-1fbd-4c13-a816-78ae949f542e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 19/10/24 20:40, Steve Dickson wrote:
>
>
> On 10/18/24 7:19 PM, Ian Kent wrote:
>> On 18/10/24 21:10, Steve Dickson wrote:
>>> Hey Ian,
>>>
>>> I would like to get this into the up
>>> coming nfs-utils release for the Bakeathon
>>> next week. Would mind reformatting the
>>> patch (dos2unix didn't work) and
>>> resubmit using "git format-patch"
>>> and "git send-email".
>>
>> Sure I can do that.
>>
>> I'll do it over the weekend.
>>
>>
>>>
>>> I am assuming the patch is tested ;-)
>>
>> It was just an example so it hasn't been tested.
> I'm testing it now... it seems stable.

Right, I say I didn't test it but that means I didn't test the code in

place. I cut and pasted the bits of it into a simple program and checked

it did what it was meant to do.


I didn't feel I could claim I tested it but it should (and sounds like

it did) work ok because I could have made mistakes with this.


Ian

>
> thanks!
>
> steved.
>>
>>
>> It was taken from code that I have in autofs that has been in use for
>>
>> many years and I'm pretty sure I saw similar code already in nfs-utils
>>
>> so the code pattern is well established. Some care should be sufficient
>>
>> to screw it up.
>>
>>
>> Anyway I'll post it so it can be reviewed by others that are familiar
>>
>> with the code pattern.
>>
>>
>> Ian
>>
>>> tia,
>>>
>>> steved.
>>>
>>> On 10/6/24 7:53 PM, Ian Kent wrote:
>>>> On 6/10/24 20:43, Steve Dickson wrote:
>>>>>
>>>>>
>>>>> On 10/4/24 10:58 PM, Ian Kent wrote:
>>>>>> Here we go again ...
>>>>>>
>>>>>> On 5/10/24 10:47, Ian Kent wrote:
>>>>>>> Umm, let's try that again ...
>>>>>>>
>>>>>>> On 5/10/24 10:41, Ian Kent wrote:
>>>>>>>> Hi Steve,
>>>>>>>>
>>>>>>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>>>>>>> While looking into a problem that turns out to be somewhere 
>>>>>>>>>> else, I noticed that in gssd_proc.c , getpwuid is used. The 
>>>>>>>>>> context is threaded, and I verified with strace that the 
>>>>>>>>>> thread is sharing memory with other threads. I believe this 
>>>>>>>>>> should be changed to getpwuid_r. Similarly the following call 
>>>>>>>>>> to getpwnam.
>>>>>>>>>>
>>>>>>>>>> Is this the right place for reports on nfs-utils?
>>>>>>>>> Yes... but I'm not a fan of change code, that been around
>>>>>>>>> for a while, without fixing a problem... What problem does 
>>>>>>>>> changing
>>>>>>>>> getpwuid to getpwuid_r fix?
>>>>>>>>>
>>>>>>>>> Patches are always welcome!
>>>>>>>>>
>>>>>>>>> steved.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and 
>>>>>>>> presumably gssd is a service so it
>>>>>>>>
>>>>>>>> could have multiple concurrent callers.
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>>> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
>>>>>>
>>>>>>
>>>>>> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
>>>>>> these functions are not thread safe.
>>>>>>
>>>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>>>
>>>>>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>>>>>> index 2ad84c59..2a376b8f 100644
>>>>>> --- a/utils/gssd/gssd_proc.c
>>>>>> +++ b/utils/gssd/gssd_proc.c
>>>>>> @@ -489,7 +489,10 @@ success:
>>>>>>   static int
>>>>>>   change_identity(uid_t uid)
>>>>>>   {
>>>>>> -       struct passwd   *pw;
>>>>>> +       struct passwd  pw;
>>>>>> +       struct passwd *ppw;
>>>>>> +       char *pw_tmp;
>>>>>> +       long tmplen;
>>>>>>          int res;
>>>>>>
>>>>>>          /* drop list of supplimentary groups first */
>>>>>> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>>>>>>                  return errno;
>>>>>>          }
>>>>>>
>>>>>> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>>>> +       if (tmplen < 0)
>>>>>> +               bufsize = 16384;
>>>>>> +
>>>>>> +       pw_tmp = malloc(tmplen);
>>>>>> +       if (!pw_tmp) {
>>>>>> +               printerr(0, "WARNING: unable to allocate passwd 
>>>>>> buffer\n");
>>>>>> +               return errno ? errno : ENOMEM;
>>>>>> +       }
>>>>>> +
>>>>>>          /* try to get pwent for user */
>>>>>> -       pw = getpwuid(uid);
>>>>>> -       if (!pw) {
>>>>>> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
>>>>>> +       if (!ppw) {
>>>>>>                  /* if that doesn't work, try to get one for 
>>>>>> "nobody" */
>>>>>> -               errno = 0;
>>>>>> -               pw = getpwnam("nobody");
>>>>>> -               if (!pw) {
>>>>>> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, 
>>>>>> &ppw);
>>>>>> +               if (!ppw) {
>>>>>>                          printerr(0, "WARNING: unable to 
>>>>>> determine gid for uid %u\n", uid);
>>>>>> -                       return errno ? errno : ENOENT;
>>>>>> +                       free(pw_tmp);
>>>>>> +                       return res ? res : ENOENT;
>>>>>>                  }
>>>>>>          }
>>>>>>
>>>>>> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>>>>>>           * other threads. To bypass this, we have to call 
>>>>>> syscall() directly.
>>>>>>           */
>>>>>>   #ifdef __NR_setresgid32
>>>>>> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, 
>>>>>> pw- >pw_gid);
>>>>>> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, 
>>>>>> pw.pw_gid);
>>>>>>   #else
>>>>>> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw- 
>>>>>> >pw_gid);
>>>>>> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, 
>>>>>> pw.pw_gid);
>>>>>>   #endif
>>>>>> +       free(pw_tmp);
>>>>>>          if (res != 0) {
>>>>>> -               printerr(0, "WARNING: failed to set gid to 
>>>>>> %u!\n", pw-  >pw_gid);
>>>>>> +               printerr(0, "WARNING: failed to set gid to 
>>>>>> %u!\n", pw.pw_gid);
>>>>>>                  return errno;
>>>>>>          }
>>>>>>
>>>>>>
>>>>> checking file utils/gssd/gssd_proc.c
>>>>> Hunk #1 FAILED at 489.
>>>>> Hunk #2 FAILED at 502.
>>>>> Hunk #3 FAILED at 521.
>>>>> 3 out of 3 hunks FAILED
>>>>>
>>>>> What branch are you applying this patch to?
>>>>> Maybe it is me copying the patch over...
>>>>>
>>>>> Try git format-patch that seems to work.
>>>>
>>>> Opps, sorry!
>>>>
>>>> I thought it was the nfs-utils repo. main branch ...
>>>>
>>>>
>>>> Maybe the patch has DOS carriage controls, I see that a lot myself.
>>>>
>>>> If a simple dos2unix doesn't fix it I'll start checking my end and 
>>>> use the
>>>>
>>>> "git format-patch", "git send-email" pair.
>>>>
>>>>
>>>> Ian
>>>>
>>>
>>
>

