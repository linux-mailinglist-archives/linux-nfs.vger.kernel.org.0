Return-Path: <linux-nfs+bounces-2715-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28BA89BDAF
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 13:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B63B20E03
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 11:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCA764CD1;
	Mon,  8 Apr 2024 11:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YW3VY5wV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126D164CCC
	for <linux-nfs@vger.kernel.org>; Mon,  8 Apr 2024 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574086; cv=none; b=eFNNJs8eKlYxvUHRj6+/9nPKO6FG4P2j40/5jxEldjONgjxtbf7sMIIZkSVdlzPk2yAxfSEODBOrJWs/CO6+k1V6mL8Go/IatebxcIImwD/0Gr8+S+Mnj2iYMqDSrCmvTfn5G/qq9AiUYd4CIJNKRpQ/UjOJ7JlyozT9oDLoT/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574086; c=relaxed/simple;
	bh=JVCMk/bmIc935azmpezucoQcAp5jW7JznaogXkQTQOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjKPBcYc2DqDHImu3y7d7+ZpJuIA16EIhpKMKcOumSL9zMqpES0IPkaZABtuPJFXHWBPq1ubwt+z/ykTPCbJ40+ll1Rpk1xtK1RKinIvVw2dPboqPmRLq2zwfY2eoRXiOUfxJHIlahuV3U7pniU/wE9WFC4yZVqJ5JPcfHsO+1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YW3VY5wV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712574083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hyyySz7D6fkVaZFIKq8B/4VeoXWIW0Nfu7L/uI7UTPI=;
	b=YW3VY5wVXQQX0urf6vrRvzdG8rAVL0ie6C3vQatpopmzaIDkls2QMi7+wM0g4ddfsV0hQl
	UNRYBXNfxZbr4/UfOJNEsncASwd9rEAE3wfD+RtJb/q/WGii5Iuat07XIZu6gYwWhCjBQo
	2gLats44CTdeMWCCnp80t5xjqmUoTtc=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-RK_AbwWLOQmsmWmeICIBZA-1; Mon, 08 Apr 2024 07:01:21 -0400
X-MC-Unique: RK_AbwWLOQmsmWmeICIBZA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a52e0e73eeso234655a91.1
        for <linux-nfs@vger.kernel.org>; Mon, 08 Apr 2024 04:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712574080; x=1713178880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hyyySz7D6fkVaZFIKq8B/4VeoXWIW0Nfu7L/uI7UTPI=;
        b=D1Q6oqw+DKBRgz76VfCi1zZsmDPLBtvtEf1ekMPAKjwoPR1ENKqHOud7inA1Pr6j6/
         9jPsL5Wosci4BMn1Tc1ey7Bc2IOrVL0nXdxM/I+c41GUKUL2NKlb0By5WqjqwmjiBSyE
         FxoNAoGTntA7ehNzFoON1H9Pc8VRP7/IOMzK7pX3mksIrHFuDSMdBcoDOhHirH0Kyqnl
         fWXBPKnb+skZ+UbrDiwfmwbNM+zRtyLuRUQNCGjDzNAOGnWikT52LoZikMGf/Vj1kqxg
         oJEh7XuO8Nh0scPy2z++6TL7XGwSBxkh2SvLjDgwtpx0qxFLuP2TaBLfBin3TyvqFmpq
         3z7Q==
X-Gm-Message-State: AOJu0YzCIv6awtGj7K1rTL5t0ETPk/8P2s99Q3QCTeQLlLq5LHMlm0W3
	/ebIxCc39xy5OJlqaDtfmUkOl+SsGp1eL9BlylfVTqXyoSGa07JB7d9sz0NLY7TtXx2gWUb1RhE
	Je9jYWV8J/EAlM5Q4Giz9djlojZ13ebCE6mM9pdNUm0nirv0pOV37GFDPxA==
X-Received: by 2002:a17:90a:7d0e:b0:2a4:9464:d2ac with SMTP id g14-20020a17090a7d0e00b002a49464d2acmr6345894pjl.2.1712574080511;
        Mon, 08 Apr 2024 04:01:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZCYLTLteZxn9N7v3aqmnudnS6vlseiZC4M0KmmhYmkYg8bEuZ9QUT7BSr6P64F7tF7G9ZUg==
