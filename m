Return-Path: <linux-nfs+bounces-9779-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C8EA22B86
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 11:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B43A05D5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 10:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B5E16A395;
	Thu, 30 Jan 2025 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loiJhm01"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5142415382E;
	Thu, 30 Jan 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738232319; cv=none; b=bSxoZAaks/qmcfGxyVCtj+ffhjFLXmjJ897jj3CdFV6MzVIJsoVdVvgCjXyvB5wbUEOMBKvFZWJDNlVKbvpePQyC05UXXsx75++o1XLcgcmEpwWkaP4C9hz38CmVJaQAUgVzjNgXlsu1LMSic4eM8WqTD46mISyIrmVcf4vpGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738232319; c=relaxed/simple;
	bh=gp8mnyM4gxWqFXz5BlBgd0fNLkA71lEnWXVUiQnKDsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKLRo0V6xpBGRy3WvyGx+KiTzfUT99D6bz4zYWevWi9A2HMXH/CI/0mbqfBUIkMGrAd6XqZdAisypPMJQ1uzobW9vdZOJ/8SNdkJ2/MCmFFINKScOt0kDm8Psb3OIhU/IYrku5CN346tR6oYOHZZ/DA9o0Izs4reKumsci1tC6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loiJhm01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB773C4CED2;
	Thu, 30 Jan 2025 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738232318;
	bh=gp8mnyM4gxWqFXz5BlBgd0fNLkA71lEnWXVUiQnKDsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=loiJhm01S8dfXtUi+VSSAUwUMSMvkXMOG3wc9DBr1Os/QEWKQMZ6OxqnYmijyoWtJ
	 4feBb3jeS6YUoWZZNg9PPFF312ath1wW9OiSU86q9jDztmeOZGRhcl+o+2USoKwUUB
	 pQe7jLNzzqHQNw5Z2wmShlHHUoRo1tYd2MJfjvOnE+gP/gygGSU07+no04yDKYQvga
	 2U8PZYCsblhkMjRM9ODaWPgU1ulUJ/jCt/qDs/FpX1CNnlqb1Qig7FasLVr+wUAbgv
	 pqZNGBHjKs1tz901IZ1bJ2DAfCbdcFH9T6BhS4SkQH4rB0c6kVu5MVN/avYh+h1f+7
	 g8t6lOcqtAcYA==
Message-ID: <ba299d75-7417-40fd-b32e-b75713f57011@kernel.org>
Date: Thu, 30 Jan 2025 11:18:25 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Content-Language: en-GB
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, gnoack@google.com,
 willemdebruijn.kernel@gmail.com, matthieu@buffet.re,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com,
 MPTCP Linux <mptcp@lists.linux.dev>, linux-nfs@vger.kernel.org,
 Paul Moore <paul@paul-moore.com>
References: <20250127.Uph4aiph9jae@digikod.net>
 <d3d589c3-a70b-fc6e-e1bb-d221833dfef5@huawei-partners.com>
 <594263fc-f4e7-43ce-a613-d3f8ebb7f874@kernel.org>
 <f6e72e71-c5ed-8a9c-f33e-f190a47b8c27@huawei-partners.com>
 <2e727df0-c981-4e0c-8d0d-09109cf27d6f@kernel.org>
 <103de503-be0e-2eb2-b6f0-88567d765148@huawei-partners.com>
 <1d1d58b3-2516-4fc8-9f9a-b10604bbe05b@kernel.org>
 <b9823ff1-2f66-3992-b389-b8e631ec03ba@huawei-partners.com>
 <20250129.Oo1xou8ieche@digikod.net>
 <64b1de00-c724-4748-9133-acd0a79b6d72@kernel.org>
 <20250130.Xe3Ohtai5aen@digikod.net>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20250130.Xe3Ohtai5aen@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mickaël,

