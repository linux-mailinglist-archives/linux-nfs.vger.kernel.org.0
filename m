Return-Path: <linux-nfs+bounces-2728-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE3E89D210
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 07:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93A461F22EBF
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Apr 2024 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F270A657D4;
	Tue,  9 Apr 2024 05:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="POB3HJkS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wDkukRnp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7346354FAF
	for <linux-nfs@vger.kernel.org>; Tue,  9 Apr 2024 05:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642002; cv=none; b=h/hAZoKgT6rUXZElCMKUCLkP5HglewG7ONhzBF3bIUpeZcIeWsfX6YSmZ6+6EeHedVT7FIIksdGYLwKotAzxBt+0B2O08orO4Et4WMpfn9cfxI1NxGFdoh9chsLa0PZ9e9vGM2HiPWE9b15xikIBLcZ6S0RNP+WCyLeiZbPZKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642002; c=relaxed/simple;
	bh=TbbjGo/MgpHHvYX2GvznjVtqtAM8ngSW5j5il8q4Kjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rHkI47ILg3ok2WzGRWfwK5qPlxRENhOQLj4zNIpIW8eHzfIJsAypf3LVCHq4kUgGPgl/RWQ6im2/53RSRN2lpyuVRfO3ysfQy1k4o12hCsqmYmr6IxkXMiPB09+OhKd76r3V7Dh/BR+UXehDx7SZ0LB3K52+JA/NTQL2n5yESZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=POB3HJkS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wDkukRnp; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5A23E138025E;
	Tue,  9 Apr 2024 01:53:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 09 Apr 2024 01:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712641999;
	 x=1712728399; bh=/qcVVpLBvI24Lzj7cBXq2r+TvOqg8xlwa7YH/PC/uvU=; b=
	POB3HJkSdsljzUtpecO3KXT7YTpx8lwH1rNOn23KpfcJDWtmrSA3iE+IK3KTYT4g
	AvimaObVsRxtMl5kfgqQIMQGO4j/+UbweJHJyEjGv+tqVQfJptXhVXDTxNC8BN7J
	PYdTHr9yV9EE2gguoWq9+Q1WeZPbCUd0gqrXK1aa9/HG2iht1l3g93scg6CkAsCE
	KsuAruawd1qpcvvLaYAlvqwdPVgUBf2sr9J6WwElSjYaM2I9W40e6XodRZa90CU3
	ciIm75ASrAVzH/omLlyYdH+J6kRdrIEiauge5Qr+1RgjfOx85YqlP36n8Sy+3C/O
	DH+RQEJBya0IgBGA2ByCog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712641999; x=
	1712728399; bh=/qcVVpLBvI24Lzj7cBXq2r+TvOqg8xlwa7YH/PC/uvU=; b=w
	DkukRnpgY6lN0uQnkrVG3kLHXDmhpNHyCp8AmsuloexkG9WwryK+7W1AP0XbjYzL
	l1KhLdcPJZeMxJqUhzWzqL4nLbG45dngGxaEEmVJ0oYRuA4Xez/G3uQYONGxiCA9
	eE2QuIgEr78Qmb0uaz9/LRu8Q4qt4XCizHiAx1bRgVQyEgzYtDb+KCH4kBVMW/TH
	lV2UCbfuREt9iHcM0vKAecY8uuD/K5BKjr71SBbptR4Ie1QeZBVIGaRcJ6Xfpdca
	sHOouA3Ltl/nd7wYLWO8xgMyOCXKxZwQnrPkAGY0HoLWg8yCALeX68wcsrXrybCh
	gHw5eG4GfXPePNSSPrWiw==
X-ME-Sender: <xms:z9cUZnhcH0Aa-3Rp9-9jUJ9HtAw84pCcabscd0ueZ-gK7zMTT19V7Q>
    <xme:z9cUZkBLBBHc0R1mtngoucuv08x6KVlRUQ0l6_FNMGGsPj43EzIDyl98Cw87iq1Wp
    948F_NXwzA3>
X-ME-Received: <xmr:z9cUZnHiz_BWMqVsb-iVCY27rASocWTycBOnykjjwkVRHgp5RKR2c-Jr4VINjm5jgw1qCwc3-JFfwdB8bPiqXk6sNcnLeZSMIzA-bB-QBySnbcXeqfHhvvgp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    eptddugfehtddugfefgfdtjeeguddttdevfeehtedvfeeufefggffgvdeileetffegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:z9cUZkRcBFFfFHlS5TSP_z1mjND6hZuaAfTqdD74dySnlcTPfKby3A>
    <xmx:z9cUZkwltKwMq8Q9oFcfqTJ3XgIUnjInCxzmyr_5YWA-dXspU4JBDg>
    <xmx:z9cUZq7FLC0PxqJ4PPCjWVXyV1-DyW2urvdjrfsiLhKoV3OB6wmBZQ>
    <xmx:z9cUZpwQsAgU8wWY_2LE9wFmagpdhG3UvTiRtZA7cWGBoQ-8WvtV6Q>
    <xmx:z9cUZg_zWithioHbKBZzqbYIEYVpW-d6ps8gFT3os5MnlPE6pL_4tP6o>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 01:53:17 -0400 (EDT)
