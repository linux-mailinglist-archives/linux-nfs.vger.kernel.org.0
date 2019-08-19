Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 322FE95121
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfHSWtG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:49:06 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40375 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSWtG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:49:06 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so3241378otb.7;
        Mon, 19 Aug 2019 15:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=KtCwL8c69F3COLA77qkJ81XZUTUH1fP6yQHmJ3Q9TRA=;
        b=MHeBxx8V+WLyrABwc4enReMYqD25fNsuHxc0dm7Y9gQJmDMBC71Al3D/tlStuGtmw9
         //noduB2DZg2WQpBltOmImdTJNyfxnnY/RIvKC8enlfVGFRTGFLm787it0psfGeiyXV5
         RWtYCpTDuDoji/lj3f3IqR2mihcQrUr2AjzeBI/+1KEm32JeetDU7FKHrsnqahouf4Kw
         DE3/b0WjTGzzVVRupSFPs9aIEJ+f7TlBbsrlY184GNyrKdfcT3hYYElyhvwsysGA4FV/
         5Yr0ptZGGHfzQOyotWoG7h+lGHgZg565bpCt5cm/LeJ+nxntN1xPt59xwQGg14NqMrA+
         POrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=KtCwL8c69F3COLA77qkJ81XZUTUH1fP6yQHmJ3Q9TRA=;
        b=MnEPUktIRM5EifB2rmQiHCFF1Wh/1xdysCR3wwjTk5McULgqiV3Xnr7W5WqmcsN4jr
         OwmQjDKbXaMdhous3r92eaGuZskBqD0mMl/J4TRuSQcHzuc9FP28N31i4jQ6b/JlukHM
         NoT/vxrMR6WzpoUBuKc1WgRom1YXS5gOGwK+FaDu0yvDet426t+PkMzk1PR1vC0ETteM
         5GUJNWVJAXEMqGDyjX1oCEIkS5UzOwZyn3NvtP0hR6op9uNpVtxhhApzSrAPOSLl1gm5
         RK/Y0+4luatCD0r+aH/ZsHCXltwuaDqq68Rqz4/fqblN+DmCnx4Y4jIEWFm3NOghrICb
         54tw==
X-Gm-Message-State: APjAAAXRiVAze2WwrrNNnVKtUVSwVJeeI1NZv50YqZ1d3l5wOxzFfP5P
        PMzUrXg1IuquLpD2W5ZWQyAm5ItA
X-Google-Smtp-Source: APXvYqwZ3UMVJCPpn0rzGbYSsj7Kb6GIoetc9CZm3vLEQGJZjPL3GJW8as6jvK6tMXL/GZ1jd/vKow==
X-Received: by 2002:a9d:4718:: with SMTP id a24mr1362102otf.12.1566254945124;
        Mon, 19 Aug 2019 15:49:05 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id g93sm6023429otb.39.2019.08.19.15.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:49:04 -0700 (PDT)
Subject: [PATCH v2 17/21] xprtrdma: Use an llist to manage free rpcrdma_reps
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:48:43 -0400
Message-ID: <156625490339.8161.16802609239404263834.stgit@seurat29.1015granger.net>
In-Reply-To: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
References: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

rpcrdma_rep objects are removed from their free list by only a
single thread: the Receive completion handler. Thus that free list
can be converted to an llist, where a single-threaded consumer and
a multi-threaded producer (rpcrdma_buffer_put) can both access the
llist without the need for any serialization.

This eliminates spin lock contention between the Receive completion
handler and rpcrdma_buffer_get, and makes the rep consumer wait-
free.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |  106 ++++++++++++++++++---------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    6 +-
 2 files changed, 53 insertions(+), 59 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 52444c4d1be2..db90083ed35b 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -75,6 +75,7 @@
  * internal functions
  */
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc);
+static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mr_free(struct rpcrdma_mr *mr);
@@ -407,7 +408,6 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_req *req;
-	struct rpcrdma_rep *rep;
 
 	cancel_work_sync(&buf->rb_refresh_worker);
 
@@ -431,8 +431,7 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 	/* The ULP is responsible for ensuring all DMA
 	 * mappings and MRs are gone.
 	 */
-	list_for_each_entry(rep, &buf->rb_recv_bufs, rr_list)
-		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
+	rpcrdma_reps_destroy(buf);
 	list_for_each_entry(req, &buf->rb_allreqs, rl_all) {
 		rpcrdma_regbuf_dma_unmap(req->rl_rdmabuf);
 		rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
@@ -1071,6 +1070,40 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	return NULL;
 }
 
