Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5746D8F6
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhLHQ5p (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:57:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56352 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbhLHQ5o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:57:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E26BAB821C6
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4BFC00446
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:10 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] SUNRPC: Record endpoint information in trace log
Date:   Wed,  8 Dec 2021 11:54:09 -0500
Message-Id:  <163898244928.1640.975270046099332764.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
References:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=7459; h=from:subject:message-id; bh=YRr5EkHxTky+OStoHYg0khKe4OSLZaSqz15JwzwjmBg=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhsOMx7/ymODzESK/LY78Apv1l6uj+AEbIoMQ+tKFj pI2TfrCJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbDjMQAKCRAzarMzb2Z/l9h8EA CTZUjVuRLmC9S2PnuZR8d3shqRGwJYnRR9dVo1uEMpXb5NlV7CMngOwTd+72/RO2PbdZrWvA3URGeM Pqn7mL8fH4PNJl01zkDA3PgyAYD0Wr3JOz4/exrQf5bV7p74sPHSx6HEPvF4lRQV22XTBnI05xb4wW d4vWjL8SnLBxLk6MPvulc6yjbixmPnuTVEJuYPm7xnHdN2TrhjIodk9X0rJgJNKR83zkfUW6u/XoNR eKhMrS21+si46D5gxagrYfKv7LAooYigNVBu7AUDAIiUeRQOuHmAfaRxNz7dNjwaH07rPyeHxiillH 2oR6qKPCvulWOJZvB9lK8WpMFx1Mf9SYXu1Fzxrbm2C7N0Oomx+IzKl8bM+McIUbjZwS0sCuHrPrif qnbuFbgN22bLBfl0aZ2LnO42cqmBRBlGbWfv777IQkLlGBMaOHP3VZo7wk8Y1QWLuMIMUOC0y5ppnm /WZSSWCtbv8nnagc8/6DwTMo62ErF2yCC3Z7dD4O/OlcF9Vi8mSm31NFEnGRJFaLQqrxkWNfVrAGPg cOyDGLzTXNK3l22GE4mCmFAHGOMjpKGgAZHHlgKhltBa+C6ZV6hKFZmv06biaYmA0D+P0uRBaBMlbP WjEAX6CR8++L8hnevR3qh5cr086OQUAZgLimBBkEn1lPvWbI+HVuelTOssCg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To make server-side trace events more useful in container-ized
environments, capture not just the remote's IP address, but the
local IP address and network namespace as well.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |  161 +++++++++++++++++++++++++----------------
 1 file changed, 100 insertions(+), 61 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 684cc0e322fa..193a543d6627 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1605,57 +1605,92 @@ TRACE_DEFINE_ENUM(SVC_COMPLETE);
 		{ SVC_PENDING,	"SVC_PENDING" },	\
 		{ SVC_COMPLETE,	"SVC_COMPLETE" })
 
+#define SVC_RQST_ENDPOINT_FIELDS \
+		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
+		__array(unsigned char, client, sizeof(struct sockaddr_in6)) \
+		__field(unsigned int, netns_ino) \
+		__field(u32, xid)
+
+#define SVC_RQST_ENDPOINT_ASSIGNMENTS(r) \
+		do { \
+			struct svc_xprt *xprt = (r)->rq_xprt; \
+			if (xprt) { \
+				memcpy(__entry->server, &xprt->xpt_local, \
+				       xprt->xpt_locallen); \
+				memcpy(__entry->client, &xprt->xpt_remote, \
+				       xprt->xpt_remotelen); \
+				__entry->netns_ino = xprt->xpt_net->ns.inum; \
+			} else { \
+				memset(__entry->server, 0, sizeof(__entry->server)); \
+				memset(__entry->client, 0, sizeof(__entry->client)); \
+				__entry->netns_ino = (r)->rq_bc_net->ns.inum; \
+			} \
+			__entry->xid = be32_to_cpu((r)->rq_xid); \
+		} while (0)
+
+#define SVC_RQST_ENDPOINT_FORMAT \
+		"xid=0x%08x server=%pISpc client=%pISpc"
+
+#define SVC_RQST_ENDPOINT_VARARGS \
+		__entry->xid, __entry->server, __entry->client
+
 TRACE_EVENT(svc_authenticate,
 	TP_PROTO(const struct svc_rqst *rqst, int auth_res),
 
 	TP_ARGS(rqst, auth_res),
 
 	TP_STRUCT__entry(
-		__field(u32, xid)
+		SVC_RQST_ENDPOINT_FIELDS
+
 		__field(unsigned long, svc_status)
 		__field(unsigned long, auth_stat)
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqst);
+
 		__entry->svc_status = auth_res;
 		__entry->auth_stat = be32_to_cpu(rqst->rq_auth_stat);
 	),
 
-	TP_printk("xid=0x%08x auth_res=%s auth_stat=%s",
-			__entry->xid, svc_show_status(__entry->svc_status),
-			rpc_show_auth_stat(__entry->auth_stat))
+	TP_printk(SVC_RQST_ENDPOINT_FORMAT
+		" auth_res=%s auth_stat=%s",
+		SVC_RQST_ENDPOINT_VARARGS,
+		svc_show_status(__entry->svc_status),
+		rpc_show_auth_stat(__entry->auth_stat))
 );
 
 TRACE_EVENT(svc_process,
-	TP_PROTO(const struct svc_rqst *rqst, const char *name),
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		const char *service
+	),
 
