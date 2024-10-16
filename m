Return-Path: <linux-nfs+bounces-7196-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41ABB9A08A4
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 13:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FA31F23BE0
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Oct 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F820204F9E;
	Wed, 16 Oct 2024 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H42hVFR4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933E5206059
	for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079311; cv=none; b=t+r5jIiplPWWY2BEbBceP3PF09/vVsX6Hmq6t989OUa7jXOrYZhG3eOuVV6kw9a2fOlgyvAxxlzMv7J6JhCRqAJCYbPauQBJ1n4Q3fvE81pgI+KOT3ydvfSiThAw88T3VF6c309l3H8UtWPfzpbvoV18U27lxNTOqO5TcSxm08s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079311; c=relaxed/simple;
	bh=llJ5hAdvdW+foy2VEbHuBB4lSkcaBNNtpJkRTUbUDn0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=LMRNVviQzwg4Uh2+F4bTVl7NSpl7yuTqIutbBDjW2TPow6eO7hnVQgFeD/EV0enJFYh34SdBxwULw3cKgab0beQ4QfsRRaPEX4oDE+ZDx0+j5zJwCa+YGb72lnax0/ErNUw5sBdT6hLtkQU5f6NZ+vCmBMxO7XPAx2S4eq8P3q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H42hVFR4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43111cff9d3so49231685e9.1
        for <linux-nfs@vger.kernel.org>; Wed, 16 Oct 2024 04:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729079308; x=1729684108; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j29kn8NSBAGoTSCtLUrhbz75yhIUIt6KQzMWUePNXkg=;
        b=H42hVFR41Oc6Lm0Rtc1lyI3ha0yPrCO5EXBql7QMdDHTOBZy7HwAzUJ0v+w5qSnXYw
         aTlRpKqk933wD8lrS3LI2MYPLvROQnHPQiHRjcUVOyXhv1fLhSW0ONvJ09GiGjz4Oc1Z
         MmoKa1OqrRFJ/eLJ3Zakmbi+uZlbp+ofsw/1z8KvXpJd7hvJaAqVClxlWsbhD9Zqi5+K
         V9d2ucBdEyXIkb967WjD++lxKXUOL0xOuIZiEbBgWKySjpGst7Khqn0hlEi+Jpp4ryAT
         0JUOwPLD1G2lulnZuKHkREmShzDYuvGU5KjsW9m4guzXp7xfcG5B/kqM5NTK6b786+wa
         g1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729079308; x=1729684108;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j29kn8NSBAGoTSCtLUrhbz75yhIUIt6KQzMWUePNXkg=;
        b=ED7zRBP8Rn3LWu2elGO3n1iBE4xM7QKoZQihMvOZGbSoGFG37cx9JGXuWyebpWDk63
         2JD4rIJSTzbCdatO6l5SvO+lSPp/46dl3EYQ3CIh1qgqOH+EqccjU/teyJbLY86QkdHw
         BkAHPFEO4uJiK5O+heiH8WxmGMseFwLzNwCgymG+eomGgZiqNNQC7PLRDalWFs/DHg7m
         CDUz+/pesJr4HTdnZm/kbrB6EerMnS89SBP3E2zVlOzTacXEM34VixgljryH8FF13/+o
         p298wmVI68/9+x/75uXrmuCJGxmC+orOQHKmsDJ8m5S8hy/CMqL7S0f2vK24o/gFieML
         dAFA==
X-Forwarded-Encrypted: i=1; AJvYcCVKcIvrk9co66iCDvD6F9fenRLXcTMzcwjKIlkfhV5RnbRrMJQRnBpGmHwfSrbAi6dMx2AqhnWZ2eU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw568YXr8J+i9mLDNYHVB3x4GY4afLYmH6HDX8r3ttrznXgoh27
	9UG1mckpbMMGIeF8F10ArEDJWPBWPug86uZEJ0Qw5rMH+mWp0MGI
X-Google-Smtp-Source: AGHT+IFTdwjoUp+2xTVTXbX+CEILP1+rgFPT0DaIPiM87hS/MMBvNc7Tx1GU6vKbjmWH3qOZ7XePvA==
X-Received: by 2002:a05:600c:1d94:b0:42f:4f6:f8f3 with SMTP id 5b1f17b1804b1-4314a284aacmr32817345e9.7.1729079307494;
        Wed, 16 Oct 2024 04:48:27 -0700 (PDT)
