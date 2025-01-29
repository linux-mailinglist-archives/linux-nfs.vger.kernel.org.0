Return-Path: <linux-nfs+bounces-9733-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F286A21BA1
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 12:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD443A6548
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA0C1B042F;
	Wed, 29 Jan 2025 11:02:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5C61D9346;
	Wed, 29 Jan 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148574; cv=none; b=hJVBKrB9R4OnE138cctFvbwOVtYq2UoVaSNtmBQXIC4mmjswfwloaNX1m9cau+7Y2aobfcqSkYRMlKFwp/klo++vsPFdzU9AV4laleqxcRTNaHQux82+O7spw6rTg5zCK6KEuohsmZZULtlJPXDZhtulbjGhn7fcMORagwREe9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148574; c=relaxed/simple;
	bh=a8wVuDa971b8zNqIsHQA7qlVQkaGnw4JI1vy/uvMChg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hhdINjKoonNSPlzx5kq/tZqO6pu+HNEZNV3NMkenCXBrKSntsITOVHlcRoSS6+83JLFM9+vJGo8ZYtM/BSjQ+dvolQ0tbuOQdb08iKKaKyePz0h3d+xyokOrZlhwbH4WdXcighQ1ClZhHt2wWgj5631eXSAJ2dnZpc04zkxUm3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YjfMT1b5Wz6D9DJ;
	Wed, 29 Jan 2025 19:00:37 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 7BD47140B30;
	Wed, 29 Jan 2025 19:02:42 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 29 Jan 2025 14:02:40 +0300
Message-ID: <103de503-be0e-2eb2-b6f0-88567d765148@huawei-partners.com>
Date: Wed, 29 Jan 2025 14:02:38 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Content-Language: ru
To: Matthieu Baerts <matttbe@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
	<mic@digikod.net>
CC: <gnoack@google.com>, <willemdebruijn.kernel@gmail.com>,
	<matthieu@buffet.re>, <linux-security-module@vger.kernel.org>,
	<netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>, MPTCP Linux <mptcp@lists.linux.dev>,
	<linux-nfs@vger.kernel.org>, Paul Moore <paul@paul-moore.com>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
 <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
 <20241018.Kahdeik0aaCh@digikod.net>
 <62336067-18c2-3493-d0ec-6dd6a6d3a1b5@huawei-partners.com>
 <20241212.qua0Os3sheev@digikod.net>
 <f480bbea-989d-378a-9493-c2bee412db00@huawei-partners.com>
 <20250124.gaegoo0Ayahn@digikod.net>
 <2f970b00-7648-1865-858a-214c5c6af0c4@huawei-partners.com>
 <20250127.Uph4aiph9jae@digikod.net>
 <d3d589c3-a70b-fc6e-e1bb-d221833dfef5@huawei-partners.com>
 <594263fc-f4e7-43ce-a613-d3f8ebb7f874@kernel.org>
 <f6e72e71-c5ed-8a9c-f33e-f190a47b8c27@huawei-partners.com>
 <2e727df0-c981-4e0c-8d0d-09109cf27d6f@kernel.org>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <2e727df0-c981-4e0c-8d0d-09109cf27d6f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 1/29/2025 1:25 PM, Matthieu Baerts wrote:
> Hi Mikhail,
> 
> On 29/01/2025 10:52, Mikhail Ivanov wrote:
>> On 1/28/2025 9:14 PM, Matthieu Baerts wrote:
>>> Hi Mikhail,
>>>
>>> Sorry, I didn't follow all the discussions in this thread, but here are
>>> some comments, hoping this can help to clarify the MPTCP case.
>>
>> Thanks a lot for sharing your knowledge, Matthieu!
>>
>>>
>>> On 28/01/2025 11:56, Mikhail Ivanov wrote:
>>>> On 1/27/2025 10:48 PM, Mickaël Salaün wrote:
>>>
>>> (...)
>>>
>>>>> I'm a bit worried that we miss some of these places (now or in future
>>>>> kernel versions).  We'll need a new LSM hook for that.
>>>>>
>>>>> Could you list the current locations?
>>>>
>>>> Currently, I know only about TCP-related transformations:
>>>>
>>>> * SMC can fallback to TCP during connection. TCP connection is used
>>>>     (1) to exchange CLC control messages in default case and (2) for the
>>>>     communication in the case of fallback. If socket was connected or
>>>>     connection failed, socket can not be reconnected again. There is no
>>>>     existing security hook to control the fallback case,
>>>>
>>>> * MPTCP uses TCP for communication between two network interfaces in the
>>>>     default case and can fallback to plain TCP if remote peer does not
>>>>     support MPTCP. AFAICS, there is also no security hook to control the
>>>>     fallback transformation,
>>>
>>> There are security hooks to control the path creation, but not to
>>> control the "fallback transformation".
>>>
>>> Technically, with MPTCP, the userspace will create an IPPROTO_MPTCP
>>> socket. This is only used "internally": to communicate between the
>>> userspace and the kernelspace, but not directly used between network
>>> interfaces. This "external" communication is done via one or multiple
>>> kernel TCP sockets carrying extra TCP options for the mapping. The
>>> userspace cannot directly control these sockets created by the kernel.
>>>
>>> In case of fallback, the kernel TCP socket "simply" drop the extra TCP
>>> options needed for MPTCP, and carry on like normal TCP. So on the wire
>>> and in the Linux network stack, it is the same TCP connection, without
>>> the MPTCP options in the TCP header. The userspace continue to
>>> communicate with the same socket.
>>>
>>> I'm not sure if there is a need to block the fallback: it means only one
>>> path can be used at a time.
>>
>> You mean that users always rely on a plain TCP communication in the case
>> the connection of MPTCP multipath communication fails?
> 
> Yes, that's the same TCP connection, just without extra bit to be able
> to use multiple TCP connections associated to the same MPTCP one.

