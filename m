Return-Path: <linux-nfs+bounces-465-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2199080A64E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 15:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514C71C20AC7
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756911E538;
	Fri,  8 Dec 2023 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gze1FFPk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC653254
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 06:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702047288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2oBMwUJQEdCSSR7S9p4CWvnPMGIlBzw4q29NX4vHUk=;
	b=Gze1FFPkbLXheDBa0URbNRLl+7sRStqqeOXoljYJYGh7mE5wANiimxwwTrAeKxHjDIkxGE
	zLnDWQenu6nMPABIM3I7pbnHa2rqZwCtyfBbR4gN0zVvv8Hy2wQFD6OR7yQurX0tRJ7RHg
	7TT1OW3H/8AzSvFZu7svWVW5afJV7gI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-8G9Y0yTdMZasYhOy2BjOGA-1; Fri, 08 Dec 2023 09:54:47 -0500
X-MC-Unique: 8G9Y0yTdMZasYhOy2BjOGA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-77f41c21cdbso17621385a.1
        for <linux-nfs@vger.kernel.org>; Fri, 08 Dec 2023 06:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702047286; x=1702652086;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2oBMwUJQEdCSSR7S9p4CWvnPMGIlBzw4q29NX4vHUk=;
        b=eDfJMldFCcqXtkAgNvHZnsFpD/9B1/Uj2ZGcEBPGxggmX4amhuPMETCv/R+qEeGc8O
         YgGPVKGIxH4/k/rm7sSkFq6GdPKqVJOw7dDB63oTbTACnSEMJhR6X+DCTxWxn9MK+W9O
         BqRDnLEYVB3Xeov7r6GpQN/RC7KpGT1hU+HBe4tlLbPLT7KCWsSZqOUQssH8lk0b+Kj8
         Z4ytK1MswkZ5Pc/994EPWU9ZRj5Xmt4S3Y9cpu0qd+w52DdG++dFaB8fu8k9QPHzh3Z1
         9me+y4BWh1P9s/yQeTa3S7+YRQ8EcsUbpzDF1LdfLwqSkxpE8y0SMc0O1pi10viwzTp4
         MUXQ==
X-Gm-Message-State: AOJu0YyDCXI8t3CwehDGn21kzNXWKosYZGluUIgqpQV9vR/tMIGmwUyI
	1NtygTCygwxTQ7iW6hi8FU674iIYDqd7MBKN1TZTI4DtzepXLf/GXbAomiX24E+JeBmcVn2EfPL
	0UdsvYODv7smi3dQRHG5x
X-Received: by 2002:a05:620a:4628:b0:76d:9234:1db4 with SMTP id br40-20020a05620a462800b0076d92341db4mr357116qkb.7.1702047286501;
        Fri, 08 Dec 2023 06:54:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbZjRRuGfTN4qHdR72O2frh0qDuVY+H+WJWmZpYHiF4tAOpos5vqCPAiemoGiHSQrScN9ETQ==
X-Received: by 2002:a05:620a:4628:b0:76d:9234:1db4 with SMTP id br40-20020a05620a462800b0076d92341db4mr357104qkb.7.1702047286198;
        Fri, 08 Dec 2023 06:54:46 -0800 (PST)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a094b00b0077f3199a7easm728333qkw.134.2023.12.08.06.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 06:54:44 -0800 (PST)
Message-ID: <81543f40-b708-447e-ae37-566706f1f81f@redhat.com>
Date: Fri, 8 Dec 2023 09:54:43 -0500
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] configure: check for rpc_gss_seccreate
Content-Language: en-US
To: Chuck Lever <chuck.lever@oracle.com>,
 Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc: linux-nfs@vger.kernel.org
References: <20231206213332.55565-1-olga.kornievskaia@gmail.com>
 <20231206213332.55565-7-olga.kornievskaia@gmail.com>
 <ZXHaTIvFruYfycsm@tissot.1015granger.net>
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <ZXHaTIvFruYfycsm@tissot.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/7/23 9:44 AM, Chuck Lever wrote:
> On Wed, Dec 06, 2023 at 04:33:32PM -0500, Olga Kornievskaia wrote:
>> From: Olga Kornievskaia <kolga@netapp.com>
>>
>> If we have rpc_gss_sccreate in tirpc library define
>> HAVE_TIRPC_GSS_SECCREATE, which would allow us to handle bad_integrity
>> errors.
>>
>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>> ---
>>   aclocal/libtirpc.m4 | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/aclocal/libtirpc.m4 b/aclocal/libtirpc.m4
>> index bddae022..ef48a2ae 100644
>> --- a/aclocal/libtirpc.m4
>> +++ b/aclocal/libtirpc.m4
>> @@ -26,6 +26,11 @@ AC_DEFUN([AC_LIBTIRPC], [
>>                                       [Define to 1 if your tirpc library provides libtirpc_set_debug])],,
>>                            [${LIBS}])])
>>   
>> +     AS_IF([test -n "${LIBTIRPC}"],
>> +           [AC_CHECK_LIB([tirpc], [rpc_gss_seccreate],
>> +                         [AC_DEFINE([HAVE_TIRPC_GSS_SECCREATE], [1],
>> +                                    [Define to 1 if your tirpc library provides rpc_gss_seccreate])],,
>> +                         [${LIBS}])])
>>     AC_SUBST([AM_CPPFLAGS])
>>     AC_SUBST(LIBTIRPC)
> 
> It would be better for distributors if this checked that the local
> version of libtirpc has the rpc_gss_seccreate fix that you sent.
> The PKG_CHECK_MODULES macro should work for that, once you know the
> version number of libtirpc that will have that fix.
This is some the distro need to worried about... Not upstream.
Yes... do to the recent changes to libtirpc, I did need to
add a requirement to nfs-utils (in Fedora) so it would compile.

> 
> Also, this patch should come either before "gssd: switch to using
> rpc_gss_seccreate()" or this change should be squashed into that
> patch, IMO.Taking a quick look... The patches seem fine... but I will
take a closer look over the weekend.

steved
> 


