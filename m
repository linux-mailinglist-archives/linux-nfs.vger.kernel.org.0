Return-Path: <linux-nfs+bounces-15815-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 193F3C2275D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 22:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FE154EEF4E
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Oct 2025 21:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C04334363;
	Thu, 30 Oct 2025 21:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHccq84e"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EFB524D1
	for <linux-nfs@vger.kernel.org>; Thu, 30 Oct 2025 21:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860890; cv=none; b=sNIdxsYAtJoGrtcBKcjPCrUIOzDIl104OOGwxnYgqYysRm0p1GD3lr5aQXpC+KnhXW6tEMeddyj8uylDzxVIpZOzvN39zTJGX+QMXFG5xcqjdhqgW1Eifu0pLXQSmzJPM2d1uv7rfJbJ44hT3iv3Rz0SnTKGRMJhkjQsfFaUe7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860890; c=relaxed/simple;
	bh=2zNmKgZoq9SX1HMtwXRlmQEru9kn/qRXE4jqALEMeXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0yv0omnkPFNDjdorUvccHiC2uyBSPJJV7UyJboUd4g6CK2+wTHH8ehF5MkpzrOG1bGiwZE+QyCP3deX4SIWiIPWuuUaLIEzZvsqBJLJ/R7p4pL08fq4BBjy+9YwG3t3agZ7jLbg4SWzUQtVssIFdQFEvMGPQZ+JVxMifTAmwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHccq84e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761860888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bsJMyRQpdpufxssOwdvikZ2ncnHVp/iXq1DT6Zj6EE=;
	b=eHccq84e1vuUAnFRljw6EuekX/t5kwmzey02ISvxrQzdC8UEwjUbuLrtvO6WwOEKIZZMug
	ycpfFQly9yTS2h57/JnWZGK9YLCyGKS1c8axghKzg1FsszKYmb4yXvWbjSoO7iFvUMzP1M
	CIHktQTvTu2hUwefULv6NhiJLpp901Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-92-JCPCMbSfP9CgMLTbw2Inww-1; Thu,
 30 Oct 2025 17:48:04 -0400
X-MC-Unique: JCPCMbSfP9CgMLTbw2Inww-1
X-Mimecast-MFC-AGG-ID: JCPCMbSfP9CgMLTbw2Inww_1761860884
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E511918089A2;
	Thu, 30 Oct 2025 21:48:03 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.64.252])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A0E11954128;
	Thu, 30 Oct 2025 21:48:02 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/3] SUNRPC: protect access to rpc_xprt bc_serv
Date: Thu, 30 Oct 2025 17:47:58 -0400
Message-ID: <20251030214759.62746-3-okorniev@redhat.com>
In-Reply-To: <20251030214759.62746-1-okorniev@redhat.com>
References: <20251030214759.62746-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We need to protect access to bc_serv usage thru the bc_pa_lock
and make sure that backchannel request processing is accessing
a valid pointer.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/sunrpc/bc_xprt.h    |  1 +
 net/sunrpc/backchannel_rqst.c     | 27 ++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c | 11 +++++++----
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index f22bf915dcf6..6f57685192aa 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -31,6 +31,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
 void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
 void xprt_free_bc_rqst(struct rpc_rqst *req);
 unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
+void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv);
 
 /*
  * Determine if a shared backchannel is in use
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index caa94cf57123..916f78cd3306 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -24,6 +24,22 @@ unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
 	return BC_MAX_SLOTS;
 }
 
+/*
+ * Helper function to nullify backchannel server pointer in transport.
+ * We need to synchronize setting the pointer to NULL (done so after
+ * the backchannel server is shutdown) with the usage of that pointer
+ * by the backchannel request processing routines
+ * xprt_complete_bc_request() and rpcrdma_bc_receive_call().
+ */
+void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
+{
+	spin_lock(&xprt->bc_pa_lock);
+	svc_destroy(serv);
+	xprt->bc_serv = NULL;
+	spin_unlock(&xprt->bc_pa_lock);
+}
+EXPORT_SYMBOL_GPL(xprt_svc_destroy_nullify_bc);
+
 /*
  * Helper routines that track the number of preallocation elements
  * on the transport.
@@ -354,7 +370,7 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
 void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 {
 	struct rpc_xprt *xprt = req->rq_xprt;
-	struct svc_serv *bc_serv = xprt->bc_serv;
+	struct svc_serv *bc_serv;
 
 	spin_lock(&xprt->bc_pa_lock);
 	list_del(&req->rq_bc_pa_list);
@@ -366,6 +382,11 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 
 	dprintk("RPC:       add callback request to list\n");
 	xprt_get(xprt);
-	lwq_enqueue(&req->rq_bc_list, &bc_serv->sv_cb_list);
-	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
+	spin_lock(&xprt->bc_pa_lock);
+	bc_serv = xprt->bc_serv;
+	if (bc_serv) {
+		lwq_enqueue(&req->rq_bc_list, &bc_serv->sv_cb_list);
+		svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
+	}
+	spin_unlock(&xprt->bc_pa_lock);
 }
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 8c817e755262..01055446ec56 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -261,11 +261,14 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	trace_xprtrdma_cb_call(r_xprt, rqst);
 
 	/* Queue rqst for ULP's callback service */
-	bc_serv = xprt->bc_serv;
 	xprt_get(xprt);
-	lwq_enqueue(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
-
-	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
+	spin_lock(&xprt->bc_pa_lock);
+	bc_serv = xprt->bc_serv;
+	if (bc_serv) {
+		lwq_enqueue(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
+		svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
+	}
+	spin_lock(&xprt->bc_pa_lock);
 
 	r_xprt->rx_stats.bcall_count++;
 	return;
-- 
2.47.1


