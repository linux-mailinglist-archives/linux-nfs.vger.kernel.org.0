Return-Path: <linux-nfs+bounces-6904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5702992266
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Oct 2024 01:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48FD3B21D27
	for <lists+linux-nfs@lfdr.de>; Sun,  6 Oct 2024 23:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BAB5733A;
	Sun,  6 Oct 2024 23:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="j6DeeESE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F/scWIJh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CC174ED0
	for <linux-nfs@vger.kernel.org>; Sun,  6 Oct 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728258832; cv=none; b=pLypGgzh+9i4Ni1skork8INzFNZAhVtvGGLHzcz6VRhJjwetwIavLmkfTyxCPfLrrMZby5/C/x4ci9JZcajLb5nj6EfKSywPDEO9haKRsC76kKPvBDRq+hnQrkQttwGRNOo7rKYSaxOWgfx1mW8iMGJB/jsr/DS31YFqE75A8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728258832; c=relaxed/simple;
	bh=IZg3uBShsBGejGjZD+i1wOqHzJQLOpLZJJLl3e2yc8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sfz6U/7UYprPgqJhwei4R5+FG3nwu98VbZMt25BAwu0UPsAynRw5sUfo12jbH56xttb/3aY/0JlgkO1lObmgXTsASU/s11pFDJ1/Hz01TA9Av3PhIrtzf0I2zdJh8B/D1Ff3sGn29qYzlAacLOy5+ftA7zT2SA6tCUGqf6tbuFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=j6DeeESE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F/scWIJh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id AC02B13800C3;
	Sun,  6 Oct 2024 19:53:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 06 Oct 2024 19:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728258828;
	 x=1728345228; bh=T5DrGPNdu0wIkxI0dOoyKc7O2PyobuV0fzUSusqHioI=; b=
	j6DeeESEQ273nMPprHw9Rzu0PW7JtQpgKtZhwemoMWiRVQkRzJ2lNYg+VoWpRKi9
	j5XiZJ0NOcG6oFFSW2DIYUxwc/6IS5g2h3eUmBKS80vFzYNAjcCpe38QBi5fWKuA
	t+V9Liv3WwltIKZuSz0lpU6mZB0sJ2j3RD+LYcfntUtWyyD6Q8YkVj+8Ya046dR8
	7LQsV7m2fYEY2fepNQHQago/EUWrULgV+aU6uRiVNiy/IzjxV+ZFbdShZaeNNP67
	77eo55FWuCr1iqn2QzfMs6qPGTb0xBm8XOy6CBW7+sjqjS9m7Kn1zba/hpwWEq/8
	5zV9MMXnri4DrYn3dXCXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728258828; x=
	1728345228; bh=T5DrGPNdu0wIkxI0dOoyKc7O2PyobuV0fzUSusqHioI=; b=F
	/scWIJhgGjh/8xC26MasVJC5Nuk4KJe2xdpzLgTRevviTTTw+ttEEr0U1LJrQ+dO
	36goja/Rc8hEN6L78s721fbwGS2y6Y04BrcfqP+Sp1qGmErY1PFD7myk7cMpGnr+
	t2dLGm5wqx7J8JY4Vk1AVZ4TzEjYLdzxHGAgmciqauP6NKavGFnY10BqVRpNYlJB
	mU8uHc6c/MoQXpQLq9i1h+x1cwFBiG4rli155XgUKaYdkfbSMCgBzaRyvlkkg3Fs
	IPTHxZRs5Ksh6YC71qqUc7/QSaZTrmSxHm2M47LSRoY8z63eXyZcdRlF1QkTySWx
	KplMQuVFBSCkwae/50+/A==
X-ME-Sender: <xms:DCMDZ6-DQQ0NECJZzrMw5eyfHYfhKONA7IPx8EeK083Rtco1wBEp1A>
    <xme:DCMDZ6tnfvAltw-2NULi-O7It_bH2EUzgdK95sV9_XcwSjPyKCrbaHjxL1QQr9aaG
    hNBYEY1r-gY>
