Return-Path: <linux-nfs+bounces-5180-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A09593FFCE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109861F2235B
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F891862BE;
	Mon, 29 Jul 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXdn7U3P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255B84D34;
	Mon, 29 Jul 2024 20:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722286359; cv=none; b=B2AekZvgrjEndyQIxv8MAjWvqxjmpfy/2kvdEyjKKyqAnw40B5XBm3a876RM/IUlmmJhtRHR8m/E4FdqBw9+GnKP1Qpwfbt62CxONfLmnB6PRD3wPzGq+D7WBKo6CkAgEHQDR9idWQm89UkvKA/zGfpwSW7ynnMmRlrYGQat69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722286359; c=relaxed/simple;
	bh=4b/NgWk//9YN2rG/pvLNeobXakfxjCRRoN8R6BcK6Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzQffuhR+EB418zbYjiFt743dzaXoL+tnoUTlx5GwLgwRrsxyseMA112t6EDnf2qZrBiLXDjEvb9jBdA1q4TFjr4fuLsSmJvZS9CP2jOQ7VTA+W5DsMYGpKSdcNYwi3rd1jsRTF/plT88HSw80qdMqCYuURJ4j+Z08R50k1iuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXdn7U3P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11534C32786;
	Mon, 29 Jul 2024 20:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722286359;
	bh=4b/NgWk//9YN2rG/pvLNeobXakfxjCRRoN8R6BcK6Xw=;
	h=From:To:Cc:Subject:Date:From;
	b=WXdn7U3PtrwfOtGqfp3nrCsgAADTQU8LPOAmbx9v99cY42Tl8iIsdKBfvNXGSwi9u
	 wm54D6eHfuU1bOzkF3bnOBFIUgK1QyHTElFEFrQJePus/SC/bckI6lJRFLUlrD46nd
	 Fd6jUrOLgooPz8KjTuMh8V5oZzdT1l5r8ptpOYPE0KRahuhoE7urCzVKQLF5AQgPpl
	 /qAjvM9aYay6P8BYQMnfVQAwpnszkjyiI/qxDXhaLM4/SnvxQwSIevcQYLn+ilRcee
	 2Phm/SJqZw0i3qg+YZUT1cm6zkywyoUofVDZvCDfFMU+znzipDNqNR+z1rOEyYDg1s
	 QilsMU6TolFOA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: <linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] svcrdma: Handle device removal outside of the CM event handler
Date: Mon, 29 Jul 2024 16:52:32 -0400
Message-ID: <20240729205232.54932-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Synchronously wait for all disconnects to complete to ensure the
transports have divested all hardware resources before the
underlying RDMA device can safely be removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  2 ++
 include/trace/events/rpcrdma.h           | 23 +++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 +++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d33bab33099a..619fc0bd837a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -48,6 +48,7 @@
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/rpc_rdma_cid.h>
 #include <linux/sunrpc/svc_rdma_pcl.h>
+#include <linux/sunrpc/rdma_rn.h>
 
 #include <linux/percpu_counter.h>
 #include <rdma/ib_verbs.h>
@@ -76,6 +77,7 @@ struct svcxprt_rdma {
 	struct svc_xprt      sc_xprt;		/* SVC transport structure */
 	struct rdma_cm_id    *sc_cm_id;		/* RDMA connection id */
 	struct list_head     sc_accept_q;	/* Conn. waiting accept */
+	struct rpcrdma_notification sc_rn;	/* removal notification */
 	int		     sc_ord;		/* RDMA read limit */
 	int                  sc_max_send_sges;
 	bool		     sc_snd_w_inv;	/* OK to use Send With Invalidate */
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index ba2d6a0e41cc..9141398591e0 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2172,6 +2172,29 @@ TRACE_EVENT(svcrdma_qp_error,
 	)
 );
 
+TRACE_EVENT(svcrdma_device_removal,
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
 DECLARE_EVENT_CLASS(svcrdma_sendqueue_class,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f15750cacacf..581cc5ed7c0c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -339,7 +339,6 @@ static int svc_rdma_cma_handler(struct rdma_cm_id *cma_id,
 		svc_xprt_enqueue(xprt);
 		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
-	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		svc_xprt_deferred_close(xprt);
 		break;
 	default:
@@ -384,6 +383,16 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	return &cma_xprt->sc_xprt;
 }
 
+static void svc_rdma_xprt_done(struct rpcrdma_notification *rn)
+{
+	struct svcxprt_rdma *rdma = container_of(rn, struct svcxprt_rdma,
+						 sc_rn);
+	struct rdma_cm_id *id = rdma->sc_cm_id;
+
+	trace_svcrdma_device_removal(id);
+	svc_xprt_close(&rdma->sc_xprt);
+}
+
 /*
  * This is the xpo_recvfrom function for listening endpoints. Its
  * purpose is to accept incoming connections. The CMA callback handler
@@ -425,6 +434,9 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	dev = newxprt->sc_cm_id->device;
 	newxprt->sc_port_num = newxprt->sc_cm_id->port_num;
 
+	if (rpcrdma_rn_register(dev, &newxprt->sc_rn, svc_rdma_xprt_done))
+		goto errout;
+
 	newxprt->sc_max_req_size = svcrdma_max_req_size;
 	newxprt->sc_max_requests = svcrdma_max_requests;
 	newxprt->sc_max_bc_requests = svcrdma_max_bc_requests;
@@ -580,6 +592,7 @@ static void __svc_rdma_free(struct work_struct *work)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(work, struct svcxprt_rdma, sc_work);
+	struct ib_device *device = rdma->sc_cm_id->device;
 
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
@@ -608,6 +621,7 @@ static void __svc_rdma_free(struct work_struct *work)
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
+	rpcrdma_rn_unregister(device, &rdma->sc_rn);
 	kfree(rdma);
 }
 
-- 
2.45.2


