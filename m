Return-Path: <linux-nfs+bounces-19405-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDtfG1ymoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19405-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F81B8827
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75C5530E4DE6
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5982C178D;
	Fri, 27 Feb 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="siz9U7ET"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85D628A72B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201034; cv=none; b=LFDAoyWZBOGpKSOl2Xn6wCU1qA8mBcUjw8dKcmdeVzaGQP5vgToWAQIEjmvLfRhZ+iz8HqjOEmrFuplBPaAFsoO1AQqWzhhbsQk19wXNgnPfkxa/JNgfooCjxyCMWV3qX020q/uVt47saQ2SCZwLit1EPmGFj+uziYSl+G1VJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201034; c=relaxed/simple;
	bh=nhtLBQFsYrEcWukWenDs/69dwA9RhyhN6HWXtENsQHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rizcJucG7P/a6Lg+1PcA9j2+mLfjerb4TX1qGlXr6UyPu/c22bVcnxvbAh09+H0DpoHU8RhXcglj8b+3tLOfzFHeE5Yj1qkDISjQYWef6yjFfJu/L1ZdexWg9rsVUUcoIQ/9al4j41Dw+e6TUsyqElJjFRo0VlKCPjAgRs90jWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=siz9U7ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD338C2BC86;
	Fri, 27 Feb 2026 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201034;
	bh=nhtLBQFsYrEcWukWenDs/69dwA9RhyhN6HWXtENsQHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=siz9U7ETlhrhA5IrxuThuFYZfeQ90BsVkPH626f6Rs48z2qnZ0Ddfubu4vEQKjP7k
	 pC7OBvU+dqFzZ2A2J3SZxmsuu6ziQPjR+0ORmjpsLJhBIy0uC/qLco3EBuHsRJvW7U
	 2O3euN1TsgkBAYHBzk6yhl9Uig+Twmvtxj9QIdEnMpPg6kkF30Ose4gYeNghbukFxt
	 Y2KfN51Y15vRc4yDy3CH7fI8IL16Tdl5KJp84argaC81jeBWM39PdBrlZH2duhz8cS
	 qOmjlWbxAacAU4jqDND1hX0J3P+3oW79UnNxodQYqgyYfbud5Q1tE7z1DdqCt5pIvO
	 45wpmm4Hto9WA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 08/18] svcrdma: Convert Read completion queue to use lock-free list
Date: Fri, 27 Feb 2026 09:03:35 -0500
Message-ID: <20260227140345.40488-9-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227140345.40488-1-cel@kernel.org>
References: <20260227140345.40488-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19405-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 2E9F81B8827
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Extend the lock-free list conversion to sc_read_complete_q. This
queue tracks receive contexts that have completed RDMA Read
operations for handling Read chunks.

With both sc_rq_dto_q and sc_read_complete_q now using llist,
the sc_rq_dto_lock spinlock is no longer needed and is removed.
This eliminates all locking from the receive and Read completion
paths.