Received: from [0.0.0.0] ([95.179.233.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc445fesm4109430f8f.113.2024.10.16.04.48.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 04:48:27 -0700 (PDT)
Message-ID: <1a765211-2d1e-48ef-a5ca-a6b39b833d5a@gmail.com>
Date: Wed, 16 Oct 2024 19:48:25 +0800
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Content-Language: en-US
To: Trond Myklebust <trondmy@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>
From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [RFC PATCH 4/5] SUNRPC: support resvport and reuseport for rpcrdma
Cc: kinglongmee@gmail.com, Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

NFSd's DRC key contains peer port, but rpcrdma does't support port resue now.
This patch supports resvport and resueport as tcp/udp for rpcrdma.
 
Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 net/sunrpc/xprtrdma/transport.c |  36 ++++++++++++
 net/sunrpc/xprtrdma/verbs.c     | 100 ++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/xprt_rdma.h |   5 ++
 3 files changed, 141 insertions(+)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 9a8ce5df83ca..fee3b562932b 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -70,6 +70,10 @@ unsigned int xprt_rdma_max_inline_write = RPCRDMA_DEF_INLINE;
 unsigned int xprt_rdma_memreg_strategy		= RPCRDMA_FRWR;
 int xprt_rdma_pad_optimize;
 static struct xprt_class xprt_rdma;
+static unsigned int xprt_rdma_min_resvport_limit = RPC_MIN_RESVPORT;
+static unsigned int xprt_rdma_max_resvport_limit = RPC_MAX_RESVPORT;
+unsigned int xprt_rdma_min_resvport = RPC_DEF_MIN_RESVPORT;
+unsigned int xprt_rdma_max_resvport = RPC_DEF_MAX_RESVPORT;
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 
@@ -137,6 +141,24 @@ static struct ctl_table xr_tunables_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "rdma_min_resvport",
+		.data		= &xprt_rdma_min_resvport,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &xprt_rdma_min_resvport_limit,
+		.extra2		= &xprt_rdma_max_resvport_limit
+	},
+	{
+		.procname	= "rdma_max_resvport",
+		.data		= &xprt_rdma_max_resvport,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &xprt_rdma_min_resvport_limit,
+		.extra2		= &xprt_rdma_max_resvport_limit
+	},
 };
 
 #endif
@@ -346,6 +368,20 @@ xprt_setup_rdma(struct xprt_create *args)
 	xprt_rdma_format_addresses(xprt, sap);
 
 	new_xprt = rpcx_to_rdmax(xprt);
+
+	if (args->srcaddr)
+		memcpy(&new_xprt->rx_srcaddr, args->srcaddr, args->addrlen);
+	else {
+		rc = rpc_init_anyaddr(args->dstaddr->sa_family,
+					(struct sockaddr *)&new_xprt->rx_srcaddr);
+		if (rc != 0) {
+			xprt_rdma_free_addresses(xprt);
+			xprt_free(xprt);
+			module_put(THIS_MODULE);
+			return ERR_PTR(rc);
+		}
+	}
+
 	rc = rpcrdma_buffer_create(new_xprt);
 	if (rc) {
 		xprt_rdma_free_addresses(xprt);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 63262ef0c2e3..0ce5123d799b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -285,6 +285,98 @@ static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
 	xprt_force_disconnect(ep->re_xprt);
 }
 
