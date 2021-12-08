Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF0B46D8F7
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbhLHQ5v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:57:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56396 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237374AbhLHQ5v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:57:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90AE7B82192
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48CC6C341C7
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:17 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid
Date:   Wed,  8 Dec 2021 11:54:16 -0500
Message-Id:  <163898245596.1640.1156120092081044565.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
References:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; h=from:subject:message-id; bh=tgA/XfkgG6krNAvHXpbAuOlVyCwM3z84JgEl4BkdJZo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhsOM4d5oMpADfV/NeFY9EgT8GszOUNGDl92Cn6NAA eXp7kWaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbDjOAAKCRAzarMzb2Z/lxKbEA CfVM1/ReesdO2WFXKqOJK/cmrb7VjuLE27oNA7tYIcoSxX0vq4n9BQ0fLNue/p1THzZyKeSPH8MCc1 FKONTEhV5LHY1g9rJl4Cs7FTdoQQZQVGeGqKryE0OMgr82DL8vmIXKwpWJyAD1WTL88naVWCyAYM2D UjzxF5J/+FXBGQ4aqFPidTrhOk8LbQ6mVFdNbG87uITqHcdI62rKIGkqdWroo3+4c/VWMLtafPNgVK YGShkkNTI/Tom+XcoYf3ydsVfGAFSKZu1HBnSvnbcDE/EnB62xmtoN/x7dcqlfTnYi5QEz9sYrFAX4 E2YRCv4sTB1DxSVKJZTAaq65wM/0x044doTGUTpeC2iKFju2EEbj5MMTDwC3gfPSNTtURlejugvCtt zul2MCSS1DZt39+X62RRbxDG3BHcQJp0b430Z6hf0aSysaiB78U4Eaw57n03IJWOAM/mSf51oNc8G7 ICn52rmX2mBdgY/4Lg5MYxVsiw7H/M1MIhxGSW0O/1KfvbRYW4oIjhUclvjA3e5kczkPT153Lu+Yy8 vvL1rMSdq8vebEaPrStzGQG7v6Ix9Cw+nxFjZ4EDJ2wLPd3IY2AtfSAYv8Yonkoum+et+sCRzlRLpK LKq6PBh3YSJ8eqVrrz1LRCazp+REh2csf0AMkj3325u/5qLSUFCAhU4cC/ww==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |  112 ++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 41 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 193a543d6627..188852443a33 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1832,50 +1832,99 @@ TRACE_EVENT(svc_xprt_create_err,
 		__entry->error)
 );
 
+#define SVC_XPRT_ENDPOINT_FIELDS \
+		__array(unsigned char, server, sizeof(struct sockaddr_in6)) \
+		__array(unsigned char, client, sizeof(struct sockaddr_in6)) \
+		__field(unsigned long, flags) \
+		__field(unsigned int, netns_ino)
+
+#define SVC_XPRT_ENDPOINT_ASSIGNMENTS(x) \
+		do { \
+			memcpy(__entry->server, &(x)->xpt_local, \
+			       (x)->xpt_locallen); \
+			memcpy(__entry->client, &(x)->xpt_remote, \
+			       (x)->xpt_remotelen); \
+			__entry->flags = (x)->xpt_flags; \
+			__entry->netns_ino = (x)->xpt_net->ns.inum; \
+		} while (0)
+
+#define SVC_XPRT_ENDPOINT_FORMAT \
+		"server=%pISpc client=%pISpc flags=%s"
+
+#define SVC_XPRT_ENDPOINT_VARARGS \
+		__entry->server, __entry->client, \
+		show_svc_xprt_flags(__entry->flags)
+
 TRACE_EVENT(svc_xprt_enqueue,
-	TP_PROTO(struct svc_xprt *xprt, struct svc_rqst *rqst),
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		const struct svc_rqst *rqst
+	),
 
 	TP_ARGS(xprt, rqst),
 
 	TP_STRUCT__entry(
+		SVC_XPRT_ENDPOINT_FIELDS
+
 		__field(int, pid)
-		__field(unsigned long, flags)
-		__string(addr, xprt->xpt_remotebuf)
 	),
 
 	TP_fast_assign(
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(xprt);
+
 		__entry->pid = rqst? rqst->rq_task->pid : 0;
-		__entry->flags = xprt->xpt_flags;
-		__assign_str(addr, xprt->xpt_remotebuf);
 	),
 
