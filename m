Return-Path: <linux-nfs+bounces-8320-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4769E1B9E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 13:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23B6516034E
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Dec 2024 12:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F111E410E;
	Tue,  3 Dec 2024 12:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hQ4A9kk7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB711E3DFD
	for <linux-nfs@vger.kernel.org>; Tue,  3 Dec 2024 12:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227452; cv=none; b=eLI8ZW5N6+Yru4s1rBWsU/tpe3kxv9RPzdFFMmGcy98zD1SXEL0bCsdwxMOud0LQuprGyyfOuQtSlgGYrrSlL3zWV8dn9OREgCVl77UWNVG3++kjAEm1GtwIzJ2BDKU0HAyjvNiHYun9uFPYCK5sBWR0H547+81UnSw+KRsKfB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227452; c=relaxed/simple;
	bh=cvYdqYhnAARopE7CJZhr+GBezVBvScjdwVP3Wz5DfbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OCcnt/PC4XipAgdKV0/J7Ox/JPaEGT2OyXwHENPYWGpl/b38lqVSmC35fAEJ2Gq8IlxSpoXMeQ0Qs3SfcjSXdGhdJqUS+CwCR4NnsnfdobxtKTd5GjsH2Uk6g6U8MA4TedF5QhOMWcRcIJdQU5rZY7845t2sUVd2ie9JoXXfYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hQ4A9kk7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733227449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QheyITusSom6GwJgPCJRrDHk6u7BUIRW5lpuj9iGQIw=;
	b=hQ4A9kk7AsAFkp/OdCGcYc8AMxyvY0k/QRgSmPtJUOz9aV2gwpodMApEXY2kUhgFLmssdg
	aJni8tvEwbn+J6iBSYYNOguyDH5jBLu7SQak0Jz2iGxb84QnOfArTQ6u8xkW8X+/vASDuT
	b8wjrd5HkNmeHWVdYLiPoWZsiKiaa0c=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-4v_4HvxMNeSjf2egnkkXfA-1; Tue, 03 Dec 2024 07:04:07 -0500
X-MC-Unique: 4v_4HvxMNeSjf2egnkkXfA-1
X-Mimecast-MFC-AGG-ID: 4v_4HvxMNeSjf2egnkkXfA
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841843a9970so496460339f.3
        for <linux-nfs@vger.kernel.org>; Tue, 03 Dec 2024 04:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733227446; x=1733832246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QheyITusSom6GwJgPCJRrDHk6u7BUIRW5lpuj9iGQIw=;
        b=KeKZbmHIZ5R+Am9TPccQNvXXmP6Z3Rn399iSSLD2lRCoxM028lCKvC8IA1NWV3rqD9
         GolkMGOCcZ3zeNw1/u7QqPyNEKxE/QF0GUbdPYKDzaMXdTDUHXju0xMxMwlyyHf85dZK
         nKtEJqDmuE52M7Zv9fftbgiGtbrlp2DeDg9PShlwuxGiB61p3gYKRZzJw19e8y0GW2e6
         00QUbDbjUCR4hKngdU0rUaEVkZY80qQ1Sv7q4e+x8CiphPopPvpo0FvI1kp1qakScgM+
         VrGkSgYCnBPIBCVkkJkmkAZ1iunUx6y64WIBDa11DmRgyKTxMHoAAnirTJ7EzbJtyU46
         EnqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh8i9RJ+Snwyd25Fau+ERsDBGItKLWZzZ9al1C2oE1XYRQrk8lVQJVE4P32EnJf3PSGVHO3a/FBp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ZDNS4y9gq8C6rllqkvC0JyWNWZEHJClf8R08uiJ5OtHo4T03
	jxOVQPSYR6L3BR/QMtq4mhzN/oYrz7KvlwE782L8xo1ABpwYqGsADVsS6OO+65uzxq8WkJqxAnC
	pHPagJyCaYVJtdPQ46OHjvnWaz6EuHNSXAz4p0Lg9q5Gh5SYBkb9A7ErJbQ==
