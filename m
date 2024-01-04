Return-Path: <linux-nfs+bounces-935-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D017A82443F
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 15:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74461C21C59
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Jan 2024 14:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ED123749;
	Thu,  4 Jan 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrwIJ1uc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8DD2375B
	for <linux-nfs@vger.kernel.org>; Thu,  4 Jan 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704380334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3NpcJS6ChPIcMpR0sNlBGfOvSRAvmwAbierFEmh6pAs=;
	b=BrwIJ1ucOJrgHxhetkK2vZ65n10IDSGyGraFVlzCqgNomsOc14C9AP7WR7qA2cnO1ztZVi
	g0wxqGpvVMNg4SwQuRloE58eSNtrt4G22NHoCTuj4oxAsWC7tgpQ065J7Y5i9HxDMGIXL/
	Ed0GXg+XsKNMlpSOZj4I723e6mpybiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-m1ApfVEtMgaEZr9f-JoLJQ-1; Thu, 04 Jan 2024 09:58:50 -0500
X-MC-Unique: m1ApfVEtMgaEZr9f-JoLJQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3556C101A52A;
	Thu,  4 Jan 2024 14:58:49 +0000 (UTC)
Received: from bcodding.csb.redhat.com (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2F9E71121313;
	Thu,  4 Jan 2024 14:58:48 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/2] NFSv4.1: Use the nfs_client's rpc timeouts for backchannel
Date: Thu,  4 Jan 2024 09:58:46 -0500
Message-ID: <8a862f8ad3cb9f65decffb2956fb8674451af25c.1704379780.git.bcodding@redhat.com>
In-Reply-To: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
References: <e28038fba1243f00b0dd66b7c5296a1e181645ea.1704379780.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

For backchannel requests that lookup the appropriate nfs_client, use the
state-management rpc_clnt's rpc_timeout parameters for the backchannel's
response.  When the nfs_client cannot be found, fall back to using the
xprt's default timeout parameters.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/callback_xdr.c          |  5 +++++
 include/linux/sunrpc/bc_xprt.h |  3 ++-
 include/linux/sunrpc/sched.h   | 14 +++++++++++++-
 include/linux/sunrpc/svc.h     |  2 ++
 include/linux/sunrpc/xprt.h    | 11 -----------
 net/sunrpc/clnt.c              |  6 ++++--
 net/sunrpc/svc.c               | 11 ++++++++++-
 net/sunrpc/xprt.c              | 12 +++++++++---
 8 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/callback_xdr.c b/fs/nfs/callback_xdr.c
index 321af81c456e..9369488f2ed4 100644
--- a/fs/nfs/callback_xdr.c
+++ b/fs/nfs/callback_xdr.c
@@ -967,6 +967,11 @@ static __be32 nfs4_callback_compound(struct svc_rqst *rqstp)
 		nops--;
 	}
 
+	if (svc_is_backchannel(rqstp) && cps.clp) {
+		rqstp->bc_to_initval = cps.clp->cl_rpcclient->cl_timeout->to_initval;
+		rqstp->bc_to_retries = cps.clp->cl_rpcclient->cl_timeout->to_retries;
+	}
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
index 8ada7dc802d3..2d61987b3545 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -37,6 +37,17 @@ struct rpc_wait {
 	struct list_head	timer_list;	/* Timer list */
 };
 
+/*
+ * This describes a timeout strategy
+ */
+struct rpc_timeout {
+	unsigned long		to_initval,		/* initial timeout */
+				to_maxval,		/* max timeout */
+				to_increment;		/* if !exponential */
+	unsigned int		to_retries;		/* max # of retries */
+	unsigned char		to_exponential;
+};
+
 /*
  * This is the RPC task struct
  */
