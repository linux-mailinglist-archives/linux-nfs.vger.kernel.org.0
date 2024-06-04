Return-Path: <linux-nfs+bounces-3547-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9F8FBCBD
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3981C218D8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB42F34;
	Tue,  4 Jun 2024 19:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdR1QfF8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AD372
	for <linux-nfs@vger.kernel.org>; Tue,  4 Jun 2024 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717530360; cv=none; b=FHUINeMapZ9gEZrlQhHi3NEpddPfcVpI5+ZsG2fz51kAwE14oCI2wIc4S9Nx/BLPFvtSj0/on/PNRH1iQ8yIN+Sasj3u0VlHFmuHyjhDmL2IROhG89P5ckHf9yyBsCSsc8d0qBM5htYSR7t/RKXAm8TCApSqepurU85MOQACVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717530360; c=relaxed/simple;
	bh=MeNlT7TdopZjysajwdcUBrq9ZwWCVURib/b08rUk99E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwjvDjFclycB87ynN4+6Vg3YKMECgtdY2uDuUzCQN9JwMIXFQURMs+0w27qapw0Zke+EAY3P+lo6nG3MWrrjqAsHUxwOFU7JoV1hiRFSGviWf5FTWjiZbn0fynha+hhLI/3MTyah4zGZAJwDmvOP7TkOZGsjKqULi0DZiiQlv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdR1QfF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D81C4AF07;
	Tue,  4 Jun 2024 19:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717530360;
	bh=MeNlT7TdopZjysajwdcUBrq9ZwWCVURib/b08rUk99E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kdR1QfF8sdkOrw06YpDfIVnXYh3bN0ne9tssZEe+uGN+aaMXg8nEqBnOQx4Oucr3K
	 XPeL52GFnXsv5pU+cQ1YsuFsyxq7lyH5fBlTAo9y8+dF2I83MPh9ExcC7g8ECu3gx2
	 wRZtUUkwjOArJgPGScwatI6/xbQsN1LEucTSOfsswx06ma+ncSJ9YbTAMENQLmgUZR
	 LgQDgAjwlM13vvstbj++ehlfwcYpNF682HUOHL48GUu4XiS8QXjKEXx/U3D1rYLiFc
	 g/fTGcbhXcRiXWDloqQV57OvHQvOCZv3OhY+kdpta07GG+TJy+vow8Gviez3b+PXDG
	 ez+fs5XozKaGQ==
