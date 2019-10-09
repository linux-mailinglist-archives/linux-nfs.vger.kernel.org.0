Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95519D14EE
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 19:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731788AbfJIRHw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 13:07:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44772 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731173AbfJIRHv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 13:07:51 -0400
Received: by mail-io1-f68.google.com with SMTP id w12so6586858iol.11;
        Wed, 09 Oct 2019 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=yZ4qkD9pdlXqRniqBictIawhNMxJa12wZcHix94iZ9Y=;
        b=fgH4sIMQCyYnpOhQfmxmgSIZUNKL9VS184s0VZrIhA2jCpQG4dgcI0DI1pASrJgf3d
         SY2Ca+R4kDyDGnetnER91VQ8sgEU/xz4+1GKQyuQug3GLiQMYRScV5NnMq9wu/jc8isH
         PcnE7WgfgUYN4JLkN4uHQUt5t9FhY6Ry2CgopgN1aMzVnXdOejUiTEUOTN4h/Ev5f5oq
         Jlv3mXcJUSlo58RXflK4BKDpwy/bSqdkVH5EQ5puslu/vFyzVoPOIstBMAwqUDJwk7Ff
         xQCrD3MbuiWH13eFW+MRI+yn9J1rdRvJ36O3zTaH8yQpM8RhHjkSfZqGxKzAnX1fRTBz
         hoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=yZ4qkD9pdlXqRniqBictIawhNMxJa12wZcHix94iZ9Y=;
        b=NXTH97qysP9amLCG6WhrWslKOGD4lfqnBfYhzwepAMKb7dmd4axrUSYZHGvr3hP5oK
         WPide1g7LwFdX8/6+uGuRnAMBOKVwyJdUIUNAdVhGbvJdyM3Xx/EztDDZG+sRZIuAEpN
         N/2lMNsykJlFilV6mUDSGo+3OSSppnFww0u+Zc+rMYw0O81LKYASi7Upaga3ALPiaBHV
         hzUMkZk79Qr4cfxnnVfA30M5XJ1MsPx6uYXlFSGIEckfeZMK+37mjA/ryqn8wRi+la23
         6pRAXQds2IMnZxlTtUxcbtTaDKk1PvEuiauA4+rTU6YlsDVYjEZ6ll6jtdc1LsjY3XfN
         rukA==
X-Gm-Message-State: APjAAAXZIPLqBk0AqHU0dLMFrDAkasABys8BodopfMqv/FygsLyTkh5W
        8U8E++VGBsE3bitfh8aJixAfc7JL
X-Google-Smtp-Source: APXvYqxgN1Kw+SKUYJUXRgHpQ10Yn3Mz1WqDy/1szHU8RXk54G8/Oa4MhL3murbN2CyNmQvCte0QGw==
X-Received: by 2002:a6b:6418:: with SMTP id t24mr4393761iog.185.1570640870345;
        Wed, 09 Oct 2019 10:07:50 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 128sm1598065iox.35.2019.10.09.10.07.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 10:07:49 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99H7mTA001504;
        Wed, 9 Oct 2019 17:07:48 GMT
Subject: [PATCH v1 6/6] xprtrdma: Manage MRs in context of a single
 connection
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 13:07:48 -0400
Message-ID: <20191009170748.2978.97255.stgit@manet.1015granger.net>
In-Reply-To: <20191009170721.2978.128.stgit@manet.1015granger.net>
References: <20191009170721.2978.128.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

MRs are now allocated on demand so we can safely throw them away on
disconnect. This way an idle transport can disconnect and it won't
pin hardware MR resources.

Two additional changes:

- Now that all MRs are destroyed on disconnect, there's no need to
  check during header marshaling if a req has MRs to recycle. Each
  req is sent only once per connection, and now rl_registered is
  guaranteed to be empty when rpcrdma_marshal_req is invoked.

- Because MRs are now destroyed in a WQ_MEM_RECLAIM context, they
  also must be allocated in a WQ_MEM_RECLAIM context. This reduces
  the likelihood that device driver memory allocation will trigger
  memory reclaim during NFS writeback.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c  |   24 +--------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |    9 +-----
 net/sunrpc/xprtrdma/verbs.c     |   62 +++++++++++++++++++++++----------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +
 4 files changed, 40 insertions(+), 57 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 9901a81..37ba82d 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -36,8 +36,8 @@
  * connect worker from running concurrently.
  *
  * When the underlying transport disconnects, MRs that are in flight
- * are flushed and are likely unusable. Thus all flushed MRs are
- * destroyed. New MRs are created on demand.
+ * are flushed and are likely unusable. Thus all MRs are destroyed.
+ * New MRs are created on demand.
  */
 
 #include <linux/sunrpc/rpc_rdma.h>