On 30/01/2025 10:51, Mickaël Salaün wrote:
> On Wed, Jan 29, 2025 at 04:44:18PM +0100, Matthieu Baerts wrote:
>> Hi Mickaël,
>>
>> On 29/01/2025 15:51, Mickaël Salaün wrote:
>>> On Wed, Jan 29, 2025 at 02:47:19PM +0300, Mikhail Ivanov wrote:
>>>> On 1/29/2025 2:33 PM, Matthieu Baerts wrote:
>>>>> On 29/01/2025 12:02, Mikhail Ivanov wrote:
>>>>>> On 1/29/2025 1:25 PM, Matthieu Baerts wrote:
>>>>>>> Hi Mikhail,
>>>>>>>
>>>>>>> On 29/01/2025 10:52, Mikhail Ivanov wrote:
>>>>>>>> On 1/28/2025 9:14 PM, Matthieu Baerts wrote:
>>>>>>>>> Hi Mikhail,
>>>>>>>>>
>>>>>>>>> Sorry, I didn't follow all the discussions in this thread, but here are
>>>>>>>>> some comments, hoping this can help to clarify the MPTCP case.
>>>>>>>>
>>>>>>>> Thanks a lot for sharing your knowledge, Matthieu!
>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 28/01/2025 11:56, Mikhail Ivanov wrote:
>>>>>>>>>> On 1/27/2025 10:48 PM, Mickaël Salaün wrote:
>>>>>>>>>
>>>>>>>>> (...)
>>>>>>>>>
>>>>>>>>>>> I'm a bit worried that we miss some of these places (now or in future
>>>>>>>>>>> kernel versions).  We'll need a new LSM hook for that.
>>>>>>>>>>>
>>>>>>>>>>> Could you list the current locations?
>>>>>>>>>>
>>>>>>>>>> Currently, I know only about TCP-related transformations:
>>>>>>>>>>
>>>>>>>>>> * SMC can fallback to TCP during connection. TCP connection is used
>>>>>>>>>>      (1) to exchange CLC control messages in default case and (2)
>>>>>>>>>> for the
>>>>>>>>>>      communication in the case of fallback. If socket was connected or
>>>>>>>>>>      connection failed, socket can not be reconnected again. There
>>>>>>>>>> is no
>>>>>>>>>>      existing security hook to control the fallback case,
>>>>>>>>>>
>>>>>>>>>> * MPTCP uses TCP for communication between two network interfaces
>>>>>>>>>> in the
>>>>>>>>>>      default case and can fallback to plain TCP if remote peer does not
>>>>>>>>>>      support MPTCP. AFAICS, there is also no security hook to
>>>>>>>>>> control the
>>>>>>>>>>      fallback transformation,
>>>>>>>>>
>>>>>>>>> There are security hooks to control the path creation, but not to
>>>>>>>>> control the "fallback transformation".
>>>>>>>>>
>>>>>>>>> Technically, with MPTCP, the userspace will create an IPPROTO_MPTCP
>>>>>>>>> socket. This is only used "internally": to communicate between the
>>>>>>>>> userspace and the kernelspace, but not directly used between network
>>>>>>>>> interfaces. This "external" communication is done via one or multiple
>>>>>>>>> kernel TCP sockets carrying extra TCP options for the mapping. The
>>>>>>>>> userspace cannot directly control these sockets created by the kernel.
>>>>>>>>>
>>>>>>>>> In case of fallback, the kernel TCP socket "simply" drop the extra TCP
>>>>>>>>> options needed for MPTCP, and carry on like normal TCP. So on the wire
>>>>>>>>> and in the Linux network stack, it is the same TCP connection, without
>>>>>>>>> the MPTCP options in the TCP header. The userspace continue to
>>>>>>>>> communicate with the same socket.
>>>>>>>>>
>>>>>>>>> I'm not sure if there is a need to block the fallback: it means only
>>>>>>>>> one
>>>>>>>>> path can be used at a time.
>>>
>>> Thanks Matthieu.
>>>
>>> So user space needs to specific IPPROTO_MPTCP to use MPTCP, but on the
>>> network this socket can translate to "augmented" or plain TCP.
>>
>> Correct. On the wire, you will only see packet with the IPPROTO_TCP
>> protocol. When MPTCP is used, extra MPTCP options will be present in the
>> TCP headers, but the protocol is still IPPROTO_TCP on the network.
>>
>>> From Landlock point of view, what matters is to have a consistent policy
>>> that maps to user space code.  The fear was that a malicious user space
>>> that is only allowed to use MPTCP could still transform an MPTCP socket
>>> to a TCP socket, while it wasn't allowed to create a TCP socket in the
>>> first place.  I now think this should not be an issue because:
>>> 1. MPTCP is kind of a superset of TCP
>>> 2. user space legitimately using MPTCP should not get any error related
>>>    to a Landlock policy because of TCP/any automatic fallback.  To say
>>>    it another way, such fallback is independent of user space requests
>>>    and may not be predicted because it is related to the current network
>>>    path.  This follows the principle of least astonishment (at least
>>>    from user space point of view).
>>>
>>> So, if I understand correctly, this should be simple for the Landlock
>>> socket creation control:  we only check socket properties at creation
>>> time and we ignore potential fallbacks.  This should be documented
>>> though.
>>
>> It depends on the restrictions that are put in place: are the user and
>> kernel sockets treated the same way? If yes, blocking TCP means that
>> even if it will be possible for the userspace to create an IPPROTO_MPTCP
>> socket, the kernel will not be allowed to IPPROTO_TCP ones to
>> communicate with the outside world. So blocking TCP will implicitly
>> block MPTCP.
>>
>> On the other hand, if only TCP user sockets are blocked, then it will be
>> possible to use MPTCP to communicate to any TCP sockets: with an
>> IPPROTO_MPTCP socket, it is possible to communicate with any IPPROTO_TCP
>> sockets, but without the extra features supported by MPTCP.
> 
> Yes, that how Landlock works, it only enforces a security policy defined
> by user space on user space.  The kernel on its own is never restricted.

