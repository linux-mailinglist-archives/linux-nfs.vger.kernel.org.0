Return-Path: <linux-nfs+bounces-19407-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHlnGv2ooWm1vQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19407-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:23:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADAF1B8D37
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D825F31DD2D1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0921423167;
	Fri, 27 Feb 2026 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi6KfS1W"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D33E41C2F5
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201036; cv=none; b=Cleogqzpam1Ma0YyoBPQf7xeTHGHnBspyVGgF3sWBxUvbA92/mTg+MjfjrK9IySg0qLejjl8RR/EbyGEYXXF1jTOZPsTQHifjKWFUij8s2DiDoHqTPHgHVGVH4B3276jAHewvrO1nKiGbj0LNOUAsdkrqS9IG1JlS/h9wM0Gn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201036; c=relaxed/simple;
	bh=+Qkb0pz1wT36WooWm/npg0rNXOKV2+23T2mHQCVpovA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBBNSqc/QR3iI8IFuIbzx0xmoiUt3aBnQneVjWIXpByhPHOdWTRcebDOCHgyQ7EAD++qdZ8zZU4xE5M7BVx0W2Sdha86kOj02+ubqIKTNTAzqaACG+zbA4AwJ3EqyBgMhBV93wtVNmS1pL8O/RwO2jC/4jUpSn7U7Qp9BZSie8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi6KfS1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823CBC19423;
	Fri, 27 Feb 2026 14:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201036;
	bh=+Qkb0pz1wT36WooWm/npg0rNXOKV2+23T2mHQCVpovA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xi6KfS1Whg/HmnbVwnGgQ5jO1Zcydc8ZyXvD7qyP1YuVN/chpp808qxh+cFFp5+Uc
	 yItwkNN/pxayaFAmugiqiVEnxnWqKGz2Cxukax9pzCv+Lfh+Ag04QrCrfVftL2BR40
	 /lPfSthF0441b2LxqVHpwhDWt8KATKsH1q7Gsdnz0vBnuuKULd9pOZZbpe3Y+UyyR6
	 rX/irtLhteFkP/LrpeKttMpjV8w0jvAiOP5titqdhGaIDrNSvkonFWt+o4PEDmiXIM
	 QvLcabKbKDkSLLdXWTTK4QZjz6Bz68+Mt6VSGcM/iTbOXoYlGSIV0FZa0WobQRTUDL
	 LKdM1N0expU+A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 10/18] svcrdma: Defer send context release to xpo_release_ctxt
Date: Fri, 27 Feb 2026 09:03:37 -0500
Message-ID: <20260227140345.40488-11-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19407-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CADAF1B8D37
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Send completion currently queues a work item to an unbound
workqueue for each completed send context. Under load, the
Send Completion handlers contend for the shared workqueue
pool lock.

Replace the workqueue with a per-transport lock-free list
(llist). The Send completion handler appends the send_ctxt
to sc_send_release_list and does no further teardown. The
nfsd thread drains the list in xpo_release_ctxt between
RPCs, performing DMA unmapping, chunk I/O resource release,
and page release in a batch.

This eliminates both the workqueue pool lock and the DMA
unmap cost from the Send completion path. DMA unmapping can
be expensive when an IOMMU is present in strict mode, as
each unmap triggers a synchronous hardware IOTLB
invalidation. Moving it to the nfsd thread, where that
latency is harmless, avoids penalizing completion handler
throughput.

The nfsd threads absorb the release cost at a point where
the client is no longer waiting on a reply, and natural
batching amortizes the overhead when completions arrive
faster than RPCs complete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          | 10 ++--
 net/sunrpc/xprtrdma/svc_rdma.c           | 18 +------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 10 ++--
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 68 ++++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  3 +-
 5 files changed, 59 insertions(+), 50 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a2d3232593a2..562a5f78cd3f 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -66,7 +66,6 @@ extern unsigned int svcrdma_ord;
 extern unsigned int svcrdma_max_requests;
 extern unsigned int svcrdma_max_bc_requests;
 extern unsigned int svcrdma_max_req_size;
-extern struct workqueue_struct *svcrdma_wq;
 
 extern struct percpu_counter svcrdma_stat_read;
 extern struct percpu_counter svcrdma_stat_recv;
@@ -89,8 +88,9 @@ extern struct percpu_counter svcrdma_stat_write;
  *
  * When adding a field, place it in the zone whose code path modifies the
  * field under load. Read-only fields can fill padding in any zone that
