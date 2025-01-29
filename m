Return-Path: <linux-nfs+bounces-9755-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC77A21FAB
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 15:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104B91884FCD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2025 14:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFA51B4250;
	Wed, 29 Jan 2025 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="cNHnr2G6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7CDDCD
	for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2025 14:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738162311; cv=none; b=DPUlut3RpEjFX4j8yUcpji4qnz765dCM4TffeL+cirhHDsBAhY+qQrtIXa0wLybw0n0hcvorIO1ExJDAZH6CGMCnFpHe2LhA8yFPkAOrWEjdmS4b+V/wuEeC0bu7xnUEXeBMTKVx+CIulmpBCKVgDf0cPUWV49jpjhiKbOb9hmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738162311; c=relaxed/simple;
	bh=uuQ4gUyr4T98j5sQ5sSoBuo1/xncsxBUuh+PdKyTBVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnlXlYztSO+Dtuo+larVbKugtQ4VMtBNyCzaiufSMwqgTcXGhg+KwxH6QcTv239CBrTyGTdkp7yMRLq80wAV8ZqhL1wyOkCGLsExmZthMLN4gcjR7jcUL2Di7EmqvGPHRqrLFBepAzRucJHhBKsGmOp6JLehk0V5mY4JPaFVwFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=cNHnr2G6; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YjlV3415nzfSj;
	Wed, 29 Jan 2025 15:51:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1738162299;
	bh=2erhwkosldZzlYXN0aQNMdfWuWfgAvD7dxnnGlGxpL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNHnr2G6Ooekqbm7My2q4rIn6J5wICpi8LnTdj8sUbTTzAjmOAJn/sG4LRLNklStU
	 zRWF09DWvM60RwwRH2PNVKsQwGwQ/Gt/X5XfujgsE3ea+VdEfDJ2RIdDV8GE0+NK7S
	 OBX9jIzjJkIpCtrxhEVxuW31Dzl8dkiNl1HWwDS0=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YjlV26H4hzX82;
	Wed, 29 Jan 2025 15:51:38 +0100 (CET)
Date: Wed, 29 Jan 2025 15:51:37 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, gnoack@google.com, 
	willemdebruijn.kernel@gmail.com, matthieu@buffet.re, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com, 
	MPTCP Linux <mptcp@lists.linux.dev>, linux-nfs@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Message-ID: <20250129.Oo1xou8ieche@digikod.net>
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
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b9823ff1-2f66-3992-b389-b8e631ec03ba@huawei-partners.com>
X-Infomaniak-Routing: alpha

