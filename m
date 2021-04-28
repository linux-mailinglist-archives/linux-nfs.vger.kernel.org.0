Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4150036E0FA
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Apr 2021 23:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhD1VdB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Apr 2021 17:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhD1VdB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Apr 2021 17:33:01 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05E0C06138B
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:15 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t17so36732078qkg.4
        for <linux-nfs@vger.kernel.org>; Wed, 28 Apr 2021 14:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEB3fsVvOc0l4sGUbovZ3sxmkNfiwInhgmEzkRx418Q=;
        b=RZlCW+BraUgW32E5WsooTE/OR///ykn94qwbhQST2OqMmHoZAfwtV4WP1gdPybnnxQ
         9siM8cYfwYl0B9UEpj2datu99Y1Ca4YegLyqHNDpnIJJCwJKeYtO6hEhGxLPvN7MhIsr
         uq1BO699kj0PLiI/rmguQfKn/gYHaWHjWPw9UcAxd+fQXxI9CyZ6GYCevzz9Mzpe7ClG
         8TBWhtaWROzT12AxrzHGfC3y01GAK5co6TYCscDQRLsc6CIDk8mZtcGH2/jcZ0zdHZll
         RgNQUjc3ZjP4OY9QHufKXnZ59Dd0kZwXk2PHMKznSGBx5VgrncAs2MzIhfRa3b2p4IDF
         Ye6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEB3fsVvOc0l4sGUbovZ3sxmkNfiwInhgmEzkRx418Q=;
        b=T9GW4dTy+FX5YJBuQI2NYMmUgTTd6B2WhNc8r3ma8ZFU7m4ZjxI1qhms4p5QoGa6ZO
         l+Gg9pfUiee4y5YlB8fvKsW9D9NuKd4qrCr1WUos3j0s45Q2uUbkYsXIIOEC5POxR7yL
         iiRX97kLZ1qsLvOdktlHijBc0OrosmavFHK9EE6OuouT1xmq3lrV3xbr9uoq0oCJe6Qr
         8rf6gQwMfhEDxcI4ZrdZjaj8SkQW3hi9b+tjycAUTgnMU50/0Qkr7QcqyW7psGGXLgEl
         WVLNco8ZE+0XW7MJm0KevJFp7VErW3vhvCPOFtnrp4vbhD4hMEWGorzze8ENgt98yUM+
         2ZEA==
X-Gm-Message-State: AOAM532bcKKy/Pc/SaaSDBCFtVwxZUXLUZ73heRzKBg9ge2lufVLoV1i
        QfsDNFaKrY/d/Lx25EOLAKg=
X-Google-Smtp-Source: ABdhPJyKJnZaDg1NK4EEM8TyJw2KwxRsbcxP1JmERcuRNUWAEDrbf5pKj3Ii7dBPcppX889o4/UAIA==
X-Received: by 2002:a37:6606:: with SMTP id a6mr30696616qkc.165.1619645534958;
        Wed, 28 Apr 2021 14:32:14 -0700 (PDT)
Received: from kolga-mac-1.vpn.netapp.com (nat-216-240-30-11.netapp.com. [216.240.30.11])
        by smtp.gmail.com with ESMTPSA id v3sm710269qkb.124.2021.04.28.14.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Apr 2021 14:32:14 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 07/13] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Wed, 28 Apr 2021 17:31:57 -0400
Message-Id: <20210428213203.40059-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
References: <20210428213203.40059-1-olga.kornievskaia@gmail.com>
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

