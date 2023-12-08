Return-Path: <linux-nfs+bounces-473-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1974080ACC7
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 20:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A3E281771
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C6B481CD;
	Fri,  8 Dec 2023 19:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RH7qgyeA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EB410E7
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702063147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ByerRZeKRoWDy+IZiaA+aAyR2HJyrgeSwO7qURPfXAI=;
	b=RH7qgyeACPNrhjKyM9blcgQvgafz8tEjEb/kweiCiSyqeml1IXZxXczfDDhba5k81r965a
	ST7YxOrxIstg09s5kX7fOF2w0WlmM4ykj6nkQ1bFniCLlNS30Sz6gytNnmhued7F4cnIpp
	DStQlo8jxxts6B2PCDy7KDFw7cm31pc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-L7JKrvgSMAKIFdmDWXDDMA-1; Fri, 08 Dec 2023 14:19:04 -0500
X-MC-Unique: L7JKrvgSMAKIFdmDWXDDMA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF18B8352A5;
	Fri,  8 Dec 2023 19:19:03 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 413B21C060B1;
	Fri,  8 Dec 2023 19:19:03 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Fixup v4.1 backchannel request timeouts
Date: Fri,  8 Dec 2023 14:19:02 -0500
Message-ID: <1bcb93ab5feefca853b95a1759da5b008c204092.1702063105.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on
the sending list"), any 4.1 backchannel tasks placed on the sending queue
would immediately return with -ETIMEDOUT since their req timers are zero.
We can fix this by keeping a copy of the rpc_clnt's timeout params on the
transport and using them to properly setup the timeouts on the v4.1
backchannel tasks' req.

Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on the sending list")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/clnt.c           |  3 +++
 net/sunrpc/xprt.c           | 23 ++++++++++++++---------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index f85d3a0daca2..7565902053f3 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -285,6 +285,7 @@ struct rpc_xprt {
 						 * items */
 	struct list_head	bc_pa_list;	/* List of preallocated
 						 * backchannel rpc_rqst's */
+	struct rpc_timeout	bc_timeout;	/* backchannel timeout params */
 #endif /* CONFIG_SUNRPC_BACKCHANNEL */
 
 	struct rb_root		recv_queue;	/* Receive queue */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d6805c1268a7..5891757c88b1 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -279,6 +279,9 @@ static struct rpc_xprt *rpc_clnt_set_transport(struct rpc_clnt *clnt,
 		clnt->cl_autobind = 1;
 
 	clnt->cl_timeout = timeout;
+#if defined(CONFIG_SUNRPC_BACKCHANNEL)
+	memcpy(&xprt->bc_timeout, timeout, sizeof(struct rpc_timeout));
+#endif
 	rcu_assign_pointer(clnt->cl_xprt, xprt);
 	spin_unlock(&clnt->cl_lock);
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 92301e32cda4..7dce780869fc 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -653,9 +653,9 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
 		jiffies + nsecs_to_jiffies(-delta);
 }
 
-static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
+static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
+		const struct rpc_timeout *to)
 {
-	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
 	unsigned long majortimeo = req->rq_timeout;
 
 	if (to->to_exponential)
@@ -667,9 +667,10 @@ static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
 	return majortimeo;
 }
 
-static void xprt_reset_majortimeo(struct rpc_rqst *req)
+static void xprt_reset_majortimeo(struct rpc_rqst *req,
+		const struct rpc_timeout *to)
 {
-	req->rq_majortimeo += xprt_calc_majortimeo(req);
+	req->rq_majortimeo += xprt_calc_majortimeo(req, to);
 }
 
 static void xprt_reset_minortimeo(struct rpc_rqst *req)
@@ -677,7 +678,8 @@ static void xprt_reset_minortimeo(struct rpc_rqst *req)
 	req->rq_minortimeo += req->rq_timeout;
 }
 
-static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
+static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req,
+		const struct rpc_timeout *to)
 {
 	unsigned long time_init;
 	struct rpc_xprt *xprt = req->rq_xprt;
@@ -686,8 +688,9 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
 		time_init = jiffies;
 	else
 		time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
-	req->rq_timeout = task->tk_client->cl_timeout->to_initval;
-	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
+
+	req->rq_timeout = to->to_initval;
+	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req, to);
 	req->rq_minortimeo = time_init + req->rq_timeout;
 }
 
@@ -715,7 +718,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 	} else {
 		req->rq_timeout = to->to_initval;
 		req->rq_retries = 0;
-		xprt_reset_majortimeo(req);
+		xprt_reset_majortimeo(req, to);
 		/* Reset the RTT counters == "slow start" */
 		spin_lock(&xprt->transport_lock);
 		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
@@ -1888,7 +1891,7 @@ xprt_request_init(struct rpc_task *task)
 	req->rq_snd_buf.bvec = NULL;
 	req->rq_rcv_buf.bvec = NULL;
 	req->rq_release_snd_buf = NULL;
-	xprt_init_majortimeo(task, req);
+	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
 
 	trace_xprt_reserve(req);
 }
@@ -1998,6 +2001,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
 	 */
 	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
 		xbufp->tail[0].iov_len;
+
+	xprt_init_majortimeo(task, req, &req->rq_xprt->bc_timeout);
 }
 #endif
 
-- 
2.43.0


