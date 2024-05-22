Return-Path: <linux-nfs+bounces-3344-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB668CC817
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 23:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BE71F21D89
	for <lists+linux-nfs@lfdr.de>; Wed, 22 May 2024 21:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEC1F4E7;
	Wed, 22 May 2024 21:19:44 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D06476048
	for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 21:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716412784; cv=none; b=Zdc6VVENdMpB2fOb5qgoaMMJl9/Zm2545fjOGNdvUKAW5HN2bqVd2MPvIezc21jcfub5xkWSq/8p0xA4jVEe1JW1Y3TYiISKeWV6Nz/Epfqc0qYxsFqO7VOwMka2z+pq4OFO0O2iyeDql5pvPYGSQrMOTIzHU4ZvSJtdcBkf3+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716412784; c=relaxed/simple;
	bh=QzyHeLsic3jyuDD6hMz4ACCs0q53FvOl//v4vC5Hthk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxyTMeuxacFId//l78azCJ7yqZUrwd0TPoe3iTTJGq3ZAd7juMoRr4PkO5/Px0hjde/+WS44X/ATVzBIndXVuwxQy0asLw0vlFY1GZ6PHgXXzbgkRT+St3j4gCSMH9NcKimaovuFqFx06hjcByJqnwN7JRL66yidEyR8GpcGlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-354c3b445bbso543738f8f.1
        for <linux-nfs@vger.kernel.org>; Wed, 22 May 2024 14:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716412781; x=1717017581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QzyHeLsic3jyuDD6hMz4ACCs0q53FvOl//v4vC5Hthk=;
        b=OuNf/zpJxi/846Jr9PtNhtDGYfPblOSSgtvejIpDdsU36PPDSYyXrUgqvRHeezagYY
         56g2j8xfm3yiXflrS4GYtOBl3ywx/YAeyLbub/kuOQYbouNdxVlrtjeiPN0gwT/Z9fiJ
         eE9SYETbmD9/fpwCpxMCbgutrTN+I7F3Xdx4uIRy9ZhN8/s+D44RIxKqqQzI77WvqPJ7
         AP0RXIddgJoaE72eAf3c3UEKL+9k4iPcpygUHWzkLfE9FPBQLBIPFfhV/O601YleyfFq
         NSl7406biyNufnLdjEgLweTGoWQCIXJBPrNuHYJ2RkkVfrv+MwnPClzfzotlepCYuFtP
         DICw==
X-Forwarded-Encrypted: i=1; AJvYcCXVIWL23ict4yRCO4tUlgRmbSdisd0PGty3GySKmEMDWpuk2JFFgrCUbsgod+HHv9SGz6kSwwebnjBKbJ/Ow/TS/3NpRZKV+9/R
X-Gm-Message-State: AOJu0YwJezX1Fx22Dp1z8TpxAPWWpUybvg4ErYGEdVQ93as63WaavReP
	MRK9WV8+f/gzYOnF8BCpWqgP2BHSomTYPq5KosCCRZJNEt4UGgvL
X-Google-Smtp-Source: AGHT+IFPEb0vrnGqsgsEje8T9hb6yf+dgN6M0ydOMjxB5xvILZQspenoTQFrclQFHYZCmz1+Yf2upQ==
X-Received: by 2002:a05:6000:188c:b0:34d:b76c:cff7 with SMTP id ffacd0b85a97d-354d8da3838mr2734800f8f.3.1716412781202;
        Wed, 22 May 2024 14:19:41 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad0absm35122295f8f.69.2024.05.22.14.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 14:19:40 -0700 (PDT)
Message-ID: <81fa32fb-c5a3-4af8-a8ca-08905a8b62ef@grimberg.me>
Date: Thu, 23 May 2024 00:19:39 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfs: propagate readlink errors in nfs_symlink_filler
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <e4e181e4a7b2db4b27b6ce3e6bb26b23e514cdb1.camel@hammerspace.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> So what do you suggest we do here? IMO at a minimum NFS should retry
>> once similar
>> to nfs4_file_open (it would probably address 99.9% of the use-cases
>> where symlinks are
>> not overwritten in a high enough frequency for the client to see 2
>> consecutive stale readlink
>> rpc rplies).
>>
>> I can send a patch paired with a vfs ESTALE conversion patch?
>> alternatively retry locally in NFS...
>> I would like to understand your position here.
>>
> Looking more closely at nfs_get_link(), it is obvious that it can
> already return ESTALE (thanks to the call to nfs_revalidate_mapping())
> and looking at do_readlinkat(), it has already been plumbed through
> with a call to retry_estale().
>
> So I think we can take your patch as is, since it doesn't add any error
> cases that callers of readlink() don't have to handle already.

Sounds good.

>
> We might still want to think about cleaning up the output of the VFS in
> all these cases, so that we don't return ESTALE when it isn't allowed
> by POSIX, but that would be a separate task.
>

Yes, I can follow up on that later...


