Return-Path: <linux-nfs+bounces-2416-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8178813F3
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 15:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D181F23B87
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 14:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D15482D8;
	Wed, 20 Mar 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="T5nz0TU3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FE4AEFA
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946599; cv=none; b=MOYV+DwcdW5TqM7o2ntiyd49Ab5DUGVHCZF2hpiU8vnCCUwG5i3KNXedMFm5Y+ObwGMTomMtar1T/PGnrUmTxJx1slf5QVF144XPEVemfNQwrT0Nl1tdhPa5CpWp/SY9a5YuFSZK8esBkcMPcWsgPssu9Px6M93KCskKwwXqFVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946599; c=relaxed/simple;
	bh=ej/J2nBPBzHXntwzQAj7NiKKHpaM1PjLMvVmlF4/WMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyekNxErXEUf8cfBmH3R80RPANTEyNz6aeV6+GBXKhwBu3qgoSkT+YkIFUlAsYOjIM46LDgtgvzvGpb6XOClFtbmC0FIBG3omYv+QZyoFWjIZhab0jlGA3og7nlxPwlSbJrt10XAs0Sr465UFIeMb16x4PRsciJAVSKtLrx9pGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=T5nz0TU3; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-22963f0e12cso1378687fac.1
        for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710946596; x=1711551396; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0oifsYgkSXGrsWwpgNkcA5dlitCI7Zaz7bG6T/afUeQ=;
        b=T5nz0TU3x/Fm6eQYCJPoDt65HZ4g1kIME5hPGtfbBb4tXMQFa09NJtF2yhofATbchO
         qV/BGsfXv4ES5oO/32lv7f1jG0sMkkdHvbWIwDg7XP2yY/eKYvlZQSvIvGfmhOA6sfv+
         mK8hT2qMNnhiLrveEEHAoD6fEw/XUYtUV8dCGxd1fUlaFlhJREtqRorHCYJFW+vXvlse
         90okhVUSA6/3pLQP0PXFBH/SLU4bBtEOHFIo6f5mPmczbZ6RuI0jppMyMOofXwRnU+jC
         TVt4FlDu12ybJaRZzF2k03XoGDmLbVcg+ExSMEcArlYFX4cIsDR5ymO24WDLhi/Kol8e
         z/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946596; x=1711551396;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0oifsYgkSXGrsWwpgNkcA5dlitCI7Zaz7bG6T/afUeQ=;
        b=P8Lqa/zSLTsSnfzI7SRfmjmDH+5HbnyP2ncZIOIavbHBz4caYQwmxfOAAeAWAGKM60
         b4Hc2LllrsEXHOU11u5pakiyDnD3MJ0UlzKsgjBRbOzY3W0nZ8sM2YUKRHcz2cootoWj
         U/zUbDgFuv1ImgmHR9rkAFMOdyd5IMSaBvzRtGF/Anjtg83xQ6Cxwlkw8T/Afq+vAN6C
         opoCe7rbynZMpF1wdrQZve5RPGmAUkI/ZiKJgW8VHMOkEEXE2KzabVh4Jpo5RvZ3u5to
         TYW5V7RQ3dQqdxsRXC2N137WLMEeXizFuLN3/i0MZARxyOlEzEuaBPSWC2uYWRi77BRs
         NogA==
X-Forwarded-Encrypted: i=1; AJvYcCWLxNBLvQj78wF22oKVi/VCaiMCjqsNm8U5zCL5zNiWyuy3wVr8ND6mWHdeOCiBhGlgC4gf5+zmprY8rvxjcPhHGs2eF2+dy7Pi
X-Gm-Message-State: AOJu0YyQtfx7C7vZp06e9Bqy/h8Tmu/1w6iFy6n3GpZkfcFD17jObenD
	Htnd7wgmX3bee0488aQ6ezgY8oiYFvyQfzTSScaZBu3YAdIY7l57lBvYFdhcBaw=
X-Google-Smtp-Source: AGHT+IEFSO8osiSoKaX21IsMfk4NykfNy7hEn9tyRA0KzlC+KsClWWOEYhoUF5nmtPrGgZJeu1wEcA==
X-Received: by 2002:a05:6870:1593:b0:220:be2c:6083 with SMTP id j19-20020a056870159300b00220be2c6083mr6390173oab.49.1710946596244;
        Wed, 20 Mar 2024 07:56:36 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id p8-20020ae9f308000000b0078874069a89sm6609726qkg.9.2024.03.20.07.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 07:56:35 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:56:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"anna@kernel.org" <anna@kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