On Wed, Jan 29, 2025 at 02:47:19PM +0300, Mikhail Ivanov wrote:
> On 1/29/2025 2:33 PM, Matthieu Baerts wrote:
> > On 29/01/2025 12:02, Mikhail Ivanov wrote:
> > > On 1/29/2025 1:25 PM, Matthieu Baerts wrote:
> > > > Hi Mikhail,
> > > > 
> > > > On 29/01/2025 10:52, Mikhail Ivanov wrote:
> > > > > On 1/28/2025 9:14 PM, Matthieu Baerts wrote:
> > > > > > Hi Mikhail,
> > > > > > 
> > > > > > Sorry, I didn't follow all the discussions in this thread, but here are
> > > > > > some comments, hoping this can help to clarify the MPTCP case.
> > > > > 
> > > > > Thanks a lot for sharing your knowledge, Matthieu!
> > > > > 
> > > > > > 
> > > > > > On 28/01/2025 11:56, Mikhail Ivanov wrote:
> > > > > > > On 1/27/2025 10:48 PM, Mickaël Salaün wrote:
> > > > > > 
> > > > > > (...)
> > > > > > 
> > > > > > > > I'm a bit worried that we miss some of these places (now or in future
> > > > > > > > kernel versions).  We'll need a new LSM hook for that.
> > > > > > > > 
> > > > > > > > Could you list the current locations?
> > > > > > > 
> > > > > > > Currently, I know only about TCP-related transformations:
> > > > > > > 
> > > > > > > * SMC can fallback to TCP during connection. TCP connection is used
> > > > > > >      (1) to exchange CLC control messages in default case and (2)
> > > > > > > for the
> > > > > > >      communication in the case of fallback. If socket was connected or
> > > > > > >      connection failed, socket can not be reconnected again. There
> > > > > > > is no
> > > > > > >      existing security hook to control the fallback case,
> > > > > > > 
> > > > > > > * MPTCP uses TCP for communication between two network interfaces
> > > > > > > in the
> > > > > > >      default case and can fallback to plain TCP if remote peer does not
> > > > > > >      support MPTCP. AFAICS, there is also no security hook to
> > > > > > > control the
> > > > > > >      fallback transformation,
> > > > > > 
> > > > > > There are security hooks to control the path creation, but not to
> > > > > > control the "fallback transformation".
> > > > > > 
> > > > > > Technically, with MPTCP, the userspace will create an IPPROTO_MPTCP
> > > > > > socket. This is only used "internally": to communicate between the
> > > > > > userspace and the kernelspace, but not directly used between network
> > > > > > interfaces. This "external" communication is done via one or multiple
> > > > > > kernel TCP sockets carrying extra TCP options for the mapping. The
> > > > > > userspace cannot directly control these sockets created by the kernel.
> > > > > > 
> > > > > > In case of fallback, the kernel TCP socket "simply" drop the extra TCP
> > > > > > options needed for MPTCP, and carry on like normal TCP. So on the wire
> > > > > > and in the Linux network stack, it is the same TCP connection, without
> > > > > > the MPTCP options in the TCP header. The userspace continue to
> > > > > > communicate with the same socket.
> > > > > > 
> > > > > > I'm not sure if there is a need to block the fallback: it means only
> > > > > > one
> > > > > > path can be used at a time.

Thanks Matthieu.

So user space needs to specific IPPROTO_MPTCP to use MPTCP, but on the
network this socket can translate to "augmented" or plain TCP.

From Landlock point of view, what matters is to have a consistent policy
that maps to user space code.  The fear was that a malicious user space
that is only allowed to use MPTCP could still transform an MPTCP socket
to a TCP socket, while it wasn't allowed to create a TCP socket in the
first place.  I now think this should not be an issue because:
1. MPTCP is kind of a superset of TCP
2. user space legitimately using MPTCP should not get any error related
   to a Landlock policy because of TCP/any automatic fallback.  To say
   it another way, such fallback is independent of user space requests
   and may not be predicted because it is related to the current network
   path.  This follows the principle of least astonishment (at least
   from user space point of view).

So, if I understand correctly, this should be simple for the Landlock
socket creation control:  we only check socket properties at creation
time and we ignore potential fallbacks.  This should be documented
though.

As an example, if a Landlock policies only allows MPTCP: socket(...,
IPPROTO_MPTCP) should be allowed and any legitimate use of the returned
socket (according to MPTCP) should be allowed, including TCP fallback.
However, socket(..., IPPROTO_TCP/0), should only be allowed if TCP is
explicitly allowed.  This means that we might end up with an MPTCP
socket only using TCP, which is OK.

I guess this should be the same for other protocols, except if user
space can explicitly transform a specific socket type to use an
*arbitrary* protocol, but I think this is not possible.