- * accesses them. Fields modified by multiple paths remain at the end,
- * outside any aligned zone.
+ * accesses them. Fields modified by multiple paths (e.g.
+ * sc_recv_ctxts, sc_send_release_list) remain at the end, outside
+ * any aligned zone.
  */
 struct svcxprt_rdma {
 	struct svc_xprt      sc_xprt;		/* SVC transport structure */
@@ -140,6 +140,8 @@ struct svcxprt_rdma {
 
 	struct llist_head    sc_recv_ctxts;
 
+	struct llist_head    sc_send_release_list;
+
 	atomic_t	     sc_completion_ids;
 };
 /* sc_flags */
@@ -257,7 +259,6 @@ struct svc_rdma_write_info {
 struct svc_rdma_send_ctxt {
 	struct llist_node	sc_node;
 	struct rpc_rdma_cid	sc_cid;
-	struct work_struct	sc_work;
 
 	struct svcxprt_rdma	*sc_rdma;
 	struct ib_send_wr	sc_send_wr;
@@ -321,6 +322,7 @@ extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
 /* svc_rdma_sendto.c */
 extern void svc_rdma_send_ctxts_destroy(struct svcxprt_rdma *rdma);
+extern void svc_rdma_send_ctxts_drain(struct svcxprt_rdma *rdma);
 extern struct svc_rdma_send_ctxt *
 		svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma);
 extern void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
diff --git a/net/sunrpc/xprtrdma/svc_rdma.c b/net/sunrpc/xprtrdma/svc_rdma.c
index 415c0310101f..f67f0612b1a9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma.c
+++ b/net/sunrpc/xprtrdma/svc_rdma.c
@@ -264,38 +264,22 @@ static int svc_rdma_proc_init(void)
 	return rc;
 }
 
-struct workqueue_struct *svcrdma_wq;
-
 void svc_rdma_cleanup(void)
 {
 	svc_unreg_xprt_class(&svc_rdma_class);
 	svc_rdma_proc_cleanup();
-	if (svcrdma_wq) {
-		struct workqueue_struct *wq = svcrdma_wq;
-
-		svcrdma_wq = NULL;
-		destroy_workqueue(wq);
-	}
 
 	dprintk("SVCRDMA Module Removed, deregister RPC RDMA transport\n");
 }
 
 int svc_rdma_init(void)
 {
-	struct workqueue_struct *wq;
 	int rc;
 
-	wq = alloc_workqueue("svcrdma", WQ_UNBOUND, 0);
-	if (!wq)
-		return -ENOMEM;
-
 	rc = svc_rdma_proc_init();
-	if (rc) {
-		destroy_workqueue(wq);
+	if (rc)
 		return rc;
-	}
 
-	svcrdma_wq = wq;
 	svc_reg_xprt_class(&svc_rdma_class);
 
 	dprintk("SVCRDMA Module Init, register RPC RDMA transport\n");
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 1bd6b0da002f..2281f9adc9f3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -244,6 +244,8 @@ void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
 
 	if (ctxt)
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
+
+	svc_rdma_send_ctxts_drain(rdma);
 }
 
 static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
@@ -379,11 +381,9 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
  * svc_rdma_flush_recv_queues - Drain pending Receive work
  * @rdma: svcxprt_rdma being shut down
  *
- * Called from svc_rdma_free() after ib_drain_qp() has blocked until
- * completion queues are empty and flush_workqueue() has waited for
- * pending work items. These preceding calls guarantee no concurrent
- * producers (completion handlers) or consumers (svc_rdma_recvfrom)
- * can be active, making unsynchronized llist_del_all() safe here.
+ * Caller must guarantee that @rdma's Send Completion queue is empty and
+ * all send contexts have been released. This guarantees concurrent
+ * producers and consumers are no longer active.
  */
 void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 263da6f76267..c8686fdfe788 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -79,21 +79,26 @@
  * The ownership of all of the Reply's pages are transferred into that
  * ctxt, the Send WR is posted, and sendto returns.
  *
- * The svc_rdma_send_ctxt is presented when the Send WR completes. The
- * Send completion handler finally releases the Reply's pages.
+ * The svc_rdma_send_ctxt is presented when the Send WR completes.
+ * The Send completion handler queues the send_ctxt onto the
+ * per-transport sc_send_release_list (a lock-free llist). The
+ * nfsd thread drains sc_send_release_list in xpo_release_ctxt
+ * between RPCs, DMA-unmapping SGEs, releasing chunk I/O
+ * resources and pages, and returning send_ctxts to the free
+ * list in a batch.
  *
- * This mechanism also assumes that completions on the transport's Send
- * Completion Queue do not run in parallel. Otherwise a Write completion
- * and Send completion running at the same time could release pages that
- * are still DMA-mapped.
+ * Correctness depends on completions on the transport's Send
+ * Completion Queue being serialized. Otherwise a Write
+ * completion and Send completion running at the same time could
+ * queue a send_ctxt whose pages are still DMA-mapped.
  *
  * Error Handling
  *
  * - If the Send WR is posted successfully, it will either complete
  *   successfully, or get flushed. Either way, the Send completion
- *   handler releases the Reply's pages.
- * - If the Send WR cannot be not posted, the forward path releases
- *   the Reply's pages.
+ *   handler queues the send_ctxt for deferred release.
+ * - If the Send WR cannot be posted, the forward path releases the
+ *   Reply's pages.
  *
  * This handles the case, without the use of page reference counting,
  * where two different Write segments send portions of the same page.
@@ -232,8 +237,9 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	goto out;
 }
 
