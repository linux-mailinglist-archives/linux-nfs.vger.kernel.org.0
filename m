Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92952FF3F2
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jan 2021 20:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbhAUTMV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jan 2021 14:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbhAUTLQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jan 2021 14:11:16 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5F2C06178B
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:31 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a12so2826781wrv.8
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jan 2021 11:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelim-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GUvQqrXJwEsvcapjHvIcxCJJ9kETeRu2eb40mzabFWw=;
        b=p/zSJR1dd/9eC5z4yRE0h69Z5FvthstX4/8GJhmdN/XFAscBRbYoUE2qSQVj6W7YRj
         i3HCWp2eoAPwjAMG8yOpCR5rHmySo1+YgT6ORB4PQpfFsT6zUXpZBY1T+awdCiMHs5tT
         0QCT9VKVLQmHVehZ2FfLew0pfhmRcqwE9CNCz1HhhXwPjfchzenZKaFe9JF73Y/bkiDx
         Pub2mlgzevfLYwRspY5oBjgFVfri4zGQFgHhHlI8Gn4ZNFDzsSnaGVM/g6jGHC/o7vZH
         NrOibI/ZJwGSAsVT8utSndXVJRrfLt9EyXc9E4ye5nK923TdTlV7n1PoHAX+Ys2YmY4r
         OXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GUvQqrXJwEsvcapjHvIcxCJJ9kETeRu2eb40mzabFWw=;
        b=PZzBl4mXFQFlT3qoggPeNpLqgd0sh2fUO5UpyuYn4pVLeRc4eJjmiO8p6lmIEOrZfh
         lVjKtFkQVaXw09jYuuWeJFCeT3DsiFAOA7KIzqjx/jyTnNjCARSiOHFqKaR/hnGg77Um
         X/ldJ9Lx3mTKQNwRR4UzQCYRMGlkr6B9P0vMQPNx5yeQh5nrrTynEEizKQNrO6FNULkg
         hO6XEl/LiUVzCEV4bbmjGg/IV6+osvGVDpuBTOGwF2h/YkqBpT/nIkI+JRTEiAjiwg4m
         avNW4f4AmXOoQyZssp9Sf+p6yzpknZhULLc9JNPdIw0LUgeKrPuvyadZqmSSa5UQ/44F
         jUSA==
X-Gm-Message-State: AOAM533N7Gwf4uSgWZIYiJg1LTBZRNtbXWvAq+diK35+BUmHOwAy1a+e
        d24NDKW7Byd6t3ZuadbOonCZ+y5S5fPB6e6x
X-Google-Smtp-Source: ABdhPJzJUU/o0LlaVN6MI33O9abAKEISaGunuiKy3Etwf+byAH12Hskrh9MHhnCtUt8IB+xlwRp2pQ==
X-Received: by 2002:adf:f512:: with SMTP id q18mr913891wro.55.1611256229088;
        Thu, 21 Jan 2021 11:10:29 -0800 (PST)
Received: from jupiter.home.aloni.org ([77.124.84.167])
        by smtp.gmail.com with ESMTPSA id d30sm11160353wrc.92.2021.01.21.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 11:10:28 -0800 (PST)
From:   Dan Aloni <dan@kernelim.com>
To:     linux-nfs@vger.kernel.org
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: [PATCH v1 4/5] sunrpc: Add srcaddr to xprt sysfs debug
Date:   Thu, 21 Jan 2021 21:10:19 +0200
Message-Id: <20210121191020.3144948-5-dan@kernelim.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210121191020.3144948-1-dan@kernelim.com>
References: <20210121191020.3144948-1-dan@kernelim.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For easier inspection of transport state with regard to nconnect, with
remoteports and localports of NFS, this helps us to know what is the
source address used for each established transport.

