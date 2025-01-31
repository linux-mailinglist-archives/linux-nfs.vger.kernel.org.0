Return-Path: <linux-nfs+bounces-9807-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49252A23CA7
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 12:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96E2168739
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 11:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0CA1BE86A;
	Fri, 31 Jan 2025 11:05:00 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0A31BBBF4;
	Fri, 31 Jan 2025 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738321500; cv=none; b=B6WIMx/vXpe697SeSLGWdOfNhWG09j3yIkVnhFLYzNvXGJqbeJs/bELtlb3WSZSfNyfIblAy6KKAm7P5Er81rVSm5VmfO3POHbRuI71PAPrSZPThN0FEShMNVE1h3+fbG3mtWUNYAHUytKidEREBuIG4RzOtQZpI+VBHnaG/7DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738321500; c=relaxed/simple;
	bh=74zBxMbZtOF6IzL5eYn1BT1WP7txMHcRiO9uVjesNWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VTNDZgPBzRAaoI3/yuYnBK05P1eRIoYq34s2UF9tjT7ABjvkyQe/IQkmMR/nqNswxyVrJvVWVi+ktezVgSavLUKnoOQg85DcXHIxkmWbYfRW2eksED/Lccu+nzc3YbG6rgcrRpDJG/lfGhdsVWMaSHXfbPclDmDgp4MAzROtgNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YktJn3zRrz6G90H;
	Fri, 31 Jan 2025 19:02:33 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 5B5E21400DB;
	Fri, 31 Jan 2025 19:04:55 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 31 Jan 2025 14:04:53 +0300
Message-ID: <9f7f282b-95c2-8849-7b71-e77213558fd4@huawei-partners.com>
Date: Fri, 31 Jan 2025 14:04:51 +0300
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Content-Language: ru
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
CC: Matthieu Baerts <matttbe@kernel.org>, <gnoack@google.com>,
	<willemdebruijn.kernel@gmail.com>, <matthieu@buffet.re>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>, MPTCP Linux
	<mptcp@lists.linux.dev>, <linux-nfs@vger.kernel.org>, Paul Moore
	<paul@paul-moore.com>
References: <20250124.gaegoo0Ayahn@digikod.net>
 <2f970b00-7648-1865-858a-214c5c6af0c4@huawei-partners.com>
 <20250127.Uph4aiph9jae@digikod.net>
 <d3d589c3-a70b-fc6e-e1bb-d221833dfef5@huawei-partners.com>
 <594263fc-f4e7-43ce-a613-d3f8ebb7f874@kernel.org>
 <f6e72e71-c5ed-8a9c-f33e-f190a47b8c27@huawei-partners.com>
 <2e727df0-c981-4e0c-8d0d-09109cf27d6f@kernel.org>
 <103de503-be0e-2eb2-b6f0-88567d765148@huawei-partners.com>
 <1d1d58b3-2516-4fc8-9f9a-b10604bbe05b@kernel.org>
 <b9823ff1-2f66-3992-b389-b8e631ec03ba@huawei-partners.com>
 <20250129.Oo1xou8ieche@digikod.net>
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20250129.Oo1xou8ieche@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 mscpeml500004.china.huawei.com (7.188.26.250)

On 1/29/2025 5:51 PM, Mickaël Salaün wrote:>>>>>>> On 28/01/2025 11:56, 
Mikhail Ivanov wrote:

[...]

>>>>>>>> * IPv6 -> IPv4 transformation for TCP and UDP sockets withon
>>>>>>>>       IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.
> 
> According to the man page: "It is allowed only for IPv6 sockets that are
> connected and bound to a v4-mapped-on-v6 address."
> 
> This compatibility feature makes sense from user space point of view and
> should not result in an error because of Landlock.

IPV6_ADDRFORM is useful to pass IPv6 sockets binded and connected to
v4-mapped-on-v6 addresses to pure IPv4 applications [1].

I just realized we first need to consider restriction of IPv4 access
for IPv4/v6 dual stack. It's possible to communicate with IPv4 peer
using IPv6 socket (on client or server side) that is mapped on
v4-mapped-on-v6 address (RFC 3493 [2]). If socket access rights provide
separate control over IPv6 and IPv4, v4-mapped-on-v6 looks like possible
bypass of IPv4 restriction and violation of the least astonishment
principle.

This can be controlled with IPV6_V6ONLY socket option or with
net.ipv6.bindv6only sysctl knob. Restriction with sysctl knob is applied
globally and may break some dual-stack dependent applications.

I'm currently trying to collect real-world examples in which user may
want to allow IPv6-only communication in a sandboxed environment.
Theoretically, this can be seen as unprivileged reduction of attack
surface for IPv6-only programs in dual-stack network (disallow to open
IPv4 connections and communicate with loopback via IPv4 stack).

Earlier, it was also discussed about possible security issues on the
userland side related to different address representation and address
filtering [3]. But, I don't really think these are the good examples for
the motivation.

If the v4-mapped-on-v6 addressing control is deemed reasonable, it
should be better implemented with a new access right for
LANDLOCK_RULE_NET_PORT rather than a part of socket creation control.

[1] https://man7.org/linux/man-pages/man7/ipv6.7.html
[2] https://datatracker.ietf.org/doc/html/rfc3493#section-3.7
[3] https://lwn.net/Articles/688462/




