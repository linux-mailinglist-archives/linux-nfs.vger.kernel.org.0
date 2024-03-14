Return-Path: <linux-nfs+bounces-2293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB487C492
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Mar 2024 22:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0591C21191
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Mar 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A717640B;
	Thu, 14 Mar 2024 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="bAQlX0ZO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70255C61C
	for <linux-nfs@vger.kernel.org>; Thu, 14 Mar 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450464; cv=none; b=mcEds19fbvcAQd8gzwqB6gO1I3A2cUI0FDGBaWOGP1FloyVrdFU+WVbZUEqAb2COH5KDr6jmxoaRrs8wZutNPhqrr5JPmEapKEPwpacLu8SjAL2yiAKIGKuK1l/Dal/jI4jToGaq+bq4MLdDQDWS19UQ8hE1onJqKCM7Ns8L3lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450464; c=relaxed/simple;
	bh=bgkl1cc5LfPaG+PM4pi+rm91E/w2PpmXbtUXkUs8aQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=h8fzMleOtN0PwvAGuGIOkmA+gGi1nyCUj9zDE1sNIo+iz6rJQO3pT6tsRVux8icIkLQO1yiAqGKybEpNBQ3ll57NzXhHRqlHp6i2dMCfXzT/Ptb1b+sM2MgB1l6j5UemunDTGWNJ0et7+YKxPyD2LQZUk+l6CJgOEQsroIqg9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=bAQlX0ZO; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609f1b77728so15074867b3.3
        for <linux-nfs@vger.kernel.org>; Thu, 14 Mar 2024 14:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710450462; x=1711055262; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X1paXqY5W9ShX37NoTp/g8CNXoLuMeO9pswTCbM8GnI=;
        b=bAQlX0ZOrf9OFHYsfQSln2hUZTESFR4wP2mdOW1IL/xolT3J3G0YqGNDQ7aJdYb9+D
         aGTmkEOH7TzUW3x9ieTzT9v3IjUej+en2cciYTQaHINhfSSaw7YmGFasH2IwLgJ/sDz5
         G6xHVvNjR3Mj0nFbqB0lkwVpzOx8ktUeZpLLHHswxgsdPBvDK+RiLeZJpkUwmw3fETHR
         /1jEPbyUQHtC3M+1mBOhfIbwwrsuupSDvHE9S69ldWPx9Xwya5tGlXcy9s4vpgiMHvEp
         QwTv9Yopf3CRQ4CWEdM5TrSIyy9TIe5xWBcI6yuUOxauGbEB+dDdSAcGDgAZFzvleNaI
         2sTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710450462; x=1711055262;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X1paXqY5W9ShX37NoTp/g8CNXoLuMeO9pswTCbM8GnI=;
        b=p40GHFEW6TtarurQ0MgE4YSn7+ZYeYew8iRP5qi0rmDJuI4h4x0gNqjajvQ5uUfAwS
         bT+le1lqmdi3GwHwrNaVwNr9g6tuOt/QUBxYkYjE1eONMEVrzMqG+6eY3aK6v5OFFjKl
         05bAmC3D6G8uF74DvZaEmW0Euv0hiUUwRmo/mPNAyzADrLr2h5tOsqELJqnrb55IBi3W
         Qei1Xe0y8lGXg+hPIMq7ChPori+YCMPsj/woV6G/aQC/Y9VCE8SOHRkXfR1UaEXriOj2
         3HINeNII2REwX+ldUlLWg0Nv3+YffOOtrFOuS2pHGUxRXM5i9hWb7e67fz5HSpvVC8mC
         sziQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeogHqu1rPgwJTl5LUsd2DAikBpj3VJ8sORp5y/0ZLrVVn8aIp3fdLZSMQpcWqh1g1cV00mRolDpElINIGAmiaq10vkXTPcDh7
X-Gm-Message-State: AOJu0YyOxoZfao2VfgvVFJJ3b62CQ3/QE8lyBNC9AufEvYgvtDA5uNfB
	hjiZHJNlfC9ra74O7Nhx7FeaHcRYKVf4JFI56DE53nT5NzZfr3QM/OLINGtFPUg=
X-Google-Smtp-Source: AGHT+IFVy5mw3Q9LQWA9bEcUuB9HNGJx793DOOgctlqohheoS8kErvVt0dzZvZLvw1aJE7BvWKscgQ==
X-Received: by 2002:a81:72c2:0:b0:609:fbc6:340 with SMTP id n185-20020a8172c2000000b00609fbc60340mr3560512ywc.40.1710450461816;
        Thu, 14 Mar 2024 14:07:41 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id v13-20020a81d00d000000b0060971c14a34sm438201ywi.27.2024.03.14.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 14:07:41 -0700 (PDT)
Date: Thu, 14 Mar 2024 17:07:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: edumazet@google.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [BUG] Panic in ipv6 on old NFS sockets from destroyed network
 namespace
