Return-Path: <linux-nfs+bounces-2414-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330E98812FB
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 15:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC2152867B9
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187463D54C;
	Wed, 20 Mar 2024 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bDttjbg8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F3A3A267
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943815; cv=none; b=eDUNA+AaHH6hyI/pv2IN7IFsU+PgRqx881bYMmUt1Om3UAwcw6iwwalrXhsQXGC/6WfwHuBzgWc88EDE6O8wZgmc2CqSYkSJfOqAeSPQv4w+Nr1Zq2WsfKTVa+vpNVMJMX2T4xcA+sdlZuGsesk5jF48TX8qIaXcn4ejSHMnZC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943815; c=relaxed/simple;
	bh=3ou5oUCQ86hqBqM0oL6+1qxMCbrCMDn4y0Od3IVxbF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/2UThJywq8WuwTZPu3Nz7mnP8x5tY1dvVtcGxqTqXgSIyFs7eXnqT+N4KhMM/ip36h6rHLwu/b0Uu1gSCizFeI9JIybwAeAM1ViqkK5miAtERweCyhXXChVy8CWVtxqvTqzrx4lQ9+aTiw0vg7r5cx3ap+vQ1T78g4phfsGQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bDttjbg8; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-430c4e67d40so23833971cf.3
        for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 07:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710943811; x=1711548611; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+TBwiaClEnyRyOmF0p2cnVM2eYlHll3J9TyTRhX/lf0=;
        b=bDttjbg8o0QcbSc7SHaAn98ILtqIjl+IKIyQiN0y9zTZmg3Y9h8tODq4VIeIfR/T9j
         tWE7d5OwLxuUSJAGVuvLdktMvgPq2OoXGIg/2yoXLTqQt8O9gjV0IcbvT6WTOFLZ6LQK
         rtCcIcDWA6zu9T/UwmP1v+oKL+yAqoymMs8grxwz8Wsh9s+2+A4g9G+AkUu6sQT/iVDW
         NdxWS5AG/CpD8/KI0Pc8L8V7zSVvj1y+eoIjqnGHM++yawYV4dvcrPVkDhGgydVE6MFl
         3ag1E9J0y45BlCW4ksNfVZgcufH1AvHYIxDH+SjoNQT9mo7jND4wBVQiZyB5E8s+HlR3
         Pxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710943811; x=1711548611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+TBwiaClEnyRyOmF0p2cnVM2eYlHll3J9TyTRhX/lf0=;
        b=a/0+gALCbVVWJIm3Co6aWGpDyKk2VUg/PvGmSlfGTOCOcDZ7tZjmFkqESQ8kvhW35L
         peupyNmFha2x4eNOcduToZAsWPe0xps06vInhhNfejPriPq0vPkMu4oOT/DruZaes6wS
         GXjSK84AgtiTpxOHyEaG3i0rqsNRqBtnRMB+PPaFsfJwTUhC9M5ZcMpv6MoqCY22SQmn
         MfcptfmDHpU001wxmw4cB2OMN8e1oelxixing8ngYu2VuqLruaI5bFyQ0cVJHUkLL1lA
         Uurm9CXr1fR4nx3YHUybOmup+tWignkQ8CCmxpSS975cFw9sj+qEWCfUVosIz1WSngNA
         ZYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUZmx/bO1H/4DMPBvnV9BTwUsUfa9CB77UdtM0WQGQbvps4wNPbA8TA/Ye/H2vmHuqzGaATPnEzAhWphGyaSPhDwiDxzlow3D18
X-Gm-Message-State: AOJu0YwKxFhiUiTxv8JhyrzmA+Ip0hPayeUADaEfEMUnqfRQEtoWqOaH
	wsdo227/oagk0LtTcFENE2FLVLFqmmtU90cXGB8kSVfUdP0Sltda7aR1wm3IxbY=
X-Google-Smtp-Source: AGHT+IFiGXDjcDIioggROyIlwfHotNbK4zIwxjqLjA/U8eB8yMyqIIWAwasOY2TZblXp+6aDXk19fQ==
X-Received: by 2002:a05:622a:86:b0:430:d18c:2f22 with SMTP id o6-20020a05622a008600b00430d18c2f22mr8694867qtw.64.1710943811293;
        Wed, 20 Mar 2024 07:10:11 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o23-20020ac872d7000000b00430a67b3437sm6944557qtp.17.2024.03.20.07.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:10:10 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:10:10 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "anna@kernel.org" <anna@kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
Message-ID: <20240320141010.GA3014929@perftesting>
References: <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
 <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com>

