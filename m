Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF030380B44
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 16:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232946AbhENOOr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbhENOOo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 May 2021 10:14:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48E9C061756
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:32 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id t11so2928123iol.9
        for <linux-nfs@vger.kernel.org>; Fri, 14 May 2021 07:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48ER+3CuPa73K29MvllAxYxB++l3k+kP8jwOXOjdExw=;
        b=Ktf35nPd8MzphtRecGTeFsj+4GqaJOtd014XidOtS0i7Q3a5xE+h3/nKPERytoNb6k
         DjpNCrxDDZc1Abe5jf48I0YHE5Byi6FFDFk7SzpUygSL+g/7Bm4yZQjsvjH/lA+oV6zD
         QnyDVORW+PI/2jotSf7KSpt+rn3S/jUawRAYPFSz+6D9RnetZeVZ0TZAWNjc9nJoFWJQ
         YXZLN0XI2vvW05QCb1/eZHvq/ugajsTe9nDaq84fIDSTDqdbBEgp0GtciH20/5EWGqBW
         CMcRHv6LpsQ18rjdv1WAfT4nCQpsAvUJ/DLGZscYQNURU9k1WrDZTkixbEbCob+IsOMh
         Sj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48ER+3CuPa73K29MvllAxYxB++l3k+kP8jwOXOjdExw=;
        b=jK3EJ86bj8AQk8RSKw22uPONUtR5nJLExmPZ2NfCwBKJSF2J+rjdhkFGJUIRJtqPYa
         +ggr7wW2bTaA9hGaQvQ5vxpRVuuSL2n4NQXECqXzQV3dDE5R3j96lJEPH6eRTadd/gkP
         zrpfW/8/brAympjjigldpiZjSkiqFRaXYpLH342ooYKk5Mi04O1FvdAbMPbsDARz4jmj
         fFt4BxA5LBvTRdz2YQPZ3IbPv4QKs2V8BDzzA4eb8tHfzZowsSzAATf76sBBsTZCZTCn
         hGy8v65RKWYmtrZLjUCMDbJOnqzI4urjTupJdLbotIzApWrSdAax9P2cE2N1I0cZK8a1
         brCA==
X-Gm-Message-State: AOAM530GiVI3nWCFqVDAwmlEGYzH2cjnMPtcCJn21K0TrJ8g3PlCOxOg
        PPZxGFMk9bp9VkWNR2vbJaU=
X-Google-Smtp-Source: ABdhPJxRmqTGqDKa0jrpaJiu9L0LXyXuEgTPJE05RVFSfoA72tQuRtQ2US8ApI7TMNA1uAYVuNdPIg==
X-Received: by 2002:a5d:88cf:: with SMTP id i15mr35009946iol.45.1621001612208;
        Fri, 14 May 2021 07:13:32 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net ([2600:1700:6a10:2e90:a4f7:32c8:9c05:11a7])
        by smtp.gmail.com with ESMTPSA id b189sm2639263iof.48.2021.05.14.07.13.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 May 2021 07:13:31 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 06/12] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Fri, 14 May 2021 10:13:17 -0400
Message-Id: <20210514141323.67922-7-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
References: <20210514141323.67922-1-olga.kornievskaia@gmail.com>
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