-	TP_printk("addr=%s pid=%d flags=%s", __get_str(addr),
-		__entry->pid, show_svc_xprt_flags(__entry->flags))
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " pid=%d",
+		SVC_XPRT_ENDPOINT_VARARGS, __entry->pid)
+);
+
+TRACE_EVENT(svc_xprt_dequeue,
+	TP_PROTO(
+		const struct svc_rqst *rqst
+	),
+
+	TP_ARGS(rqst),
+
+	TP_STRUCT__entry(
+		SVC_XPRT_ENDPOINT_FIELDS
+
+		__field(unsigned long, wakeup)
+	),
+
+	TP_fast_assign(
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
+
+		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
+							rqst->rq_qtime));
+	),
+
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu",
+		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
 );
 
 DECLARE_EVENT_CLASS(svc_xprt_event,
-	TP_PROTO(struct svc_xprt *xprt),
+	TP_PROTO(
+		const struct svc_xprt *xprt
+	),
 
 	TP_ARGS(xprt),
 
 	TP_STRUCT__entry(
-		__field(unsigned long, flags)
-		__string(addr, xprt->xpt_remotebuf)
+		SVC_XPRT_ENDPOINT_FIELDS
 	),
 
 	TP_fast_assign(
-		__entry->flags = xprt->xpt_flags;
-		__assign_str(addr, xprt->xpt_remotebuf);
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(xprt);
 	),
 
-	TP_printk("addr=%s flags=%s", __get_str(addr),
-		show_svc_xprt_flags(__entry->flags))
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT, SVC_XPRT_ENDPOINT_VARARGS)
 );
 
 #define DEFINE_SVC_XPRT_EVENT(name) \
 	DEFINE_EVENT(svc_xprt_event, svc_xprt_##name, \
 			TP_PROTO( \
-				struct svc_xprt *xprt \
+				const struct svc_xprt *xprt \
 			), \
 			TP_ARGS(xprt))
 
@@ -1893,44 +1942,25 @@ TRACE_EVENT(svc_xprt_accept,
 	TP_ARGS(xprt, service),
 
 	TP_STRUCT__entry(
-		__string(addr, xprt->xpt_remotebuf)
+		SVC_XPRT_ENDPOINT_FIELDS
+
 		__string(protocol, xprt->xpt_class->xcl_name)
 		__string(service, service)
 	),
 
 	TP_fast_assign(
-		__assign_str(addr, xprt->xpt_remotebuf);
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(xprt);
+
 		__assign_str(protocol, xprt->xpt_class->xcl_name);
 		__assign_str(service, service);
 	),
 
-	TP_printk("addr=%s protocol=%s service=%s",
-		__get_str(addr), __get_str(protocol), __get_str(service)
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " protocol=%s service=%s",
+		SVC_XPRT_ENDPOINT_VARARGS,
+		__get_str(protocol), __get_str(service)
 	)
 );
 
-TRACE_EVENT(svc_xprt_dequeue,
-	TP_PROTO(struct svc_rqst *rqst),
-
-	TP_ARGS(rqst),
-
-	TP_STRUCT__entry(
-		__field(unsigned long, flags)
-		__field(unsigned long, wakeup)
-		__string(addr, rqst->rq_xprt->xpt_remotebuf)
-	),
-
-	TP_fast_assign(
-		__entry->flags = rqst->rq_xprt->xpt_flags;
-		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
-							rqst->rq_qtime));
-		__assign_str(addr, rqst->rq_xprt->xpt_remotebuf);
-	),
-
-	TP_printk("addr=%s flags=%s wakeup-us=%lu", __get_str(addr),
-		show_svc_xprt_flags(__entry->flags), __entry->wakeup)
-);
-
 TRACE_EVENT(svc_wake_up,
 	TP_PROTO(int pid),
 