Message-ID: <20240320145634.GA3091349@perftesting>
References: <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
 <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com>
 <20240320141010.GA3014929@perftesting>
 <CANn89iJaK_Zw6zc9zFEm9++J4Txd3iQCKhu_gzgGGoqnpQe5cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJaK_Zw6zc9zFEm9++J4Txd3iQCKhu_gzgGGoqnpQe5cA@mail.gmail.com>

On Wed, Mar 20, 2024 at 03:28:15PM +0100, Eric Dumazet wrote:
> On Wed, Mar 20, 2024 at 3:10 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Tue, Mar 19, 2024 at 09:59:48PM +0000, Trond Myklebust wrote:
> > > On Tue, 2024-03-19 at 16:07 -0400, Josef Bacik wrote:
> > > > We've been seeing variations of the following panic in production
> > > >
> > > >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > >   RIP: 0010:ip6_pol_route+0x59/0x7a0
> > > >   Call Trace:
> > > >    <IRQ>
> > > >    ? __die+0x78/0xc0
> > > >    ? page_fault_oops+0x286/0x380
> > > >    ? fib6_table_lookup+0x95/0xf40
> > > >    ? exc_page_fault+0x5d/0x110
> > > >    ? asm_exc_page_fault+0x22/0x30
> > > >    ? ip6_pol_route+0x59/0x7a0
> > > >    ? unlink_anon_vmas+0x370/0x370
> > > >    fib6_rule_lookup+0x56/0x1b0
> > > >    ? update_blocked_averages+0x2c6/0x6a0
> > > >    ip6_route_output_flags+0xd2/0x130
> > > >    ip6_dst_lookup_tail+0x3b/0x220
> > > >    ip6_dst_lookup_flow+0x2c/0x80
> > > >    inet6_sk_rebuild_header+0x14c/0x1e0
> > > >    ? tcp_release_cb+0x150/0x150
> > > >    __tcp_retransmit_skb+0x68/0x6b0
> > > >    ? tcp_current_mss+0xca/0x150
> > > >    ? tcp_release_cb+0x150/0x150
> > > >    tcp_send_loss_probe+0x8e/0x220
> > > >    tcp_write_timer+0xbe/0x2d0
> > > >    run_timer_softirq+0x272/0x840
> > > >    ? hrtimer_interrupt+0x2c9/0x5f0
> > > >    ? sched_clock_cpu+0xc/0x170
> > > >    irq_exit_rcu+0x171/0x330
> > > >    sysvec_apic_timer_interrupt+0x6d/0x80
> > > >    </IRQ>
> > > >    <TASK>
> > > >    asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > >   RIP: 0010:cpuidle_enter_state+0xe7/0x243
> > > >
> > > > Inspecting the vmcore with drgn you can see why this is a NULL
> > > > pointer deref
> > > >
> > > >     >>> prog.crashed_thread().stack_trace()[0]
> > > >     #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in
> > > > ip6_pol_route at net/ipv6/route.c:2212:40
> > > >
> > > >     2212        if (net->ipv6.devconf_all->forwarding == 0)
> > > >     2213              strict |= RT6_LOOKUP_F_REACHABLE;
> > > >
> > > >     >>>
> > > > prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
> > > >     (struct ipv6_devconf *)0x0
> > > >
> > > > Looking at the socket you can see that it's been closed
> > > >
> > > >     >>>
> > > > decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['sk'].
> > > > __sk_common.skc_flags, prog.type('enum sock_flags'))
> > > >     'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> > > >     >>> decode_enum_type_flags(1 <<
> > > > prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_state.v
> > > > alue_(), prog["TCPF_CLOSE"].type_, bit_numbers=False)
> > > >     'TCPF_FIN_WAIT1'
> > > >
> > > > This occurs in our container setup where we have an NFS mount that
> > > > belongs to the containers network namespace.  On container shutdown
> > > > our
> > > > netns goes away, which sets net->ipv6.defconf_all = NULL, and then we
> > > > panic.  In the kernel we're responsible for destroying our sockets
> > > > when
> > > > the network namespace exits, or holding a reference on the network
> > > > namespace for our sockets so this doesn't happen.
> > > >
> > > > Even once we shutdown the socket we can still have TCP timers that
> > > > fire
> > > > in the background, hence this panic.  SUNRPC shuts down the socket
> > > > and
> > > > throws away all knowledge of it, but it's still doing things in the
> > > > background.
> > > >
> > > > Fix this by grabbing a reference on the network namespace for any tcp
> > > > sockets we open.  With this patch I'm able to cycle my 500 node
> > > > stress
> > > > tier over and over again without panicing, whereas previously I was
> > > > losing 10-20 nodes every shutdown cycle.
> > > >
> > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > ---
> > > > Apologies, I just grepped for SUNRPC in MAINTAINERS and didn't
> > > > realize there was
> > > > a division of the client and server side of SUNRPC.
> > > >
> > > >  net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
> > > >  1 file changed, 20 insertions(+)
> > > >
> > > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > > index bb81050c870e..f02387751a94 100644
> > > > --- a/net/sunrpc/xprtsock.c
> > > > +++ b/net/sunrpc/xprtsock.c
> > > > @@ -2333,6 +2333,7 @@ static int xs_tcp_finish_connecting(struct
> > > > rpc_xprt *xprt, struct socket *sock)
> > > >
> > > >     if (!transport->inet) {
> > > >             struct sock *sk = sock->sk;
> > > > +           struct net *net = sock_net(sk);
> > > >
> > > >             /* Avoid temporary address, they are bad for long-
> > > > lived
> > > >              * connections such as NFS mounts.
> > > > @@ -2350,7 +2351,26 @@ static int xs_tcp_finish_connecting(struct
> > > > rpc_xprt *xprt, struct socket *sock)
> > > >             tcp_sock_set_nodelay(sk);
> > > >
> > > >             lock_sock(sk);
> > > > +           /*
> > > > +            * Because timers can fire after the fact we need to
> > > > hold a
> > > > +            * reference on the netns for this socket.
> > > > +            */
> > > > +           if (!sk->sk_net_refcnt) {
> > > > +                   if (!maybe_get_net(net)) {
> > > > +                          release_sock(sk);
> > > > +                          return -ENOTCONN;
> > > > +                  }
> > > > +                  /*
> > > > +                   * For kernel sockets we have a tracker put
> > > > in place for
> > > > +                   * the tracing, we need to free this to
> > > > maintaine
> > > > +                   * consistent tracking info.
> > > > +                   */
> > > > +                  __netns_tracker_free(net, &sk->ns_tracker,
> > > > false);
> > > >
> > > > +                  sk->sk_net_refcnt = 1;
> > > > +                  netns_tracker_alloc(net, &sk->ns_tracker,
> > > > GFP_KERNEL);
> > > > +                  sock_inuse_add(net, 1);
> > > > +           }
> > > >             xs_save_old_callbacks(transport, sk);
> > > >
> > > >             sk->sk_user_data = xprt;
> > >
> > > Hmm... Doesn't this end up being more or less equivalent to calling
> > > __sock_create() with the kernel flag being set to 0?
> >
> > AFAICT yes, but there are a lot of other things that happen with kern being set
> > to 1, so I think this is a safer bet, and is analagous to this other fix
> > 3a58f13a881e ("net: rds: acquire refcount on TCP sockets").  Thanks,
> >
> 
> Hmm... this would prevent a netns with one or more TCP flows owned by
> this layer to be dismantled,
> even if all other processes/sockets disappeared ?

Yeah but if sockets are still in use then we want the netns to still be up
right?  I personally am very confused about how the lifetime stuff works for
sockets, I don't understand how shutting down the socket means it gets to stick
around after the fact forever, but feels like if it's tied to a netns then it's
completely valid to hold the netns open until we're done with the socket.

> 
> Have you looked at my suggestion instead ?
> 
> https://lore.kernel.org/bpf/CANn89i+484ffqb93aQm1N-tjxxvb3WDKX0EbD7318RwRgsatjw@mail.gmail.com/
> 
> I never formally submitted this patch because I got no feedback.

I did something similar, tho not with _sync so maybe that was the problem, but
this is what I did originally in production before I emailed you the first time

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40a2aa9fd00e..73ae59a5a488 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2827,6 +2827,8 @@ void tcp_shutdown(struct sock *sk, int how)
        if (!(how & SEND_SHUTDOWN))
                return;

+       tcp_clear_xmit_timers(sk);
+
        /* If we've already sent a FIN, or it's a closed state, skip this. */
        if ((1 << sk->sk_state) &
            (TCPF_ESTABLISHED | TCPF_SYN_SENT |

But I still hit the panic.  I followed this up with a patch where I set a
special flag that I set on the socket _after_ i called kernel_sock_shutdown(),
and then I added a WARN_ON() to the icsk_retransmit_timer re-arm stuff if my
flag was set, and this fired alllll the time.  Stopping the timer doesn't help,
because after we close the socket we'll still get some incoming ACK that'll
re-arm the timer and then we're in the same position we were originally.

I'm happy to be wrong here, because this is clearly not my area of expertise,
but I wandered down this road and it wasn't the right one.  Thanks,

Josef

