Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4090458343A
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Jul 2022 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiG0UuA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Jul 2022 16:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiG0Ut6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Jul 2022 16:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEB74E84D
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 13:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3104961AA2
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 20:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D72C433C1
        for <linux-nfs@vger.kernel.org>; Wed, 27 Jul 2022 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658954995;
        bh=VhYrqWoztd22bvtrYhm6wtjtsJLUblTWgBnijr/LY2c=;
        h=From:To:Subject:Date:From;
        b=o2882I29D7tfNDiDPWTAFnshZ1bn9wnv+J+2JQS4q2+qd6AaxVC4/aFQ4n1oDsIvm
         A3urIQGLn2rc993ohfJAKdt8exWzGwa8RtizpYhZxmN9fR47G2LVjTmRfnDCxIzuIK
         A1Ge1ee3BnebVbOOvJoDuTPyTlm1V3ZOK7bydmIcdhpr/GTf5bUUMNq7shzrDy6pV7
         L7XlcoogIX7/HHhnz5W1+cAFTdCZMgQG+ZCpJyH9VlVSm93Q8a+OGT098kphmcG7Tr
         ++ReP7jL5U8XJ1sJKdK1qVjnaPRqgp/fTrPrcWTAyx45AS9UvJZlZXdjvt6MTJFMXY
         BYEhiOBVoiazA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Don't reuse bvec on retransmission of the request
Date:   Wed, 27 Jul 2022 16:43:28 -0400
Message-Id: <20220727204328.717480-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a request is re-encoded and then retransmitted, we need to make sure
that we also re-encode the bvec, in case the page lists have changed.