Signed-off-by: Dan Aloni <dan@kernelim.com>
---
 include/linux/sunrpc/xprt.h                |  1 +
 net/sunrpc/debugfs.c                       |  8 ++--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  2 +-
 net/sunrpc/xprtrdma/transport.c            | 10 ++++-
 net/sunrpc/xprtrdma/xprt_rdma.h            |  3 +-
 net/sunrpc/xprtsock.c                      | 49 ++++++++++++++--------
 6 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index d2e97ee802af..2bdf9e806964 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -43,6 +43,7 @@ struct rpc_timeout {
 
 enum rpc_display_format_t {
 	RPC_DISPLAY_ADDR = 0,
+	RPC_DISPLAY_SRC_ADDR,
 	RPC_DISPLAY_PORT,
 	RPC_DISPLAY_PROTO,
 	RPC_DISPLAY_HEX_ADDR,
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 56029e3af6ff..4c65b64077f7 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -175,9 +175,11 @@ xprt_info_show(struct seq_file *f, void *v)
 {
 	struct rpc_xprt *xprt = f->private;
 
-	seq_printf(f, "netid: %s\n", xprt->address_strings[RPC_DISPLAY_NETID]);
-	seq_printf(f, "addr:  %s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
-	seq_printf(f, "port:  %s\n", xprt->address_strings[RPC_DISPLAY_PORT]);
+	seq_printf(f, "netid:   %s\n", xprt->address_strings[RPC_DISPLAY_NETID]);
+	seq_printf(f, "addr:    %s\n", xprt->address_strings[RPC_DISPLAY_ADDR]);
+	seq_printf(f, "port:    %s\n", xprt->address_strings[RPC_DISPLAY_PORT]);
+	seq_printf(f, "srcaddr: %s\n", xprt->address_strings[RPC_DISPLAY_SRC_ADDR]
+		   ? xprt->address_strings[RPC_DISPLAY_SRC_ADDR] : "");
 	seq_printf(f, "state: 0x%lx\n", xprt->state);
 	return 0;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 63f8be974df2..93e4dcb1a807 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -261,7 +261,7 @@ xprt_setup_rdma_bc(struct xprt_create *args)
 
 	memcpy(&xprt->addr, args->dstaddr, args->addrlen);
 	xprt->addrlen = args->addrlen;
-	xprt_rdma_format_addresses(xprt, (struct sockaddr *)&xprt->addr);
+	xprt_rdma_format_addresses(xprt, (struct sockaddr *)&xprt->addr, NULL);
 	xprt->resvport = 0;
 
 	xprt->max_payload = xprt_rdma_max_inline_read;
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 45726ab5f13a..0d1cce310f13 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -181,7 +181,8 @@ xprt_rdma_format_addresses6(struct rpc_xprt *xprt, struct sockaddr *sap)
 }
 
 void
-xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap)
+xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap,
+			   struct sockaddr *src_sap)
 {
 	char buf[128];
 
@@ -200,6 +201,11 @@ xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap)
 	(void)rpc_ntop(sap, buf, sizeof(buf));
 	xprt->address_strings[RPC_DISPLAY_ADDR] = kstrdup(buf, GFP_KERNEL);
 
+	if (src_sap) {
+		(void)rpc_ntop(src_sap, buf, sizeof(buf));
+		xprt->address_strings[RPC_DISPLAY_SRC_ADDR] = kstrdup(buf, GFP_KERNEL);
+	}
+
 	snprintf(buf, sizeof(buf), "%u", rpc_get_port(sap));
 	xprt->address_strings[RPC_DISPLAY_PORT] = kstrdup(buf, GFP_KERNEL);
 
@@ -352,7 +358,7 @@ xprt_setup_rdma(struct xprt_create *args)
 
 	if (rpc_get_port(sap))
 		xprt_set_bound(xprt);
-	xprt_rdma_format_addresses(xprt, sap);
+	xprt_rdma_format_addresses(xprt, sap, args->srcaddr);
 
 	new_xprt = rpcx_to_rdmax(xprt);
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index cb4539d4740a..5fc36fdd2056 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -573,7 +573,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
  */
 extern unsigned int xprt_rdma_max_inline_read;
 extern unsigned int xprt_rdma_max_inline_write;
-void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
+void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap,
+				struct sockaddr *src_sap);
 void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
 void xprt_rdma_close(struct rpc_xprt *xprt);
 void xprt_rdma_print_stats(struct rpc_xprt *xprt, struct seq_file *seq);
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c56a66cdf4ac..e8ea13f29dfe 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -229,6 +229,12 @@ static inline struct sockaddr *xs_addr(struct rpc_xprt *xprt)
 	return (struct sockaddr *) &xprt->addr;
 }
 