+static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
+{
+	rpcrdma_regbuf_free(rep->rr_rdmabuf);
+	kfree(rep);
+}
+
+static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
+{
+	struct llist_node *node;
+
+	/* Calls to llist_del_first are required to be serialized */
+	node = llist_del_first(&buf->rb_free_reps);
+	if (!node)
+		return NULL;
+	return llist_entry(node, struct rpcrdma_rep, rr_node);
+}
+
+static void rpcrdma_rep_put(struct rpcrdma_buffer *buf,
+			    struct rpcrdma_rep *rep)
+{
+	if (!rep->rr_temp)
+		llist_add(&rep->rr_node, &buf->rb_free_reps);
+	else
+		rpcrdma_rep_destroy(rep);
+}
+
+static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
+{
+	struct rpcrdma_rep *rep;
+
+	while ((rep = rpcrdma_rep_get_locked(buf)) != NULL)
+		rpcrdma_rep_destroy(rep);
+}
+
 /**
  * rpcrdma_buffer_create - Create initial set of req/rep objects
  * @r_xprt: transport instance to (re)initialize
@@ -1106,7 +1139,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	}
 
 	buf->rb_credits = 1;
-	INIT_LIST_HEAD(&buf->rb_recv_bufs);
+	init_llist_head(&buf->rb_free_reps);
 
 	rc = rpcrdma_sendctxs_create(r_xprt);
 	if (rc)
@@ -1118,12 +1151,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	return rc;
 }
 
-static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
-{
-	rpcrdma_regbuf_free(rep->rr_rdmabuf);
-	kfree(rep);
-}
-
 /**
  * rpcrdma_req_destroy - Destroy an rpcrdma_req object
  * @req: unused object to be destroyed
@@ -1182,15 +1209,7 @@ rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 	cancel_work_sync(&buf->rb_refresh_worker);
 
 	rpcrdma_sendctxs_destroy(buf);
-
-	while (!list_empty(&buf->rb_recv_bufs)) {
-		struct rpcrdma_rep *rep;
-
-		rep = list_first_entry(&buf->rb_recv_bufs,
-				       struct rpcrdma_rep, rr_list);
-		list_del(&rep->rr_list);
-		rpcrdma_rep_destroy(rep);
-	}
+	rpcrdma_reps_destroy(buf);
 
 	while (!list_empty(&buf->rb_send_bufs)) {
 		struct rpcrdma_req *req;
@@ -1281,39 +1300,24 @@ rpcrdma_buffer_get(struct rpcrdma_buffer *buffers)
  */
 void rpcrdma_buffer_put(struct rpcrdma_buffer *buffers, struct rpcrdma_req *req)
 {
-	struct rpcrdma_rep *rep = req->rl_reply;
-
+	if (req->rl_reply)
+		rpcrdma_rep_put(buffers, req->rl_reply);
 	req->rl_reply = NULL;
 
 	spin_lock(&buffers->rb_lock);
 	list_add(&req->rl_list, &buffers->rb_send_bufs);
-	if (rep) {
-		if (!rep->rr_temp) {
-			list_add(&rep->rr_list, &buffers->rb_recv_bufs);
-			rep = NULL;
-		}
-	}
 	spin_unlock(&buffers->rb_lock);
-	if (rep)
-		rpcrdma_rep_destroy(rep);
 }
 
-/*
- * Put reply buffers back into pool when not attached to
- * request. This happens in error conditions.
+/**
+ * rpcrdma_recv_buffer_put - Release rpcrdma_rep back to free list
+ * @rep: rep to release
+ *
+ * Used after error conditions.
  */
-void
-rpcrdma_recv_buffer_put(struct rpcrdma_rep *rep)
+void rpcrdma_recv_buffer_put(struct rpcrdma_rep *rep)
 {
-	struct rpcrdma_buffer *buffers = &rep->rr_rxprt->rx_buf;
-
-	if (!rep->rr_temp) {
-		spin_lock(&buffers->rb_lock);
-		list_add(&rep->rr_list, &buffers->rb_recv_bufs);
-		spin_unlock(&buffers->rb_lock);
-	} else {
-		rpcrdma_rep_destroy(rep);
-	}
+	rpcrdma_rep_put(&rep->rr_rxprt->rx_buf, rep);
 }
 
 /* Returns a pointer to a rpcrdma_regbuf object, or NULL.
@@ -1469,22 +1473,10 @@ rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
 
 	/* fast path: all needed reps can be found on the free list */
 	wr = NULL;
-	spin_lock(&buf->rb_lock);
 	while (needed) {
-		rep = list_first_entry_or_null(&buf->rb_recv_bufs,
-					       struct rpcrdma_rep, rr_list);
+		rep = rpcrdma_rep_get_locked(buf);
 		if (!rep)
-			break;
-
-		list_del(&rep->rr_list);
-		rep->rr_recv_wr.next = wr;
-		wr = &rep->rr_recv_wr;
-		--needed;
-	}
-	spin_unlock(&buf->rb_lock);
-
-	while (needed) {
-		rep = rpcrdma_rep_create(r_xprt, temp);
+			rep = rpcrdma_rep_create(r_xprt, temp);
 		if (!rep)
 			break;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 200d075bbe31..bd1befa83d24 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -47,6 +47,7 @@
 #include <linux/atomic.h>		/* atomic_t, etc */
 #include <linux/kref.h>			/* struct kref */
 #include <linux/workqueue.h>		/* struct work_struct */
+#include <linux/llist.h>
 
 #include <rdma/rdma_cm.h>		/* RDMA connection api */
 #include <rdma/ib_verbs.h>		/* RDMA verbs api */
@@ -200,7 +201,7 @@ struct rpcrdma_rep {
 	struct rpc_rqst		*rr_rqst;
 	struct xdr_buf		rr_hdrbuf;
 	struct xdr_stream	rr_stream;
-	struct list_head	rr_list;
+	struct llist_node	rr_node;
 	struct ib_recv_wr	rr_recv_wr;
 };
 
@@ -362,7 +363,6 @@ rpcrdma_mr_pop(struct list_head *list)
 struct rpcrdma_buffer {
 	spinlock_t		rb_lock;
 	struct list_head	rb_send_bufs;
-	struct list_head	rb_recv_bufs;
 	struct list_head	rb_mrs;
 
 	unsigned long		rb_sc_head;
@@ -373,6 +373,8 @@ struct rpcrdma_buffer {
 	struct list_head	rb_allreqs;
 	struct list_head	rb_all_mrs;
 
+	struct llist_head	rb_free_reps;
+
 	u32			rb_max_requests;
 	u32			rb_credits;	/* most recent credit grant */
 

