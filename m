Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDABB12FAE2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgACQ4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:35 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:33247 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ4f (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:35 -0500
Received: by mail-yb1-f195.google.com with SMTP id n66so18855508ybg.0;
        Fri, 03 Jan 2020 08:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=zwhon8II32DWrYSmdSH74tObIQ31P4JpVuINWcxt7H8=;
        b=jtb1Df4JQrV4EJZ3K3gElpQ3Oukw9PwmhSE6nu8toBWy8F3UJx1JdT5Hzb9PXDq1iB
         u51V5+KE9zT9tjUnYi+Q/4aelMwPzGQNyCXLfnvNvu/qFzIw+npZzs1vIfaVGZ/wUf+D
         q2RRj2SDDvIzRNraEs0A1Ov+sNE5qvlCeuz2mbfmQsQPIu0p+7am+7XIB1noMrKgP0Ol
         +UF/7Z75EEf+LV5LRNbAvh1kaSo6pKrwikVYZ9n1g7o42ulcQXCMAGNdYkqF0DyRHiP5
         cDJkIdJg8kk7jiM5xU2+Yvf04yePO5FwWsJtdYRtHql8kuSyaQlWjOv82o3f7aGl1WvA
         6xNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=zwhon8II32DWrYSmdSH74tObIQ31P4JpVuINWcxt7H8=;
        b=NHE8ZvxtgAJl2de7q1phOcl6/zchnKKGvWoWDSO6M7uKk1tCfYMVvMUvu++guM0K97
         mPBVFuf5mdgwD7wUhD1xiMmoay4ZmmhRKjAZ0HQ7aRBQSSiLx7P0y9LvWl3wu13+r4oc
         b0yLrHXv7r27QBK0XEMt8VsKZiAiDGE99CpQLtuXuY5IcMSYNClDo9j65SqQEfEnrCIj
         ib2GoUoEWM2c2gjMrSl+GgxDrCFFwMwFP6to6HDbVOH73cyfem/27TMx2MZrMxi4jyYl
         ydqGGaEBqCa2e4osCtYE6zCUjbYU83qctp80sIrRr/XSGq/oZNkIrFc5aBXUf1ovta6V
         Qtmg==
X-Gm-Message-State: APjAAAXtQuMcho9FdrqTr3QjS0mstFL+8PoJhhoHqrxPefF1hW6zTFe5
        ZXjyDSxUfP5yukaj6M4ABcBT1Ku1
X-Google-Smtp-Source: APXvYqzTR8fw6RM84HUegSojixZGghJ0We77Djifqlc54DfCCp/c3s8kBl19mzHlrBGNQyNmUKw8XA==
X-Received: by 2002:a25:99c2:: with SMTP id q2mr51083887ybo.365.1578070593771;
        Fri, 03 Jan 2020 08:56:33 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id g29sm23955007ywk.31.2020.01.03.08.56.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:33 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GuW5w016386;
        Fri, 3 Jan 2020 16:56:32 GMT
Subject: [PATCH v1 2/9] xprtrdma: Make sendctx queue lifetime the same as
 connection lifetime
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:32 -0500
Message-ID: <157807059245.4606.283126960136817326.stgit@morisot.1015granger.net>
In-Reply-To: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
References: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The size of the sendctx queue depends on the value stored in
ia->ri_max_send_sges. This value is determined by querying the
underlying device.

Eventually, rpcrdma_ia_open() and rpcrdma_ep_create() will be called
in the connect worker rather than at transport set-up time. The
underlying device will not have been chosen device set-up time.

The sendctx queue will thus have to be created after the underlying
device has been chosen via address and route resolution; in other
words, in the connect worker.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   12 ++++++++----
 net/sunrpc/xprtrdma/verbs.c    |   22 +++++++++++++++-------
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 28dd498e683e..6d9075507bd6 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -698,6 +698,7 @@ TRACE_EVENT(xprtrdma_post_send,
 
 	TP_STRUCT__entry(
 		__field(const void *, req)
+		__field(const void *, sc)
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
 		__field(int, num_sge)
@@ -712,14 +713,15 @@ TRACE_EVENT(xprtrdma_post_send,
 		__entry->client_id = rqst->rq_task->tk_client ?
 				     rqst->rq_task->tk_client->cl_clid : -1;
 		__entry->req = req;
+		__entry->sc = req->rl_sendctx;
 		__entry->num_sge = req->rl_wr.num_sge;
 		__entry->signaled = req->rl_wr.send_flags & IB_SEND_SIGNALED;
 		__entry->status = status;
 	),
 
-	TP_printk("task:%u@%u req=%p (%d SGE%s) %sstatus=%d",
+	TP_printk("task:%u@%u req=%p sc=%p (%d SGE%s) %sstatus=%d",
 		__entry->task_id, __entry->client_id,
-		__entry->req, __entry->num_sge,
+		__entry->req, __entry->sc, __entry->num_sge,
 		(__entry->num_sge == 1 ? "" : "s"),
 		(__entry->signaled ? "signaled " : ""),
 		__entry->status
@@ -818,6 +820,7 @@ TRACE_EVENT(xprtrdma_wc_send,
 
 	TP_STRUCT__entry(
 		__field(const void *, req)
+		__field(const void *, sc)
 		__field(unsigned int, unmap_count)
 		__field(unsigned int, status)
 		__field(unsigned int, vendor_err)
@@ -825,13 +828,14 @@ TRACE_EVENT(xprtrdma_wc_send,
 
 	TP_fast_assign(
 		__entry->req = sc->sc_req;
+		__entry->sc = sc;
 		__entry->unmap_count = sc->sc_unmap_count;
 		__entry->status = wc->status;
 		__entry->vendor_err = __entry->status ? wc->vendor_err : 0;
 	),
 
-	TP_printk("req=%p, unmapped %u pages: %s (%u/0x%x)",
-		__entry->req, __entry->unmap_count,
+	TP_printk("req=%p sc=%p unmapped=%u: %s (%u/0x%x)",
+		__entry->req, __entry->sc, __entry->unmap_count,
 		rdma_show_wc_status(__entry->status),
 		__entry->status, __entry->vendor_err
 	)
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 0ad81d3c735e..3cc6d19f7f3a 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -74,6 +74,8 @@
 /*
  * internal functions
  */
+static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt);
+static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt);
 static void rpcrdma_sendctx_put_locked(struct rpcrdma_xprt *r_xprt,
 				       struct rpcrdma_sendctx *sc);
 static void rpcrdma_reqs_reset(struct rpcrdma_xprt *r_xprt);
@@ -427,6 +429,7 @@ rpcrdma_ia_remove(struct rpcrdma_ia *ia)
 		rpcrdma_regbuf_dma_unmap(req->rl_recvbuf);
 	}
 	rpcrdma_mrs_destroy(r_xprt);
+	rpcrdma_sendctxs_destroy(r_xprt);
 	ib_dealloc_pd(ia->ri_pd);
 	ia->ri_pd = NULL;
 
@@ -704,6 +707,10 @@ rpcrdma_ep_connect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
 	rpcrdma_reset_cwnd(r_xprt);
 	rpcrdma_post_recvs(r_xprt, true);
 
+	rc = rpcrdma_sendctxs_create(r_xprt);
+	if (rc)
+		goto out;
+
 	rc = rdma_connect(ia->ri_id, &ep->rep_remote_cma);
 	if (rc)
 		goto out;
@@ -756,6 +763,7 @@ rpcrdma_ep_disconnect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
 	rpcrdma_xprt_drain(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
 	rpcrdma_mrs_destroy(r_xprt);
+	rpcrdma_sendctxs_destroy(r_xprt);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -775,13 +783,17 @@ rpcrdma_ep_disconnect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
  * queue activity, and rpcrdma_xprt_drain has flushed all remaining
  * Send requests.
  */
-static void rpcrdma_sendctxs_destroy(struct rpcrdma_buffer *buf)
+static void rpcrdma_sendctxs_destroy(struct rpcrdma_xprt *r_xprt)
 {
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	unsigned long i;
 
+	if (!buf->rb_sc_ctxs)
+		return;
 	for (i = 0; i <= buf->rb_sc_last; i++)
 		kfree(buf->rb_sc_ctxs[i]);
 	kfree(buf->rb_sc_ctxs);
+	buf->rb_sc_ctxs = NULL;
 }
 
 static struct rpcrdma_sendctx *rpcrdma_sendctx_create(struct rpcrdma_ep *ep)
@@ -809,7 +821,6 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 	 * Sends are posted.
 	 */
 	i = buf->rb_max_requests + RPCRDMA_MAX_BC_REQUESTS;
-	dprintk("RPC:       %s: allocating %lu send_ctxs\n", __func__, i);
 	buf->rb_sc_ctxs = kcalloc(i, sizeof(sc), GFP_KERNEL);
 	if (!buf->rb_sc_ctxs)
 		return -ENOMEM;
@@ -823,6 +834,8 @@ static int rpcrdma_sendctxs_create(struct rpcrdma_xprt *r_xprt)
 		buf->rb_sc_ctxs[i] = sc;
 	}
 
+	buf->rb_sc_head = 0;
+	buf->rb_sc_tail = 0;
 	return 0;
 }
 
@@ -1165,10 +1178,6 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 
 	init_llist_head(&buf->rb_free_reps);
 
-	rc = rpcrdma_sendctxs_create(r_xprt);
-	if (rc)
-		goto out;
-
 	return 0;
 out:
 	rpcrdma_buffer_destroy(buf);
@@ -1244,7 +1253,6 @@ static void rpcrdma_mrs_destroy(struct rpcrdma_xprt *r_xprt)
 void
 rpcrdma_buffer_destroy(struct rpcrdma_buffer *buf)
 {
-	rpcrdma_sendctxs_destroy(buf);
 	rpcrdma_reps_destroy(buf);
 
 	while (!list_empty(&buf->rb_send_bufs)) {