+static inline struct sockaddr *xs_srcaddr(struct rpc_xprt *xprt)
+{
+	struct sock_xprt *transport = container_of(xprt, struct sock_xprt, xprt);
+	return (struct sockaddr *) &transport->srcaddr;
+}
+
 static inline struct sockaddr_un *xs_addr_un(struct rpc_xprt *xprt)
 {
 	return (struct sockaddr_un *) &xprt->addr;
@@ -244,9 +250,11 @@ static inline struct sockaddr_in6 *xs_addr_in6(struct rpc_xprt *xprt)
 	return (struct sockaddr_in6 *) &xprt->addr;
 }
 
-static void xs_format_common_peer_addresses(struct rpc_xprt *xprt)
+static void xs_format_common_addresses(struct rpc_xprt *xprt,
+			               struct sockaddr *sap,
+			               int display_addr,
+			               int display_hex_addr)
 {
-	struct sockaddr *sap = xs_addr(xprt);
 	struct sockaddr_in6 *sin6;
 	struct sockaddr_in *sin;
 	struct sockaddr_un *sun;
@@ -256,19 +264,19 @@ static void xs_format_common_peer_addresses(struct rpc_xprt *xprt)
 	case AF_LOCAL:
 		sun = xs_addr_un(xprt);
 		strlcpy(buf, sun->sun_path, sizeof(buf));
-		xprt->address_strings[RPC_DISPLAY_ADDR] =
+		xprt->address_strings[display_addr] =
 						kstrdup(buf, GFP_KERNEL);
 		break;
 	case AF_INET:
 		(void)rpc_ntop(sap, buf, sizeof(buf));
-		xprt->address_strings[RPC_DISPLAY_ADDR] =
+		xprt->address_strings[display_addr] =
 						kstrdup(buf, GFP_KERNEL);
 		sin = xs_addr_in(xprt);
 		snprintf(buf, sizeof(buf), "%08x", ntohl(sin->sin_addr.s_addr));
 		break;
 	case AF_INET6:
 		(void)rpc_ntop(sap, buf, sizeof(buf));
-		xprt->address_strings[RPC_DISPLAY_ADDR] =
+		xprt->address_strings[display_addr] =
 						kstrdup(buf, GFP_KERNEL);
 		sin6 = xs_addr_in6(xprt);
 		snprintf(buf, sizeof(buf), "%pi6", &sin6->sin6_addr);
@@ -277,7 +285,8 @@ static void xs_format_common_peer_addresses(struct rpc_xprt *xprt)
 		BUG();
 	}
 
-	xprt->address_strings[RPC_DISPLAY_HEX_ADDR] = kstrdup(buf, GFP_KERNEL);
+	if (display_hex_addr != -1)
+		xprt->address_strings[display_hex_addr] = kstrdup(buf, GFP_KERNEL);
 }
 
 static void xs_format_common_peer_ports(struct rpc_xprt *xprt)
@@ -292,13 +301,17 @@ static void xs_format_common_peer_ports(struct rpc_xprt *xprt)
 	xprt->address_strings[RPC_DISPLAY_HEX_PORT] = kstrdup(buf, GFP_KERNEL);
 }
 
