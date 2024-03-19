Return-Path: <linux-nfs+bounces-2404-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45898805A9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 20:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11EE51F217E3
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 19:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B343B2A2;
	Tue, 19 Mar 2024 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Utlv5XM2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB633B28F
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 19:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877869; cv=none; b=YnkRWQrXC1y/mXQsNnQGe+A5XkbxdKN4yZFAvGfdpeaSft2B2gdTZYMWC22HxNeiZAw9Y8iDedatIMYbVdrNdKvSXSW33SQqYK7OasdwFZ4u8yLhQ44AB1XnunHPNy6G+SkmiwhiiI3i9hCS0T6QhHkJjsd+dkkM9RRDLkLxb4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877869; c=relaxed/simple;
	bh=ai81RR0oiiIfy/LDzXsQYc2Xlq9Uf/j0sS8YbjIdz40=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=B58FF3WTxHgCXL9q4XjU82orfSKEEEQjTk9x1jBQkt4ptNSEDeBh+5zO1uCJ+11+G3dHUov3FMPfbhTITQdaP7q424x3AbtXJeJLMC3TIuKktkOHT6QzJvtXyTBWlQNl9vhRICF143SYsdqiQy770IgBJ/4Ijlx4vzueq1rcefM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Utlv5XM2; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-609408d4b31so58330777b3.0
        for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 12:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710877866; x=1711482666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNaFERd6aeJLviwH9klNvrlMOMnEbvfvONZuf7wCyUo=;
        b=Utlv5XM2Z4Petff6+PuNQdP1mWyhTaBVdatOhZ4B8+A51P5Roi/z45bdpAGqgUscs0
         c1ztanZA8otSyrur0NUeHosKmj24Ax/S1VF1fydA5XgBguzKlcu/TwwRtzB1tKkSgsiI
         K0lfxCQYQDUKMKytY1g+fsbg/ywbh12FVKGGpbqIDSqN1JvkZzKXCrEIfHduFeJOzaYi
         8f+YxGNsBnTOsqfoPZPj99tAqYux8OUQut4vJ8pIrG0SVpA4Z/sDBBUPKj1VmTAiP6x4
         +SKlILWfPA2djWX66YPFfQH2t4GfqmHTGJNDslzJA/uwVdxT3oqy8STnza1KgKFUJdHZ
         t3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877866; x=1711482666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UNaFERd6aeJLviwH9klNvrlMOMnEbvfvONZuf7wCyUo=;
        b=MIDW9oC3qonPl6MrKiG3mk9Gz0jhZ4HJI6rkPpJ4wuWin8EJRozw79En7F/wgmbtLB
         7OHzfenRTO1hTrfGD9Tjb7DzivhNqXn3qN+agt9mJbmzHjCjkqzW0kucpTirsnF5jHo3
         YFI+Tk8BeZdY57VeQVdDbZ8X3N3OWLtYb650ktDWL3rLzafjaA5LdlJ42+a0yvrp60mE
         iIol1STJcfnoNHwYGNQ7oxsJAVRv5Buq3FjyboI0Zx5U6KQgyG9Orn6QlINRfpNKT77Q
         oNGWc77rVy+3IhpOpmCcBtrPTqCZVDL3iDLeEf73CkuDr3shG99+VjdHhmBE99wmwczF
         TxQg==
X-Forwarded-Encrypted: i=1; AJvYcCWG6PZKMLhaNkT2O2g9RezJvXjIP8bshLaEPE7zkeLpI2uW8hFi3hYihp/OvNQOGaTGg5Lwzpjx8F24woXew4c2PyBm651d8yvT
X-Gm-Message-State: AOJu0Yx0BLJg4xWleUqi60hFJDK6de5Yo+9Sk1VWC2Z/HGqkMY8oXbKQ
	OlZgHCm0RYbTUCoT6akavpX9RZgUJTmGwTsBWflfurRM1Ur+zq9EMBqyx+Z8Srk=
X-Google-Smtp-Source: AGHT+IFVgbgiSbJjnczTKa0BWM8qaEW7u3lHDWeXP3Nt1sCStLUFP9rrZ9pDYD6/q9C6htLStlL5JA==
X-Received: by 2002:a0d:f801:0:b0:60c:c986:5ea with SMTP id i1-20020a0df801000000b0060cc98605eamr11408ywf.42.1710877866467;
        Tue, 19 Mar 2024 12:51:06 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id jc13-20020a05622a714d00b00430911bac01sm4044432qtb.74.2024.03.19.12.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 12:51:06 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-nfs@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	kernel-team@fb.com
Subject: [PATCH] sunrpc: hold a ref on netns for tcp sockets
Date: Tue, 19 Mar 2024 15:49:49 -0400
Message-ID: <512efbd56ad3679068759586c6fa9b681aec14f0.1710877783.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've been seeing variations of the following panic in production

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

This occurs in our container setup where we have an NFS mount that
belongs to the containers network namespace.  On container shutdown our
netns goes away, which sets net->ipv6.defconf_all = NULL, and then we
panic.  In the kernel we're responsible for destroying our sockets when
the network namespace exits, or holding a reference on the network
namespace for our sockets so this doesn't happen.

Even once we shutdown the socket we can still have TCP timers that fire
in the background, hence this panic.  SUNRPC shuts down the socket and
throws away all knowledge of it, but it's still doing things in the
background.

Fix this by grabbing a reference on the network namespace for any tcp
sockets we open.  With this patch I'm able to cycle my 500 node stress
tier over and over again without panicing, whereas previously I was
losing 10-20 nodes every shutdown cycle.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/sunrpc/xprtsock.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bb81050c870e..f02387751a94 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2333,6 +2333,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 	if (!transport->inet) {
 		struct sock *sk = sock->sk;
+		struct net *net = sock_net(sk);
 
 		/* Avoid temporary address, they are bad for long-lived
 		 * connections such as NFS mounts.
@@ -2350,7 +2351,26 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		tcp_sock_set_nodelay(sk);
 
 		lock_sock(sk);
+		/*
+		 * Because timers can fire after the fact we need to hold a
+		 * reference on the netns for this socket.
+		 */
+		if (!sk->sk_net_refcnt) {
+			if (!maybe_get_net(net)) {
+			       release_sock(sk);
+			       return -ENOTCONN;
+		       }
+		       /*
+			* For kernel sockets we have a tracker put in place for
+			* the tracing, we need to free this to maintaine
+			* consistent tracking info.
+			*/
+		       __netns_tracker_free(net, &sk->ns_tracker, false);
 
+		       sk->sk_net_refcnt = 1;
+		       netns_tracker_alloc(net, &sk->ns_tracker, GFP_KERNEL);
+		       sock_inuse_add(net, 1);
+		}
 		xs_save_old_callbacks(transport, sk);
 
 		sk->sk_user_data = xprt;
-- 
2.43.0


