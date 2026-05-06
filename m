Return-Path: <linux-nfs+bounces-21413-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILeqAOBg+2kuaQMAu9opvQ
	(envelope-from <linux-nfs+bounces-21413-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 17:40:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 039C04DD6D1
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 17:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8627D30958EB
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70A47CC80;
	Wed,  6 May 2026 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0eeodaV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CB421EF4;
	Wed,  6 May 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778081239; cv=none; b=UhfSNy5Si48cnKlhWfVp0b8UR6NLY99LUaW9OzX5KAMiQHN5zT2nu/Z2duiHzQhbiqE7Wo4qlwHWpqffx09iU/UY3OYAoHKHwaLFzLqD6wOwDl0/3bpg0zW8UGqTaYv9mf29ki1V9WAIEkHGq8122prMpyqOOhwRc5AFDO7V9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778081239; c=relaxed/simple;
	bh=ALvNbH/XI5he1UOYaAeW+P1+Xx+oIH1pVuauhVr2yEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bIT8V641eRFXTVxlYwb1R+RtxwIGftqnNwo9EZe6bYYMQfvtQWb/8EbFnQYHOxusbn1c1lviyVYgTXgnhgT0qIEG+nkGPMVoCMNLP7kuKg4XLOvbUirkrWntxTQnQCVacL9jalkAkMv3kABj1CU0154wMppepflnhQQuXBy9XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0eeodaV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B7FC2BCB0;
	Wed,  6 May 2026 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778081238;
	bh=ALvNbH/XI5he1UOYaAeW+P1+Xx+oIH1pVuauhVr2yEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G0eeodaVazJctTqb2mb2sjJhzPqn26TIaIO5Z92/b8/xHCO45JZK3vMlbVrXMe9GD
	 pIROigmbra4lhm7zWKSX+2MZh46Mj3HQLaed+mAdgblR/qZ8NA0wNqSKLVCJ5zrcSY
	 Nu10CCHIGfXVt3wHXD4b4WjWw3SiwUyoLoQCkjne+nxvMBp+R05WJO2axN4avnLzwv
	 KCIhpRwVm2YJvuO7BKRaNqGOBkTgg/Wk+nv73jG/otNBBDnIFud+loimmfYenUpwfD
	 u5ejIwkbI122C21NLPyzsrB79OUgjgWPg5615boLKITpDuJ7TgCxAttXrPNrqYbwSD
	 Yjk/q/dSallCQ==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 06 May 2026 11:26:51 -0400
Subject: [PATCH 2/2] svcrdma: Defer send context release to
 xpo_release_ctxt
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-svcrdma-next-v1-2-915fce8c4fbb@oracle.com>
References: <20260506-svcrdma-next-v1-0-915fce8c4fbb@oracle.com>
In-Reply-To: <20260506-svcrdma-next-v1-0-915fce8c4fbb@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=13103;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=jXBuMucerlR+evpY6FEDt+x7U7QGwSSK/xl1HglS28Q=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp+13MpsAIFeh28d2wIRHfPQLquy6+/jVkJj0S6
 65ATMd6llSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaftdzAAKCRAzarMzb2Z/
 l3LyD/0bMB3WrwcUgca4NcgeyLW1XajmtNgDhjU76neI+vfz0QJd3JQm8dsaeUthsomV3pYMp9X
 3LM6uqhLUW7bth4wkHAfOutCl7t9NMLMvJ7d8gAfOBTOvlLYHsrM2+Cnwe111fkK1dS0g5d5Amb
 xCQp8SqLbd1ois0uc9+eR1WrSGy5WTmWAsaqdp/yHpljCwEFIjD18q20GyNTmiFDqlb51j3woWJ
 h3hevB+Jd3hGXNymvS/pgi+wJR5SC9uZqWbN2Es41+H5Ds2jr4KtbPh9SKpwpSYHNKdPjg9khRm
 Nbo3x7uVtNk9LooiRPcgj31oIzngoQU+2jLnPFFRFHn669el6UUb5+fJEMab38VPcBq9G2oQ6Mw
 XoPNEyHMpGBRe1npFx81lreDF7xxZl0GB+GpMuMT/5N48ji2SN+R72Gm5sf3jgwASNv6KAckJsm
 F3Skp8EW+P2TQsQLiRSlL0KAdM+E4crOmMGe6PalfrEMuNnVSusaJOE2nQtQFbbeOZXeRSca6YP
 3fdjDae5dVYuaiRR3UP69lJp5JbAX847dGVfAZxMtrIKGBOMG5mCFecuR5evQxZTZrjPui/X7Xn
 OFOCXD6fs2DG3zLmfv7qrQgCGwA/JcLk/FiFSILo2I8q5QcN5ZxENvlMQv2TwxQLCudB+CuDL9p
 4DfHQtzXSmJhaFQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 039C04DD6D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21413-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

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

A self-enqueue backstops drain on a quiescing transport.
When svc_rdma_send_ctxt_put() observes that its llist_add()
transitions sc_send_release_list from empty to non-empty,
it sets XPT_DATA and calls svc_xprt_enqueue() so that
svc_xprt_ready() schedules an nfsd thread. The thread
enters svc_rdma_recvfrom(), finds no pending receive,
clears XPT_DATA, and returns 0; svc_xprt_release() then
runs xpo_release_ctxt and drains the list. Under steady
load the foreground drain keeps the list non-empty between
adds and no enqueue fires; only the trailing edge of a
burst pays for a wakeup. Without this path, a Send
completion arriving after the last xpo_release_ctxt on an
idle connection would leave the send_ctxt's DMA mappings
and reply pages pinned until the next RPC, send-context
exhaustion, or transport close.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  5 +-
 net/sunrpc/xprtrdma/svc_rdma.c           | 18 +------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  9 ++++
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 91 +++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  3 +-
 5 files changed, 82 insertions(+), 44 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 14eb9d52742e..4ba39f07371d 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -66,7 +66,6 @@ extern unsigned int svcrdma_ord;
 extern unsigned int svcrdma_max_requests;
 extern unsigned int svcrdma_max_bc_requests;
 extern unsigned int svcrdma_max_req_size;
-extern struct workqueue_struct *svcrdma_wq;
 
 extern struct percpu_counter svcrdma_stat_read;
 extern struct percpu_counter svcrdma_stat_recv;
@@ -117,6 +116,8 @@ struct svcxprt_rdma {
 
 	struct llist_head    sc_recv_ctxts;
 
+	struct llist_head    sc_send_release_list;
+
 	atomic_t	     sc_completion_ids;
 };
 /* sc_flags */
@@ -235,7 +236,6 @@ struct svc_rdma_write_info {
 struct svc_rdma_send_ctxt {
 	struct llist_node	sc_node;
 	struct rpc_rdma_cid	sc_cid;
-	struct work_struct	sc_work;
 
 	struct svcxprt_rdma	*sc_rdma;
 	struct ib_send_wr	sc_send_wr;
@@ -299,6 +299,7 @@ extern int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 
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
index f8a0638eb095..19503a12d0a2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -242,6 +242,10 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
  * Ensure that the recv_ctxt is released whether or not a Reply
  * was sent. For example, the client could close the connection,
  * or svc_process could drop an RPC, before the Reply is sent.
+ *
+ * Also drain any send_ctxts queued for deferred release so that
+ * DMA unmap and page release run in nfsd thread context between
+ * RPCs rather than on the Send completion path.
  */
 void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
 {
@@ -251,6 +255,8 @@ void svc_rdma_release_ctxt(struct svc_xprt *xprt, void *vctxt)
 
 	if (ctxt)
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
+
+	svc_rdma_send_ctxts_drain(rdma);
 }
 
 static bool svc_rdma_refresh_recvs(struct svcxprt_rdma *rdma,
@@ -384,6 +390,9 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
  * svc_rdma_flush_recv_queues - Drain pending Receive work
  * @rdma: svcxprt_rdma being shut down
  *
+ * Caller must guarantee that @rdma's Send and Recv Completion
+ * Queues are empty (e.g., via ib_drain_qp()), so that no completion
+ * handlers can still produce work on the queues being drained.
  */
 void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 8b3f0c8c14b2..eceefd21bec8 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -79,21 +79,21 @@
  * The ownership of all of the Reply's pages are transferred into that
  * ctxt, the Send WR is posted, and sendto returns.
  *
- * The svc_rdma_send_ctxt is presented when the Send WR completes. The
- * Send completion handler finally releases the Reply's pages.
- *
- * This mechanism also assumes that completions on the transport's Send
- * Completion Queue do not run in parallel. Otherwise a Write completion
- * and Send completion running at the same time could release pages that
- * are still DMA-mapped.
+ * The svc_rdma_send_ctxt is presented when the Send WR completes.
+ * The Send completion handler queues the send_ctxt onto the
+ * per-transport sc_send_release_list (a lock-free llist). The
+ * nfsd thread drains sc_send_release_list in xpo_release_ctxt
+ * between RPCs, DMA-unmapping SGEs, releasing chunk I/O
+ * resources and pages, and returning send_ctxts to the free
+ * list in a batch.
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
@@ -226,14 +226,25 @@ struct svc_rdma_send_ctxt *svc_rdma_send_ctxt_get(struct svcxprt_rdma *rdma)
 	return ctxt;
 
 out_empty:
+	svc_rdma_send_ctxts_drain(rdma);
+
+	spin_lock(&rdma->sc_send_lock);
+	node = llist_del_first(&rdma->sc_send_ctxts);
+	spin_unlock(&rdma->sc_send_lock);
+	if (node) {
+		ctxt = llist_entry(node, struct svc_rdma_send_ctxt, sc_node);
+		goto out;
+	}
+
 	ctxt = svc_rdma_send_ctxt_alloc(rdma);
 	if (!ctxt)
 		return NULL;
 	goto out;
 }
 
-static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
-				       struct svc_rdma_send_ctxt *ctxt)
+/* Release chunk I/O resources and DMA-unmap SGEs. */
+static void svc_rdma_send_ctxt_unmap(struct svcxprt_rdma *rdma,
+				     struct svc_rdma_send_ctxt *ctxt)
 {
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
@@ -241,9 +252,6 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	svc_rdma_write_chunk_release(rdma, ctxt);
 	svc_rdma_reply_chunk_release(rdma, ctxt);
 
-	if (ctxt->sc_page_count)
-		release_pages(ctxt->sc_pages, ctxt->sc_page_count);
-
 	/* The first SGE contains the transport header, which
 	 * remains mapped until @ctxt is destroyed.
 	 */
@@ -256,30 +264,56 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
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
+ * Queues @ctxt onto sc_send_release_list. DMA unmap and
+ * page release run later in svc_rdma_send_ctxts_drain(),
+ * typically from xpo_release_ctxt.
+ *
+ * On the empty-to-non-empty transition, set XPT_DATA and
+ * enqueue the transport. Without this self-trigger, a Send
+ * completion arriving after the last xpo_release_ctxt on an
+ * idle connection would leave the send_ctxt's DMA mappings
+ * and reply pages pinned until another drain occurred.
  */
 void svc_rdma_send_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_send_ctxt *ctxt)
 {
-	INIT_WORK(&ctxt->sc_work, svc_rdma_send_ctxt_put_async);
-	queue_work(svcrdma_wq, &ctxt->sc_work);
+	if (llist_add(&ctxt->sc_node, &rdma->sc_send_release_list)) {
+		set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
+		svc_xprt_enqueue(&rdma->sc_xprt);
+	}
 }
 
 /**
@@ -367,6 +401,15 @@ int svc_rdma_sq_wait(struct svcxprt_rdma *rdma,
 	atomic_inc(&rdma->sc_sq_ticket_tail);
 	wake_up(&rdma->sc_sq_ticket_wait);
 	trace_svcrdma_sq_retry(rdma, cid);
+
+	/*
+	 * While this thread sat on sc_send_wait or sc_sq_ticket_wait,
+	 * Send completions that tried to enqueue this transport for a
+	 * release-list drain were rejected: svc_rdma_has_wspace returns
+	 * 0 while either waitqueue is active, and svc_xprt_ready
+	 * rejects the enqueue. Drain the release list now.
+	 */
+	svc_rdma_send_ctxts_drain(rdma);
 	return 0;
 
 out_close:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f18bc60d9f4f..f99cd6177504 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -178,6 +178,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
+	init_llist_head(&cma_xprt->sc_send_release_list);
 	init_waitqueue_head(&cma_xprt->sc_send_wait);
 	init_waitqueue_head(&cma_xprt->sc_sq_ticket_wait);
 
@@ -614,7 +615,7 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
-	flush_workqueue(svcrdma_wq);
+	svc_rdma_send_ctxts_drain(rdma);
 
 	svc_rdma_flush_recv_queues(rdma);
 

-- 
2.53.0


