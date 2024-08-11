Return-Path: <linux-nfs+bounces-5305-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1BF94E2D4
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 21:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AFBF1C208E5
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Aug 2024 19:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6071547E4;
	Sun, 11 Aug 2024 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2eDbH4H"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B454526ACB
	for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723405840; cv=none; b=iu5up8P/l6cRBhnR8dAq15YE9ft4O/sE+lEe4JqYL+p1EvLMMfoAKKZ03kpWq/WPQOS/B0OqAvXwxTtsOonNdlPhU/7mOGjfWOIy3jmQCSicfmUld+mmPQKWA29shEebJ5MP1VNGCQWL96Qph/g+YciuZ01Y2oRDbAfqmv+gLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723405840; c=relaxed/simple;
	bh=GddqtmpooNTTIihhRpAXOm6clrljH3p3PV47in4gUiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qmXQOtrKTUggsfhG/6NNNdx/knTWKwC24n2hFr672A32VuDQD2ZscLHBnDO6y5VktLHGmwncAOCRvRU5Au2juYkVFmx4uhFELhyS7elrcpvHrE1yxn/9lHvr07WUiw/Hlocxxo6i06jT9/wubLXGlXsJenCuZZO94wUw7QLGmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2eDbH4H; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-710ec581999so1010987b3a.2
        for <linux-nfs@vger.kernel.org>; Sun, 11 Aug 2024 12:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723405838; x=1724010638; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qeoGOgzPbQB7C2LuHl09vcqZZw19yc52YYo1wyEBEGA=;
        b=S2eDbH4HFEf2MbOKx7RgVjuZsl5E8rTRN166YjoV8MtX58sMA6wnhObqbqdsoDT0z/
         UdUKaCryZGaefCTGX8q6kbRhRxsGumQDlcJ+Dbr1sb24+GEv7yILbS6oL2VfjC0wyt1j
         fHtmNdRFlr3qFCsHGAQ7L7kgqndW1C/MxLPFQSrcXf3inMMmCOLPv+VGXyDpGCKM43el
         C/OGuCaBbcTy4j+ZRVz3j1noA+wQVFOfZSKHUEL9L1MdsxAgcwINsqyF5SiXUgkPBCAP
         ygiEpwGNq/cqTR35qLJpEWYTkCoqPjrbEdZERXDWBxp7l0M7IwEyZ5uPTjbMctuL5LIq
         VEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723405838; x=1724010638;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qeoGOgzPbQB7C2LuHl09vcqZZw19yc52YYo1wyEBEGA=;
        b=MmfwJ12oGIINjPSQzokCXXSUSEImONEyH58RArr/rW9VeI5B/8KkFCUJjjB/Rtph8Q
         zsww9/pHyFn9zlaVIc/2vd+L3mVJ8cSgCs/xnTnsySyherQcFhacC9dlWCaM7c9cc3EI
         NBX9jEWjQZ2l2z4kA/2UyZY6ybBapxhUIpTd0Kmhy/IaXwV6P8GMsthL3E8bRPQh54/B
         N0MnmyPSLRZQXpuvadhxnrD6lRsehw1GYv/VahBqKXdpbg0MbSJ19GvOcRNAQgu+7Au+
         J25FWP2bDRU2Oma9LCNtjxAsoUi2xNs58yiMqTxC9lZyk2UYhlTQOV5tgjLplB58G8WO
         YI9A==
X-Forwarded-Encrypted: i=1; AJvYcCXc66fgL9dW6ag232CFn3xpklYJ94eN0uhjt5Dxw356XYlRxEOLgGcG5y+UmsRWgb4zZBoFXalk1FsQSzSTE2Ex2nv4V+8B6M9e
X-Gm-Message-State: AOJu0Yx3UiVKYuHIPta2b2hSgLvxuykTyz8ZGcM5RbiIIUj11xh4TvZN
	+PCMyfEWufF67FlcUXkwfcFvYYuN2W3tB5m4st25zIeFYNe6BrMrB5ZCtGju
X-Google-Smtp-Source: AGHT+IETT6ZLQlgua9m3KXgtC6Z7UdZY1/94ZEDMsSPMUQgsjIlkxALoK1D+kSZuxzWk6drHy4MqWg==
X-Received: by 2002:a05:6a20:9f9b:b0:1c4:87b2:e07d with SMTP id adf61e73a8af0-1c89ff243a9mr10974011637.16.1723405837775;
        Sun, 11 Aug 2024 12:50:37 -0700 (PDT)
