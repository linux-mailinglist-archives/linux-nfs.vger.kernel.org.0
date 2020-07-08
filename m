Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89421912C
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgGHUJY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUJX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:23 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CDC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:23 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so17001441qvb.13
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=O7yT2cSbYvo2QL4A8cl5rVSH3gKdyWLem9KFWSi2wV0=;
        b=SYfXkJvWIFklDr0SOVcx45KfIatQFUA3DJsXaFkKypIzFg7yNRkyyVq5uf7HREJ+kV
         ZfHP+GcZZMluplA7XTkCtPOXF6i1Pb9O83SQA7wSlVUVRg1Hz6/0rDRozEquBc++oW52
         9MhStzbZbKC+t5gUm6miv5crWeSfG3TxmN/244uvRaUT3DwgVQQrMOKW9Jhii0k69rKd
         ut5X/dIpdixf1/WIllBj9jhJuOH1uSi6Eei6x+iV4MzAAsKbrMuhXjhUsKgDZtdZSlES
         Wtbm7T/EWRsvUAHBIbnZO5avuF/G2HnpQunHLzqN9XVUVVXFTwZ18V5396Hv/iSvCgQ/
         tGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=O7yT2cSbYvo2QL4A8cl5rVSH3gKdyWLem9KFWSi2wV0=;
        b=LCOgKfJspE17fs6Xb9nTdvT/QzkuNi+sY63oXiVm3vuWrq/YJgb7fvVcQdgu6muttp
         mPM6wASkEV2JzZvu5VaxzOuLLIBh4zYKGDdd81x75ub6nanrOqtanyP6x4GtdWeIELET
         jFA60jMrFIxkRgEbweI76V+KvSbSswIuPZYIXxzQ6F55/BOIPVFDUSs93nT5nff8gtH5
         KiPsokGYAZYsuMl02F23Xm/UNuvwye4XbHZ7HknGhnlFfe03LtKJsNdIJUy47rChbCjd
         L3huDH6AT5hUve1ZsDo9WFWCupnmm3Dsd6Dx8CKkhnBFtGmeUKNYguz4PynbEedxgTST
         vGXQ==
X-Gm-Message-State: AOAM531L0NFBgxo4Q0bgMsfoI8Uy5PpGpNFcWROvz8qNlYuEfqKWEptn
        zzgv7Hy9SGCK0B+w4euqjaBLgP2Z
X-Google-Smtp-Source: ABdhPJyYWZ/gZ4MOa9bP+UA4+5NsGkn2+jJ6Z7EKPkjT3PYdI6Jn4lhUjpaLfF4U0PXUm8HwK4VP9Q==
X-Received: by 2002:a05:6214:851:: with SMTP id dg17mr60077427qvb.235.1594238962565;
        Wed, 08 Jul 2020 13:09:22 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id y16sm876405qty.1.2020.07.08.13.09.22
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:22 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9LRE006075
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:21 GMT
Subject: [PATCH v1 04/22] SUNRPC: Update debugging instrumentation in
 xprt_do_reserve()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:21 -0400
Message-ID: <20200708200921.22129.10571.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a dprintk() with a tracepoint. The tracepoint marks the
point where an RPC request is assigned an XID.

Additional clean up: Remove trace_xprt_enq_xmit, which reports much
the same thing. That tracepoint was added for debugging commit
918f3c1fe83c ("SUNRPC: Improve latency for interactive tasks").

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   55 ++++++++++++++++++-----------------------
 net/sunrpc/xprt.c             |    8 +-----
 2 files changed, 26 insertions(+), 37 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ea61628b9deb..7ff40870d122 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1031,37 +1031,6 @@ TRACE_EVENT(xprt_transmit,
 		__entry->seqno, __entry->status)
 );
 
-TRACE_EVENT(xprt_enq_xmit,
-	TP_PROTO(
-		const struct rpc_task *task,
-		int stage
-	),
-
-	TP_ARGS(task, stage),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(u32, xid)
-		__field(u32, seqno)
-		__field(int, stage)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client ?
-			task->tk_client->cl_clid : -1;
-		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
-		__entry->seqno = task->tk_rqstp->rq_seqno;
-		__entry->stage = stage;
-	),
-
-	TP_printk(
-		"task:%u@%u xid=0x%08x seqno=%u stage=%d",
-		__entry->task_id, __entry->client_id, __entry->xid,
-		__entry->seqno, __entry->stage)
-);
-
 TRACE_EVENT(xprt_ping,
 	TP_PROTO(const struct rpc_xprt *xprt, int status),
 
@@ -1176,6 +1145,30 @@ DEFINE_CONG_EVENT(release_cong);
 DEFINE_CONG_EVENT(get_cong);
 DEFINE_CONG_EVENT(put_cong);
 
+TRACE_EVENT(xprt_reserve,
+	TP_PROTO(
+		const struct rpc_rqst *rqst
+	),
+
+	TP_ARGS(rqst),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, xid)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = rqst->rq_task->tk_pid;
+		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
+		__entry->xid = be32_to_cpu(rqst->rq_xid);
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x",
+		__entry->task_id, __entry->client_id, __entry->xid
+	)
+);
+
 TRACE_EVENT(xs_stream_read_data,
 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 46db56e1aa38..cb5cf74105aa 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1258,7 +1258,6 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 				/* Note: req is added _before_ pos */
 				list_add_tail(&req->rq_xmit, &pos->rq_xmit);
 				INIT_LIST_HEAD(&req->rq_xmit2);
-				trace_xprt_enq_xmit(task, 1);
 				goto out;
 			}
 		} else if (RPC_IS_SWAPPER(task)) {
@@ -1270,7 +1269,6 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 				/* Note: req is added _before_ pos */
 				list_add_tail(&req->rq_xmit, &pos->rq_xmit);
 				INIT_LIST_HEAD(&req->rq_xmit2);
-				trace_xprt_enq_xmit(task, 2);
 				goto out;
 			}
 		} else if (!req->rq_seqno) {
@@ -1279,13 +1277,11 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 					continue;
 				list_add_tail(&req->rq_xmit2, &pos->rq_xmit2);
 				INIT_LIST_HEAD(&req->rq_xmit);
-				trace_xprt_enq_xmit(task, 3);
 				goto out;
 			}
 		}
 		list_add_tail(&req->rq_xmit, &xprt->xmit_queue);
 		INIT_LIST_HEAD(&req->rq_xmit2);
-		trace_xprt_enq_xmit(task, 4);
 out:
 		set_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate);
 		spin_unlock(&xprt->queue_lock);
@@ -1736,8 +1732,8 @@ xprt_request_init(struct rpc_task *task)
 	req->rq_rcv_buf.bvec = NULL;
 	req->rq_release_snd_buf = NULL;
 	xprt_init_majortimeo(task, req);
-	dprintk("RPC: %5u reserved req %p xid %08x\n", task->tk_pid,
-			req, ntohl(req->rq_xid));
+
+	trace_xprt_reserve(req);
 }
 
 static void

