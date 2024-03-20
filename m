Return-Path: <linux-nfs+bounces-2417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 070638813FE
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 16:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FC83284C60
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 15:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345444AEE0;
	Wed, 20 Mar 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0f22vuY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F0E4EB4A
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946825; cv=none; b=cTQvi8R13KQlAqY5+SFP9+knmu1oWVk2+V1QA0kk/fHuHg5bNMO7UpUoffI6DJH1unsektCVgE0LBbm0+kBERoeCfmDRMi60qacjeOOEx6tq+vIhbwy2XxowdBD9YDBL3xHpSpkKNwMoATzrgGw86qbe52RjZM9NGhqZkf1F/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946825; c=relaxed/simple;
	bh=Be0RraHo85CRN3OzQW3g2VdRivESwxlfwxLDJftXQ70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mk9nUP8zatjuOvYPiSv3Or2ACfv3Z0ke3Yp+6r/HMlq1MDKm8VZKEEKj3tjJyGiPJqfWNXCqxEnqdUOH4kb25T+lnLmaHQ57rGi7x5qSeA21W+YeHesJ4O0o/uLWnLluUDwxfgGbfPR+oL7UMAa+sy28Dws/H52UUscRVHonpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0f22vuY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56b98e59018so15387a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710946821; x=1711551621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAaaN87RAZ+d7z/eXV0RCuoqBhlch2XdKg96wa2pkCE=;
        b=b0f22vuYjUDRz+N93qYMnaHFnBpQ/rxVg48WYCFdmr/uj2D9rCRgOEFlvk042I0COQ
         Zd3D8mI3bVS7dQlofaiJgxsJ3/2r87Am3rVWUgGO034IPgR/fr53v6O+lm9gNjPemgDJ
         SbZfA+8vQXlOMEcuxsYzdtEvYXZ5RAJpaySgB5bs7kgohk7QppPPOEHNwiMdEiJYek4W
         pfvIhk/XT3tD0ZhXYKezguHv9VOR3P6BEkKgpg6MG5tC4BLYqIK8XM3RGvRlZNTjaDvV
         sym1hKBqM5tAdJoP4jkZYRW77GRoMU2x5psnFbXMNFGvBOvpAvoiXVT9PL1+6d5/ui8J
         8xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710946821; x=1711551621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aAaaN87RAZ+d7z/eXV0RCuoqBhlch2XdKg96wa2pkCE=;
        b=SnwNeMWxpPUUqx/ZDWiaV8oS/TZ+I3uoza9Kkkb4c0g3qlbyYCbiradvWbhptByaLE
         zTmeb38Y5C3W8/MrtozblKF4EjrDqJJ8DUET3htZBFu1WEeLGjCwzTljAs1he5hVqln8
         QbQYrherBh7+rfYy8EpFG5iQPLMhSjygapSesXg8FC5vB94LrvjazUf/5a2LdI3TlgfS
         vzver1at9y4a95PDtEkgvMxL2IO4DJDDWAcEa2tILQaVKsdgz45A6GA48CdjOr2AP+pE
         V/iKF92GZSiI80Qq1ZSkpCMyJdd/fcr43OajJ9wArPjQWPUxh4lnQY67QrriVMgvD1aT
         5aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSPBd570U20Btbuh3o/rYQ7cN/l0mse2xPcKAHY8f1nV3n/3KPM3SaeWMSglpRtaikAIcN3OBzP2OLFtuBWkxiihImZep5ZIQe
X-Gm-Message-State: AOJu0YyUaxAoQwLQlIOotrfAFSsbLVgy29lM+ST9wqYwcIMkK0aZD8Fu
	9mOv47zdtHAAt6meorG4ylxXWDOqaxC+3FElZMexwkKA5WnrK2+Q5n0N0ZS9Jo1vV2LR3v6oIfh
	0/4GhvbsdcNzkNPaPmIQ36ikmuGtcJ3MGS4Le
X-Google-Smtp-Source: AGHT+IHyEATSNlYQZyH5h/4Bptk8s5AdioqHXQPLSiHN/54P/03BxIcbiJ69eLj8VU/K7nLr2KlIt1bv6nxaTpqoibc=
X-Received: by 2002:aa7:d746:0:b0:56b:a060:1e4 with SMTP id
 a6-20020aa7d746000000b0056ba06001e4mr202013eds.2.1710946820681; Wed, 20 Mar
 2024 08:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
 <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com>
 <20240320141010.GA3014929@perftesting> <CANn89iJaK_Zw6zc9zFEm9++J4Txd3iQCKhu_gzgGGoqnpQe5cA@mail.gmail.com>
 <20240320145634.GA3091349@perftesting>
In-Reply-To: <20240320145634.GA3091349@perftesting>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Mar 2024 16:00:09 +0100
Message-ID: <CANn89iJwh=qcOsSvkbCsnrccbGNkdOTORyrwM+13mSbgNqH5Nw@mail.gmail.com>
Subject: Re: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
To: Josef Bacik <josef@toxicpanda.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org" <anna@kernel.org>, 
	"kernel-team@fb.com" <kernel-team@fb.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:56=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Wed, Mar 20, 2024 at 03:28:15PM +0100, Eric Dumazet wrote:
