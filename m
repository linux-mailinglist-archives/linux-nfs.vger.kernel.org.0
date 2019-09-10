Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF23AF01B
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436815AbfIJRFJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 13:05:09 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40900 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436760AbfIJRFJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Sep 2019 13:05:09 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so39137070iof.7
        for <linux-nfs@vger.kernel.org>; Tue, 10 Sep 2019 10:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jujwM56kPgDRllqGRmd8xDdso1+OBvApNmETfxOr8+s=;
        b=pSKo6xNBquBboxVi7W+1k/A3HJGqxjEPvrY3yksSogtL81YSr5AW1mI/m4qv3ghjWj
         CnjgrTfeY3lkmhj+VCUI+FFooWJAE57TdZ5hcNMAmSQq/XVa9Y9a4f5bFaLHXDEy92sY
         bQl+/BXh/IdlRYBNkkVGs2tb6jumiLroAyoHzz3Eb5cqIZv18kECOn9ZHRvk+McKB99x
         rUAk7r+BJ5NNx1lgkZ9Z0Vk1YD9Dxb8Y3QpplgnNlt/KjUEGq+r5i/XkgK+rWsR63yxh
         4nmytZvtFn1eSzduLwOinOB83l3x/sByPr/oNkiOryuIzlTJMSe+U9aI5XZdx2lDyt/f
         2E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jujwM56kPgDRllqGRmd8xDdso1+OBvApNmETfxOr8+s=;
        b=IsplJEeK0P4XQEvJSPOtSHCyD72adiHyHYYtvntLDgJ+eAKjvN2DD9cj5Fp9+inz9N
         CpwDDq6qY/fYAYQ3cSz4je59ajlHXtx1soxEUuUO6shEpeRBgwCIZ/EszldZNS/x1Fad
         EKMZBzsscsNCH9nntj7oK1xBPstHjqk5VfrRm6ccW+N+Enq6+7OzLUh4pxiIk0Y7jFbZ
         9u9HyjMph/JamGOBjcZNGy3tzqTpxfw3ArhLMafRN2Dck0G2qT3Ar3pL9yHbZLG/8n4q
         WKz+XcE8nr+GTFdyGZt0CM8WWb3QSCoBBcf+X2LAJRbj6N3g4TjOp1RKFSB6/X7FKH+b
         RCnw==
X-Gm-Message-State: APjAAAVXBr7Dk3WnYKhGoFRUY7cZetYHYkorfNsFCU4olRcJzFmKbINs
        S1dK2CWSTfjbiezoSVXtq1XNm37mPQ==
X-Google-Smtp-Source: APXvYqwZv26OugVwhGtZ9Mk1ZBQj7NIDhsE0UZCOu6YynnyaUS8Jq2/p7YDznHaApeNobUFQFDH5TQ==
X-Received: by 2002:a6b:9107:: with SMTP id t7mr32784916iod.150.1568135105949;
        Tue, 10 Sep 2019 10:05:05 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id e5sm5661417ioh.44.2019.09.10.10.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 10:05:05 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Dequeue the request from the receive queue while we're re-encoding
Date:   Tue, 10 Sep 2019 13:01:35 -0400
Message-Id: <20190910170135.104865-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we dequeue the request from the transport receive queue
while we're re-encoding to prevent issues like use-after-free when
we release the bvec.

Fixes: 7536908982047 ("SUNRPC: Ensure the bvecs are reset when we re-encode...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20+
---
v2: Ensure we also reset req->rq_reply_bytes_recvd in rpc_xdr_encode()

 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/clnt.c           |  6 ++---
 net/sunrpc/xprt.c           | 54 +++++++++++++++++++++----------------
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 13e108bcc9eb..d783e15ba898 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -352,6 +352,7 @@ bool			xprt_prepare_transmit(struct rpc_task *task);
 void			xprt_request_enqueue_transmit(struct rpc_task *task);
 void			xprt_request_enqueue_receive(struct rpc_task *task);
 void			xprt_request_wait_receive(struct rpc_task *task);
+void			xprt_request_dequeue_xprt(struct rpc_task *task);
 bool			xprt_request_need_retransmit(struct rpc_task *task);
 void			xprt_transmit(struct rpc_task *task);
 void			xprt_end_transmit(struct rpc_task *task);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a07b516e503a..7a75f34ad393 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1862,6 +1862,7 @@ rpc_xdr_encode(struct rpc_task *task)
 		     req->rq_rbuffer,
 		     req->rq_rcvsize);
 