@@ -119,20 +119,6 @@ static void frwr_mr_recycle(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	frwr_mr_recycle(mr->mr_xprt, mr);
 }
 
-/* frwr_recycle - Discard MRs
- * @req: request to reset
- *
- * Used after a reconnect. These MRs could be in flight, we can't
- * tell. Safe thing to do is release them.
- */
-void frwr_recycle(struct rpcrdma_req *req)
-{
-	struct rpcrdma_mr *mr;
-
-	while ((mr = rpcrdma_mr_pop(&req->rl_registered)))
-		frwr_mr_recycle(mr->mr_xprt, mr);
-}
-
 /* frwr_reset - Place MRs back on the free list
  * @req: request to reset
  *
@@ -166,9 +152,6 @@ int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr)
 	struct ib_mr *frmr;
 	int rc;
 
-	/* NB: ib_alloc_mr and device drivers typically allocate
-	 *     memory with GFP_KERNEL.
-	 */
 	frmr = ib_alloc_mr(ia->ri_pd, ia->ri_mrtype, depth);
 	if (IS_ERR(frmr))
 		goto out_mr_err;
@@ -440,9 +423,6 @@ int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req)
 		post_wr = &frwr->fr_regwr.wr;
 	}
 
-	/* If ib_post_send fails, the next ->send_request for
-	 * @req will queue these MRs for recovery.
-	 */
 	return ib_post_send(ia->ri_id->qp, post_wr, NULL);
 }
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 7c125e6..7b13582 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -363,8 +363,7 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
 out_getmr_err:
 	trace_xprtrdma_nomrs(req);
 	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
-	if (r_xprt->rx_ep.rep_connected != -ENODEV)
-		schedule_work(&r_xprt->rx_buf.rb_refresh_worker);
+	rpcrdma_mrs_refresh(r_xprt);
 	return ERR_PTR(-EAGAIN);
 }
 
@@ -863,12 +862,6 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 		rtype = rpcrdma_areadch;
 	}
 
-	/* If this is a retransmit, discard previously registered
-	 * chunks. Very likely the connection has been replaced,
-	 * so these registrations are invalid and unusable.
-	 */
-	frwr_recycle(req);
-
 	/* This implementation supports the following combinations
 	 * of chunk lists in one RPC-over-RDMA Call message:
 	 *
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 82361e7..c79d862 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -78,7 +78,7 @@
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf);
 static void rpcrdma_mrs_create(struct rpcrdma_xprt *r_xprt);
-static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf);
+static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt);
 static struct rpcrdma_regbuf *
 rpcrdma_regbuf_alloc(size_t size, enum dma_data_direction direction,
 		     gfp_t flags);
@@ -407,8 +407,6 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_req *req;
 
-	cancel_work_sync(&buf->rb_refresh_worker);
-
 	/* This is similar to rpcrdma_ep_destroy, but:
 	 * - Don't cancel the connect worker.
 	 * - Don't call rpcrdma_ep_disconnect, which waits
@@ -435,7 +433,7 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 		rpcrdma_regbuf_dma_unmap(req->rl_sendbuf);
 		rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
 	}
-	rpcrdma_mrs_destroy(buf);
+	rpcrdma_mrs_destroy(r_xprt);
 	ib_dealloc_pd(ia->ri_pd);
 	ia->ri_pd = NULL;
 
@@ -628,8 +626,6 @@ static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt,
 		pr_err("rpcrdma: rdma_create_qp returned %d\n", err);
 		goto out3;
 	}
-
-	rpcrdma_mrs_create(r_xprt);
 	return 0;
 
 out3:
@@ -703,7 +699,6 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 	memcpy(&qp_init_attr, &ep->rep_attr, sizeof(qp_init_attr));
 	switch (ep->rep_connected) {
 	case 0:
-		dprintk("RPC:       %s: connecting...\n", __func__);
 		rc = rdma_create_qp(ia->ri_id, ia->ri_pd, &qp_init_attr);
 		if (rc) {
 			rc = -ENETUNREACH;
@@ -741,7 +736,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 		goto out;
 	}
 
-	dprintk("RPC:       %s: connected\n", __func__);
+	rpcrdma_mrs_create(r_xprt);
 
 out:
 	if (rc)
@@ -756,11 +751,8 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
  * @ep: endpoint to disconnect
  * @ia: associated interface adapter
  *
- * This is separate from destroy to facilitate the ability
- * to reconnect without recreating the endpoint.
- *
- * This call is not reentrant, and must not be made in parallel
- * on the same endpoint.
+ * Caller serializes. Either the transport send lock is held,
+ * or we're being called to destroy the transport.
  */
 void
 rpcrdma_ep_disconnect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
