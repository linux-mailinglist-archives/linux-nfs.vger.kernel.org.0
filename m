Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F874835E9
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Aug 2019 17:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfHFPzE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 6 Aug 2019 11:55:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36595 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732048AbfHFPzD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 6 Aug 2019 11:55:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id c15so11901372oic.3;
        Tue, 06 Aug 2019 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eP1zYTlfrsy+xX4WBaVOK7VHw4uG+pdTMDQy9KlZtP0=;
        b=IZ/+fiGl3+90y9IoUBqiYYrZ/mq1SkFR3FYiaDiFlCetAx+pC7mYAMfUe5qhfpORxr
         8z8UA9C/6LxEnXpmC9zXnUYsLftvw7n7byn1EMUQ6C4/TK3AwKmXF3icD86Tug6KZgHm
         6Nv6IQsQ4Ib7qWnXvk4Vcjuw5IGAEz37gwCBv/oMnLZPeR8l6IdWxC5hUqCY7+bhC4Lj
         m1UqYTevROQJ1WmYFsRfpUjWE5FpziVbjnmU6OG0O/uzHXnRGRdn6ryMbPhEAY8HsuWM
         sLLqpgsM5oP9C2jY0z7D9QY6QiqKO63c+SweJxDd5p/8cl/bqCaxDknmG3r6e+19DZiu
         PDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eP1zYTlfrsy+xX4WBaVOK7VHw4uG+pdTMDQy9KlZtP0=;
        b=C9Enn1OKLmntNIT8zZ42CgpUdp33An0UZvpRdtIEiG8JWmc0kgfwqVE9AaLEVLV6r6
         DHDVwj02Dd4UCS6vkiVsYlZnsCn5I7m3RhAtXtczbZtwAkkki+88xp3j8QdBLgyqHSLT
         RCfV3IkZKJsTvqcpuiGYQwYlBb7HhnZaz3I0ejNHto/L2EMnc6XrCeynfd8DL4VQxNnX
         7ELl8DxdfuGtd5XmQTPqU2yadMUrczmSzgn5OOm6Bo6hkaRxjGytMdCYeqi1fzpP4j/I
         7UvJHqt8Mwec79bBW6Rzj6HTlhc/rLXddRb5Jyxxr+81TSozk1jvhVH/fbmuZtwcjFp/
         qYIQ==
X-Gm-Message-State: APjAAAXRYedjLiRrIQOep9mqMwFS1ydznrf3e1evvQpHdDd5WXoeXYTp
        wFsAq2tw2VoUr3XgHgBfMZZUv9Tz
X-Google-Smtp-Source: APXvYqwRyZfCQQFwFqRFDRLD5V3y6xg9Yy5dGjrscxUq9AY07v2pjdMMhKxCwAqijlJ6ur2/joyZBw==
X-Received: by 2002:a02:3f1d:: with SMTP id d29mr5037822jaa.116.1565106902108;
        Tue, 06 Aug 2019 08:55:02 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y17sm66209769ioa.40.2019.08.06.08.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 08:55:01 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x76Ft0xX011553;
        Tue, 6 Aug 2019 15:55:00 GMT
Subject: [PATCH v1 14/18] xprtrdma: Use an llist to manage free rpcrdma_reps
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 06 Aug 2019 11:55:00 -0400
Message-ID: <20190806155500.9529.30933.stgit@manet.1015granger.net>
In-Reply-To: <20190806155246.9529.14571.stgit@manet.1015granger.net>
References: <20190806155246.9529.14571.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
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
index 15a77b3..4112b8a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -74,6 +74,7 @@
  * internal functions
  */
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_sendctx *sc);
+static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mr_free(struct rpcrdma_mr *mr);
@@ -406,7 +407,6 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_req *req;
-	struct rpcrdma_rep *rep;
 
 	cancel_work_sync(&buf->rb_refresh_worker);
 
@@ -430,8 +430,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	/* The ULP is responsible for ensuring all DMA
 	 * mappings and MRs are gone.
 	 */
-	list_for_each_entry(rep, &buf->rb_recv_bufs, rr_list)
-		rpcrdma_regbuf_dma_unmap(rep->rr_rdmabuf);
+	rpcrdma_reps_destroy(buf);
 	list_for_each_entry(req, &buf->rb_allreqs, rl_all) {
 		rpcrdma_regbuf_dma_unmap(req->rl_rdmabuf);
 		rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
@@ -1063,6 +1062,40 @@ static struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
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
@@ -1098,7 +1131,7 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	}
 
 	buf->rb_credits = 1;
-	INIT_LIST_HEAD(&buf->rb_recv_bufs);
+	init_llist_head(&buf->rb_free_reps);
 
 	rc = rpcrdma_sendctxs_create(r_xprt);
 	if (rc)
@@ -1110,12 +1143,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
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
@@ -1174,15 +1201,7 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
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
@@ -1273,39 +1292,24 @@ struct rpcrdma_req *
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
@@ -1461,22 +1465,10 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 
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
index b388bb4..338da5f 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -47,6 +47,7 @@
 #include <linux/atomic.h>		/* atomic_t, etc */
 #include <linux/kref.h>			/* struct kref */
 #include <linux/workqueue.h>		/* struct work_struct */
+#include <linux/llist.h>
 
 #include <rdma/rdma_cm.h>		/* RDMA connection api */
 #include <rdma/ib_verbs.h>		/* RDMA verbs api */
@@ -205,7 +206,7 @@ struct rpcrdma_rep {
 	struct rpc_rqst		*rr_rqst;
 	struct xdr_buf		rr_hdrbuf;
 	struct xdr_stream	rr_stream;
-	struct list_head	rr_list;
+	struct llist_node	rr_node;
 	struct ib_recv_wr	rr_recv_wr;
 };
 
@@ -367,7 +368,6 @@ struct rpcrdma_req {
 struct rpcrdma_buffer {
 	spinlock_t		rb_lock;
 	struct list_head	rb_send_bufs;
-	struct list_head	rb_recv_bufs;
 	struct list_head	rb_mrs;
 
 	unsigned long		rb_sc_head;
@@ -378,6 +378,8 @@ struct rpcrdma_buffer {
 	struct list_head	rb_allreqs;
 	struct list_head	rb_all_mrs;
 
+	struct llist_head	rb_free_reps;
+
 	u32			rb_max_requests;
 	u32			rb_credits;	/* most recent credit grant */
 