X-Gm-Gg: ASbGncuhHh8nGghtkhgxieuq2lgZxYIT+EUcllD/rpAeY0OzNH+yyWbOZEa7wcc8AiT
	biUZBv0Jr6i22zjfCnApSNvtXTXr2t3ibG4Z1UPZqYxAcS5lwgDmwR5yb73Uq902IbxFHh5aHtU
	v1jwkhswM4R77APaYEaEWz4K2jnfV2MWlzNGtV1UjttLmxy8TWPpJl73yvSnvAV1JrcWFAaXVHj
	s3yYxdqdwros2WdN4FzVEln/+YaQ+4KWPenQEQZ5Ki3L27tNg==
X-Received: by 2002:a05:6602:6d0e:b0:843:f261:60e0 with SMTP id ca18e2360f4ac-8445b556cebmr323502739f.5.1733227445749;
        Tue, 03 Dec 2024 04:04:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKV1Xd32JETczqfeUUD07PCAa/s8bUrBYP4MfosB7E1YzZPlR79Pm+2BXx9MhIcooXjiDo/g==
X-Received: by 2002:a05:6602:6d0e:b0:843:f261:60e0 with SMTP id ca18e2360f4ac-8445b556cebmr323481839f.5.1733227443941;
        Tue, 03 Dec 2024 04:04:03 -0800 (PST)
Received: from [172.31.1.12] ([70.105.249.243])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e230e5f21esm2557522173.80.2024.12.03.04.04.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 04:04:02 -0800 (PST)
Message-ID: <577509ce-fbbb-4715-8fe3-33cd66c89589@redhat.com>
Date: Tue, 3 Dec 2024 07:04:00 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFSv4 referrals broken when not enabling junction support
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Sam Hartman <hartmans@debian.org>, Anton Lundin <glance@ac2.se>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <Zv7NRNXeUtzpfbJg@eldamar.lan>
 <e7341203-c53c-4005-9d70-239073352b2b@redhat.com>
 <ZxUVlpd0Ec5NaWF1@eldamar.lan> <Zxv8GLvNT2sjB2Pn@eldamar.lan>
 <1fc7de18-eaf0-4a1e-bd41-e6072b0f3d7f@redhat.com>
 <Z0VVLw9htR7_C5Bc@elende.valinor.li>
 <e86284ac-7a77-440b-bb5d-bdb1e6f23a40@redhat.com>
 <Z04OnJtb1oDl5sfd@eldamar.lan>
 <328fdce3-a66b-4254-a178-389caf75a685@redhat.com>
 <A8C1C88C-35D5-43D1-B848-1E0CF337F1F6@oracle.com>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <A8C1C88C-35D5-43D1-B848-1E0CF337F1F6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/2/24 3:02 PM, Chuck Lever III wrote:
