Return-Path: <linux-nfs+bounces-16036-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2421C333C5
	for <lists+linux-nfs@lfdr.de>; Tue, 04 Nov 2025 23:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7344188C7B1
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Nov 2025 22:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC8E313539;
	Tue,  4 Nov 2025 22:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyioX63E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A2B1DF25F
	for <linux-nfs@vger.kernel.org>; Tue,  4 Nov 2025 22:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295378; cv=none; b=sGjeNF02zQI7k9t2yQ5tjRn13aPUGbu0LWe+IZ6NBeSb+RN7zly/h/1lihyPe0u/nSppHT1+NnZs5sZErke7GHFwSuxPeULrqMJIkVC6ghuGuiD0unzDj7MQV/XGXHC9tWIbuHo95PPtVqwNoN4PgDrxyZ+iVTw6im9G0NTo4Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295378; c=relaxed/simple;
	bh=pNr2xVi7ZPmvUc5mMTUOg/oYrbGDn4IfkJAv4ILPXTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EthjsvlUpB9MmCvpB4X5QL3gbc8KlT4YF2XvuzSxnUj82yBZVeIMX5+hcnhPSGk2V2etSka8Kk/dHkhuD2KwuElN6jLZGjTnBhjwL/qDz7qrnIy0dlOEq5KmyELCtBi3UoBQYo6cB8tY4DYuOz788Z6ghWeVy7gUrcHzKAFkhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyioX63E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762295375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1c//yqdob59kmiYREcOao76ADJSMLnNWEmW6GK0bLDA=;
	b=YyioX63Ebi3Axkw0sTFVsWr62JJREbbb92lHHalQq/8sJppEB5JjtmzqWdZD7wYynnKZNA
	8PourIrXP5K3vWXry0ePrmVqyw9iztlyFctFO/AvtHYkrwZf//F3ODyFqx+MTx2HyVfvFt
	2oD9xoYpZMojE21KdycQhMZ78mmOgVA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-yETu8fbaORqAS1unQQh-6g-1; Tue,
 04 Nov 2025 17:29:32 -0500
X-MC-Unique: yETu8fbaORqAS1unQQh-6g-1
X-Mimecast-MFC-AGG-ID: yETu8fbaORqAS1unQQh-6g_1762295371
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 766A318002E4;
	Tue,  4 Nov 2025 22:29:31 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.88.89])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A56DA1956056;
	Tue,  4 Nov 2025 22:29:30 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/4] SUNRPC: cleanup common code in backchannel request
Date: Tue,  4 Nov 2025 17:29:25 -0500
Message-ID: <20251104222927.69423-3-okorniev@redhat.com>
In-Reply-To: <20251104222927.69423-1-okorniev@redhat.com>
References: <20251104222927.69423-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Create a helper function for common code between rdma
and tcp backchannel handling of the backchannel request.
Make sure that access is protected by the bc_pa_lock
lock.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/sunrpc/bc_xprt.h    |  1 +
 net/sunrpc/backchannel_rqst.c     | 19 ++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c |  8 ++------
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index f22bf915dcf6..178f34ad8db6 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -25,6 +25,7 @@ void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
 void xprt_free_bc_request(struct rpc_rqst *req);
 int xprt_setup_backchannel(struct rpc_xprt *, unsigned int min_reqs);
 void xprt_destroy_backchannel(struct rpc_xprt *, unsigned int max_reqs);
+void xprt_enqueue_bc_request(struct rpc_rqst *req);
 
 /* Socket backchannel transport methods */
 int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index caa94cf57123..efddea0f4b8b 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -354,7 +354,6 @@ struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid)
 void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 {
 	struct rpc_xprt *xprt = req->rq_xprt;
-	struct svc_serv *bc_serv = xprt->bc_serv;
 
 	spin_lock(&xprt->bc_pa_lock);
 	list_del(&req->rq_bc_pa_list);
@@ -365,7 +364,21 @@ void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied)
 	set_bit(RPC_BC_PA_IN_USE, &req->rq_bc_pa_state);
 
 	dprintk("RPC:       add callback request to list\n");
+	xprt_enqueue_bc_request(req);
+}
+
+void xprt_enqueue_bc_request(struct rpc_rqst *req)
+{
+	struct rpc_xprt *xprt = req->rq_xprt;
+	struct svc_serv *bc_serv;
+
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
+EXPORT_SYMBOL_GPL(xprt_enqueue_bc_request);
diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 8c817e755262..2f0f9618dd05 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -9,6 +9,7 @@
 #include <linux/sunrpc/svc.h>
 #include <linux/sunrpc/svc_xprt.h>
 #include <linux/sunrpc/svc_rdma.h>
+#include <linux/sunrpc/bc_xprt.h>
 
 #include "xprt_rdma.h"
 #include <trace/events/rpcrdma.h>
@@ -220,7 +221,6 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 			     struct rpcrdma_rep *rep)
 {
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
-	struct svc_serv *bc_serv;
 	struct rpcrdma_req *req;
 	struct rpc_rqst *rqst;
 	struct xdr_buf *buf;
@@ -261,11 +261,7 @@ void rpcrdma_bc_receive_call(struct rpcrdma_xprt *r_xprt,
 	trace_xprtrdma_cb_call(r_xprt, rqst);
 
 	/* Queue rqst for ULP's callback service */
-	bc_serv = xprt->bc_serv;
-	xprt_get(xprt);
-	lwq_enqueue(&rqst->rq_bc_list, &bc_serv->sv_cb_list);
-
-	svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
+	xprt_enqueue_bc_request(rqst);
 
 	r_xprt->rx_stats.bcall_count++;
 	return;
-- 
2.47.1