@@ -205,7 +216,8 @@ struct rpc_wait_queue {
  */
 struct rpc_task *rpc_new_task(const struct rpc_task_setup *);
 struct rpc_task *rpc_run_task(const struct rpc_task_setup *);
-struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req);
+struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
+		struct rpc_timeout *timeout);
 void		rpc_put_task(struct rpc_task *);
 void		rpc_put_task_async(struct rpc_task *);
 bool		rpc_task_set_rpc_status(struct rpc_task *task, int rpc_status);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index b10f987509cc..3331a1c2b47e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -250,6 +250,8 @@ struct svc_rqst {
 	struct net		*rq_bc_net;	/* pointer to backchannel's
 						 * net namespace
 						 */
+	unsigned long	bc_to_initval;
+	unsigned int	bc_to_retries;
 	void **			rq_lease_breaker; /* The v4 client breaking a lease */
 	unsigned int		rq_status_counter; /* RPC processing counter */
 };
diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index f85d3a0daca2..464f6a9492ab 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -30,17 +30,6 @@
 #define RPC_MAXCWND(xprt)	((xprt)->max_reqs << RPC_CWNDSHIFT)
 #define RPCXPRT_CONGESTED(xprt) ((xprt)->cong >= (xprt)->cwnd)
 
-/*
- * This describes a timeout strategy
- */
-struct rpc_timeout {
-	unsigned long		to_initval,		/* initial timeout */
-				to_maxval,		/* max timeout */
-				to_increment;		/* if !exponential */
-	unsigned int		to_retries;		/* max # of retries */
-	unsigned char		to_exponential;
-};
-
 enum rpc_display_format_t {
 	RPC_DISPLAY_ADDR = 0,
 	RPC_DISPLAY_PORT,
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index daa9582ec861..886fc4c76558 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1302,8 +1302,10 @@ static void call_bc_encode(struct rpc_task *task);
  * rpc_run_bc_task - Allocate a new RPC task for backchannel use, then run
  * rpc_execute against it
  * @req: RPC request
+ * @timeout: timeout values to use for this task
  */
-struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
+struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req,
+		struct rpc_timeout *timeout)
 {
 	struct rpc_task *task;
 	struct rpc_task_setup task_setup_data = {
@@ -1322,7 +1324,7 @@ struct rpc_task *rpc_run_bc_task(struct rpc_rqst *req)
 		return task;
 	}
 
-	xprt_init_bc_request(req, task);
+	xprt_init_bc_request(req, task, timeout);
 
 	task->tk_action = call_bc_encode;
 	atomic_inc(&task->tk_count);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3f2ea7a0496f..3f714d33624b 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1557,6 +1557,7 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 {
 	struct rpc_task *task;
 	int proc_error;
+	struct rpc_timeout timeout;
 
 	/* Build the svc_rqst used by the common processing routine */
 	rqstp->rq_xid = req->rq_xid;
@@ -1602,8 +1603,16 @@ void svc_process_bc(struct rpc_rqst *req, struct svc_rqst *rqstp)
 		return;
 	}
 	/* Finally, send the reply synchronously */
+	if (rqstp->bc_to_initval > 0) {
+		timeout.to_initval = rqstp->bc_to_initval;
+		timeout.to_retries = rqstp->bc_to_initval;
+	} else {
+		timeout.to_initval = req->rq_xprt->timeout->to_initval;
+		timeout.to_initval = req->rq_xprt->timeout->to_retries;
+	}
 	memcpy(&req->rq_snd_buf, &rqstp->rq_res, sizeof(req->rq_snd_buf));
-	task = rpc_run_bc_task(req);
+	task = rpc_run_bc_task(req, &timeout);
+
 	if (IS_ERR(task))
 		return;
 
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 6cc9ffac962d..af13fdfa6672 100644
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
 
@@ -1999,8 +2000,13 @@ xprt_init_bc_request(struct rpc_rqst *req, struct rpc_task *task)
 	 */
 	xbufp->len = xbufp->head[0].iov_len + xbufp->page_len +
 		xbufp->tail[0].iov_len;
-
-	xprt_init_majortimeo(task, req, req->rq_xprt->timeout);
+	/*
+	 * Backchannel Replies are sent with !RPC_TASK_SOFT and
+	 * RPC_TASK_NO_RETRANS_TIMEOUT. The major timeout setting
+	 * affects only how long each Reply waits to be sent when
+	 * a transport connection cannot be established.
+	 */
+	xprt_init_majortimeo(task, req, to);
 }
 #endif
 
-- 
2.43.0


