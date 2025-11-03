Return-Path: <linux-nfs+bounces-15972-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B821C2E3BE
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 23:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605963A6687
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 22:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD22C324F;
	Mon,  3 Nov 2025 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQClNS8C"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B02EF664
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762208030; cv=none; b=Lwrod5C3nHzkFd6N2fcHSilgO0SJBkDyI0ktqTlFwGIs2ROhLMbY4RxFlCvSnxeEHq5q+sbUKG7pEX0E//mDAyzzf21TjocCUMp0U6hh2Kq+Aga0Gu7zwyGhWtEWjqayrcC9W38GQGjdhD4CseNsdH4qERLDbD9UzPkRn8U6iN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762208030; c=relaxed/simple;
	bh=pNr2xVi7ZPmvUc5mMTUOg/oYrbGDn4IfkJAv4ILPXTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vejmf6Am4v3Nt7G4mX9wphAX+yxudkgv4HccKTMgzKVO2MUEftjuZRk0DdCD+KujQZd/BxSMcCczsEuDJn7910Enm1U/rPPx83lOvifwnmDxUC14Bi0S72UEQAovm0aXEWg9fW0qCnP7Gyyoaaa1WHYKOTwFXf3xciQ1WcU99Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XQClNS8C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762208027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1c//yqdob59kmiYREcOao76ADJSMLnNWEmW6GK0bLDA=;
	b=XQClNS8Cij7fzKfp6LUvKeeqg08VN1GEjdbykYE4yhbLX5USNlfs+nLqAIm76Orryptz6M
	z7aE5A2GT4WV1Nq2Ha6/yv21i4BJIUPZkTdI4I4u28iYAbsJfVIVMhuayF+okLBQINI+i1
	OtffCl3AsM4AmFk8jHMFhcACP8m20fw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-307-uxfrnbxLP9mwxxfKK0ZipA-1; Mon,
 03 Nov 2025 17:13:44 -0500
X-MC-Unique: uxfrnbxLP9mwxxfKK0ZipA-1
X-Mimecast-MFC-AGG-ID: uxfrnbxLP9mwxxfKK0ZipA_1762208023
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 540FD195609D;
	Mon,  3 Nov 2025 22:13:43 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7800919560A2;
	Mon,  3 Nov 2025 22:13:42 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/4] SUNRPC: cleanup common code in backchannel request
Date: Mon,  3 Nov 2025 17:13:37 -0500
Message-ID: <20251103221339.45145-3-okorniev@redhat.com>
In-Reply-To: <20251103221339.45145-1-okorniev@redhat.com>
References: <20251103221339.45145-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