X-ME-Received: <xmr:DCMDZwAe-snipljQQO-Vq7LNE-MGHpYtRPd0IVaL4xfGcmP4JHPnUpiZxKaEdY7ob8o_uNDlO8C_6Dt6GOB_dlhdNYolxGZNVmE2RN0grZwCg-fMyZvvgiwz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedgvdekucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:DCMDZycyVqPRei4GgxZ862majZKSIdzxJ8Z-kywug2Sfz_SIknwuCA>
    <xmx:DCMDZ_Mo-kY76t4UPQK-CTSDu5G9x_GvP8w4klYf-80npVEVS_o0iQ>
    <xmx:DCMDZ8ldOPQXB2NMCCxczzZtw8MEYXm9gkD4r_y_bBNAhTti6Ht1mw>
    <xmx:DCMDZxsWLNYTKYEinFEOd3xlcSM9yMhsgkHyLxgcuv_ZCfyk8MoNHw>
    <xmx:DCMDZ4ZBmBpjuG-7c_qV1IGT58dGYMUlF-P-bBNlBmOeIm0eA0x4aO4N>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Oct 2024 19:53:47 -0400 (EDT)
Message-ID: <eae570d0-7639-4467-98c6-b67fc1bdc292@themaw.net>
Date: Mon, 7 Oct 2024 07:53:41 +0800
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
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= xsFNBE6c/ycBEADdYbAI5BKjE+yw+dOE+xucCEYiGyRhOI9JiZLUBh+PDz8cDnNxcCspH44o
 E7oTH0XPn9f7Zh0TkXWA8G6BZVCNifG7mM9K8Ecp3NheQYCk488ucSV/dz6DJ8BqX4psd4TI
 gpcs2iDQlg5CmuXDhc5z1ztNubv8hElSlFX/4l/U18OfrdTbbcjF/fivBkzkVobtltiL+msN
 bDq5S0K2KOxRxuXGaDShvfbz6DnajoVLEkNgEnGpSLxQNlJXdQBTE509MA30Q2aGk6oqHBQv
 zxjVyOu+WLGPSj7hF8SdYOjizVKIARGJzDy8qT4v/TLdVqPa2d0rx7DFvBRzOqYQL13/Zvie
 kuGbj3XvFibVt2ecS87WCJ/nlQxCa0KjGy0eb3i4XObtcU23fnd0ieZsQs4uDhZgzYB8LNud
 WXx9/Q0qsWfvZw7hEdPdPRBmwRmt2O1fbfk5CQN1EtNgS372PbOjQHaIV6n+QQP2ELIa3X5Z
 RnyaXyzwaCt6ETUHTslEaR9nOG6N3sIohIwlIywGK6WQmRBPyz5X1oF2Ld9E0crlaZYFPMRH
 hQtFxdycIBpTlc59g7uIXzwRx65HJcyBflj72YoTzwchN6Wf2rKq9xmtkV2Eihwo8WH3XkL9
 cjVKjg8rKRmqIMSRCpqFBWJpT1FzecQ8EMV0fk18Q5MLj441yQARAQABzRtJYW4gS2VudCA8
 cmF2ZW5AdGhlbWF3Lm5ldD7CwXsEEwECACUCGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheA
 BQJOnjOcAhkBAAoJEOdnc4D1T9iphrYQALHK3J5rjzy4qPiLJ0EE9eJkyV1rqtzct5Ah9pu6
 LSkqxgQCfN3NmKOoj+TpbXGagg28qTGjkFvJSlpNY7zAj+fA11UVCxERgQBOJcPrbgaeYZua
 E4ST+w/inOdatNZRnNWGugqvez80QGuxFRQl1ttMaky7VxgwNTXcFNjClW3ifdD75gHlrU0V
 ZUULa1a0UVip0rNc7mFUKxhEUk+8NhowRZUk0nt1JUwezlyIYPysaN7ToVeYE4W0VgpWczmA
 tHtkRGIAgwL7DCNNJ6a+H50FEsyixmyr/pMuNswWbr3+d2MiJ1IYreZLhkGfNq9nG/+YK/0L
 Q2/OkIsz8bOrkYLTw8WwzfTz2RXV1N2NtsMKB/APMcuuodkSI5bzzgyu1cDrGLz43faFFmB9
 xAmKjibRLk6ChbmrZhuCYL0nn+RkL036jMLw5F1xiu2ltEgK2/gNJhm29iBhvScUKOqUnbPw
 DSMZ2NipMqj7Xy3hjw1CStEy3pCXp8/muaB8KRnf92VvjO79VEls29KuX6rz32bcBM4qxsVn
 cOqyghSE69H3q4SY7EbhdIfacUSEUV+m/pZK5gnJIl6n1Rh6u0MFXWttvu0j9JEl92Ayj8u8
 J/tYvFMpag3nTeC3I+arPSKpeWDX08oisrEp0Yw15r+6jbPjZNz7LvrYZ2fa3Am6KRn0zsFN
 BE6c/ycBEADZzcb88XlSiooYoEt3vuGkYoSkz7potX864MSNGekek1cwUrXeUdHUlw5zwPoC
 4H5JF7D8q7lYoelBYJ+Mf0vdLzJLbbEtN5+v+s2UEbkDlnUQS1yRo1LxyNhJiXsQVr7WVA/c
 8qcDWUYX7q/4Ckg77UO4l/eHCWNnHu7GkvKLVEgRjKPKroIEnjI0HMK3f6ABDReoc741RF5X
 X3qwmCgKZx0AkLjObXE3W769dtbNbWmW0lgFKe6dxlYrlZbq25Aubhcu2qTdQ/okx6uQ41+v
 QDxgYtocsT/CG1u0PpbtMeIm3mVQRXmjDFKjKAx9WOX/BHpk7VEtsNQUEp1lZo6hH7jeo5me
 CYFzgIbXdsMA9TjpzPpiWK9GetbD5KhnDId4ANMrWPNuGC/uPHDjtEJyf0cwknsRFLhL4/NJ
 KvqAuiXQ57x6qxrkuuinBQ3S9RR3JY7R7c3rqpWyaTuNNGPkIrRNyePky/ZTgTMA5of8Wioy
 z06XNhr6mG5xT+MHztKAQddV3xFy9f3Jrvtd6UvFbQPwG7Lv+/UztY5vPAzp7aJGz2pDbb0Q
 BC9u1mrHICB4awPlja/ljn+uuIb8Ow3jSy+Sx58VFEK7ctIOULdmnHXMFEihnOZO3NlNa6q+
 XZOK7J00Ne6y0IBAaNTM+xMF+JRc7Gx6bChES9vxMyMbXwARAQABwsFfBBgBAgAJBQJOnP8n
 AhsMAAoJEOdnc4D1T9iphf4QAJuR1jVyLLSkBDOPCa3ejvEqp4H5QUogl1ASkEboMiWcQJQd
 LaH6zHNySMnsN6g/UVhuviANBxtW2DFfANPiydox85CdH71gLkcOE1J7J6Fnxgjpc1Dq5kxh
 imBSqa2hlsKUt3MLXbjEYL5OTSV2RtNP04KwlGS/xMfNwQf2O2aJoC4mSs4OeZwsHJFVF8rK
 XDvL/NzMCnysWCwjVIDhHBBIOC3mecYtXrasv9nl77LgffyyaAAQZz7yZcvn8puj9jH9h+mr
 L02W+gd+Sh6Grvo5Kk4ngzfT/FtscVGv9zFWxfyoQHRyuhk0SOsoTNYN8XIWhosp9GViyDtE
 FXmrhiazz7XHc32u+o9+WugpTBZktYpORxLVwf9h1PY7CPDNX4EaIO64oyy9O3/huhOTOGha
 nVvqlYHyEYCFY7pIfaSNhgZs2aV0oP13XV6PGb5xir5ah+NW9gQk/obnvY5TAVtgTjAte5tZ
 +coCSBkOU1xMiW5Td7QwkNmtXKHyEF6dxCAMK1KHIqxrBaZO27PEDSHaIPHePi7y4KKq9C9U
 8k5V5dFA0mqH/st9Sw6tFbqPkqjvvMLETDPVxOzinpU2VBGhce4wufSIoVLOjQnbIo1FIqWg
 Dx24eHv235mnNuGHrG+EapIh7g/67K0uAzwp17eyUYlE5BMcwRlaHMuKTil6
