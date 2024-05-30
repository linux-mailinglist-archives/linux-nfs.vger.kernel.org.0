Return-Path: <linux-nfs+bounces-3492-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 032258D51A3
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 20:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A001C209DC
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2024 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D6947F51;
	Thu, 30 May 2024 18:08:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C971B47A7A
	for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717092534; cv=none; b=Jl7IGhLyNleOiBz+EldIaF8t/7SDif3raVNusRoFEdsYClEKP/lm7ZcW/ZxzIKFfJZrG05eDqy5jdTyMc4i5hInlw2Z2SiWJ4sdFRS+hk1QSW9kgC8LcThm5TRPoiP7ceEQuIYwcq50DekIvNOfp9XMOAJHh/JLPi9f5UfhxdoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717092534; c=relaxed/simple;
	bh=Y5VUdQ0AozqGKQopSfGtZFowvZbOTsRlf5ojYvhnXMc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V9z23Gk0tu6WaMQMU1rcsFyERj3oPdW42NErN799UqnUYNFJkb8Z7AMcNzNRBlGJAmKSRhhvAJ0ISHChbqxdYUSNqYnAE7NirLNqpaolNn6b+lJx/frUSti9kAhT3s+CdxT+zaTHeKnLaRzFcdY0ZfOkz6TX6sLpzTJrHSbyqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421160b07eeso445345e9.0
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2024 11:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717092531; x=1717697331;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LX99xaCR9P9WmmydEm3mActNFiybMzqROrRaMmfL81E=;
        b=u8vf3Qtu4qABbFxd46A/wbCZXIeSoOHowf8yRd+aa74S+wBCcKKGUpiysTu4VzjVHL
         jGqgBY7G8zgzFTKa6+9rpemx9IwUlVVejT6VmsVqWxjDt6v4882veBoSiUsh0oi/Ss8p
         4X8il2HwN3M/BE1ceYK8KCOxZS7EXAQWhDasb/59KLY4rn32hLax6mWc/xXPLvPik6yU
         QcX8Q7de+Q31SrjxHku8UXUqA9xkzTYomeXFvJn7GO8lO7t3qKIh9CU/hCyJTyTEegvA
         1Bi8BM9lIbdVTSusMXoGfulfsFzlIGAZcCqZXIhwYIkaGQsMsipXSRTnKHEPEmMebnMI
         akGw==
X-Forwarded-Encrypted: i=1; AJvYcCXHz9kFDHgD8xOS8FmwDEc7/mFVLwJYUPjcDAYZLW2+Zoa87Ot/LzQB2F3pWwaaH/wnN3cIBTNYg0WEy8iPltlGbM1le2vmHldX
X-Gm-Message-State: AOJu0YzigYnvuuKTfN7Xj9vHeYT15DVfsbZGyAk29LDTYlVojKeyMR2X
	ac9L4Tz+XcZhvg+TDd2crhN9XxRaFm0K4w21ZzgJRfoMBenr7myI
X-Google-Smtp-Source: AGHT+IH85IuK9dXK3dBkt/kMEotKuLs1rS+AtnS22x8e95P8Nub/vstgsOi21PdUjNkxmV4RTx91+w==
X-Received: by 2002:a5d:4b8b:0:b0:354:e778:3665 with SMTP id ffacd0b85a97d-35dc00c1fa6mr2091508f8f.5.1717092530928;
        Thu, 30 May 2024 11:08:50 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd064b601sm74386f8f.98.2024.05.30.11.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 11:08:50 -0700 (PDT)
Message-ID: <ea5efcf6-4414-4a66-ad2e-9e9060bf5dbc@grimberg.me>
Date: Thu, 30 May 2024 21:08:49 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
From: Sagi Grimberg <sagi@grimberg.me>
To: Trond Myklebust <trondmy@hammerspace.com>,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, "dan.aloni@vastdata.com"
 <dan.aloni@vastdata.com>, "chuck.lever@oracle.com" <chuck.lever@oracle.com>
References: <20240521125840.186618-1-sagi@grimberg.me>
 <fa1a77fee6403454444fffce839924157778df95.camel@kernel.org>
 <ac2bfa20-d952-4917-8a70-1e821f9b57ca@grimberg.me>
 <d5409ff9ce51e439f442abb1cded7c7ab732b726.camel@hammerspace.com>
 <4d2bc7f1-b5c2-469c-9351-772626c707d7@grimberg.me>
 <c1d98e76-1b5c-4d91-a7fe-9412df7c2fab@grimberg.me>
 <e4e181e4a7b2db4b27b6ce3e6bb26b23e514cdb1.camel@hammerspace.com>
 <81fa32fb-c5a3-4af8-a8ca-08905a8b62ef@grimberg.me>
Content-Language: en-US
In-Reply-To: <81fa32fb-c5a3-4af8-a8ca-08905a8b62ef@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/05/2024 0:19, Sagi Grimberg wrote:
>
>>> So what do you suggest we do here? IMO at a minimum NFS should retry
>>> once similar
>>> to nfs4_file_open (it would probably address 99.9% of the use-cases
>>> where symlinks are
>>> not overwritten in a high enough frequency for the client to see 2
>>> consecutive stale readlink
>>> rpc rplies).
>>>
>>> I can send a patch paired with a vfs ESTALE conversion patch?
>>> alternatively retry locally in NFS...
>>> I would like to understand your position here.
>>>
>> Looking more closely at nfs_get_link(), it is obvious that it can
>> already return ESTALE (thanks to the call to nfs_revalidate_mapping())
>> and looking at do_readlinkat(), it has already been plumbed through
>> with a call to retry_estale().
>>
>> So I think we can take your patch as is, since it doesn't add any error
>> cases that callers of readlink() don't have to handle already.
>
> Sounds good.
>
>>
>> We might still want to think about cleaning up the output of the VFS in
>> all these cases, so that we don't return ESTALE when it isn't allowed
>> by POSIX, but that would be a separate task.
>>
>
> Yes, I can follow up on that later...
>

Hey Trond,
is there anything else you are expecting to see before this is taken to 
your tree?

