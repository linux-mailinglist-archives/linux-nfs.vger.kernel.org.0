Return-Path: <linux-nfs+bounces-2415-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF29881350
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 15:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94FD2284E53
	for <lists+linux-nfs@lfdr.de>; Wed, 20 Mar 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC1F47F4A;
	Wed, 20 Mar 2024 14:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2RUr5nx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD045974
	for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710944910; cv=none; b=rvMGub3kKNrTQbdQ0A7HA5b3bdNMzbJmX2kRWyhRDVfsmmf1uVngeHSIOa9SHCLX2mGhpwS7n0rHMPDKZbyWKhCWeqNOg5gcPzJVSmfOXbvQNCSmuIvKSh79xlM9A0b+M4Rv1CNvvMdryRVFjbIptzbNsMPiILPo8TMlv8JQSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710944910; c=relaxed/simple;
	bh=/pZA4XptCTxSr7zrMbwxC+DXKCwczhNX7k5r0Z4hJXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mR7fUQqttSrjIWw69omczChbj98rnT8zI3VbpT1XnCHIMUhPqBFibDWCqFoITMAI1acJ27Y04FdxfokD5+LQtFIxweMJH4PAJYWNk9sqfe6QZ2HfzLEH9M3a2XXpf7YUMf+9g/Eli+2QZsO72nwKRDVetJqDljMD3sQt3559BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2RUr5nx; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56b98e59018so14724a12.0
        for <linux-nfs@vger.kernel.org>; Wed, 20 Mar 2024 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710944907; x=1711549707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e99pzoAqzFvLUs2GgFemTkIgIcTrbjARQieXsMpd0ks=;
        b=u2RUr5nxSc158/KYYZhZcEs0vSiQjHelNjzQu8+lOkbKnnMp+yzbYjstRHv2RnhyjB
         yp+jCtzHnF19sT1O5bDxb9iKivbh+CwGxvDhBd6l+jgUtdE+beltYCXzYEhu1TOaJvIA
         oLw8yWhFohFlrCxlZVIpbuaOiesUkbRFmuoWBso7rDdWL8pHRz1cg7dVgBcWGwh/2EaS
         GJ/stcbSKNLJu+Xj4YkdsltCelAppG2CwKMvlrGuxDdb++yOfHeXejCIePr7cacoBfGJ
         HhBJnQugnXlgikR1uNOxSu8Gb59pKlYLHO07PiuAOWRU+n9Yuo4pETkg6WszUh1ANPZP
         HD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710944907; x=1711549707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e99pzoAqzFvLUs2GgFemTkIgIcTrbjARQieXsMpd0ks=;
        b=HycQ/DAHVWsIJqHii8nOpdiDqJa6On5sfeK46IFVk/nmFx8nzb9TTZqjEU6rJTgJii
         VIiR8eKn3heEUrHbkEZbz+UsXZTcOIS5RlHrnipUYlFPAvnUL7slFkNEoxjROTzNRr/h
         SB/9CTzIwaIKBb37aOl2+JGuMAoqe/0/Nkyj0ULWh5+CYLNcvToS7iRLDUvROyl1FoBf
         1vl6iGV9I6CLRstJuQGR9REydARvTGefhKrVEkTLU/IouQWxTsD09+B4ZIs1+JWHjoVa
         NqJm6dhN7cFXDxTRhsS8SuDMXLLx2hoMVJ9maGWvwdfYe7huUCMX/HQ1D7DSF+efFu8C
         STUg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ96mX/4HNbqW3otCwRb2H0t/wG8w6Ab+vGs59cKULnsVpGODzUPanWQbbG7grcBfCtYifoPFztiqJMgzHcLjVfic4bGJS6xpj
X-Gm-Message-State: AOJu0YyXPB8jEPMLNgJzvmC/rNolJlT9QEUF1flNRiF5fQyxZC/B8l2E
	7DXrBR5GrCCcFsBjo25zJZvvkTzQSGsgdZr+UrFsk2+m5oC9swbiLBLvMF+GpHnmkne0h0/iEb6
	qSZf+47nCdkkyCnOtwtXbPSZy5yFruFg3iOTU
