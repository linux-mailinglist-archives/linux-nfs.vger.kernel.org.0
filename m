Return-Path: <linux-nfs+bounces-2734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A689E170
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 19:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482201C209CD
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 17:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E67155755;
	Tue,  9 Apr 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CU1G2vTv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FE7153582
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712683225; cv=none; b=Qo4B24v1ZT64p+BLyBp+Gwsu594P+j+YK5fjTq12B3LjJjDEyagql5SvIFE2WxCus65LJCwz/WnxlHXapooZPWRiivpILHXQlBYTC5QRaOld4Lk91VpOlfvkoldv9aXaZbBQiWZr7lbCYr1LHv0nUijirzOBtk62OYQN9TP34bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712683225; c=relaxed/simple;
	bh=XWlhy8RgDEgzAP6fnoqFyKPgZ4TlNWZG9SzCGGrvMpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6xx1hFj8nNhvjd5DREpBTBMIO88zWH/P+2iOvfW4zWVTn7U45mLjgR2ZGLEWWVGQ9A1cgfDD2xIGOUJ15VPQGscpYDITvK7IHvs8oYz4dDz2vU5t/GhUXX9sJ/hc6Sax6Xz4G87xQzwT1HOYVTG2tC4E8oVxWzqDg54JEQGaDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CU1G2vTv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712683222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DyulDX8B+7wqe2y8jwpBMqQnsDSbah2LbCKEmdCDEzs=;
	b=CU1G2vTvoQpPb1uw+ezyArbopTpfWilAiUirzUa/J2XY+eJjaNwTPnAhpxnLOJua8zCqC2
	2lMQDod7eXdcWRxIZyNITBkNQra1bPka3i6K8FIdjVPtV4/3dn6kJRU/JFm2o++iAlLZa4
	EidA8NTArSrPwpKemMUMzbXe56Nj+C8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-FJFZq2QGOGWbPpnsPKpnlw-1; Tue, 09 Apr 2024 13:20:20 -0400
X-MC-Unique: FJFZq2QGOGWbPpnsPKpnlw-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78d670996e4so27349185a.1
        for <linux-nfs@vger.kernel.org>; Tue, 09 Apr 2024 10:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712683220; x=1713288020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DyulDX8B+7wqe2y8jwpBMqQnsDSbah2LbCKEmdCDEzs=;
        b=IhCzZeUOrIcoV/cWiY+c0o+UiS+ulPM43UOKtsauwrS2mXa7FW0PFuvKV4frlhVHZY
         XI2nwYcCQawlWU6jg0sqEP9IRg+O4z3vVRUnXyNBeCP+jhzPEtWqwv397cpc8ea3kh/h
         5sbXyIfA1o6zbiMBka6HcOVu79z5zFgaHKWMUPqghIRJXUzejEaoD/0UYxaTpyDDIf25
         FGjQnvfyr3CwZEFyruJ4YzswttX+IjHwPDibz1y0/591Flj5Rje+UM+k/o8HidaecG2M
         EEwRPRmSkeSCVXwSDhdPcowSxXvd08i7K1Hj5JJAFoW3mJHY6W5o6UezSZnZ6dWSvqc5
         41og==
X-Gm-Message-State: AOJu0YxehUf7iDZ8A9K3REawIVWPmFYK4vgXUoxS256wl8a0cvrCHDoh
	/h8mZNpw1yjRbrYcV3kGg0Dt+ZkWPAYiprVqhv3AlJU4Bx2GoDIvLi+AJ9OBHAdF7hYYtnOuweD
	nxdgJujF3MG9bNoRWPWXtTy2XP6qPXD+5tB88XITOnfNnk83GPPOMuC3ezQ==
X-Received: by 2002:a05:620a:7181:b0:78d:7727:123b with SMTP id vm1-20020a05620a718100b0078d7727123bmr230979qkn.4.1712683220461;
        Tue, 09 Apr 2024 10:20:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4HAQ2fAUffybR467xfp4qHSYAR7urASj0NcaUTwE7mNvSLGmNk9jYowamHL4WSwWfKa1DmQ==
X-Received: by 2002:a05:620a:7181:b0:78d:7727:123b with SMTP id vm1-20020a05620a718100b0078d7727123bmr230962qkn.4.1712683220157;
        Tue, 09 Apr 2024 10:20:20 -0700 (PDT)
Received: from [10.19.60.48] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t30-20020a05620a035e00b0078d74f1d3c8sm373683qkm.110.2024.04.09.10.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 10:20:19 -0700 (PDT)
Message-ID: <8f363925-e72b-4484-9a94-aed044bb1967@redhat.com>
Date: Tue, 9 Apr 2024 13:20:18 -0400
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
 <6dbecf8d-1074-48bb-8395-e4edf2c53109@redhat.com>
 <b881f549-6b50-4ab3-9df3-bebdaa326a70@themaw.net>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <b881f549-6b50-4ab3-9df3-bebdaa326a70@themaw.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/9/24 1:53 AM, Ian Kent wrote:
> On 8/4/24 19:01, Steve Dickson wrote:
>> Hey Ian!
>>
>> Good to hear from you!!
>>
>> On 4/7/24 7:57 PM, Ian Kent wrote:
>>> On 8/4/24 00:29, Chuck Lever III wrote:
>>>>> On Apr 7, 2024, at 10:45 AM, Steve Dickson <steved@redhat.com> wrote:
>>>>>
>>>>> On 4/6/24 6:26 PM, Matt Turner wrote:
>>>>>> On Sat, Apr 6, 2024 at 4:37 PM Steve Dickson <steved@redhat.com> 
>>>>>> wrote:
>>>>>>> Unfortunately the idea of having a nfsv4 only server
>>>>>>> did not go over well with upstream.
>>>>>> Which upstream do you mean? nfs-utils, Linux kernel?
>>>>> The NFS server maintainers... they didn't push back hard
>>>>> but the didn't it was necessary.
>>>> I'm sympathetic to some folks wanting a narrower footprint,
>>>> but I think we'd like to have support for all versions
>>>> packaged and available for an NFS server administrator,
>>>> right out of the shrink-wrap. Currently, most installations
>>>> want to deploy v3 and v4, so we should cater to the common
>>>> case.
>>>
>>> I have to say I agree with Chuck.
>> Yes... I definitely see Chuck's point.
>>
>>>
>>>
>>> Over the years I have had to deal with the consequences of dropping 
>>> support
>>>
>>> for NFS versions. So far that has been at the distribution level but 
>>> if it
>>>
>>> had been at the upstream level I would have had a much harder time of 
>>> it.
>>>
>>>
>>> am-utils for example, yes it's maybe not a good case because it lacks 
>>> upstream
>>>
>>> support nowadays, but I still work on it. It uses an NFS client 
>>> implementation
>>>
>>> to provide automount support and NFS v2 was ideal for the localhost 
>>> server but
>>>
>>> v2 support was removed from distro kernel builds and I had to 
>>> implement an NFS
>>>
>>> v3 server for this which was very much overkill.
>> My apologies... That was me. Removing v2 cut down
>> the testing matrix two-fold. v3 was there to replace
>> v2... I just did the obvious.
> 
> Hehe, Yeah, I know.
> 
> 
> But this seemed like a good opportunity to let you know these changes 
> can be rather
> 
> inconvienient for some so that you have all the information when making 
> changes at
> 
> a later time.
Point taken....

> 
> 
> Even removing UDP support from the Fedora kernel config caused a problem 
> for me.
> 
> 
> Again, am-utils, it had a bug with it's background processing that was 
> causing slow mounts
> 
> that, ASAICS, could only be fixed by using UDP (which is sensible for a 
> service running or
> 
> localhost) or re-writting the entire application to use threads, a good 
> idea but way too much
> 
> work.
> 
> 
> OTOH we always knew the amd application would die in time to come so it 
> isn't such a big
> 
> deal I suppose.
Again it was a testing matrix thing... Plus TCP handled network
congestion much better than NFS ever could

> 
> 
>>
>>>
>>>
>>> Now there's talk of dropping v3 support which will spell the end of 
>>> am-utils,
>>>
>>> unnecessarily IMHO.
>> Yes... I was poking the bear when I said "deprecate" v3. Knowing
>> full well it would go over like a lead balloon :-)
>>
>> But coming up with a way of separating the protocols
>> so only one can be used (client or server) in VMs or
>> containers is a bad idea?
> 
> Yes, that's a bit harder and I think will require a division of the 
> packages ...
Right...

steved.
> 
> 
>>
>>>
>>>
>>> I can understand the urge to drop v2 but there are still many v3 
>>> users so I wonder
>>>
>>> about the wisdom of even thinking about dropping v3 support and 
>>> multiple packages,
>>>
>>> IMHO, will introduce an unnecessary downstream overhead. It's hard 
>>> enough to keep
>>>
>>> up with the workload as it is.
>>>
>>>
>>> I also gat that mostly what I'm saying has happened at distro level 
>>> but please don't
>>>
>>> go down this path upstream too.
>> You are right... this is distro level conversation but
>> upstream should be involved... IMHO.
> 
> Indeed, yes.
> 
> 
> Ian
> 
>>
>> steved.
>>
>>>
>>>
>>> Ian
>>>
>>>>
>>>> As I recall, the NFSv4-only mechanism proposed at the time
>>>> was pretty clunky. If you have alternative ideas, I'm happy
>>>> to consider them. But let's recognize that an NFSv4-only
>>>> deployment is the special case here, and not make life more
>>>> difficult for everyone else, especially folks who might
>>>> start with an NFSv4-only deployment and need to add NFSv3
>>>> later, for whatever crazy reason.
>>>>
>>>> The nfs-server unit should be made to do the right thing
>>>> no matter what is installed on the system and no matter what
>>>> is in /etc/nfs.conf. I don't see why screwing with the
>>>> distro packaging is needed?
>>>>
>>>> -- 
>>>> Chuck Lever
>>>>
>>>>
>>>
>>
> 