Note that llist provides LIFO ordering rather than FIFO. For
independent RPC requests this has no semantic impact.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  4 +--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 44 +++++++++---------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 10 +++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  5 +--
 4 files changed, 24 insertions(+), 39 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 884a29cecfa0..8f6483ed9e5f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -130,8 +130,7 @@ struct svcxprt_rdma {
 	u32		     sc_pending_recvs ____cacheline_aligned_in_smp;
 	u32		     sc_recv_batch;
 	struct llist_head    sc_rq_dto_q;
-	struct list_head     sc_read_complete_q;
-	spinlock_t	     sc_rq_dto_lock;
+	struct llist_head    sc_read_complete_q;
 
 	spinlock_t	     sc_lock;		/* transport lock */
 
@@ -203,7 +202,6 @@ struct svc_rdma_chunk_ctxt {
 
 struct svc_rdma_recv_ctxt {
 	struct llist_node	rc_node;
-	struct list_head	rc_list;
 	struct ib_recv_wr	rc_recv_wr;
 	struct ib_cqe		rc_cqe;
 	struct rpc_rdma_cid	rc_cid;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index e99adf14fa9b..1bd6b0da002f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -108,13 +108,6 @@
 
 static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc);
 
-static inline struct svc_rdma_recv_ctxt *
-svc_rdma_next_recv_ctxt(struct list_head *list)
-{
-	return list_first_entry_or_null(list, struct svc_rdma_recv_ctxt,
-					rc_list);
-}
-
 static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
@@ -386,14 +379,21 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
  * svc_rdma_flush_recv_queues - Drain pending Receive work
  * @rdma: svcxprt_rdma being shut down
  *
+ * Called from svc_rdma_free() after ib_drain_qp() has blocked until
+ * completion queues are empty and flush_workqueue() has waited for
+ * pending work items. These preceding calls guarantee no concurrent
+ * producers (completion handlers) or consumers (svc_rdma_recvfrom)
+ * can be active, making unsynchronized llist_del_all() safe here.
  */
 void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 	struct llist_node *node;
 
-	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_read_complete_q))) {
-		list_del(&ctxt->rc_list);
+	node = llist_del_all(&rdma->sc_read_complete_q);
+	while (node) {
+		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+		node = node->next;
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 	}
 	node = llist_del_all(&rdma->sc_rq_dto_q);
@@ -946,17 +946,13 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	rqstp->rq_xprt_ctxt = NULL;
 
-	spin_lock(&rdma_xprt->sc_rq_dto_lock);
-	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
-	if (ctxt) {
-		list_del(&ctxt->rc_list);
-		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+	node = llist_del_first(&rdma_xprt->sc_read_complete_q);
+	if (node) {
+		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
 		svc_xprt_received(xprt);
 		svc_rdma_read_complete(rqstp, ctxt);
 		goto complete;
 	}
-	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
-
 	node = llist_del_first(&rdma_xprt->sc_rq_dto_q);
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
@@ -968,20 +964,12 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		/*
 		 * If a completion arrived after llist_del_first but
 		 * before clear_bit, the producer's set_bit would be
-		 * cleared above. Recheck to close this race window.
+		 * cleared above. Recheck both queues to close this
+		 * race window.
 		 */
-		if (!llist_empty(&rdma_xprt->sc_rq_dto_q))
+		if (!llist_empty(&rdma_xprt->sc_rq_dto_q) ||
+		    !llist_empty(&rdma_xprt->sc_read_complete_q))
 			set_bit(XPT_DATA, &xprt->xpt_flags);
-
-		/* Recheck sc_read_complete_q under lock for the same
-		 * reason -- svc_rdma_wc_read_done() may have added an
-		 * entry and set XPT_DATA between our earlier unlock
-		 * and the clear_bit above.
-		 */
-		spin_lock(&rdma_xprt->sc_rq_dto_lock);
-		if (!list_empty(&rdma_xprt->sc_read_complete_q))
-			set_bit(XPT_DATA, &xprt->xpt_flags);
-		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
 	}
 
 	/* Unblock the transport for the next receive */
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index b1237d81075b..554463c72f1f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -370,11 +370,13 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_read(wc, &cc->cc_cid, ctxt->rc_readbytes,
 				      cc->cc_posttime);
 
-		spin_lock(&rdma->sc_rq_dto_lock);
-		list_add_tail(&ctxt->rc_list, &rdma->sc_read_complete_q);
-		/* the unlock pairs with the smp_rmb in svc_xprt_ready */
+		llist_add(&ctxt->rc_node, &rdma->sc_read_complete_q);
+		/*
+		 * The implicit barrier of llist_add's cmpxchg pairs with
+		 * the smp_rmb in svc_xprt_ready, ensuring the list update
+		 * is visible before XPT_DATA is observed.
+		 */
 		set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
-		spin_unlock(&rdma->sc_rq_dto_lock);
 		svc_xprt_enqueue(&rdma->sc_xprt);
 		return;
 	case IB_WC_WR_FLUSH_ERR:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index ff9bae18a1aa..9f52d2c6666d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -164,7 +164,6 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 {
 	static struct lock_class_key svcrdma_rwctx_lock;
 	static struct lock_class_key svcrdma_sctx_lock;
-	static struct lock_class_key svcrdma_dto_lock;
 	struct svcxprt_rdma *cma_xprt;
 
 	cma_xprt = kzalloc_node(sizeof(*cma_xprt), GFP_KERNEL, node);
@@ -174,7 +173,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	init_llist_head(&cma_xprt->sc_rq_dto_q);
-	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
+	init_llist_head(&cma_xprt->sc_read_complete_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
@@ -182,8 +181,6 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	init_waitqueue_head(&cma_xprt->sc_sq_ticket_wait);
 
 	spin_lock_init(&cma_xprt->sc_lock);
-	spin_lock_init(&cma_xprt->sc_rq_dto_lock);
-	lockdep_set_class(&cma_xprt->sc_rq_dto_lock, &svcrdma_dto_lock);
 	spin_lock_init(&cma_xprt->sc_send_lock);
 	lockdep_set_class(&cma_xprt->sc_send_lock, &svcrdma_sctx_lock);
 	spin_lock_init(&cma_xprt->sc_rw_ctxt_lock);
-- 
2.53.0


