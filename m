Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5022E430579
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhJPWtk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3DA7861242;
        Sat, 16 Oct 2021 22:47:31 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 11/14] SUNRPC: Report RPC messages with unknown procedures via a tracepoint
Date:   Sat, 16 Oct 2021 18:47:30 -0400
Message-Id:  <163442445010.1001.10719088094457400066.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; h=from:subject:message-id; bh=aNm6kGLASjw3nZXlX2HI2joHW1vORSE9rnhn7ksUAW0=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1aCowXUyg70uDGvvT3+UvcV3cF2DOXXX30qb5kn hTwk/TKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWggAKCRAzarMzb2Z/lzjQEA CrYNeaT/snhYhz1tbWw3DAqxO6dqbaqS1hx5YLSWDuy4RtO1k4dWX4eSpg5ptHh+N8jCa/vrcs25SP qWs3mjk7u8k4RgKfV3ak9WbVOQLal+6fPMCZEbM/H/Y7/hZMWowW043Yn5lCgk+4vmlpXNMAKyURBe /RjP1w1rj4mfSqAqXUdBKdv4FqEe/IHMN8h6WnWsr43S+zUsjl7CRIvY/rBJntDBeY9Of7leST2Ap5 Hm+vx1btPEWfm9xpcJcG6NVEiy9t+1ESoKqPdr0xiJuw5znajVvXAQeKDhsDgvtU/DLaLYHD1TR8Bl QcqyFAbdKv1ONfSIZr4Arkl5wrpzXs/MfYuSlQekBfjyMtnC1R2b5DmyDOA0RNT1Xh349iLXounVrQ SU5/APogwjMAnbrZhEZ7DrArOGdr3OWrw6fHmlBl6no+JdlByoe2rK+Y1TMAZPr9fZPd4V7KjrPRS4 6zE4HK1yZqFKdaP7v9PKQmGR7eBMGitRIiLCRJdfMIEsv4Sb/c7DvClLZJAoMvfGftTrOW16kN51jz Km7Ld1J6kwIuKkYlsimaGt8drfLN/rN3p9yUoHCO0P/ZPIMiFVNTEB8E1Cbvd2IeUCkDQJQOat/3lV SpJeRT1MlsuGgM3k8Vacg0BPzVD1BU7ZR0s8OO01uHNoAdg4etdwwFU6P04A==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a dprintk call site. The new tracepoint can be left enabled
persistently to capture problems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   30 ++++++++++++++++++++++++++++++
 net/sunrpc/svc.c              |    3 +--
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 804912b26abb..85459c40eb35 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1716,6 +1716,36 @@ TRACE_EVENT(svc_decode_prog_mismatch_err,
 	)
 );
 
+TRACE_EVENT(svc_decode_proc_unavail_err,
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		const struct svc_program *progp
+	),
+
+	TP_ARGS(rqst, progp),
+
+	TP_STRUCT__entry(
+		__field(u32, procedure)
+		__field(u32, version)
+		__string(progname, progp->pg_name)
+		__string(addr, rqst->rq_xprt ?
+			 rqst->rq_xprt->xpt_remotebuf : "(null)")
+	),
+
+	TP_fast_assign(
+		__entry->version = rqst->rq_vers;
+		__entry->procedure = rqst->rq_proc;
+		__assign_str(progname, progp->pg_name)
+		__assign_str(addr, rqst->rq_xprt ?
+			     rqst->rq_xprt->xpt_remotebuf : "(null)");
+	),
+
+	TP_printk("addr=%s %sv%u procedure=%u",
+		__get_str(addr), __get_str(progname),
+		__entry->version, __entry->procedure
+	)
+);
+
 DECLARE_EVENT_CLASS(svc_rqst_event,
 
 	TP_PROTO(
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 66e46d7755e9..a0f37e89393f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1414,8 +1414,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto sendit;
 
 err_bad_proc:
-	svc_printk(rqstp, "unknown procedure (%d)\n", rqstp->rq_proc);
-
+	trace_svc_decode_proc_unavail_err(rqstp, progp);
 	serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROC_UNAVAIL);
 	goto sendit;

