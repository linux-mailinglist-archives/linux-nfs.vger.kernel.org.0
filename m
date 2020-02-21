Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BA41689AE
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBUWA3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:29 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46410 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUWA2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:28 -0500
Received: by mail-yw1-f67.google.com with SMTP id z141so1770105ywd.13;
        Fri, 21 Feb 2020 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=nwZ5hFs2I6P+nhTXyWL1rM9kfmUlXzT4m+peBPuLd9c=;
        b=jN9WkBoL8eje+BL1EMgrsYatnrt0YhSISTgy9wK2AXjPZmL4DcPNrT14GSDgEtZ1op
         FT01AR4R8lJgoviBwcO8kSwAvEkFs4FRSNAqhBAERBztcN4PqjbRTohzmKDcaqYRAtsq
         nKiL77jY1+A+mcdABNhp0E1m6eAK80SBs8JBRA05vBUC6c1VhVjsexwQDnzqYRjtSF3t
         7rrGw41Y/yafxeSJeUZfpKlsJ5y2H8Ng+CaK+jzjjyG/YMBmO5wsuYiiQCeU1+dN5o1r
         3MiGm6IY0iz4TlUlJnxz+zX4eau0JqqvdkCHeNY/1s6p7ufC0vpD3gAQHk26wdAMLmCx
         BZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=nwZ5hFs2I6P+nhTXyWL1rM9kfmUlXzT4m+peBPuLd9c=;
        b=fQHcrEjDNQYBNtbbk1lnDmqbVWrtwZFv/y7v48VCrE1VduYeIzI3pECdFJMlLIe8+g
         ioqJ0sEY+uTCcQ7RaTCzAGnKrVKjMtKtHBvJ9WeYWEln3Q+qJeb1blXCTvq8XvPZg3v1
         SvCe5HQdJt83VJHANTG9jXK33/MC3iFiLuzEu0F4ISTudq6hcR5U4mqlb7iUqatzje0+
         HSy1aHmtBFbmLm/9gwuslWR7vPhTV7aMqqhe07JgnLMo62EsHBzqvsZCX+IlrhIhU1yc
         dCIcecpgImLOBn6J4f37IwH5nL+RFbQuAJWqVqfRRffTYq/roQffLvG7HEmrK4xA0SKd
         LQxQ==
X-Gm-Message-State: APjAAAWUphshRyo9P9glIwk/KNuUddik28GF2FKUSjNqeSrmhO8RMI+r
        ybTa/BRCjGTimbvzSK0Mpqx5Va+n
X-Google-Smtp-Source: APXvYqzA9ouZ1e2rJvf43naah9hDn0IwKRdUxaOCW14rp9yBu5PHAKkATW+/aIft5fPXnDrx8vLE2w==
X-Received: by 2002:a81:49d4:: with SMTP id w203mr29117266ywa.377.1582322424393;
        Fri, 21 Feb 2020 14:00:24 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c21sm1806232ywb.71.2020.02.21.14.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:24 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0N2R018985;
        Fri, 21 Feb 2020 22:00:23 GMT
Subject: [PATCH v1 03/11] xprtrdma: Clean up the post_send path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:23 -0500
Message-ID: <20200221220023.2072.57646.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: Simplify the synopses of functions in the post_send path
by combining the struct rpcrdma_ia and struct rpcrdma_ep arguments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/backchannel.c |    2 +-
 net/sunrpc/xprtrdma/frwr_ops.c    |   14 +++++++++-----
 net/sunrpc/xprtrdma/transport.c   |    2 +-
 net/sunrpc/xprtrdma/verbs.c       |   13 +++++--------
 net/sunrpc/xprtrdma/xprt_rdma.h   |    5 ++---
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/xprtrdma/backchannel.c b/net/sunrpc/xprtrdma/backchannel.c
index 1a0ae0c61353..4b43910a6ed2 100644
--- a/net/sunrpc/xprtrdma/backchannel.c
+++ b/net/sunrpc/xprtrdma/backchannel.c
@@ -115,7 +115,7 @@ int xprt_rdma_bc_send_reply(struct rpc_rqst *rqst)
 	if (rc < 0)
 		goto failed_marshal;
 
