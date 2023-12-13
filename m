Return-Path: <linux-nfs+bounces-578-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C75811F53
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 20:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B145FB2118E
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 19:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E986C68296;
	Wed, 13 Dec 2023 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq5mQZ6q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469EEB7
	for <linux-nfs@vger.kernel.org>; Wed, 13 Dec 2023 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702496974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=o3HzT6oh0+evacpeJS+Py+8urFr12rVnLTX2CVihH+I=;
	b=gq5mQZ6qjcFEr2WyqbsbX+PzbkxB6zqhsZnRNipo/zp3bB1qrH+OJ0KjYgRj8HnBkV3fOi
	FJLmq+gYEpIr28dCZUwf9pKASCFZ1E9L1ZZkm1bqHZXrJPHHI7YMuxWf8HhpdAhjrvO5WB
	bQBqZQxklRxE/a7Xc00OSqmS24n+OX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-1D9ul27PP_qQwpGfCYc3UQ-1; Wed, 13 Dec 2023 14:49:31 -0500
X-MC-Unique: 1D9ul27PP_qQwpGfCYc3UQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4E8D88F2F0;
	Wed, 13 Dec 2023 19:49:30 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5949F492BC6;
	Wed, 13 Dec 2023 19:49:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/2] SUNRPC: Fixup v4.1 backchannel request timeouts
Date: Wed, 13 Dec 2023 14:49:28 -0500
Message-ID: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

After commit 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on
the sending list"), any 4.1 backchannel tasks placed on the sending queue
would immediately return with -ETIMEDOUT since their req timers are zero.

Initialize the backchannel's rpc_rqst timeout parameters from the xprt's
default timeout settings.

Fixes: 59464b262ff5 ("SUNRPC: SOFTCONN tasks should time out when on the sending list")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprt.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2364c485540c..6cc9ffac962d 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -651,9 +651,9 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
 		jiffies + nsecs_to_jiffies(-delta);
 }
 
-static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
+static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req,
+		const struct rpc_timeout *to)
 {
-	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
 	unsigned long majortimeo = req->rq_timeout;
 
 	if (to->to_exponential)
@@ -665,9 +665,10 @@ static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
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
@@ -675,7 +676,8 @@ static void xprt_reset_minortimeo(struct rpc_rqst *req)
 	req->rq_minortimeo += req->rq_timeout;
 }
 
-static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
+static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req,
+		const struct rpc_timeout *to)
 {
 	unsigned long time_init;
 	struct rpc_xprt *xprt = req->rq_xprt;
@@ -684,8 +686,9 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
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
 
@@ -713,7 +716,7 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 	} else {
 		req->rq_timeout = to->to_initval;
 		req->rq_retries = 0;
-		xprt_reset_majortimeo(req);
+		xprt_reset_majortimeo(req, to);
 		/* Reset the RTT counters == "slow start" */
 		spin_lock(&xprt->transport_lock);
 		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
@@ -1886,7 +1889,7 @@ xprt_request_init(struct rpc_task *task)
 	req->rq_snd_buf.bvec = NULL;
 	req->rq_rcv_buf.bvec = NULL;
 	req->rq_release_snd_buf = NULL;
-	xprt_init_majortimeo(task, req);
+	xprt_init_majortimeo(task, req, task->tk_client->cl_timeout);
 
 	trace_xprt_reserve(req);
 }
@@ -1996,6 +1999,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
 	 */
 	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
 		xbufp->tail[0].iov_len;
+
+	xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
 }
 #endif
 
-- 
2.43.0


