Return-Path: <linux-nfs+bounces-2406-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3108805DB
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCB201F23111
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Mar 2024 20:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D39854665;
	Tue, 19 Mar 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="l2wi7Mfo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E973A1AA
	for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878914; cv=none; b=P46ffK2fnOqi0z/jqlrF98jqH+KHG67Y4RnO1P7sSB9JREAU75zetT6YsTpp+bAP/IT+nBDKejAGShsADaU2onRW0jGYwK+DRNUfJ79mAxlfWrqN85tCxb/X7k/pZghPV0Ok+cMqQZP/mrDQOsFHeFj8xGRyD/bleMsAfMywu/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878914; c=relaxed/simple;
	bh=HwsS6pc6sI9Zj43Q3PeNbIhOK3SD/Jf/S0Intge2b7U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HXB1BL/N2RwkTbYpFuVCiUSP6TiI7I9UdKAnXYqSFAx6TYRZ5XxjhHqoPJnbPdKmN5wA7EVErMwYl1iE6cRngZPiee9vRwppRe+NLszxm2E2RVKYNQ9aWpEZuOl7zv6Q6b8fP4H4sCxfEIkGF0pasM614hhOUIAv5gfr+Q2V7Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=l2wi7Mfo; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso5619699276.0
        for <linux-nfs@vger.kernel.org>; Tue, 19 Mar 2024 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710878911; x=1711483711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ILNKK59pTsFr0d1EBTRcXGUpvf1KaLJBkAzvTwBPAqw=;
        b=l2wi7MfoCw5FknWZ/pndwb4WOKQeDgFgxkYpqQQ5k/xDsdoOFQmeIksSXBrQB3fiVf
         toeToqCH/y2LWE24DS+tDgflvRDkYCtWDv9Si4jRx4m25yAfT0YVfxd90bi+VPnvrmJy
         HNtccd45nzJ1AKKxG8U2477nUSlJDlWcVU2wE+fVnOJ9qoGKJMpSGDJbt6+5DCcM/2J0
         tEBwj5rrl8wgwQji0k6O7VYB7DO/6gc1QsOnLDCyx27V/pFtR6Vzdk4w/gbyDjzIVpTT
         B6kT8yP1LJwIghfl4XyyihH/W4VsY8hAPo9F8ukKwZOz87FJFEBXpf5uSeKRrgdFJt0s
         nYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878911; x=1711483711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILNKK59pTsFr0d1EBTRcXGUpvf1KaLJBkAzvTwBPAqw=;
        b=Acp0X39f7uJfBoS7J93KLDw0zuv+kDUp2rTfOVnSfb/9oKfqgDrAq3aGngMrAZ8syI
         plVuOrCkr21x3YMAxuH/x3hmqmeK5dsFfhPTGXgoJN0Zw16rPzafLuRthzzX9LMWQ2Ou
         Pup6ojCYGpVdH5pVdSZD+KviRvFNwSQZ4+LvP3tWNBQn5pm0OCTsDD+ZEF5+UA9onNHV
         CF7lGHWnGlNQdKVfOU88SXnEtV+nda/536Q8QhBJMzQDnDl2RrwHaAyKkw7aCKwH76tF
         GMBYEAYAwhrgAVOyBbWbJJS4jYTOABVbOiFvySAlnhfiIeQSSpNzlOm0QZRvdZKe2OAD
         3kdg==
X-Forwarded-Encrypted: i=1; AJvYcCXPRha06LyhS53qhU/0oyjx3s36SqaKaXSFbLsWgvHxVGDGDm++b+F5CJXCsA42DrgV7CKwlB+1LrYvl4RS/Pbdz9t4M8tRyTQ/
X-Gm-Message-State: AOJu0YyXlVn+6wSQPQnSho6VWe43/8RpSbcHYfKnDEc52jXGde+jkqyX
	gn/byfIbwUDP/OD+t56SIw2gpwbiaW40QXcLhSl9dRKUFDn53nuj4X1cWAFUEWg=
X-Google-Smtp-Source: AGHT+IGBH5EORds4SRDpOJ3jWurn/fyymZl14erWM7v7G8RO7NuPTOb9idB4AW28coHF5psWnpuptw==
X-Received: by 2002:a25:2f8f:0:b0:dcc:ec02:38b0 with SMTP id v137-20020a252f8f000000b00dccec0238b0mr11035545ybv.64.1710878911114;
        Tue, 19 Mar 2024 13:08:31 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ch14-20020a05622a40ce00b00430dcca3fb5sm1805521qtb.16.2024.03.19.13.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:08:30 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	kernel-team@fb.com
Subject: [PATCH][RESEND] sunrpc: hold a ref on netns for tcp sockets
Date: Tue, 19 Mar 2024 16:07:48 -0400
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
Apologies, I just grepped for SUNRPC in MAINTAINERS and didn't realize there was
a division of the client and server side of SUNRPC.

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