OK, thank you, that's clearer.

>>> As an example, if a Landlock policies only allows MPTCP: socket(...,
>>> IPPROTO_MPTCP) should be allowed and any legitimate use of the returned
>>> socket (according to MPTCP) should be allowed, including TCP fallback.
>>> However, socket(..., IPPROTO_TCP/0), should only be allowed if TCP is
>>> explicitly allowed.  This means that we might end up with an MPTCP
>>> socket only using TCP, which is OK.
>>
>> Would it not be confusing for the person who set the Landlock policies?
>> Especially for the ones who had policies to block TCP, and thought they
>> were "safe", no?
> 
> There are two kind of users for Landlock:
> 1. developers sandboxing their applications;
> 2. sysadmins or security experts sandboxing execution environments (e.g.
>    with container runtimes, service managers, sandboxing tools...).
> 
> It would make sense for developers to allow what their code request,
> whatever fallback the kernel might use instead.  In this case, they
> should not care about MPTCP being TCP with some flags underneath.
> Moreover, developers might not be aware of the system on which their
> application is running, and their concern should mainly be about
> compatibility.
> 
> For security or network experts, implying that allowing MPTCP means that
> fallback to TCP is allowed might be a bit surprising at first, but they
> should have the knowledge to know how MPTCP works underneath, including
> this fallback mechanism.  Moreover, this kind of users can (and should)
> also rely on system-wide security policies such as Netfilter, which
> give more control.
> 
> In a nutshell, Landlock should favor compatibility at the sandboxing/app
> layers and we should rely on system-wide security policies (taking into
> account the running system's context) for more fine-grained control.
> This compatibility behaviors should be explained in the Landlock
> documentation though.

Thank you, also clearer!

In my mind, Landlock would be used to get a sort of "jail" so that "any"
users could use it to run untrusted apps for example. In that case, I
was thinking no everybody will know that MPTCP can be used to bypass
some restrictions only applied to TCP sockets.

>> If only TCP is blocked on the userspace side, simply using IPPROTO_MPTCP
>> instead of IPPROTO_TCP will allow any users to continue to talk with the
>> outside world. Also, it is easy to force apps to use IPPROTO_MPTCP
>> instead of IPPROTO_TCP, e.g. using 'mptcpize' which set LD_PRELOAD in
>> order to change the parameters of the socket() call.
>>
>>    mptcpize run curl https://check.mptcp.dev
> 
> Landlock restrictions are enforced at a specific time for a process and
> all its future children.  LD_PRELOAD is not an issue because a security
> policy cannot be disabled once enforced.  If a sandboxed program uses
> MPTCP (because of LD_PRELOAD) instead of TCP, the previously enforced
> policy will be enforced the same (either to allow or deny the use of
> MPTCP).
> 
> The only issue with LD_PRELOAD could be when e.g. curl sandboxes itself
> and denies itself the use of MPTCP, whereas mptcpize would "patch" the
> curl process to use MPTCP.  In this case, connections would failed.  A
> solution would be for mptcpize to "patch" the Landlock security as well,
> or for curl to be more permissive.  If the sandboxing happens before
> calling mptcpize, or if it is enforced by mptcpize, then it would work
> as expected.

OK, it is clearer for me now that I understand apps can sandbox themselves!

>>> I guess this should be the same for other protocols, except if user
>>> space can explicitly transform a specific socket type to use an
>>> *arbitrary* protocol, but I think this is not possible.
>> I'm sorry, I don't know what is possible with the other ones. But again,
>> blocking both user and kernel sockets the same way might make more sense
>> here.
>>
>>>>>>>>
>>>>>>>> You mean that users always rely on a plain TCP communication in the case
>>>>>>>> the connection of MPTCP multipath communication fails?
>>>>>>>
>>>>>>> Yes, that's the same TCP connection, just without extra bit to be able
>>>>>>> to use multiple TCP connections associated to the same MPTCP one.
>>>>>>
>>>>>> Indeed, so MPTCP communication should be restricted the same way as TCP.
>>>>>> AFAICS this should be intuitive for MPTCP users and it'll be better
>>>>>> to let userland define this dependency.
>>>>>
>>>>> Yes, I think that would make more sense.
>>>>>
>>>>> I guess we can look at MPTCP as TCP with extra features.
>>>>
>>>> Yeap
>>>>
>>>>>
>>>>> So if TCP is blocked, MPTCP should be blocked as well. (And eventually
>>>>> having the possibility to block only TCP but not MPTCP and the opposite,
>>>>> but that's a different topic: a possible new feature, but not a bug-fix)
>>>> What do you mean by the "bug fix"?
>>>>
>>>>>
>>>>>>>>>> * IPv6 -> IPv4 transformation for TCP and UDP sockets withon
>>>>>>>>>>      IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.
>>>
>>> According to the man page: "It is allowed only for IPv6 sockets that are
>>> connected and bound to a v4-mapped-on-v6 address."
>>>
>>> This compatibility feature makes sense from user space point of view and
>>> should not result in an error because of Landlock.
>>>
>>>>>>>>>>
>>>>>>>>>> As I said before, I wonder if user may want to use SMC or MPTCP and
>>>>>>>>>> deny
>>>>>>>>>> TCP communication, since he should rely on fallback transformation
>>>>>>>>>> during the connection in the common case. It may be unexpected for
>>>>>>>>>> connect(2) to fail during the fallback due to security politics.
>>>>>>>>>
>>>>>>>>> With MPTCP, fallbacks can happen at the beginning of a connection, when
>>>>>>>>> there is only one path. This is done after the userspace's
>>>>>>>>> connect(). If
>>>
>>> A remaining question is then, can we repurpose an MPTCP socket that did
>>> fallback to TCP, to (re)connect to another destination (this time
>>> directly with TCP)?
>>
>> If the socket was created with the IPPROTO_MPTCP protocol, the protocol
>> will not change after a disconnection. But still, with an MPTCP socket,
>> it is by design possible to connect to a TCP one no mater how the socket
>> was used before.
> 
> OK, this makes sense if we see MPTCP as a superset of TCP.
> 
>>
>>> I guess this is possible.  If it is the case, I think it should be OK
>>> anyway.  That could be used by an attacker, but that should not give
>>> more access because of the MPTCP fallback mechanism anyway.  We should
>>> see MPTCP as a superset of TCP.  At the end, security policy is in the
>>> hands of user space.
>>
>> As long as it is documented and not seen as a regression :)
>>
>> To me, it sounds strange to have to add extra rules for MPTCP if TCP is
>> blocked, but that's certainly because I see MPTCP like it is seen on the
>> wire: as an extension to TCP, not as a different protocol.
> 
> I understand.  For Landlock, I'd prefer to not add exceptions according
> to protocol implementations, but to define a security policy that could
> easily map to user space code.  The current proposal is to map the
> Landlock API to (a superset of) the socket(2) API, and then being able
> to specify restrictions on a domain, a type, or a protocol.  However, we
> could document and encourage users to only specify AF_INET/AF_INET6 +
> SOCK_STREAM but without specifying any protocol (not "0" but a wildcard
> "(u64)-1"), which would then implicitly allow TCP and MPTCP.

Good idea!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


