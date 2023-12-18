Return-Path: <linux-nfs+bounces-702-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB92817D49
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 23:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C2461F23077
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Dec 2023 22:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFFD74E33;
	Mon, 18 Dec 2023 22:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl+Jcq54"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00EA74E25;
	Mon, 18 Dec 2023 22:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27A7C433C7;
	Mon, 18 Dec 2023 22:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938722;
	bh=burEwcbXLcYgXuGR/fX2hub2bWTWY41UK8kGHPY0GdI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=jl+Jcq54NRHTnoDvYi3U36dBQBa9fgbQBRi5AamuePNewzmb1+ZnzBn/8+tMMwWsu
	 1f3os0ylOkMIjLLjauOCnXWcA3NWO8I5fI3MceyLs4AuwOLlw5Useb542HINJZb7DY
	 bWRg1vm3ArM7kxR0OIZ7dZn//IaJUpFF6VB85BMkjy7Gas3Qxx14x25xB2MHEW1fZn
	 5aCC92YMJg6M3QF84fo1WvLVdDsJBM5LVJp1wI4cHuBGs8cWIwhHJC+YiDr5kuUNuH
	 BnT9rKuIvFid1w4SCd6J39+SU5bxad3WuIAJ81LzX1jn/XwSDqI+8DjPqlX1Wu3OAq
	 MONK92StTqKmg==
Subject: [PATCH v1 3/4] svcrdma: Copy construction of svc_rqst::rq_arg to
 rdma_read_complete()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: tom@talpey.com
Date: Mon, 18 Dec 2023 17:32:01 -0500
Message-ID: 
 <170293872099.4604.16258519407111601722.stgit@bazille.1015granger.net>
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

Once a set of RDMA Reads are complete, the Read completion handler
will poke the transport to trigger a second call to
svc_rdma_recvfrom(). recvfrom() will then merge the RDMA Read
payloads with the previously received RPC header to form a completed
RPC Call message.

The new code is copied from the svc_rdma_process_read_list() path.
A subsequent patch will make use of this code and remove the code
that this was copied from (svc_rdma_rw.c).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h          |    1 
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   93 +++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 9a3fc6eb09a8..110c1475c527 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -2112,6 +2112,7 @@ TRACE_EVENT(svcrdma_wc_read,
 
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_read_flush);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_read_err);
+DEFINE_SIMPLE_CID_EVENT(svcrdma_read_finished);
 
 DEFINE_SIMPLE_CID_EVENT(svcrdma_wc_write);
 DEFINE_SEND_FLUSH_EVENT(svcrdma_wc_write_flush);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 2de947183a7a..034bdd02f925 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -767,10 +767,86 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
 	return true;
 }
 
+/* Finish constructing the RPC Call message in rqstp::rq_arg.
+ *
+ * The incoming RPC/RDMA message is an RDMA_MSG type message
+ * with a single Read chunk (only the upper layer data payload
+ * was conveyed via RDMA Read).
+ */
+static void svc_rdma_read_complete_one(struct svc_rqst *rqstp,
+				       struct svc_rdma_recv_ctxt *ctxt)
+{
+	struct svc_rdma_chunk *chunk = pcl_first_chunk(&ctxt->rc_read_pcl);
+	struct xdr_buf *buf = &rqstp->rq_arg;
+	unsigned int length;
+
+	/* Split the Receive buffer between the head and tail
+	 * buffers at Read chunk's position. XDR roundup of the
+	 * chunk is not included in either the pagelist or in
+	 * the tail.
+	 */
+	buf->tail[0].iov_base = buf->head[0].iov_base + chunk->ch_position;
+	buf->tail[0].iov_len = buf->head[0].iov_len - chunk->ch_position;
+	buf->head[0].iov_len = chunk->ch_position;
+
+	/* Read chunk may need XDR roundup (see RFC 8166, s. 3.4.5.2).
+	 *
+	 * If the client already rounded up the chunk length, the
+	 * length does not change. Otherwise, the length of the page
+	 * list is increased to include XDR round-up.
+	 *
+	 * Currently these chunks always start at page offset 0,
+	 * thus the rounded-up length never crosses a page boundary.
+	 */
+	buf->pages = &rqstp->rq_pages[0];
+	length = xdr_align_size(chunk->ch_length);
+	buf->page_len = length;
+	buf->len += length;
+	buf->buflen += length;
+}
+
+/* Finish constructing the RPC Call message in rqstp::rq_arg.
+ *
+ * The incoming RPC/RDMA message is an RDMA_MSG type message
+ * with payload in multiple Read chunks and no PZRC.
+ */
+static void svc_rdma_read_complete_multiple(struct svc_rqst *rqstp,
+					    struct svc_rdma_recv_ctxt *ctxt)
+{
+	struct xdr_buf *buf = &rqstp->rq_arg;
+
+	buf->len += ctxt->rc_readbytes;
+	buf->buflen += ctxt->rc_readbytes;
+
+	buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
+	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, ctxt->rc_readbytes);
+	buf->pages = &rqstp->rq_pages[1];
+	buf->page_len = ctxt->rc_readbytes - buf->head[0].iov_len;
+}
+
+/* Finish constructing the RPC Call message in rqstp::rq_arg.
+ *
+ * The incoming RPC/RDMA message is an RDMA_NOMSG type message
+ * (the RPC message body was conveyed via RDMA Read).
+ */
+static void svc_rdma_read_complete_pzrc(struct svc_rqst *rqstp,
+					struct svc_rdma_recv_ctxt *ctxt)
+{
+	struct xdr_buf *buf = &rqstp->rq_arg;
+
+	buf->len += ctxt->rc_readbytes;
+	buf->buflen += ctxt->rc_readbytes;
+
+	buf->head[0].iov_base = page_address(rqstp->rq_pages[0]);
+	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, ctxt->rc_readbytes);
+	buf->pages = &rqstp->rq_pages[1];
+	buf->page_len = ctxt->rc_readbytes - buf->head[0].iov_len;
+}
+
 static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
 					    struct svc_rdma_recv_ctxt *ctxt)
 {
-	int i;
+	unsigned int i;
 
 	/* Transfer the Read chunk pages into @rqstp.rq_pages, replacing
 	 * the rq_pages that were already allocated for this rqstp.
@@ -789,6 +865,21 @@ static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
 	 * pages in ctxt::rc_pages a second time.
 	 */
 	ctxt->rc_page_count = 0;
+
+	/* Finish constructing the RPC Call message. The exact
+	 * procedure for that depends on what kind of RPC/RDMA
+	 * chunks were provided by the client.
+	 */
+	if (pcl_is_empty(&ctxt->rc_call_pcl)) {
+		if (ctxt->rc_read_pcl.cl_count == 1)
+			svc_rdma_read_complete_one(rqstp, ctxt);
+		else
+			svc_rdma_read_complete_multiple(rqstp, ctxt);
+	} else {
+		svc_rdma_read_complete_pzrc(rqstp, ctxt);
+	}
+
+	trace_svcrdma_read_finished(&ctxt->rc_cid);
 }
 
 /**



