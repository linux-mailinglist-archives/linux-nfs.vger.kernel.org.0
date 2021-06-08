Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3257D3A04DC
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhFHUC3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 16:02:29 -0400
Received: from mail-qv1-f47.google.com ([209.85.219.47]:45031 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbhFHUC1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 16:02:27 -0400
Received: by mail-qv1-f47.google.com with SMTP id w4so4080685qvr.11
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1eLaAiQvGuNoMxbAdj78LO7Lm9Pb6c7fvLRSowTJkC0=;
        b=Lsf2d11SjiVFkj6bM2AM7AFqC6TXaLA9DrdTmUw3tX+sA+nlLpw1b1jGIeA7iPS5Qh
         s1fSXuy6gs/Ji8l8EhyZTKE7Wyepunea5GvPfsmxnHMG+y3P2U90mJ59x7Qg+hUx/Sw2
         0VImQD5y9HbxGyOblZachsi9E688FJz2V+k5XvFLodJRQECTy5YPEcCQFybzkO/bZWDZ
         j5/q+YQLw0U3BhUmlLVGGeeqdEQ08bzve9INGA/Gb3bB/TsSxTksbTRroda2tEW12r6S
         8gyTelH1poZFHK1Bb/Y3QTGm4VY2mzbmR5dubcSm6g+lZYfEK0aKaFbaitSI+Per47JK
         +qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1eLaAiQvGuNoMxbAdj78LO7Lm9Pb6c7fvLRSowTJkC0=;
        b=aSmYbu6rHaiOxbzx6dM4qfDqN2+NNm/jyCY2eWzZvXPzq8Er4vLpcyhLJd0bKIfoWg
         dqbJLB17WLLOmwAUgv98uFtbRG/CtxXeFHeR0N7n6pJQ6xPeXSKvzioiSNPKPSZSGuZJ
         P0KoDPCpl1itwT5ncv9M8IMn+g8fUJqarlZoqpzJtdvIZEasXfZhYlGV4326agsPljLw
         ES1heNBYRSI0ueq/ingVFIccok1oW9U8Ar29NIQjp2Fu5uXIHcXSeiypwsGooNPKBMX8
         7Gka6KNHMENWadP66e6HooEAdgc5zc09k57CGEy6sjPaz5RlQ6CmRFCgXHST/a9Tqqef
         JWlg==
X-Gm-Message-State: AOAM533geDkMKcINUsePbuQe8Jr636u6QELcHOX5tNFazVtPCtasSBwE
        4jdleMRCKfnhTr0yl6/VDX7AIQZkrD0=
X-Google-Smtp-Source: ABdhPJw+Dj0I4iH9pHHN98jnXUreo8If+bJPK378HqCs1dP2YZp9nE3qylCl24efgRzhs6aP8q9Tgw==
X-Received: by 2002:ad4:45a6:: with SMTP id y6mr1668163qvu.54.1623182374027;
        Tue, 08 Jun 2021 12:59:34 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id j127sm12952765qke.90.2021.06.08.12.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 12:59:33 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 06/13] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Tue,  8 Jun 2021 15:59:15 -0400
Message-Id: <20210608195922.88655-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
References: <20210608195922.88655-1-olga.kornievskaia@gmail.com>
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