-static void xs_format_peer_addresses(struct rpc_xprt *xprt,
-				     const char *protocol,
-				     const char *netid)
+static void xs_format_addresses(struct rpc_xprt *xprt,
+			        const char *protocol,
+			        const char *netid)
 {
 	xprt->address_strings[RPC_DISPLAY_PROTO] = protocol;
 	xprt->address_strings[RPC_DISPLAY_NETID] = netid;
-	xs_format_common_peer_addresses(xprt);
+	xs_format_common_addresses(xprt, xs_addr(xprt),
+				   RPC_DISPLAY_ADDR, RPC_DISPLAY_HEX_ADDR);
+	if (xs_srcaddr(xprt)->sa_family != 0)
+		xs_format_common_addresses(xprt, xs_srcaddr(xprt),
+					   RPC_DISPLAY_SRC_ADDR, -1);
 	xs_format_common_peer_ports(xprt);
 }
 
@@ -2793,7 +2806,7 @@ static struct rpc_xprt *xs_setup_local(struct xprt_create *args)
 			goto out_err;
 		}
 		xprt_set_bound(xprt);
-		xs_format_peer_addresses(xprt, "local", RPCBIND_NETID_LOCAL);
+		xs_format_addresses(xprt, "local", RPCBIND_NETID_LOCAL);
 		ret = ERR_PTR(xs_local_setup_socket(transport));
 		if (ret)
 			goto out_err;
@@ -2860,13 +2873,13 @@ static struct rpc_xprt *xs_setup_udp(struct xprt_create *args)
 		if (((struct sockaddr_in *)addr)->sin_port != htons(0))
 			xprt_set_bound(xprt);
 
-		xs_format_peer_addresses(xprt, "udp", RPCBIND_NETID_UDP);
+		xs_format_addresses(xprt, "udp", RPCBIND_NETID_UDP);
 		break;
 	case AF_INET6:
 		if (((struct sockaddr_in6 *)addr)->sin6_port != htons(0))
 			xprt_set_bound(xprt);
 
-		xs_format_peer_addresses(xprt, "udp", RPCBIND_NETID_UDP6);
+		xs_format_addresses(xprt, "udp", RPCBIND_NETID_UDP6);
 		break;
 	default:
 		ret = ERR_PTR(-EAFNOSUPPORT);
@@ -2942,13 +2955,13 @@ static struct rpc_xprt *xs_setup_tcp(struct xprt_create *args)
 		if (((struct sockaddr_in *)addr)->sin_port != htons(0))
 			xprt_set_bound(xprt);
 
-		xs_format_peer_addresses(xprt, "tcp", RPCBIND_NETID_TCP);
+		xs_format_addresses(xprt, "tcp", RPCBIND_NETID_TCP);
 		break;
 	case AF_INET6:
 		if (((struct sockaddr_in6 *)addr)->sin6_port != htons(0))
 			xprt_set_bound(xprt);
 
-		xs_format_peer_addresses(xprt, "tcp", RPCBIND_NETID_TCP6);
+		xs_format_addresses(xprt, "tcp", RPCBIND_NETID_TCP6);
 		break;
 	default:
 		ret = ERR_PTR(-EAFNOSUPPORT);
@@ -3006,11 +3019,11 @@ static struct rpc_xprt *xs_setup_bc_tcp(struct xprt_create *args)
 
 	switch (addr->sa_family) {
 	case AF_INET:
-		xs_format_peer_addresses(xprt, "tcp",
-					 RPCBIND_NETID_TCP);
+		xs_format_addresses(xprt, "tcp",
+				   RPCBIND_NETID_TCP);
 		break;
 	case AF_INET6:
-		xs_format_peer_addresses(xprt, "tcp",
+		xs_format_addresses(xprt, "tcp",
 				   RPCBIND_NETID_TCP6);
 		break;
 	default:
-- 
2.26.2