-	if (rpcrdma_ep_post(&r_xprt->rx_ia, &r_xprt->rx_ep, req))
+	if (rpcrdma_post_sends(r_xprt, req))
 		goto drop_connection;
 	return 0;
 
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index f161be259997..1f34aa49679c 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -374,18 +374,22 @@ static void frwr_wc_fastreg(struct ib_cq *cq, struct ib_wc *wc)
 }
 
 /**
- * frwr_send - post Send WR containing the RPC Call message
- * @ia: interface adapter
- * @req: Prepared RPC Call
+ * frwr_send - post Send WRs containing the RPC Call message
+ * @r_xprt: controlling transport instance
+ * @req: prepared RPC Call
  *
  * For FRWR, chain any FastReg WRs to the Send WR. Only a
  * single ib_post_send call is needed to register memory
  * and then post the Send WR.
  *
- * Returns the result of ib_post_send.
+ * Returns the return code from ib_post_send.
+ *
+ * Caller must hold the transport send lock to ensure that the
+ * pointers to the transport's rdma_cm_id and QP are stable.
  */
-int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req)
+int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct ib_send_wr *post_wr;
 	struct rpcrdma_mr *mr;
 
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index d915524a8e68..8934c24a5701 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -688,7 +688,7 @@ static bool rpcrdma_check_regbuf(struct rpcrdma_xprt *r_xprt,
 		goto drop_connection;
 	rqst->rq_xtime = ktime_get();
 
-	if (rpcrdma_ep_post(&r_xprt->rx_ia, &r_xprt->rx_ep, req))
+	if (rpcrdma_post_sends(r_xprt, req))
 		goto drop_connection;
 
 	rqst->rq_xmit_bytes_sent += rqst->rq_snd_buf.len;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 02ce3d548825..8fd6682d2646 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1461,20 +1461,17 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 }
 
 /**
- * rpcrdma_ep_post - Post WRs to a transport's Send Queue
- * @ia: transport's device information
- * @ep: transport's RDMA endpoint information
+ * rpcrdma_post_sends - Post WRs to a transport's Send Queue
+ * @r_xprt: controlling transport instance
  * @req: rpcrdma_req containing the Send WR to post
  *
  * Returns 0 if the post was successful, otherwise -ENOTCONN
  * is returned.
  */
-int
-rpcrdma_ep_post(struct rpcrdma_ia *ia,
-		struct rpcrdma_ep *ep,
-		struct rpcrdma_req *req)
+int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *send_wr = &req->rl_wr;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	int rc;
 
 	if (!ep->rep_send_count || kref_read(&req->rl_kref) > 1) {
@@ -1485,7 +1482,7 @@ static void rpcrdma_regbuf_free(struct rpcrdma_regbuf *rb)
 		--ep->rep_send_count;
 	}
 
-	rc = frwr_send(ia, req);
+	rc = frwr_send(r_xprt, req);
 	trace_xprtrdma_post_send(req, rc);
 	if (rc)
 		return -ENOTCONN;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 9e3e9a82cb9f..82ec4c25432f 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -467,8 +467,7 @@ struct rpcrdma_xprt {
 int rpcrdma_ep_connect(struct rpcrdma_ep *, struct rpcrdma_ia *);
 void rpcrdma_ep_disconnect(struct rpcrdma_ep *, struct rpcrdma_ia *);
 
-int rpcrdma_ep_post(struct rpcrdma_ia *, struct rpcrdma_ep *,
-				struct rpcrdma_req *);
+int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
 
 /*
@@ -542,7 +541,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 				struct rpcrdma_mr_seg *seg,
 				int nsegs, bool writing, __be32 xid,
 				struct rpcrdma_mr *mr);
-int frwr_send(struct rpcrdma_ia *ia, struct rpcrdma_req *req);
+int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);

