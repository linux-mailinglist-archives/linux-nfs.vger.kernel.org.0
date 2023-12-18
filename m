Return-Path: <linux-nfs+bounces-703-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A00817D4C
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 23:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0510B235FB
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADFA76081;
	Mon, 18 Dec 2023 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwWC7i0+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E28476080;
	Mon, 18 Dec 2023 22:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613C1C433C7;
	Mon, 18 Dec 2023 22:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938728;
	bh=kmjPRrKt+OLy6oEhR8cZyITBuhz7Wbbxj6JUMpJygf4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ZwWC7i0+WvteXG3QvJLN80wmlzMQC6x/ve8p9yAUHgFsTEW+E+96Xm5Z855s33c03
	 /8RowHprq1tJVT9w6WcYbldy7QQRIKh+0OeswTjXj1WoKVCIykCNTDaNshK88HPVuC
	 MUHpKQGjDjCMs3KF16l4sSb89DSqpfyFNEYWkXY1pwSoRel/c+NeIlhfotVwptzUYB
	 dC67rb8nUXM77JgpNmW8gq1SH0dPDB1Rx0FXEFJ7P/3KLDI9mJu+QhM5JVVMpJLU2M
	 8lfeIWQ/oCOF9IBSNlzG6G9puQUbZnWMhipftjoH3ukKDkr5mq6Fli78LcTB+cd1Ae
	 9Wy/ieUU1V5ZQ==
Subject: [PATCH v1 4/4] svcrdma: Implement multi-stage Read completion again
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 18 Dec 2023 17:32:07 -0500
Message-ID: 
 <170293872745.4604.13501370140544523227.stgit@bazille.1015granger.net>
In-Reply-To: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
References: 
 <170293795877.4604.12721267378032407419.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Having an nfsd thread waiting for an RDMA Read completion is
problematic if the Read responder (ie, the client) stops responding.
We need to go back to handling RDMA Reads by getting the svc scheduler
to call svc_rdma_recvfrom() a second time to finish building an RPC
message after a Read completion.

This is the final patch, and makes several changes that have to
happen concurrently:

1. svc_rdma_process_read_list no longer waits for a completion, but
   simply builds and posts the Read WRs.

2. svc_rdma_read_done() now queues a completed Read on
   sc_read_complete_q for later processing rather than calling
   complete().

3. The completed RPC message is no longer built in the
   svc_rdma_process_read_list() path. Finishing the message is now
   done in svc_rdma_recvfrom() when it notices work on the
   sc_read_complete_q. The "finish building this RPC message" code
   is removed from the svc_rdma_process_read_list() path.

This arrangement avoids the need for an nfsd thread to wait for an
RDMA Read non-interruptibly without a timeout. It's basically the
same code structure that Tom Tucker used for Read chunks along with
some clean-up and modernization.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |    6 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   36 +++++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |  151 +++++++++++--------------------
 3 files changed, 80 insertions(+), 113 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index c98d29e51b9c..e7595ae62fe2 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -170,8 +170,6 @@ struct svc_rdma_chunk_ctxt {
 	struct list_head	cc_rwctxts;
 	ktime_t			cc_posttime;
 	int			cc_sqecount;
-	enum ib_wc_status	cc_status;
-	struct completion	cc_done;
 };
 
 struct svc_rdma_recv_ctxt {
@@ -191,6 +189,7 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_pageoff;
 	unsigned int		rc_curpage;
 	unsigned int		rc_readbytes;
+	struct xdr_buf		rc_saved_arg;
 	struct svc_rdma_chunk_ctxt	rc_cc;
 
 	struct svc_rdma_pcl	rc_call_pcl;
@@ -240,6 +239,9 @@ extern int svc_rdma_recvfrom(struct svc_rqst *);
 extern void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma);
 extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 			     struct svc_rdma_chunk_ctxt *cc);
+extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
+				struct svc_rdma_chunk_ctxt *cc,
+				enum dma_data_direction dir);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_chunk *chunk,
 				     const struct xdr_buf *xdr);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 034bdd02f925..d72953f29258 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -214,6 +214,8 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_recv_ctxt *ctxt)
 {
+	svc_rdma_cc_release(rdma, &ctxt->rc_cc, DMA_FROM_DEVICE);
+
 	/* @rc_page_count is normally zero here, but error flows
 	 * can leave pages in @rc_pages.
 	 */
@@ -870,6 +872,7 @@ static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
 	 * procedure for that depends on what kind of RPC/RDMA
 	 * chunks were provided by the client.
 	 */
+	rqstp->rq_arg = ctxt->rc_saved_arg;
 	if (pcl_is_empty(&ctxt->rc_call_pcl)) {
 		if (ctxt->rc_read_pcl.cl_count == 1)
 			svc_rdma_read_complete_one(rqstp, ctxt);
@@ -930,7 +933,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
 	if (ctxt) {
 		list_del(&ctxt->rc_list);
-		spin_unlock_bh(&rdma_xprt->sc_rq_dto_lock);
+		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+		svc_xprt_received(xprt);
 		svc_rdma_read_complete(rqstp, ctxt);
 		goto complete;
 	}
@@ -965,11 +969,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_rdma_get_inv_rkey(rdma_xprt, ctxt);
 
 	if (!pcl_is_empty(&ctxt->rc_read_pcl) ||
-	    !pcl_is_empty(&ctxt->rc_call_pcl)) {
-		ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
-		if (ret < 0)
-			goto out_readfail;
-	}
+	    !pcl_is_empty(&ctxt->rc_call_pcl))
+		goto out_readlist;
 
 complete:
 	rqstp->rq_xprt_ctxt = ctxt;
@@ -983,12 +984,23 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
 	return 0;
 
-out_readfail:
-	if (ret == -EINVAL)
-		svc_rdma_send_error(rdma_xprt, ctxt, ret);
-	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
-	svc_xprt_deferred_close(xprt);
-	return -ENOTCONN;
+out_readlist:
+	/* This @rqstp is about to be recycled. Save the work
+	 * already done constructing the Call message in rq_arg
+	 * so it can be restored when the RDMA Reads have
+	 * completed.
+	 */
+	ctxt->rc_saved_arg = rqstp->rq_arg;
+
+	ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
+	if (ret < 0) {
+		if (ret == -EINVAL)
+			svc_rdma_send_error(rdma_xprt, ctxt, ret);
+		svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
+		svc_xprt_deferred_close(xprt);
+		return ret;
+	}
+	return 0;
 
 out_backchannel:
 	svc_rdma_handle_bc_reply(rqstp, ctxt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 28a34718dee5..c00fcce61d1e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -163,14 +163,15 @@ void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 	cc->cc_sqecount = 0;
 }
 
-/*
- * The consumed rw_ctx's are cleaned and placed on a local llist so
- * that only one atomic llist operation is needed to put them all
- * back on the free list.
+/**
+ * svc_rdma_cc_release - Release resources held by a svc_rdma_chunk_ctxt
+ * @rdma: controlling transport instance
+ * @cc: svc_rdma_chunk_ctxt to be released
+ * @dir: DMA direction
  */
-static void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
-				struct svc_rdma_chunk_ctxt *cc,
-				enum dma_data_direction dir)
+void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
+			 struct svc_rdma_chunk_ctxt *cc,
+			 enum dma_data_direction dir)
 {
 	struct llist_node *first, *last;
 	struct svc_rdma_rw_ctxt *ctxt;
@@ -300,12 +301,21 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
+
+	ctxt = container_of(cc, struct svc_rdma_recv_ctxt, rc_cc);
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
-		ctxt = container_of(cc, struct svc_rdma_recv_ctxt, rc_cc);
 		trace_svcrdma_wc_read(wc, &cc->cc_cid, ctxt->rc_readbytes,
 				      cc->cc_posttime);
-		break;
+
+		spin_lock(&rdma->sc_rq_dto_lock);
+		list_add_tail(&ctxt->rc_list, &rdma->sc_read_complete_q);
+		/* the unlock pairs with the smp_rmb in svc_xprt_ready */
+		set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
+		spin_unlock(&rdma->sc_rq_dto_lock);
+		svc_xprt_enqueue(&rdma->sc_xprt);
+		return;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_read_flush(wc, &cc->cc_cid);
 		break;
@@ -313,10 +323,13 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_read_err(wc, &cc->cc_cid);
 	}
 
