Return-Path: <linux-nfs+bounces-5319-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E6D94EFBC
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 16:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69DD11C218FD
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Aug 2024 14:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE74E17E8E2;
	Mon, 12 Aug 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONG57icB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA414C5A4
	for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473454; cv=none; b=J84a3FtExg53dz5VbcZDEegeZhl4j+ezQsrNDgh1+Tg2BHaY6/tOQxOaftxI58CoxYK8wrSW1+LkTpFwVokwmV9J6mDO5oGYzO/2wEvJ1usGmqyV6mJf8YktPSkvdxwqGsorWrxV/SiuhdQQkXcnZhBl2KYquxKUTES2yIblFy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473454; c=relaxed/simple;
	bh=EreYBNmKRHrtgzo+Csp8FWWyCzvRoLLpPkcbQ9IW5dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcw8O2kGVxYiwWk2S+CuNlnF0BY4Cx2BDFPpe+4Z5+1Q4ssspOKlbt6vgdBisESOEooRWK4AGMVzvwGLTMuN6khnqy0kQk9/KvKREkIrX1CAi4k2H/d3NAm6XO1yeT2iiGMdU+3Vk1y8SuCLhPqJgA/dpM2do+RtZyf7PmQ1rqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONG57icB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cd5d6b2581so2864234a91.2
        for <linux-nfs@vger.kernel.org>; Mon, 12 Aug 2024 07:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723473452; x=1724078252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FgMx5pp8nZPjJu9c5qOrslbYa/zsB0uys3gmflrx1w=;
        b=ONG57icB2SL8MoxSeD+TwwZpHmyTX1DCs3+x7+Tc4Ytq4Z0jwRp/jqQBvkFf6bj4aH
         srScH6V/m/nRQXxmyBFyVfFpeBgaILRD65DTtiYo+uCHbkbpWrFPOMRy9QSd8JjzdiBK
         gCMeP4+wdUAJVYsafrR7a1Ntn0Wn6v8mbL5aaTbkze1f55wiH3ZwoSfP51GD7lT9+vCZ
         mTJsfpGP2PAoTGCvPbqR14I8SRKnSSY/1ECu5gjkgQzcDPu+QvtB6pwmpdsD5J39+8PN
         9OtWzHxPcNpkc3x7KEMzNwjpt8g9eKB6klgTLNCGyt27C9vTBVpt8NbjeZE/JfdS2iVk
         aGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473452; x=1724078252;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7FgMx5pp8nZPjJu9c5qOrslbYa/zsB0uys3gmflrx1w=;
        b=rHvP7wJDQ9T9s6f2pT3C1TvKaD0mhmO6AhTebNSLXtznQkvTTulH3ZReErBUntvTz0
         lQXhCDtJxji4tTWADRd2oo9lq/XbAuzDZUZfrpoo9d56NvR8Rr0RyeTbYAZqKarQ1iX8
         pHihRKYrlQYA0AS2bd2R4OfZPCi8pkwZg8GoxwzqAN+5aH8f44pfKNMQ61tGBmp9+okA
         wbESTyiVk0LDZrCeZZUHY/htVNF+9cOILH30c8dw5TiwE2xCd3aOP1aeX0xFbH/7TWJG
         1+3mf1TxXlLycnxdVu1cqqeFpZJug2dWL/2gmiMy1PWKRLo9gLv2ERTC/4MvMaXb4qCZ
         36mw==
X-Forwarded-Encrypted: i=1; AJvYcCU9lK9OM2JV2KvpzXsRE7Yl/PktK52X7GKZKek8lKAvbJUknIHV+at7sWPc3kjjccXVoHyR8YJTVJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkoYXA8v1CzLOiZSv9Klwy/JteSvNzA0H44KT8wrz1Aag39pLl
	3wqpz0Aacg6AOYAdQ4dFdrDXbnztNrRiqP1PLACMZWOMD3TsFpLl
X-Google-Smtp-Source: AGHT+IEOOrKd3lXQSDb8r8OERsXDoDweApZGESxcTgtmzScHPzcwlZhVBKqSioPHVD2FWmR/fIOWcA==
X-Received: by 2002:a17:90b:4a46:b0:2c9:7e9e:70b3 with SMTP id 98e67ed59e1d1-2d392641d59mr451738a91.33.1723473452313;
        Mon, 12 Aug 2024 07:37:32 -0700 (PDT)
Received: from [192.168.86.113] (syn-076-091-193-045.res.spectrum.com. [76.91.193.45])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6d083sm5172691a91.4.2024.08.12.07.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:37:31 -0700 (PDT)
Message-ID: <e9b083fa-537c-48ea-9338-d11d206d7c16@gmail.com>
Date: Mon, 12 Aug 2024 07:37:30 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS client to pNFS DS
Content-Language: en-US
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc: Olga Kornievskaia <aglo@umich.edu>,
 schumaker anna <schumaker.anna@gmail.com>,
 linux-nfs <linux-nfs@vger.kernel.org>,
 Trond Myklebust <trondmy@hammerspace.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
 <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
 <24bf013f-78af-4d05-80ae-1b35ed54c6a0@gmail.com>
 <1030980705.45726678.1723445525556.JavaMail.zimbra@desy.de>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <1030980705.45726678.1723445525556.JavaMail.zimbra@desy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I confirmed that it was Ganesha problem, it was configured to be DS but 
