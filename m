Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5953768AB
	for <lists+linux-nfs@lfdr.de>; Fri,  7 May 2021 18:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbhEGQ0d (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 May 2021 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238114AbhEGQ01 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 May 2021 12:26:27 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1DAC061574
        for <linux-nfs@vger.kernel.org>; Fri,  7 May 2021 09:25:26 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id i22so8117026ila.11
        for <linux-nfs@vger.kernel.org>; Fri, 07 May 2021 09:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48ER+3CuPa73K29MvllAxYxB++l3k+kP8jwOXOjdExw=;
        b=PpGINacUSIApPtbNnmWNHtBa7sM7sVAR568F7bx8fSfL2nAdlsxcazDLIOWkRr3wKZ
         j8/MKhPaooi2XpbHOWqOPyrmis620fdgIOW0UnmyFfRhS+Lg20sU8A5yVoHqD2iSR10S
         h2spVFLrJeE+kATdEzIeVEqwSsxQd7mz4ppQixny2FFtQmEaTOPaz0iZjNV7Jl2wRMF6
         /7kFXXgHxGW/Ztg7qYzcEr/XrodQY8blV/Sdn40OsfN2jc2j1Yz4IJd0PdDykJMhWqpj
         MHyzJ925XceOBZ6jw4nowjynNeLoqpRQrh4fAgPRDI47hW1nmo0hNJOv4NnyEFUQmz0Y
         JTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48ER+3CuPa73K29MvllAxYxB++l3k+kP8jwOXOjdExw=;
        b=OLAyVQiNOaBkEpuVcBspFh+OgqPmn35n5zd47S0NEnJSCNcB3XCr1BBdWUgSeWuijr
         ipqRVH4T6IdNMhz3DimDioBtFQaKRXPysHvT2iZibrwhMNcGZdSoeO5kwWyrnkocNAWs
         b+AOMq/KDj9bO7rOdmAjvb9EVSXPcFHWc2NqNP/fCrZext8c8e/6rn1xuSFfhssxlxK+
         LW0V8pCjwagBoBAlcaNK+K0HEHUohp+JBfhRCtmcTD6hHZk2cUGFDWQ8uCIUudNnjhmD
         z/uA0wQATwm8MK13x4O6ayBk0MvL31M9kY/5TgqSu3CChf8y0FMkyMLZwgkF4xkHqIrf
         op3A==
X-Gm-Message-State: AOAM533gqMKynYjChRpgJtwCylriD/FQysN5M9F2kPsZ2rMie2yB8yob
        mwi+9XgSm3vR72b2jzqLhURn50cWZ67nqw==
X-Google-Smtp-Source: ABdhPJztSor1n4MvFcYIOvn3NEfrRgIbb6q1CrVzV+d/w96XgemxRcD3IjtcKZ27oEufOqQwJfFT/A==
X-Received: by 2002:a92:b106:: with SMTP id t6mr10414389ilh.99.1620404726379;
        Fri, 07 May 2021 09:25:26 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id v2sm2451000ioe.22.2021.05.07.09.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 May 2021 09:25:25 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v6 06/12] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Fri,  7 May 2021 12:25:12 -0400
Message-Id: <20210507162518.51520-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
References: <20210507162518.51520-1-olga.kornievskaia@gmail.com>
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

