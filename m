Return-Path: <linux-nfs+bounces-9726-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3BBA21095
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 19:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132747A41F5
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Jan 2025 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BE1DE4F6;
	Tue, 28 Jan 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rB3vptfE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD991DE3C4;
	Tue, 28 Jan 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738088057; cv=none; b=ay9ySIUCyBfFdg3+iACbA/3XZJnTGASl/M+rfuW0OkANv85aid5JZLylsFmFe8K31KBAelxtVviugS2UcNa5vapfwaYPB91RPPv0Z17RVldSMxgluzfyDZNBYWVF/0wQxOGkqpV+TrtVwnkJs5jnn4dIR5+jfQd53aGlSicQpRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738088057; c=relaxed/simple;
	bh=2DZvKYB5G50NQ+Qn2CyJG4KaVvg154qst0Jbn39SO8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YV/5J/4/woUJ9LgTkS+EI5Wa6McObJ9ohfGu1p29STTaDXjTjb/dLJvZUCEBlFeM2SEs+3BV808EuDmbsyZsOnLyCapAqHxNdnBIrM7xBGPH1VdmVmZCABsRWPc/Z7ogrqL884h07FNtLzvItf9ctJ2pUQK0+SilfN7piCDwA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rB3vptfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B498C4CED3;
	Tue, 28 Jan 2025 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738088057;
	bh=2DZvKYB5G50NQ+Qn2CyJG4KaVvg154qst0Jbn39SO8g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rB3vptfER9pddELVlIO3e0BuM3ENfRz3/D4XRxWCfFshXTUg9NtB0q8kCve5XUz4V
	 V2TuTd2YFC09gJe3a80qI2/lYm1hAmXm6LgQDWEEvS2gnpz7zxZqtq9AtiyAL6UaLP
	 lEZP3ryuD4idNI34xRHNcK9YbrR9O9MgKEC4fxpcy6Avh2l1Y1XFFmEVJ8YZIEyoX7
	 ZCJj1HaR6JUgt4Xx8rJDz6zkrijyMh1Qih7ADgBj10ZubltQWOOTWECnX+uJXcGVRV
	 Ig7r0m2A4sggU8pqScR+DQaGRKz+vo60X3bOh9/OX3xJGhlIr61dzoppDh8d5JiKLE
	 9m4YBt50Z5G1Q==
Message-ID: <594263fc-f4e7-43ce-a613-d3f8ebb7f874@kernel.org>
Date: Tue, 28 Jan 2025 19:14:02 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: gnoack@google.com, willemdebruijn.kernel@gmail.com, matthieu@buffet.re,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com,
 MPTCP Linux <mptcp@lists.linux.dev>, linux-nfs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>
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
Content-Language: en-GB
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <d3d589c3-a70b-fc6e-e1bb-d221833dfef5@huawei-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mikhail,

Sorry, I didn't follow all the discussions in this thread, but here are
some comments, hoping this can help to clarify the MPTCP case.

On 28/01/2025 11:56, Mikhail Ivanov wrote:
> On 1/27/2025 10:48 PM, Mickaël Salaün wrote:

(...)

>> I'm a bit worried that we miss some of these places (now or in future
>> kernel versions).  We'll need a new LSM hook for that.
>>
>> Could you list the current locations?
> 
> Currently, I know only about TCP-related transformations:
> 
> * SMC can fallback to TCP during connection. TCP connection is used
>   (1) to exchange CLC control messages in default case and (2) for the
>   communication in the case of fallback. If socket was connected or
>   connection failed, socket can not be reconnected again. There is no
>   existing security hook to control the fallback case,
> 
> * MPTCP uses TCP for communication between two network interfaces in the
>   default case and can fallback to plain TCP if remote peer does not
>   support MPTCP. AFAICS, there is also no security hook to control the
>   fallback transformation,

There are security hooks to control the path creation, but not to
control the "fallback transformation".

Technically, with MPTCP, the userspace will create an IPPROTO_MPTCP
socket. This is only used "internally": to communicate between the
userspace and the kernelspace, but not directly used between network
interfaces. This "external" communication is done via one or multiple
kernel TCP sockets carrying extra TCP options for the mapping. The
userspace cannot directly control these sockets created by the kernel.

In case of fallback, the kernel TCP socket "simply" drop the extra TCP
options needed for MPTCP, and carry on like normal TCP. So on the wire
and in the Linux network stack, it is the same TCP connection, without
the MPTCP options in the TCP header. The userspace continue to
communicate with the same socket.

I'm not sure if there is a need to block the fallback: it means only one
path can be used at a time.

> * IPv6 -> IPv4 transformation for TCP and UDP sockets with
>   IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.
> 
> As I said before, I wonder if user may want to use SMC or MPTCP and deny
> TCP communication, since he should rely on fallback transformation
> during the connection in the common case. It may be unexpected for
> connect(2) to fail during the fallback due to security politics.

With MPTCP, fallbacks can happen at the beginning of a connection, when
there is only one path. This is done after the userspace's connect(). If
the fallback is blocked, I guess the userspace will get the same errors
as when an open connection is reset.

(Note that on the listener side, the fallback can happen before the
userspace's accept() which can even get an IPPROTO_TCP socket in return)

> Theoretically, any TCP restriction should cause similar SMC and MPTCP
> restriction. If we deny creation of TCP sockets, we should also deny
> creation of SMC and MPTCP sockets. I thought that such dependencies may
> be too complex and it will be better to leave them for the user and not
> provide any transformation control at all. What do you think?
I guess the creation of "kernel" TCP sockets used by MPTCP (and SMC?)
can be restricted, it depends on where this hook is placed I suppose.

(...)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


