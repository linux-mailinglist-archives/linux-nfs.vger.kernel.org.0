Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC76F2AC523
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Nov 2020 20:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgKITjp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Nov 2020 14:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgKITjp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Nov 2020 14:39:45 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718C5C0613CF;
        Mon,  9 Nov 2020 11:39:45 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id h15so9081438qkl.13;
        Mon, 09 Nov 2020 11:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pFmSTPq2X6QoYR0uzNsi6sAGzG1HoxcBY5oCQljopBM=;
        b=N1s/Z2yp7ojCW7vty2oumHHzUH9dSbWUryjTkmeWBin4WVevHaJzfhkm9Z1aElD+DY
         52bw+h/GrakBSoyalnHTJLDgMVAghUXunUwHCOYIlreGw+KfcKqhH8+lN/IQXpGOBLzk
         9QF4ezLsMJa5lDTydH1WvHsoOYM0Epvp3q4K6c2geqmKHBg+IeFnRUBC8R0kSvkO1Qdl
         BWTSCn4cWElzVq1D+egwbhAcLp51VmZyC9hHHZgKX9VCu4dQYcv2tcWDCo258uFFg+iF
         3eRY6kM7G3zmKDRwyHpER18DsJ6fovsrlnv9ZrlqLLuik3sh6HJMz3F4unbezXXWdEZv
         /zgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pFmSTPq2X6QoYR0uzNsi6sAGzG1HoxcBY5oCQljopBM=;
        b=J7PhF3SmgkeoD58SuMWZO6CAxjZpEf3Uswlu5cDOV1pZYjRz83It7pDK03MgvmgFJ5
         H51T4WS2dG5zx7Sk6ZwPXinJMoYopbhuwtOPNQkvGVcyYIkrbbJsahHAO0qLCJltGbru
         oCP679Cw/gfuNtTxzLUSPSNkDG0ZW/vPOGr3/lVb98okqpBYVsuT82n+IiuLJ7Z8d8XO
         zLIZslvTSOsNtdfLAmBZuSi5+lQ0A4uCxlPrc30lhGtdv3c4OGlTw9jWXPf5XHVxXvRp
         +0E/xdbqHK3KgEfNE9PxRxbp/QZv6T+vawOZM43zyKF3zePrUt1aIUpen7PADoQvYRdN
         5d1g==
X-Gm-Message-State: AOAM5338E1z2YG+ylZVUbp8oD+6zqYAtTg8rVBpt5f6yTANQOVLT2jsF
        MWzwNTZECn0gRGBg+0/+HEyFNxqINtI=
X-Google-Smtp-Source: ABdhPJzFfIR5HyUfkVAzAHFsU5h3QtBMFgjHeCSzUvggbkOo3wKbHgazP7PDLO/yZ4Mat54+cTPUvg==
X-Received: by 2002:a05:620a:697:: with SMTP id f23mr15132905qkh.374.1604950784300;
        Mon, 09 Nov 2020 11:39:44 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v14sm6671285qkb.15.2020.11.09.11.39.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 11:39:43 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0A9Jdg4S021807;
        Mon, 9 Nov 2020 19:39:42 GMT
Subject: [PATCH v1 06/13] xprtrdma: Clean up reply parsing error tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 09 Nov 2020 14:39:42 -0500
Message-ID: <160495078250.2072548.16793898833643155194.stgit@manet.1015granger.net>
In-Reply-To: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
References: <160495073877.2072548.16070760241273615384.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

- Rename the tracepoints with the "_err" suffix to indicate these
  are rare error events
- Replace display of kernel memory addresses
- Tie the XID and error to a connection IP address instead

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |   27 ++++++++++++++-------------
 net/sunrpc/xprtrdma/rpc_rdma.c |   10 +++++-----
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index b0750c0d2753..93d717d8139f 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -60,7 +60,7 @@ DECLARE_EVENT_CLASS(rpcrdma_completion_class,
 				),					\
 				TP_ARGS(wc, cid))
 
