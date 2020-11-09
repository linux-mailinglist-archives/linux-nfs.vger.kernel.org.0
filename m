Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095DE2AC525
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgKITjv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITjv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:51 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38C2C0613CF;
        Mon,  9 Nov 2020 11:39:50 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id l2so9129927qkf.0;
        Mon, 09 Nov 2020 11:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=JY/P8KIws5TAga7tUT3/gSDQCvJoPVAqnDHVNoHGMUc=;
        b=ddv5SS0nrLrvukVPPlIQhneHbzizOnOpBa/l6U5SeOPiBi1wF7R6is9FJJgIt2kFpV
         K/BhsY/5EX6QW5ZQfNuR8KZenQ3ayEAGsV8zOFPZ9s6Y5JkZzn0LgJWnTPVvp4ZqsiEC
         KY2jb87ynnicRKpmBjSgmvwG7J8nVa32UifBSoVAByX0MFuSGHkn9NVVdFQKjF5ASLhW
         7/MjMmDydrrjl7kzjVZYN/mZxtrdxHuj3j7AnbDXpbNZKgsiCTKkYFbVfwPG0lC6c9aR
         gC87wVEprIqLiQqmWfvItHp1DBs3kptikfN71hRz/aiuPaxBPagLkBJ+MpcfaYSdA08K
         JrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=JY/P8KIws5TAga7tUT3/gSDQCvJoPVAqnDHVNoHGMUc=;
        b=dc6hhxAHe6azNgKdMXbqAKarny40v9AKe1Q0HrWpVtzd9tEsOm4L8H8O6WgQKJ48/U
         dkiH2PTQWakkrqV0PHAZ4yObAGGKixi++nWneXbPg2hX+4ZmLyK0nepa4hOHS/6F7RYQ
         SI6LMzc/bR9f1dkn5DzAGRJmvRe+7S71n267HPx5cWgFDuwY9uCSi/Dbtkf1tfaxCn0f
         gSV0ZjD+CGeDpdO4g6hKSSFYJqZdIpdouw2CDaLp9ktmncZOMwET0E00WYzZhlyHzAI6
         0F005/kovq3ftjZHMW7EsqaoQ3zNVlz+SpFpvHek+gicXtmTwwdit3mYIlzYnggkY/qD
         8TJg==
X-Gm-Message-State: AOAM533UoQantaumUqZ86iNLI/kRRTzeqYfFIPk4Dk3/8mMfgOlD6vKM
        XJO87oXUfvE3k76AFFfh+pVg4fzikZo=
X-Google-Smtp-Source: ABdhPJzD2x4CcVI8PGOtQ3e9tywamaZnpT6RoskSuiPjwfpxMNOwu8HDFNzPAU9dqRktZ2ainGRJ5A==
X-Received: by 2002:a37:6c06:: with SMTP id h6mr15579090qkc.288.1604950789517;
        Mon, 09 Nov 2020 11:39:49 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f61sm6332687qtb.75.2020.11.09.11.39.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:48 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9JdluR021810;
        Mon, 9 Nov 2020 19:39:47 GMT
Subject: [PATCH v1 07/13] xprtrdma: Clean up tracepoints in the reply path
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:47 -0500
Message-ID: <160495078762.2072548.8813363103493808175.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace unnecessary display of kernel memory addresses.

Also, there are no longer any trace_xprtrdma_defer_cmp() call sites.
And remove the trace_xprtrdma_leaked_rep() tracepoint because there
doesn't seem to be an overwhelming need to have a tracepoint for
catching a software bug that has long since been fixed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   66 ++--------------------------------------
 net/sunrpc/xprtrdma/rpc_rdma.c |    6 +---
 2 files changed, 5 insertions(+), 67 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 93d717d8139f..c28bf17e769b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -974,17 +974,14 @@ TRACE_EVENT(xprtrdma_reply,
 	TP_PROTO(
 		const struct rpc_task *task,
 		const struct rpcrdma_rep *rep,
-		const struct rpcrdma_req *req,
 		unsigned int credits
 	),
 
-	TP_ARGS(task, rep, req, credits),
+	TP_ARGS(task, rep, credits),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
-		__field(const void *, rep)
-		__field(const void *, req)
 		__field(u32, xid)
 		__field(unsigned int, credits)
 	),
@@ -992,42 +989,13 @@ TRACE_EVENT(xprtrdma_reply,
 	TP_fast_assign(
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client->cl_clid;
-		__entry->rep = rep;
-		__entry->req = req;
 		__entry->xid = be32_to_cpu(rep->rr_xid);
 		__entry->credits = credits;
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x, %u credits, rep=%p -> req=%p",
-		__entry->task_id, __entry->client_id, __entry->xid,
-		__entry->credits, __entry->rep, __entry->req
-	)
-);
-
-TRACE_EVENT(xprtrdma_defer_cmp,
-	TP_PROTO(
-		const struct rpcrdma_rep *rep
-	),
-
-	TP_ARGS(rep),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(const void *, rep)
-		__field(u32, xid)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = rep->rr_rqst->rq_task->tk_pid;
-		__entry->client_id = rep->rr_rqst->rq_task->tk_client->cl_clid;
-		__entry->rep = rep;
-		__entry->xid = be32_to_cpu(rep->rr_xid);
-	),
-
-	TP_printk("task:%u@%u xid=0x%08x rep=%p",
+	TP_printk("task:%u@%u xid=0x%08x credits=%u",
 		__entry->task_id, __entry->client_id, __entry->xid,
-		__entry->rep
+		__entry->credits
 	)
 );
 
@@ -1212,34 +1180,6 @@ TRACE_EVENT(xprtrdma_cb_setup,
 DEFINE_CB_EVENT(xprtrdma_cb_call);
 DEFINE_CB_EVENT(xprtrdma_cb_reply);
 
-TRACE_EVENT(xprtrdma_leaked_rep,
-	TP_PROTO(
-		const struct rpc_rqst *rqst,
-		const struct rpcrdma_rep *rep
-	),
-
-	TP_ARGS(rqst, rep),
-
-	TP_STRUCT__entry(
-		__field(unsigned int, task_id)
-		__field(unsigned int, client_id)
-		__field(u32, xid)
-		__field(const void *, rep)
-	),
-
-	TP_fast_assign(
-		__entry->task_id = rqst->rq_task->tk_pid;
-		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->rep = rep;
-	),
-
-	TP_printk("task:%u@%u xid=0x%08x rep=%p",
-		__entry->task_id, __entry->client_id, __entry->xid,
-		__entry->rep
-	)
-);
-
 /**
  ** Server-side RPC/RDMA events
  **/
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 29f847c8f609..8078559bdc31 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1443,14 +1443,12 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	rpcrdma_post_recvs(r_xprt, false);
 
 	req = rpcr_to_rdmar(rqst);
-	if (req->rl_reply) {
-		trace_xprtrdma_leaked_rep(rqst, req->rl_reply);
+	if (unlikely(req->rl_reply))
 		rpcrdma_recv_buffer_put(req->rl_reply);
-	}
 	req->rl_reply = rep;
 	rep->rr_rqst = rqst;
 
-	trace_xprtrdma_reply(rqst->rq_task, rep, req, credits);
+	trace_xprtrdma_reply(rqst->rq_task, rep, credits);
 
 	if (rep->rr_wc_flags & IB_WC_WITH_INVALIDATE)
 		frwr_reminv(rep, &req->rl_registered);


