Return-Path: <linux-nfs+bounces-9582-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFFBA1B84B
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A56487A3F37
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Jan 2025 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA62C78F57;
	Fri, 24 Jan 2025 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="reRC9qwT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176EF84A5B
	for <linux-nfs@vger.kernel.org>; Fri, 24 Jan 2025 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730931; cv=none; b=PXbkGFGaMA9Gv4WhNI7dc5ZevsSIyktF8cHNjR2VxYzL7Ni8Ek/IVMwuiY/L7WNpdYbWgOXGmqSSfo7LzwcblYvqsBQsPd5g3tO/HvL9mLizU/JaYzgdgz2Lt12ChHaZZavoLN1DH7H4a5cKt7O/XNRyG3O5Ybhrqr03x93l4vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730931; c=relaxed/simple;
	bh=nH28DVYTP+TC0YE3Xzv7/009Ixuvu0optzt5JjA2QrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqzDPa4xuNrutxVYek4wyYEQm6Y8U8t/iKTyIhJa4zAtQ+57nEykMl8qGSIA2b4zm2OVxwfU3cWkV5x5BIgrhgut4cEJfNhYwX9cy9hyzCENPd0h8s7YXFKCPvWq/i0Wd+XSV08N4lkxQtgDm5JaiZQEyMruKpUAE2LOSgLLgTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=reRC9qwT; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YfgyM6BwWz13lS;
	Fri, 24 Jan 2025 16:02:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1737730923;
	bh=0NPsjoPT8LMmQNGl1K8J0cK2+QGlz7EopgYgFkv0jRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=reRC9qwTfvOmFD9Knsye/1sjgJr7MQoqETzttEhj9YV88vy9DgMSCd6Wb/FkcSPQ/
	 nmFQ+dg03nIHip+QpZSR/2Njh2/qYLIpik1bQ/DS3smDcMxpzkSNcDx7ehqu4H/6yg
	 d7LxyifGZpToie+jlrv2Nxb2A5pTeQeU/MKupIvc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4YfgyM0LgSzG3l;
	Fri, 24 Jan 2025 16:02:02 +0100 (CET)
Date: Fri, 24 Jan 2025 16:02:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, gnoack@google.com, 
	willemdebruijn.kernel@gmail.com, matthieu@buffet.re, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com, 
	MPTCP Linux <mptcp@lists.linux.dev>, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Message-ID: <20250124.gaegoo0Ayahn@digikod.net>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
 <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
 <20241018.Kahdeik0aaCh@digikod.net>
 <62336067-18c2-3493-d0ec-6dd6a6d3a1b5@huawei-partners.com>
 <20241212.qua0Os3sheev@digikod.net>
 <f480bbea-989d-378a-9493-c2bee412db00@huawei-partners.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f480bbea-989d-378a-9493-c2bee412db00@huawei-partners.com>
X-Infomaniak-Routing: alpha

