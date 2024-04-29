Return-Path: <linux-nfs+bounces-3063-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E18B5DAA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D47528A5DB
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Apr 2024 15:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA6B127E2B;
	Mon, 29 Apr 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq8U/A47"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031A127E21;
	Mon, 29 Apr 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404348; cv=none; b=PsdMiG4uzOUB3qladiR423+BdaKKstC44Pa6EieIGXMjXtz3Rq6yjjRR84z2RHwbiBMFmK3qsbq8JrmaaCoVZhSDW+tDSEXn/VrI3rc02efmbDPxDUkyl+v++7A+JarBjVhZrM/9i4dufRqvuxiOQtrMzv4U8VRtbPTyZeX2iHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404348; c=relaxed/simple;
	bh=CQQfWet9gRYvytRYkhPPwpkxKK1mvYgGDcAwgOS5qq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lkdsNykc4mYT+n0rdCfX47psPaQtUz6gok68tl5xu5FSylT+xEoCl4xEkPGJWU0Z6941jrwy/J6cxg8SNeO/6LoHtUPPFZggo18U6OKburZLRSt4+4Z7N/7XCytaX+zY7Gn4zVSO1IUuKbz4ZCbO7oxAzolX7cXXsipWIORD5io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq8U/A47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5738C4AF14;
	Mon, 29 Apr 2024 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714404348;
	bh=CQQfWet9gRYvytRYkhPPwpkxKK1mvYgGDcAwgOS5qq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kq8U/A47lB/1NODC/Kh6VcY/ruMTF9Qv7513eb5dGgAr18xX/z2tqkCgOPQXFHhfx
	 zGTCVFeNlsPhD65M/Vqlml6hR3OGTJJkAct15k9IKgtXX8sU7MmkkuanDflbnt8m+J
	 hepoEqHOkGkhoA9yELEKxzftSMtLl/TYfWNzS/Tuj4qZwSX1/R0FEJXQYx7aFw1VRn
	 nDtHh7+d9KRNrnwwkh8VNNfZTuaKw1ipyi5MFXOnd/l5MWVIsE4esP1rstdQXR5+XH
	 mm2cU8vl4u5v19NxQEG9Lf9lDGDlKgVsveQZHEm6zfufPPPHX1uCQQc3VpYIWOvpsy
	 XoMX/PokCIYSw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 4/4] xprtrdma: Move MRs to struct rpcrdma_ep
Date: Mon, 29 Apr 2024 11:25:42 -0400
Message-ID: <20240429152537.212958-10-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429152537.212958-6-cel@kernel.org>
References: <20240429152537.212958-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9678; i=chuck.lever@oracle.com; h=from:subject; bh=l6rX/ZC8L4NkMCKe75WVMTLvRYW9ylOWHZBIeAcPFs8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmL7vy2WObc4SeGY0QS08ZGftCF6Z/O1ZwLJPYe 5AUr2Aqi9OJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZi+78gAKCRAzarMzb2Z/ lw3dD/9MwY+wnUScEPuB+AiOwPYc+kKmXYJaiQnYr6eAUy0aSrLTxHUcOxjJDIf5HFoHNHHJR7w Qf+kCvjiTtyU0Escy6w8hC0KtZGciu9XdSVsYkAZxqNbExhjftv5I2Q9b6H1EkG2F0ObUjP2zXv DVneX39ysB/5li9PjCuVUDktvh+wNJzZPaHxYwiR+X4agVsqE4/huj3eu4UpCsbLtEXwTFnkqJ6 y2L4MVdKxfkuyrXCYQJjo7Mtcn9lz4TNGPu7M54oyyTjIndxFHkW9BghrzOtsUWYKs+EzmVWMk0 OSZKsRgtYPNlHe+gK68SYsjXr6Sof3woBo08CgIsv1cb+BnTPSR/osfRIOA4JwXtU5a+S6m2nei gFKfjY8Ljaody4Mwh/VDhhoZ8B4u1MJemrUT1UakxFP5Qb1iTgMTW8rSRmWPwYWGrwvi8qX6tCZ A1nS6AhAbHagz0/LgtgNIAGkI4A3MJSraqS/xDXNbgpZYSESHb6lfBJObz/vmxPPv50DgH/wlex 792ApRdoA5PtowzCD/Rrc178ofadFN2kht0dHYxxqO79NUH4nkA0Lf5xtD8Exn7zjfKgyGGQvQ5 VcKOCG9snPnvvT74+ehOj+QP/59L+78s81rlEcPPeWv7nqfD3cq+wDgbNgQTKeqrh1JUbzKRvWA eLBe0IGnB9AglFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

MRs are a connection-specific hardware resource, thus they should be
anchored in the EP and released with the other hardware resources.

