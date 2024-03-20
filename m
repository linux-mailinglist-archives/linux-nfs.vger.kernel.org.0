Return-Path: <linux-nfs+bounces-2418-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A04A58814AF
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 16:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55717282920
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D2454BCC;
	Wed, 20 Mar 2024 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Z+Eg5lxE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB59B54BCA
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948937; cv=none; b=DcbexgIYyT7QvxP3J+GCn1g3R/qVJZge6wZ/As3vABE3hureWGo0cWE3u+8l/SH2uGA6Be+9p1YASozD9GzAFUIYyGETqMKZ+ZEP4prjitHbbqZot43is5EGurz4HYoyNZKD6+yniPvGQXsGPiKE7pYrBtOMcC2rbA197XjDSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948937; c=relaxed/simple;
	bh=4e246MDSkDxdkyl/UNRkk0zmUPgdQF89GbSQpTPbKUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGgD41KicdsR0AONgAqTTzfZlcoSwRlPory9X8EcWEg4ns8PT7BIpD6f03K6Go6sNMWnE2AJL8bw1z+XcRlin4dEQA6VGAbLnj2KedhrWMa8MIE3RW7SnlD3k+n/07YoB7uyICUHfb9a/pO1r95+sMikNZGvuqawJKA6wUOREcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Z+Eg5lxE; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-22222357d76so7926fac.2
        for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710948935; x=1711553735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=33Gv0jOfCm5TuR2BffPVOxHwLE2fYBQoXk+czoeIrBE=;
        b=Z+Eg5lxEsHhxV2+JEdwVJEYmHyFUI/pTVqIMxAXb3N2VGW/uOOhGvS4o7IElJj4KPW
         18DEDzjMTL6xFvMCoilIAaY5P5Kcpo1WgWbm1vpSs1scxIr6tN1qx5kjBUZEsQsewvCW
         fFUI+2zEZJ71W5LuTp29dsera66m5nANrGZu5ZE2eyYHUKJ2MahVobLWSRA2qsloQaGO
         6D7tOn5Ma8p407OXQw7cLJaATNjvDxuQTXvDCkmqSQO4D39YIB/6Btm9qZB5sMsdWf28
         cer57ihAe3TCJH1rabFSFlqt8KTa/cQESWspLVsX+JGovyPyYbl9CwXB4DdjYOabTj4I
         WmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710948935; x=1711553735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=33Gv0jOfCm5TuR2BffPVOxHwLE2fYBQoXk+czoeIrBE=;
        b=dPzAZW/3i+l3WOZNrgmdlSm04UPkea9S+i4YEPerZXTe/O4K3lcdPLi8prxg6Tz/bV
         mcubiSNCbXga1hz9wsEHP9vtECE3HVxYsdY3Ybsekh4guweEzcQKx+SBP7Ymqb5XZr7B
         kAyyKf6+N0NwpEzkHW0Gn1X0+j944/VOE13jkZ439nwx4BEP5mLEMh89e0OXgCMT/wD1
         uOC5lhZXVRf8qk3YDzcySbvx9tDmSuvN3dEnpsmNLs/ewWSFHOEU7NkurA9EKPHbBLaI
         Yo/7hU1F/DjRJXkkRrc3s5c7FklkU770Hjw4GTumqXwTkXEBevgDK/DT5nAx5kWSLf/L
         iTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi90RGws0UkptSMzWAz3EQqMe+1a/ScHpuHkOoO96wmiT179Fk/RKaY4JioMt75fx87BjkPcHKcQznhzLXCsVol23Ds3ZQmLlY
X-Gm-Message-State: AOJu0YxxJZbJE01VCdUir83ARch/KlXn4RznjjdFDDYcWR0bgJ/7ymCA
	XXUq/K/ZrpJdh23IJw9Z1n/YXGpSc63oL4V5ESK9Fefivn/zP5yAnGrbI7NkZh4PKvam7cbEuWQ
	D
X-Google-Smtp-Source: AGHT+IHJxjUnFPC9sVmyQumlW20IBnZFJiGOS8U+JecYWni4+2wJHHQFVeqO1neAAVIf1ou2T3MEyA==
X-Received: by 2002:a05:6870:889b:b0:229:7bc3:274a with SMTP id m27-20020a056870889b00b002297bc3274amr5912661oam.11.1710948934800;
        Wed, 20 Mar 2024 08:35:34 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id gi7-20020a056214248700b0069612003bacsm4388455qvb.53.2024.03.20.08.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:35:34 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:35:33 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
	"anna@kernel.org" <anna@kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
