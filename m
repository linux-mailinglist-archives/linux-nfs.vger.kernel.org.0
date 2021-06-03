Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1F139ADDE
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jun 2021 00:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhFCWWf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Jun 2021 18:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhFCWWe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Jun 2021 18:22:34 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2986C06175F
        for <linux-nfs@vger.kernel.org>; Thu,  3 Jun 2021 15:20:49 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 76so7510336qkn.13
        for <linux-nfs@vger.kernel.org>; Thu, 03 Jun 2021 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eLaAiQvGuNoMxbAdj78LO7Lm9Pb6c7fvLRSowTJkC0=;
        b=m4ahZHo9Z4DKINnwtrYDFF4EaTBHjvzcj10g2osgY2tw/ECq9aGtKnfbOdMfL2crx3
         7GdBVvL+tI+mn4tDjwaqNgnRk3rzJ5GvmDr6ciwStYaF3ZEyo8/jNJXmjY0aklv7wV8k
         0p2OU7fqysx6u7wRSwIp4a/kiAw2L9Ire0AOj/iQw8K49oRn/2scvrciXxxSwUWWMiPb
         zZu4IuRlyZqdUm0bKLlqsyDzjtAVyUIr1IAoI7jG/V4iwmzdMX2DeottfkykqvKxMcKl
         XU74uGrrAhYMiBBAJGiU8/afhSpP30qZyyXef8P/1jFzw7toDrX3dZrznpa43uAMAsdP
         jFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eLaAiQvGuNoMxbAdj78LO7Lm9Pb6c7fvLRSowTJkC0=;
        b=tV+ufXtpPWFGYBHfDDmpMGQ5a+7v/a80YFtDSX/ZNfxGffWtdkeU6IekH/5eFeyhUm
         9bnG+IqNcqHEcjFzrLJCF0gndI/b44WW1ntETPkC4Pg7+rqK+/+VD6C8dIU81MXMVJao
         yZUyDz7kut1W+M0mtgBPp5Zrchqt1KSzDX99FFU/yRS18MuCv2JMdctU1J5vrpWd7KeK
         XYCg/Ltv9il98+b3OrUktOa6NSDRiw9K50BftOQgG7GemVKfHcQ1T6YVEaeYgK/Tg8QG
         mka7toEpEeBer3s15Log4ti3V39RDL+OeJIBHTn03ARLl1nmVeH8tkQBfZiEZR7UzTFM
         eBXQ==
X-Gm-Message-State: AOAM5310Qtdn+TpsFbwLKmbetm+V6ZmCCAIvOyE+CEShm+57m+PhzyqF
        a8UkyyJBN+NWN/ur43Dh8KbpXGQQTJc=
X-Google-Smtp-Source: ABdhPJwkZYOhKhfcwR1cqOwvlM7UrVCiGJWaFbTdE65Q66yE2ofQSn/pHTGl9801Ax9X5hCobYLDdg==
X-Received: by 2002:a37:468b:: with SMTP id t133mr1453410qka.189.1622758848976;
        Thu, 03 Jun 2021 15:20:48 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-23.netapp.com. [216.240.30.23])
        by smtp.gmail.com with ESMTPSA id 187sm2870230qkn.43.2021.06.03.15.20.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jun 2021 15:20:48 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 06/13] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Thu,  3 Jun 2021 18:20:32 -0400
Message-Id: <20210603222039.19182-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
References: <20210603222039.19182-1-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Olga Kornievskaia <kolga@netapp.com>

We need to keep track of the type for a given transport.

Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
---
 include/linux/sunrpc/xprt.h     | 2 ++
 net/sunrpc/xprtrdma/transport.c | 2 ++
 net/sunrpc/xprtsock.c           | 9 +++++++++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 1fbc470ce205..7efc6c0a5455 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -53,6 +53,7 @@ enum rpc_display_format_t {
 
 struct rpc_task;
 struct rpc_xprt;
+struct xprt_class;
 struct seq_file;
 struct svc_serv;
 struct net;
@@ -289,6 +290,7 @@ struct rpc_xprt {
 	atomic_t		inject_disconnect;
 #endif
 	struct rcu_head		rcu;
+	const struct xprt_class	*xprt_class;
 };
 
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 19a49d26b1e4..9c2ffc67c0fd 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -73,6 +73,7 @@ unsigned int xprt_rdma_max_inline_read = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
 int xprt_rdma_pad_optimize;
+static struct xprt_class xprt_rdma;
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 
@@ -349,6 +350,7 @@ xprt_setup_rdma(struct xprt_create *args)
 	/* Ensure xprt->addr holds valid server TCP (not RDMA)
 	 * address, for any side protocols which peek at it */
 	xprt->prot = IPPROTO_TCP;
+	xprt->xprt_class = &xprt_rdma;
 	xprt->addrlen = args->addrlen;
 	memcpy(&xprt->addr, sap, xprt->addrlen);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 316d04945587..2ad4d0df45fe 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -91,6 +91,11 @@ static unsigned int xprt_max_resvport_limit = RPC_MAX_RESVPORT;
 
 static struct ctl_table_header *sunrpc_table_header;
 
+static struct xprt_class xs_local_transport;
+static struct xprt_class xs_udp_transport;
+static struct xprt_class xs_tcp_transport;
+static struct xprt_class xs_bc_tcp_transport;
+
 /*
  * FIXME: changing the UDP slot table size should also resize the UDP
  *        socket buffers for existing UDP transports
@@ -2779,6 +2784,7 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = 0;
+	xprt->xprt_class = &xs_local_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
 	xprt->bind_timeout = XS_BIND_TO;
@@ -2848,6 +2854,7 @@ static struct rpc_xprt *xs_setup_udp(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_UDP;
+	xprt->xprt_class = &xs_udp_transport;
 	/* XXX: header size can vary due to auth type, IPv6, etc. */
 	xprt->max_payload = (1U << 16) - (MAX_HEADER << 3);
 
@@ -2928,6 +2935,7 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_TCP;
+	xprt->xprt_class = &xs_tcp_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
 	xprt->bind_timeout = XS_BIND_TO;
@@ -3001,6 +3009,7 @@ static struct rpc_xprt *xs_setup_bc_tcp(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_TCP;
+	xprt->xprt_class = &xs_bc_tcp_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 	xprt->timeout = &xs_tcp_default_timeout;
 
-- 
2.27.0