On Fri, Dec 13, 2024 at 09:19:10PM +0300, Mikhail Ivanov wrote:
> On 12/12/2024 9:43 PM, Mickaël Salaün wrote:
> > On Thu, Oct 31, 2024 at 07:21:44PM +0300, Mikhail Ivanov wrote:
> > > On 10/18/2024 9:08 PM, Mickaël Salaün wrote:
> > > > On Thu, Oct 17, 2024 at 02:59:48PM +0200, Matthieu Baerts wrote:
> > > > > Hi Mikhail and Landlock maintainers,
> > > > > 
> > > > > +cc MPTCP list.
> > > > 
> > > > Thanks, we should include this list in the next series.
> > > > 
> > > > > 
> > > > > On 17/10/2024 13:04, Mikhail Ivanov wrote:
> > > > > > Do not check TCP access right if socket protocol is not IPPROTO_TCP.
> > > > > > LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP
> > > > > > should not restrict bind(2) and connect(2) for non-TCP protocols
> > > > > > (SCTP, MPTCP, SMC).
> > > > > 
> > > > > Thank you for the patch!
> > > > > 
> > > > > I'm part of the MPTCP team, and I'm wondering if MPTCP should not be
> > > > > treated like TCP here. MPTCP is an extension to TCP: on the wire, we can
> > > > > see TCP packets with extra TCP options. On Linux, there is indeed a
> > > > > dedicated MPTCP socket (IPPROTO_MPTCP), but that's just internal,
> > > > > because we needed such dedicated socket to talk to the userspace.
> > > > > 
> > > > > I don't know Landlock well, but I think it is important to know that an
> > > > > MPTCP socket can be used to discuss with "plain" TCP packets: the kernel
> > > > > will do a fallback to "plain" TCP if MPTCP is not supported by the other
> > > > > peer or by a middlebox. It means that with this patch, if TCP is blocked
> > > > > by Landlock, someone can simply force an application to create an MPTCP
> > > > > socket -- e.g. via LD_PRELOAD -- and bypass the restrictions. It will
> > > > > certainly work, even when connecting to a peer not supporting MPTCP.
> > > > > 
> > > > > Please note that I'm not against this modification -- especially here
> > > > > when we remove restrictions around MPTCP sockets :) -- I'm just saying
> > > > > it might be less confusing for users if MPTCP is considered as being
> > > > > part of TCP. A bit similar to what someone would do with a firewall: if
> > > > > TCP is blocked, MPTCP is blocked as well.
> > > > 
> > > > Good point!  I don't know well MPTCP but I think you're right.  Given
> > > > it's close relationship with TCP and the fallback mechanism, it would
> > > > make sense for users to not make a difference and it would avoid bypass
> > > > of misleading restrictions.  Moreover the Landlock rules are simple and
> > > > only control TCP ports, not peer addresses, which seems to be the main
> > > > evolution of MPTCP. >
> > > > > 
> > > > > I understand that a future goal might probably be to have dedicated
> > > > > restrictions for MPTCP and the other stream protocols (and/or for all
> > > > > stream protocols like it was before this patch), but in the meantime, it
> > > > > might be less confusing considering MPTCP as being part of TCP (I'm not
> > > > > sure about the other stream protocols).
> > > > 
> > > > We need to take a closer look at the other stream protocols indeed.
> > > Hello! Sorry for the late reply, I was on a small business trip.
> > > 
> > > Thanks a lot for this catch, without doubt MPTCP should be controlled
> > > with TCP access rights.
> > > 
> > > In that case, we should reconsider current semantics of TCP control.
> > > 
> > > Currently, it looks like this:
> > > * LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
> > > * LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to a
> > >    remote port.
> > > 
> > > According to these definitions only TCP sockets should be restricted and
> > > this is already provided by Landlock (considering observing commit)
> > > (assuming that "TCP socket" := user space socket of IPPROTO_TCP
> > > protocol).
> > > 
> > > AFAICS the two objectives of TCP access rights are to control
> > > (1) which ports can be used for sending or receiving TCP packets
> > >      (including SYN, ACK or other service packets).
> > > (2) which ports can be used to establish TCP connection (performed by
> > >      kernel network stack on server or client side).
> > > 
> > > In most cases denying (2) cause denying (1). Sending or receiving TCP
> > > packets without initial 3-way handshake is only possible on RAW [1] or
> > > PACKET [2] sockets. Usage of such sockets requires root privilligies, so
> > > there is no point to control them with Landlock.
> > 
> > I agree.
> > 
> > > 
> > > Therefore Landlock should only take care about case (2). For now
> > > (please correct me if I'm wrong), we only considered control of
> > > connection performed on user space plain TCP sockets (created with
> > > IPPROTO_TCP).
> > 
> > Correct. Landlock is dedicated to sandbox user space processes and the
> > related access rights should focus on restricting what is possible
> > through syscalls (mainly).
> > 
> > > 
> > > TCP kernel sockets are generally used in the following ways:
> > > * in a couple of other user space protocols (MPTCP, SMC, RDS)
> > > * in a few network filesystems (e.g. NFS communication over TCP)
> > > 
> > > For the second case TCP connection is currently not restricted by
> > > Landlock. This approach is may be correct, since NFS should not have
> > > access to a plain TCP communication and TCP restriction of NFS may
> > > be too implicit. Nevertheless, I think that restriction via current
> > > access rights should be considered.
> > 
> > I'm not sure what you mean here.  I'm not familiar with NFS in the
> > kernel.  AFAIK there is no socket type for NFS.
> 
> NFS client makes RPC requests to perform remote file operations on the
> NFS server. RPC requests can be sent using TCP, UDP, or RDMA sockets at
> the transport layer.
> 
> Call trace of creating TCP socket for client->server communication:
> 	nfs_create_rpc_client()
> 	rpc_create()
> 	xprt_create_transport()
> 	xs_setup_tcp()
> 	xs_tcp_setup_socket()
> 	xs_create_sock()
> 
> And RPC request is forwarded to TCP stack by calling
> 	xs_tcp_send_request().

OK, but it looks like this is connections on behalf of the kernel, that
only the kernel can use.  In other words, when these functions are
called, I guess current_cred() doesn't point to user space credentials.
Because the kernel cannot be restricted by Landlock, we should be good.

> 
> > 
> > > 
> > > For the first case, each protocol use TCP differently, so they should
> > > be considered separately.
> > 
> > Yes, for user-accessible protocols.
> > 
> > > 
> > > In the case of MPTCP TCP internal sockets are used to establish
> > > connection and exchange data between two network interfaces. MPTCP
> > > allows to have multiple TCP connections between two MPTCP sockets by
> > > connecting different network interfaces (e.g. WIFI and 3G).
> > > 
> > > Shared Memory Communication is a protocol that allows TCP applications
> > > transparently use RDMA for communication [3]. TCP internal socket is
> > > used to exchange service CLC messages when establishing SMC connection
> > > (which seems harmless for sandboxing) and for communication in the case
> > > of fallback. Fallback happens only if RDMA communication became
> > > impossible (e.g. if RDMA capable RNIC card went down on host or peer
> > > side). So, preventing TCP communication may be achieved by controlling
> > > fallback mechanism.
> > > 
> > > Reliable Datagram Socket is connectionless protocol implemented by
> > > Oracle [4]. It uses TCP stack or Infiniband to reliably deliever
> > > datagrams. For every sendmsg(2), recvmsg(2) it establishes TCP
> > > connection and use it to deliever splitted message.
> > > 
> > > In comparison with previous protocols, RDS sockets cannot be binded or
> > > connected to special TCP ports (e.g. with bind(2), connect(2)). 16385
> > > port is assigned to receiving side and sending side is binded to the
> > > port allocated by the kernel (by using zero as port number).
> > > 
> > > It may be useful to restrict RDS-over-TCP with current access rights,
> > > since it allows to perform TCP communication from user-space. But it
> > > would be only possible to fully allow or deny sending/receiving
> > > (since used ports are not controlled from user space).
> > 
> > Thanks for these explanations.  The ability to fine-control specific
> > protocol operations (e.g. connect, bind) can be useful for widely used
> > protocol such as TCP and UDP (or if someone wants to implement it for
> > another protocol), but this approach would not scale with all protocols
> > because of their own semantic and the development efforts.  The Landlock
> > access rights should be explicit, and we should also be able to deny
> > access to a whole set of protocols.  This should be partially possible
> > with your socket creation patch series.  I guess the remaining cases
> > would be to cover transformation of one socket type to another.  I think
> > we could control such transformation by building on top of the socket
> > creation control foundation: instead of controlling socket creation, add
> > a new access right to control socket transformation.  What do you think?
> 
> I agree that implementing fine-control network access rights for other
> protocols only to be able to completely restrict TCP operations seems
> excessive.
> 
> Do you mean the implementation of 2 access rights: for creating and
> transforming sockets?

Yes, but if it's not too complex I think it would make sense to only
have one access right that will cover these two cases.  I'm not sure
there is one common point where to check these socket transformation
though.

> 
> If so, there are only 2 socket protocols that can be transformed to TCP
> (in the fallback path) - MPTCP and SMC. Recall that in the case of RDS,
> a TCP socket can be used implicitly to deliver an RDS datagram.

Hmm, interesting.  Then we'll also need an access right to use a
protocol?  I'm worried that this kind of check would have a significant
performance impact.  I think we could tag a socket at creation time with
the allowed protocol transitions.

> Let's
> assume that the process of configuring TCP as a transport for RDS is
> also included in the socket transformation control.
> 
> Socket creation control is sufficient to restrict the implicit use of a
> TCP connection. Theoretically, separate socket transformation
> control is only required if the user wants to use (for example) SMC
> sockets with restricted (partially or completely) TCP bind(2) and
> connect(2) actions. But SMC (or MPTCP) applications should rely on TCP
> communication in case of fallback. I think they are unlikely to have any
> TCP restrictions.
> 
> However, control of fallback to TCP by applying socket creation rules
> is too implicit and inconvenient.
> 
> Initially, I thought that users could expect TCP access rights to
> completely restrict the corresponding TCP actions without additional
> rules for sockets. I have concerns that socket transformation control
> would not be explicit enough for such purpose.
> 
> Probably, it will be more correctly to apply rules that deny creation of
> SMC, MPTCP and RDS sockets (or their transformation to TCP) in
> landlock_restrict_self() if TCP actions are not fully allowed?

That should be achieved with your socket creation control patch series
right?

I'm not sure to understand the use of landlock_restrict_self() here.
Rulesets should fully define an access control on their own.

> 
> > 
> > > 
> > > Restricting any TCP connection in the kernel is probably simplest
> > > design, but we should consider above cases to provide the most useful
> > > one.
> > > 
> > > [1] https://man7.org/linux/man-pages/man7/raw.7.html
> > > [2] https://man7.org/linux/man-pages/man7/packet.7.html
> > > [3] https://datatracker.ietf.org/doc/html/rfc7609
> > > [4] https://oss.oracle.com/projects/rds/dist/documentation/rds-3.1-spec.html
> > > 
> > > > 
> > > > > 
> > > > > 
> > > > > > sk_is_tcp() is used for this to check address family of the socket
> > > > > > before doing INET-specific address length validation. This is required
> > > > > > for error consistency.

Could you please send a new patch series for this specific fix,
including minimal tests?  I'd like to merge that as soon as possible,
and it will be backported to all kernel versions.

> > > > > > 
> > > > > > Closes: https://github.com/landlock-lsm/linux/issues/40
> > > > > > Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
> > > > > 
> > > > > I don't know how fixes are considered in Landlock, but should this patch
> > > > > be considered as a fix? It might be surprising for someone who thought
> > > > > all "stream" connections were blocked to have them unblocked when
> > > > > updating to a minor kernel version, no?
> > > > 
> > > > Indeed.  The main issue was with the semantic/definition of
> > > > LANDLOCK_ACCESS_FS_NET_{CONNECT,BIND}_TCP.  We need to synchronize the
> > > > code with the documentation, one way or the other, preferably following
> > > > the principle of least astonishment.
> > > > 
> > > > > 
> > > > > (Personally, I would understand such behaviour change when upgrading to
> > > > > a major version, and still, maybe only if there were alternatives to
> > > > 
> > > > This "fix" needs to be backported, but we're not clear yet on what it
> > > > should be. :)
> > > > 
> > > > > continue having the same behaviour, e.g. a way to restrict all stream
> > > > > sockets the same way, or something per stream socket. But that's just me
> > > > > :) )
> > > > 
> > > > The documentation and the initial idea was to control TCP bind and
> > > > connect.  The kernel implementation does more than that, so we need to
> > > > synthronize somehow.
> > > > 
> > > > > 
> > > > > Cheers,
> > > > > Matt
> > > > > -- 
> > > > > Sponsored by the NGI0 Core fund.
> > > > > 
> > > > > 
> > > 
> 

