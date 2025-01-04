Return-Path: <linux-nfs+bounces-8912-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD5A016F5
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 22:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097C23A370F
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 21:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30A542AA1;
	Sat,  4 Jan 2025 21:47:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A42F4409
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 21:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736027262; cv=none; b=gileSDs7HNDtWK9dg3LadoCyZuCMNiLemHG6cSph9UILeSNTxZ7pDF5BIoy33OexIfuFtSAiOH6C8H0VByr12Z7FX64hlWGXeeW1z7N5JwAqtATvwxs5/3Nj9j+IkC/MO7exJQaNur1Yg713YR+/PnmSoCVBaH0ph15PqDEPs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736027262; c=relaxed/simple;
	bh=eeSf0V/2qACymbqIIQkAYZC9Oc51tGraEw+7j4lsH4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Plyl3djcKh54zZUUNqvGbPyj4qwZwZQG4npMKH6MpxvGF3y/KmL1KgGhZyYbo4yXFKnvIN0GIHTcv9gHSE9GnD4AQUeElVhGSrt42C7w6P98AtbgGiSZlu5GKVAGpgi6akIn0jh+v9hTme6xgmWivMHdrRwiQcEPb12FN+8ugrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43618283dedso131420525e9.3
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jan 2025 13:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736027259; x=1736632059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUq7TwIrF/Sli3NQf8W+TkseSKxDBHW1YDtGSQZ548s=;
        b=bstKLfTbwiCUvuyqcIr/VvJAtBKvj5C70SkSXtjFx3Zf1NIREdl6RI1SHjSUe/eQgk
         wA5pYsht7zPfDs7m/jrIV3ijcAlegBjs/xqMWE59am0ezEYxdSPEVL8LGLJ7FcozLyGu
         rtzaj44Dl6oASAVHh18huWjrQdsfeDO7C7CWi4iMAniHU84VHyrAtmskdPT89p334wWE
         /gSJ4xKBlTmEPzI8Cwh/KmyHTHh5KQzP1f8QIeTMZIUzqRhJ0E9t6fC4lE97iN/0BC0U
         bP8Sjr02I+0P/YYuLFQfpSiSYM1ABGCjrHdl6sNL/2ba1l6Yqad/4OGYLIHjJgEswDho
         HV6g==
X-Forwarded-Encrypted: i=1; AJvYcCWpwUhv7a9r0zPCqT0YXS+N+bP4XvSLRqLzv/eOA077o/MztZhioiET5V/1dBP30VzeplgjJa4UHgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH96P+du4Hjm8XA0w+U709LdVdNoXfshmbq6dBSIoA+xMhWf9H
	kxWU/ZN0+/kxSItwlxMiS0qEUy5SbmPZHDT5kOnes5aPtp5mEjFtTEGSYw==
X-Gm-Gg: ASbGncv7cgT0DxxFQg0VBgGFsQu4JKL9luRmgqAyDyKVLlBdx89GSasy8kYCA7HxZDX
	DrfOluiJ/r3mnyqPXGvseW61RLU5nwSh+iTeeAQklz01LYzkrNn0SZmUydkWx4qCRnRzy9eQbd6
	osZUtyrGHzJ2NcCuICmmcfRM8kz5XR05EkptDmKdaPcLM0Ar9Daj7GFg3HBmFKRWvNs7Le8YODR
	+pq3ivHRgS4hnQFurJqZ7MPd9/sk86GXosfHCKDdSTELfeQZ14ro0EXrWZmwIuJzKu6R9+MJbxo
	TSxO51jqHX16iG5aCoUKVqg=
X-Google-Smtp-Source: AGHT+IGyA3NohiOxFFNUBte5PzZZeya0jzIuPZ0m+hfLbd3xCUlKfgfvZDxND0u5Rifc2FB+QR0cFg==
X-Received: by 2002:a5d:5e09:0:b0:386:3e3c:efd with SMTP id ffacd0b85a97d-38a223ffb0dmr56882817f8f.44.1736027259199;
        Sat, 04 Jan 2025 13:47:39 -0800 (PST)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8292adsm43696617f8f.19.2025.01.04.13.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 13:47:38 -0800 (PST)
Message-ID: <9a2b7a74-2531-466e-865f-eb2bd11b2483@grimberg.me>
Date: Sat, 4 Jan 2025 23:47:37 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Write delegation stateid permission checks
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>
Cc: Shaul Tamari <shaul.tamari@vastdata.com>, linux-nfs@vger.kernel.org
References: <CAFEWm5DTvUucAps=SamE5OVs0uYX5n4trFf5PBasBOFbEFWAfA@mail.gmail.com>
 <e52500f98a7153822a6165d26dcf66c3d352129b.camel@kernel.org>
 <3ee21c03-83a5-4ad8-a54f-5c076125e924@grimberg.me>
 <c497a2c1-9bdd-4ccd-91e5-769f4708d9e7@oracle.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c497a2c1-9bdd-4ccd-91e5-769f4708d9e7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 03/01/2025 0:42, Chuck Lever wrote:
> On 1/2/25 5:07 PM, Sagi Grimberg wrote:
>>
>>
>>
>> On 02/01/2025 15:41, Jeff Layton wrote:
>>> On Thu, 2025-01-02 at 11:08 +0200, Shaul Tamari wrote:
>>>> Should the server check permissions for read access as well when
>>>> OPEN4_SHARE_ACCESS_WRITE is requested and DELEGATION_WRITE is granted
>>>> ?
>>>>
>>> Possibly? When trying to grant a write delegation, the server should
>>> probably also do an opportunistic permission check for read as well,
>>> and only grant the delegation if that passes. If it fails, you could
>>> still allow the open and just not grant the delegation.
>>
>> Yes, that is what Chuck suggested at the time.
>>
>>>
>>> ISTR that Sagi may have tried this approach though and there was a
>>> problem with it?
>>
>> Not a problem per se, IIRC the thread left off that we need to sort out
>> access reference accounting for nfsd_file for both reads and writes for
>> a single write deleg...
>
> I've been pondering this recently.
>
> The desired outcome would be to deal with a OPEN(SHARE_ACCESS_WRITE)
> by opening the file twice: once, WR_ONLY, for the OPEN state ID, and
> once RW, for the write delegation.

Makes sense. I guess we should skip the WR_ONLY open if the client asks for
OPEN_XOR_DELEGATION and will never send a CLOSE.

>
> Will that work? won't the two opens conflict with each other and
> trigger a delegation recall?

I think that nfsd_breaker_owns_lease() should prevent the conflict as 
the two
come from the same client by definition. But I'm maybe misinterpreting it..

