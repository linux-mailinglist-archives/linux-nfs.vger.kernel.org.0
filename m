Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF1A2C1593
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Nov 2020 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgKWUEX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Nov 2020 15:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgKWUEX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Nov 2020 15:04:23 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C62C0613CF
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:23 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z188so6803061qke.9
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=tDjUj9OHG3MgWfymkB8Z0cJsQnH7QZk73EqARM1nLzM=;
        b=Tz68b0u33h0YXFePiq90M+nmlkPuH/TGpX5itjL9S8BHJhBKJB2CB9dvUR1YODEJ93
         8Y3m8o9DPTM4HeM7cAsUt+1PZtUBpqJPFxe/d8q8VqxAUJPWan4AdPy7iLct2BlgCD4v
         bEBdFBTsgHgAxvyDZS2KAo5FtRjMnhVMSWS+2yDeT2WORgC686D//lVlufQvNSJjQl+E
         BN6tbYswOUvyy4W/fD11ZCHHn9bMPEzRvwVKhddKamEOzl52IBlY3I/4GuAk8GJHmUaA
         3uvvTuZi98afc+kR3ViZFEIgnu5x0uf7BYU3wGU1G2u1qAU+3BMQhKE0jDlXPueYnPWF
         OrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=tDjUj9OHG3MgWfymkB8Z0cJsQnH7QZk73EqARM1nLzM=;
        b=ZRxOm9wtYNR+CRTvNzvUSdRfAzqwNa+S+C3O1nqNF2dyClMU06bdaXH83o/Jc+nbGt
         Y7bE+y2aLZRGwI/KopWH7CTsbF243LQnZw+BEVz7J7Z9jiPAIEc1jKQ6z2C/wyeAohIg
         XrtUw3PuvXFq2gV/mCnrnj9AdjoFrbwylArsMibDI4gknUwThhQUEsdRJgh1xF8pP02W
         eYhj4zNYovqNtTlJc8D1beCaXjCjOByNhz4NuHGbqtUa7dIZc/1ZSMa57qiMDBo2pa3g
         +EBfeifFAu6q1OSz9NWZck9SI7gjWcLkSO3X8yASQTR5YqFxGx2Rgc2hNmlPRnZIXXJ3
         Imlw==
X-Gm-Message-State: AOAM530TcjqeoNo3tkHuoqrlpZjRqvsuHJz9u4R+ppSVN62Qwb2PSvJr
        sqqWaO+jO+FXGtBJRTzawRX3i3CsJNI=
X-Google-Smtp-Source: ABdhPJzNEYav66oMngNQYkhB1l/CDpJIQkv6Ah8OjvYAnpKZLFq4y0s+dLO7RN5B8F7qwkwbbn31/Q==
X-Received: by 2002:a37:b4e:: with SMTP id 75mr1165702qkl.78.1606161862038;
        Mon, 23 Nov 2020 12:04:22 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id c9sm10257847qkm.116.2020.11.23.12.04.21
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2020 12:04:21 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ANK4KDV010279
        for <linux-nfs@vger.kernel.org>; Mon, 23 Nov 2020 20:04:20 GMT
Subject: [PATCH v3 04/85] NFSD: Add tracepoints in nfsd_dispatch()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 23 Nov 2020 15:04:20 -0500
Message-ID: <160616186042.51996.15361343804924022774.stgit@klimt.1015granger.net>
In-Reply-To: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
References: <160616177104.51996.14915419165992024951.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For troubleshooting purposes, record GARBAGE_ARGS and CANT_ENCODE
failures.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c |   17 +++++----------
 fs/nfsd/trace.h  |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c4c646f25f1c..7214e578c09c 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -29,6 +29,8 @@
 #include "netns.h"
 #include "filecache.h"
 
+#include "trace.h"
+
 #define NFSDDBG_FACILITY	NFSDDBG_SVC
 
 bool inter_copy_offload_enable;
@@ -1009,11 +1011,8 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 	struct kvec *resv = &rqstp->rq_res.head[0];
 	__be32 *p;
 
-	dprintk("nfsd_dispatch: vers %d proc %d\n",
-				rqstp->rq_vers, rqstp->rq_proc);
-
 	if (nfs_request_too_big(rqstp, proc))
-		goto out_too_large;
+		goto out_decode_err;
 
 	/*
 	 * Give the xdr decoder a chance to change this if it wants
@@ -1052,24 +1051,18 @@ int nfsd_dispatch(struct svc_rqst *rqstp, __be32 *statp)
 out_cached_reply:
 	return 1;
 
-out_too_large:
-	dprintk("nfsd: NFSv%d argument too large\n", rqstp->rq_vers);
-	*statp = rpc_garbage_args;
-	return 1;
-
 out_decode_err:
-	dprintk("nfsd: failed to decode arguments!\n");
+	trace_nfsd_garbage_args_err(rqstp);
 	*statp = rpc_garbage_args;
 	return 1;
 
 out_update_drop:
-	dprintk("nfsd: Dropping request; may be revisited later\n");
 	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
 out_dropit:
 	return 0;
 
 out_encode_err:
-	dprintk("nfsd: failed to encode result!\n");
+	trace_nfsd_cant_encode_err(rqstp);
 	nfsd_cache_update(rqstp, RC_NOCACHE, NULL);
 	*statp = rpc_system_err;
 	return 1;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 89f218d0279c..0bf1707bd846 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,66 @@
 #include "export.h"
 #include "nfsfh.h"
 
+#define NFSD_TRACE_PROC_ARG_FIELDS \
+		__field(unsigned int, netns_ino) \
+		__field(u32, xid) \
+		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
+		__array(unsigned char, client, sizeof(struct sockaddr_in6))
+
+#define NFSD_TRACE_PROC_ARG_ASSIGNMENTS \
+		do { \
+			__entry->netns_ino = SVC_NET(rqstp)->ns.inum; \
+			__entry->xid = be32_to_cpu(rqstp->rq_xid); \
+			memcpy(__entry->server, &rqstp->rq_xprt->xpt_local, \
+			       rqstp->rq_xprt->xpt_locallen); \
+			memcpy(__entry->client, &rqstp->rq_xprt->xpt_remote, \
+			       rqstp->rq_xprt->xpt_remotelen); \
+		} while (0);
+
+TRACE_EVENT(nfsd_garbage_args_err,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+	TP_ARGS(rqstp),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_ARG_FIELDS
+
+		__field(u32, vers)
+		__field(u32, proc)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_ARG_ASSIGNMENTS
+
+		__entry->vers = rqstp->rq_vers;
+		__entry->proc = rqstp->rq_proc;
+	),
+	TP_printk("xid=0x%08x vers=%u proc=%u",
+		__entry->xid, __entry->vers, __entry->proc
+	)
+);
+
+TRACE_EVENT(nfsd_cant_encode_err,
+	TP_PROTO(
+		const struct svc_rqst *rqstp
+	),
+	TP_ARGS(rqstp),
+	TP_STRUCT__entry(
+		NFSD_TRACE_PROC_ARG_FIELDS
+
+		__field(u32, vers)
+		__field(u32, proc)
+	),
+	TP_fast_assign(
+		NFSD_TRACE_PROC_ARG_ASSIGNMENTS
+
+		__entry->vers = rqstp->rq_vers;
+		__entry->proc = rqstp->rq_proc;
+	),
+	TP_printk("xid=0x%08x vers=%u proc=%u",
+		__entry->xid, __entry->vers, __entry->proc
+	)
+);
+
 #define show_nfsd_may_flags(x)						\
 	__print_flags(x, "|",						\
 		{ NFSD_MAY_EXEC,		"EXEC" },		\


