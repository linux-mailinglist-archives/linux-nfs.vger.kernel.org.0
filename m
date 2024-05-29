Return-Path: <linux-nfs+bounces-3473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FDD8D3790
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 15:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD1C1C223DD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 May 2024 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D230B125C0;
	Wed, 29 May 2024 13:27:47 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33E11CAB
	for <linux-nfs@vger.kernel.org>; Wed, 29 May 2024 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989267; cv=none; b=cfLAmZWFtR38RXnuX5SzAs6ANB5nI7NQYXi2qMUeORtYJCRAWgS33/X3Sm2jBetX1Z4D3ny8fdU9RMGKj0yVJYBWLmOHfa6irt+PrORml2gnkdmhV2OqSIrELbf/MD2ZU0ad8H8mFAIfxQqA9lQYW2Of0AiTv1vyeq3gTFxNvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989267; c=relaxed/simple;
	bh=bwtTE9NSFG/4aYBnRtO/O9C2cPX57zcCPDlp6mv3sS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huzVjlCNIiJVT8yuSt0GzaxofuocjfdPUfFlcZ/4l/xeNIlD389LiZ+RKB31779fknCl6wsLzLpwCXjoNezNuQ+AVHzw/8HwdTqiKmB3NUNrnVis634L44i6Knje/A7Pbc0K+v8B+KxYqck9ntWRVU9DUDXT/TXBgQOY5TgsN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.56] (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 71B9961E5FE01;
	Wed, 29 May 2024 15:27:07 +0200 (CEST)
Message-ID: <d2ab4ee7-ba0f-44ac-b921-90c8fa5a04d2@molgen.mpg.de>
Date: Wed, 29 May 2024 15:27:07 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSD: Unable to initialize client recovery tracking! (-110)
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever III <chuck.lever@oracle.com>
Cc: regressions@lists.linux.dev, linux-nfs@vger.kernel.org,
 it+linux-nfs@molgen.mpg.de, Linus Torvalds <torvalds@linux-foundation.org>
References: <aaeae060-2be0-4b9f-818c-1b7d87e41a5f@molgen.mpg.de>
 <e8ab863e-18a5-4c16-b0c8-a3ab6440a9f6@molgen.mpg.de>
 <5096230634b5bab2e5094c0d52780ffe2fa75bb9.camel@kernel.org>
 <90700421-4567-4e28-ae71-8541086b46e2@leemhuis.info>
 <5360A648-8236-466C-A9D8-82F2BBE6F059@oracle.com>
 <fcec2a033773a2129e0271c870d1116681feccfb.camel@kernel.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <fcec2a033773a2129e0271c870d1116681feccfb.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jeff, dear Chuck, dear Thorsten,


Thank you for your responses, and sorry for not replying earlier.

Am 29.05.24 um 15:13 schrieb Jeff Layton:
> On Fri, 2024-05-24 at 16:09 +0000, Chuck Lever III wrote:

>>> On May 24, 2024, at 7:16 AM, Linux regression tracking (Thorsten
>>> Leemhuis) wrote:
>>>
>>> On 21.05.24 12:01, Jeff Layton wrote:
>>>> On Tue, 2024-05-21 at 11:55 +0200, Paul Menzel wrote:
>>>>> Am 19.04.24 um 18:50 schrieb Paul Menzel:
>>>>>
>>>>>> Since at least Linux 6.8-rc6, Linux logs the warning below:
>>>>>>
>>>>>>      NFSD: Unable to initialize client recovery tracking! (-110)
>>>>>>
>>>>>> I haven’t had time to bisect yet, so if you have an idea,
>>>>>> that’d be great.
>>>>>
>>>>> 74fd48739d0488e39ae18b0168720f449a06690c is the first bad commit
>>>>> commit 74fd48739d0488e39ae18b0168720f449a06690c
>>>>> Author: Jeff Layton <jlayton@kernel.org>
>>>>> Date:   Fri Oct 13 09:03:53 2023 -0400
>>>>>
>>>>>      nfsd: new Kconfig option for legacy client tracking
>>>>>
>>>>>      We've had a number of attempts at different NFSv4 client tracking
>>>>>      methods over the years, but now nfsdcld has emerged as the clear winner
>>>>>      since the others (recoverydir and the usermodehelper upcall) are
>>>>>      problematic.
>>>> [...]
>>>> It sounds like you need to enable nfsdcld in your environment. The old
>>>> recovery tracking methods are deprecated. The only surviving one
>>>> requires the nfsdcld daemon to be running when recovery tracking is
>>>> started. Alternately, you can enable this option in your kernels if you
>>>> want to keep using the deprecated methods in the interim.
>>>
>>> Hmm. Then why didn't this new config option default to "Y" for a while
>>> (say a year or two) before changing the default to off? That would have
>>> prevented people like Paul from running into the problem when running
>>> "olddefconfig". I think that is what Linus would have wanted in a case
>>> like this, but might be totally wrong there (I CCed him, in case he
>>> wants to share his opinion, but maybe he does not care much).
>>
>> That's fair. I recall we believed at the time that very few people
>> if anyone currently use a legacy recovery tracking mechanism, and
>> the workaround, if they do, is easy.
>>
>>> But I guess that's too late now, unless we want to meddle with config
>>> option names. But I guess that might not be worth it after half a year
>>> for something that only causes a warning (aiui).
>>
>> In Paul's case, the default behavior might prevent proper NFSv4
>> state recovery, which is a little more hazardous than a mere
>> warning, IIUC.
>>
>> To my surprise, it often takes quite some time for changes like
>> this to matriculate into mainstream usage, so half a year isn't
>> that long. We might want to change to a more traditional
>> deprecation path (default Y with warning, wait, default N, wait,
>> redact the old code).
> 
> I've no objection if you want to do that.
> 
> I'm more concerned about Paul's setup though. Paul, what distro are you
> running that starts nfsd (and presumably, mountd, etc.), but doesn't
> bother starting nfsdcld?
> 
> Reenabling this for now is an OK workaround, but we need to understand
> where these setups are coming from, and probably do some sort of
> outreach to get them working properly.

Thank you for the explanation. Due to historical reasons we maintain our 
own distribution MarIuX64 [1] and currently run Linux 5.15.x and 6.6.x. 
Installing nfsdcld is no problem, but it would have been nice to make 
this clearer in the error message, so people without being NFSD experts 
getting this message, knew what to do right away. Maybe:

NFSD: Unable to initialize client recovery tracking! (-110) Is nfsdcld 
running? Otherwise enable NFSD_LEGACY_CLIENT_TRACKING.


Kind regards,

Paul


[1]: https://github.molgen.mpg.de/mariux64/bee-files/
[2]: https://github.molgen.mpg.de/mariux64/bee-files/pull/3111