-	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
-	cc->cc_status = wc->status;
-	complete(&cc->cc_done);
-	return;
+	/* The RDMA Read has flushed, so the incoming RPC message
+	 * cannot be constructed and must be dropped. Signal the
+	 * loss to the client by closing the connection.
+	 */
+	svc_rdma_cc_release(rdma, cc, DMA_FROM_DEVICE);
+	svc_rdma_recv_ctxt_put(rdma, ctxt);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /*
@@ -823,7 +836,6 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 			      struct svc_rdma_recv_ctxt *head)
 {
 	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
-	struct xdr_buf *buf = &rqstp->rq_arg;
 	struct svc_rdma_chunk *chunk, *next;
 	unsigned int start, length;
 	int ret;
@@ -853,18 +865,7 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 
 	start += length;
 	length = head->rc_byte_len - start;
-	ret = svc_rdma_copy_inline_range(rqstp, head, start, length);
-	if (ret < 0)
-		return ret;
-
-	buf->len += head->rc_readbytes;
-	buf->buflen += head->rc_readbytes;
-
-	buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
-	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
-	buf->pages = &rqstp->rq_pages[1];
-	buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
-	return 0;
+	return svc_rdma_copy_inline_range(rqstp, head, start, length);
 }
 
 /**
@@ -888,42 +889,8 @@ svc_rdma_read_multiple_chunks(struct svc_rqst *rqstp,
 static int svc_rdma_read_data_item(struct svc_rqst *rqstp,
 				   struct svc_rdma_recv_ctxt *head)
 {
-	struct xdr_buf *buf = &rqstp->rq_arg;
-	struct svc_rdma_chunk *chunk;
-	unsigned int length;
-	int ret;
-
-	chunk = pcl_first_chunk(&head->rc_read_pcl);
-	ret = svc_rdma_build_read_chunk(rqstp, head, chunk);
-	if (ret < 0)
-		goto out;
-
-	/* Split the Receive buffer between the head and tail
-	 * buffers at Read chunk's position. XDR roundup of the
-	 * chunk is not included in either the pagelist or in
-	 * the tail.
-	 */
-	buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
-	buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
-	buf->head[0].iov_len = chunk->ch_position;
-
-	/* Read chunk may need XDR roundup (see RFC 8166, s. 3.4.5.2).
-	 *
-	 * If the client already rounded up the chunk length, the
-	 * length does not change. Otherwise, the length of the page
-	 * list is increased to include XDR round-up.
-	 *
-	 * Currently these chunks always start at page offset 0,
-	 * thus the rounded-up length never crosses a page boundary.
-	 */
-	buf->pages = &rqstp->rq_pages[0];
-	length = xdr_align_size(chunk->ch_length);
-	buf->page_len = length;
-	buf->len += length;
-	buf->buflen += length;
-
-out:
-	return ret;
+	return svc_rdma_build_read_chunk(rqstp, head,
+					 pcl_first_chunk(&head->rc_read_pcl));
 }
 
 /**
@@ -1051,23 +1018,28 @@ static int svc_rdma_read_call_chunk(struct svc_rqst *rqstp,
 static noinline int svc_rdma_read_special(struct svc_rqst *rqstp,
 					  struct svc_rdma_recv_ctxt *head)
 {
-	struct xdr_buf *buf = &rqstp->rq_arg;
-	int ret;
-
-	ret = svc_rdma_read_call_chunk(rqstp, head);
-	if (ret < 0)
-		goto out;
-
-	buf->len += head->rc_readbytes;
-	buf->buflen += head->rc_readbytes;
+	return svc_rdma_read_call_chunk(rqstp, head);
+}
 
-	buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
-	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, head->rc_readbytes);
-	buf->pages = &rqstp->rq_pages[1];
-	buf->page_len = head->rc_readbytes - buf->head[0].iov_len;
+/* Pages under I/O have been copied to head->rc_pages. Ensure that
+ * svc_xprt_release() does not put them when svc_rdma_recvfrom()
+ * returns. This has to be done after all Read WRs are constructed
+ * to properly handle a page that happens to be part of I/O on behalf
+ * of two different RDMA segments.
+ *
+ * Note: if the subsequent post_send fails, these pages have already
+ * been moved to head->rc_pages and thus will be cleaned up by
+ * svc_rdma_recv_ctxt_put().
+ */
+static void svc_rdma_clear_rqst_pages(struct svc_rqst *rqstp,
+				      struct svc_rdma_recv_ctxt *head)
+{
+	unsigned int i;
 
-out:
-	return ret;
+	for (i = 0; i < head->rc_page_count; i++) {
+		head->rc_pages[i] = rqstp->rq_pages[i];
+		rqstp->rq_pages[i] = NULL;
+	}
 }
 
 /**
@@ -1113,30 +1085,11 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 			ret = svc_rdma_read_multiple_chunks(rqstp, head);
 	} else
 		ret = svc_rdma_read_special(rqstp, head);
+	svc_rdma_clear_rqst_pages(rqstp, head);
 	if (ret < 0)
-		goto out_err;
+		return ret;
 
 	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
-	init_completion(&cc->cc_done);
 	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
-	if (ret < 0)
-		goto out_err;
-
-	ret = 1;
-	wait_for_completion(&cc->cc_done);
-	if (cc->cc_status != IB_WC_SUCCESS)
-		ret = -EIO;
-
-	/* rq_respages starts after the last arg page */
-	rqstp->rq_respages = &rqstp->rq_pages[head->rc_page_count];
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
-
-	/* Ensure svc_rdma_recv_ctxt_put() does not release pages
-	 * left in @rc_pages while I/O proceeds.
-	 */
-	head->rc_page_count = 0;
-
-out_err:
-	svc_rdma_cc_release(rdma, cc, DMA_FROM_DEVICE);
-	return ret;
+	return ret < 0 ? ret : 1;
 }



