Return-Path: <linux-nfs+bounces-14-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 478A37F3403
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 17:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5F3B21EFB
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Nov 2023 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D739418E02;
	Tue, 21 Nov 2023 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/CDkUia"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB45381E;
	Tue, 21 Nov 2023 16:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6193C433C8;
	Tue, 21 Nov 2023 16:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700584828;
	bh=V5p4QcoTWlqaRgyxr3UOZ7FpMjsdBlIqka6QOEOm4co=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=f/CDkUiadnS1Y9lxRTgLGfYUv4HwMhIVzau/uHYjxFtgcnOeg5duBfjTQaB/EQunI
	 q1b4/dgsOM8+R25aZ5IDVM05ArRaSxg2R8pJdf+nlpi1nOKyzmVwLJiXDup4Qya7zp
	 6SYW6nNPLEAMs/UQoeL2uJmajztbIimyB8jEOhhYtQymL0fNd16tBtIZTOakgJ1Nta
	 kFEZcTQX7oPyn4RPCYT/dTWvUHyc6NhBb7TuZQ/eXU98EyNGQDXh4gVmJGuwDjE1LO
	 3JC5mwGcNE8dSbTG9kp0KJNsl5yWV/kfnW5t+OYzPOfyjHJml6cF0c+QVanhiWppZ6
	 0KfrikJNJYegQ==
Subject: [PATCH v2 3/6] svcrdma: Add a utility workqueue to svcrdma
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>, tom@talpey.com
Date: Tue, 21 Nov 2023 11:40:26 -0500
Message-ID: 
 <170058482674.4504.5617536262259718863.stgit@bazille.1015granger.net>
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

To handle work in the background, set up an UNBOUND workqueue for
svcrdma. Subsequent patches will make use of it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |    1 +
 net/sunrpc/xprtrdma/svc_rdma.c           |   32 +++++++++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    1 +
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 4ac32895a058..e18c94e816b3 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -65,6 +65,7 @@ extern unsigned int svcrdma_ord;
 extern unsigned int svcrdma_max_requests;
 extern unsigned int svcrdma_max_bc_requests;
 extern unsigned int svcrdma_max_req_size;
+extern struct workqueue_struct *svcrdma_wq;
 
 extern struct percpu_counter svcrdma_stat_read;
 extern struct percpu_counter svcrdma_stat_recv;
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index f0d5eeed4c88..f86970733eb0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -256,28 +256,44 @@ static int svc_rdma_proc_init(void)
 	return rc;
 }
 
+struct workqueue_struct *svcrdma_wq;
+
 void svc_rdma_cleanup(void)
 {
-	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
 	svc_unreg_xprt_class(&svc_rdma_class);
 	svc_rdma_proc_cleanup();
+	if (svcrdma_wq) {
+		struct workqueue_struct *wq = svcrdma_wq;
+
+		svcrdma_wq = NULL;
+		destroy_workqueue(wq);
+	}
+
+	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
 }
 
 int svc_rdma_init(void)
 {
+	struct workqueue_struct *wq;
 	int rc;
 
-	dprintk("SVCRDMA Module Init, register RPC RDMA transport\n");
-	dprintk("\tsvcrdma_ord      : %d\n", svcrdma_ord);
-	dprintk("\tmax_requests     : %u\n", svcrdma_max_requests);
-	dprintk("\tmax_bc_requests  : %u\n", svcrdma_max_bc_requests);
-	dprintk("\tmax_inline       : %d\n", svcrdma_max_req_size);
+	wq = alloc_workqueue("svcrdma", WQ_UNBOUND, 0);
+	if (!wq)
+		return -ENOMEM;
 
 	rc = svc_rdma_proc_init();
-	if (rc)
+	if (rc) {
+		destroy_workqueue(wq);
 		return rc;
+	}
 
-	/* Register RDMA with the SVC transport switch */
+	svcrdma_wq = wq;
 	svc_reg_xprt_class(&svc_rdma_class);
+
+	dprintk("SVCRDMA Module Init, register RPC RDMA transport\n");
+	dprintk("\tsvcrdma_ord      : %d\n", svcrdma_ord);
+	dprintk("\tmax_requests     : %u\n", svcrdma_max_requests);
+	dprintk("\tmax_bc_requests  : %u\n", svcrdma_max_bc_requests);
+	dprintk("\tmax_inline       : %d\n", svcrdma_max_req_size);
 	return 0;
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 2abd895046ee..c046916df007 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -547,6 +547,7 @@ static void __svc_rdma_free(struct work_struct *work)
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
+	flush_workqueue(svcrdma_wq);
 
 	svc_rdma_flush_recv_queues(rdma);
 



