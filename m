Return-Path: <linux-nfs+bounces-9731-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F7A21A69
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 10:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819F118889DE
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2821ACEB5;
	Wed, 29 Jan 2025 09:52:09 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19917191F84;
	Wed, 29 Jan 2025 09:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738144329; cv=none; b=OVxYGVa/Sr1Hig5juEGtzwMJg0dahoOBKM/l4B2J/IpbozGvN9FDmlLXtgHO/cK+WW1qbq4E9m1UB9cfz52b1VGRRdlLWoY+qhoIl8TGIKhxi3tQEAH2mSeyLfcuvnrNTgNYqbQzVrVGGVdVmcjAFCvIODNn7jUbc/nOrVCMQaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738144329; c=relaxed/simple;
	bh=vnm2Sr7Bpz2tMcpRtHGyI6+lG68KZTS3zvIXOoyG9cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JTir/0g5/tNERMU1KrJ/bL0EC7lCclRv5oKIhNoaceTNmNBlSYsyb7QZFj3w4Jv5G/TkUCVlhiHFvkFczlXT47R3ZzMZGYV8Mx6Qd0FR/kB/ZxlslvqrBvvtBepSN9ExjBYLe64Tv7ASlFzf/uZgWhrySPjfVftIeL/5NktrtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yjcnn1VR1z6J67n;
	Wed, 29 Jan 2025 17:49:49 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 73F8A140B18;
	Wed, 29 Jan 2025 17:52:04 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 29 Jan 2025 12:52:02 +0300
Message-ID: <f6e72e71-c5ed-8a9c-f33e-f190a47b8c27@huawei-partners.com>
Date: Wed, 29 Jan 2025 12:52:00 +0300
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
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <594263fc-f4e7-43ce-a613-d3f8ebb7f874@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 1/28/2025 9:14 PM, Matthieu Baerts wrote:
> Hi Mikhail,
> 
> Sorry, I didn't follow all the discussions in this thread, but here are
> some comments, hoping this can help to clarify the MPTCP case.

Thanks a lot for sharing your knowledge, Matthieu!

> 
> On 28/01/2025 11:56, Mikhail Ivanov wrote:
>> On 1/27/2025 10:48 PM, Mickaël Salaün wrote:
> 
> (...)
> 
>>> I'm a bit worried that we miss some of these places (now or in future
>>> kernel versions).  We'll need a new LSM hook for that.
>>>
>>> Could you list the current locations?
>>
>> Currently, I know only about TCP-related transformations:
>>
>> * SMC can fallback to TCP during connection. TCP connection is used
>>    (1) to exchange CLC control messages in default case and (2) for the
>>    communication in the case of fallback. If socket was connected or
>>    connection failed, socket can not be reconnected again. There is no
>>    existing security hook to control the fallback case,
>>
>> * MPTCP uses TCP for communication between two network interfaces in the
>>    default case and can fallback to plain TCP if remote peer does not
>>    support MPTCP. AFAICS, there is also no security hook to control the
>>    fallback transformation,
> 
> There are security hooks to control the path creation, but not to
> control the "fallback transformation".
> 
> Technically, with MPTCP, the userspace will create an IPPROTO_MPTCP
> socket. This is only used "internally": to communicate between the
> userspace and the kernelspace, but not directly used between network
> interfaces. This "external" communication is done via one or multiple
> kernel TCP sockets carrying extra TCP options for the mapping. The
> userspace cannot directly control these sockets created by the kernel.
> 
> In case of fallback, the kernel TCP socket "simply" drop the extra TCP
> options needed for MPTCP, and carry on like normal TCP. So on the wire
> and in the Linux network stack, it is the same TCP connection, without
> the MPTCP options in the TCP header. The userspace continue to
> communicate with the same socket.
> 
> I'm not sure if there is a need to block the fallback: it means only one
> path can be used at a time.

You mean that users always rely on a plain TCP communication in the case
the connection of MPTCP multipath communication fails?

> 
>> * IPv6 -> IPv4 transformation for TCP and UDP sockets withon
>>    IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.
>>
>> As I said before, I wonder if user may want to use SMC or MPTCP and deny
>> TCP communication, since he should rely on fallback transformation
>> during the connection in the common case. It may be unexpected for
>> connect(2) to fail during the fallback due to security politics.
> 
> With MPTCP, fallbacks can happen at the beginning of a connection, when
> there is only one path. This is done after the userspace's connect(). If
> the fallback is blocked, I guess the userspace will get the same errors
> as when an open connection is reset.

In the case of blocking due to security policy, userspace should get
-EACESS. I mean, the user might not expect the fallback path to be
blocked during the connection if he has allowed only MPTCP communication
using the Landlock policy.

> 
> (Note that on the listener side, the fallback can happen before the
> userspace's accept() which can even get an IPPROTO_TCP socket in return)

Indeed, fallback can happen on a server side as well.

> 
>> Theoretically, any TCP restriction should cause similar SMC and MPTCP
>> restriction. If we deny creation of TCP sockets, we should also deny
>> creation of SMC and MPTCP sockets. I thought that such dependencies may
>> be too complex and it will be better to leave them for the user and not
>> provide any transformation control at all. What do you think?
> I guess the creation of "kernel" TCP sockets used by MPTCP (and SMC?)
> can be restricted, it depends on where this hook is placed I suppose.

Calling
	socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP)
causes creation of kernel TCP socket, so we can use
security_socket_create() hook for this purpose.

> 
> (...)
> 
> Cheers,
> Matt