X-Google-Smtp-Source: AGHT+IFXPjV4aP4vLq1qwAK2dbuulc2r7JUhu2CGhUlTU5P+4mH/H9jQgTmOLSTLsA/JEyMMC9RGYyh5uTMxdDRtcv8=
X-Received: by 2002:aa7:c359:0:b0:568:ce1e:94e5 with SMTP id
 j25-20020aa7c359000000b00568ce1e94e5mr147770edr.5.1710944906819; Wed, 20 Mar
 2024 07:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
 <caa3af93b31b554f0c1e643320041835f0bfe044.camel@hammerspace.com> <20240320141010.GA3014929@perftesting>
In-Reply-To: <20240320141010.GA3014929@perftesting>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 20 Mar 2024 15:28:15 +0100
Message-ID: <CANn89iJaK_Zw6zc9zFEm9++J4Txd3iQCKhu_gzgGGoqnpQe5cA@mail.gmail.com>
Subject: Re: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
To: Josef Bacik <josef@toxicpanda.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>, "anna@kernel.org" <anna@kernel.org>, 
	"kernel-team@fb.com" <kernel-team@fb.com>, 
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:10=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> On Tue, Mar 19, 2024 at 09:59:48PM +0000, Trond Myklebust wrote:
> > On Tue, 2024-03-19 at 16:07 -0400, Josef Bacik wrote:
> > > We've been seeing variations of the following panic in production
> > >
> > >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> > >   RIP: 0010:ip6_pol_route+0x59/0x7a0
> > >   Call Trace:
> > >    <IRQ>
> > >    ? __die+0x78/0xc0
> > >    ? page_fault_oops+0x286/0x380
> > >    ? fib6_table_lookup+0x95/0xf40
> > >    ? exc_page_fault+0x5d/0x110
> > >    ? asm_exc_page_fault+0x22/0x30
> > >    ? ip6_pol_route+0x59/0x7a0
> > >    ? unlink_anon_vmas+0x370/0x370
> > >    fib6_rule_lookup+0x56/0x1b0
> > >    ? update_blocked_averages+0x2c6/0x6a0
> > >    ip6_route_output_flags+0xd2/0x130
> > >    ip6_dst_lookup_tail+0x3b/0x220
> > >    ip6_dst_lookup_flow+0x2c/0x80
> > >    inet6_sk_rebuild_header+0x14c/0x1e0
> > >    ? tcp_release_cb+0x150/0x150
> > >    __tcp_retransmit_skb+0x68/0x6b0
> > >    ? tcp_current_mss+0xca/0x150
> > >    ? tcp_release_cb+0x150/0x150
> > >    tcp_send_loss_probe+0x8e/0x220
> > >    tcp_write_timer+0xbe/0x2d0
> > >    run_timer_softirq+0x272/0x840
> > >    ? hrtimer_interrupt+0x2c9/0x5f0
> > >    ? sched_clock_cpu+0xc/0x170
> > >    irq_exit_rcu+0x171/0x330
> > >    sysvec_apic_timer_interrupt+0x6d/0x80
> > >    </IRQ>
> > >    <TASK>
> > >    asm_sysvec_apic_timer_interrupt+0x16/0x20
> > >   RIP: 0010:cpuidle_enter_state+0xe7/0x243
> > >
> > > Inspecting the vmcore with drgn you can see why this is a NULL
> > > pointer deref
> > >
> > >     >>> prog.crashed_thread().stack_trace()[0]
> > >     #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in
> > > ip6_pol_route at net/ipv6/route.c:2212:40
> > >
> > >     2212        if (net->ipv6.devconf_all->forwarding =3D=3D 0)
> > >     2213              strict |=3D RT6_LOOKUP_F_REACHABLE;
> > >
> > >     >>>
> > > prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
> > >     (struct ipv6_devconf *)0x0
> > >
> > > Looking at the socket you can see that it's been closed
> > >
> > >     >>>
> > > decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['sk'].
> > > __sk_common.skc_flags, prog.type('enum sock_flags'))
> > >     'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
> > >     >>> decode_enum_type_flags(1 <<
> > > prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_state.v
> > > alue_(), prog["TCPF_CLOSE"].type_, bit_numbers=3DFalse)
> > >     'TCPF_FIN_WAIT1'
> > >
> > > This occurs in our container setup where we have an NFS mount that
> > > belongs to the containers network namespace.  On container shutdown
> > > our
> > > netns goes away, which sets net->ipv6.defconf_all =3D NULL, and then =
we
> > > panic.  In the kernel we're responsible for destroying our sockets
> > > when
> > > the network namespace exits, or holding a reference on the network
> > > namespace for our sockets so this doesn't happen.
> > >
> > > Even once we shutdown the socket we can still have TCP timers that
> > > fire
> > > in the background, hence this panic.  SUNRPC shuts down the socket
> > > and
> > > throws away all knowledge of it, but it's still doing things in the
> > > background.
> > >
> > > Fix this by grabbing a reference on the network namespace for any tcp
> > > sockets we open.  With this patch I'm able to cycle my 500 node
> > > stress
> > > tier over and over again without panicing, whereas previously I was
> > > losing 10-20 nodes every shutdown cycle.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > > ---
> > > Apologies, I just grepped for SUNRPC in MAINTAINERS and didn't
> > > realize there was
> > > a division of the client and server side of SUNRPC.
> > >
> > >  net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
> > > index bb81050c870e..f02387751a94 100644
> > > --- a/net/sunrpc/xprtsock.c
> > > +++ b/net/sunrpc/xprtsock.c
> > > @@ -2333,6 +2333,7 @@ static int xs_tcp_finish_connecting(struct
> > > rpc_xprt *xprt, struct socket *sock)
> > >
> > >     if (!transport->inet) {
> > >             struct sock *sk =3D sock->sk;
> > > +           struct net *net =3D sock_net(sk);
> > >
> > >             /* Avoid temporary address, they are bad for long-
> > > lived
> > >              * connections such as NFS mounts.
> > > @@ -2350,7 +2351,26 @@ static int xs_tcp_finish_connecting(struct
> > > rpc_xprt *xprt, struct socket *sock)
> > >             tcp_sock_set_nodelay(sk);
> > >
> > >             lock_sock(sk);
> > > +           /*
> > > +            * Because timers can fire after the fact we need to
> > > hold a
> > > +            * reference on the netns for this socket.
> > > +            */
> > > +           if (!sk->sk_net_refcnt) {
> > > +                   if (!maybe_get_net(net)) {
> > > +                          release_sock(sk);
> > > +                          return -ENOTCONN;
> > > +                  }
> > > +                  /*
> > > +                   * For kernel sockets we have a tracker put
> > > in place for
> > > +                   * the tracing, we need to free this to
> > > maintaine
> > > +                   * consistent tracking info.
> > > +                   */
> > > +                  __netns_tracker_free(net, &sk->ns_tracker,
> > > false);
> > >
> > > +                  sk->sk_net_refcnt =3D 1;
> > > +                  netns_tracker_alloc(net, &sk->ns_tracker,
> > > GFP_KERNEL);
> > > +                  sock_inuse_add(net, 1);
> > > +           }
> > >             xs_save_old_callbacks(transport, sk);
> > >
> > >             sk->sk_user_data =3D xprt;
> >
> > Hmm... Doesn't this end up being more or less equivalent to calling
> > __sock_create() with the kernel flag being set to 0?
>
> AFAICT yes, but there are a lot of other things that happen with kern bei=
ng set
> to 1, so I think this is a safer bet, and is analagous to this other fix
> 3a58f13a881e ("net: rds: acquire refcount on TCP sockets").  Thanks,
>

Hmm... this would prevent a netns with one or more TCP flows owned by
this layer to be dismantled,
even if all other processes/sockets disappeared ?

Have you looked at my suggestion instead ?

https://lore.kernel.org/bpf/CANn89i+484ffqb93aQm1N-tjxxvb3WDKX0EbD7318RwRgs=
atjw@mail.gmail.com/

I never formally submitted this patch because I got no feedback.

