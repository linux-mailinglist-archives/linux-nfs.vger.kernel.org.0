Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7187A422EDA
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236515AbhJERQO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 13:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233961AbhJERQO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 13:16:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B9C56611CA
        for <linux-nfs@vger.kernel.org>; Tue,  5 Oct 2021 17:14:23 +0000 (UTC)
Subject: [PATCH RFC 4/5] SUNRPC: Don't dereference xprt->snd_task if it's a
 cookie
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Tue, 05 Oct 2021 13:14:23 -0400
Message-ID: <163345406305.524558.10364500477577574454.stgit@morisot.1015granger.net>
In-Reply-To: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
References: <163345354511.524558.1980332041837428746.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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