> > On Wed, Mar 20, 2024 at 3:10=E2=80=AFPM Josef Bacik <josef@toxicpanda.c=
om> wrote:
> > >
> > > On Tue, Mar 19, 2024 at 09:59:48PM +0000, Trond Myklebust wrote:
> > > > On Tue, 2024-03-19 at 16:07 -0400, Josef Bacik wrote:
> > > > > We've been seeing variations of the following panic in production
> > > > >
> > > > >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > > > >   RIP: 0010:ip6_pol_route+0x59/0x7a0
> > > > >   Call Trace:
> > > > >    <IRQ>
> > > > >    ? __die+0x78/0xc0
> > > > >    ? page_fault_oops+0x286/0x380
> > > > >    ? fib6_table_lookup+0x95/0xf40
> > > > >    ? exc_page_fault+0x5d/0x110
> > > > >    ? asm_exc_page_fault+0x22/0x30
> > > > >    ? ip6_pol_route+0x59/0x7a0
> > > > >    ? unlink_anon_vmas+0x370/0x370
> > > > >    fib6_rule_lookup+0x56/0x1b0
> > > > >    ? update_blocked_averages+0x2c6/0x6a0
> > > > >    ip6_route_output_flags+0xd2/0x130
> > > > >    ip6_dst_lookup_tail+0x3b/0x220
> > > > >    ip6_dst_lookup_flow+0x2c/0x80
> > > > >    inet6_sk_rebuild_header+0x14c/0x1e0
> > > > >    ? tcp_release_cb+0x150/0x150
> > > > >    __tcp_retransmit_skb+0x68/0x6b0
> > > > >    ? tcp_current_mss+0xca/0x150
> > > > >    ? tcp_release_cb+0x150/0x150
> > > > >    tcp_send_loss_probe+0x8e/0x220
> > > > >    tcp_write_timer+0xbe/0x2d0
> > > > >    run_timer_softirq+0x272/0x840
> > > > >    ? hrtimer_interrupt+0x2c9/0x5f0
> > > > >    ? sched_clock_cpu+0xc/0x170
> > > > >    irq_exit_rcu+0x171/0x330
> > > > >    sysvec_apic_timer_interrupt+0x6d/0x80
> > > > >    </IRQ>
> > > > >    <TASK>
> > > > >    asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > > >   RIP: 0010:cpuidle_enter_state+0xe7/0x243
> > > > >
> > > > > Inspecting the vmcore with drgn you can see why this is a NULL
> > > > > pointer deref
> > > > >
> > > > >     >>> prog.crashed_thread().stack_trace()[0]
> > > > >     #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in
> > > > > ip6_pol_route at net/ipv6/route.c:2212:40
> > > > >
> > > > >     2212        if (net->ipv6.devconf_all->forwarding =3D=3D 0)
> > > > >     2213              strict |=3D RT6_LOOKUP_F_REACHABLE;
> > > > >
> > > > >     >>>
> > > > > prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
> > > > >     (struct ipv6_devconf *)0x0
> > > > >
> > > > > Looking at the socket you can see that it's been closed
> > > > >
> > > > >     >>>
> > > > > decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['s=
k'].
> > > > > __sk_common.skc_flags, prog.type('enum sock_flags'))
> > > > >     'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> > > > >     >>> decode_enum_type_flags(1 <<
> > > > > prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_sta=
te.v
> > > > > alue_(), prog["TCPF_CLOSE"].type_, bit_numbers=3DFalse)
> > > > >     'TCPF_FIN_WAIT1'
> > > > >
> > > > > This occurs in our container setup where we have an NFS mount tha=
t
> > > > > belongs to the containers network namespace.  On container shutdo=
wn
> > > > > our
> > > > > netns goes away, which sets net->ipv6.defconf_all =3D NULL, and t=
hen we
> > > > > panic.  In the kernel we're responsible for destroying our socket=
s
> > > > > when
> > > > > the network namespace exits, or holding a reference on the networ=
k
> > > > > namespace for our sockets so this doesn't happen.
> > > > >
> > > > > Even once we shutdown the socket we can still have TCP timers tha=
t
> > > > > fire
> > > > > in the background, hence this panic.  SUNRPC shuts down the socke=
t
> > > > > and
> > > > > throws away all knowledge of it, but it's still doing things in t=
he
> > > > > background.
> > > > >
> > > > > Fix this by grabbing a reference on the network namespace for any=
 tcp
