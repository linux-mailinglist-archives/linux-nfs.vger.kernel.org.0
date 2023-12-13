Return-Path: <linux-nfs+bounces-577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68820811F52
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AABF1C2085D
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Dec 2023 19:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA0745C3;
	Wed, 13 Dec 2023 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q7S+31Rj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2FFA7
	for <linux-nfs@vger.kernel.org>; Wed, 13 Dec 2023 11:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702496973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QVhm8VcH2j9S/AlxOQHCW35XWjWBN+tIS7GVlHolbsY=;
	b=Q7S+31RjHX44alWcli0LV2xOHaTKXCpwqkBW6i9iqDTUpTzxf/n31ea7J1FPgMC6RYXlJY
	n74mCnRC8EaKyk6WbPndwjlTjtAtRyOeM48X39u4JaxSI5Le5g7PxgI8v6syo/ox/ShAEZ
	IcHDVpG22MZ9VL0LJ7F35GdfEeO+JSI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-xfydycZsMUO4gNxu29DLJg-1; Wed,
 13 Dec 2023 14:49:31 -0500
X-MC-Unique: xfydycZsMUO4gNxu29DLJg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 51DB61C05134;
	Wed, 13 Dec 2023 19:49:31 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D98DB492BC6;
	Wed, 13 Dec 2023 19:49:30 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 2/2] NFSv4.1: Use the nfs_client's rpc timeouts for backchannel
Date: Wed, 13 Dec 2023 14:49:29 -0500
Message-ID: <90c9365ad91e1eb0058b170fb332ea70ad554d8b.1702496910.git.bcodding@redhat.com>
In-Reply-To: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1702496910.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

For backchannel requests that lookup the appropriate nfs_client, use the
state-management rpc_clnt's rpc_timeout parameters for the backchannel's
response.  When the nfs_client cannot be found, fall back to using the
xprt's default timeout parameters.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/callback_proc.c         | 3 +++
 fs/nfs/callback_xdr.c          | 3 +++
 include/linux/sunrpc/bc_xprt.h | 3 ++-
 include/linux/sunrpc/sched.h   | 3 ++-
 include/linux/sunrpc/svc.h     | 1 +
 net/sunrpc/clnt.c              | 8 ++++++--
 net/sunrpc/svc.c               | 6 +++++-
 net/sunrpc/xprt.c              | 5 +++--
 8 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/callback_proc.c b/fs/nfs/callback_proc.c
index 96a4923080ae..8ce721eba383 100644
--- a/fs/nfs/callback_proc.c
+++ b/fs/nfs/callback_proc.c
@@ -504,6 +504,9 @@ __be32 nfs4_callback_sequence(void *argp, void *resp,
 	if (!(clp->cl_session->flags & SESSION4_BACK_CHAN))
 		goto out;
 
+	/* release in svc_process_bc */
+	refcount_inc(&clp->cl_rpcclient->cl_count);
+
 	tbl = &clp->cl_session->bc_slot_table;
 
 	/* Set up res before grabbing the spinlock */
diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 321af81c456e..40a43d615b82 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -967,6 +967,9 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 		nops--;
 	}
 
+	if (svc_is_backchannel(rqstp) && cps.clp)
+		rqstp->bc_rpc_clnt = cps.clp->cl_rpcclient;
+
 	*hdr_res.status = status;
 	*hdr_res.nops = htonl(nops);
 	nfs4_cb_free_slot(&cps);
diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index db30a159f9d5..f22bf915dcf6 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -20,7 +20,8 @@
 #ifdef CONFIG_SUNRPC_BACKCHANNEL
 struct rpc_rqst *xprt_lookup_bc_request(struct rpc_xprt *xprt, __be32 xid);
 void xprt_complete_bc_request(struct rpc_rqst *req, uint32_t copied);
-void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task);
+void xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
+		const struct rpc_timeout *to);
 void xprt_free_bc_request(struct rpc_rqst *req);
 int xprt_setup_backchannel(struct rpc_xprt *, unsigned int min_reqs);
 void xprt_destroy_backchannel(struct rpc_xprt *, unsigned int max_reqs);
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 8ada7dc802d3..786c1d2e9d6a 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -205,7 +205,8 @@ struct rpc_wait_queue {
  */
 struct rpc_task *rpc_new_task(const struct rpc_task_setup *);
 struct rpc_task *rpc_run_task(const struct rpc_task_setup *);
-struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req);
+struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
+		struct rpc_clnt *clnt);
 void		rpc_put_task(struct rpc_task *);
 void		rpc_put_task_async(struct rpc_task *);
 bool		rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index b10f987509cc..1c727a422a65 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -250,6 +250,7 @@ struct svc_rqst {
 	struct net		*rq_bc_net;	/* pointer to backchannel's
 						 * net namespace
 						 */
+	struct rpc_clnt		*bc_rpc_clnt;	/* v4.1 backchannel RPC client */
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
 	unsigned int		rq_status_counter; /* RPC processing counter */
 };
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index daa9582ec861..1946c2b39de3 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1302,9 +1302,12 @@ static void call_bc_encode(struct rpc_task *task);
  * rpc_run_bc_task - Allocate a new RPC task for backchannel use, then run
  * rpc_execute against it
  * @req: RPC request
+ * @clnt: RPC client from request's cl_rpcclient
  */
-struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
+struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
+		struct rpc_clnt *clnt)
 {
+	const struct rpc_timeout *timeout;
 	struct rpc_task *task;
 	struct rpc_task_setup task_setup_data = {
 		.callback_ops = &rpc_default_ops,
@@ -1322,7 +1325,8 @@ struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
 		return task;
 	}
 
-	xprt_init_bc_request(req, task);
+	timeout = clnt ? clnt->cl_timeout : req->rq_xprt->timeout;
+	xprt_init_bc_request(req, task, timeout);
 
 	task->tk_action = call_bc_encode;
 	atomic_inc(&task->tk_count);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3f2ea7a0496f..47685c05499a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1603,7 +1603,11 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 	}
 	/* Finally, send the reply synchronously */
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
-	task = rpc_run_bc_task(req);
+	task = rpc_run_bc_task(req, rqstp->bc_rpc_clnt);
+
+	if (rqstp->bc_rpc_clnt)
+		rpc_release_client(rqstp->bc_rpc_clnt);
+
 	if (IS_ERR(task))
 		return;
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 6cc9ffac962d..6f69975f3764 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1986,7 +1986,8 @@ void xprt_release(struct rpc_task *task)
 
 #ifdef CONFIG_SUNRPC_BACKCHANNEL
 void
-xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
+xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task,
+		const struct rpc_timeout *to)
 {
 	struct xdr_buf *xbufp = &req->rq_snd_buf;
 
@@ -2000,7 +2001,7 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
 	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
 		xbufp->tail[0].iov_len;
 
-	xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
+	xprt_init_majortimeo(task, req, to);
 }
 #endif
 
-- 
2.43.0


