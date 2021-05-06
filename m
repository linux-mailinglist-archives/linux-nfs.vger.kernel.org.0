Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1F7375CE2
	for <lists+linux-nfs@lfdr.de>; Thu,  6 May 2021 23:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbhEFVfo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 May 2021 17:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhEFVfo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 May 2021 17:35:44 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65088C061574
        for <linux-nfs@vger.kernel.org>; Thu,  6 May 2021 14:34:45 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id t3so6156617iol.5
        for <linux-nfs@vger.kernel.org>; Thu, 06 May 2021 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48ER+3CuPa73K29MvllAxYxB++l3k+kP8jwOXOjdExw=;
        b=UbyLJ1fH9Lop7/ej4QoSfGtugQf0Zqxi2XI+3i06h2DeYNzqJLbW2dP9L4BSUQPNsr
         yznZRIrL1F4mOqoBqlQ+H1HDh2YaA6oMeu1rue2pmFRdjhs7eUHtLifEt8x3jn09waoa
         ux6J7PYDon21lrKJCrbg3WEAHpJohXp+ImdhOX7NocJS+uKacpxciq/c9XKiYEHT83bs
         W9KI+mXYa+Udue+n+sYn+OYtqSyJ4QJFfrw/LT/6VAx4yguEyXdNcYH+mqHrhWbu1n37
         uTg5xVD2n2SeyZVRXQWnUIvKqLkLmxng5f6x3CE9gZGRU8cCrZx/EQzULA2Lj61eN6gO
         1Ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48ER+3CuPa73K29MvllAxYxB++l3k+kP8jwOXOjdExw=;
        b=H8QFfBIKGgFFuA+mIx7gpITCifugRS88d9L4LNHQU2vGxWNg2yOBeuEeBV6N2hYs0C
         ABbQExSItfjiuBkoDAaC9Rn+8wIWsf9hYFN3oYpn4zX6eTTLDdx9lD3/Pv2gXWvN5JSE
         QJb9IIfNELJcu3ZouzZSgA4S5/onMwxNxGIvPMU2ylA0hfn/4kx5opUZBhm5q6QpKAT+
         Xraw5CXtsAFR9OTEMR7kvj83iGBNkzm2+B3cq9bI9QtvFeoNT53jASHbcPmrOcEsyBdu
         PM90W4plSFdCOMD8LCMZ2bF4i0NWtG2imJLxwgQyMbQUGVtPIYArbP/t+YT6cyyVxUrd
         D6lQ==
X-Gm-Message-State: AOAM532CwufuQhQ2lCNSWf1JFNIeUS/Nu0jw1P5p0NK+g++cvh3/v3A5
        D9UoeslDHAq1hGUHAQcPz8U=
X-Google-Smtp-Source: ABdhPJyPpxS117k9awXuPpg1yH7pXyErrfX55dpQjmD1KxA57rXMLO/V/4BStRD4yKcP7sBHDBxm+Q==
X-Received: by 2002:a6b:3703:: with SMTP id e3mr4919766ioa.120.1620336884897;
        Thu, 06 May 2021 14:34:44 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id 6sm1486019iog.36.2021.05.06.14.34.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 May 2021 14:34:44 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 06/12] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Thu,  6 May 2021 17:34:29 -0400
Message-Id: <20210506213435.42457-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
References: <20210506213435.42457-1-olga.kornievskaia@gmail.com>
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
index 82294d06075c..a2edcc42e6c4 100644
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
index 09953597d055..71500eb89bff 100644
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
index 47aa47a2b07c..f02a61bc0d95 100644
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
@@ -2777,6 +2782,7 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = 0;
+	xprt->xprt_class = &xs_local_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
 	xprt->bind_timeout = XS_BIND_TO;
@@ -2846,6 +2852,7 @@ static struct rpc_xprt *xs_setup_udp(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_UDP;
+	xprt->xprt_class = &xs_udp_transport;
 	/* XXX: header size can vary due to auth type, IPv6, etc. */
 	xprt->max_payload = (1U << 16) - (MAX_HEADER << 3);
 
@@ -2926,6 +2933,7 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_TCP;
+	xprt->xprt_class = &xs_tcp_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 
 	xprt->bind_timeout = XS_BIND_TO;
@@ -2999,6 +3007,7 @@ static struct rpc_xprt *xs_setup_bc_tcp(struct xprt_create *args)
 	transport = container_of(xprt, struct sock_xprt, xprt);
 
 	xprt->prot = IPPROTO_TCP;
+	xprt->xprt_class = &xs_bc_tcp_transport;
 	xprt->max_payload = RPC_MAX_FRAGMENT_SIZE;
 	xprt->timeout = &xs_tcp_default_timeout;
 
-- 
2.27.0

