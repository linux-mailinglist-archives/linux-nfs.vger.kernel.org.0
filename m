Return-Path: <linux-nfs+bounces-7300-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAC49A49F5
	for <lists+linux-nfs@lfdr.de>; Sat, 19 Oct 2024 01:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62F6283D26
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Oct 2024 23:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ADD19067C;
	Fri, 18 Oct 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="qo4X6cQe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5SeNSJE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40418E758
	for <linux-nfs@vger.kernel.org>; Fri, 18 Oct 2024 23:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729293590; cv=none; b=sypYQvw9vSwz9MwNQDU2M33zornNENi/AS9Ad4Pnjk7RI6yPSykWUAw6g1lIc7teIl7/f1T0+joyNm/pe6PvTVvIPGZk6uc08sxti1ZMM/aG8j9D0fA4yOujxTWE9y4G8VLR4sHRsGtfEKyXpCSvkYbr33v4j8LuCZEPuILCQas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729293590; c=relaxed/simple;
	bh=0laZROexYUlQkq4/zuynBp+W8n4omujGRsIY79tgQaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PVYR+b9haqpvq+L21mLrKucIxTKhKLNVq9Er4RbPKzTHXUhCdMr1qq8BFEyew9d1oQZETpJZxgxyIxsHgwschhORIzr8fjDJwVkOQJz/VEpZ/LwUIYPaLWUbMieoZ29xLmmj3LBLBzbHOprQoaQYcQElJx2W/y8BxM/15wd1zXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=qo4X6cQe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5SeNSJE; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C644D11401C0;
	Fri, 18 Oct 2024 19:19:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 18 Oct 2024 19:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1729293586;
	 x=1729379986; bh=auE9JAo9R7mhpQnVbwjqe6GWAZpjPnk61pyjftwOPqM=; b=
	qo4X6cQetQ+AhKrQIlr2Zlw8yJ0sNif2uozUJefLFxsW4wzcyRDKicJSOLDAG9OP
	deG5VcW6Z0c8cLdV93r1/Ti/bvn/LnqxZPyewP8ivTftaa32jW1LwLvzngjtqGBJ
	xbZByzyNYth0v0LLVEce6ZeYKj4bz9/i7kk/EF3fsnQhdRfTmnMAz0Hs6bBKOy02
	U5I1A+8Zc/6AczB4Req0vJc3Ar0wSeXo0bVa+VIf9mLtBzCBMFcCUFxf20y+F6Ab
	kGG5n2xmTt/rJChj1y8gv875aJz0jlRr8tl8lrnWNfWWJ9ZAgNQ27z3MnjH3OwCz
	l0oAttoHVGW2e5vP/Q30lQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729293586; x=
	1729379986; bh=auE9JAo9R7mhpQnVbwjqe6GWAZpjPnk61pyjftwOPqM=; b=W
	5SeNSJEPKSFqAINI3or1T9ue1zZOQfU/Nokj5WUyKREkNX2GYbqc9IQZu8TdSAd4
	AE+Bb4elKVnTuBEDke5h/NcLxJ7uV6OQf4lUfl3TwOKVvNSP7lYjMpVDGoGsVCbv
	5SP1epHbKLTaiOuMmczf8waGr+qm0nd8l8E9zmAMNa0GeTQP5CGqZ4AHF2NAG79x
	lQ4NJ29svF8Mtzaqi9MZKCsE+C6j6CnO/HcMWfDIgG+Oyucp/co7S8xGnmEFNRxm
	jgL0kQmbCJaIxQmeEzN5P+OB6J1ITDqsyhNu3bxW4MGzPWvS8YDyGfQurpmsFv8E
	IFLCqgkCeQwuga/EML4Aw==
X-ME-Sender: <xms:Eu0SZ0qypB3OSwKte7KyOk9GNPOAf3vAMOGQsV6PsGSvT2IjbIkl4Q>
    <xme:Eu0SZ6qBfGf7MV2suYvCFcpFyTLNmraUNMGDkDPpicPIWgSxkrwSPBhD4J_nkx4d1
    zSyx1xlKW5e>