From: cel@kernel.org
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 3/5] xprtrdma: Handle device removal outside of the CM event handler
Date: Tue,  4 Jun 2024 15:45:25 -0400
Message-ID: <20240604194522.10390-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604194522.10390-6-cel@kernel.org>
References: <20240604194522.10390-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4252; i=chuck.lever@oracle.com; h=from:subject; bh=EAbyFc9tekg2vKPRrrre/Y17+KdtZfKCpjv5RXp4p68=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmX27gqXNjZPd6AqcfPrDmrRzozEULGd8SnLnEm 1TEiF27NJCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZl9u4AAKCRAzarMzb2Z/ l/TxD/99FpkPXHdeDroA1lt+OALJCEcNiBwZEJXTYn5fL77nOQiPpm2Tuq2euLiMyrYxJUTsUeE tZAxBhMP66xDY9Po7qBUQtH9wDDY3K5leRhKZD/CXU610/eTjKjClE54CUII4DE9XIukHmzbF9n omIb4Qmf3zbXM15znYWhgvzBXa/XfAJwqGAtrr3xFaqmukQ5ccCj97gS7wIf8RsFCuGet/wfk4F Wvd6DxUK/82krnfgFTZtbiPou7DVWaDaSukTbnpkbG984NnwEeRb3xkDY7QjwRDkiOSgIUe7hgu OhX4XcepdEe/UeFYZEfH5N4im4AeqwvYK76YywjENcq/zGVxuByC2FsVB3mkqLihGRtgw6+vJQq 8Q/1OQoSCAeqaPd3M5Co0IdQ+nSAarSMbS0OJH4tIyOFDnnsCDqwS+tdFIVIrGgDu3lhOtxkEPl ysOruGyO6e+kGRw5U5DpRmUIq7KZjV2ZeNanCpuXwbICLAUW/aQLCThd14IgkpQbCSfabkwe39b t9SdfUkTj0U4yVIvpQf45EsqCM/Lg8coRJXFBtQb6ru9I2sHjq9Wn9K0gww+bH/SGgGUSuesEmk GWgcgQvCA8bBuW7QskZHTpePMhSMqkuYmdyKwqeHp3wXfTMkjlbp2aSSL4P/8gC8lplvdPk4axs nsPqXw4dM5rnWYw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Wait for all disconnects to complete to ensure the transport has
divested all of its hardware resources before the underlying RDMA
device can be removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  | 23 +++++++++++++++++++++++
 net/sunrpc/xprtrdma/verbs.c     | 23 ++++++++++++++---------
 net/sunrpc/xprtrdma/xprt_rdma.h |  2 ++
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index ecdaf088219d..ba2d6a0e41cc 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -669,6 +669,29 @@ TRACE_EVENT(xprtrdma_inline_thresh,
 DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
 
+TRACE_EVENT(xprtrdma_device_removal,
+	TP_PROTO(
+		const struct rdma_cm_id *id
+	),
+
+	TP_ARGS(id),
+
+	TP_STRUCT__entry(
+		__string(name, id->device->name)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+	),
+
+	TP_fast_assign(
+		__assign_str(name);
+		memcpy(__entry->addr, &id->route.addr.dst_addr,
+		       sizeof(struct sockaddr_in6));
+	),
+
+	TP_printk("device %s to be removed, disconnecting %pISpc\n",
+		__get_str(name), __entry->addr
+	)
+);
+
 DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
 
 TRACE_EVENT(xprtrdma_op_connect,
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index a0b071089e15..04558c99e9f4 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -222,7 +222,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_ep *ep,
 static int
 rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
-	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;
 	struct rpcrdma_ep *ep = id->context;
 
 	might_sleep();
@@ -241,14 +240,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_async_rc = -ENETUNREACH;
 		complete(&ep->re_done);
 		return 0;
-	case RDMA_CM_EVENT_DEVICE_REMOVAL:
-		pr_info("rpcrdma: removing device %s for %pISpc\n",
-			ep->re_id->device->name, sap);
-		switch (xchg(&ep->re_connect_status, -ENODEV)) {
-		case 0: goto wake_connect_worker;
-		case 1: goto disconnected;
-		}
-		return 0;
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
 		goto disconnected;
@@ -284,6 +275,14 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	return 0;
 }
 
+static void rpcrdma_ep_removal_done(struct rpcrdma_notification *rn)
+{
+	struct rpcrdma_ep *ep = container_of(rn, struct rpcrdma_ep, re_rn);
+
+	trace_xprtrdma_device_removal(ep->re_id);
+	xprt_force_disconnect(ep->re_xprt);
+}
+
 static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 					    struct rpcrdma_ep *ep)
 {
@@ -323,6 +322,10 @@ static struct rdma_cm_id *rpcrdma_create_id(struct rpcrdma_xprt *r_xprt,
 	if (rc)
 		goto out;
 
+	rc = rpcrdma_rn_register(id->device, &ep->re_rn, rpcrdma_ep_removal_done);
+	if (rc)
+		goto out;
+
 	return id;
 
 out:
@@ -350,6 +353,8 @@ static void rpcrdma_ep_destroy(struct kref *kref)
 		ib_dealloc_pd(ep->re_pd);
 	ep->re_pd = NULL;
 
+	rpcrdma_rn_unregister(ep->re_id->device, &ep->re_rn);
+
 	kfree(ep);
 	module_put(THIS_MODULE);
 }
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index da409450dfc0..341725c66ec8 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -56,6 +56,7 @@
 #include <linux/sunrpc/rpc_rdma_cid.h> 	/* completion IDs */
 #include <linux/sunrpc/rpc_rdma.h> 	/* RPC/RDMA protocol */
 #include <linux/sunrpc/xprtrdma.h> 	/* xprt parameters */
+#include <linux/sunrpc/rdma_rn.h>	/* removal notifications */
 
 #define RDMA_RESOLVE_TIMEOUT	(5000)	/* 5 seconds */
 #define RDMA_CONNECT_RETRY_MAX	(2)	/* retries if no listener backlog */
@@ -92,6 +93,7 @@ struct rpcrdma_ep {
 	struct rpcrdma_connect_private
 				re_cm_private;
 	struct rdma_conn_param	re_remote_cma;
+	struct rpcrdma_notification	re_rn;
 	int			re_receive_count;
 	unsigned int		re_max_requests; /* depends on device */
 	unsigned int		re_inline_send;	/* negotiated */
-- 
2.45.1


