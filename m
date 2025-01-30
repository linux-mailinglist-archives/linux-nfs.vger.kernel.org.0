Return-Path: <linux-nfs+bounces-9778-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD29A22B05
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 10:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CE518814E2
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Jan 2025 09:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B691B6D0F;
	Thu, 30 Jan 2025 09:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rfa5Q7c8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224101B87C9
	for <linux-nfs@vger.kernel.org>; Thu, 30 Jan 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738231063; cv=none; b=IfroCbjKufWCFkJb98CpreVF+7MUJ6kJdsC/SQz3rgewjNPI61yTumzcQVRtez2DpOFNqH9kA4vBGEoO1ZfFndVi/SfsNM0RD8OUEI0z/4FcnOHekCim4QFb/EnWCchRbee7OCqkd5vB3lUPFa7UmECK1Yla1QsZmENyXT+DDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738231063; c=relaxed/simple;
	bh=M1G3bPGJ7ltahw2nrExz3W1U4Y3lSF4XA1+ifN1BJ3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNwn64yijSCSmRSonLZ+8q/d7ciQQz8IZkAVyvlAphD+Af4Jfq4T9Kgk2Erl6R50TTNc/Wc6Jg0BrJLzBR5QrBLA4/IzwYBNyj3b46b1tbwA6JfkWgVcLX5t09rC9oqEq3RfnEk9aGYy/rhi4HOh6ZsiU/87S+fuoS6A77R3uek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rfa5Q7c8; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YkDnV0P4vzfWS;
	Thu, 30 Jan 2025 10:51:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738230701;
	bh=YZm0vTuwCQA/yZDxmiQL1tM2SC0CyU6mDR1fUgobEaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rfa5Q7c8BZlxn76PD00hzcjeKBZIxcKQoM7rqXLK0zImquZ9ipQCBOFnOA6zcbtQv
	 XdVE+SR/ismYu/Sxlmk35/CmYkX+r+kLscxgVY+iNv25uS7Qb1sJ0RV4+cgbe81vuE
	 ToRkGSCjl/emS3aY/1GWc/JM2fAyddv/J+ecGMc8=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YkDnT0NLPzWgd;
	Thu, 30 Jan 2025 10:51:40 +0100 (CET)
Date: Thu, 30 Jan 2025 10:51:40 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	gnoack@google.com, willemdebruijn.kernel@gmail.com, matthieu@buffet.re, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com, 
	MPTCP Linux <mptcp@lists.linux.dev>, linux-nfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Message-ID: <20250130.Xe3Ohtai5aen@digikod.net>
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
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b1de00-c724-4748-9133-acd0a79b6d72@kernel.org>
X-Infomaniak-Routing: alpha

