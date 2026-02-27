Return-Path: <linux-nfs+bounces-19401-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAbeEE6moWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19401-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:30 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3CC1B8805
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FB9C30DF846
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A484029DB65;
	Fri, 27 Feb 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJ4I8Yhh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C7D29898B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201031; cv=none; b=f7WkS4Id24klpGmDxl+QFydY7Yhku/xWpgcKHf+qZzhXMV7ngqKT6BKfPVbcYdjqQDmwFlACy0Fa/YANEaAGPWqFgVdbhNayTp/PS/5yRAsLOb9sp8aFlSlqzFIpsl2afFhe0JAsPxI5mF6JALt8tyWb7/mWOi+9h7uJ5TEIdJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201031; c=relaxed/simple;
	bh=Epuuid4tv9lZaeUbhMxuSwwmITLsNVKUYVD15G4L48U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAUHAvYogrO1J9DcNFvj1/78KnFuaBg1h+4Fmt6V262N1w4o3iQxafAGoPelO6zz0Vb6Y3fbGISTxG+loDWyd0vZRo9HsYJ2NShMFTXJ77+yLcIjjXxkvmcKlHKoE92Y9tzeBkH6bQxasQQdbGVFIjjKU4eV65ESzPBiEaUQZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJ4I8Yhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B108C19425;
	Fri, 27 Feb 2026 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201031;
	bh=Epuuid4tv9lZaeUbhMxuSwwmITLsNVKUYVD15G4L48U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eJ4I8YhhagkmCU540uiK867ykRhYBHUr8oJghgK0Dt7cyZq2lQayhjm1RsCO4PoZ5
	 uCBWhVOIWvR0FXAkhoKdvvh95unptIPgON9EmdJUW7Crvwml9bKqBgJ8RlguYkfeVM
	 +O/5pVYVh/Z+lhvUWsHP7kWGG5fYe1TuGExX70hpcHCkxAUSMPjwi3zCmH4n9a+67l
	 FJ6Mg0WFV56fAJZNFd32+sQOA8k9+yUkPsMyO7JKI9iN1ibrO5e3z4Hj0uuKYUHPbd
	 vyD7JlA/31aANhEjRTIpxMUcrOaV9Gqgbc+XNJCUCZFA1SaMJJJlykyaxgNbyYytLN
	 2aOMmBksIzrgQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 04/18] svcrdma: Add Write chunk WRs to the RPC's Send WR chain
Date: Fri, 27 Feb 2026 09:03:31 -0500
Message-ID: <20260227140345.40488-5-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19401-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: ED3CC1B8805
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Previously, Write chunk RDMA Writes were posted via a separate
ib_post_send() call with their own completion handler. Each Write
chunk incurred a doorbell and generated a completion event.

Link Write chunk WRs onto the RPC Reply's Send WR chain so that a
single ib_post_send() call posts both the RDMA Writes and the Send
WR. A single completion event signals that all operations have
finished. This reduces both doorbell rate and completion rate, as
well as eliminating the latency of a round-trip between the Write
chunk completion and the subsequent Send WR posting.

The lifecycle of Write chunk resources changes: previously, the
svc_rdma_write_done() completion handler released Write chunk
resources when RDMA Writes completed. With WR chaining, resources
remain live until the Send completion. A new sc_write_info_list
tracks Write chunk metadata attached to each Send context, and
svc_rdma_write_chunk_release() frees these resources when the
Send context is released.

The svc_rdma_write_done() handler now handles only error cases.
On success it returns immediately since the Send completion handles
resource release. On failure (WR flush), it closes the connection
to signal to the client that the RPC Reply is incomplete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h       | 13 +++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c     | 94 ++++++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 10 ++-
 3 files changed, 91 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 658b8498177e..df6e08aaad57 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -216,6 +216,7 @@ struct svc_rdma_recv_ctxt {
  */
 struct svc_rdma_write_info {
 	struct svcxprt_rdma	*wi_rdma;
+	struct list_head	wi_list;
 
 	const struct svc_rdma_chunk	*wi_chunk;
 
@@ -244,7 +245,10 @@ struct svc_rdma_send_ctxt {
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
+
+	struct list_head	sc_write_info_list;
 	struct svc_rdma_write_info sc_reply_info;
+
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
@@ -277,11 +281,14 @@ extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 				struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir);
+extern void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
+					 struct svc_rdma_send_ctxt *ctxt);
 extern void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
 					 struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
-				    const struct svc_rdma_recv_ctxt *rctxt,
-				    const struct xdr_buf *xdr);
+extern int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
+				       const struct svc_rdma_recv_ctxt *rctxt,
+				       struct svc_rdma_send_ctxt *sctxt,
+				       const struct xdr_buf *xdr);
 extern int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 					const struct svc_rdma_pcl *write_pcl,
 					const struct svc_rdma_pcl *reply_pcl,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 6626f18de55e..c5d65164eae2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -251,6 +251,28 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 	queue_work(svcrdma_wq, &info->wi_work);
 }
 
