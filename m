Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB432AC529
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbgKITkC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITkC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:40:02 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C823C0613CF;
        Mon,  9 Nov 2020 11:40:01 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id b18so9103913qkc.9;
        Mon, 09 Nov 2020 11:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=s7U1FxZ+z7GUy8ieTH2Y2E7zdKp7EwHjHeiJIQb/jhU=;
        b=eJdb2yeKeclQtKcJY5NcSXhQyxo22YdH0/0uHVlw3xqQPM5PnA1gVW7yjZELF1GKiH
         lp6GK7K4/gypm5w50L9AXMevJLYPNAAGVi2bMXMzZXZPTM2EzOMmFMiUgrn47h5XTNJt
         0z35HYZVT2ldanNuvRCHj7yo08uAI39bEThbyq16zrRM5K6T73U5TMKFt15w9Izizes0
         aOhnMKkOC/s8GTOUEp5817+zgBrjTdBDqkUhQ1vo2DUQdybRNSK33rqX0NcRhtZwCVkl
         DgIqe77fOJnyq7ZpcHa9ePR10pDvuiOI7Sb/puT4n8n/6d5IZF6E2vrb43l2tsZjOmfS
         0eyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=s7U1FxZ+z7GUy8ieTH2Y2E7zdKp7EwHjHeiJIQb/jhU=;
        b=Ui8lirRgvl1MRvISljR5B90BHZVNVN3OC0p58YTasDPGXxmYXRonEXmsi071D+54L3
         MURSVfRQsh9AE67vcLkzIhhNBTHiVM1p2mFUVC00ezjR4q8RPmRp1tG8iotmDXfAvKLd
         7f1OZFN2Q/Qa6oamyevOJMECGawnJzQbqi+aEBB2NQ9LVs0+6d1ISNHikW4vZlh527WX
         mz6gDDYFu+QPb08QAFuUPjbi6uSuo8RVtJaczMg0OCl60iM2td240Acd9I6E5LRb+wFd
         8dVrAwrEdsosbrfRRVTYF2y95OT1mVMEJak8r9oe+mLjqBOjrtECVhgsr+c1h8k0N6cz
         wO+A==
X-Gm-Message-State: AOAM531sm3hnP+wdbrOBuCqsstt/oskWZC9CVf8OY8/cvTTPzCV0kyqT
        WbaQQ8ysryDvV1bTvdz/HEj3ahUzgAw=
X-Google-Smtp-Source: ABdhPJwSnxSyiukYSMHjvyn2mq2GN46jHZA/vInNsLVQsT1F+/+HOYr0ZVyG08GB8tDzo8uIexS4EQ==
X-Received: by 2002:a37:5904:: with SMTP id n4mr15378604qkb.364.1604950800010;
        Mon, 09 Nov 2020 11:40:00 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j124sm4495647qkf.113.2020.11.09.11.39.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:59 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9Jdwjk021816;
        Mon, 9 Nov 2020 19:39:58 GMT
Subject: [PATCH v1 09/13] xprtrdma: Clean up trace_xprtrdma_nomrs()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:58 -0500
Message-ID: <160495079830.2072548.3366377773172889012.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

- Rename it following the "_err" suffix convention
- Replace display of kernel memory addresses
- Tie MR exhaustion to a peer IP address, similar to the createmrs
   tracepoint

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   19 ++++++++++---------
 net/sunrpc/xprtrdma/rpc_rdma.c |    2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 6bdbe1165270..4fcda2a25bb8 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -545,32 +545,33 @@ TRACE_EVENT(xprtrdma_mr_get,
 	)
 );
 
-TRACE_EVENT(xprtrdma_nomrs,
+TRACE_EVENT(xprtrdma_nomrs_err,
 	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
 		const struct rpcrdma_req *req
 	),
 
-	TP_ARGS(req),
+	TP_ARGS(r_xprt, req),
 
 	TP_STRUCT__entry(
-		__field(const void *, req)
 		__field(unsigned int, task_id)
 		__field(unsigned int, client_id)
-		__field(u32, xid)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
 	),
 
 	TP_fast_assign(
 		const struct rpc_rqst *rqst = &req->rl_slot;
 
-		__entry->req = req;
 		__entry->task_id = rqst->rq_task->tk_pid;
 		__entry->client_id = rqst->rq_task->tk_client->cl_clid;
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("task:%u@%u xid=0x%08x req=%p",
-		__entry->task_id, __entry->client_id, __entry->xid,
-		__entry->req
+	TP_printk("peer=[%s]:%s task:%u@%u",
+		__get_str(addr), __get_str(port),
+		__entry->task_id, __entry->client_id
 	)
 );
 
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 8078559bdc31..f27eb2322b38 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -323,7 +323,7 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
 	return frwr_map(r_xprt, seg, nsegs, writing, req->rl_slot.rq_xid, *mr);
 
 out_getmr_err:
-	trace_xprtrdma_nomrs(req);
+	trace_xprtrdma_nomrs_err(r_xprt, req);
 	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
 	rpcrdma_mrs_refresh(r_xprt);
 	return ERR_PTR(-EAGAIN);


