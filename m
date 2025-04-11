Return-Path: <linux-nfs+bounces-11115-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C639A8606A
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 16:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B51DD189E521
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Apr 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963BB142E83;
	Fri, 11 Apr 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+zfBUl9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B225537FF;
	Fri, 11 Apr 2025 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381351; cv=none; b=N0I+j6uTch+f/1nqApArtIHFUNra0DJEebQgHxvq2yPsdKCWpuVLgGYE9/lUHX6cuiBBDsJ7C242bJK0tuyZ2xSY1oCozYYmzBsnwueduNZO2p2pkfYFtnD3RPIkirOWDGxajDdhPiH/lDXHW4IxzXA93f6W8Mm/FMcwaQWb6ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381351; c=relaxed/simple;
	bh=YROGXLoyPnGQUwrDEzwNUTEF7kTJ7MEfzPBgfw6hD8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f+QMoA2tiVMxFoKCK3+R5srLEMIdhxT81o7HuT8KVmlsG5dUTMSmK1DUm6evs786RCqBhwvgM7COKwcG+GMEjyhbs13rtVV8syWSni5BXOHKNov+gfyHkoDAueTFQPH3+OLoODvrk7DYchictCkzfChM+MSp0iSMxXfEdQOMrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+zfBUl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A2AC4CEE2;
	Fri, 11 Apr 2025 14:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744381350;
	bh=YROGXLoyPnGQUwrDEzwNUTEF7kTJ7MEfzPBgfw6hD8o=;
	h=From:Date:Subject:To:Cc:From;
	b=s+zfBUl9aGkDTTH0vUpvPnEXUNaC0mxSNp8MbovxcGBZQCKC7D2Bg2+semp0wWlCs
	 5Drrqj34nklxkYZ7bqAUnPx5nRrDqKAfGVXtQU+Bi8qsz1o4Ovy860tKTqEb6nBC/g
	 +0buzA2ZFF8wTgoat4UilC4sf4sgpIR5Ges2fMW1D1sVZpj/P5eZFl3wbfFCsBhcne
	 kJrLZi0LAxjn02/gzC2K3DSxMWDyekE7l8H8fDLSR/0R8Kem6JY4LFlODEl4lPu3u4
	 tG5Dg29JUvoRyIkRHKemXP7o3q2ctJ1ec8bG9EJOwhH7wiOe88z6zil5n5pwf/NG8/
	 1qrLp4l223kXg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 11 Apr 2025 10:22:14 -0400
Subject: [PATCH] sunrpc: add info about xprt queue times to
 svc_xprt_dequeue tracepoint
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-sunrpc-tracepoints-v1-1-ed2eb14ce6ee@kernel.org>
X-B4-Tracking: v=1; b=H4sIAJUl+WcC/x3MQQ5AMBBA0avIrDUxpSGuIhbUlNlUM4NIxN01l
 m/x/wNKwqTQFw8IXay8xwwsC/DbFFcyvGSDrayrGkSjZ5TkzSGTp7RzPNS0M/rF2a4O2EEOk1D
 g+58O4/t+WPQ0s2QAAAA=
X-Change-ID: 20250411-sunrpc-tracepoints-7b1cd5283f18
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3648; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=YROGXLoyPnGQUwrDEzwNUTEF7kTJ7MEfzPBgfw6hD8o=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn+SWYDoVqQqf9QByqMRuPwdhGISiVayqDYkSw+
 qKd26QEvtGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/klmAAKCRAADmhBGVaC
 Fb2HD/4lYswF8SsHPsp/n/zn37H8983qtbOeywdXWC5CiktCy1prUk0cfCXfGtNicrPrhywuCau
 +FXWnb8N6Q3GcPAi/c5rCG4dWBB6e2WqMu39YnSk5GWGoSbG+MtEhuxRPvb5YyqrZngquzBaXMD
 j9w3Q2FBYkU3knQ8JDcbw2v6BwsQua2Pr7MAUROx9NbfWqpWjeHEReFywnn2JoKJ8BvAkB4qiLl
 BaEfvVU2MS7hCAPqW03mzt5p0QhO3xpe31pH8Unf8Mj4IWKAPDYU2qI+RyyMioC+o8A6ZuMzhRt
 vAZqbWENg3jDn1eOqg1oiCWF4/SAOeZkGNrrmGuRw7VLb5NX5n5d1Jkon738frO9c79ZixsmKl4
 jhnsMe6VvDbF+JgxQR3wkRTrhNtECWl4wG8X0UDROTZLgHh6U6aFsV85Lxed1+ZkGJRRU/b5Bgp
 2SFrOQSq+V3Sm3tRj7Cc4hhLp+P+W+Nr5Z0twH+bUxPTl/fD4V7bzQu03LzCjgJI0K4kazz132G
 IAIBrDZQ2dr308gIS7tVNyVumQHrhNEYVBiKIbZIFIqK5jIyBDcJgQkHVpzjFYZm3N+C48E7r01
 lnwVpbcqF7JzTIA9wRrbODLa027wOjp9O+GWGGsUFT3lR4qfcM+ATZs4c1sJXSZg2VxjYcEnTfH
 Rax3Dvc/yjZDLhQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I've been looking at a problem where we see increased RPC timeouts in
