Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A07219129
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgGHUJN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgGHUJN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:09:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6E4C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:09:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k18so5261662qtm.10
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IScHmM/bKixJ0d8idRKfjYwISdY1gpV/WMBGnysbihI=;
        b=ZhoyLB2ueJ5uCIn0dTHeqeGfUjK8/P9yiBIEB75jr0xsUO1U2Iuztk4TOkZVR28J6b
         YIWcvltCd/3i3KjNG+zZOsj3l7p5F78ESHRFT1zV/8T6IfRLgS9Yl34xO1hrCxIj27HZ
         1ImvxwqzAaLH2YZ2lD4i8EoEKnTU6WH3lWtEXj3zI40xyVHtVSBZ/GyPGOP5PDlK71k/
         t/QOSqdYAYck6PLkHcEmI/4qmmCqIVRImSvxoNPMwT38Mi7QS1avhQJmmGKIlW5e9I1h
         PKP0zhpDYB4QfcVmvh1qy9TK12u3rBGFSC6Mtbq/281w+LcEMxsxiKWQaQYZeMqZmuCf
         zs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IScHmM/bKixJ0d8idRKfjYwISdY1gpV/WMBGnysbihI=;
        b=d0KjH+djVAC873nIFAulFNAc1rEo5NCsOZEomW0UMG1cZq3sgGpmq5xhJoaw81j6fe
         3z1NdolMBgzvVeOc/nZTdqkj+U5cWdDBOoUfWKJeHA4suRnTSVI5f24MXOawdOZANDlc
         MQXf2DLp4vl/RTfTv3+083DDQQ0YFVlEJZtDMfa/Igv152DjSIZB2CQKoogTyGQ8TtNd
         sGtCZYIws26TeZ8IzJUthKAATq7OnL/22uKz/rgcIp2eF0Eo6ssfLaw68YnFhnz5wRAr
         dCCRAzxGI/LnXUUHEIofE4yI1DryUbzUvrKqiqGYVykC5YBOQZaNAwlaeG0TGnW0QKl7
         Eqtw==
X-Gm-Message-State: AOAM533ECn1y7wuaIPp1SqavgbrGMLQ0wcde9vPnSzgkkIno2eoXC1Wf
        5rfI+aMu0NXf9Ih4huEatHndikWY
X-Google-Smtp-Source: ABdhPJwhWB64ASTkDZGF0kpkz/77zGhztp1K6QcXslsFzT4I2GCYXtrvrTKCHCXmyQGkKwVEYAjuJw==
X-Received: by 2002:aed:3081:: with SMTP id 1mr63539345qtf.118.1594238952193;
        Wed, 08 Jul 2020 13:09:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 1sm1021244qki.122.2020.07.08.13.09.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:09:11 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068K9BlI006069
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:09:11 GMT
Subject: [PATCH v1 02/22] SUNRPC: Hoist trace_xprtrdma_op_allocate into
 generic code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:09:11 -0400
Message-ID: <20200708200911.22129.26084.stgit@manet.1015granger.net>
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

Introduce a tracepoint in call_allocate that reports the exact
sizes in the RPC buffer allocation request and the status of the
result. This helps catch problems with XDR buffer provisioning,
and replaces transport-specific debugging instrumentation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   30 ------------------------------
 include/trace/events/sunrpc.h   |   30 ++++++++++++++++++++++++++++++
 net/sunrpc/clnt.c               |    3 +--
 net/sunrpc/sched.c              |    2 --
 net/sunrpc/xprtrdma/transport.c |    2 --
 5 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 0f05a6e2b9cb..920621536731 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1150,36 +1150,6 @@ TRACE_EVENT(xprtrdma_decode_seg,
  ** Allocation/release of rpcrdma_reqs and rpcrdma_reps
  **/
 
-TRACE_EVENT(xprtrdma_op_allocate,
-	TP_PROTO(
-		const struct rpc_task *task,
-		const struct rpcrdma_req *req
-	),
-
-	TP_ARGS(task, req),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(const void *, req)
-		__field(size_t, callsize)
-		__field(size_t, rcvsize)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = task->tk_pid;
-		__entry->client_id = task->tk_client->cl_clid;
-		__entry->req = req;
-		__entry->callsize = task->tk_rqstp->rq_callsize;
-		__entry->rcvsize = task->tk_rqstp->rq_rcvsize;
-	),
-
-	TP_printk("task:%u@%u req=%p (%zu, %zu)",
-		__entry->task_id, __entry->client_id,
-		__entry->req, __entry->callsize, __entry->rcvsize
-	)
-);
-
 TRACE_EVENT(xprtrdma_op_free,
 	TP_PROTO(
 		const struct rpc_task *task,
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 2a43ed40b7e3..ea61628b9deb 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -517,6 +517,36 @@ DEFINE_RPC_REPLY_EVENT(stale_creds);
 DEFINE_RPC_REPLY_EVENT(bad_creds);
 DEFINE_RPC_REPLY_EVENT(auth_tooweak);
 
+TRACE_EVENT(rpc_buf_alloc,
+	TP_PROTO(
+		const struct rpc_task *task,
+		int status
+	),
+
+	TP_ARGS(task, status),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(size_t, callsize)
+		__field(size_t, recvsize)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
+		__entry->callsize = task->tk_rqstp->rq_callsize;
+		__entry->recvsize = task->tk_rqstp->rq_rcvsize;
+		__entry->status = status;
+	),
+
+	TP_printk("task:%u@%u callsize=%zu recvsize=%zu status=%d",
+		__entry->task_id, __entry->client_id,
+		__entry->callsize, __entry->recvsize, __entry->status
+	)
+);
+
 TRACE_EVENT(rpc_call_rpcerror,
 	TP_PROTO(
 		const struct rpc_task *task,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a91d1cdad9d7..2086f4389996 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1823,6 +1823,7 @@ call_allocate(struct rpc_task *task)
 	req->rq_rcvsize <<= 2;
 
 	status = xprt->ops->buf_alloc(task);
+	trace_rpc_buf_alloc(task, status);
 	xprt_inject_disconnect(xprt);
 	if (status == 0)
 		return;
@@ -1831,8 +1832,6 @@ call_allocate(struct rpc_task *task)
 		return;
 	}
 
-	dprintk("RPC: %5u rpc_buffer allocation failed\n", task->tk_pid);
-
 	if (RPC_IS_ASYNC(task) || !fatal_signal_pending(current)) {
 		task->tk_action = call_allocate;
 		rpc_delay(task, HZ>>4);
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 7eba20a88438..adce1e2ed10d 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1036,8 +1036,6 @@ int rpc_malloc(struct rpc_task *task)
 		return -ENOMEM;
 
 	buf->len = size;
-	dprintk("RPC: %5u allocated buffer of size %zu at %p\n",
-			task->tk_pid, size, buf);
 	rqst->rq_buffer = buf->data;
 	rqst->rq_rbuffer = (char *)rqst->rq_buffer + rqst->rq_callsize;
 	return 0;
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 053c8ab1265a..612b60f31302 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -586,11 +586,9 @@ xprt_rdma_allocate(struct rpc_task *task)
 
 	rqst->rq_buffer = rdmab_data(req->rl_sendbuf);
 	rqst->rq_rbuffer = rdmab_data(req->rl_recvbuf);
-	trace_xprtrdma_op_allocate(task, req);
 	return 0;
 
 out_fail:
-	trace_xprtrdma_op_allocate(task, NULL);
 	return -ENOMEM;
 }
 