In-Reply-To: <ef43bc4b-c445-4a0e-aaac-6cb57aca7c35@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 20:43, Steve Dickson wrote:
>
>
> On 10/4/24 10:58 PM, Ian Kent wrote:
>> Here we go again ...
>>
>> On 5/10/24 10:47, Ian Kent wrote:
>>> Umm, let's try that again ...
>>>
>>> On 5/10/24 10:41, Ian Kent wrote:
>>>> Hi Steve,
>>>>
>>>> On 5/10/24 03:54, Steve Dickson wrote:
>>>>> Hello,
>>>>>
>>>>> On 10/4/24 2:14 PM, Charles Hedrick wrote:
>>>>>> While looking into a problem that turns out to be somewhere else, 
>>>>>> I noticed that in gssd_proc.c , getpwuid is used. The context is 
>>>>>> threaded, and I verified with strace that the thread is sharing 
>>>>>> memory with other threads. I believe this should be changed to 
>>>>>> getpwuid_r. Similarly the following call to getpwnam.
>>>>>>
>>>>>> Is this the right place for reports on nfs-utils?
>>>>> Yes... but I'm not a fan of change code, that been around
>>>>> for a while, without fixing a problem... What problem does changing
>>>>> getpwuid to getpwuid_r fix?
>>>>>
>>>>> Patches are always welcome!
>>>>>
>>>>> steved.
>>>>>
>>>>>
>>>>
>>>> Yeah, getpwuid(3) and getpwnam() aren't thread safe and presumably 
>>>> gssd is a service so it
>>>>
>>>> could have multiple concurrent callers.
>>>>
>>>>
>>
>> [PATCH} nfs-utils: use getpwuid_r() and getpwnam_r() in gssd
>>
>>
>> gssd uses getpwuid(3) and getpwnam(3) in a pthreads context but
>> these functions are not thread safe.
>>
>> Signed-off-by: Ian Kent <raven@themaw.net>
>>
>> diff --git a/utils/gssd/gssd_proc.c b/utils/gssd/gssd_proc.c
>> index 2ad84c59..2a376b8f 100644
>> --- a/utils/gssd/gssd_proc.c
>> +++ b/utils/gssd/gssd_proc.c
>> @@ -489,7 +489,10 @@ success:
>>   static int
>>   change_identity(uid_t uid)
>>   {
>> -       struct passwd   *pw;
>> +       struct passwd  pw;
>> +       struct passwd *ppw;
>> +       char *pw_tmp;
>> +       long tmplen;
>>          int res;
>>
>>          /* drop list of supplimentary groups first */
>> @@ -502,15 +505,25 @@ change_identity(uid_t uid)
>>                  return errno;
>>          }
>>
>> +       tmplen = sysconf(_SC_GETPW_R_SIZE_MAX);
>> +       if (tmplen < 0)
>> +               bufsize = 16384;
>> +
>> +       pw_tmp = malloc(tmplen);
>> +       if (!pw_tmp) {
>> +               printerr(0, "WARNING: unable to allocate passwd 
>> buffer\n");
>> +               return errno ? errno : ENOMEM;
>> +       }
>> +
>>          /* try to get pwent for user */
>> -       pw = getpwuid(uid);
>> -       if (!pw) {
>> +       res = getpwuid_r(uid, &pw, pw_tmp, tmplen, &ppw);
>> +       if (!ppw) {
>>                  /* if that doesn't work, try to get one for "nobody" */
>> -               errno = 0;
>> -               pw = getpwnam("nobody");
>> -               if (!pw) {
>> +               res = getpwnam_r("nobody", &pw, pw_tmp, tmplen, &ppw);
>> +               if (!ppw) {
>>                          printerr(0, "WARNING: unable to determine 
>> gid for uid %u\n", uid);
>> -                       return errno ? errno : ENOENT;
>> +                       free(pw_tmp);
>> +                       return res ? res : ENOENT;
>>                  }
>>          }
>>
>> @@ -521,12 +534,13 @@ change_identity(uid_t uid)
>>           * other threads. To bypass this, we have to call syscall() 
>> directly.
>>           */
>>   #ifdef __NR_setresgid32
>> -       res = syscall(SYS_setresgid32, pw->pw_gid, pw->pw_gid, 
>> pw->pw_gid);
>> +       res = syscall(SYS_setresgid32, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>>   #else
>> -       res = syscall(SYS_setresgid, pw->pw_gid, pw->pw_gid, 
>> pw->pw_gid);
>> +       res = syscall(SYS_setresgid, pw.pw_gid, pw.pw_gid, pw.pw_gid);
>>   #endif
>> +       free(pw_tmp);
>>          if (res != 0) {
>> -               printerr(0, "WARNING: failed to set gid to %u!\n", 
>> pw-  >pw_gid);
>> +               printerr(0, "WARNING: failed to set gid to %u!\n", 
>> pw.pw_gid);
>>                  return errno;
>>          }
>>
>>
> checking file utils/gssd/gssd_proc.c
> Hunk #1 FAILED at 489.
> Hunk #2 FAILED at 502.
> Hunk #3 FAILED at 521.
> 3 out of 3 hunks FAILED
>
> What branch are you applying this patch to?
> Maybe it is me copying the patch over...
>
> Try git format-patch that seems to work.

Opps, sorry!

I thought it was the nfs-utils repo. main branch ...


Maybe the patch has DOS carriage controls, I see that a lot myself.

If a simple dos2unix doesn't fix it I'll start checking my end and use the

"git format-patch", "git send-email" pair.


Ian