-	TP_ARGS(rqst, name),
+	TP_ARGS(rqst, service),
 
 	TP_STRUCT__entry(
-		__field(u32, xid)
+		SVC_RQST_ENDPOINT_FIELDS
+
 		__field(u32, vers)
 		__field(u32, proc)
-		__string(service, name)
+		__string(service, service)
 		__string(procedure, svc_proc_name(rqst))
-		__string(addr, rqst->rq_xprt ?
-			 rqst->rq_xprt->xpt_remotebuf : "(null)")
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqst);
+
 		__entry->vers = rqst->rq_vers;
 		__entry->proc = rqst->rq_proc;
-		__assign_str(service, name);
+		__assign_str(service, service);
 		__assign_str(procedure, svc_proc_name(rqst));
-		__assign_str(addr, rqst->rq_xprt ?
-			     rqst->rq_xprt->xpt_remotebuf : "(null)");
 	),
 
-	TP_printk("addr=%s xid=0x%08x service=%s vers=%u proc=%s",
-			__get_str(addr), __entry->xid,
-			__get_str(service), __entry->vers,
-			__get_str(procedure)
+	TP_printk(SVC_RQST_ENDPOINT_FORMAT
+		" service=%s vers=%u proc=%s (%u)",
+		SVC_RQST_ENDPOINT_VARARGS,
+		__get_str(service), __entry->vers, __get_str(procedure),
+		__entry->proc
 	)
 );
 
@@ -1668,20 +1703,20 @@ DECLARE_EVENT_CLASS(svc_rqst_event,
 	TP_ARGS(rqst),
 
 	TP_STRUCT__entry(
-		__field(u32, xid)
+		SVC_RQST_ENDPOINT_FIELDS
+
 		__field(unsigned long, flags)
-		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqst);
+
 		__entry->flags = rqst->rq_flags;
-		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s xid=0x%08x flags=%s",
-			__get_str(addr), __entry->xid,
-			show_rqstp_flags(__entry->flags))
+	TP_printk(SVC_RQST_ENDPOINT_FORMAT " flags=%s",
+		SVC_RQST_ENDPOINT_VARARGS,
+		show_rqstp_flags(__entry->flags))
 );
 #define DEFINE_SVC_RQST_EVENT(name) \
 	DEFINE_EVENT(svc_rqst_event, svc_##name, \
@@ -1694,34 +1729,63 @@ DEFINE_SVC_RQST_EVENT(defer);
 DEFINE_SVC_RQST_EVENT(drop);
 
 DECLARE_EVENT_CLASS(svc_rqst_status,
-
-	TP_PROTO(struct svc_rqst *rqst, int status),
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		int status
+	),
 
 	TP_ARGS(rqst, status),
 
 	TP_STRUCT__entry(
-		__field(u32, xid)
+		SVC_RQST_ENDPOINT_FIELDS
+
 		__field(int, status)
 		__field(unsigned long, flags)
-		__string(addr, rqst->rq_xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqst);
+
 		__entry->status = status;
 		__entry->flags = rqst->rq_flags;
-		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s xid=0x%08x status=%d flags=%s",
-		  __get_str(addr), __entry->xid,
-		  __entry->status, show_rqstp_flags(__entry->flags))
+	TP_printk(SVC_RQST_ENDPOINT_FORMAT " status=%d flags=%s",
+		SVC_RQST_ENDPOINT_VARARGS,
+		__entry->status, show_rqstp_flags(__entry->flags))
 );
 
 DEFINE_EVENT(svc_rqst_status, svc_send,
-	TP_PROTO(struct svc_rqst *rqst, int status),
+	TP_PROTO(const struct svc_rqst *rqst, int status),
 	TP_ARGS(rqst, status));
 
+TRACE_EVENT(svc_stats_latency,
+	TP_PROTO(
+		const struct svc_rqst *rqst
+	),
+
+	TP_ARGS(rqst),
+
+	TP_STRUCT__entry(
+		SVC_RQST_ENDPOINT_FIELDS
+
+		__field(unsigned long, execute)
+		__string(procedure, svc_proc_name(rqst))
+	),
+
+	TP_fast_assign(
+		SVC_RQST_ENDPOINT_ASSIGNMENTS(rqst);
+
+		__entry->execute = ktime_to_us(ktime_sub(ktime_get(),
+							 rqst->rq_stime));
+		__assign_str(procedure, svc_proc_name(rqst));
+	),
+
+	TP_printk(SVC_RQST_ENDPOINT_FORMAT " proc=%s execute-us=%lu",
+		SVC_RQST_ENDPOINT_VARARGS,
+		__get_str(procedure), __entry->execute)
+);
+
 #define show_svc_xprt_flags(flags)					\
 	__print_flags(flags, "|",					\
 		{ (1UL << XPT_BUSY),		"XPT_BUSY"},		\
@@ -1901,31 +1965,6 @@ TRACE_EVENT(svc_alloc_arg_err,
 	TP_printk("pages=%u", __entry->pages)
 );
 
-TRACE_EVENT(svc_stats_latency,
-	TP_PROTO(const struct svc_rqst *rqst),
-
-	TP_ARGS(rqst),
-
-	TP_STRUCT__entry(
-		__field(u32, xid)
-		__field(unsigned long, execute)
-		__string(procedure, svc_proc_name(rqst))
-		__string(addr, rqst->rq_xprt->xpt_remotebuf)
-	),
-
-	TP_fast_assign(
-		__entry->xid = be32_to_cpu(rqst->rq_xid);
-		__entry->execute = ktime_to_us(ktime_sub(ktime_get(),
-							 rqst->rq_stime));
-		__assign_str(procedure, svc_proc_name(rqst));
-		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
-	),
-
-	TP_printk("addr=%s xid=0x%08x proc=%s execute-us=%lu",
-		__get_str(addr), __entry->xid, __get_str(procedure),
-		__entry->execute)
-);
-
 DECLARE_EVENT_CLASS(svc_deferred_event,
 	TP_PROTO(
 		const struct svc_deferred_req *dr