Message-ID: <20240314210740.GA2823176@perftesting>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We've been hitting the following panic in production, and I've root caused
what's happening, but I'm at a loss on how to fix it.

The panic we're seeing is this

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    RIP: 0010:ip6_pol_route+0x59/0x7a0
    Call Trace:
     <IRQ>
     ? __die+0x78/0xc0
     ? page_fault_oops+0x286/0x380
     ? fib6_table_lookup+0x95/0xf40
     ? exc_page_fault+0x5d/0x110
     ? asm_exc_page_fault+0x22/0x30
     ? ip6_pol_route+0x59/0x7a0
     ? unlink_anon_vmas+0x370/0x370
     fib6_rule_lookup+0x56/0x1b0
     ? update_blocked_averages+0x2c6/0x6a0
     ip6_route_output_flags+0xd2/0x130
     ip6_dst_lookup_tail+0x3b/0x220
     ip6_dst_lookup_flow+0x2c/0x80
     inet6_sk_rebuild_header+0x14c/0x1e0
     ? tcp_release_cb+0x150/0x150
     __tcp_retransmit_skb+0x68/0x6b0
     ? tcp_current_mss+0xca/0x150
     ? tcp_release_cb+0x150/0x150
     tcp_send_loss_probe+0x8e/0x220
     tcp_write_timer+0xbe/0x2d0
     run_timer_softirq+0x272/0x840
     ? hrtimer_interrupt+0x2c9/0x5f0
     ? sched_clock_cpu+0xc/0x170
     irq_exit_rcu+0x171/0x330
     sysvec_apic_timer_interrupt+0x6d/0x80
     </IRQ>
     <TASK>
     asm_sysvec_apic_timer_interrupt+0x16/0x20
    RIP: 0010:cpuidle_enter_state+0xe7/0x243

Inspecting the vmcore with drgn you can see why this is a NULL pointer deref

      >>> prog.crashed_thread().stack_trace()[0]
      #0 at 0xffffffff810bfa89 (ip6_pol_route+0x59/0x796) in ip6_pol_route at net/ipv6/route.c:2212:40

      2212        if (net->ipv6.devconf_all->forwarding == 0)
      2213              strict |= RT6_LOOKUP_F_REACHABLE;

      >>> prog.crashed_thread().stack_trace()[0]['net'].ipv6.devconf_all
      (struct ipv6_devconf *)0x0

Looking at the socket you can see that it's been closed

      >>> decode_enum_type_flags(prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_flags, prog.type('enum sock_flags'))
      'SOCK_DEAD|SOCK_KEEPOPEN|SOCK_ZAPPED|SOCK_USE_WRITE_QUEUE'
      >>> decode_enum_type_flags(1 << prog.crashed_thread().stack_trace()[11]['sk'].__sk_common.skc_state.value_(), prog["TCPF_CLOSE"].type_, bit_numbers=False)
      'TCPF_FIN_WAIT1'

The way this reproduces is with our NFS setup.  We have an NFS mount inside of a
container, which has it's own network namespace.  We setup the mount inside of
this network namespace.

On container shutdown sometimes we trigger this panic, it's pretty reliably
reproduced, with a stress tier of 200 machines I can usually trigger it on ~10
machines by stopping the jobs.

My initial thought was that NFS wasn't properly shutting down the sockets, but
this doesn't appear to be the case.  The sock is always marked with SOCK_DEAD.
My second thought was that we had some pending timers when we call
kernel_sock_shutdown(), so I added tcp_clear_xmit_timers(sk); to tcp_shutdown()
to make sure the timers were cleared.  This didn't fix the issue.

I added some debugging to the socket and flagged the socket when NFS called
kernel_sock_shutdown() and then had a WARN_ON(sock_flag(sk,
JOSEFS_SPECIAL_FLAG)) where we arm the timer, and that trips constantly.  So
we're definitely arming the sock after NFS has shutdown the socket.

This is where we leave my ability to figure out what's going on and how to fix
it.  What seems to be happening is this

1. NFS calls kernel_sock_shutdown() when we unmount.
2. We get an ACK on the socket and the timer gets armed.
3. We shutdown the container and tear down the network namespace.
4. The timer fires and we try to send the loss probe and we panic because the
   network namespace teardown removes the devconf as part of its teardown.

It appears to me that sock's will just hang around forever past the end of an
application being done with it, tho I'm not sure if I'm correct in this.  If
that's the case then I don't know the correct way to handle this, other than
adding an extra case for the timer to simply not run when SOCK_DEAD is set.  But
this seems to be done on purpose, so seems like that's a bad fix.

Let me know if you have debug patches or other information you'd like from a
vmcore, I have plenty.  Like I said I can reproduce reliably, it does take a few
hours to deploy a test kernel, but I can have a turn around of about a day for
debug patches.  Thanks,

Josef

