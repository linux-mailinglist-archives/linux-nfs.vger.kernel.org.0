Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35259D14B7
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Oct 2019 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbfJIQ6Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Oct 2019 12:58:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36359 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbfJIQ6Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Oct 2019 12:58:16 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so6623131iof.3
        for <linux-nfs@vger.kernel.org>; Wed, 09 Oct 2019 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=y9jC4CF48Om3/7Ax5L+MSPz7ktRfkaF3UU5UQC+s/TY=;
        b=qVMlpHgW6yEfDCq4yBUz/JToUPZz6cRIroOqY7j4q//t45QOZSCdgDo1LEyhvvrQ8v
         CKDqMgDcy8mCItoRiySan1TkvPlm9ozijtycWOhkuub0lcKvSaQzfnvH7W66uTZegL/w
         MXNC5JOBrNP+XeYWU5jSoLQ4GrE085Weex+bRMTNI5M/E/3rgYCTRk414KxWrK9cZiuh
         IJiiWf3X2D63u91UUIrEXkUh8g+Y5ZV0v3VprB6hwMFRISeFmxn4y7WPoUJdZRLvOa3v
         E5KX5FDSNgvMM/G4v8Bb7ZN7yFFCbF+K1csUBTzSwKOxh+vBtY+b1UNdew02rJM6IZfi
         PhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=y9jC4CF48Om3/7Ax5L+MSPz7ktRfkaF3UU5UQC+s/TY=;
        b=HtqRXv01ZP9UbDzSMkZJcBhhGNhCXC4Mwbu4peSkwMYsF0D6VirKN9BNC0Dl4C5Qew
         YO7wjJ+AGGGNw5Lrgmoyb26+Hk0NgAKp5O1F3DFRzLgSeeMGypQqZGzfujlYc2SvK3Oq
         wAvpN/ZfP82+VG9Ou5IDBCVycvgdQaU1vRs3WxMdZI+6TWsPtT02FMdIFBH1ioaIS+H1
         Ke9JVgJ3mwiw5rsWab5WLWSSjZVbBoH0O2SGbASeUGPoEzh3Oas1t3EZrc9eTHL1S0bY
         phVPtCHfwbEi6szYXXdoh4hI/vNNJM9aeQfRP12q15RJyrwCmUe1UaEgqH1SoCi7hpdk
         wpgA==
X-Gm-Message-State: APjAAAXjzM1w9SsnGKeI3cQf5W3dswj/LQnx+QzdnOZnD0N3I5YHhoYw
        zhg+IwSpBTjVTj+uU1nUwuUi2GfT
X-Google-Smtp-Source: APXvYqyypKYV9XHxHDPck6Qqoup4VJB8/0eL4J+pF5c12tT9lq9zNdGPzPKz8PXshVjELZ45dIXHHw==
X-Received: by 2002:a02:ab96:: with SMTP id t22mr1561913jan.78.1570640295406;
        Wed, 09 Oct 2019 09:58:15 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a24sm1173348iok.37.2019.10.09.09.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 09:58:14 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x99GwE44001459;
        Wed, 9 Oct 2019 16:58:14 GMT
Subject: [PATCH 2/2] SUNRPC: Add trace points to observe transport
 congestion control
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 09 Oct 2019 12:58:14 -0400
Message-ID: <20191009165814.2428.55998.stgit@manet.1015granger.net>
In-Reply-To: <20191009165713.2428.84819.stgit@manet.1015granger.net>
References: <20191009165713.2428.84819.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

To help debug problems with RPC/RDMA credit management, replace
dprintk() call sites in the transport send lock paths with trace
events.

Similar trace points are defined for the non-congestion paths.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   93 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/xprt.c             |   22 ++++++----
 2 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index ffa3c51..378233f 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -777,6 +777,99 @@
 			__get_str(addr), __get_str(port), __entry->status)
 );
 
