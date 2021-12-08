Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B82C46D8F5
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Dec 2021 17:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhLHQ5m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Dec 2021 11:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhLHQ5l (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Dec 2021 11:57:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD573C061746
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 08:54:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D5513CE225E
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E751EC00446
        for <linux-nfs@vger.kernel.org>; Wed,  8 Dec 2021 16:54:03 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] SUNRPC: Remove low signal-to-noise tracepoints
Date:   Wed,  8 Dec 2021 11:54:02 -0500
Message-Id:  <163898243636.1640.16855750027301323187.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.34.0
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2978; h=from:subject:message-id; bh=D19s+a/lLBFIwEGkwt6aIwB669VbJEErVsgPJHeM4i4=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhsOMkUtnQo9eMQ588t/Onjk8oC+C+X2KEIQcyEzMK SI3ELiSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYbDjJAAKCRAzarMzb2Z/l//TD/ 96xlZuTd51Oi8cgb6tzyOz1LVHrWL727qumHcqPdgW7ECuGPy24kUVkJCkHCgi4/YnWFWXzk7WC1s9 OeNm36u9oSWjVx6ut7beIepbvMozBPbcUG31Cr7+/psbVZzK4eK4PkxR/t7wQ36QOY7khnFb54v0n1 94+SZZrP38j9j2cDAmzqUUKWbEu5bL6gvKk2p0Dv6wjd7UP+1N1mKGSmyC+xDUZGQTpBAoFDuiJN7s scaH6rFH7MrT/kAgIbKikV9AH2xZEdrTZbjRglmLmXR0Ga+tjmTxuuWacVcpJ+q1tu1Iuw2GutOLnK Pc8I5Fswxrkdg+yz3Eya+JAFOmFVEobfYBN3ze3rC4xt+qSHibz6reK5JI+qD2CRbePN00bryVf0yA 8rMn8gVf4idbyXyHTNxZdDIQ+XDYHYbyA+XjXHAmnS5i0lzbuz7Gotqn69xCeJlr+cAx/RdDgKucTp ncE3ESbC/Ukm/P5lqx436+dsgHlZHY/pA6AruHUPqNk2blJ1/XHiVVuYHBCyrONm/20D4ReR+SAgkj m69NhB3ocs0WS3Bvaxc7bb2EQyNzm9xzkxDk/2sYtaT0/z39+uGyPZiO9eXw/pT9O1A58654Ltup0f KA6L17PB9GEZ1bD6u2UFKOGEHJugETIVVioHoaTjI5PzxHf4dFxap4jVkg8g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm about to add more information to the server-side SUNRPC
tracepoints, so I'm going to offset the increased trace log
consumption by getting rid of some tracepoints that fire frequently
but don't offer much value.

trace_svc_xprt_received() was useful for debugging, perhaps, but
is not generally informative.

trace_svc_handle_xprt() reports largely the same information as
trace_svc_xdr_recvfrom().

As a clean-up, rename trace_svc_xprt_do_enqueue() to match
svc_xprt_dequeue().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   24 +-----------------------
 net/sunrpc/svc_xprt.c         |    6 ++----
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3a99358c262b..684cc0e322fa 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1768,7 +1768,7 @@ TRACE_EVENT(svc_xprt_create_err,
 		__entry->error)
 );
 
-TRACE_EVENT(svc_xprt_do_enqueue,
+TRACE_EVENT(svc_xprt_enqueue,
 	TP_PROTO(struct svc_xprt *xprt, struct svc_rqst *rqst),
 
 	TP_ARGS(xprt, rqst),
@@ -1815,7 +1815,6 @@ DECLARE_EVENT_CLASS(svc_xprt_event,
 			), \
 			TP_ARGS(xprt))
 
-DEFINE_SVC_XPRT_EVENT(received);
 DEFINE_SVC_XPRT_EVENT(no_write_space);
 DEFINE_SVC_XPRT_EVENT(close);
 DEFINE_SVC_XPRT_EVENT(detach);
@@ -1902,27 +1901,6 @@ TRACE_EVENT(svc_alloc_arg_err,
 	TP_printk("pages=%u", __entry->pages)
 );
 
-TRACE_EVENT(svc_handle_xprt,
-	TP_PROTO(struct svc_xprt *xprt, int len),
-
-	TP_ARGS(xprt, len),
-
-	TP_STRUCT__entry(
-		__field(int, len)
-		__field(unsigned long, flags)
-		__string(addr, xprt->xpt_remotebuf)
-	),
-
-	TP_fast_assign(
-		__entry->len = len;
-		__entry->flags = xprt->xpt_flags;
-		__assign_str(addr, xprt->xpt_remotebuf);
-	),
-
-	TP_printk("addr=%s len=%d flags=%s", __get_str(addr),
-		__entry->len, show_svc_xprt_flags(__entry->flags))
-);
-
 TRACE_EVENT(svc_stats_latency,
 	TP_PROTO(const struct svc_rqst *rqst),
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 1e99ba1b9d72..b1744432489e 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -264,8 +264,6 @@ void svc_xprt_received(struct svc_xprt *xprt)
 		return;
 	}
 
-	trace_svc_xprt_received(xprt);
-
 	/* As soon as we clear busy, the xprt could be closed and
 	 * 'put', so we need a reference to call svc_enqueue_xprt with:
 	 */
@@ -466,7 +464,7 @@ void svc_xprt_do_enqueue(struct svc_xprt *xprt)
 out_unlock:
 	rcu_read_unlock();
 	put_cpu();
-	trace_svc_xprt_do_enqueue(xprt, rqstp);
+	trace_svc_xprt_enqueue(xprt, rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_do_enqueue);
 
@@ -842,8 +840,8 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
 	} else
 		svc_xprt_received(xprt);
+
 out:
-	trace_svc_handle_xprt(xprt, len);
 	return len;
 }
 

