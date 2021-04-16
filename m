Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAB361862
	for <lists+linux-nfs@lfdr.de>; Fri, 16 Apr 2021 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238316AbhDPDxC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 23:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbhDPDxB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 23:53:01 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9E4C061756
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:37 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id 130so13399565qkm.4
        for <linux-nfs@vger.kernel.org>; Thu, 15 Apr 2021 20:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i7slSIy/hMWHVhcOCT6x9BQEEZPJBRvI25D3ZapeUf8=;
        b=iB+DJ6ZK8MB1aUFcl31OyPJYJ1tiKi4rq2wPIV5QuDVloQe2BT4VHIVIFQqQ9PYwll
         YOCQ05hwUcnt3nfYr/TGyPUVnCMv5BiK+p8l7Lrvt1U2irfcl1jNaOz0PSRsx2JSt7vj
         iBA+8qtaORohqPcig+DMLnUOBFa+6MC6efT+vCy8RxSktGhBDbPUAVVnHQerepKzFb/M
         YYEJWwyL8c7Gop5yzV5C0Oj+XKfgkUoL8DgVxlifXQZSIEOAqxRd0/OvXxy6MpIEznWz
         2wbak5OuaF4Lbxrkafre61D5zmNC7KFIwMvqNhogoiwReWzyYHrKjRbV8JJrJ5g+kMZR
         khZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i7slSIy/hMWHVhcOCT6x9BQEEZPJBRvI25D3ZapeUf8=;
        b=dTsNjQM014s82y3Q0MUNMGR0rq3nXgou2z7UYbL/Quwnc30J/ndOopLZztVENndZiC
         mOTm1TTrY5tKlQ1XaQRvgjJlZ6AwGq/f2Llr/YuWffqKHYMU/nm26/TAuoL0nTZ0qtwb
         Pcb2zHBkhWW4RpzY01WLNfmm0XB4AASjZHb4nCyoY4UuCoZ3yuCK3Frz88Rmrk8NzbUJ
         5ZNsl2EUQwful/TnteM6ZATOMKNAMgYStS/3C3pNLBHT7Kwd1uiD6rAgjJZC5sfJ6MVN
         Nhjx6uc+NF9qrLTY4nyG1FtvdQgmgdUKUZK8ab/OWIvLR7X9cpbz4yLpFiQkPrJ9qswS
         XtKA==
X-Gm-Message-State: AOAM5310gEFA6oc9Xv3axsPrSTE13eRY1AOucQc2f/iFTuk9Wq1eai4L
        HKm/vrQH4GTixIwp0ImxG8U=
X-Google-Smtp-Source: ABdhPJyA9RyQNzREjH4R4YzvzjEMXHfisjtGH4KT+T/NkZ9H2b/HAZdQRdG6z0WVk6E2mASnGtpUVA==
X-Received: by 2002:a05:620a:759:: with SMTP id i25mr6625426qki.193.1618545157023;
        Thu, 15 Apr 2021 20:52:37 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-25.netapp.com. [216.240.30.25])
        by smtp.gmail.com with ESMTPSA id x82sm3500913qkb.0.2021.04.15.20.52.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 20:52:36 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/13] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Thu, 15 Apr 2021 23:52:20 -0400
Message-Id: <20210416035226.53588-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
References: <20210416035226.53588-1-olga.kornievskaia@gmail.com>
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
index 78d29d1bcc20..de0dec5f6d5b 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -73,6 +73,7 @@ unsigned int xprt_rdma_max_inline_read = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
 int xprt_rdma_pad_optimize;
+static struct xprt_class xprt_rdma;
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 
@@ -347,6 +348,7 @@ xprt_setup_rdma(struct xprt_create *args)
 	/* Ensure xprt->addr holds valid server TCP (not RDMA)
 	 * address, for any side protocols which peek at it */
 	xprt->prot = IPPROTO_TCP;
+	xprt->xprt_class = &xprt_rdma;
 	xprt->addrlen = args->addrlen;
 	memcpy(&xprt->addr, sap, xprt->addrlen);
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2bcb80c19339..5ff37badd335 100644
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