Message-ID: <20240320153533.GA3092095@perftesting>
References: <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
 <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com>
 <20240320141010.GA3014929@perftesting>
 <CANn89iJaK_Zw6zc9zFEm9++J4Txd3iQCKhu_gzgGGoqnpQe5cA@mail.gmail.com>
 <20240320145634.GA3091349@perftesting>
 <CANn89iJwh=qcOsSvkbCsnrccbGNkdOTORyrwM+13mSbgNqH5Nw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJwh=qcOsSvkbCsnrccbGNkdOTORyrwM+13mSbgNqH5Nw@mail.gmail.com>

On Wed, Mar 20, 2024 at 04:00:09PM +0100, Eric Dumazet wrote:
> On Wed, Mar 20, 2024 at 3:56 PM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Wed, Mar 20, 2024 at 03:28:15PM +0100, Eric Dumazet wrote:
> > > On Wed, Mar 20, 2024 at 3:10 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > > >
> > > > On Tue, Mar 19, 2024 at 09:59:48PM +0000, Trond Myklebust wrote:
> > > > > On Tue, 2024-03-19 at 16:07 -0400, Josef Bacik wrote:
> > > > > > We've been seeing variations of the following panic in production
> > > > > >
> > > > > >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > > >   RIP: 0010:ip6_pol_route+0x59/0x7a0
> > > > > >   Call Trace:
> > > > > >    <IRQ>
> > > > > >    ? __die+0x78/0xc0
> > > > > >    ? page_fault_oops+0x286/0x380
> > > > > >    ? fib6_table_lookup+0x95/0xf40
> > > > > >    ? exc_page_fault+0x5d/0x110
> > > > > >    ? asm_exc_page_fault+0x22/0x30
> > > > > >    ? ip6_pol_route+0x59/0x7a0
> > > > > >    ? unlink_anon_vmas+0x370/0x370
> > > > > >    fib6_rule_lookup+0x56/0x1b0
> > > > > >    ? update_blocked_averages+0x2c6/0x6a0
> > > > > >    ip6_route_output_flags+0xd2/0x130
> > > > > >    ip6_dst_lookup_tail+0x3b/0x220
> > > > > >    ip6_dst_lookup_flow+0x2c/0x80
> > > > > >    inet6_sk_rebuild_header+0x14c/0x1e0
> > > > > >    ? tcp_release_cb+0x150/0x150
> > > > > >    __tcp_retransmit_skb+0x68/0x6b0
> > > > > >    ? tcp_current_mss+0xca/0x150
> > > > > >    ? tcp_release_cb+0x150/0x150
> > > > > >    tcp_send_loss_probe+0x8e/0x220
> > > > > >    tcp_write_timer+0xbe/0x2d0
> > > > > >    run_timer_softirq+0x272/0x840
> > > > > >    ? hrtimer_interrupt+0x2c9/0x5f0
> > > > > >    ? sched_clock_cpu+0xc/0x170
> > > > > >    irq_exit_rcu+0x171/0x330
> > > > > >    sysvec_apic_timer_interrupt+0x6d/0x80
> > > > > >    </IRQ>
> > > > > >    <TASK>
> > > > > >    asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > > >   RIP: 0010:cpuidle_enter_state+0xe7/0x243
> > > > > >
> > > > > > Inspecting the vmcore with drgn you can see why this is a NULL
> > > > > > pointer deref
> > > > > >
> > > > > >     >>> prog.crashed_thread().stack_trace()[0]
> > > > > >     #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in
> > > > > > ip6_pol_route at net/ipv6/route.c:2212:40
> > > > > >
> > > > > >     2212        if (net->ipv6.devconf_all->forwarding == 0)
> > > > > >     2213              strict |= RT6_LOOKUP_F_REACHABLE;
> > > > > >
> > > > > >     >>>
> > > > > > prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
> > > > > >     (struct ipv6_devconf *)0x0
> > > > > >
> > > > > > Looking at the socket you can see that it's been closed
> > > > > >
> > > > > >     >>>
> > > > > > decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['sk'].
> > > > > > __sk_common.skc_flags, prog.type('enum sock_flags'))
> > > > > >     'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> > > > > >     >>> decode_enum_type_flags(1 <<
> > > > > > prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_state.v
> > > > > > alue_(), prog["TCPF_CLOSE"].type_, bit_numbers=False)
> > > > > >     'TCPF_FIN_WAIT1'
> > > > > >
> > > > > > This occurs in our container setup where we have an NFS mount that
> > > > > > belongs to the containers network namespace.  On container shutdown
> > > > > > our
> > > > > > netns goes away, which sets net->ipv6.defconf_all = NULL, and then we
> > > > > > panic.  In the kernel we're responsible for destroying our sockets
> > > > > > when
> > > > > > the network namespace exits, or holding a reference on the network
> > > > > > namespace for our sockets so this doesn't happen.
> > > > > >
> > > > > > Even once we shutdown the socket we can still have TCP timers that
> > > > > > fire
> > > > > > in the background, hence this panic.  SUNRPC shuts down the socket
> > > > > > and
> > > > > > throws away all knowledge of it, but it's still doing things in the
> > > > > > background.
> > > > > >
> > > > > > Fix this by grabbing a reference on the network namespace for any tcp
> > > > > > sockets we open.  With this patch I'm able to cycle my 500 node
> > > > > > stress
> > > > > > tier over and over again without panicing, whereas previously I was
> > > > > > losing 10-20 nodes every shutdown cycle.
> > > > > >
> > > > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > > > ---
> > > > > > Apologies, I just grepped for SUNRPC in MAINTAINERS and didn't
> > > > > > realize there was
> > > > > > a division of the client and server side of SUNRPC.
> > > > > >
> > > > > >  net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
> > > > > >  1 file changed, 20 insertions(+)
> > > > > >
> > > > > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > > > > index bb81050c870e..f02387751a94 100644
> > > > > > --- a/net/sunrpc/xprtsock.c
> > > > > > +++ b/net/sunrpc/xprtsock.c
> > > > > > @@ -2333,6 +2333,7 @@ static int xs_tcp_finish_connecting(struct
> > > > > > rpc_xprt *xprt, struct socket *sock)
> > > > > >
> > > > > >     if (!transport->inet) {
> > > > > >             struct sock *sk = sock->sk;
> > > > > > +           struct net *net = sock_net(sk);
> > > > > >
> > > > > >             /* Avoid temporary address, they are bad for long-
> > > > > > lived
> > > > > >              * connections such as NFS mounts.
> > > > > > @@ -2350,7 +2351,26 @@ static int xs_tcp_finish_connecting(struct
> > > > > > rpc_xprt *xprt, struct socket *sock)
> > > > > >             tcp_sock_set_nodelay(sk);
> > > > > >
> > > > > >             lock_sock(sk);
> > > > > > +           /*
> > > > > > +            * Because timers can fire after the fact we need to
> > > > > > hold a
> > > > > > +            * reference on the netns for this socket.
> > > > > > +            */
> > > > > > +           if (!sk->sk_net_refcnt) {
> > > > > > +                   if (!maybe_get_net(net)) {
> > > > > > +                          release_sock(sk);
> > > > > > +                          return -ENOTCONN;
> > > > > > +                  }
> > > > > > +                  /*
> > > > > > +                   * For kernel sockets we have a tracker put
> > > > > > in place for
> > > > > > +                   * the tracing, we need to free this to
> > > > > > maintaine
> > > > > > +                   * consistent tracking info.
> > > > > > +                   */
> > > > > > +                  __netns_tracker_free(net, &sk->ns_tracker,
> > > > > > false);
> > > > > >
> > > > > > +                  sk->sk_net_refcnt = 1;
> > > > > > +                  netns_tracker_alloc(net, &sk->ns_tracker,
> > > > > > GFP_KERNEL);
> > > > > > +                  sock_inuse_add(net, 1);
> > > > > > +           }
> > > > > >             xs_save_old_callbacks(transport, sk);
> > > > > >
> > > > > >             sk->sk_user_data = xprt;
> > > > >
> > > > > Hmm... Doesn't this end up being more or less equivalent to calling
> > > > > __sock_create() with the kernel flag being set to 0?
> > > >
> > > > AFAICT yes, but there are a lot of other things that happen with kern being set
> > > > to 1, so I think this is a safer bet, and is analagous to this other fix
> > > > 3a58f13a881e ("net: rds: acquire refcount on TCP sockets").  Thanks,
> > > >
> > >
> > > Hmm... this would prevent a netns with one or more TCP flows owned by
> > > this layer to be dismantled,
> > > even if all other processes/sockets disappeared ?
> >
> > Yeah but if sockets are still in use then we want the netns to still be up
> > right?  I personally am very confused about how the lifetime stuff works for
> > sockets, I don't understand how shutting down the socket means it gets to stick
> > around after the fact forever, but feels like if it's tied to a netns then it's
> > completely valid to hold the netns open until we're done with the socket.
> >
> > >
> > > Have you looked at my suggestion instead ?
> > >
> > > https://lore.kernel.org/bpf/CANn89i+484ffqb93aQm1N-tjxxvb3WDKX0EbD7318RwRgsatjw@mail.gmail.com/
> > >
> > > I never formally submitted this patch because I got no feedback.
> >
> > I did something similar, tho not with _sync so maybe that was the problem, but
> > this is what I did originally in production before I emailed you the first time
> 
> 
> The _sync part is mandatory really for this context.
> 
> Not that it needs to be done while the socket is not locked, or risk a deadlock.
> 
> Note that modern trees have timer_shutdown_sync() which might even be better.
> 

Sounds good, I've reverted my patches and I've applied this patch, I should have
results by the end of the day on wether or not it fixed the problem.  Thanks,

Josef