> 
> 
>> On Dec 2, 2024, at 2:57 PM, Steve Dickson <steved@redhat.com> wrote:
>>
>>
>>
>> On 12/2/24 2:46 PM, Salvatore Bonaccorso wrote:
>>> Hi Steve,
>>> On Mon, Dec 02, 2024 at 01:26:46PM -0500, Steve Dickson wrote:
>>>>
>>>>
>>>> On 11/25/24 11:57 PM, Salvatore Bonaccorso wrote:
>>>>> Hi Steve,
>>>>>
>>>>> On Sat, Oct 26, 2024 at 09:04:01AM -0400, Steve Dickson wrote:
>>>>>>
>>>>>>
>>>>>> On 10/25/24 4:14 PM, Salvatore Bonaccorso wrote:
>>>>>>> Hi Steve,
>>>>>>>
>>>>>>> On Sun, Oct 20, 2024 at 04:37:10PM +0200, Salvatore Bonaccorso wrote:
>>>>>>>> Hi Steve,
>>>>>>>>
>>>>>>>> On Tue, Oct 08, 2024 at 06:12:58AM -0400, Steve Dickson wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 10/3/24 12:58 PM, Salvatore Bonaccorso wrote:
>>>>>>>>>> Hi Steve, hi linux-nfs people,
>>>>>>>>>>
>>>>>>>>>> it got reported twice in Debian that  NFSv4 referrals are broken when
>>>>>>>>>> junction support is disabled. The two reports are at:
>>>>>>>>>>
>>>>>>>>>> https://bugs.debian.org/1035908
>>>>>>>>>> https://bugs.debian.org/1083098
>>>>>>>>>>
>>>>>>>>>> While arguably having junction support seems to be the preferred
>>>>>>>>>> option, the bug (or maybe unintended behaviour) arises when junction
>>>>>>>>>> support is not enabled (this for instance is the case in the Debian
>>>>>>>>>> stable/bookworm version, as we cannot simply do such changes in a
>>>>>>>>>> stable release; note later relases will have it enabled).
>>>>>>>>>>
>>>>>>>>>> The "breakage" seems to be introduced with 15dc0bead10d ("exportd:
>>>>>>>>>> Moved cache upcalls routines  into libexport.a"), so
>>>>>>>>>> nfs-utils-2-5-3-rc6 as this will mask behind the #ifdef
>>>>>>>>>> HAVE_JUNCTION_SUPPORT's code which seems needed to support the refer=
>>>>>>>>>> in /etc/exports.
>>>>>>>>>>
>>>>>>>>>> I had a quick conversation with Cuck offliste about this, and I can
>>>>>>>>>> hopefully state with his word, that yes, while nfsref is the direction
>>>>>>>>>> we want to go, we do not want to actually disable refer= in
>>>>>>>>>> /etc/exports.
>>>>>>>>> +1
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Steve, what do you think? I'm not sure on the best patch for this,
>>>>>>>>>> maybe reverting the parts masking behind #ifdef HAVE_JUNCTION_SUPPORT
>>>>>>>>>> which are touched in 15dc0bead10d would be enough?
>>>>>>>>> Yeah there is a lot of change with 15dc0bead10d
>>>>>>>>>
>>>>>>>>> Let me look into this... At the up coming Bake-a-ton [1]
>>>>>>>>
>>>>>>>> Thanks a lot for that, looking forward then to a fix which we might
>>>>>>>> backport in Debian to the older version as well.
>>>>>>>
>>>>>>> Hope the Bake-a-ton was productive :)
>>>>>>>
>>>>>>> Did you had a chance to look at this issue beeing there?
>>>>>> Yes I did... and we did talk about the problem.... still looking into it.
>>>>>
>>>>> Reviewing the open bugs in Debian I remembered of this one. If you
>>>>> have already a POC implementation/bugfix available, would it help if I
>>>>> prod at least the two reporters in Debian to test the changes?
>>>>>
>>>>> Thanks a lot for your work, it is really appreciated!
>>>> I was not able to reproduce this at the Bakeathon
>>>> with the latest nfs-utils... and today I took another
>>>> look today...
>>>>
>>>> Would mind showing me the step that cause the error
>>>> and what is the error?
>>> Let me ask the two reporters in Debian, Cc'ed.
>>> Sam, Anton can you provide here how to reproduce the issue with
>>> nfs-utils which you reported?
>> Please note setting "enable-junction=no" does disable
>> the referral code. aka in dump_to_cache()
>>
>> #ifdef HAVE_JUNCTION_SUPPORT
>>         write_fsloc(&bp, &blen, exp);
>> #endif
>>
>> So unless I'm not understanding something (which is very possible :-) )
>> disabling junctions also disables referrals.
> 
> Disabling junction support is not supposed to disable referrals.
> Referrals worked long before junction support was added, and
> stopped working in this configuration with the commit that
> Salvatore bisected to.
Got it... thanks!

steved.
> 
> 
>> steved.
>>
>>> Context:
>>> - https://bugs.debian.org/1035908
>>> - https://bugs.debian.org/1083098
>>> Regards,
>>> Salvatore
>>
> 
> --
> Chuck Lever
> 
> 


