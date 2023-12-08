Return-Path: <linux-nfs+bounces-466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFCA80A669
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 16:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455851F210B1
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 15:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A7200C7;
	Fri,  8 Dec 2023 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqD/o0ZE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E897198D
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 07:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702047698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pM3my2w6Rvp7rY0wISDDTE/8h9rmjO9a/06bgwl1vhU=;
	b=WqD/o0ZEwjiLb37gh5PrmijbeGIifIRtdNGgOQQ/zGMFtv8SRMCHRmB5gmTWOd1leO/7a3
	1p1p4Rhsgat+ibMaPgiZc82PbmWN0AXLYV2dbj8K56DV1jrfg7eDmCJpZMDOGCQT77weE9
	likGPgD0loBULJoFM6G+2167tgthIhI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-XHs63-35PI2xywLmXZpy0g-1; Fri, 08 Dec 2023 10:01:31 -0500
X-MC-Unique: XHs63-35PI2xywLmXZpy0g-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-77d8df7c8e2so30852985a.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Dec 2023 07:01:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047691; x=1702652491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pM3my2w6Rvp7rY0wISDDTE/8h9rmjO9a/06bgwl1vhU=;
        b=puOiRj3B6wcmKYqTK6/tPrhjylT0bbCw93Vtremt0i5Upv75XoCStj0f6KlYCJctIs
         MW9R8jDD4QaIiMrTxXwrZAj1niPVFm9yNW2GzP7PMc6DCG+kbqRKCaF3o6kuRwYOVJ3w
         7ZxcNTXzEBHk00ulTlLLofsQqQfimEnHeqat3u/xlfUbBdcF50nlaYdJw4a5NVb9xSD1
         GmMasoV3uqyT0hz+aEYQK4xglh8k7fw5V2vuAobM1bqpgZTHE7bSkbvc6BLqL9YS74ry
         bQ3piFTm5eGNwbzqJPOhmCWEchg5N+q6azidUIx7pgyV1+yoHnvPlZB9USYTr0qVBozW
         jRiQ==
X-Gm-Message-State: AOJu0Yzbz+esYgUXlmpERQKVSwdlPMuiHid9l5zzGkQ62ydyd2ugIwgO
	kad+lUJwk3WXjViIHDJDz9KhGD1Q6GwoBsYfgiColb4T6KpnYk0bOukZgMVAyiRJqD29fCBlaax
	ZqUi+l8S9O7vTqZEUl9YpCRQr5c5X
X-Received: by 2002:a05:620a:2910:b0:77d:9db0:f50 with SMTP id m16-20020a05620a291000b0077d9db00f50mr438509qkp.2.1702047690891;
        Fri, 08 Dec 2023 07:01:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNsI4tMtOYc7xHWZXOBjYBD1aXToBsFFrAg7VImEsfcmJKM9xVeM36+qmHrWM/jwDygfffpQ==
X-Received: by 2002:a05:620a:2910:b0:77d:9db0:f50 with SMTP id m16-20020a05620a291000b0077d9db00f50mr438486qkp.2.1702047690610;
        Fri, 08 Dec 2023 07:01:30 -0800 (PST)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a0e9600b0077589913a8bsm731162qkm.132.2023.12.08.07.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:01:30 -0800 (PST)
Message-ID: <687d51fc-fc87-40a1-80c8-9261fcb8dd7a@redhat.com>
Date: Fri, 8 Dec 2023 10:01:29 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
Content-Language: en-US
To: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
 Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com>
 <ZXHaTIvFruYfycsm@tissot.1015granger.net>
 <CAN-5tyFr7-eRP_wjrv_zOmsVC6ft1f1c+fNovbOXr0CVrtzfRw@mail.gmail.com>
 <ZXJG2xyFUs9pzHlq@tissot.1015granger.net>
 <CAN-5tyE_jBLJeW_JK0RScEDLF9jAZoi6upsM9aWRhtHPcYxHUQ@mail.gmail.com>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <CAN-5tyE_jBLJeW_JK0RScEDLF9jAZoi6upsM9aWRhtHPcYxHUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/8/23 9:26 AM, Olga Kornievskaia wrote:
> On Thu, Dec 7, 2023 at 5:27 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> On Thu, Dec 07, 2023 at 05:21:50PM -0500, Olga Kornievskaia wrote:
>>> On Thu, Dec 7, 2023 at 9:44 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>
>>>>> If we have rpc_gss_sccreate in tirpc library define
>>>>> HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
>>>>> errors.
>>>>>
>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>> ---
>>>>>   aclocal/libtirpc.m4 | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
>>>>> index bddae022..ef48a2ae 100644
>>>>> --- a/aclocal/libtirpc.m4
>>>>> +++ b/aclocal/libtirpc.m4
>>>>> @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
>>>>>                                       [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
>>>>>                            [${LIBS}])])
>>>>>
>>>>> +     AS_IF([test -n "${LIBTIRPC}"],
>>>>> +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
>>>>> +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
>>>>> +                                    [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
>>>>> +                         [${LIBS}])])
>>>>>     AC_SUBST([AM_CPPFLAGS])
>>>>>     AC_SUBST(LIBTIRPC)
>>>>
>>>> It would be better for distributors if this checked that the local
>>>> version of libtirpc has the rpc_gss_seccreate fix that you sent.
>>>> The PKG_CHECK_MODULES macro should work for that, once you know the
>>>> version number of libtirpc that will have that fix.
>>>>
>>>> Also, this patch should come either before "gssd: switch to using
>>>> rpc_gss_seccreate()" or this change should be squashed into that
>>>> patch, IMO.
>>>
>>> I can certainly re-arrange the order (if Steve wants me to re-send an
>>> ordered list).  I attempted to address your comment to  check for
>>> existence of the function or fallback to the old way.
>>
>> A comment that I made when I thought no changes to rpc_gss_seccreate(3t)
>> would be needed.... But you found and fixed a bug there.
>>
>>
>>> I'm not sure I'm
>>> capable of producing something that depends on distro versioning (or
>>> am I supposed to be)?
>>
>> I think this series truly needs to check the libtirpc version.
>> Otherwise the build will complete successfully, gssd will use
>> rpc_gss_seccreate(), but it will be broken.
>>
>> Grep for PKG_CHECK_MODULES in the other files in aclocal/ and you
>> should find a pattern to use.
> 
> Yes but I won't know the version number of libtirpc (version or rpm
> package) for which to check? It seems like libtirpc changes needs to
> be checked in (btw I'm assuming a new version would need to be
> generated), then (if that's it or libtirpc version and package version
> are different things there might be more) this particular patch could
> be generated. Isn't that correct?
> 
> Steve, I could really use your guidance on steps to be done here.
Again... The versions "on who is on first and what is on second" :-)
Is not an upstream problem... It is a distro problem...

Let me take a closer look...

> 
> Thank you.
> 
>>
>>
>>> I think this goes back to me hoping that a
>>> distro would create matching set of libtirpc and nfs-utils rpms...
We do... upstream creates tar balls... distros create rpm
that have requirements for certain versions of things.

steved.

>>
>> IME distros don't work that way.
>>
>>
>> --
>> Chuck Lever
> 