> > > > > sockets we open.  With this patch I'm able to cycle my 500 node
> > > > > stress
> > > > > tier over and over again without panicing, whereas previously I w=
as
> > > > > losing 10-20 nodes every shutdown cycle.
> > > > >
> > > > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > > > ---
> > > > > Apologies, I just grepped for SUNRPC in MAINTAINERS and didn't
> > > > > realize there was
> > > > > a division of the client and server side of SUNRPC.
> > > > >
> > > > >  net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
> > > > >  1 file changed, 20 insertions(+)
> > > > >
> > > > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > > > index bb81050c870e..f02387751a94 100644
> > > > > --- a/net/sunrpc/xprtsock.c
> > > > > +++ b/net/sunrpc/xprtsock.c
> > > > > @@ -2333,6 +2333,7 @@ static int xs_tcp_finish_connecting(struct
> > > > > rpc_xprt *xprt, struct socket *sock)
> > > > >
> > > > >     if (!transport->inet) {
> > > > >             struct sock *sk =3D sock->sk;
> > > > > +           struct net *net =3D sock_net(sk);
> > > > >
> > > > >             /* Avoid temporary address, they are bad for long-
> > > > > lived
> > > > >              * connections such as NFS mounts.
> > > > > @@ -2350,7 +2351,26 @@ static int xs_tcp_finish_connecting(struct
> > > > > rpc_xprt *xprt, struct socket *sock)
> > > > >             tcp_sock_set_nodelay(sk);
> > > > >
> > > > >             lock_sock(sk);
> > > > > +           /*
> > > > > +            * Because timers can fire after the fact we need to
> > > > > hold a
> > > > > +            * reference on the netns for this socket.
> > > > > +            */
> > > > > +           if (!sk->sk_net_refcnt) {
> > > > > +                   if (!maybe_get_net(net)) {
> > > > > +                          release_sock(sk);
> > > > > +                          return -ENOTCONN;
> > > > > +                  }
> > > > > +                  /*
> > > > > +                   * For kernel sockets we have a tracker put
> > > > > in place for
> > > > > +                   * the tracing, we need to free this to
> > > > > maintaine
> > > > > +                   * consistent tracking info.
> > > > > +                   */
> > > > > +                  __netns_tracker_free(net, &sk->ns_tracker,
> > > > > false);
> > > > >
> > > > > +                  sk->sk_net_refcnt =3D 1;
> > > > > +                  netns_tracker_alloc(net, &sk->ns_tracker,
> > > > > GFP_KERNEL);
> > > > > +                  sock_inuse_add(net, 1);
> > > > > +           }
> > > > >             xs_save_old_callbacks(transport, sk);
> > > > >
> > > > >             sk->sk_user_data =3D xprt;
> > > >
> > > > Hmm... Doesn't this end up being more or less equivalent to calling
> > > > __sock_create() with the kernel flag being set to 0?
> > >
> > > AFAICT yes, but there are a lot of other things that happen with kern=
 being set
> > > to 1, so I think this is a safer bet, and is analagous to this other =
fix
> > > 3a58f13a881e ("net: rds: acquire refcount on TCP sockets").  Thanks,
> > >
> >
> > Hmm... this would prevent a netns with one or more TCP flows owned by
> > this layer to be dismantled,
> > even if all other processes/sockets disappeared ?
>
> Yeah but if sockets are still in use then we want the netns to still be u=
p
> right?  I personally am very confused about how the lifetime stuff works =
for
> sockets, I don't understand how shutting down the socket means it gets to=
 stick
> around after the fact forever, but feels like if it's tied to a netns the=
n it's
> completely valid to hold the netns open until we're done with the socket.
>
> >
> > Have you looked at my suggestion instead ?
> >
> > https://lore.kernel.org/bpf/CANn89i+484ffqb93aQm1N-tjxxvb3WDKX0EbD7318R=
wRgsatjw@mail.gmail.com/
> >
> > I never formally submitted this patch because I got no feedback.
>
> I did something similar, tho not with _sync so maybe that was the problem=
, but
> this is what I did originally in production before I emailed you the firs=
t time


The _sync part is mandatory really for this context.

Not that it needs to be done while the socket is not locked, or risk a dead=
lock.

Note that modern trees have timer_shutdown_sync() which might even be bette=
r.


>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 40a2aa9fd00e..73ae59a5a488 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2827,6 +2827,8 @@ void tcp_shutdown(struct sock *sk, int how)
>         if (!(how & SEND_SHUTDOWN))
>                 return;
>
> +       tcp_clear_xmit_timers(sk);
> +
>         /* If we've already sent a FIN, or it's a closed state, skip this=
. */
>         if ((1 << sk->sk_state) &
>             (TCPF_ESTABLISHED | TCPF_SYN_SENT |
>
> But I still hit the panic.  I followed this up with a patch where I set a
> special flag that I set on the socket _after_ i called kernel_sock_shutdo=
wn(),
> and then I added a WARN_ON() to the icsk_retransmit_timer re-arm stuff if=
 my
> flag was set, and this fired alllll the time.  Stopping the timer doesn't=
 help,
> because after we close the socket we'll still get some incoming ACK that'=
ll
> re-arm the timer and then we're in the same position we were originally.

timer_shutdown() to the rescue perhaps.


>
> I'm happy to be wrong here, because this is clearly not my area of expert=
ise,
> but I wandered down this road and it wasn't the right one.  Thanks,
>
> Josef