+	req->rq_reply_bytes_recvd = 0;
 	req->rq_snd_buf.head[0].iov_len = 0;
 	xdr_init_encode(&xdr, &req->rq_snd_buf,
 			req->rq_snd_buf.head[0].iov_base, req);
@@ -1881,6 +1882,8 @@ call_encode(struct rpc_task *task)
 	if (!rpc_task_need_encode(task))
 		goto out;
 	dprint_status(task);
+	/* Dequeue task from the receive queue while we're encoding */
+	xprt_request_dequeue_xprt(task);
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
 	rpc_xdr_encode(task);
 	/* Did the encode result in an error condition? */
@@ -2518,9 +2521,6 @@ call_decode(struct rpc_task *task)
 		return;
 	case -EAGAIN:
 		task->tk_status = 0;
-		xdr_free_bvec(&req->rq_rcv_buf);
-		req->rq_reply_bytes_recvd = 0;
-		req->rq_rcv_buf.len = 0;
 		if (task->tk_client->cl_discrtry)
 			xprt_conditional_disconnect(req->rq_xprt,
 						    req->rq_connect_cookie);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2e71f5455c6c..20631d64312c 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1323,6 +1323,36 @@ xprt_request_dequeue_transmit(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 }
 
+/**
+ * xprt_request_dequeue_xprt - remove a task from the transmit+receive queue
+ * @task: pointer to rpc_task
+ *
+ * Remove a task from the transmit and receive queues, and ensure that
+ * it is not pinned by the receive work item.
+ */
+void
+xprt_request_dequeue_xprt(struct rpc_task *task)
+{
+	struct rpc_rqst	*req = task->tk_rqstp;
+	struct rpc_xprt *xprt = req->rq_xprt;
+
+	if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate) ||
+	    test_bit(RPC_TASK_NEED_RECV, &task->tk_runstate) ||
+	    xprt_is_pinned_rqst(req)) {
+		spin_lock(&xprt->queue_lock);
+		xprt_request_dequeue_transmit_locked(task);
+		xprt_request_dequeue_receive_locked(task);
+		while (xprt_is_pinned_rqst(req)) {
+			set_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
+			spin_unlock(&xprt->queue_lock);
+			xprt_wait_on_pinned_rqst(req);
+			spin_lock(&xprt->queue_lock);
+			clear_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
+		}
+		spin_unlock(&xprt->queue_lock);
+	}
+}
+
 /**
  * xprt_request_prepare - prepare an encoded request for transport
  * @req: pointer to rpc_rqst
@@ -1747,28 +1777,6 @@ void xprt_retry_reserve(struct rpc_task *task)
 	xprt_do_reserve(xprt, task);
 }
 
-static void
-xprt_request_dequeue_all(struct rpc_task *task, struct rpc_rqst *req)
-{
-	struct rpc_xprt *xprt = req->rq_xprt;
-
-	if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate) ||
-	    test_bit(RPC_TASK_NEED_RECV, &task->tk_runstate) ||
-	    xprt_is_pinned_rqst(req)) {
-		spin_lock(&xprt->queue_lock);
-		xprt_request_dequeue_transmit_locked(task);
-		xprt_request_dequeue_receive_locked(task);
-		while (xprt_is_pinned_rqst(req)) {
-			set_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
-			spin_unlock(&xprt->queue_lock);
-			xprt_wait_on_pinned_rqst(req);
-			spin_lock(&xprt->queue_lock);
-			clear_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
-		}
-		spin_unlock(&xprt->queue_lock);
-	}
-}
-
 /**
  * xprt_release - release an RPC request slot
  * @task: task which is finished with the slot
@@ -1788,7 +1796,7 @@ void xprt_release(struct rpc_task *task)
 	}
 
 	xprt = req->rq_xprt;
-	xprt_request_dequeue_all(task, req);
+	xprt_request_dequeue_xprt(task);
 	spin_lock(&xprt->transport_lock);
 	xprt->ops->release_xprt(xprt, task);
 	if (xprt->ops->release_request)
-- 
2.21.0

