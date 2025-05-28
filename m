Return-Path: <linux-nfs+bounces-11936-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC5AC5E14
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 02:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00D9D7AFBE9
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 00:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D6152F99;
	Wed, 28 May 2025 00:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBkz54W8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF89F41C72;
	Wed, 28 May 2025 00:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748391181; cv=none; b=PRHLRiZe4Ex7WY5ZA+WdmqbqJYsqPXj6izCZPw0pcKLJ7OAVGnhjAuHxecPov6V6g4nrBePhHN5ZqVvqKJpF56aXgtKQ6kajLEfK3nwNeZ0Mt/gvu4ZF0uSvPcXKS5sWHrj63KmNzBxRfunSSWOJCrTOrLpCEQinbjKMO5RqhTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748391181; c=relaxed/simple;
	bh=cxW4SaBd30d71b+XTGQnQOrd3RoXiIa9IXf9TAX8wcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DbuXQeCXgO+BaF6eGfsvpP81VAAJxHjZGQfB6YDtexrtlAsg3VCKmSYjNw3uHlmufMVUlXE1xpNYZjTHkJ8lnsko2EFNm2QGDlceX1RwMplx5QxKk1DYqZjm9nAOPwoDATzPTtb6u5FNvgEej3KrDtCtKR/gUImSVCF9sbqz9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBkz54W8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CBF2C4CEEF;
	Wed, 28 May 2025 00:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748391180;
	bh=cxW4SaBd30d71b+XTGQnQOrd3RoXiIa9IXf9TAX8wcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cBkz54W8rb4B9VA3IK0gsi5vhlq4TR9Nk6IYfIJ8ieIOB82bRTHHZwP/wzy3PutwT
	 +aYkkOxxDPRC6NNy9FQWNIos68XuOhkSxHXInCwmbox7leypTgcdxAHS/Uq/OGh2WE
	 Od/joQd8ZgHwypznwJDpQzzhzV9mfw9Gv1fQ9oy/E0u93TRWJFeVHSjy+DwBFjwdXY
	 PMx8ANiem1VbCAyNswZmYW98QRp+857CqCWjwCjKxN5iBFEtXVAnArTCVmC1d4w1lD
	 cios5kOGfl1CDxHnlwEdioTNDw/chS+uWSgCAIFo+50fTFIYyMuK+RuehsDE8eKU5a
	 AOhbX6XrVv8WA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 May 2025 20:12:48 -0400
Subject: [PATCH 2/2] sunrpc: new tracepoints around svc thread wakeups
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-rpc-numa-v1-2-fa1d98e9a900@kernel.org>
References: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
In-Reply-To: <20250527-rpc-numa-v1-0-fa1d98e9a900@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Mike Snitzer <snitzer@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cxW4SaBd30d71b+XTGQnQOrd3RoXiIa9IXf9TAX8wcI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNlUGnW4tgC8sVfVgHbdTgLn8V08NG8CkTE+ob
 BFqhAKcGoGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDZVBgAKCRAADmhBGVaC
 FUZUD/9BxN8EbQJyaMr+oPKZt5N1nr44RjHQy1scup+4Oq61Z07x8RkeHzVlc5cXFpS6u59licC
 VnbnpVSaR2MpagNnU18dcj6qjstz+RkQYcdKFSV35D2gGd/YX5S0PexNB4Hs9Kbp+1LHrBPfKAR
 pi26BBmC8OBL2ZH/eBeQlTcOC10VdwzMv4NWwuUU6nvbGcaW30/06z2fM30Pf7oQ6Pecm0Lyouw
 sET9h2mMdF4iSBeslSVqz0QpK4uz0x5oBaAjmId/8/7J7hH3nZSl4mN1MQcX2pXbKoXc3WlN0rI
 8n2PerX+GAfLOag/sKdrzH1Q/d0ZouO0Tsopu/41kXMY9EAJRNig1NKzyn5604WfDcTMSJbncBO
 oQUPdcl5Dt5LgFUQdts0bVOHGnIHO/sf6XmHzR7l4SWBgBdDOV6iE6gaJjtmbweEraTV+8hAyAm
 KRMnQfT96DbZ7oIJvO44MjbDQZRZ4FUfr8l8NVerRgZk+05Z350/fcGYGssZctqGEw++5tVz9Z6
 38M7SKEgPRxlKHSGWAaASwS78Kdf/6foihD0URiL6lB2GGfWvUEsfxtuLnOCfvAY1vbMxZQFx5p
 LGR14NTuEV/ubtIgqHbK510RC9k1okcxMstGyZAaUMZ/hS2zCH4bF+hi7q1n1WAm6PJwucE1kBn
 QWSM4+U8fPJW8Dg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Convert the svc_wake_up tracepoint into svc_pool_thread_event class.
Have it also record the pool id, and add new tracepoints for when the
thread is already running and for when there are no idle threads.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/trace/events/sunrpc.h | 23 ++++++++++++++++++-----
 net/sunrpc/svc.c              |  5 ++++-
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 5d331383047b79b9f6dcd699c87287453c1a5f49..d23009b4dc979fd7eebcfb6bc3164608f74ab23b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2124,22 +2124,35 @@ TRACE_EVENT(svc_xprt_accept,
 	)
 );
 
-TRACE_EVENT(svc_wake_up,
-	TP_PROTO(int pid),
+DECLARE_EVENT_CLASS(svc_pool_thread_event,
+	TP_PROTO(const struct svc_pool *pool, pid_t pid),
 
-	TP_ARGS(pid),
+	TP_ARGS(pool, pid),
 
 	TP_STRUCT__entry(
-		__field(int, pid)
+		__field(unsigned int, pool_id)
+		__field(pid_t, pid)
 	),
 
 	TP_fast_assign(
+		__entry->pool_id = pool->sp_id;
 		__entry->pid = pid;
 	),
 
-	TP_printk("pid=%d", __entry->pid)
+	TP_printk("pool=%u pid=%d", __entry->pool_id, __entry->pid)
 );
 
+#define DEFINE_SVC_POOL_THREAD_EVENT(name) \
+	DEFINE_EVENT(svc_pool_thread_event, svc_pool_thread_##name, \
+			TP_PROTO( \
+				const struct svc_pool *pool, pid_t pid \
+			), \
+			TP_ARGS(pool, pid))
+
+DEFINE_SVC_POOL_THREAD_EVENT(wake);
+DEFINE_SVC_POOL_THREAD_EVENT(running);
+DEFINE_SVC_POOL_THREAD_EVENT(noidle);
+
 TRACE_EVENT(svc_alloc_arg_err,
 	TP_PROTO(
 		unsigned int requested,
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c03bf28a5eeec839fd85e24f5525f..de80d3683350dc86bee3413719797dcf7a4562e8 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -749,13 +749,16 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 		WRITE_ONCE(rqstp->rq_qtime, ktime_get());
 		if (!task_is_running(rqstp->rq_task)) {
 			wake_up_process(rqstp->rq_task);
-			trace_svc_wake_up(rqstp->rq_task->pid);
+			trace_svc_pool_thread_wake(pool, rqstp->rq_task->pid);
 			percpu_counter_inc(&pool->sp_threads_woken);
+		} else {
+			trace_svc_pool_thread_running(pool, rqstp->rq_task->pid);
 		}
 		rcu_read_unlock();
 		return;
 	}
 	rcu_read_unlock();
+	trace_svc_pool_thread_noidle(pool, rqstp->rq_task->pid);
 
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);

-- 
2.49.0