Message-ID: <b881f549-6b50-4ab3-9df3-bebdaa326a70@themaw.net>
Date: Tue, 9 Apr 2024 13:53:12 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Steve Dickson <steved@redhat.com>,
 Chuck Lever III <chuck.lever@oracle.com>, Matt Turner <mattst88@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
 <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
 <1a5a0fcd-0514-42ae-8d22-2d534327447f@themaw.net>
 <6dbecf8d-1074-48bb-8395-e4edf2c53109@redhat.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <6dbecf8d-1074-48bb-8395-e4edf2c53109@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/4/24 19:01, Steve Dickson wrote:
> Hey Ian!
>
> Good to hear from you!!
>
> On 4/7/24 7:57 PM, Ian Kent wrote:
>> On 8/4/24 00:29, Chuck Lever III wrote:
>>>> On Apr 7, 2024, at 10:45 AM, Steve Dickson <steved@redhat.com> wrote:
>>>>
>>>> On 4/6/24 6:26 PM, Matt Turner wrote:
>>>>> On Sat, Apr 6, 2024 at 4:37 PM Steve Dickson <steved@redhat.com> 
>>>>> wrote:
>>>>>> Unfortunately the idea of having a nfsv4 only server
>>>>>> did not go over well with upstream.
>>>>> Which upstream do you mean? nfs-utils, Linux kernel?
>>>> The NFS server maintainers... they didn't push back hard
>>>> but the didn't it was necessary.
>>> I'm sympathetic to some folks wanting a narrower footprint,
>>> but I think we'd like to have support for all versions
>>> packaged and available for an NFS server administrator,
>>> right out of the shrink-wrap. Currently, most installations
>>> want to deploy v3 and v4, so we should cater to the common
>>> case.
>>
>> I have to say I agree with Chuck.
> Yes... I definitely see Chuck's point.
>
>>
>>
>> Over the years I have had to deal with the consequences of dropping 
>> support
>>
>> for NFS versions. So far that has been at the distribution level but 
>> if it
>>
>> had been at the upstream level I would have had a much harder time of 
>> it.
>>
>>
>> am-utils for example, yes it's maybe not a good case because it lacks 
>> upstream
>>
>> support nowadays, but I still work on it. It uses an NFS client 
>> implementation
>>
>> to provide automount support and NFS v2 was ideal for the localhost 
>> server but
>>
>> v2 support was removed from distro kernel builds and I had to 
>> implement an NFS
>>
>> v3 server for this which was very much overkill.
> My apologies... That was me. Removing v2 cut down
> the testing matrix two-fold. v3 was there to replace
> v2... I just did the obvious.

Hehe, Yeah, I know.


But this seemed like a good opportunity to let you know these changes 
can be rather

inconvienient for some so that you have all the information when making 
changes at

a later time.


Even removing UDP support from the Fedora kernel config caused a problem 
for me.


Again, am-utils, it had a bug with it's background processing that was 
causing slow mounts

that, ASAICS, could only be fixed by using UDP (which is sensible for a 
service running or

localhost) or re-writting the entire application to use threads, a good 
idea but way too much

work.


OTOH we always knew the amd application would die in time to come so it 
isn't such a big

deal I suppose.


>
>>
>>
>> Now there's talk of dropping v3 support which will spell the end of 
>> am-utils,
>>
>> unnecessarily IMHO.
> Yes... I was poking the bear when I said "deprecate" v3. Knowing
> full well it would go over like a lead balloon :-)
>
> But coming up with a way of separating the protocols
> so only one can be used (client or server) in VMs or
> containers is a bad idea?

Yes, that's a bit harder and I think will require a division of the 
packages ...


>
>>
>>
>> I can understand the urge to drop v2 but there are still many v3 
>> users so I wonder
>>
>> about the wisdom of even thinking about dropping v3 support and 
>> multiple packages,
>>
>> IMHO, will introduce an unnecessary downstream overhead. It's hard 
>> enough to keep
>>
>> up with the workload as it is.
>>
>>
>> I also gat that mostly what I'm saying has happened at distro level 
>> but please don't
>>
>> go down this path upstream too.
> You are right... this is distro level conversation but
> upstream should be involved... IMHO.

Indeed, yes.


Ian

>
> steved.
>
>>
>>
>> Ian
>>
>>>
>>> As I recall, the NFSv4-only mechanism proposed at the time
>>> was pretty clunky. If you have alternative ideas, I'm happy
>>> to consider them. But let's recognize that an NFSv4-only
>>> deployment is the special case here, and not make life more
>>> difficult for everyone else, especially folks who might
>>> start with an NFSv4-only deployment and need to add NFSv3
>>> later, for whatever crazy reason.
>>>
>>> The nfs-server unit should be made to do the right thing
>>> no matter what is installed on the system and no matter what
>>> is in /etc/nfs.conf. I don't see why screwing with the
>>> distro packaging is needed?
>>>
>>> -- 
>>> Chuck Lever
>>>
>>>
>>
>