clients when the nfs_layout_flexfiles dataserver_timeo value is tuned
very low (6s). This is necessary to ensure quick failover to a different
mirror if a server goes down, but it causes a lot more major RPC timeouts.

Ultimately, the problem is server-side however. It's sometimes doesn't
respond to connection attempts. My theory is that the interrupt handler
runs when a connection comes in, the xprt ends up being enqueued, but it
takes a significant amount of time for the nfsd thread to pick it up.

Currently, the svc_xprt_dequeue tracepoint displays "wakeup-us". This is
the time between the wake_up() call, and the thread dequeueing the xprt.
If no thread was woken, or the thread ended up picking up a different
xprt than intended, then this value won't tell us how long the xprt was
waiting.

Add a new xpt_qtime field to struct svc_xprt and set it in
svc_xprt_enqueue(). When the dequeue tracepoint fires, also store the
time that the xprt sat on the queue in total. Display it as "qtime-us".

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h |  1 +
 include/trace/events/sunrpc.h   | 13 +++++++------
 net/sunrpc/svc_xprt.c           |  1 +
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 72be609525796792274d5b8cb5ff37f73723fc23..369a89aea18618748607ee943247c327bf62c8d5 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -53,6 +53,7 @@ struct svc_xprt {
 	struct svc_xprt_class	*xpt_class;
 	const struct svc_xprt_ops *xpt_ops;
 	struct kref		xpt_ref;
+	ktime_t			xpt_qtime;
 	struct list_head	xpt_list;
 	struct lwq_node		xpt_ready;
 	unsigned long		xpt_flags;
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 5d331383047b79b9f6dcd699c87287453c1a5f49..67db3f2953d5d64f2e8e455b218f7f6ecb7753ec 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2040,19 +2040,20 @@ TRACE_EVENT(svc_xprt_dequeue,
 
 	TP_STRUCT__entry(
 		SVC_XPRT_ENDPOINT_FIELDS(rqst->rq_xprt)
-
 		__field(unsigned long, wakeup)
+		__field(unsigned long, qtime)
 	),
 
 	TP_fast_assign(
-		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
+		ktime_t ktime = ktime_get();
 
-		__entry->wakeup = ktime_to_us(ktime_sub(ktime_get(),
-							rqst->rq_qtime));
+		SVC_XPRT_ENDPOINT_ASSIGNMENTS(rqst->rq_xprt);
+		__entry->wakeup = ktime_to_us(ktime_sub(ktime, rqst->rq_qtime));
+		__entry->qtime = ktime_to_us(ktime_sub(ktime, rqst->rq_xprt->xpt_qtime));
 	),
 
-	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu",
-		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup)
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu qtime-us=%lu",
+		SVC_XPRT_ENDPOINT_VARARGS, __entry->wakeup, __entry->qtime)
 );
 
 DECLARE_EVENT_CLASS(svc_xprt_event,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index ae25405d8bd22672a361d1fd3adfdcebb403f90f..32018557797b1f683d8b7259f5fccd029aebcd71 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -488,6 +488,7 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 	pool = svc_pool_for_cpu(xprt->xpt_server);
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
+	xprt->xpt_qtime = ktime_get();
 	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
 
 	svc_pool_wake_idle_thread(pool);

---
base-commit: acad0c0757d30205fba27fd8f08afda37d5aa66b
change-id: 20250411-sunrpc-tracepoints-7b1cd5283f18

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


