Return-Path: <linux-nfs+bounces-2294-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B589287C4DB
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Mar 2024 22:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E511C21745
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Mar 2024 21:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1D768E1;
	Thu, 14 Mar 2024 21:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/ISSiD8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4776415
	for <linux-nfs@vger.kernel.org>; Thu, 14 Mar 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452861; cv=none; b=MQyv0z0BL1IXO2sAjGlioQKyCX+pqiv4IP4jZ/PoRg29hdbc6YGWFYQdoi1FG1HDTVEQxtIjjKkTcHAdVA2p/+acX7ZprPoK9Gj7d85DNvoFgjAPEJuAbHaV7q8MXgRQ2t0lMqxUoJbs7t+2FlUWLXD1oi1cRPYfUXDu3OGUlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452861; c=relaxed/simple;
	bh=rArz5PbsMjiqZkHOTckxHGuhSAZSJrOy+i6L9VPx9W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJTn3wsCjpxJSbuYIx/sn+wX9P5tclKaBuvJ+A0k0926B51EdiVbQ8zhTdbML3nYoPc6DWYvO3YxR9RDzgbQJM8fz8ye6AfYXyMBJpAUu3rHqGfEsL2wQUMWD/1UbvU/t3/ALYWP70y6A9W1pWhEyBRHgPJ7+eK9ar9mj5ORGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/ISSiD8; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-566b160f6eeso2001a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 14 Mar 2024 14:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710452858; x=1711057658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yj5f/ytrcbQ9bq8jRGc8O12ypIGwxmWYCX3kg31Cwh4=;
        b=j/ISSiD8DYOyQAi42i9CHYc319DgJwAOGqobThRi+NfrFyGq+YuOTo2f+ngU4oeT05
         o6UioGMnZxrfpjPaKMXLk9O4c1EQKVuh+muxwx0CKB+xaiuEQCW0UQ+yqS33NdQUF99G
         R4ZLY3RqAd0PzIzeQm/0yfc9dPQEVC56j6z3Hh27OGwIlUcOCKNx1AMa8boOhVGo9kHk
         iIpG8GFCFSWNbShDdp4dfCPNB8fG4LCnEen8xzZtFs9LrL1bxA8oWyRUX+nIMn5ISi08
         O8Lj6xXHpVgrHG/8bjKIs253r6knKoRXtkajUYELmobV0P1bs/Pz2kGey4niZu0oUiPO
         TFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710452858; x=1711057658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yj5f/ytrcbQ9bq8jRGc8O12ypIGwxmWYCX3kg31Cwh4=;
        b=XKNzsWTTNfjy5VYcvTXaBZttbl/DGqTsTl4qgR2fRJryD/bIHnvub1S/LZuZFbKdQe
         g4S2eNZCMFcXaNkIt47UjgUMebOPamHQDBXAZIIuBJUkQKR8Sz/xZQ8Nol0qB4cU95pR
         4+L33R6Mx2W91BfuRwT4q8lpOdAv8mfVWFIvGe6t2YP2PVE9lZUBHq76TfzzXRJrUN3B
         Cswe7FakGeAak9UIeUJf/tlzj8m0xizin1b7P4Cy/NtwUdmqAgqFHIb+1DdLjsUOwLjb
         HU2hsebo7HR9KcvyNglTHA5xDzMi22aXrh2DsbY6c6pg2aUyFoezcjQLoMY43U7wgH4F
         +euA==
X-Forwarded-Encrypted: i=1; AJvYcCW5i4lJQV2DcAxkzWBS6KvPmhndOCHIBXYw1Hfw9cOuz67Bk2wR5FSU/WnVKT9nrfFgEpEctKAAxxK5xj5TKoL3sGLCiMuVI8TR
X-Gm-Message-State: AOJu0YxKxypjhoV45SYGVQaau7sYd6TTLFUGV/WlaO07yGyp1QEKzwXx
	qKZ65s8g6aXYwjOoOkZqKhw7V7RUfKd+sgHD0jydofZwakqio03wIhe+2eZxV9mIZmNxx2PX94U
	OuB6Fh58RvM57i6xC42kx7eennzzYGlVHO/Kw
X-Google-Smtp-Source: AGHT+IEVsQzYZM0gMMFcJFJcO/fLFugCS83znhcv0H9buTdOu9WX9O2QVgdpdmkJlnSz+3qkH8JKZJiSJ86DMXmSXW4=
X-Received: by 2002:a05:6402:2024:b0:568:5e6c:a3c4 with SMTP id
 ay4-20020a056402202400b005685e6ca3c4mr44213edb.0.1710452858029; Thu, 14 Mar
 2024 14:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314210740.GA2823176@perftesting>
In-Reply-To: <20240314210740.GA2823176@perftesting>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 14 Mar 2024 22:47:25 +0100
Message-ID: <CANn89i+Bid4YkwFEmxSvF22Gk0jY+hH7P=mjEKR=LBPc+vG_PA@mail.gmail.com>
Subject: Re: [BUG] Panic in ipv6 on old NFS sockets from destroyed network namespace
To: Josef Bacik <josef@toxicpanda.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 10:07=E2=80=AFPM Josef Bacik <josef@toxicpanda.com>=
 wrote:
>
> Hello,
>
> We've been hitting the following panic in production, and I've root cause=
d
> what's happening, but I'm at a loss on how to fix it.
>
> The panic we're seeing is this
>
>     BUG: kernel NULL pointer dereference, address: 0000000000000000
>     RIP: 0010:ip6_pol_route+0x59/0x7a0
>     Call Trace:
>      <IRQ>
>      ? __die+0x78/0xc0
>      ? page_fault_oops+0x286/0x380
>      ? fib6_table_lookup+0x95/0xf40
>      ? exc_page_fault+0x5d/0x110
>      ? asm_exc_page_fault+0x22/0x30
>      ? ip6_pol_route+0x59/0x7a0
>      ? unlink_anon_vmas+0x370/0x370
>      fib6_rule_lookup+0x56/0x1b0
>      ? update_blocked_averages+0x2c6/0x6a0
>      ip6_route_output_flags+0xd2/0x130
>      ip6_dst_lookup_tail+0x3b/0x220
>      ip6_dst_lookup_flow+0x2c/0x80
>      inet6_sk_rebuild_header+0x14c/0x1e0
>      ? tcp_release_cb+0x150/0x150
>      __tcp_retransmit_skb+0x68/0x6b0
>      ? tcp_current_mss+0xca/0x150
>      ? tcp_release_cb+0x150/0x150
>      tcp_send_loss_probe+0x8e/0x220
>      tcp_write_timer+0xbe/0x2d0
>      run_timer_softirq+0x272/0x840
>      ? hrtimer_interrupt+0x2c9/0x5f0
>      ? sched_clock_cpu+0xc/0x170
>      irq_exit_rcu+0x171/0x330
>      sysvec_apic_timer_interrupt+0x6d/0x80
>      </IRQ>
>      <TASK>
>      asm_sysvec_apic_timer_interrupt+0x16/0x20
>     RIP: 0010:cpuidle_enter_state+0xe7/0x243
>
> Inspecting the vmcore with drgn you can see why this is a NULL pointer de=
ref
>
>       >>> prog.crashed_thread().stack_trace()[0]
>       #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in ip6_pol_rout=
e at net/ipv6/route.c:2212:40
>
>       2212        if (net->ipv6.devconf_all->forwarding =3D=3D 0)
>       2213              strict |=3D RT6_LOOKUP_F_REACHABLE;
>
>       >>> prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
>       (struct ipv6_devconf *)0x0
>
> Looking at the socket you can see that it's been closed
>
>       >>> decode_enum_type_flags(prog.crashed_thread().stack_trace()[11][=
'sk'].__sk_common.skc_flags, prog.type('enum sock_flags'))
>       'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
>       >>> decode_enum_type_flags(1 << prog.crashed_thread().stack_trace()=
[11]['sk'].__sk_common.skc_state.value_(), prog["TCPF_CLOSE"].type_, bit_nu=
mbers=3DFalse)
>       'TCPF_FIN_WAIT1'
>
> The way this reproduces is with our NFS setup.  We have an NFS mount insi=
de of a
> container, which has it's own network namespace.  We setup the mount insi=
de of
> this network namespace.
>
> On container shutdown sometimes we trigger this panic, it's pretty reliab=
ly
> reproduced, with a stress tier of 200 machines I can usually trigger it o=
n ~10
> machines by stopping the jobs.
>
> My initial thought was that NFS wasn't properly shutting down the sockets=
, but
> this doesn't appear to be the case.  The sock is always marked with SOCK_=
DEAD.
> My second thought was that we had some pending timers when we call
> kernel_sock_shutdown(), so I added tcp_clear_xmit_timers(sk); to tcp_shut=
down()
> to make sure the timers were cleared.  This didn't fix the issue.
>
> I added some debugging to the socket and flagged the socket when NFS call=
ed
> kernel_sock_shutdown() and then had a WARN_ON(sock_flag(sk,
> JOSEFS_SPECIAL_FLAG)) where we arm the timer, and that trips constantly. =
 So
> we're definitely arming the sock after NFS has shutdown the socket.
>
> This is where we leave my ability to figure out what's going on and how t=
o fix
> it.  What seems to be happening is this
>
> 1. NFS calls kernel_sock_shutdown() when we unmount.
> 2. We get an ACK on the socket and the timer gets armed.
> 3. We shutdown the container and tear down the network namespace.
> 4. The timer fires and we try to send the loss probe and we panic because=
 the
>    network namespace teardown removes the devconf as part of its teardown=
.
>
> It appears to me that sock's will just hang around forever past the end o=
f an
> application being done with it, tho I'm not sure if I'm correct in this. =
 If
> that's the case then I don't know the correct way to handle this, other t=
han
> adding an extra case for the timer to simply not run when SOCK_DEAD is se=
t.  But
> this seems to be done on purpose, so seems like that's a bad fix.
>
> Let me know if you have debug patches or other information you'd like fro=
m a
> vmcore, I have plenty.  Like I said I can reproduce reliably, it does tak=
e a few
> hours to deploy a test kernel, but I can have a turn around of about a da=
y for
> debug patches.  Thanks,
>
> Josef

  If NFS is using kernel sockets, it is NFS responsibility to remove
all of them when the netns is destroyed.

Also look at recent relevant  patches

2a750d6a5b365265dbda33330a6188547ddb5c24 rds: tcp: Fix use-after-free
of net in reqsk_timer_handler().
1c4e97dd2d3c9a3e84f7e26346aa39bc426d3249 tcp: Fix NEW_SYN_RECV
handling in inet_twsk_purge()