> > > > > 
> > > > > You mean that users always rely on a plain TCP communication in the case
> > > > > the connection of MPTCP multipath communication fails?
> > > > 
> > > > Yes, that's the same TCP connection, just without extra bit to be able
> > > > to use multiple TCP connections associated to the same MPTCP one.
> > > 
> > > Indeed, so MPTCP communication should be restricted the same way as TCP.
> > > AFAICS this should be intuitive for MPTCP users and it'll be better
> > > to let userland define this dependency.
> > 
> > Yes, I think that would make more sense.
> > 
> > I guess we can look at MPTCP as TCP with extra features.
> 
> Yeap
> 
> > 
> > So if TCP is blocked, MPTCP should be blocked as well. (And eventually
> > having the possibility to block only TCP but not MPTCP and the opposite,
> > but that's a different topic: a possible new feature, but not a bug-fix)
> What do you mean by the "bug fix"?
> 
> > 
> > > > > > > * IPv6 -> IPv4 transformation for TCP and UDP sockets withon
> > > > > > >      IPV6_ADDRFORM. Can be controlled with setsockopt() security hook.

According to the man page: "It is allowed only for IPv6 sockets that are
connected and bound to a v4-mapped-on-v6 address."

This compatibility feature makes sense from user space point of view and
should not result in an error because of Landlock.

> > > > > > > 
> > > > > > > As I said before, I wonder if user may want to use SMC or MPTCP and
> > > > > > > deny
> > > > > > > TCP communication, since he should rely on fallback transformation
> > > > > > > during the connection in the common case. It may be unexpected for
> > > > > > > connect(2) to fail during the fallback due to security politics.
> > > > > > 
> > > > > > With MPTCP, fallbacks can happen at the beginning of a connection, when
> > > > > > there is only one path. This is done after the userspace's
> > > > > > connect(). If

A remaining question is then, can we repurpose an MPTCP socket that did
fallback to TCP, to (re)connect to another destination (this time
directly with TCP)?

I guess this is possible.  If it is the case, I think it should be OK
anyway.  That could be used by an attacker, but that should not give
more access because of the MPTCP fallback mechanism anyway.  We should
see MPTCP as a superset of TCP.  At the end, security policy is in the
hands of user space.

> > > > > > the fallback is blocked, I guess the userspace will get the same errors
> > > > > > as when an open connection is reset.
> > > > > 
> > > > > In the case of blocking due to security policy, userspace should get
> > > > > -EACESS. I mean, the user might not expect the fallback path to be
> > > > > blocked during the connection if he has allowed only MPTCP communication
> > > > > using the Landlock policy.
> > > > 
> > > > A "fallback" can happen on different occasions as mentioned in the
> > > > RFC8684 [1], e.g.
> > > > 
> > > > - The client asks to use MPTCP, but the other peer doesn't support it:
> > > > 
> > > >     Client                Server
> > > >     |     SYN + MP_CAPABLE     |
> > > >     |------------------------->|
> > > >     |         SYN/ACK          |
> > > >     |<-------------------------|  => Fallback on the client side
> > > >     |           ACK            |
> > > >     |------------------------->|
> > > > 
> > > > - A middle box doesn't touch the 3WHS, but intercept the communication
> > > > just after:
> > > > 
> > > >     Client                Server
> > > >     |     SYN + MP_CAPABLE     |
> > > >     |------------------------->|
> > > >     |   SYN/ACK + MP_CAPABLE   |
> > > >     |<-------------------------|
> > > >     |     ACK + MP_CAPABLE     |
> > > >     |------------------------->|
> > > >     |        DSS + data        | => but the server doesn't receive the DSS
> > > >     |------------------------->| => So fallback on the server side
> > > >     |           ACK            |
> > > >     |<-------------------------| => Fallback on the client side
> > > > 
> > > > - etc.
> > > > 
> > > > So the connect(), even in blocking mode, can be OK, but the "fallback"
> > > > will happen later.
> > > 
> > > Thanks! Theoretical "socket transformation" control should cover all
> > > these cases.
> > > 
> > > You mean that it might be reasonable for a Landlock policy to block
> > > MPTCP fallback when establishing first sublflow (when client does not
> > > receive MP_CAPABLE)?
> > 
> > Personally, I don't even know if there is really a need for such
> > policies. The fallback is there not to block a connection if the other
> > peer doesn't support MPTCP, or if a middlebox decides to mess-up with
> > MPTCP options. So instead of an error, the connection continues but is
> > "degraded" by not being able to create multiple paths later on.

I agree, this kind of compatibility feature should not be denied.

> > 
> > Maybe best to wait for a concrete use-case before implementing this?
> 
> Ok, got it! I agree that such policies does not seem to be useful.
> 
> > 
> > (...)
> > 
> > Cheers,
> > Matt
> 

