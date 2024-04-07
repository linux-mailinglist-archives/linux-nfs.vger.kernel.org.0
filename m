Return-Path: <linux-nfs+bounces-2703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3D89B4D0
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Apr 2024 01:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BCA21C203B8
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Apr 2024 23:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B743AC5;
	Sun,  7 Apr 2024 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="gsZcwLq2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xUI7TSCo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1886D1E893
	for <linux-nfs@vger.kernel.org>; Sun,  7 Apr 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712534256; cv=none; b=C/46pToV2/+a2p+aJZxRNJXXxnE0b+yHhexMF8oDBlnamgPUNrGWoTtLisvhrOLYMtIqg17DA6Oj/cfU93Hv0tlYTb9ejCDqSsXuE/tmZco6c7xJJpg7m3eojJknMy4uorEnnLr0LAba5vgYgCMZn731RipFqq2cU/qnwbBSA6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712534256; c=relaxed/simple;
	bh=N1EdZshzlWG79HQy6rqtF6pqye2vlrh0u+1Gy+9roNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJu8JgcR05dxBBAVG+j92Gwf+pwPAMnhrtCSbbkRzJHf7TpKfUHhM/1b31HPFcDC0qjhtvbsh/z32HIOlBIKMClhEh1iFMKcm7oureAaURJbECIMKpPDzwSelHWEdSkOD4MMl8fpu+2nlSKG7XssZYQpX0rVbohfIFkb18ZUeWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=none smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=gsZcwLq2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xUI7TSCo; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=themaw.net
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D942B1C000EF;
	Sun,  7 Apr 2024 19:57:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 07 Apr 2024 19:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1712534252;
	 x=1712620652; bh=IyQsvL73/2AUEvpuTz0pExtehFwr0+hXVU2XCpf1NkI=; b=
	gsZcwLq2R9Y2FPlCUip+WzhCDPh4BxBK2GYLiJBccxtDVofNCNa85J/StieuQMlv
	POQKRi1OdhAQqQK5E/8wWMqcqgJogwh/7B9BcCyidKV9vni8uMTPq1GbgxaeKtZ3
	c4PwyvrCwfUCi74owWiRTey09epQ2Xn8najusmSQU6JqMdVjSFDx1v+98MA+0Ign
	19d1yGsU4y3OnD5o38HaBi2gBOB8TKowRodIqQm93i0kpFsIcVw+oBF18Sss5iwZ
	bQMpnjQ2E/cNox320w1b368Fm4lYCU0Tb1IU/S6S09IVsINlfmBuoQw+sQU6WLIC
	Od1v2B/n5U5X7Nq8JHlZKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712534252; x=
	1712620652; bh=IyQsvL73/2AUEvpuTz0pExtehFwr0+hXVU2XCpf1NkI=; b=x
	UI7TSCo1EpaHIuNWkewYYvcr8QAn1G7QF/u+XmdN8cg+Vh1T+/Nr40sRYi6PKWTK
	Ixah4RC5Z5cESRzByrNlRoU1YkqihOWCuqcWMSwmiRGLCGP0lUgNwjRJiPqcaEX3
	g3uEMkVxFt83zCDH59XVx+hCw6wegEBl9XnlfiX3aZz/oVUL158hSr3GrvqNJzwE
	b5ZfEudVLmX+G4F+rOMsvHfyub/F+m/pkA2BH6W0WrAm4Sv7Qx0rXTQozScEbCqJ
	ErXt4JWfvclHk6q4YTrbBHhJr2KkEUekvdsDhse1YubNQsSHlMyW53gFcvmtJaSW
	DHR1W8zBANfgQuuauparg==
X-ME-Sender: <xms:7DITZsqKOaAOpPheYGNxE18Wp5dZJ0puf5-_9yk6jGf_cmgOmzr_Dw>
    <xme:7DITZiqwX1GgA5_qdOGP69FOTb8ZfWsou7KDEH3S91iJEByymeU4rim9AIJS6Vxef
    gM6KOlk-KWP>