Received: from [192.168.86.113] (syn-076-091-193-045.res.spectrum.com. [76.91.193.45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5a89dfesm2698597b3a.159.2024.08.11.12.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 12:50:37 -0700 (PDT)
Message-ID: <24bf013f-78af-4d05-80ae-1b35ed54c6a0@gmail.com>
Date: Sun, 11 Aug 2024 12:50:36 -0700
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NFS client to pNFS DS
Content-Language: en-US
To: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>,
 Olga Kornievskaia <aglo@umich.edu>
Cc: Anna Schumaker <schumaker.anna@gmail.com>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trondmy@hammerspace.com>
References: <CAN-5tyHXg8=Sv8MS7vJUwG+=Av8oL6Bk_ZDDfwjEf3-R0KT=dg@mail.gmail.com>
 <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
From: marc eshel <eshel.marc@gmail.com>
In-Reply-To: <685478263.45656552.1723405271880.JavaMail.zimbra@z-mbx-2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/11/24 12:41 PM, Mkrtchyan, Tigran wrote:
>> On 10. Aug 2024, at 23:20, Olga Kornievskaia <aglo@umich.edu> wrote:
>>
>> ﻿On Fri, Aug 9, 2024 at 12:27 PM marc eshel <eshel.marc@gmail.com> wrote:
>>>
>>> On 8/9/24 8:15 AM, Olga Kornievskaia wrote:
>>>> On Fri, Aug 9, 2024 at 10:09 AM marc eshel <eshel.marc@gmail.com> wrote:
>>>>> Thanks for the replies, I am a little rusty with debugging NFS but this what I see when the NFS client tried to create a session with the DS.
>>>>>
>>>>> Ganesha was configured for sec=sys and the client mount had the option sec=sys, I assume flavor 390004 means it was trying to use krb5i.
>>>> For 4.1, the client will always try to do state operations with krb5i
>>>> even when sec=sys when the client detects that it's configured to do
>>>> Kerberos (ie., gssd is running). This context creation is triggered
>>>> regardless of whether the rpc client is used for MDS or DS.
>>>>
>>>> My question to you: is the MDS configured with Kerberos but the DS
>>>> isn't? And also, does this lead to a failure?
>>> Both MDS DS are configured for sec=sys and it is leading to client
>>> switching from DS to MDS so yes, it is pNFS failure. What I see on the
>>> DS is the client creating a session and than imminently destroying it
>>> before committing it. If the is something else that I can debug I will
>>> be happy to.
>> pnfs failure is unexpected. I'm pretty confident that a non-kerberos
>> configured client can do normal pnfs with sec=sys. I can help debug,
> Yes, I can confirm that. All RHEL kernels and weekly -rc kernels from Linus works as expected. We mount always with sec=sys, and despite the fact, that hosts configured to support kerberos due to AFS and GPFS, the access to DSes is never an issue and never tries to use kerberos.
>
> Tigran.

Hi Tigran,

It is possible that it is failing back to MDS for another reason and the 
error message that I see is not the reason for the failure. Are you 
using pNFS with Ganesha and GPFS?

Marc.

>
>> if you want to send me a network trace and tracepoint output. Btw what
>> kernel/distro are you using?
>>
>>> Marc.
>>>
>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC: Couldn't create
>>>>> auth handle (flavor 390004)
>>>>>
>>>>> Marc.
>>>>>
>>>>> On 8/9/24 6:06 AM, Anna Schumaker wrote:
>>>>>
>>>>> On Thu, Aug 8, 2024 at 6:07 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>>>>>
>>>>> On Mon, Aug 5, 2024 at 5:51 PM marc eshel <eshel.marc@gmail.com> wrote:
>>>>>
>>>>> Hi Trond,
>>>>>
>>>>> Will the Linux NFS client try to us krb5i regardless of the MDS
>>>>> configuration?
>>>>>
>>>>> Is there any option to avoid it?
>>>>>
>>>>> I was under the impression the linux client has no way of choosing a
>>>>> different auth_gss security flavor for the DS than the MDS. Meaning
>>>>>
>>>>> That's a good point, I completely missed that this is specifically for the DS.
>>>>>
>>>>> that if mount command has say sec=krb5i then both MDS and DS
>>>>> connections have to do krb5i and if say the DS isn't configured for
>>>>> Kerberos, then IO would fallback to MDS. I no longer have a pnfs
>>>>>
>>>>> That's what I would expect, too.
>>>>>
>>>>> server to verify whether or not what I say is true but that is what my
>>>>> memory tells me is the case.
>>>>>
>>>>>
>>>>> Thanks, Marc.
>>>>>
>>>>> ul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>>>> stripe count 1
>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: nfs4_fl_alloc_deviceid_node
>>>>> ds_num 1
>>>>> Jul 30 11:10:58 svl-marcrh-node-1 kernel: RPC: Couldn't create
>>>>> auth handle (flavor 390004)
>>>>>
>>>>>