-static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
-				       struct svc_rdma_send_ctxt *ctxt)
+/* DMA-unmap SGEs and release chunk I/O resources. */
+static void svc_rdma_send_ctxt_unmap(struct svcxprt_rdma *rdma,
+				     struct svc_rdma_send_ctxt *ctxt)
 {
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
@@ -241,9 +247,6 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	svc_rdma_write_chunk_release(rdma, ctxt);
 	svc_rdma_reply_chunk_release(rdma, ctxt);
 
-	if (ctxt->sc_page_count)
-		release_pages(ctxt->sc_pages, ctxt->sc_page_count);
-
 	/* The first SGE contains the transport header, which
 	 * remains mapped until @ctxt is destroyed.
 	 */
@@ -256,30 +259,49 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 				  ctxt->sc_sges[i].length,
 				  DMA_TO_DEVICE);
 	}
+}
+
+/* Unmap, release pages, and return send_ctxt to the free list. */
+static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
+				       struct svc_rdma_send_ctxt *ctxt)
+{
+	svc_rdma_send_ctxt_unmap(rdma, ctxt);
+
+	if (ctxt->sc_page_count)
+		release_pages(ctxt->sc_pages, ctxt->sc_page_count);
 
 	llist_add(&ctxt->sc_node, &rdma->sc_send_ctxts);
 }
 
-static void svc_rdma_send_ctxt_put_async(struct work_struct *work)
+/**
+ * svc_rdma_send_ctxts_drain - Release completed send_ctxts
+ * @rdma: controlling svcxprt_rdma
+ *
+ * Called from xpo_release_ctxt and during transport teardown.
+ */
+void svc_rdma_send_ctxts_drain(struct svcxprt_rdma *rdma)
 {
-	struct svc_rdma_send_ctxt *ctxt;
+	struct svc_rdma_send_ctxt *ctxt, *next;
+	struct llist_node *node;
 
-	ctxt = container_of(work, struct svc_rdma_send_ctxt, sc_work);
-	svc_rdma_send_ctxt_release(ctxt->sc_rdma, ctxt);
+	node = llist_del_all(&rdma->sc_send_release_list);
+	llist_for_each_entry_safe(ctxt, next, node, sc_node)
+		svc_rdma_send_ctxt_release(rdma, ctxt);
 }
 
 /**
- * svc_rdma_send_ctxt_put - Return send_ctxt to free list
+ * svc_rdma_send_ctxt_put - Queue send_ctxt for deferred release
  * @rdma: controlling svcxprt_rdma
- * @ctxt: object to return to the free list
+ * @ctxt: send_ctxt to queue for deferred release
  *
- * Pages left in sc_pages are DMA unmapped and released.
+ * Queues @ctxt for deferred release via the per-transport
+ * sc_send_release_list. DMA unmapping and page release run
+ * later in svc_rdma_send_ctxts_drain().
  */
 void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_send_ctxt *ctxt)
 {
-	INIT_WORK(&ctxt->sc_work, svc_rdma_send_ctxt_put_async);
-	queue_work(svcrdma_wq, &ctxt->sc_work);
+	llist_add(&ctxt->sc_node, &rdma->sc_send_release_list);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9f52d2c6666d..719566234277 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -177,6 +177,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
+	init_llist_head(&cma_xprt->sc_send_release_list);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
 	init_waitqueue_head(&cma_xprt->sc_sq_ticket_wait);
 
@@ -610,7 +611,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
-	flush_workqueue(svcrdma_wq);
+	svc_rdma_send_ctxts_drain(rdma);
 
 	svc_rdma_flush_recv_queues(rdma);
 
-- 
2.53.0