X-ME-Received: <xmr:7DITZhMWHGhRdeRUPOkk6zMS_Wqq3ONFhT8IlOSA4xKnBpfihnHEjvH-B2ynAfYtzjWCNTC45GHp4UNIHzE2jXARuGfcjcVijrE0U1EoI067Y9SxpmrFki1f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    eptddugfehtddugfefgfdtjeeguddttdevfeehtedvfeeufefggffgvdeileetffegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnh
    esthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:7DITZj7kMajxY-mzbjRxC4TRZmPpyYVqXqHusiu8K09WlFOF7r_AJg>
    <xmx:7DITZr6mudnDt-mmpyCxdgMoSQiCl_MmdeuqMlzK5y0ke9junIk0FA>
    <xmx:7DITZjhP6XushNRgblKv3asj8qys62mVC6yoY4uFfP2MrS_R_S5jEg>
    <xmx:7DITZl6cwGkYg6afgADsUOrxEDXA_HDjIvms6FN_LagzK2p6jGZwAA>
    <xmx:7DITZu0YepM6tp4ka5JN2Rjo3hvScdlOw1TV0-DsnjJIc4o6apaZt4Uo>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Apr 2024 19:57:30 -0400 (EDT)
Message-ID: <1a5a0fcd-0514-42ae-8d22-2d534327447f@themaw.net>
Date: Mon, 8 Apr 2024 07:57:24 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfs-utils' .service files not usable with nfsv4-server.service
To: Chuck Lever III <chuck.lever@oracle.com>,
 Steve Dickson <steved@redhat.com>, Matt Turner <mattst88@gmail.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <CAEdQ38GJgxponxNxkcv+t8mhwRPzOjan58MTBgOL8p9tY=rvTw@mail.gmail.com>
 <79c69668-4f8e-448e-9f50-6977cda662fc@redhat.com>
 <CAEdQ38FOP0_g0FK5DYz954OwfJjLUf2pjQL1CX=VNC60kd8HEw@mail.gmail.com>
 <50d1fcab-ba94-405e-896a-5bbae128998b@redhat.com>
 <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
Content-Language: en-US
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <3138D81C-EAD9-41CD-A32D-DEA4AA002CEE@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/4/24 00:29, Chuck Lever III wrote:
>> On Apr 7, 2024, at 10:45 AM, Steve Dickson <steved@redhat.com> wrote:
>>
>> On 4/6/24 6:26 PM, Matt Turner wrote:
>>> On Sat, Apr 6, 2024 at 4:37 PM Steve Dickson <steved@redhat.com> wrote:
>>>> Unfortunately the idea of having a nfsv4 only server
>>>> did not go over well with upstream.
>>> Which upstream do you mean? nfs-utils, Linux kernel?
>> The NFS server maintainers... they didn't push back hard
>> but the didn't it was necessary.
> I'm sympathetic to some folks wanting a narrower footprint,
> but I think we'd like to have support for all versions
> packaged and available for an NFS server administrator,
> right out of the shrink-wrap. Currently, most installations
> want to deploy v3 and v4, so we should cater to the common
> case.

I have to say I agree with Chuck.


Over the years I have had to deal with the consequences of dropping support

for NFS versions. So far that has been at the distribution level but if it

had been at the upstream level I would have had a much harder time of it.


am-utils for example, yes it's maybe not a good case because it lacks 
upstream

support nowadays, but I still work on it. It uses an NFS client 
implementation

to provide automount support and NFS v2 was ideal for the localhost 
server but

v2 support was removed from distro kernel builds and I had to implement 
an NFS

v3 server for this which was very much overkill.


Now there's talk of dropping v3 support which will spell the end of 
am-utils,

unnecessarily IMHO.


I can understand the urge to drop v2 but there are still many v3 users 
so I wonder

about the wisdom of even thinking about dropping v3 support and multiple 
packages,

IMHO, will introduce an unnecessary downstream overhead. It's hard 
enough to keep

up with the workload as it is.


I also gat that mostly what I'm saying has happened at distro level but 
please don't

go down this path upstream too.


Ian

>
> As I recall, the NFSv4-only mechanism proposed at the time
> was pretty clunky. If you have alternative ideas, I'm happy
> to consider them. But let's recognize that an NFSv4-only
> deployment is the special case here, and not make life more
> difficult for everyone else, especially folks who might
> start with an NFSv4-only deployment and need to add NFSv3
> later, for whatever crazy reason.
>
> The nfs-server unit should be made to do the right thing
> no matter what is installed on the system and no matter what
> is in /etc/nfs.conf. I don't see why screwing with the
> distro packaging is needed?
>
> --
> Chuck Lever
>
>

