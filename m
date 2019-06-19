Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F29F4BB95
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFSOcv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:32:51 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35393 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOcu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:32:50 -0400
Received: by mail-io1-f66.google.com with SMTP id m24so38715200ioo.2;
        Wed, 19 Jun 2019 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Oje0i/9HliJ+SmSczKn331eMag+SCeYsXboopbPTP3o=;
        b=f5Jj/3o3+3K/EAaQYGHnowrkiAqqarjX8nBMWw7pbVFJ9JRUvGEdauS8EDQN0s/rW7
         Vk3gbciLLGGppdVDrJECr8e7ecg55opcm8Xubl6NHCwhCgsXnWOWrXCO7ceyAWL/e+gS
         rSp9d/mR+N+htA2SfYecF581ZUjyGYZ8Q7HI3pSR3VWH6TlTVq6OOjacHPQh6voLoYNz
         uUrDnJWUSvKKPQoEkYgUxYo3eNa2+PBCiFhQX7ZANI3VVbA+O250pab2UkIB8kKSo7Yi
         f1UCFLTmoPj95APBd4WXBgRDi3IiYDRTZkrf9+l3lzgwaXbR4Wstw4knIYZckdonzCbI
         qThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Oje0i/9HliJ+SmSczKn331eMag+SCeYsXboopbPTP3o=;
        b=FS3jh/pizRK684uLAx0XwSEYdQjIReCgvNKaD2uijLs2eIBEtZl4VCN1mWK0dOaB+J
         JiFUZy6w7I3ToO8rf1ZQi4ZqA7rxi277fs0vreZ4IGN58AjQtL2ZdPA2pO4HyJ1cFjYG
         Rx4g2uyODtX6wzn8gFN47i0zh78oJ6bA8kAxTtBeV/3OSA5FF5ktvi064piPIqSFgHwL
         Z1wvblWEckjvD27WTMi54uEx2MMV6iIeZHDPKZn5nW8rEPV+SVpKebmRE8v4X/M0GHfh
         r0OnThc4lrDOhnXQxBLplpdu6wTM096QvnJuu8RIjkIKFRE2RErBPIPXThlEWxnWjay+
         nh+g==
X-Gm-Message-State: APjAAAWqvSvRpZhy77EuowqJwWGAs/JTdqVaFV6mEgfCWxVOSIjoiqdr
        Zgt/gMFJ8ZYWG5w172KSxbQ=
X-Google-Smtp-Source: APXvYqxTWlIGjE71rTey6T6Uv/ESLmx4hZOSFUjyXFmgGgUxZq5PL56FyT8pecUuUp5gSsJ6+3Mo6A==
X-Received: by 2002:a5d:8c84:: with SMTP id g4mr65484852ion.211.1560954769774;
        Wed, 19 Jun 2019 07:32:49 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v13sm20235501ioq.13.2019.06.19.07.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:32:49 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEWmQC004503;
        Wed, 19 Jun 2019 14:32:48 GMT
Subject: [PATCH v4 04/19] xprtrdma: Fix occasional transport deadlock
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:32:48 -0400
Message-ID: <20190619143248.3826.87089.stgit@manet.1015granger.net>
In-Reply-To: <20190619143031.3826.46412.stgit@manet.1015granger.net>
References: <20190619143031.3826.46412.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Under high I/O workloads, I've noticed that an RPC/RDMA transport
occasionally deadlocks (IOPS goes to zero, and doesn't recover).
Diagnosis shows that the sendctx queue is empty, but when sendctxs
are returned to the queue, the xprt_write_space wake-up never
occurs. The wake-up logic in rpcrdma_sendctx_put_locked is racy.

I noticed that both EMPTY_SCQ and XPRT_WRITE_SPACE are implemented
via an atomic bit. Just one of those is sufficient. Removing
EMPTY_SCQ in favor of the generic bit mechanism makes the deadlock
un-reproducible.

Without EMPTY_SCQ, rpcrdma_buffer::rb_flags is no longer used and
is therefore removed.

Unfortunately this patch does not apply cleanly to stable. If
needed, someone will have to port it and test it.

Fixes: 2fad659209d5 ("xprtrdma: Wait on empty sendctx queue")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   27 +++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/frwr_ops.c  |    6 +++++-
 net/sunrpc/xprtrdma/rpc_rdma.c  |   26 ++++++++++++--------------
 net/sunrpc/xprtrdma/verbs.c     |   11 +++--------
 net/sunrpc/xprtrdma/xprt_rdma.h |    6 ------
 5 files changed, 47 insertions(+), 29 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 59492a93..2fb4151 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -539,6 +539,33 @@
 	)
 );
 