On Tue, Mar 19, 2024 at 09:59:48PM +0000, Trond Myklebust wrote:
> On Tue, 2024-03-19 at 16:07 -0400, Josef Bacik wrote:
> > We've been seeing variations of the following panic in production
> > 
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >   RIP: 0010:ip6_pol_route+0x59/0x7a0
> >   Call Trace:
> >    <IRQ>
> >    ? __die+0x78/0xc0
> >    ? page_fault_oops+0x286/0x380
> >    ? fib6_table_lookup+0x95/0xf40
> >    ? exc_page_fault+0x5d/0x110
> >    ? asm_exc_page_fault+0x22/0x30
> >    ? ip6_pol_route+0x59/0x7a0
> >    ? unlink_anon_vmas+0x370/0x370
> >    fib6_rule_lookup+0x56/0x1b0
> >    ? update_blocked_averages+0x2c6/0x6a0
> >    ip6_route_output_flags+0xd2/0x130
> >    ip6_dst_lookup_tail+0x3b/0x220
> >    ip6_dst_lookup_flow+0x2c/0x80
> >    inet6_sk_rebuild_header+0x14c/0x1e0
> >    ? tcp_release_cb+0x150/0x150
> >    __tcp_retransmit_skb+0x68/0x6b0
> >    ? tcp_current_mss+0xca/0x150
> >    ? tcp_release_cb+0x150/0x150
> >    tcp_send_loss_probe+0x8e/0x220
> >    tcp_write_timer+0xbe/0x2d0
> >    run_timer_softirq+0x272/0x840
> >    ? hrtimer_interrupt+0x2c9/0x5f0
> >    ? sched_clock_cpu+0xc/0x170
> >    irq_exit_rcu+0x171/0x330
> >    sysvec_apic_timer_interrupt+0x6d/0x80
> >    </IRQ>
> >    <TASK>
> >    asm_sysvec_apic_timer_interrupt+0x16/0x20
> >   RIP: 0010:cpuidle_enter_state+0xe7/0x243
> > 
> > Inspecting the vmcore with drgn you can see why this is a NULL
> > pointer deref
> > 
> >     >>> prog.crashed_thread().stack_trace()[0]
> >     #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in
> > ip6_pol_route at net/ipv6/route.c:2212:40
> > 
> >     2212        if (net->ipv6.devconf_all->forwarding == 0)
> >     2213              strict |= RT6_LOOKUP_F_REACHABLE;
> > 
> >     >>>
> > prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
> >     (struct ipv6_devconf *)0x0
> > 
> > Looking at the socket you can see that it's been closed
> > 
> >     >>>
> > decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['sk'].
> > __sk_common.skc_flags, prog.type('enum sock_flags'))
> >     'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> >     >>> decode_enum_type_flags(1 <<
> > prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_state.v
> > alue_(), prog["TCPF_CLOSE"].type_, bit_numbers=False)
> >     'TCPF_FIN_WAIT1'
> > 
> > This occurs in our container setup where we have an NFS mount that
> > belongs to the containers network namespace.  On container shutdown
> > our
> > netns goes away, which sets net->ipv6.defconf_all = NULL, and then we
> > panic.  In the kernel we're responsible for destroying our sockets
> > when
> > the network namespace exits, or holding a reference on the network
> > namespace for our sockets so this doesn't happen.
> > 
> > Even once we shutdown the socket we can still have TCP timers that
> > fire
> > in the background, hence this panic.  SUNRPC shuts down the socket
> > and
> > throws away all knowledge of it, but it's still doing things in the
> > background.
> > 
> > Fix this by grabbing a reference on the network namespace for any tcp
> > sockets we open.  With this patch I'm able to cycle my 500 node
> > stress
> > tier over and over again without panicing, whereas previously I was
> > losing 10-20 nodes every shutdown cycle.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > Apologies, I just grepped for SUNRPC in MAINTAINERS and didn't
> > realize there was
> > a division of the client and server side of SUNRPC.
> > 
> >  net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > index bb81050c870e..f02387751a94 100644
> > --- a/net/sunrpc/xprtsock.c
> > +++ b/net/sunrpc/xprtsock.c
> > @@ -2333,6 +2333,7 @@ static int xs_tcp_finish_connecting(struct
> > rpc_xprt *xprt, struct socket *sock)
> >  
> >  	if (!transport->inet) {
> >  		struct sock *sk = sock->sk;
> > +		struct net *net = sock_net(sk);
> >  
> >  		/* Avoid temporary address, they are bad for long-
> > lived
> >  		 * connections such as NFS mounts.
> > @@ -2350,7 +2351,26 @@ static int xs_tcp_finish_connecting(struct
> > rpc_xprt *xprt, struct socket *sock)
> >  		tcp_sock_set_nodelay(sk);
> >  
> >  		lock_sock(sk);
> > +		/*
> > +		 * Because timers can fire after the fact we need to
> > hold a
> > +		 * reference on the netns for this socket.
> > +		 */
> > +		if (!sk->sk_net_refcnt) {
> > +			if (!maybe_get_net(net)) {
> > +			       release_sock(sk);
> > +			       return -ENOTCONN;
> > +		       }
> > +		       /*
> > +			* For kernel sockets we have a tracker put
> > in place for
> > +			* the tracing, we need to free this to
> > maintaine
> > +			* consistent tracking info.
> > +			*/
> > +		       __netns_tracker_free(net, &sk->ns_tracker,
> > false);
> >  
> > +		       sk->sk_net_refcnt = 1;
> > +		       netns_tracker_alloc(net, &sk->ns_tracker,
> > GFP_KERNEL);
> > +		       sock_inuse_add(net, 1);
> > +		}
> >  		xs_save_old_callbacks(transport, sk);
> >  
> >  		sk->sk_user_data = xprt;
> 
> Hmm... Doesn't this end up being more or less equivalent to calling
> __sock_create() with the kernel flag being set to 0?

AFAICT yes, but there are a lot of other things that happen with kern being set
to 1, so I think this is a safer bet, and is analagous to this other fix
3a58f13a881e ("net: rds: acquire refcount on TCP sockets").  Thanks,

Josef