X-Received: by 2002:a17:90a:7d0e:b0:2a4:9464:d2ac with SMTP id g14-20020a17090a7d0e00b002a49464d2acmr6345876pjl.2.1712574080108;
        Mon, 08 Apr 2024 04:01:20 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.134.36])
        by smtp.gmail.com with ESMTPSA id c24-20020a17090abf1800b002a2884e9f44sm6187260pjs.14.2024.04.08.04.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:01:19 -0700 (PDT)
Message-ID: <6dbecf8d-1074-48bb-8395-e4edf2c53109@redhat.com>
Date: Mon, 8 Apr 2024 07:01:13 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Ian Kent <raven@themaw.net>, Chuck Lever III <chuck.lever@oracle.com>,
 Matt Turner <mattst88@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
 <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
 <1a5a0fcd-0514-42ae-8d22-2d534327447f@themaw.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <1a5a0fcd-0514-42ae-8d22-2d534327447f@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Ian!

Good to hear from you!!

On 4/7/24 7:57 PM, Ian Kent wrote:
> On 8/4/24 00:29, Chuck Lever III wrote:
>>> On Apr 7, 2024, at 10:45 AM, Steve Dickson <steved@redhat.com> wrote:
>>>
>>> On 4/6/24 6:26 PM, Matt Turner wrote:
>>>> On Sat, Apr 6, 2024 at 4:37 PM Steve Dickson <steved@redhat.com> wrote:
>>>>> Unfortunately the idea of having a nfsv4 only server
>>>>> did not go over well with upstream.
>>>> Which upstream do you mean? nfs-utils, Linux kernel?
>>> The NFS server maintainers... they didn't push back hard
>>> but the didn't it was necessary.
>> I'm sympathetic to some folks wanting a narrower footprint,
>> but I think we'd like to have support for all versions
>> packaged and available for an NFS server administrator,
>> right out of the shrink-wrap. Currently, most installations
>> want to deploy v3 and v4, so we should cater to the common
>> case.
> 
> I have to say I agree with Chuck.
Yes... I definitely see Chuck's point.

> 
> 
> Over the years I have had to deal with the consequences of dropping support
> 
> for NFS versions. So far that has been at the distribution level but if it
> 
> had been at the upstream level I would have had a much harder time of it.
> 
> 
> am-utils for example, yes it's maybe not a good case because it lacks 
> upstream
> 
> support nowadays, but I still work on it. It uses an NFS client 
> implementation
> 
> to provide automount support and NFS v2 was ideal for the localhost 
> server but
> 
> v2 support was removed from distro kernel builds and I had to implement 
> an NFS
> 
> v3 server for this which was very much overkill.
My apologies... That was me. Removing v2 cut down
the testing matrix two-fold. v3 was there to replace
v2... I just did the obvious.

> 
> 
> Now there's talk of dropping v3 support which will spell the end of 
> am-utils,
> 
> unnecessarily IMHO.
Yes... I was poking the bear when I said "deprecate" v3. Knowing
full well it would go over like a lead balloon :-)

But coming up with a way of separating the protocols
so only one can be used (client or server) in VMs or
containers is a bad idea?

> 
> 
> I can understand the urge to drop v2 but there are still many v3 users 
> so I wonder
> 
> about the wisdom of even thinking about dropping v3 support and multiple 
> packages,
> 
> IMHO, will introduce an unnecessary downstream overhead. It's hard 
> enough to keep
> 
> up with the workload as it is.
> 
> 
> I also gat that mostly what I'm saying has happened at distro level but 
> please don't
> 
> go down this path upstream too.
You are right... this is distro level conversation but
upstream should be involved... IMHO.

steved.

> 
> 
> Ian
> 
>>
>> As I recall, the NFSv4-only mechanism proposed at the time
>> was pretty clunky. If you have alternative ideas, I'm happy
>> to consider them. But let's recognize that an NFSv4-only
>> deployment is the special case here, and not make life more
>> difficult for everyone else, especially folks who might
>> start with an NFSv4-only deployment and need to add NFSv3
>> later, for whatever crazy reason.
>>
>> The nfs-server unit should be made to do the right thing
>> no matter what is installed on the system and no matter what
>> is in /etc/nfs.conf. I don't see why screwing with the
>> distro packaging is needed?
>>
>> -- 
>> Chuck Lever
>>
>>
> 