@@ -780,6 +772,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 
 	rpcrdma_xprt_drain(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
+	rpcrdma_mrs_destroy(r_xprt);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -987,6 +980,28 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 }
 
 /**
+ * rpcrdma_mrs_refresh - Wake the MR refresh worker
+ * @r_xprt: controlling transport instance
+ *
+ */
+void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
+{
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+
+	/* If there is no underlying device, it's no use to
+	 * wake the refresh worker.
+	 */
+	if (ep->rep_connected != -ENODEV) {
+		/* The work is scheduled on a WQ_MEM_RECLAIM
+		 * workqueue in order to prevent MR allocation
+		 * from recursing into NFS during direct reclaim.
+		 */
+		queue_work(xprtiod_workqueue, &buf->rb_refresh_worker);
+	}
+}
+
+/**
  * rpcrdma_req_create - Allocate an rpcrdma_req object
  * @r_xprt: controlling r_xprt
  * @size: initial size, in bytes, of send and receive buffers
@@ -1145,8 +1160,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	INIT_LIST_HEAD(&buf->rb_all_mrs);
 	INIT_WORK(&buf->rb_refresh_worker, rpcrdma_mr_refresh_worker);
 
-	rpcrdma_mrs_create(r_xprt);
-
 	INIT_LIST_HEAD(&buf->rb_send_bufs);
 	INIT_LIST_HEAD(&buf->rb_allreqs);
 
@@ -1177,8 +1190,8 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
  * rpcrdma_req_destroy - Destroy an rpcrdma_req object
  * @req: unused object to be destroyed
  *
- * This function assumes that the caller prevents concurrent device
- * unload and transport tear-down.
+ * Relies on caller holding the transport send lock to protect
+ * removing req->rl_all from buf->rb_all_reqs safely.
  */
 void rpcrdma_req_destroy(struct rpcrdma_req *req)
 {
@@ -1204,17 +1217,18 @@ void rpcrdma_req_destroy(struct rpcrdma_req *req)
 
 /**
  * rpcrdma_mrs_destroy - Release all of a transport's MRs
- * @buf: controlling buffer instance
+ * @r_xprt: controlling transport instance
  *
  * Relies on caller holding the transport send lock to protect
  * removing mr->mr_list from req->rl_free_mrs safely.
  */
-static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
+static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_xprt *r_xprt = container_of(buf, struct rpcrdma_xprt,
-						   rx_buf);
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_mr *mr;
 
+	cancel_work_sync(&buf->rb_refresh_worker);
+
 	spin_lock(&buf->rb_lock);
 	while ((mr = list_first_entry_or_null(&buf->rb_all_mrs,
 					      struct rpcrdma_mr,
@@ -1224,10 +1238,10 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 		spin_unlock(&buf->rb_lock);
 
 		frwr_release_mr(mr);
+
 		spin_lock(&buf->rb_lock);
 	}
 	spin_unlock(&buf->rb_lock);
-	r_xprt->rx_stats.mrs_allocated = 0;
 }
 
 /**
@@ -1241,8 +1255,6 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
-	cancel_work_sync(&buf->rb_refresh_worker);
-
 	rpcrdma_sendctxs_destroy(buf);
 	rpcrdma_reps_destroy(buf);
 
@@ -1254,8 +1266,6 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_buffer *buf)
 		list_del(&req->rl_list);
 		rpcrdma_req_destroy(req);
 	}
-
-	rpcrdma_mrs_destroy(buf);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 2f89cfc..a7ef965 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -488,6 +488,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt, size_t size,
 
 struct rpcrdma_mr *rpcrdma_mr_get(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_mr_put(struct rpcrdma_mr *mr);
+void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt);
 
 static inline void
 rpcrdma_mr_recycle(struct rpcrdma_mr *mr)
@@ -543,7 +544,6 @@ static inline bool rpcrdma_regbuf_dma_map(struct rpcrdma_xprt *r_xprt,
 /* Memory registration calls xprtrdma/frwr_ops.c
  */
 bool frwr_is_supported(struct ib_device *device);
-void frwr_recycle(struct rpcrdma_req *req);
 void frwr_reset(struct rpcrdma_req *req);
 int frwr_open(struct rpcrdma_ia *ia, struct rpcrdma_ep *ep);
 int frwr_init_mr(struct rpcrdma_ia *ia, struct rpcrdma_mr *mr);

