Return-Path: <linux-nfs+bounces-469-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DA980A90E
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6892B20B86
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Dec 2023 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2189938DF6;
	Fri,  8 Dec 2023 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXVFKVWG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF1B199E
	for <linux-nfs@vger.kernel.org>; Fri,  8 Dec 2023 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702053235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y4TVLto5yau0RPKvE5rj0WXkhDHoLDKrreZTCT+40mI=;
	b=CXVFKVWGl5HYvzQKju05soTNg2RGgrIg1bn7KayglQKzUNmhFMVoLvtKeKAX7gYAEno7I2
	D6BK2R55ebwAkMnLRws63YQi8R/lG8yyc2ZqFBs3iQvO+YOk2i5TE/XfqZxH5XPybYR8R2
	NUQ2TKywRgBDfgFK0S/EGiqcdC3KO0M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-KirhAhM-M5CSnv9hnaCBAw-1; Fri, 08 Dec 2023 11:33:53 -0500
X-MC-Unique: KirhAhM-M5CSnv9hnaCBAw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEA388F5DA8;
	Fri,  8 Dec 2023 16:33:52 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.48.3])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 627AB1C060AF;
	Fri,  8 Dec 2023 16:33:52 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fixup v4.1 backchannel request timeouts
Date: Fri,  8 Dec 2023 11:33:51 -0500
Message-ID: <d69074e4dc692ea7a9ccc866d8f87177539411e2.1702053194.git.bcodding@redhat.com>
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
 net/sunrpc/xprt.c           | 15 +++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

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
index 92301e32cda4..d9cbe0814fd8 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -655,9 +655,14 @@ static unsigned long xprt_abs_ktime_to_jiffies(ktime_t abstime)
 
 static unsigned long xprt_calc_majortimeo(struct rpc_rqst *req)
 {
-	const struct rpc_timeout *to = req->rq_task->tk_client->cl_timeout;
+	const struct rpc_timeout *to;
 	unsigned long majortimeo = req->rq_timeout;
 
+	if (req->rq_task->tk_client)
+		to = req->rq_task->tk_client->cl_timeout;
+	else
+		to = &req->rq_xprt->bc_timeout;
+
 	if (to->to_exponential)
 		majortimeo <<= to->to_retries;
 	else
@@ -686,7 +691,11 @@ static void xprt_init_majortimeo(struct rpc_task *task, struct rpc_rqst *req)
 		time_init = jiffies;
 	else
 		time_init = xprt_abs_ktime_to_jiffies(task->tk_start);
-	req->rq_timeout = task->tk_client->cl_timeout->to_initval;
+
+	if (task->tk_client)
+		req->rq_timeout = task->tk_client->cl_timeout->to_initval;
+	else
+		req->rq_timeout = req->rq_xprt->bc_timeout.to_initval;
 	req->rq_majortimeo = time_init + xprt_calc_majortimeo(req);
 	req->rq_minortimeo = time_init + req->rq_timeout;
 }
@@ -1998,6 +2007,8 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
 	 */
 	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
 		xbufp->tail[0].iov_len;
+
+	xprt_init_majortimeo(task, req);
 }
 #endif
 
-- 
2.43.0


