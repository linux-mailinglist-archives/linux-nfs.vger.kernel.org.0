Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80F430578
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhJPWte (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWtd (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB46361242;
        Sat, 16 Oct 2021 22:47:24 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 10/14] SUNRPC: Report RPC messages with unknown versions via a tracepoint
Date:   Sat, 16 Oct 2021 18:47:23 -0400
Message-Id:  <163442444354.1001.15864029868683063345.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; h=from:subject:message-id; bh=fARa1NmQNXxfVhnPC3lDsTr4jIgB8YE4MQvUKuwkKiI=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1Z7qFWF4ImNBsPFV48pzcPp+jNtPn8BIiAn2wDU +pocHPmJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWewAKCRAzarMzb2Z/l2DHEA C7vIraD0mxVyUl21AvfS6PZFMq6kPJBxsjW7byt4dGnGndqKfH4qTHrCIT7hUFQWCsLbUDZ1rc2CWJ LEl1/BA5EoHl/ObI9QjXz8Se2oEQo7VFKRhYHyfHgC0z31dj5SX4n6q8A9PRDDUI/PG7SM+E2/VEpH BhqZ+o97cUqYjv9VZuo5bgXE/U6JhaTrwkEwPR22Dji+/rbNXSDD8nZJP0KaS91aCFKXd2j/fwXvoK Vyn0kQJkzCWMS5u5WD36VqtueCk7ExoMH7znamYwDzzLYu6QVgPABEonhmkHHZ4ukCTzZtJlZMekEc 0zIj/HMW0QfDroHqP6ZbqiJHR63rkoZin0Eei1gB9olwp7SRflK3ufwpkS/Go7a8p4nEYxqJ5r3SHn WosqLoPNGSXiA66jLKitZKXKp3c/Vb2b7+ftF+vIYWQ8fHR0LnJUm/wld+232FAyX6YPvSnkZUz9E0 RHNo7eXttKmJUAWTT3xhBVYn8dBlGNNg0bFNGcrXqgViox6Orkj/Ex1gNqk5qhUMCCoTeTn7ECXxi+ bS837QeWe6IOgGriyUle2vmOCUMzu3NlxsM86M4BXhHh4ql8bJUuMTe1oZ/ERRaUnMFhE16El68/y+ TlxCjBfos65WyfMbwe1X/QvOv4U8n6Dmo/oksC9YcmlQeBSPCpDtY0p3RcIQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a dprintk call site. The new tracepoint can be left enabled
persistently to capture problems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   28 ++++++++++++++++++++++++++++
 net/sunrpc/svc.c              |    4 +---
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index db581a837f1b..804912b26abb 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1688,6 +1688,34 @@ TRACE_EVENT(svc_decode_prog_unavail_err,
 	TP_printk("addr=%s program=%u", __get_str(addr), __entry->program)
 );
 
+TRACE_EVENT(svc_decode_prog_mismatch_err,
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		const struct svc_program *progp
+	),
+
+	TP_ARGS(rqst, progp),
+
+	TP_STRUCT__entry(
+		__field(u32, version)
+		__string(progname, progp->pg_name)
+		__string(addr, rqst->rq_xprt ?
+			 rqst->rq_xprt->xpt_remotebuf : "(null)")
+	),
+
+	TP_fast_assign(
+		__entry->version = rqst->rq_vers;
+		__assign_str(progname, progp->pg_name)
+		__assign_str(addr, rqst->rq_xprt ?
+			     rqst->rq_xprt->xpt_remotebuf : "(null)");
+	),
+
+	TP_printk("addr=%s %sv%u",
+		__get_str(addr), __get_str(progname),
+		__entry->version
+	)
+);
+
 DECLARE_EVENT_CLASS(svc_rqst_event,
 
 	TP_PROTO(
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index a057d1373579..66e46d7755e9 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1406,9 +1406,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto sendit;
 
 err_bad_vers:
-	svc_printk(rqstp, "unknown version (%d for prog %d, %s)\n",
-		       rqstp->rq_vers, rqstp->rq_prog, progp->pg_name);
-
+	trace_svc_decode_prog_mismatch_err(rqstp, progp);
 	serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_MISMATCH);
 	svc_putnl(resv, process.mismatch.lovers);

