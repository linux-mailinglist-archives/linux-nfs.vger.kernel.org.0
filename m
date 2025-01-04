Return-Path: <linux-nfs+bounces-8914-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C875A01715
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 23:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90413A2309
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 22:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3D115DBAE;
	Sat,  4 Jan 2025 22:26:05 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B94846D
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736029565; cv=none; b=HmSogz3U5glXXeUbsf6sRRvEHNEp/vYbLK1DTMZHdV0HmwA+4uElesuEzYrvPbl9g9WCYM4Fd/e7/T9khh1rpyrRMDa9FkImK+pIp6+isb3BdTOsPwMPvO1y701ZpYCTi4Mv3PI5pu4freYYKLTtNjkCECwjXdtbeaP5l4mzLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736029565; c=relaxed/simple;
	bh=l4/kWwjwVeOHys7AN3k9dYe4k6JIdiXOkm9157oW5G8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WQ8JGP+kz0+TxXrrvUrR0KV5MVMzEUtyp9mBo+bNQUfpDFtAzBb341AfsYIpByUcKoHSyilGZjzW1scneUZ9fLDxGBMdmwWQOjmksbdyVXV2vVKAJ2PzRvknu5tvvXB7ch0TpvQHzwKfPg3OfZEuepSGWnkcCUIXS4m8q7yA6MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3863494591bso6857595f8f.1
        for <linux-nfs@vger.kernel.org>; Sat, 04 Jan 2025 14:26:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736029562; x=1736634362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1znj7BFPI307Ty2PNtta7xUI6UuXvua4Vd0GZok8xrQ=;
        b=ruKk0CxIlA41YVN/qvwFQDMXZojSTPWeOHkT6rZOpaTepRXZ9HdvgKSihOiIYrvRfB
         uVnF+OKsrXTgPosGvxSZCL9902sRPspD3Ums079OICuBLf86gQQ9A/MfUU1PdmCvGrc9
         BjxKqr/EklH84ZmDd7a8ASGFQWYs4AIpLlEb+ZNbjXq4/eZqkd2LLW6Xi9NYEJc96RbO
         M5sYmhecYIwGO/pPqY0yt76znqj+iDWYMhwTTP20EK6A/pS2lcgLAxPf0CEqY6mguJNe
         RJP1taNXGHmGv4xOVDcWDZ5tK7ID76yHTv9OsQAQON0wXUxYwDMzVXh8ESUu1gAabFB3
         5SSw==
X-Forwarded-Encrypted: i=1; AJvYcCWfeqYKhQ4xJkiJEBh1A3VEQgimps+u4mH1bi95XqJemFmZEvGx3SMLyzwd+1nqKPXyi190w6EPlCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/nRZIgiZJuJe7hyKCZxQB6Mia2sKVQqtfBgSXfSMTAlmkFYCz
	GKzl6jEerWYtBLhyFxNLRut18yMZq1B7URMFr5RaloXGYQZ9bH/Segefzg==
X-Gm-Gg: ASbGncs/tPorvd69OIIwoHju9QdPHEdlE0Fj0ZT1+8ssohuSAy1nSyHrm+b9Qr9w1QD
	4+31ZSSX5TgTJ7l2Gsv0gqemtR+zFsHPXtECTe+6QEG5WRm0MeASvI80d1Ti0qWfLuZUgAjZE4q
	G18LBraG51l4C9ur0nj5q8anZMdaL8IdLH7HWrGLeuGHn8f3ThrgF/xnMH/P5YSXsVktxnhpNI3
	zC8JzXNQKfdXfBBK+IdAfg+pOyqqjeOx856m7QubmLX0mY+4QuxcF7Ikt6wemO3S6y7rHa0rQl0
	uoPEfML6jmyC4uVkIfacq4Q=
X-Google-Smtp-Source: AGHT+IFkinRRC6vrfvoHrdeS8EmK7fRTB2DKOCaicykyXdzkf5f2pZQFDOUeKOOvptAs6+XdgbJeVg==
X-Received: by 2002:a5d:648b:0:b0:385:e17a:ce6f with SMTP id ffacd0b85a97d-38a221fb704mr42937195f8f.24.1736029562403;
        Sat, 04 Jan 2025 14:26:02 -0800 (PST)
Received: from [10.100.102.74] (CBL217-132-142-53.bb.netvision.net.il. [217.132.142.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828bd3sm43464063f8f.10.2025.01.04.14.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jan 2025 14:26:01 -0800 (PST)
Message-ID: <ad99755e-3ba0-4239-8f39-9d4405e02bc5@grimberg.me>
Date: Sun, 5 Jan 2025 00:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfc] nfsd: offer write delegation for O_WRONLY opens
To: Martin Wege <martin.l.wege@gmail.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <20240706224207.927978-1-sagi@grimberg.me>
 <114581777d5b61b6973ec9ef2537ee887989e197.camel@kernel.org>
 <9156BC30-78C3-4854-8BC3-510E586B4613@oracle.com>
 <3b4ec3b0-5359-4f95-81a3-1d558756bddd@oracle.com>
 <5a071e49-f214-41d3-b29f-aa1860b12455@grimberg.me>
 <e23bb0d4-7f83-45fd-8df1-b127e1f749db@oracle.com>
 <9b9430e9-845b-4e21-b021-cfc387cbd01e@grimberg.me>
 <53440FD0-58F1-4B92-BCC3-20CB91BB529C@oracle.com>
 <500c22cd-b88c-48e6-8cb4-732f66f8e913@grimberg.me>
 <9DB557C4-60D9-4148-9017-AEE32792BA0A@oracle.com>
 <a8d6d640-ab58-498d-9b28-427014ca9b5b@grimberg.me>
 <CANH4o6NyKgTt+ooWCzQDwB+CvRB674ikmMD9kEegBvzdeCtCfg@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CANH4o6NyKgTt+ooWCzQDwB+CvRB674ikmMD9kEegBvzdeCtCfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


>>>> On Jul 10, 2024, at 3:11 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
>>>>
>>>>
>>>>> Yes, as an NFSD co-maintainer, I would like to see the
>>>>> READ stateid issue addressed. We just got distracted
>>>>> by other things in the meantime.
>>>> OK, so reading the correspondence from the last time, it seems that
>>>> the breakage was the usage of anon stateid on a read. The spec says that
>>>> the client should use a stateid associated with a open/deleg to avoid
>>>> self-recall, but allowed to use the anon stateid.
>>>>
>>>> I think that Dai's patch is a good starting point but needs to add handling of
>>>> the anon stateid case. The server should check if the client holds a delegation,
>>>> if so simply allow, if another client holds a deleg, it should recall?
>>> For an anon stateid, NFSD might just always recall if
>>> there is a delegation on that file. The use of anon is
>>> kind of a legacy behavior, IIUC, so no need to go to a
>>> lot of trouble to make it optimal.
>>>
>>> (This is my starting position; I'm open to be convinced
>>> NFSD should take more pain for this use case).
>> Hey Chuck, didn't forget about this.
>>
>> I'll look into this when I find some time (which I lack these days).
>>
> Welcome to 2025 - is this issue fixed?

No, I didn't get to come back to this... sorry :(

I'll try to find some time for this, but if someone else is interested 
in seeing
this added, it may not be sufficient to wait for me to get it done.