On Wed, Jan 29, 2025 at 04:44:18PM +0100, Matthieu Baerts wrote:
> Hi Mickaël,
> 
> On 29/01/2025 15:51, Mickaël Salaün wrote:
> > On Wed, Jan 29, 2025 at 02:47:19PM +0300, Mikhail Ivanov wrote:
> >> On 1/29/2025 2:33 PM, Matthieu Baerts wrote:
> >>> On 29/01/2025 12:02, Mikhail Ivanov wrote:
> >>>> On 1/29/2025 1:25 PM, Matthieu Baerts wrote:
> >>>>> Hi Mikhail,
> >>>>>
> >>>>> On 29/01/2025 10:52, Mikhail Ivanov wrote:
> >>>>>> On 1/28/2025 9:14 PM, Matthieu Baerts wrote:
> >>>>>>> Hi Mikhail,
> >>>>>>>
> >>>>>>> Sorry, I didn't follow all the discussions in this thread, but here are
> >>>>>>> some comments, hoping this can help to clarify the MPTCP case.
> >>>>>>
> >>>>>> Thanks a lot for sharing your knowledge, Matthieu!
> >>>>>>
> >>>>>>>
> >>>>>>> On 28/01/2025 11:56, Mikhail Ivanov wrote:
> >>>>>>>> On 1/27/2025 10:48 PM, Mickaël Salaün wrote:
> >>>>>>>
> >>>>>>> (...)
> >>>>>>>
> >>>>>>>>> I'm a bit worried that we miss some of these places (now or in future
> >>>>>>>>> kernel versions).  We'll need a new LSM hook for that.
> >>>>>>>>>
> >>>>>>>>> Could you list the current locations?
> >>>>>>>>
> >>>>>>>> Currently, I know only about TCP-related transformations:
> >>>>>>>>
> >>>>>>>> * SMC can fallback to TCP during connection. TCP connection is used
> >>>>>>>>      (1) to exchange CLC control messages in default case and (2)
> >>>>>>>> for the
> >>>>>>>>      communication in the case of fallback. If socket was connected or
> >>>>>>>>      connection failed, socket can not be reconnected again. There
> >>>>>>>> is no
> >>>>>>>>      existing security hook to control the fallback case,
> >>>>>>>>
> >>>>>>>> * MPTCP uses TCP for communication between two network interfaces
> >>>>>>>> in the
> >>>>>>>>      default case and can fallback to plain TCP if remote peer does not
> >>>>>>>>      support MPTCP. AFAICS, there is also no security hook to
> >>>>>>>> control the
> >>>>>>>>      fallback transformation,
> >>>>>>>
> >>>>>>> There are security hooks to control the path creation, but not to
> >>>>>>> control the "fallback transformation".
> >>>>>>>
> >>>>>>> Technically, with MPTCP, the userspace will create an IPPROTO_MPTCP
> >>>>>>> socket. This is only used "internally": to communicate between the
> >>>>>>> userspace and the kernelspace, but not directly used between network
> >>>>>>> interfaces. This "external" communication is done via one or multiple
> >>>>>>> kernel TCP sockets carrying extra TCP options for the mapping. The
> >>>>>>> userspace cannot directly control these sockets created by the kernel.
> >>>>>>>
> >>>>>>> In case of fallback, the kernel TCP socket "simply" drop the extra TCP
> >>>>>>> options needed for MPTCP, and carry on like normal TCP. So on the wire
> >>>>>>> and in the Linux network stack, it is the same TCP connection, without
> >>>>>>> the MPTCP options in the TCP header. The userspace continue to
> >>>>>>> communicate with the same socket.
> >>>>>>>
> >>>>>>> I'm not sure if there is a need to block the fallback: it means only
> >>>>>>> one
> >>>>>>> path can be used at a time.
> > 
> > Thanks Matthieu.
> > 
> > So user space needs to specific IPPROTO_MPTCP to use MPTCP, but on the
> > network this socket can translate to "augmented" or plain TCP.
> 
> Correct. On the wire, you will only see packet with the IPPROTO_TCP
> protocol. When MPTCP is used, extra MPTCP options will be present in the
> TCP headers, but the protocol is still IPPROTO_TCP on the network.
> 
> > From Landlock point of view, what matters is to have a consistent policy
> > that maps to user space code.  The fear was that a malicious user space
> > that is only allowed to use MPTCP could still transform an MPTCP socket
> > to a TCP socket, while it wasn't allowed to create a TCP socket in the
> > first place.  I now think this should not be an issue because:
> > 1. MPTCP is kind of a superset of TCP
> > 2. user space legitimately using MPTCP should not get any error related
> >    to a Landlock policy because of TCP/any automatic fallback.  To say
> >    it another way, such fallback is independent of user space requests
> >    and may not be predicted because it is related to the current network
> >    path.  This follows the principle of least astonishment (at least
> >    from user space point of view).
> > 
> > So, if I understand correctly, this should be simple for the Landlock
> > socket creation control:  we only check socket properties at creation
> > time and we ignore potential fallbacks.  This should be documented
> > though.
> 
> It depends on the restrictions that are put in place: are the user and
> kernel sockets treated the same way? If yes, blocking TCP means that
> even if it will be possible for the userspace to create an IPPROTO_MPTCP
> socket, the kernel will not be allowed to IPPROTO_TCP ones to
> communicate with the outside world. So blocking TCP will implicitly
> block MPTCP.
> 
> On the other hand, if only TCP user sockets are blocked, then it will be
> possible to use MPTCP to communicate to any TCP sockets: with an
> IPPROTO_MPTCP socket, it is possible to communicate with any IPPROTO_TCP
> sockets, but without the extra features supported by MPTCP.

Yes, that how Landlock works, it only enforces a security policy defined
by user space on user space.  The kernel on its own is never restricted.

> 
> > As an example, if a Landlock policies only allows MPTCP: socket(...,
> > IPPROTO_MPTCP) should be allowed and any legitimate use of the returned
> > socket (according to MPTCP) should be allowed, including TCP fallback.
> > However, socket(..., IPPROTO_TCP/0), should only be allowed if TCP is
> > explicitly allowed.  This means that we might end up with an MPTCP
> > socket only using TCP, which is OK.
> 
> Would it not be confusing for the person who set the Landlock policies?
> Especially for the ones who had policies to block TCP, and thought they
> were "safe", no?

There are two kind of users for Landlock:
1. developers sandboxing their applications;
2. sysadmins or security experts sandboxing execution environments (e.g.
   with container runtimes, service managers, sandboxing tools...).

It would make sense for developers to allow what their code request,
whatever fallback the kernel might use instead.  In this case, they
should not care about MPTCP being TCP with some flags underneath.
Moreover, developers might not be aware of the system on which their
application is running, and their concern should mainly be about
compatibility.

For security or network experts, implying that allowing MPTCP means that
fallback to TCP is allowed might be a bit surprising at first, but they
should have the knowledge to know how MPTCP works underneath, including
this fallback mechanism.  Moreover, this kind of users can (and should)
also rely on system-wide security policies such as Netfilter, which
give more control.