+DECLARE_EVENT_CLASS(xprt_writelock_event,
+	TP_PROTO(
+		const struct rpc_xprt *xprt, const struct rpc_task *task
+	),
+
+	TP_ARGS(xprt, task),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(unsigned int, snd_task_id)
+	),
+
+	TP_fast_assign(
+		if (task) {
+			__entry->task_id = task->tk_pid;
+			__entry->client_id = task->tk_client ?
+					     task->tk_client->cl_clid : -1;
+		} else {
+			__entry->task_id = -1;
+			__entry->client_id = -1;
+		}
+		__entry->snd_task_id = xprt->snd_task ?
+					xprt->snd_task->tk_pid : -1;
+	),
+
+	TP_printk("task:%u@%u snd_task:%u",
+			__entry->task_id, __entry->client_id,
+			__entry->snd_task_id)
+);
+
+#define DEFINE_WRITELOCK_EVENT(name) \
+	DEFINE_EVENT(xprt_writelock_event, xprt_##name, \
+			TP_PROTO( \
+				const struct rpc_xprt *xprt, \
+				const struct rpc_task *task \
+			), \
+			TP_ARGS(xprt, task))
+
+DEFINE_WRITELOCK_EVENT(reserve_xprt);
+DEFINE_WRITELOCK_EVENT(release_xprt);
+
+DECLARE_EVENT_CLASS(xprt_cong_event,
+	TP_PROTO(
+		const struct rpc_xprt *xprt, const struct rpc_task *task
+	),
+
+	TP_ARGS(xprt, task),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(unsigned int, snd_task_id)
+		__field(unsigned long, cong)
+		__field(unsigned long, cwnd)
+		__field(bool, wait)
+	),
+
+	TP_fast_assign(
+		if (task) {
+			__entry->task_id = task->tk_pid;
+			__entry->client_id = task->tk_client ?
+					     task->tk_client->cl_clid : -1;
+		} else {
+			__entry->task_id = -1;
+			__entry->client_id = -1;
+		}
+		__entry->snd_task_id = xprt->snd_task ?
+					xprt->snd_task->tk_pid : -1;
+		__entry->cong = xprt->cong;
+		__entry->cwnd = xprt->cwnd;
+		__entry->wait = test_bit(XPRT_CWND_WAIT, &xprt->state);
+	),
+
+	TP_printk("task:%u@%u snd_task:%u cong=%lu cwnd=%lu%s",
+			__entry->task_id, __entry->client_id,
+			__entry->snd_task_id, __entry->cong, __entry->cwnd,
+			__entry->wait ? " (wait)" : "")
+);
+
+#define DEFINE_CONG_EVENT(name) \
+	DEFINE_EVENT(xprt_cong_event, xprt_##name, \
+			TP_PROTO( \
+				const struct rpc_xprt *xprt, \
+				const struct rpc_task *task \
+			), \
+			TP_ARGS(xprt, task))
+
+DEFINE_CONG_EVENT(reserve_cong);
+DEFINE_CONG_EVENT(release_cong);
+DEFINE_CONG_EVENT(get_cong);
+DEFINE_CONG_EVENT(put_cong);
+
 TRACE_EVENT(xs_stream_read_data,
 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 8a45b3c..fcbeb56 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -205,20 +205,20 @@ int xprt_reserve_xprt(struct rpc_xprt *xprt, struct rpc_task *task)
 
 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state)) {
 		if (task == xprt->snd_task)
-			return 1;
+			goto out_locked;
 		goto out_sleep;
 	}
 	if (test_bit(XPRT_WRITE_SPACE, &xprt->state))
 		goto out_unlock;
 	xprt->snd_task = task;
 
+out_locked:
+	trace_xprt_reserve_xprt(xprt, task);
 	return 1;
 
 out_unlock:
 	xprt_clear_locked(xprt);
 out_sleep:
-	dprintk("RPC: %5u failed to lock transport %p\n",
-			task->tk_pid, xprt);
 	task->tk_status = -EAGAIN;
 	if  (RPC_IS_SOFT(task))
 		rpc_sleep_on_timeout(&xprt->sending, task, NULL,
@@ -269,23 +269,22 @@ int xprt_reserve_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task)
 
 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state)) {
 		if (task == xprt->snd_task)
-			return 1;
+			goto out_locked;
 		goto out_sleep;
 	}
 	if (req == NULL) {
 		xprt->snd_task = task;
-		return 1;
+		goto out_locked;
 	}
 	if (test_bit(XPRT_WRITE_SPACE, &xprt->state))
 		goto out_unlock;
 	if (!xprt_need_congestion_window_wait(xprt)) {
 		xprt->snd_task = task;
-		return 1;
+		goto out_locked;
 	}
 out_unlock:
 	xprt_clear_locked(xprt);
 out_sleep:
-	dprintk("RPC: %5u failed to lock transport %p\n", task->tk_pid, xprt);
 	task->tk_status = -EAGAIN;
 	if (RPC_IS_SOFT(task))
 		rpc_sleep_on_timeout(&xprt->sending, task, NULL,
@@ -293,6 +292,9 @@ int xprt_reserve_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task)
 	else
 		rpc_sleep_on(&xprt->sending, task, NULL);
 	return 0;
+out_locked:
+	trace_xprt_reserve_cong(xprt, task);
+	return 1;
 }
 EXPORT_SYMBOL_GPL(xprt_reserve_xprt_cong);
 
@@ -357,6 +359,7 @@ void xprt_release_xprt(struct rpc_xprt *xprt, struct rpc_task *task)
 		xprt_clear_locked(xprt);
 		__xprt_lock_write_next(xprt);
 	}
+	trace_xprt_release_xprt(xprt, task);
 }
 EXPORT_SYMBOL_GPL(xprt_release_xprt);
 
@@ -374,6 +377,7 @@ void xprt_release_xprt_cong(struct rpc_xprt *xprt, struct rpc_task *task)
 		xprt_clear_locked(xprt);
 		__xprt_lock_write_next_cong(xprt);
 	}
+	trace_xprt_release_cong(xprt, task);
 }
 EXPORT_SYMBOL_GPL(xprt_release_xprt_cong);
 
@@ -395,8 +399,7 @@ static inline void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *ta
 {
 	if (req->rq_cong)
 		return 1;
-	dprintk("RPC: %5u xprt_cwnd_limited cong = %lu cwnd = %lu\n",
-			req->rq_task->tk_pid, xprt->cong, xprt->cwnd);
+	trace_xprt_get_cong(xprt, req->rq_task);
 	if (RPCXPRT_CONGESTED(xprt)) {
 		xprt_set_congestion_window_wait(xprt);
 		return 0;
@@ -418,6 +421,7 @@ static inline void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *ta
 	req->rq_cong = 0;
 	xprt->cong -= RPC_CWNDSCALE;
 	xprt_test_and_clear_congestion_window_wait(xprt);
+	trace_xprt_put_cong(xprt, req->rq_task);
 	__xprt_lock_write_next_cong(xprt);
 }
 

