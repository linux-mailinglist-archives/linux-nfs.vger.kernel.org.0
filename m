Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816E4430577
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbhJPWta (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:49:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhJPWt0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:49:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2557961214;
        Sat, 16 Oct 2021 22:47:18 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@redhat.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v1 09/14] SUNRPC: Report RPC messages with unknown programs via a tracepoint
Date:   Sat, 16 Oct 2021 18:47:17 -0400
Message-Id:  <163442443701.1001.17427042362741679888.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
References:  <163442364683.1001.4500967510037013459.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1667; h=from:subject:message-id; bh=UrJQaI6YKnP2Ez3yhFOOKIsA4jVLexkS6bh9JLL1EZ8=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha1Z1EB6+UXRy/dmQGIOSUmMa/lbHGpjLjO6T84dj cQNcKpSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtWdQAKCRAzarMzb2Z/lywED/ 9pizWG+TsnjY7r7XtKSV/NUrqNNZ1L8UPljeLI97xj8bmnvNQagmCVvKw05AXMkmq07/ehRuI+teOY 4o4/fI674McJM2AL8fh8INB6smWfcYggCXqZjBqFkjb/UvfEP7MJ+1DHwIekgQWvUu9vjLTaearlHF 210QU65eekANQm8vwsd/tYh3GUH5HMKCm2gwoReHldsEd5F7jhtVaC1q1tzVUJpsb5KkZHkud/BgEc q93pjUj3zgVT6nTIC23+zyqawZlgJUISE08ljbxyRlWjvHvXqTw5DZml5X07gIU3bNUvS0pd+1oldj E1uL0omtCYfsWEHjIdBl3pajnEoHpagdjYRfZJraoTg8kvcBlkNWfZsQqPweQinirUoyRTTFN441wM 9pcCY+1dLAF+i9aEkdBfxWKnx3342N2w/2PyTDGReChU+8KIQJs1J/VWGgBD62C7odo06Hvk9F/Foe hAFmt7ThplSAFSxcMmwsPuQBgG7FUB7YjE6kOs9gf4TESV6FQpmAZ65igE8nIBIW9MV25EhEn3lWYl WHyqlW2MIzwm1hNqsULY5NDXDg/q5UKGlv1tRwxbVIVLHKYXDOXRyYJOEMJob3uNIylgseAzxPS/vQ 7aTL+6ay1YmTdMCe5v/hAHJ7T1Q0KjdO2SoxYoRQv/wqn+0xh3eCmq+ZfyJw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Replace a dprintk call site. The new tracepoint can be left enabled
persistently to capture problems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   23 +++++++++++++++++++++++
 net/sunrpc/svc.c              |    2 +-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3cfdd0ef6600..db581a837f1b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1665,6 +1665,29 @@ TRACE_EVENT(svc_decode_len_err,
 	TP_printk("addr=%s len=%zu", __get_str(addr), __entry->len)
 );
 
+TRACE_EVENT(svc_decode_prog_unavail_err,
+	TP_PROTO(
+		const struct svc_rqst *rqst,
+		u32 program
+	),
+
+	TP_ARGS(rqst, program),
+
+	TP_STRUCT__entry(
+		__field(u32, program)
+		__string(addr, rqst->rq_xprt ?
+			 rqst->rq_xprt->xpt_remotebuf : "(null)")
+	),
+
+	TP_fast_assign(
+		__entry->program = program;
+		__assign_str(addr, rqst->rq_xprt ?
+			     rqst->rq_xprt->xpt_remotebuf : "(null)");
+	),
+
+	TP_printk("addr=%s program=%u", __get_str(addr), __entry->program)
+);
+
 DECLARE_EVENT_CLASS(svc_rqst_event,
 
 	TP_PROTO(
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3d95faffe43b..a057d1373579 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1400,7 +1400,7 @@ svc_process_common(struct svc_rqst *rqstp, struct kvec *argv, struct kvec *resv)
 	goto sendit;
 
 err_bad_prog:
-	dprintk("svc: unknown program %d\n", prog);
+	trace_svc_decode_prog_unavail_err(rqstp, prog);
 	serv->sv_stats->rpcbadfmt++;
 	svc_putnl(resv, RPC_PROG_UNAVAIL);
 	goto sendit;