In a nutshell, Landlock should favor compatibility at the sandboxing/app
layers and we should rely on system-wide security policies (taking into
account the running system's context) for more fine-grained control.
This compatibility behaviors should be explained in the Landlock
documentation though.

> 
> If only TCP is blocked on the userspace side, simply using IPPROTO_MPTCP
> instead of IPPROTO_TCP will allow any users to continue to talk with the
> outside world. Also, it is easy to force apps to use IPPROTO_MPTCP
> instead of IPPROTO_TCP, e.g. using 'mptcpize' which set LD_PRELOAD in
> order to change the parameters of the socket() call.
> 
>    mptcpize run curl https://check.mptcp.dev

Landlock restrictions are enforced at a specific time for a process and
all its future children.  LD_PRELOAD is not an issue because a security
policy cannot be disabled once enforced.  If a sandboxed program uses
MPTCP (because of LD_PRELOAD) instead of TCP, the previously enforced
policy will be enforced the same (either to allow or deny the use of
MPTCP).

The only issue with LD_PRELOAD could be when e.g. curl sandboxes itself
and denies itself the use of MPTCP, whereas mptcpize would "patch" the
curl process to use MPTCP.  In this case, connections would failed.  A
solution would be for mptcpize to "patch" the Landlock security as well,
or for curl to be more permissive.  If the sandboxing happens before
calling mptcpize, or if it is enforced by mptcpize, then it would work
as expected.

> 
> > I guess this should be the same for other protocols, except if user
> > space can explicitly transform a specific socket type to use an
> > *arbitrary* protocol, but I think this is not possible.
> I'm sorry, I don't know what is possible with the other ones. But again,
> blocking both user and kernel sockets the same way might make more sense
> here.
> 
> >>>>>>
> >>>>>> You mean that users always rely on a plain TCP communication in the case
> >>>>>> the connection of MPTCP multipath communication fails?
> >>>>>
> >>>>> Yes, that's the same TCP connection, just without extra bit to be able
> >>>>> to use multiple TCP connections associated to the same MPTCP one.
> >>>>
> >>>> Indeed, so MPTCP communication should be restricted the same way as TCP.
> >>>> AFAICS this should be intuitive for MPTCP users and it'll be better
> >>>> to let userland define this dependency.
> >>>
> >>> Yes, I think that would make more sense.
> >>>
> >>> I guess we can look at MPTCP as TCP with extra features.
> >>
> >> Yeap
> >>
> >>>
> >>> So if TCP is blocked, MPTCP should be blocked as well. (And eventually
> >>> having the possibility to block only TCP but not MPTCP and the opposite,
> >>> but that's a different topic: a possible new feature, but not a bug-fix)
> >> What do you mean by the "bug fix"?
> >>
> >>>
> >>>>>>>> * IPv6 -> IPv4 transformation for TCP and UDP sockets withon
> >>>>>>>>      IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.
> > 
> > According to the man page: "It is allowed only for IPv6 sockets that are
> > connected and bound to a v4-mapped-on-v6 address."
> > 
> > This compatibility feature makes sense from user space point of view and
> > should not result in an error because of Landlock.
> > 
> >>>>>>>>
> >>>>>>>> As I said before, I wonder if user may want to use SMC or MPTCP and
> >>>>>>>> deny
> >>>>>>>> TCP communication, since he should rely on fallback transformation
> >>>>>>>> during the connection in the common case. It may be unexpected for
> >>>>>>>> connect(2) to fail during the fallback due to security politics.
> >>>>>>>
> >>>>>>> With MPTCP, fallbacks can happen at the beginning of a connection, when
> >>>>>>> there is only one path. This is done after the userspace's
> >>>>>>> connect(). If
> > 
> > A remaining question is then, can we repurpose an MPTCP socket that did
> > fallback to TCP, to (re)connect to another destination (this time
> > directly with TCP)?
> 
> If the socket was created with the IPPROTO_MPTCP protocol, the protocol
> will not change after a disconnection. But still, with an MPTCP socket,
> it is by design possible to connect to a TCP one no mater how the socket
> was used before.

OK, this makes sense if we see MPTCP as a superset of TCP.

> 
> > I guess this is possible.  If it is the case, I think it should be OK
> > anyway.  That could be used by an attacker, but that should not give
> > more access because of the MPTCP fallback mechanism anyway.  We should
> > see MPTCP as a superset of TCP.  At the end, security policy is in the
> > hands of user space.
> 
> As long as it is documented and not seen as a regression :)
> 
> To me, it sounds strange to have to add extra rules for MPTCP if TCP is
> blocked, but that's certainly because I see MPTCP like it is seen on the
> wire: as an extension to TCP, not as a different protocol.

I understand.  For Landlock, I'd prefer to not add exceptions according
to protocol implementations, but to define a security policy that could
easily map to user space code.  The current proposal is to map the
Landlock API to (a superset of) the socket(2) API, and then being able
to specify restrictions on a domain, a type, or a protocol.  However, we
could document and encourage users to only specify AF_INET/AF_INET6 +
SOCK_STREAM but without specifying any protocol (not "0" but a wildcard
"(u64)-1"), which would then implicitly allow TCP and MPTCP.

> 
> (...)
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.
> 

