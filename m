Return-Path: <linux-nfs+bounces-483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148380CF61
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 16:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28571C21204
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Dec 2023 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F34B5A6;
	Mon, 11 Dec 2023 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEJQ9dTf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EE4AF81;
	Mon, 11 Dec 2023 15:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC311C433B9;
	Mon, 11 Dec 2023 15:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308250;
	bh=Cn2aLrgLn9F4WwngZDunocI5s85Y6YoRuq/jxaaPDr4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cEJQ9dTfj1hiXCcLW1NkRUFavOioJ3tD9NITXYTr03W9MnD3MDHByAGCJT+W1ZMZq
	 mFANGT1OyshB8b7QU2PIEr2NE1ewhmb+VDEL5xkvSfCx8EGPRTKfACyhbWpgEMWtnY
	 x72GaqAXd06CMatfYfBpA1xyepzFBP+gcdyAaYEday8Ce2Zo2Ci5zAba4qM5riPftL
	 6rYydb9oAb98qqx6eANB+oLPm51zW7wKE4P3xSIencVMd5VUMSMjT8RDSxujMqD4Nh
	 5cgUTzPWzaoGEvVMCA6CLQ8ooluO6Mg/PIU0yodPeSe/PPhBQOsT3iQduV4WzSCvHg
	 w0KTWL8FpuypQ==
Subject: [PATCH v1 1/8] svcrdma: De-duplicate completion ID initialization
 helpers
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 11 Dec 2023 10:24:08 -0500
Message-ID: 
 <170230824865.90242.7760213084666437745.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
References: 
 <170230788373.90242.9421368360904462120.stgit@bazille.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |   24 ++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    7 -------
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |    9 +--------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |    7 -------
 4 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 051fefde8d51..46f2ce9f810b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -134,6 +134,30 @@ enum {
 
 #define RPCSVC_MAXPAYLOAD_RDMA	RPCSVC_MAXPAYLOAD
 
+/**
+ * svc_rdma_send_cid_init - Initialize a Receive Queue completion ID
+ * @rdma: controlling transport
+ * @cid: completion ID to initialize
+ */
+static inline void svc_rdma_recv_cid_init(struct svcxprt_rdma *rdma,
+					  struct rpc_rdma_cid *cid)
+{
+	cid->ci_queue_id = rdma->sc_rq_cq->res.id;
+	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
+}
+
+/**
+ * svc_rdma_send_cid_init - Initialize a Send Queue completion ID
+ * @rdma: controlling transport
+ * @cid: completion ID to initialize
+ */
+static inline void svc_rdma_send_cid_init(struct svcxprt_rdma *rdma,
+					  struct rpc_rdma_cid *cid)
+{
+	cid->ci_queue_id = rdma->sc_sq_cq->res.id;
+	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
+}
+
 /*
  * A chunk context tracks all I/O for moving one Read or Write
  * chunk. This is a set of rdma_rw's that handle data movement
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 392a91dc8a99..ac6351e292c5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -115,13 +115,6 @@ svc_rdma_next_recv_ctxt(struct list_head *list)
 					rc_list);
 }
 
-static void svc_rdma_recv_cid_init(struct svcxprt_rdma *rdma,
-				   struct rpc_rdma_cid *cid)
-{
-	cid->ci_queue_id = rdma->sc_rq_cq->res.id;
-	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
-}
-
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 4d2db06ccfd2..eab71f3867fa 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -146,13 +146,6 @@ static int svc_rdma_rw_ctx_init(struct svcxprt_rdma *rdma,
 	return ret;
 }
 
-static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
-				 struct rpc_rdma_cid *cid)
-{
-	cid->ci_queue_id = rdma->sc_sq_cq->res.id;
-	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
-}
-
 /**
  * svc_rdma_cc_init - Initialize an svc_rdma_chunk_ctxt
  * @rdma: controlling transport instance
@@ -161,7 +154,7 @@ static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
 void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 		      struct svc_rdma_chunk_ctxt *cc)
 {
-	svc_rdma_cc_cid_init(rdma, &cc->cc_cid);
+	svc_rdma_send_cid_init(rdma, &cc->cc_cid);
 
 	INIT_LIST_HEAD(&cc->cc_rwctxts);
 	cc->cc_sqecount = 0;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 9571ed4a74d4..c9585e469ca8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -113,13 +113,6 @@
 
 static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc);
 
-static void svc_rdma_send_cid_init(struct svcxprt_rdma *rdma,
-				   struct rpc_rdma_cid *cid)
-{
-	cid->ci_queue_id = rdma->sc_sq_cq->res.id;
-	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
-}
-
 static struct svc_rdma_send_ctxt *
 svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 {