Fixes: ff053dbbaffe ("SUNRPC: Move the call to xprt_send_pagedata() out of xprt_sock_sendmsg()")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
- v2: Fix up warning in call_decode

 include/linux/sunrpc/xprt.h |  3 ++-
 net/sunrpc/clnt.c           |  1 -
 net/sunrpc/xprt.c           | 27 ++++++++++++++++++---------
 net/sunrpc/xprtsock.c       | 12 ++----------
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 0d51b9f9ea37..b9f59aabee53 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -144,7 +144,8 @@ struct rpc_xprt_ops {
 	unsigned short	(*get_srcport)(struct rpc_xprt *xprt);
 	int		(*buf_alloc)(struct rpc_task *task);
 	void		(*buf_free)(struct rpc_task *task);
-	int		(*prepare_request)(struct rpc_rqst *req);
+	int		(*prepare_request)(struct rpc_rqst *req,
+					   struct xdr_buf *buf);
 	int		(*send_request)(struct rpc_rqst *req);
 	void		(*wait_for_reply_request)(struct rpc_task *task);
 	void		(*timer)(struct rpc_xprt *xprt, struct rpc_task *task);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index bbfc47f03480..b098e707ad41 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1870,7 +1870,6 @@ rpc_xdr_encode(struct rpc_task *task)
 	req->rq_snd_buf.head[0].iov_len = 0;
 	xdr_init_encode(&xdr, &req->rq_snd_buf,
 			req->rq_snd_buf.head[0].iov_base, req);
-	xdr_free_bvec(&req->rq_snd_buf);
 	if (rpc_encode_header(task, &xdr))
 		return;
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 44348c9f4b00..d71eec494826 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -73,7 +73,7 @@ static void	xprt_init(struct rpc_xprt *xprt, struct net *net);
 static __be32	xprt_alloc_xid(struct rpc_xprt *xprt);
 static void	xprt_destroy(struct rpc_xprt *xprt);
 static void	xprt_request_init(struct rpc_task *task);
-static int	xprt_request_prepare(struct rpc_rqst *req);
+static int	xprt_request_prepare(struct rpc_rqst *req, struct xdr_buf *buf);
 
 static DEFINE_SPINLOCK(xprt_list_lock);
 static LIST_HEAD(xprt_list);
@@ -1149,7 +1149,7 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 	if (!xprt_request_need_enqueue_receive(task, req))
 		return 0;
 
-	ret = xprt_request_prepare(task->tk_rqstp);
+	ret = xprt_request_prepare(task->tk_rqstp, &req->rq_rcv_buf);
 	if (ret)
 		return ret;
 	spin_lock(&xprt->queue_lock);
@@ -1179,8 +1179,11 @@ xprt_request_dequeue_receive_locked(struct rpc_task *task)
 {
 	struct rpc_rqst *req = task->tk_rqstp;
 
-	if (test_and_clear_bit(RPC_TASK_NEED_RECV, &task->tk_runstate))
+	if (test_and_clear_bit(RPC_TASK_NEED_RECV, &task->tk_runstate)) {
 		xprt_request_rb_remove(req->rq_xprt, req);
+		xdr_free_bvec(&req->rq_rcv_buf);
+		req->rq_private_buf.bvec = NULL;
+	}
 }
 
 /**
@@ -1336,8 +1339,14 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 {
 	struct rpc_rqst *pos, *req = task->tk_rqstp;
 	struct rpc_xprt *xprt = req->rq_xprt;
+	int ret;
 
 	if (xprt_request_need_enqueue_transmit(task, req)) {
+		ret = xprt_request_prepare(task->tk_rqstp, &req->rq_snd_buf);
+		if (ret) {
+			task->tk_status = ret;
+			return;
+		}
 		req->rq_bytes_sent = 0;
 		spin_lock(&xprt->queue_lock);
 		/*
@@ -1397,6 +1406,7 @@ xprt_request_dequeue_transmit_locked(struct rpc_task *task)
 	} else
 		list_del(&req->rq_xmit2);
 	atomic_long_dec(&req->rq_xprt->xmit_queuelen);
+	xdr_free_bvec(&req->rq_snd_buf);
 }
 
 /**
@@ -1433,8 +1443,6 @@ xprt_request_dequeue_xprt(struct rpc_task *task)
 	    test_bit(RPC_TASK_NEED_RECV, &task->tk_runstate) ||
 	    xprt_is_pinned_rqst(req)) {
 		spin_lock(&xprt->queue_lock);
-		xprt_request_dequeue_transmit_locked(task);
-		xprt_request_dequeue_receive_locked(task);
 		while (xprt_is_pinned_rqst(req)) {
 			set_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
 			spin_unlock(&xprt->queue_lock);
@@ -1442,6 +1450,8 @@ xprt_request_dequeue_xprt(struct rpc_task *task)
 			spin_lock(&xprt->queue_lock);
 			clear_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
 		}
+		xprt_request_dequeue_transmit_locked(task);
+		xprt_request_dequeue_receive_locked(task);
 		spin_unlock(&xprt->queue_lock);
 	}
 }
@@ -1449,18 +1459,19 @@ xprt_request_dequeue_xprt(struct rpc_task *task)
 /**
  * xprt_request_prepare - prepare an encoded request for transport
  * @req: pointer to rpc_rqst
+ * @buf: pointer to send/rcv xdr_buf
  *
  * Calls into the transport layer to do whatever is needed to prepare
  * the request for transmission or receive.
  * Returns error, or zero.
  */
 static int
-xprt_request_prepare(struct rpc_rqst *req)
+xprt_request_prepare(struct rpc_rqst *req, struct xdr_buf *buf)
 {
 	struct rpc_xprt *xprt = req->rq_xprt;
 
 	if (xprt->ops->prepare_request)
-		return xprt->ops->prepare_request(req);
+		return xprt->ops->prepare_request(req, buf);
 	return 0;
 }
 
@@ -1961,8 +1972,6 @@ void xprt_release(struct rpc_task *task)
 	spin_unlock(&xprt->transport_lock);
 	if (req->rq_buffer)
 		xprt->ops->buf_free(task);
-	xdr_free_bvec(&req->rq_rcv_buf);
-	xdr_free_bvec(&req->rq_snd_buf);
 	if (req->rq_cred != NULL)
 		put_rpccred(req->rq_cred);
 	if (req->rq_release_snd_buf)
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index eba1be9984f8..e976007f4fd0 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -822,17 +822,9 @@ static int xs_stream_nospace(struct rpc_rqst *req, bool vm_wait)
 	return ret;
 }
 
-static int
-xs_stream_prepare_request(struct rpc_rqst *req)
+static int xs_stream_prepare_request(struct rpc_rqst *req, struct xdr_buf *buf)
 {
-	gfp_t gfp = rpc_task_gfp_mask();
-	int ret;
-
-	ret = xdr_alloc_bvec(&req->rq_snd_buf, gfp);
-	if (ret < 0)
-		return ret;
-	xdr_free_bvec(&req->rq_rcv_buf);
-	return xdr_alloc_bvec(&req->rq_rcv_buf, gfp);
+	return xdr_alloc_bvec(buf, rpc_task_gfp_mask());
 }
 
 /*
-- 
2.37.1

