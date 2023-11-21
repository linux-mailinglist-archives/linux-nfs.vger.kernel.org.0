Return-Path: <linux-nfs+bounces-15-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CAD7F3405
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 713AAB20F23
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28B25674F;
	Tue, 21 Nov 2023 16:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ+JUjaY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3591E5674C;
	Tue, 21 Nov 2023 16:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E69CC433C7;
	Tue, 21 Nov 2023 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584834;
	bh=KPCgMf2paQU2vKeZS8AWyTHoe4qDFS5TCSe1Qrn8r0c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nQ+JUjaYGUcACT9S3ZqGxPD7fJWR5XQuVaa73TC4yY2hxICanHSAGffbNaqMhCGDP
	 pDucciTfQiCj1W41vImNNnduMJVEVGn97S4URvEJEr4RdZpLws3ZQlWNh0fad1cm9Y
	 BVC9XmKhL3vm/QKvMl5g9WBpByPWwZNeJmwHA4mpOKp3kwKYy3wlYTV4dKn1SezbSp
	 L3RE/LIkVf0znux1VWMhWtL+qA6pE22SaZZxD1Ekec1FBhMRBljGLYm8TRm6VTH+S0
	 exRQdKKbBpT/V5mXKV8qo9zo+IXPydbEW1v+KXKhov7Gh0R3T2imAJqAQSOey9wmvv
	 XjYtgJVEeguVQ==
Subject: [PATCH v2 4/6] svcrdma: Add an async version of
 svc_rdma_send_ctxt_put()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:33 -0500
Message-ID: 
 <170058483320.4504.14961094296267468100.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
References: 
 <170058462629.4504.17663192195815644972.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

DMA unmapping can take quite some time, so it should not be handled
in a single-threaded completion handler. Defer releasing send_ctxts
to the recently-added workqueue.

With this patch, DMA unmapping can be handled in parallel, and it
does not cause head-of-queue blocking of Send completions.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       |    2 ++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |   34 ++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index e18c94e816b3..ab250017b99f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -152,7 +152,9 @@ struct svc_rdma_recv_ctxt {
 struct svc_rdma_send_ctxt {
 	struct llist_node	sc_node;
 	struct rpc_rdma_cid	sc_cid;
+	struct work_struct	sc_work;
 
+	struct svcxprt_rdma	*sc_rdma;
 	struct ib_send_wr	sc_send_wr;
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 45735f74eb86..22c39ba923d2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -143,6 +143,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 
 	svc_rdma_send_cid_init(rdma, &ctxt->sc_cid);
 
+	ctxt->sc_rdma = rdma;
 	ctxt->sc_send_wr.next = NULL;
 	ctxt->sc_send_wr.wr_cqe = &ctxt->sc_cqe;
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
@@ -223,15 +224,8 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	goto out;
 }
 
-/**
- * svc_rdma_send_ctxt_put - Return send_ctxt to free list
- * @rdma: controlling svcxprt_rdma
- * @ctxt: object to return to the free list
- *
- * Pages left in sc_pages are DMA unmapped and released.
- */
-void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
-			    struct svc_rdma_send_ctxt *ctxt)
+static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
+				       struct svc_rdma_send_ctxt *ctxt)
 {
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
@@ -255,6 +249,28 @@ void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 	llist_add(&ctxt->sc_node, &rdma->sc_send_ctxts);
 }
 
+static void svc_rdma_send_ctxt_put_async(struct work_struct *work)
+{
+	struct svc_rdma_send_ctxt *ctxt;
+
+	ctxt = container_of(work, struct svc_rdma_send_ctxt, sc_work);
+	svc_rdma_send_ctxt_release(ctxt->sc_rdma, ctxt);
+}
+
+/**
+ * svc_rdma_send_ctxt_put - Return send_ctxt to free list
+ * @rdma: controlling svcxprt_rdma
+ * @ctxt: object to return to the free list
+ *
+ * Pages left in sc_pages are DMA unmapped and released.
+ */
+void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
+			    struct svc_rdma_send_ctxt *ctxt)
+{
+	INIT_WORK(&ctxt->sc_work, svc_rdma_send_ctxt_put_async);
+	queue_work(svcrdma_wq, &ctxt->sc_work);
+}
+
 /**
  * svc_rdma_wake_send_waiters - manage Send Queue accounting
  * @rdma: controlling transport