X-ME-Received: <xmr:Eu0SZ5NJmtidm5Z902ItcJZWyfZwUKCGd4jrhxtj0QO4rl2XPZyyuyPqj2Py_fQ9PaecTVxrYJD1NhxY49LCG8uu7trtPH6Y9LBpFipYjon4Zu-Se-_NIQFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehgedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfesthekredttddvjeen
    ucfhrhhomhepkfgrnhcumfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenuc
    ggtffrrghtthgvrhhnpeeiudeiledvtdfgheeglefgfeetleejfffhgfdvheevtdeigeff
    feekjeffvdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthdpnhgspghrtghpthhtohepfedpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvghvvggusehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehhvggurhhitghksehruhhtghgvrhhsrdgvughupdhrtghpthhtohep
    lhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Eu0SZ77RMmq_R5IW7Cif5aoo9O2MV-ResNCkRNk-ZnEkfzkT_UWsqg>
    <xmx:Eu0SZz7Gfzt3Uz8D7TFY1XSJvCpxtwSI85-mhKueT1zGzmKfiokoWA>
    <xmx:Eu0SZ7i4kSepnXvR30baVIEY8fwZkeeVyHUvF4PPn8JRG4HpKXyGfQ>
    <xmx:Eu0SZ96HPhGdo68plXfyb-7V2eyzeiU4QKcNnngGNoNekYCIescr9A>
    <xmx:Eu0SZ1l9w3urt6Cwo1og1TMWjbktCBHm3KRMT52OJJre7CCcaLW-YoF8>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 19:19:45 -0400 (EDT)
Message-ID: <e62ae2f3-56eb-4c21-b625-36decbe31036@themaw.net>
Date: Sat, 19 Oct 2024 07:19:40 +0800
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
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <f68e01b2-cd71-41d8-a157-7eeb8f9b6464@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18/10/24 21:10, Steve Dickson wrote:
> Hey Ian,
>
> I would like to get this into the up
> coming nfs-utils release for the Bakeathon
> next week. Would mind reformatting the
> patch (dos2unix didn't work) and
> resubmit using "git format-patch"
> and "git send-email".

Sure I can do that.

I'll do it over the weekend.


>
> I am assuming the patch is tested ;-)

It was just an example so it hasn't been tested.


It was taken from code that I have in autofs that has been in use for

many years and I'm pretty sure I saw similar code already in nfs-utils

so the code pattern is well established. Some care should be sufficient

to screw it up.


Anyway I'll post it so it can be reviewed by others that are familiar

with the code pattern.


Ian