+static int rpcrdma_get_random_port(void)
+{
+	unsigned short min = xprt_rdma_min_resvport, max = xprt_rdma_max_resvport;
+	unsigned short range;
+	unsigned short rand;
+
+	if (max < min)
+		return -EADDRINUSE;
+	range = max - min + 1;
+	rand = get_random_u32_below(range);
+	return rand + min;
+}
+
+static void rpcrdma_set_srcport(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
+{
+        struct sockaddr *sap = (struct sockaddr *)&id->route.addr.src_addr;
+
+	if (r_xprt->rx_srcport == 0 && r_xprt->rx_xprt.reuseport) {
+		switch (sap->sa_family) {
+		case AF_INET6:
+			r_xprt->rx_srcport = ntohs(((struct sockaddr_in6 *)sap)->sin6_port);
+			break;
+		case AF_INET:
+			r_xprt->rx_srcport = ntohs(((struct sockaddr_in *)sap)->sin_port);
+			break;
+		}
+	}
+}
+
+static int rpcrdma_get_srcport(struct rpcrdma_xprt *r_xprt)
+{
+	int port = r_xprt->rx_srcport;
+
+	if (port == 0 && r_xprt->rx_xprt.resvport)
+		port = rpcrdma_get_random_port();
+	return port;
+}
+
+static unsigned short rpcrdma_next_srcport(struct rpcrdma_xprt *r_xprt, unsigned short port)
+{
+	if (r_xprt->rx_srcport != 0)
+		r_xprt->rx_srcport = 0;
+	if (!r_xprt->rx_xprt.resvport)
+		return 0;
+	if (port <= xprt_rdma_min_resvport || port > xprt_rdma_max_resvport)
+		return xprt_rdma_max_resvport;
+	return --port;
+}
+
+static int rpcrdma_bind(struct rpcrdma_xprt *r_xprt, struct rdma_cm_id *id)
+{
+	struct sockaddr_storage myaddr;
+	int err, nloop = 0;
+	int port = rpcrdma_get_srcport(r_xprt);
+	unsigned short last;
+
+	/*
+	 * If we are asking for any ephemeral port (i.e. port == 0 &&
+	 * r_xprt->rx_xprt.resvport == 0), don't bind.  Let the local
+	 * port selection happen implicitly when the socket is used
+	 * (for example at connect time).
+	 *
+	 * This ensures that we can continue to establish TCP
+	 * connections even when all local ephemeral ports are already
+	 * a part of some TCP connection.  This makes no difference
+	 * for UDP sockets, but also doesn't harm them.
+	 *
+	 * If we're asking for any reserved port (i.e. port == 0 &&
+	 * r_xprt->rx_xprt.resvport == 1) rpcrdma_get_srcport above will
+	 * ensure that port is non-zero and we will bind as needed.
+	 */
+	if (port <= 0)
+		return port;
+
+	memcpy(&myaddr, &r_xprt->rx_srcaddr, r_xprt->rx_xprt.addrlen);
+	do {
+		rpc_set_port((struct sockaddr *)&myaddr, port);
+		err = rdma_bind_addr(id, (struct sockaddr *)&myaddr);
+		if (err == 0) {
+			if (r_xprt->rx_xprt.reuseport)
+				r_xprt->rx_srcport = port;
+			break;
+		}
+		last = port;
+		port = rpcrdma_next_srcport(r_xprt, port);
+		if (port > last)
+			nloop++;
+	} while (err == -EADDRINUSE && nloop != 2);
+
+	return err;
+}
+
 static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 					    struct rpcrdma_ep *ep)
 {
@@ -300,6 +392,12 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	if (IS_ERR(id))
 		return id;
 
+	rc = rpcrdma_bind(r_xprt, id);
+	if (rc) {
+		rc = -ENOTCONN;
+		goto out;
+	}
+
 	ep->re_async_rc = -ETIMEDOUT;
 	rc = rdma_resolve_addr(id, NULL, (struct sockaddr *)&xprt->addr,
 			       RDMA_RESOLVE_TIMEOUT);
@@ -328,6 +426,8 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	if (rc)
 		goto out;
 
+	rpcrdma_set_srcport(r_xprt, id);
+
 	return id;
 
 out:
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8147d2b41494..9c7bcb541267 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -433,6 +433,9 @@ struct rpcrdma_xprt {
 	struct delayed_work	rx_connect_worker;
 	struct rpc_timeout	rx_timeout;
 	struct rpcrdma_stats	rx_stats;
+
+	struct sockaddr_storage	rx_srcaddr;
+	unsigned short		rx_srcport;
 };
 
 #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
@@ -581,6 +584,8 @@ static inline void rpcrdma_set_xdrlen(struct xdr_buf *xdr, size_t len)
  */
 extern unsigned int xprt_rdma_max_inline_read;
 extern unsigned int xprt_rdma_max_inline_write;
+extern unsigned int xprt_rdma_min_resvport;
+extern unsigned int xprt_rdma_max_resvport;
 void xprt_rdma_format_addresses(struct rpc_xprt *xprt, struct sockaddr *sap);
 void xprt_rdma_free_addresses(struct rpc_xprt *xprt);
 void xprt_rdma_close(struct rpc_xprt *xprt);
-- 
2.47.0