-DECLARE_EVENT_CLASS(xprtrdma_reply_event,
+DECLARE_EVENT_CLASS(xprtrdma_reply_class,
 	TP_PROTO(
 		const struct rpcrdma_rep *rep
 	),
@@ -68,29 +68,30 @@ DECLARE_EVENT_CLASS(xprtrdma_reply_event,
 	TP_ARGS(rep),
 
 	TP_STRUCT__entry(
-		__field(const void *, rep)
-		__field(const void *, r_xprt)
 		__field(u32, xid)
 		__field(u32, version)
 		__field(u32, proc)
+		__string(addr, rpcrdma_addrstr(rep->rr_rxprt))
+		__string(port, rpcrdma_portstr(rep->rr_rxprt))
 	),
 
 	TP_fast_assign(
-		__entry->rep = rep;
-		__entry->r_xprt = rep->rr_rxprt;
 		__entry->xid = be32_to_cpu(rep->rr_xid);
 		__entry->version = be32_to_cpu(rep->rr_vers);
 		__entry->proc = be32_to_cpu(rep->rr_proc);
+		__assign_str(addr, rpcrdma_addrstr(rep->rr_rxprt));
+		__assign_str(port, rpcrdma_portstr(rep->rr_rxprt));
 	),
 
-	TP_printk("rxprt %p xid=0x%08x rep=%p: version %u proc %u",
-		__entry->r_xprt, __entry->xid, __entry->rep,
-		__entry->version, __entry->proc
+	TP_printk("peer=[%s]:%s xid=0x%08x version=%u proc=%u",
+		__get_str(addr), __get_str(port),
+		__entry->xid, __entry->version, __entry->proc
 	)
 );
 
 #define DEFINE_REPLY_EVENT(name)					\
-		DEFINE_EVENT(xprtrdma_reply_event, name,		\
+		DEFINE_EVENT(xprtrdma_reply_class,			\
+				xprtrdma_reply_##name##_err,		\
 				TP_PROTO(				\
 					const struct rpcrdma_rep *rep	\
 				),					\
@@ -1030,10 +1031,10 @@ TRACE_EVENT(xprtrdma_defer_cmp,
 	)
 );
 
-DEFINE_REPLY_EVENT(xprtrdma_reply_vers);
-DEFINE_REPLY_EVENT(xprtrdma_reply_rqst);
-DEFINE_REPLY_EVENT(xprtrdma_reply_short);
-DEFINE_REPLY_EVENT(xprtrdma_reply_hdr);
+DEFINE_REPLY_EVENT(vers);
+DEFINE_REPLY_EVENT(rqst);
+DEFINE_REPLY_EVENT(short);
+DEFINE_REPLY_EVENT(hdr);
 
 TRACE_EVENT(xprtrdma_err_vers,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index c178f93aa40b..29f847c8f609 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (c) 2014-2017 Oracle.  All rights reserved.
+ * Copyright (c) 2014-2020, Oracle and/or its affiliates.
  * Copyright (c) 2003-2007 Network Appliance, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
@@ -1369,7 +1369,7 @@ void rpcrdma_complete_rqst(struct rpcrdma_rep *rep)
 	return;
 
 out_badheader:
-	trace_xprtrdma_reply_hdr(rep);
+	trace_xprtrdma_reply_hdr_err(rep);
 	r_xprt->rx_stats.bad_reply_count++;
 	rqst->rq_task->tk_status = status;
 	status = 0;
@@ -1462,16 +1462,16 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	return;
 
 out_badversion:
-	trace_xprtrdma_reply_vers(rep);
+	trace_xprtrdma_reply_vers_err(rep);
 	goto out;
 
 out_norqst:
 	spin_unlock(&xprt->queue_lock);
-	trace_xprtrdma_reply_rqst(rep);
+	trace_xprtrdma_reply_rqst_err(rep);
 	goto out;
 
 out_shortreply:
-	trace_xprtrdma_reply_short(rep);
+	trace_xprtrdma_reply_short_err(rep);
 
 out:
 	rpcrdma_recv_buffer_put(rep);


