Return-Path: <linux-nfs+bounces-11052-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7490AA82801
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6049A1883A6F
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Apr 2025 14:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14B266EE8;
	Wed,  9 Apr 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbwYAjhy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3421266B7D;
	Wed,  9 Apr 2025 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209183; cv=none; b=bJpsKhfiX7Rr67GDtbhzy4cLgElZfk15niB4VIE3nqSfgRSS9b6uQHUgZ1vtkYvPT2YQ5Uo6irCkLBfNELcSeSCKodxv2r6UmlBY6F4Tn3Ibh2+AvsXQn1H4QuWUXm5nz+8jqfRNQq13jwnh4y2FlidC9wz6sU5PHMFlFax0Hxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209183; c=relaxed/simple;
	bh=VcnUzY+565jZTK8hBoI7wqCh9wq7lagdh8T+HHqHCGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IecG7pmyxJDf/igb2tj+XNlJ5dRI3LVKDaqGRoL1adKg4rmnDK6wS9Z0jecY8mYqqdJQHAdLOjJ6h1jszCWsjbWwkmrwEOXadj/q0RLlTN6kvTi6SGr979EHEtEJJcvGhmQp1HSLNyUjrPUOUGA/Zv77iXv0zvvEqGCHwBFFonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbwYAjhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554A1C4CEE9;
	Wed,  9 Apr 2025 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209183;
	bh=VcnUzY+565jZTK8hBoI7wqCh9wq7lagdh8T+HHqHCGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sbwYAjhyWsD6scHuzlsifquNSVkiH61nFV1Lbiw0a7gTeurZACTlfymikgJw1DUHP
	 GKrGMM1Fmt5mimbGAVa2mAjfi93eHpPCk+1QUuC8bLN2D94m15YW7F38VvPHRcKvI0
	 eGn62eKFev8rULZM9qCUo3JE3qhbXvqE4J8k20yoILEXqh0ZmcJPWYprixjz6r+OXm
	 oUON/jw/89iWM+llag3hDa8a0AhBPnSVu4dOroJmVVpZxRLzl6NmRA5kOAu9A4t5gB
	 QLS9UY8afqSp92I1Wv6Ho36sS3h/YDRmOf1B4FscN1JdXaHWZc2Dxmfa6K0GlZXCnc
	 IgTwWUqQhj8JA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 09 Apr 2025 10:32:24 -0400
Subject: [PATCH v2 02/12] sunrpc: add info about xprt queue times to
 svc_xprt_dequeue tracepoint
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-nfsd-tracepoints-v2-2-cf4e084fdd9c@kernel.org>
References: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
In-Reply-To: <20250409-nfsd-tracepoints-v2-0-cf4e084fdd9c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Sargun Dillon <sargun@sargun.me>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2626; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=VcnUzY+565jZTK8hBoI7wqCh9wq7lagdh8T+HHqHCGs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn9oUZ1UNowgzZRAIse4nozI0i/q8iWgXnk/uNe
 r8b4Ecn00qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/aFGQAKCRAADmhBGVaC
 FbYTD/4itzqsj3M1tcwjdE2mNhfwkO15OREdrlltyBoT8YhIgJl10M8pjuMrDYj7qsQXe2zmCpQ
 ZL3KwkgfFq0Oxw+eUZS+bX4oUKgBfTC+TDcWeEuKj9SNLrO3W+7DXzT9CG8WVFK1+xyEyWqZJmF
 WzUP4hTLh4yYT6sbe04HyUdazGjUF36UrI1Ts5qDmdruNNndI7fmhO90Hkn3BkN0EbF84ewdFZ4
 YhRUHSbRNhJquLtdnjVs41/rF9bFWWOc3/dc/LiaatfUgMpSv96sb7g+W3/mTh3dlACW/QvjFJ4
 UJUFUZfcfjw5tRy8pOC45jFpHRbrij+MOkW+w3L3jwJLLFa9+AEhTqxYb9sipNZLCDJar/EVGT8
 p8X41GD2oQiZxIun73hzOjcl+SfcOTjJGJ2FnJfFuc+nDiNabVTCEXh0Eat9Kz1DsaFVXd5+5lc
 tP0do0KOmZrYawS0CPHhduFiGRShn63O1zCeCKqvzpO3e3qWww5JEdQno2b6R48YzXZ8bbBgQSP
 xicRRHoboMbJJkmBGV/QoTywTbq51IfcyOqg853212VMm4bVgLbmlMDMVSfiyYLS02lF3fnMc5v
 QMPMRp4EjkoqazTxvv4wZk1WKKFD8NpbjLqPHkbJc9xxmiE6h53s1OWDdw5KiPy/9jl0oNBLJhD
 LYpKL0lnNbToMrA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently, this tracepoint displays "wakeup-us", which is the time that
the woken thread spent sleeping, before dequeueing the next xprt. Add a
new statistic that shows how long the xprt sat on the queue before being
serviced.

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
index 5d331383047b79b9f6dcd699c87287453c1a5f49..b5a0f0bc1a3b7cfd90ce0181a8a419db810988bb 100644
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
+	TP_printk(SVC_XPRT_ENDPOINT_FORMAT " wakeup-us=%lu qtime=%lu",
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

-- 
2.49.0