Indeed, so MPTCP communication should be restricted the same way as TCP.
AFAICS this should be intuitive for MPTCP users and it'll be better
to let userland define this dependency.

> 
>>>> * IPv6 -> IPv4 transformation for TCP and UDP sockets withon
>>>>     IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.
>>>>
>>>> As I said before, I wonder if user may want to use SMC or MPTCP and deny
>>>> TCP communication, since he should rely on fallback transformation
>>>> during the connection in the common case. It may be unexpected for
>>>> connect(2) to fail during the fallback due to security politics.
>>>
>>> With MPTCP, fallbacks can happen at the beginning of a connection, when
>>> there is only one path. This is done after the userspace's connect(). If
>>> the fallback is blocked, I guess the userspace will get the same errors
>>> as when an open connection is reset.
>>
>> In the case of blocking due to security policy, userspace should get
>> -EACESS. I mean, the user might not expect the fallback path to be
>> blocked during the connection if he has allowed only MPTCP communication
>> using the Landlock policy.
> 
> A "fallback" can happen on different occasions as mentioned in the
> RFC8684 [1], e.g.
> 
> - The client asks to use MPTCP, but the other peer doesn't support it:
> 
>    Client                Server
>    |     SYN + MP_CAPABLE     |
>    |------------------------->|
>    |         SYN/ACK          |
>    |<-------------------------|  => Fallback on the client side
>    |           ACK            |
>    |------------------------->|
> 
> - A middle box doesn't touch the 3WHS, but intercept the communication
> just after:
> 
>    Client                Server
>    |     SYN + MP_CAPABLE     |
>    |------------------------->|
>    |   SYN/ACK + MP_CAPABLE   |
>    |<-------------------------|
>    |     ACK + MP_CAPABLE     |
>    |------------------------->|
>    |        DSS + data        | => but the server doesn't receive the DSS
>    |------------------------->| => So fallback on the server side
>    |           ACK            |
>    |<-------------------------| => Fallback on the client side
> 
> - etc.
> 
> So the connect(), even in blocking mode, can be OK, but the "fallback"
> will happen later.

Thanks! Theoretical "socket transformation" control should cover all
these cases.

You mean that it might be reasonable for a Landlock policy to block
MPTCP fallback when establishing first sublflow (when client does not
receive MP_CAPABLE)?

> 
> Again, once the "fallback" has been done, it just means there will be no
> more MPTCP options in the TCP headers, and these TCP connections,
> created and controlled by the kernel, will continue as "plain" TCP
> connections. It simply means that the MPTCP connection will be
> restricted to one path, because it will not be possible to create
> additional paths any more without these MPTCP options in the initial path.

Correct, thanks

> 
> [1] https://datatracker.ietf.org/doc/html/rfc8684#name-fallback
> 
>>> (Note that on the listener side, the fallback can happen before the
>>> userspace's accept() which can even get an IPPROTO_TCP socket in return)
>>
>> Indeed, fallback can happen on a server side as well.
> 
> Same here, this fallback can happen at different stages of the
> connection, e.g. the server, supporting MPTCP, can receive a SYN without
> MP_CAPABLE option ; or the 3WHS is OK, but the MPTCP options are
> stripped later.
> 
>>>> Theoretically, any TCP restriction should cause similar SMC and MPTCP
>>>> restriction. If we deny creation of TCP sockets, we should also deny
>>>> creation of SMC and MPTCP sockets. I thought that such dependencies may
>>>> be too complex and it will be better to leave them for the user and not
>>>> provide any transformation control at all. What do you think?
>>> I guess the creation of "kernel" TCP sockets used by MPTCP (and SMC?)
>>> can be restricted, it depends on where this hook is placed I suppose.
>>
>> Calling
>>      socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP)
>> causes creation of kernel TCP socket, so we can use
>> security_socket_create() hook for this purpose.
> 
> That's good if you use this hook then!
> 
> Cheers,
> Matt