+/**
+ * svc_rdma_write_chunk_release - Release Write chunk I/O resources
+ * @rdma: controlling transport
+ * @ctxt: Send context that is being released
+ *
+ * Write chunk resources remain live until Send completion because
+ * Write WRs are chained to the Send WR. This function releases all
+ * write_info structures accumulated on @ctxt->sc_write_info_list.
+ */
+void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
+				  struct svc_rdma_send_ctxt *ctxt)
+{
+	struct svc_rdma_write_info *info;
+
+	while (!list_empty(&ctxt->sc_write_info_list)) {
+		info = list_first_entry(&ctxt->sc_write_info_list,
+					struct svc_rdma_write_info, wi_list);
+		list_del(&info->wi_list);
+		svc_rdma_write_info_free(info);
+	}
+}
+
 /**
  * svc_rdma_reply_chunk_release - Release Reply chunk I/O resources
  * @rdma: controlling transport
@@ -307,13 +329,11 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svc_rdma_write_info *info =
-			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
 		trace_svcrdma_wc_write(&cc->cc_cid);
-		break;
+		return;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_write_flush(wc, &cc->cc_cid);
 		break;
@@ -321,12 +341,11 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_write_err(wc, &cc->cc_cid);
 	}
 
-	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
-
-	if (unlikely(wc->status != IB_WC_SUCCESS))
-		svc_xprt_deferred_close(&rdma->sc_xprt);
-
-	svc_rdma_write_info_free(info);
+	/* The RDMA Write has flushed, so the client won't get
+	 * some of the outgoing RPC message. Signal the loss
+	 * to the client by closing the connection.
+	 */
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /**
@@ -600,13 +619,27 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 	return xdr->len;
 }
 
-static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     const struct svc_rdma_chunk *chunk,
-				     const struct xdr_buf *xdr)
+/*
+ * svc_rdma_prepare_write_chunk - Link Write WRs for @chunk onto @sctxt's chain
+ *
+ * Write WRs are prepended to the Send WR chain so that a single
+ * ib_post_send() posts both RDMA Writes and the final Send. Only
+ * the first WR in each chunk gets a CQE for error detection;
+ * subsequent WRs complete without individual completion events.
+ * The Send WR's signaled completion indicates all chained
+ * operations have finished.
+ */
+static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
+					struct svc_rdma_send_ctxt *sctxt,
+					const struct svc_rdma_chunk *chunk,
+					const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
+	struct ib_send_wr *first_wr;
 	struct xdr_buf payload;
+	struct list_head *pos;
+	struct ib_cqe *cqe;
 	int ret;
 
 	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
@@ -622,10 +655,25 @@ static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 	if (ret != payload.len)
 		goto out_err;
 
-	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
-	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
-	if (ret < 0)
+	ret = -EINVAL;
+	if (unlikely(sctxt->sc_sqecount + cc->cc_sqecount > rdma->sc_sq_depth))
 		goto out_err;
+
+	first_wr = sctxt->sc_wr_chain;
+	cqe = &cc->cc_cqe;
+	list_for_each(pos, &cc->cc_rwctxts) {
+		struct svc_rdma_rw_ctxt *rwc;
+
+		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
+		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
+					   rdma->sc_port_num, cqe, first_wr);
+		cqe = NULL;
+	}
+	sctxt->sc_wr_chain = first_wr;
+	sctxt->sc_sqecount += cc->cc_sqecount;
+	list_add(&info->wi_list, &sctxt->sc_write_info_list);
+
+	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
 	return 0;
 
 out_err:
@@ -634,17 +682,19 @@ static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_send_write_list - Send all chunks on the Write list
+ * svc_rdma_prepare_write_list - Construct WR chain for sending Write list
  * @rdma: controlling RDMA transport
  * @rctxt: Write list provisioned by the client
+ * @sctxt: Send WR resources
  * @xdr: xdr_buf containing an RPC Reply message
  *
- * Returns zero on success, or a negative errno if one or more
- * Write chunks could not be sent.
+ * Returns zero on success, or a negative errno if WR chain
+ * construction fails for one or more Write chunks.
  */
-int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
-			     const struct svc_rdma_recv_ctxt *rctxt,
-			     const struct xdr_buf *xdr)
+int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
+				const struct svc_rdma_recv_ctxt *rctxt,
+				struct svc_rdma_send_ctxt *sctxt,
+				const struct xdr_buf *xdr)
 {
 	struct svc_rdma_chunk *chunk;
 	int ret;
@@ -652,7 +702,7 @@ int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
 	pcl_for_each_chunk(chunk, &rctxt->rc_write_pcl) {
 		if (!chunk->ch_payload_length)
 			break;
-		ret = svc_rdma_send_write_chunk(rdma, chunk, xdr);
+		ret = svc_rdma_prepare_write_chunk(rdma, sctxt, chunk, xdr);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 4fff03b96b84..263da6f76267 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -150,6 +150,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
+	INIT_LIST_HEAD(&ctxt->sc_write_info_list);
 	ctxt->sc_xprt_buf = buffer;
 	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
 		     rdma->sc_max_req_size);
@@ -237,6 +238,7 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
+	svc_rdma_write_chunk_release(rdma, ctxt);
 	svc_rdma_reply_chunk_release(rdma, ctxt);
 
 	if (ctxt->sc_page_count)
@@ -1056,6 +1058,12 @@ void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
+
+	/* Ensure only the error message is posted, not any previously
+	 * prepared Write chunk WRs.
+	 */
+	sctxt->sc_wr_chain = &sctxt->sc_send_wr;
+	sctxt->sc_sqecount = 1;
 	if (svc_rdma_post_send(rdma, sctxt))
 		goto put_ctxt;
 	return;
@@ -1103,7 +1111,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_send_write_list(rdma, rctxt, &rqstp->rq_res);
+	ret = svc_rdma_prepare_write_list(rdma, rctxt, sctxt, &rqstp->rq_res);
 	if (ret < 0)
 		goto put_ctxt;
 
-- 
2.53.0


