Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF94A430525
	for <lists+linux-nfs@lfdr.de>; Sun, 17 Oct 2021 00:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbhJPWE5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 16 Oct 2021 18:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244675AbhJPWEy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 16 Oct 2021 18:04:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9580060EE9;
        Sat, 16 Oct 2021 22:02:45 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/7] SUNRPC: Don't dereference xprt->snd_task if it's a cookie
Date:   Sat, 16 Oct 2021 18:02:44 -0400
Message-Id:  <163442176448.1585.14151942803213662102.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
References:  <163442096873.1585.8967342784030733636.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2181; h=from:subject:message-id; bh=Kw4yNjULbSjcpbOVAfTWvgi1gPr+frxbyoW4hgZ0ecc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBha0wEAjFubBrKAcg8Wh/6K/4gdDjr0WbgD+isj+5M l2PWRkqJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWtMBAAKCRAzarMzb2Z/l0mYD/ 4wRYk6fXpfZnK+wNWNPHEOO5ct2Rdp19K10/VF0/2ZAx7WmxWSTPG1k+qxA1lTaQVaGSSahU9Zd5DJ VOwmFBGQ57/lnB1mOz5pXIEzgJgPadasYV1Of9boHM+XEtid1Cn8+Wr2JjfLVZRvSCrUki9qvEAJO1 ac5uM5fSWSPU9eupmDBEATKjKNhNmvUlmIkc0uE17bnQthFfoavz+36laSBWuAxPlUEOYoxU967vZk XhjmWsJGZ4reW/UOgUc/+iHvUtHSLuF+WXV7le8F4jDF03fHuwIFA76TL3xvGMMTdrF8LN3nYD/f25 8BTJQmQyshhNX2whU/DiAvm6eFf/aEqppJx7vvC4G73KmNmmoQsN49wK7rma8U49MMKIu2g6ONQ7vA /8vlHVPd/Zuh86r4a0qA0F72iptViH1/B5D/THp6Fv8zRTwhOX5S03xC0cuF/MO08brv9AmuPLQlt+ GPyOrWGYCE2l1GN4J/D/uLw59vZYc8isrgHBgc/7rh/6jhqLCpq28MO69ljgl6iPkyb27H/U/L2P7h OIQk36dVc61EV/7jjZIn8YhMVqCP/KYkmfliHydE/O8MH70lHZU0AHONCC5WIQNl5dhAEgJPmu7PNN MExioHjC/vwNHNt1KmKOD1rzHFnqHPTjONR6l82V07iCsaEVIAy5NThZ87Pw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Fixes: e26d9972720e ("SUNRPC: Clean up scheduling of autoclose")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h      |    9 ++++-----
 include/trace/events/sunrpc_base.h |    9 +++++++++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 9caf4533366e..83c2a1cb2e3a 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -932,7 +932,8 @@ TRACE_EVENT(rpc_socket_nospace,
 		{ BIT(XPRT_REMOVE),		"REMOVE" },		\
 		{ BIT(XPRT_CONGESTED),		"CONGESTED" },		\
 		{ BIT(XPRT_CWND_WAIT),		"CWND_WAIT" },		\
-		{ BIT(XPRT_WRITE_SPACE),	"WRITE_SPACE" })
+		{ BIT(XPRT_WRITE_SPACE),	"WRITE_SPACE" },	\
+		{ BIT(XPRT_SND_IS_COOKIE),	"SND_IS_COOKIE" })
 
 DECLARE_EVENT_CLASS(rpc_xprt_lifetime_class,
 	TP_PROTO(
@@ -1118,8 +1119,7 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 
 	TP_fast_assign(
 		SUNRPC_TRACE_TASK_ASSIGN(task);
-		__entry->snd_task_id = xprt->snd_task ?
-					xprt->snd_task->tk_pid : -1;
+		SUNRPC_TRACE_SNDTASK_ASSIGN(xprt);
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -1157,8 +1157,7 @@ DECLARE_EVENT_CLASS(xprt_cong_event,
 
 	TP_fast_assign(
 		SUNRPC_TRACE_TASK_ASSIGN(task);
-		__entry->snd_task_id = xprt->snd_task ?
-					xprt->snd_task->tk_pid : -1;
+		SUNRPC_TRACE_SNDTASK_ASSIGN(xprt);
 		__entry->cong = xprt->cong;
 		__entry->cwnd = xprt->cwnd;
 		__entry->wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
diff --git a/include/trace/events/sunrpc_base.h b/include/trace/events/sunrpc_base.h
index 2cbed4a9a63a..abdffe4f53d6 100644
--- a/include/trace/events/sunrpc_base.h
+++ b/include/trace/events/sunrpc_base.h
@@ -25,6 +25,15 @@
 		} \
 	} while (0);
 
+#define SUNRPC_TRACE_SNDTASK_ASSIGN(x) \
+	do { \
+		if ((x)->snd_task && \
+		    !test_bit(XPRT_SND_IS_COOKIE, &(x)->state)) \
+			__entry->snd_task_id = (x)->snd_task->tk_pid; \
+		else \
+			__entry->snd_task_id = SUNRPC_TRACE_PID_SPECIAL; \
+	} while(0);
+
 #define SUNRPC_TRACE_PID_SPECIFIER	"%08x"
 #define SUNRPC_TRACE_CLID_SPECIFIER	"%08x"
 #define SUNRPC_TRACE_TASK_SPECIFIER \

