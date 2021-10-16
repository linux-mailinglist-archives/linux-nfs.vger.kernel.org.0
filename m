Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582B043057A
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbhJPWtq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:53862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4B4461242;
        Sat, 16 Oct 2021 22:47:37 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 12/14] SUNRPC: Report RPC messages that can't be decoded via a tracepoint
Date:   Sat, 16 Oct 2021 18:47:36 -0400
Message-Id:  <163442445665.1001.12306562080032764704.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; h=from:subject:message-id; bh=OWxQlg3RAr67opp/JhqS8r2GtyYYUau4w6Iu0KNv6ic=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1aILUROZdXzaFZklU8IJ7sl5vCJV2V69NyqhzJU 3iFsKbiJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWiAAKCRAzarMzb2Z/lyysD/ 4lViBKrZXKUnq5Ow9QprbhlJYf0i/1EgvQwugAq+Kv3myLsKMyjDnULzmwDxP6uijyBFHL5ts7KRaN cqfN+GUZYiufO0E8RcjI3fzE7SmAeSAcbUAHSyMCo5MoyrhObU/WuXEsrPoVu9veszitwCl0mCeOh8 L1xlihRbgAvGR6LBPc9Gct4fDT7MZ9YG7mcwCg7LX3arcUYQ+wuok+MgYDHxlf4hwSpGT3q2FUeXuP Y10aSsrh/kKvxyO81TeVHnIRfZY8Jj8N54vValXYjArMTxgwXhO+vUlYdXmHsmMIJ1tlXBPslfER44 uRpptQHw28GtuMcuZDjcBVn9lIYV523/qa1tsPbrLXRwaHLSgXJkFPGriW1Vi1hEV2Xu1TQ7KX0v9l FJKRtBrpxzRIclQvCNzvgTFIrEDqnV4qz85CP4nR4tvo/rh2uvOxSyD9wdmA91sarXPulWudfRqSzk nWL8koi7CYf9/Jm2nVKxJp/+Wwc1KYn/3jGkhLEYpnrJTKwIfgHYErQFRVLZxNurw/2FheTjRPqCNH 9iOd229h6G5xCjXZizuE8sSWWFpCKK39Z5BpjGXCGyDmWBI+mlWUJnDrIGMp2z+E9RM2sIcHy3/gW5 in+x3xqM3+aO0jzITTaxhZOmOlDwL53+PeFFLrlJ8PqNtJ7WoVOYj+akWTIQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a dprintk call site. The new tracepoint can be left enabled
persistently to capture problems.

This commit removes the last remaining call site for svc_printk(),
so that function is removed as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   20 ++++++++++++++++++++
 net/sunrpc/svc.c              |   29 +----------------------------
 2 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 85459c40eb35..9d0e7904230e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1746,6 +1746,26 @@ TRACE_EVENT(svc_decode_proc_unavail_err,
 	)
 );
 
+TRACE_EVENT(svc_decode_header_err,
+	TP_PROTO(
+		const struct svc_rqst *rqst
+	),
+
+	TP_ARGS(rqst),
+
+	TP_STRUCT__entry(
+		__string(addr, rqst->rq_xprt ?
+			 rqst->rq_xprt->xpt_remotebuf : "(null)")
+	),
+
+	TP_fast_assign(
+		__assign_str(addr, rqst->rq_xprt ?
+			     rqst->rq_xprt->xpt_remotebuf : "(null)");
+	),
+
+	TP_printk("addr=%s", __get_str(addr))
+);
+
 DECLARE_EVENT_CLASS(svc_rqst_event,
 
 	TP_PROTO(
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a0f37e89393f..ae3c2d31d6dc 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -33,8 +33,6 @@
 
 #include "fail.h"
 
-#define RPCDBG_FACILITY	RPCDBG_SVCDSP
-
 static void svc_unregister(const struct svc_serv *serv, struct net *net);
 
 #define svc_serv_is_pooled(serv)    ((serv)->sv_ops->svo_function)
@@ -1156,30 +1154,6 @@ static void svc_unregister(const struct svc_serv *serv, struct net *net)
 	spin_unlock_irqrestore(&current->sighand->siglock, flags);
 }
 
-/*
- * dprintk the given error with the address of the client that caused it.
- */
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-static __printf(2, 3)
-void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...)
-{
-	struct va_format vaf;
-	va_list args;
-	char 	buf[RPC_MAX_ADDRBUFLEN];
-
-	va_start(args, fmt);
-
-	vaf.fmt = fmt;
-	vaf.va = &args;
-
-	dprintk("svc: %s: %pV", svc_print_addr(rqstp, buf, sizeof(buf)), &vaf);
-
-	va_end(args);
-}
-#else
-static __printf(2,3) void svc_printk(struct svc_rqst *rqstp, const char *fmt, ...) {}
-#endif
-
 __be32
 svc_generic_init_request(struct svc_rqst *rqstp,
 		const struct svc_program *progp,
@@ -1420,8 +1394,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto sendit;
 
 err_garbage:
-	svc_printk(rqstp, "failed to decode args\n");
-
+	trace_svc_decode_header_err(rqstp);
 	rpc_stat = rpc_garbage_args;
 err_bad:
 	serv->sv_stats->rpcbadfmt++;