for some reason it responded to EXCHANGE_ID that it is not a DS so the 
client switched back to the MDS. Again wondering if Ganesha is used for 
pNFS by anyone.

Thank you all for the help, Marc.

On 8/11/24 11:52 PM, Mkrtchyan, Tigran wrote:
>
> ----- Original Message -----
>> From: "marc eshel" <eshel.marc@gmail.com>
>> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>, "Olga Kornievskaia" <aglo@umich.edu>
>> Cc: "schumaker anna" <schumaker.anna@gmail.com>, "linux-nfs" <linux-nfs@vger.kernel.org>, "Trond Myklebust"
>> <trondmy@hammerspace.com>
>> Sent: Sunday, 11 August, 2024 21:50:36
>> Subject: Re: NFS client to pNFS DS
>> On 8/11/24 12:41 PM, Mkrtchyan, Tigran wrote:
>>>> On 10. Aug 2024, at 23:20, Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>
>>>> ﻿On Fri, Aug 9, 2024 at 12:27 PM marc eshel <eshel.marc@gmail.com> wrote:
>>>>> On 8/9/24 8:15 AM, Olga Kornievskaia wrote:
>>>>>> On Fri, Aug 9, 2024 at 10:09 AM marc eshel <eshel.marc@gmail.com> wrote:
>>>>>>> Thanks for the replies, I am a little rusty with debugging NFS but this what I
>>>>>>> see when the NFS client tried to create a session with the DS.
>>>>>>>
>>>>>>> Ganesha was configured for sec=sys and the client mount had the option sec=sys,
>>>>>>> I assume flavor 390004 means it was trying to use krb5i.
>>>>>> For 4.1, the client will always try to do state operations with krb5i
>>>>>> even when sec=sys when the client detects that it's configured to do
>>>>>> Kerberos (ie., gssd is running). This context creation is triggered
>>>>>> regardless of whether the rpc client is used for MDS or DS.
>>>>>>
>>>>>> My question to you: is the MDS configured with Kerberos but the DS
>>>>>> isn't? And also, does this lead to a failure?
>>>>> Both MDS DS are configured for sec=sys and it is leading to client
>>>>> switching from DS to MDS so yes, it is pNFS failure. What I see on the
>>>>> DS is the client creating a session and than imminently destroying it
>>>>> before committing it. If the is something else that I can debug I will
>>>>> be happy to.
>>>> pnfs failure is unexpected. I'm pretty confident that a non-kerberos
>>>> configured client can do normal pnfs with sec=sys. I can help debug,
>>> Yes, I can confirm that. All RHEL kernels and weekly -rc kernels from Linus
>>> works as expected. We mount always with sec=sys, and despite the fact, that
>>> hosts configured to support kerberos due to AFS and GPFS, the access to DSes is
>>> never an issue and never tries to use kerberos.
>>>
>>> Tigran.
>> Hi Tigran,
>>
>> It is possible that it is failing back to MDS for another reason and the
>> error message that I see is not the reason for the failure. Are you
>> using pNFS with Ganesha and GPFS?
>>
>> Marc.
> Hi Marc,
>
> pNFS is used exclusively with dCache. Can you provide the packet capture
> of failing pNFS traffic, like mount + cp + umount?
>
> Best regards,
>     Tigran.
>
>>>> if you want to send me a network trace and tracepoint output. Btw what
>>>> kernel/distro are you using?
>>>>
>>>>> Marc.
>>>>>
>>>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC: Couldn't create
>>>>>>> auth handle (flavor 390004)
>>>>>>>
>>>>>>> Marc.
>>>>>>>
>>>>>>> On 8/9/24 6:06 AM, Anna Schumaker wrote:
>>>>>>>
>>>>>>> On Thu, Aug 8, 2024 at 6:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>>>
>>>>>>> On Mon, Aug 5, 2024 at 5:51 PM marc eshel <eshel.marc@gmail.com> wrote:
>>>>>>>
>>>>>>> Hi Trond,
>>>>>>>
>>>>>>> Will the Linux NFS client try to us krb5i regardless of the MDS
>>>>>>> configuration?
>>>>>>>
>>>>>>> Is there any option to avoid it?
>>>>>>>
>>>>>>> I was under the impression the linux client has no way of choosing a
>>>>>>> different auth_gss security flavor for the DS than the MDS. Meaning
>>>>>>>
>>>>>>> That's a good point, I completely missed that this is specifically for the DS.
>>>>>>>
>>>>>>> that if mount command has say sec=krb5i then both MDS and DS
>>>>>>> connections have to do krb5i and if say the DS isn't configured for
>>>>>>> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
>>>>>>>
>>>>>>> That's what I would expect, too.
>>>>>>>
>>>>>>> server to verify whether or not what I say is true but that is what my
>>>>>>> memory tells me is the case.
>>>>>>>
>>>>>>>
>>>>>>> Thanks, Marc.
>>>>>>>
>>>>>>> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>>>>>> stripe count 1
>>>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>>>>>> ds_num 1
>>>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC: Couldn't create
>>>>>>> auth handle (flavor 390004)
>>>>>>>

