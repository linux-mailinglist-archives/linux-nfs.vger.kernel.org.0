Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFE7360003
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhDOC2g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 22:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDOC2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Apr 2021 22:28:36 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A13C061574
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:13 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c3so12778548ils.5
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ucYfPxQ2q6euyweVHd9Cs6eqlS3LoA+VSPktZIPi2pI=;
        b=ULlFwvLJvy53HjVBOy35f0sOwhDfzhNu+p00RiCS+YDVAUXpySUz5Hdu7wV1cz5bGr
         S7C1pyWGsU4V1f25Ba0qa8KGi3ivHH7Na8k5C7/tsBGDZXkaIAvq3Rw96YN2VpQeDdWj
         1/GbZBPOhLvysRdDp0BTHtLNIQV5urmMXFlK0t1x39EmlnoxNgyT3k+kNmqTgEtOePS1
         rAA6wOZqD5zTIxCFy2ZPJNfvpAgmMTHdM+AQoH/lgN1GY3sBznOCar1nHeF4I+JTc/IT
         tjqwgVbG5w+KETtYpVFc3eSVyOU8W940d/wDagRY2POurq80hVe4XKMzVAc05eOaKYxE
         nH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ucYfPxQ2q6euyweVHd9Cs6eqlS3LoA+VSPktZIPi2pI=;
        b=GPyCnGjTgJjw6vxcHwYqkCPl814KRSrSHdY65zCCOqr6rtfitJY9T7l4xh3zb2kT2u
         VqzA9C7dnGet7HZUbENhD1FzmVudRRNlyEqrhHqEX38IkY6gCXXysaeoXcg6Ow0pi4/A
         VwkZDhmUPdAdUuzVunZd+3LNCOTiIdaV121fnyNa00w2Q59mqjad/XRbrv3TNaIKzTgG
         THQ30HxcuH2ggpmgOjLOyagJvxLaoQ9g6p2W5tfLHt006jIUEd8nQaUWxn5YUO692AKR
         vDAglx2MUUaJ09ioVclKpax1mX32HWAp5vYrQxMZ4j6gHnWLP02YigVwB8SHbyAKyLbm
         tKqA==
X-Gm-Message-State: AOAM53256/lfNjlAupZOsYt4x5TFeoO+x13bIHHpR7QrQUgy4AR+Qtk0
        GCu5lTwlu5SyynX1Ppdj/MY=
X-Google-Smtp-Source: ABdhPJwmyp4zuc3J9kwvHL2Ef6eMCBAXcrgEzyC5S473NhCvLM77hR9hAmUtz75D7lX4dvAMsryPMg==
X-Received: by 2002:a05:6e02:1caf:: with SMTP id x15mr1040685ill.89.1618453693241;
        Wed, 14 Apr 2021 19:28:13 -0700 (PDT)
Received: from kolga-mac-1.attlocal.net (172-10-226-31.lightspeed.livnmi.sbcglobal.net. [172.10.226.31])
        by smtp.gmail.com with ESMTPSA id s11sm608917ilh.47.2021.04.14.19.28.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Apr 2021 19:28:12 -0700 (PDT)
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/13] sunrpc: keep track of the xprt_class in rpc_xprt structure
Date:   Wed, 14 Apr 2021 22:27:56 -0400
Message-Id: <20210415022802.31692-8-olga.kornievskaia@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
References: <20210415022802.31692-1-olga.kornievskaia@gmail.com>
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
index 78d29d1bcc20..2c2e51e54fbb 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -87,6 +87,7 @@ static unsigned int dummy;
 
 static struct ctl_table_header *sunrpc_table_header;
 
+static struct xprt_class xprt_rdma;
 static struct ctl_table xr_tunables_table[] = {
 	{
 		.procname	= "rdma_slot_table_entries",
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