> tia,
>
> steved.
>
> On 10/6/24 7:53 PM, Ian Kent wrote:
>> On 6/10/24 20:43, Steve Dickson wrote:
>>>
>>>
>>> On 10/4/24 10:58 PM, Ian Kent wrote:
>>>> Here we go again ...
>>>>
>>>> On 5/10/24 10:47, Ian Kent wrote:
>>>>> Umm, let's try that again ...
>>>>>
>>>>> On 5/10/24 10:41, Ian Kent wrote:
>>>>>> Hi Steve,
>>>>>>
>>>>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>>>>> While looking into a problem that turns out to be somewhere 
>>>>>>>> else, I noticed that in gssd_proc.c , getpwuid is used. The 
>>>>>>>> context is threaded, and I verified with strace that the thread 
>>>>>>>> is sharing memory with other threads. I believe this should be 
>>>>>>>> changed to getpwuid_r. Similarly the following call to getpwnam.
>>>>>>>>
>>>>>>>> Is this the right place for reports on nfs-utils?
>>>>>>> Yes... but I'm not a fan of change code, that been around
>>>>>>> for a while, without fixing a problem... What problem does changing
>>>>>>> getpwuid to getpwuid_r fix?
>>>>>>>
>>>>>>> Patches are always welcome!
>>>>>>>
>>>>>>> steved.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and 
>>>>>> presumably gssd is a service so it
>>>>>>
>>>>>> could have multiple concurrent callers.
>>>>>>
>>>>>>
>>>>
>>>> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
>>>>
>>>>
>>>> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
>>>> these functions are not thread safe.
>>>>
>>>> Signed-off-by: Ian Kent <raven@themaw.net>
>>>>
>>>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>>>> index 2ad84c59..2a376b8f 100644
>>>> --- a/utils/gssd/gssd_proc.c
>>>> +++ b/utils/gssd/gssd_proc.c
>>>> @@ -489,7 +489,10 @@ success:
>>>>   static int
>>>>   change_identity(uid_t uid)
>>>>   {
>>>> -       struct passwd   *pw;
>>>> +       struct passwd  pw;
>>>> +       struct passwd *ppw;
>>>> +       char *pw_tmp;
>>>> +       long tmplen;
>>>>          int res;
>>>>
>>>>          /* drop list of supplimentary groups first */
>>>> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>>>>                  return errno;
>>>>          }
>>>>
>>>> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
>>>> +       if (tmplen < 0)
>>>> +               bufsize = 16384;
>>>> +
>>>> +       pw_tmp = malloc(tmplen);
>>>> +       if (!pw_tmp) {
>>>> +               printerr(0, "WARNING: unable to allocate passwd 
>>>> buffer\n");
>>>> +               return errno ? errno : ENOMEM;
>>>> +       }
>>>> +
>>>>          /* try to get pwent for user */
>>>> -       pw = getpwuid(uid);
>>>> -       if (!pw) {
>>>> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
>>>> +       if (!ppw) {
>>>>                  /* if that doesn't work, try to get one for 
>>>> "nobody" */
>>>> -               errno = 0;
>>>> -               pw = getpwnam("nobody");
>>>> -               if (!pw) {
>>>> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
>>>> +               if (!ppw) {
>>>>                          printerr(0, "WARNING: unable to determine 
>>>> gid for uid %u\n", uid);
>>>> -                       return errno ? errno : ENOENT;
>>>> +                       free(pw_tmp);
>>>> +                       return res ? res : ENOENT;
>>>>                  }
>>>>          }
>>>>
>>>> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>>>>           * other threads. To bypass this, we have to call 
>>>> syscall() directly.
>>>>           */
>>>>   #ifdef __NR_setresgid32
>>>> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, pw- 
>>>> >pw_gid);
>>>> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, 
>>>> pw.pw_gid);
>>>>   #else
>>>> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, pw- 
>>>> >pw_gid);
>>>> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>>>>   #endif
>>>> +       free(pw_tmp);
>>>>          if (res != 0) {
>>>> -               printerr(0, "WARNING: failed to set gid to %u!\n", 
>>>> pw-  >pw_gid);
>>>> +               printerr(0, "WARNING: failed to set gid to %u!\n", 
>>>> pw.pw_gid);
>>>>                  return errno;
>>>>          }
>>>>
>>>>
>>> checking file utils/gssd/gssd_proc.c
>>> Hunk #1 FAILED at 489.
>>> Hunk #2 FAILED at 502.
>>> Hunk #3 FAILED at 521.
>>> 3 out of 3 hunks FAILED
>>>
>>> What branch are you applying this patch to?
>>> Maybe it is me copying the patch over...
>>>
>>> Try git format-patch that seems to work.
>>
>> Opps, sorry!
>>
>> I thought it was the nfs-utils repo. main branch ...
>>
>>
>> Maybe the patch has DOS carriage controls, I see that a lot myself.
>>
>> If a simple dos2unix doesn't fix it I'll start checking my end and 
>> use the
>>
>> "git format-patch", "git send-email" pair.
>>
>>
>> Ian
>>
>