+TRACE_EVENT(xprtrdma_prepsend_failed,
+	TP_PROTO(const struct rpc_rqst *rqst,
+		 int ret
+	),
+
+	TP_ARGS(rqst, ret),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__entry->ret = ret;
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x: ret=%d",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		__entry->ret
+	)
+);
+
 TRACE_EVENT(xprtrdma_post_send,
 	TP_PROTO(
 		const struct rpcrdma_req *req,
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 794ba4c..ac47314 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -391,7 +391,7 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 			rpcrdma_mr_recycle(mr);
 		mr = rpcrdma_mr_get(r_xprt);
 		if (!mr)
-			return ERR_PTR(-EAGAIN);
+			goto out_getmr_err;
 	} while (mr->frwr.fr_state != FRWR_IS_INVALID);
 	frwr = &mr->frwr;
 	frwr->fr_state = FRWR_IS_VALID;
@@ -448,6 +448,10 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	*out = mr;
 	return seg;
 
+out_getmr_err:
+	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
+	return ERR_PTR(-EAGAIN);
+
 out_dmamap_err:
 	mr->mr_dir = DMA_NONE;
 	trace_xprtrdma_frwr_sgerr(mr, i);
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 97bfb80..59b214b 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -699,22 +699,28 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 			  struct rpcrdma_req *req, u32 hdrlen,
 			  struct xdr_buf *xdr, enum rpcrdma_chunktype rtype)
 {
+	int ret;
+
+	ret = -EAGAIN;
 	req->rl_sendctx = rpcrdma_sendctx_get_locked(r_xprt);
 	if (!req->rl_sendctx)
-		return -EAGAIN;
+		goto err;
 	req->rl_sendctx->sc_wr.num_sge = 0;
 	req->rl_sendctx->sc_unmap_count = 0;
 	req->rl_sendctx->sc_req = req;
 	__clear_bit(RPCRDMA_REQ_F_TX_RESOURCES, &req->rl_flags);
 
+	ret = -EIO;
 	if (!rpcrdma_prepare_hdr_sge(r_xprt, req, hdrlen))
-		return -EIO;
-
+		goto err;
 	if (rtype != rpcrdma_areadch)
 		if (!rpcrdma_prepare_msg_sges(r_xprt, req, xdr, rtype))
-			return -EIO;
-
+			goto err;
 	return 0;
+
+err:
+	trace_xprtrdma_prepsend_failed(&req->rl_slot, ret);
+	return ret;
 }
 
 /**
@@ -877,15 +883,7 @@ static bool rpcrdma_prepare_msg_sges(struct rpcrdma_xprt *r_xprt,
 
 out_err:
 	trace_xprtrdma_marshal_failed(rqst, ret);
-	switch (ret) {
-	case -EAGAIN:
-		xprt_wait_for_buffer_space(rqst->rq_xprt);
-		break;
-	case -ENOBUFS:
-		break;
-	default:
-		r_xprt->rx_stats.failed_marshal_count++;
-	}
+	r_xprt->rx_stats.failed_marshal_count++;
 	return ret;
 }
 
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index e71315e..0be5a36 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -901,7 +901,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	 * completions recently. This is a sign the Send Queue is
 	 * backing up. Cause the caller to pause and try again.
 	 */
-	set_bit(RPCRDMA_BUF_F_EMPTY_SCQ, &buf->rb_flags);
+	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
 	r_xprt->rx_stats.empty_sendctx_q++;
 	return NULL;
 }
@@ -936,10 +936,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	/* Paired with READ_ONCE */
 	smp_store_release(&buf->rb_sc_tail, next_tail);
 
-	if (test_and_clear_bit(RPCRDMA_BUF_F_EMPTY_SCQ, &buf->rb_flags)) {
-		smp_mb__after_atomic();
-		xprt_write_space(&sc->sc_xprt->rx_xprt);
-	}
+	xprt_write_space(&sc->sc_xprt->rx_xprt);
 }
 
 static void
@@ -977,8 +974,6 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 	r_xprt->rx_stats.mrs_allocated += count;
 	spin_unlock(&buf->rb_mrlock);
 	trace_xprtrdma_createmrs(r_xprt, count);
-
-	xprt_write_space(&r_xprt->rx_xprt);
 }
 
 static void
@@ -990,6 +985,7 @@ struct rpcrdma_sendctx *rpcrdma_sendctx_get_locked(struct rpcrdma_xprt *r_xprt)
 						   rx_buf);
 
 	rpcrdma_mrs_create(r_xprt);
+	xprt_write_space(&r_xprt->rx_xprt);
 }
 
 /**
@@ -1089,7 +1085,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	int i, rc;
 
-	buf->rb_flags = 0;
 	buf->rb_max_requests = r_xprt->rx_ep.rep_max_requests;
 	buf->rb_bc_srv_max_requests = 0;
 	spin_lock_init(&buf->rb_mrlock);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index d1e0749..2c6c5d8 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -391,7 +391,6 @@ struct rpcrdma_buffer {
 	struct list_head	rb_recv_bufs;
 	struct list_head	rb_allreqs;
 
-	unsigned long		rb_flags;
 	u32			rb_max_requests;
 	u32			rb_credits;	/* most recent credit grant */
 
@@ -402,11 +401,6 @@ struct rpcrdma_buffer {
 	struct delayed_work	rb_refresh_worker;
 };
 
-/* rb_flags */
-enum {
-	RPCRDMA_BUF_F_EMPTY_SCQ = 0,
-};
-
 /*
  * Statistics for RPCRDMA
  */