Closes: Link: https://bugzilla.kernel.org/show_bug.cgi?id=218704
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |  7 ++--
 net/sunrpc/xprtrdma/verbs.c     | 70 ++++++++++++++++-----------------
 net/sunrpc/xprtrdma/xprt_rdma.h | 13 +++---
 3 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 6e508708d06d..7e918753eec4 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -112,15 +112,14 @@ void frwr_reset(struct rpcrdma_req *req)
 
 /**
  * frwr_mr_init - Initialize one MR
- * @r_xprt: controlling transport instance
+ * @ep: controlling transport instance
  * @mr: generic MR to prepare for FRWR
  *
  * Returns zero if successful. Otherwise a negative errno
  * is returned.
  */
-int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
+int frwr_mr_init(struct rpcrdma_ep *ep, struct rpcrdma_mr *mr)
 {
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	unsigned int depth = ep->re_max_fr_depth;
 	struct scatterlist *sg;
 	struct ib_mr *frmr;
@@ -134,7 +133,7 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	if (IS_ERR(frmr))
 		goto out_mr_err;
 
-	mr->mr_xprt = r_xprt;
+	mr->mr_ep = ep;
 	mr->mr_ibmr = frmr;
 	mr->mr_device = NULL;
 	INIT_LIST_HEAD(&mr->mr_list);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index f1e4a28325fa..2578d9e77056 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -71,7 +71,8 @@ static int rpcrdma_reqs_setup(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reps_unmap(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
-static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
+static void rpcrdma_mrs_destroy(struct rpcrdma_ep *ep);
+static void rpcrdma_mr_refresh_worker(struct work_struct *work);
 static void rpcrdma_ep_get(struct rpcrdma_ep *ep);
 static void rpcrdma_ep_put(struct rpcrdma_ep *ep);
 static struct rpcrdma_regbuf *
@@ -337,6 +338,8 @@ static void rpcrdma_ep_destroy(struct work_struct *work)
 {
 	struct rpcrdma_ep *ep = container_of(work, struct rpcrdma_ep, re_worker);
 
+	rpcrdma_mrs_destroy(ep);
+
 	if (ep->re_id->qp) {
 		rdma_destroy_qp(ep->re_id);
 		ep->re_id->qp = NULL;
@@ -393,6 +396,11 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->re_xprt = &r_xprt->rx_xprt;
 	kref_init(&ep->re_kref);
 
+	spin_lock_init(&ep->re_mr_lock);
+	INIT_WORK(&ep->re_refresh_worker, rpcrdma_mr_refresh_worker);
+	INIT_LIST_HEAD(&ep->re_mrs);
+	INIT_LIST_HEAD(&ep->re_all_mrs);
+
 	id = rpcrdma_create_id(r_xprt, ep);
 	if (IS_ERR(id)) {
 		kfree(ep);
@@ -575,7 +583,6 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_xprt_drain(r_xprt);
 	rpcrdma_reps_unmap(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
-	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 
 	r_xprt->rx_ep = NULL;
@@ -749,7 +756,6 @@ static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 static void
 rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct ib_device *device = ep->re_id->device;
 	unsigned int count;
@@ -764,16 +770,16 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 		if (!mr)
 			break;
 
-		rc = frwr_mr_init(r_xprt, mr);
+		rc = frwr_mr_init(ep, mr);
 		if (rc) {
 			kfree(mr);
 			break;
 		}
 
-		spin_lock(&buf->rb_lock);
-		rpcrdma_mr_push(mr, &buf->rb_mrs);
-		list_add(&mr->mr_all, &buf->rb_all_mrs);
-		spin_unlock(&buf->rb_lock);
+		spin_lock(&ep->re_mr_lock);
+		rpcrdma_mr_push(mr, &ep->re_mrs);
+		list_add(&mr->mr_all, &ep->re_all_mrs);
+		spin_unlock(&ep->re_mr_lock);
 	}
 
 	r_xprt->rx_stats.mrs_allocated += count;
@@ -783,10 +789,11 @@ rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt)
 static void
 rpcrdma_mr_refresh_worker(struct work_struct *work)
 {
-	struct rpcrdma_buffer *buf = container_of(work, struct rpcrdma_buffer,
-						  rb_refresh_worker);
-	struct rpcrdma_xprt *r_xprt = container_of(buf, struct rpcrdma_xprt,
-						   rx_buf);
+	struct rpcrdma_ep *ep = container_of(work, struct rpcrdma_ep,
+					     re_refresh_worker);
+	struct rpcrdma_xprt *r_xprt = container_of(ep->re_xprt,
+						   struct rpcrdma_xprt,
+						   rx_xprt);
 
 	rpcrdma_mrs_create(r_xprt);
 	xprt_write_space(&r_xprt->rx_xprt);
@@ -799,7 +806,6 @@ rpcrdma_mr_refresh_worker(struct work_struct *work)
  */
 void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 
 	/* If there is no underlying connection, it's no use
@@ -807,7 +813,7 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
 	 */
 	if (ep->re_connect_status != 1)
 		return;
-	queue_work(system_highpri_wq, &buf->rb_refresh_worker);
+	queue_work(system_highpri_wq, &ep->re_refresh_worker);
 }
 
 /**
@@ -1044,9 +1050,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 
 	buf->rb_bc_srv_max_requests = 0;
 	spin_lock_init(&buf->rb_lock);
-	INIT_LIST_HEAD(&buf->rb_mrs);
-	INIT_LIST_HEAD(&buf->rb_all_mrs);
-	INIT_WORK(&buf->rb_refresh_worker, rpcrdma_mr_refresh_worker);
 
 	INIT_LIST_HEAD(&buf->rb_send_bufs);
 	INIT_LIST_HEAD(&buf->rb_allreqs);
@@ -1085,11 +1088,11 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 	list_del(&req->rl_all);
 
 	while ((mr = rpcrdma_mr_pop(&req->rl_free_mrs))) {
-		struct rpcrdma_buffer *buf = &mr->mr_xprt->rx_buf;
+		struct rpcrdma_ep *ep = mr->mr_ep;
 
-		spin_lock(&buf->rb_lock);
+		spin_lock(&ep->re_mr_lock);
 		list_del(&mr->mr_all);
-		spin_unlock(&buf->rb_lock);
+		spin_unlock(&ep->re_mr_lock);
 
 		frwr_mr_release(mr);
 	}
@@ -1102,31 +1105,28 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 
 /**
  * rpcrdma_mrs_destroy - Release all of a transport's MRs
- * @r_xprt: controlling transport instance
+ * @ep: controlling transport instance
  *
- * Relies on caller holding the transport send lock to protect
- * removing mr->mr_list from req->rl_free_mrs safely.
  */
-static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt)
+static void rpcrdma_mrs_destroy(struct rpcrdma_ep *ep)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_mr *mr;
 
-	cancel_work_sync(&buf->rb_refresh_worker);
+	cancel_work_sync(&ep->re_refresh_worker);
 
-	spin_lock(&buf->rb_lock);
-	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
+	spin_lock(&ep->re_mr_lock);
+	while ((mr = list_first_entry_or_null(&ep->re_all_mrs,
 					      struct rpcrdma_mr,
 					      mr_all)) != NULL) {
 		list_del(&mr->mr_list);
 		list_del(&mr->mr_all);
-		spin_unlock(&buf->rb_lock);
+		spin_unlock(&ep->re_mr_lock);
 
 		frwr_mr_release(mr);
 
-		spin_lock(&buf->rb_lock);
+		spin_lock(&ep->re_mr_lock);
 	}
-	spin_unlock(&buf->rb_lock);
+	spin_unlock(&ep->re_mr_lock);
 }
 
 /**
@@ -1162,12 +1162,12 @@ rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 struct rpcrdma_mr *
 rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct rpcrdma_mr *mr;
 
-	spin_lock(&buf->rb_lock);
-	mr = rpcrdma_mr_pop(&buf->rb_mrs);
-	spin_unlock(&buf->rb_lock);
+	spin_lock(&ep->re_mr_lock);
+	mr = rpcrdma_mr_pop(&ep->re_mrs);
+	spin_unlock(&ep->re_mr_lock);
 	return mr;
 }
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 048d2e329384..ce703b6e3b86 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -96,6 +96,11 @@ struct rpcrdma_ep {
 	unsigned int		re_inline_send;	/* negotiated */
 	unsigned int		re_inline_recv;	/* negotiated */
 
+	spinlock_t		re_mr_lock;
+	struct list_head	re_mrs;
+	struct list_head	re_all_mrs;
+	struct work_struct	re_refresh_worker;
+
 	atomic_t		re_completion_ids;
 
 	char			re_write_pad[XDR_UNIT];
@@ -253,7 +258,7 @@ struct rpcrdma_mr {
 		struct ib_reg_wr	mr_regwr;
 		struct ib_send_wr	mr_invwr;
 	};
-	struct rpcrdma_xprt	*mr_xprt;
+	struct rpcrdma_ep	*mr_ep;
 	u32			mr_handle;
 	u32			mr_length;
 	u64			mr_offset;
@@ -365,7 +370,6 @@ rpcrdma_mr_pop(struct list_head *list)
 struct rpcrdma_buffer {
 	spinlock_t		rb_lock;
 	struct list_head	rb_send_bufs;
-	struct list_head	rb_mrs;
 
 	unsigned long		rb_sc_head;
 	unsigned long		rb_sc_tail;
@@ -373,7 +377,6 @@ struct rpcrdma_buffer {
 	struct rpcrdma_sendctx	**rb_sc_ctxs;
 
 	struct list_head	rb_allreqs;
-	struct list_head	rb_all_mrs;
 	struct list_head	rb_all_reps;
 
 	struct llist_head	rb_free_reps;
@@ -383,8 +386,6 @@ struct rpcrdma_buffer {
 
 	u32			rb_bc_srv_max_requests;
 	u32			rb_bc_max_requests;
-
-	struct work_struct	rb_refresh_worker;
 };
 
 /*
@@ -533,7 +534,7 @@ rpcrdma_data_dir(bool writing)
  */
 void frwr_reset(struct rpcrdma_req *req);
 int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device);
-int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr);
+int frwr_mr_init(struct rpcrdma_ep *ep, struct rpcrdma_mr *mr);
 void frwr_mr_release(struct rpcrdma_mr *mr);
 struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
-- 
2.44.0


