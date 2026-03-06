Return-Path: <linux-nfs+bounces-19852-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMEAI+JNq2lYcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19852-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D01922826A
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98C94307F09D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FF23AEF37;
	Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c943i2hA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA96349B02;
	Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834196; cv=none; b=MiJevrtfkRhYLsyuGVWFenNNJDXUgsHa5rOTkWbJJwG7pdMG3wZC+8Nnm2NwunbBfgbwOpoctqbfwYTEK8xZzWtEtVAv0WU0nFK8SFwQ8zLNjFAZNpMqXdiSfp6PT3EfzNRA40Kji2Nzqcw5X6mjBCIs/CGwFGuUobv53uf7qPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834196; c=relaxed/simple;
	bh=/C3xnlzhMyW8uA6aHp0CX019nbsiNQVEcf/jyGgocWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEwWxsolNrVeuelKZVksW7AffWMBry6iNw98WuCmVLBbBb6sC031izseHrbtN96J3uh/eclcEX82B6YE9Na+trBra7u8xoU5M+cTx6D4Px4s+mAoS3DzySvR1Q7Bef0gGWHYEFYAh/mKK9Dhksb+bEiL7Z9xOmF0x6sbHdJZYgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c943i2hA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790CBC2BC86;
	Fri,  6 Mar 2026 21:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834195;
	bh=/C3xnlzhMyW8uA6aHp0CX019nbsiNQVEcf/jyGgocWo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c943i2hAl6AfQuvcNnEP2jLlAzAgxUOZ9gXzfTA7jTFE5XR1lMyUWEDg2io+vndG0
	 NSri72NZ2Q0oxWG0LVmadRvV572e/rWZbrqOOi4xh1ngTEn3EOG4xKZfkN0riLB7uU
	 ti7FkONjTPzUfAT3jrTZ9QVA1/nV6NooALt596G0jTLOKTg5GHsbfnUSvJYI30q5Aw
	 ndlFNYdQ3LNpAJIBXDcCz5bSYfsSE5Bw6HlLXLSoBWeQ1kQm3vnhup5zKzZRUnK8KF
	 /fzoPd9ivypkS+p5u04rIFoTQ+aj6SnXyreFbc6tfE3oXMItLqZy9vm1HbTjCTm3LA
	 vKv5/7vgpMEig==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 5/7] xprtrdma: Replace rpcrdma_mr_seg with xdr_buf cursor
Date: Fri,  6 Mar 2026 16:56:26 -0500
Message-ID: <20260306215620.3668-14-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21499; i=chuck.lever@oracle.com; h=from:subject; bh=AyUkgFJufd15vQd7NUjSeCI+5Q3FU3TQlmwAxcukqA0=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02N2Xt1s/Wfe14ko/8lt4Km+WicV9/ElxVcu tpWVyNybk6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjQAKCRAzarMzb2Z/ l0TdD/9Trj2zxLeurlT06WV2cXSYuphHHJ7grqnoArLyUG2+cug+qP4Fgvw0Og+SUT6ls8iq3a9 mhVcUy9+UVRhLSTM72QePlOLAuz9t+PmJwJ+gV3OvXiMR8R8t8nkOeGa8HYiu1JlxtSk82nMaEe 8eCexeW4RlXXCnjc+5ND2ttfpWvlP2TOaqyW52zvwC3348f6oThiYKi0O/0GrkZlJ+ZB5GiEF3O NF7w0z74Y6Jzzr8G42eeA3hUZS6TrX+cOhz2YadBlW9T877xlofG8mrIs5L8kTlE3FMz5iqPA2N pwQ3Ipxco/GCjAggZ0oz+tGG5YIFU1Epz1eeVDfUUNiGSbMvGdwAOKerFkQGEJwYR7S43XoS455 TOmmroFg4k/hlGQhkVQNZJXqhJ7m2KSDCBfr7hIRolJxR9ie4AJD3HM68Tl7nD7RVv3o9GSPkQt amjSj6jSg8B3TL5e0kCdt/hahvGrEMTTCaRpeTFhcpuf7nRDBQrX7zKgHDKSLCIhXhtVFd1ZjcP J/x4BB8gne/QDE/iJqUC9W4nTBHAE+CnLQYSig8cD3BjKu/8HXwcidpKlRebxDIbWCxfzdO5WN2 Pg5yi/VCmYKhBUnZLixttOKr+W9kKM6pn/TKE0HT4BB+Rg1+XYaAUN3wsCyb9PYAHYvfB+piLKH NvQQtMhTJUqHgFA=
 =
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D01922826A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19852-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.984];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The FRWR registration path converts data through three
representations: xdr_buf -> rpcrdma_mr_seg[] -> scatterlist[]
-> ib_map_mr_sg(). The rpcrdma_mr_seg intermediate is a relic
of when multiple registration strategies existed (FMR, physical,
FRWR). Only FRWR remains, so this indirection and the 6240-byte
rl_segments[260] array embedded in each rpcrdma_req serve no
purpose.

Introduce struct rpcrdma_xdr_cursor to track position within
an xdr_buf during iterative MR registration. Rewrite frwr_map to
populate scatterlist entries directly from the xdr_buf regions
(head kvec, page list, tail kvec). The boundary logic for
non-SG_GAPS devices is simpler because the xdr_buf structure
guarantees that page-region entries after the first start at
offset 0, and that head/tail kvecs are separate regions that
naturally break at MR boundaries.

Fix a pre-existing bug in rpcrdma_encode_write_list where the
write-pad statistics accumulator added mr->mr_length from the last
data MR rather than the write-pad MR. The refactored code uses
ep->re_write_pad_mr->mr_length.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |  28 +++---
 net/sunrpc/xprtrdma/frwr_ops.c  | 117 ++++++++++++++++++-----
 net/sunrpc/xprtrdma/rpc_rdma.c  | 163 +++++++++++---------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |  42 +++++---
 4 files changed, 193 insertions(+), 157 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index e6a72646c507..b79913048e1a 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -392,10 +392,10 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		const struct rpc_task *task,
 		unsigned int pos,
 		struct rpcrdma_mr *mr,
-		int nsegs
+		bool is_last
 	),
 
-	TP_ARGS(task, pos, mr, nsegs),
+	TP_ARGS(task, pos, mr, is_last),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
@@ -405,7 +405,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		__field(u32, handle)
 		__field(u32, length)
 		__field(u64, offset)
-		__field(int, nsegs)
+		__field(bool, is_last)
 	),
 
 	TP_fast_assign(
@@ -416,7 +416,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
 		__entry->offset = mr->mr_offset;
-		__entry->nsegs = nsegs;
+		__entry->is_last = is_last;
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -424,7 +424,7 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 		__entry->task_id, __entry->client_id,
 		__entry->pos, __entry->length,
 		(unsigned long long)__entry->offset, __entry->handle,
-		__entry->nents < __entry->nsegs ? "more" : "last"
+		__entry->is_last ? "last" : "more"
 	)
 );
 
@@ -434,18 +434,18 @@ DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 					const struct rpc_task *task,	\
 					unsigned int pos,		\
 					struct rpcrdma_mr *mr,		\
-					int nsegs			\
+					bool is_last			\
 				),					\
-				TP_ARGS(task, pos, mr, nsegs))
+				TP_ARGS(task, pos, mr, is_last))
 
 DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 	TP_PROTO(
 		const struct rpc_task *task,
 		struct rpcrdma_mr *mr,
-		int nsegs
+		bool is_last
 	),
 
-	TP_ARGS(task, mr, nsegs),
+	TP_ARGS(task, mr, is_last),
 
 	TP_STRUCT__entry(
 		__field(unsigned int, task_id)
@@ -454,7 +454,7 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 		__field(u32, handle)
 		__field(u32, length)
 		__field(u64, offset)
-		__field(int, nsegs)
+		__field(bool, is_last)
 	),
 
 	TP_fast_assign(
@@ -464,7 +464,7 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 		__entry->handle = mr->mr_handle;
 		__entry->length = mr->mr_length;
 		__entry->offset = mr->mr_offset;
-		__entry->nsegs = nsegs;
+		__entry->is_last = is_last;
 	),
 
 	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
@@ -472,7 +472,7 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 		__entry->task_id, __entry->client_id,
 		__entry->length, (unsigned long long)__entry->offset,
 		__entry->handle,
-		__entry->nents < __entry->nsegs ? "more" : "last"
+		__entry->is_last ? "last" : "more"
 	)
 );
 
@@ -481,9 +481,9 @@ DECLARE_EVENT_CLASS(xprtrdma_wrch_event,
 				TP_PROTO(				\
 					const struct rpc_task *task,	\
 					struct rpcrdma_mr *mr,		\
-					int nsegs			\
+					bool is_last			\
 				),					\
-				TP_ARGS(task, mr, nsegs))
+				TP_ARGS(task, mr, is_last))
 
 TRACE_DEFINE_ENUM(DMA_BIDIRECTIONAL);
 TRACE_DEFINE_ENUM(DMA_TO_DEVICE);
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 4331b0b65f4c..229057d35fb8 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -268,10 +268,9 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 }
 
 /**
- * frwr_map - Register a memory region
+ * frwr_map - Register a memory region from an xdr_buf cursor
  * @r_xprt: controlling transport
- * @seg: memory region co-ordinates
- * @nsegs: number of segments remaining
+ * @cur: cursor tracking position within the xdr_buf
  * @writing: true when RDMA Write will be used
  * @xid: XID of RPC using the registered memory
  * @mr: MR to fill in
@@ -279,34 +278,104 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
  * Prepare a REG_MR Work Request to register a memory region
  * for remote access via RDMA READ or RDMA WRITE.
  *
- * Returns the next segment or a negative errno pointer.
- * On success, @mr is filled in.
+ * Returns 0 on success (cursor advanced past consumed data,
+ * @mr populated) or a negative errno on failure.
  */
-struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
-				struct rpcrdma_mr_seg *seg,
-				int nsegs, bool writing, __be32 xid,
-				struct rpcrdma_mr *mr)
+int frwr_map(struct rpcrdma_xprt *r_xprt,
+	     struct rpcrdma_xdr_cursor *cur,
+	     bool writing, __be32 xid,
+	     struct rpcrdma_mr *mr)
 {
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	const struct xdr_buf *xdrbuf = cur->xc_buf;
+	bool sg_gaps = ep->re_mrtype == IB_MR_TYPE_SG_GAPS;
+	unsigned int max_depth = ep->re_max_fr_depth;
 	struct ib_reg_wr *reg_wr;
 	int i, n, dma_nents;
 	struct ib_mr *ibmr;
 	u8 key;
 
-	if (nsegs > ep->re_max_fr_depth)
-		nsegs = ep->re_max_fr_depth;
-	for (i = 0; i < nsegs;) {
-		sg_set_page(&mr->mr_sg[i], seg->mr_page,
-			    seg->mr_len, seg->mr_offset);
+	i = 0;
 
-		++seg;
-		++i;
-		if (ep->re_mrtype == IB_MR_TYPE_SG_GAPS)
-			continue;
-		if ((i < nsegs && seg->mr_offset) ||
-		    offset_in_page((seg-1)->mr_offset + (seg-1)->mr_len))
-			break;
+	/* Head kvec */
+	if (!(cur->xc_flags & XC_HEAD_DONE)) {
+		const struct kvec *head = &xdrbuf->head[0];
+
+		sg_set_page(&mr->mr_sg[i],
+			    virt_to_page(head->iov_base),
+			    head->iov_len,
+			    offset_in_page(head->iov_base));
+		cur->xc_flags |= XC_HEAD_DONE;
+		i++;
+		/* Without sg-gap support, each non-contiguous region
+		 * must be registered as a separate MR.  Returning
+		 * here after the head kvec causes the caller to
+		 * invoke frwr_map() again for the page list and
+		 * tail.
+		 */
+		if (!sg_gaps)
+			goto finish;
 	}
+
+	/* Page list */
+	if (!(cur->xc_flags & XC_PAGES_DONE) && xdrbuf->page_len) {
+		unsigned int page_base, remaining;
+		struct page **ppages;
+
+		remaining = xdrbuf->page_len - cur->xc_page_offset;
+		page_base = offset_in_page(xdrbuf->page_base +
+					   cur->xc_page_offset);
+		ppages = xdrbuf->pages +
+			 ((xdrbuf->page_base + cur->xc_page_offset)
+			  >> PAGE_SHIFT);
+
+		while (remaining > 0 && i < max_depth) {
+			unsigned int len;
+
+			len = min_t(unsigned int,
+				    PAGE_SIZE - page_base, remaining);
+			sg_set_page(&mr->mr_sg[i], *ppages,
+				    len, page_base);
+			cur->xc_page_offset += len;
+			i++;
+			ppages++;
+			remaining -= len;
+
+			if (!sg_gaps && remaining > 0 &&
+			    offset_in_page(page_base + len))
+				goto finish;
+			page_base = 0;
+		}
+		if (remaining == 0)
+			cur->xc_flags |= XC_PAGES_DONE;
+	} else if (!(cur->xc_flags & XC_PAGES_DONE)) {
+		cur->xc_flags |= XC_PAGES_DONE;
+	}
+
+	/* Tail kvec */
+	if (!(cur->xc_flags & XC_TAIL_DONE) && xdrbuf->tail[0].iov_len &&
+	    i < max_depth) {
+		const struct kvec *tail = &xdrbuf->tail[0];
+
+		if (!sg_gaps && i > 0) {
+			struct scatterlist *prev = &mr->mr_sg[i - 1];
+
+			if (offset_in_page(prev->offset + prev->length) ||
+			    offset_in_page(tail->iov_base))
+				goto finish;
+		}
+		sg_set_page(&mr->mr_sg[i],
+			    virt_to_page(tail->iov_base),
+			    tail->iov_len,
+			    offset_in_page(tail->iov_base));
+		cur->xc_flags |= XC_TAIL_DONE;
+		i++;
+	} else if (!(cur->xc_flags & XC_TAIL_DONE) &&
+		   !xdrbuf->tail[0].iov_len) {
+		cur->xc_flags |= XC_TAIL_DONE;
+	}
+
+finish:
 	mr->mr_dir = rpcrdma_data_dir(writing);
 	mr->mr_nents = i;
 
@@ -338,15 +407,15 @@ struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
 	mr->mr_offset = ibmr->iova;
 	trace_xprtrdma_mr_map(mr);
 
-	return seg;
+	return 0;
 
 out_dmamap_err:
 	trace_xprtrdma_frwr_sgerr(mr, i);
-	return ERR_PTR(-EIO);
+	return -EIO;
 
 out_mapmr_err:
 	trace_xprtrdma_frwr_maperr(mr, n);
-	return ERR_PTR(-EIO);
+	return -EIO;
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 3aac1456e23e..a77e7e48aab2 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -200,67 +200,30 @@ rpcrdma_alloc_sparse_pages(struct xdr_buf *buf)
 	return 0;
 }
 
-/* Convert @vec to a single SGL element.
- *
- * Returns pointer to next available SGE, and bumps the total number
- * of SGEs consumed.
- */
-static struct rpcrdma_mr_seg *
-rpcrdma_convert_kvec(struct kvec *vec, struct rpcrdma_mr_seg *seg,
-		     unsigned int *n)
+static void
+rpcrdma_xdr_cursor_init(struct rpcrdma_xdr_cursor *cur,
+			const struct xdr_buf *xdrbuf,
+			unsigned int pos, enum rpcrdma_chunktype type)
 {
-	seg->mr_page = virt_to_page(vec->iov_base);
-	seg->mr_offset = offset_in_page(vec->iov_base);
-	seg->mr_len = vec->iov_len;
-	++seg;
-	++(*n);
-	return seg;
+	cur->xc_buf = xdrbuf;
+	cur->xc_page_offset = 0;
+	cur->xc_flags = 0;
+
+	if (pos != 0)
+		cur->xc_flags |= XC_HEAD_DONE;
+	if (!xdrbuf->page_len)
+		cur->xc_flags |= XC_PAGES_DONE;
+	if (type == rpcrdma_readch || type == rpcrdma_writech ||
+	    !xdrbuf->tail[0].iov_len)
+		cur->xc_flags |= XC_TAIL_DONE;
 }
 
-/* Convert @xdrbuf into SGEs no larger than a page each. As they
- * are registered, these SGEs are then coalesced into RDMA segments
- * when the selected memreg mode supports it.
- *
- * Returns positive number of SGEs consumed, or a negative errno.
- */
-
-static int
-rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
-		     unsigned int pos, enum rpcrdma_chunktype type,
-		     struct rpcrdma_mr_seg *seg)
+static bool
+rpcrdma_xdr_cursor_done(const struct rpcrdma_xdr_cursor *cur)
 {
-	unsigned long page_base;
-	unsigned int len, n;
-	struct page **ppages;
-
-	n = 0;
-	if (pos == 0)
-		seg = rpcrdma_convert_kvec(&xdrbuf->head[0], seg, &n);
-
-	len = xdrbuf->page_len;
-	ppages = xdrbuf->pages + (xdrbuf->page_base >> PAGE_SHIFT);
-	page_base = offset_in_page(xdrbuf->page_base);
-	while (len) {
-		seg->mr_page = *ppages;
-		seg->mr_offset = page_base;
-		seg->mr_len = min_t(u32, PAGE_SIZE - page_base, len);
-		len -= seg->mr_len;
-		++ppages;
-		++seg;
-		++n;
-		page_base = 0;
-	}
-
-	if (type == rpcrdma_readch || type == rpcrdma_writech)
-		goto out;
-
-	if (xdrbuf->tail[0].iov_len)
-		rpcrdma_convert_kvec(&xdrbuf->tail[0], seg, &n);
-
-out:
-	if (unlikely(n > RPCRDMA_MAX_SEGS))
-		return -EIO;
-	return n;
+	return (cur->xc_flags & (XC_HEAD_DONE | XC_PAGES_DONE |
+				 XC_TAIL_DONE)) ==
+	       (XC_HEAD_DONE | XC_PAGES_DONE | XC_TAIL_DONE);
 }
 
 static int
@@ -292,11 +255,10 @@ encode_read_segment(struct xdr_stream *xdr, struct rpcrdma_mr *mr,
 	return 0;
 }
 
-static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
-						 struct rpcrdma_req *req,
-						 struct rpcrdma_mr_seg *seg,
-						 int nsegs, bool writing,
-						 struct rpcrdma_mr **mr)
+static int rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
+			      struct rpcrdma_req *req,
+			      struct rpcrdma_xdr_cursor *cur,
+			      bool writing, struct rpcrdma_mr **mr)
 {
 	*mr = rpcrdma_mr_pop(&req->rl_free_mrs);
 	if (!*mr) {
@@ -307,13 +269,13 @@ static struct rpcrdma_mr_seg *rpcrdma_mr_prepare(struct rpcrdma_xprt *r_xprt,
 	}
 
 	rpcrdma_mr_push(*mr, &req->rl_registered);
-	return frwr_map(r_xprt, seg, nsegs, writing, req->rl_slot.rq_xid, *mr);
+	return frwr_map(r_xprt, cur, writing, req->rl_slot.rq_xid, *mr);
 
 out_getmr_err:
 	trace_xprtrdma_nomrs_err(r_xprt, req);
 	xprt_wait_for_buffer_space(&r_xprt->rx_xprt);
 	rpcrdma_mrs_refresh(r_xprt);
-	return ERR_PTR(-EAGAIN);
+	return -EAGAIN;
 }
 
 /* Register and XDR encode the Read list. Supports encoding a list of read
@@ -336,10 +298,10 @@ static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
 				    enum rpcrdma_chunktype rtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
-	struct rpcrdma_mr_seg *seg;
+	struct rpcrdma_xdr_cursor cur;
 	struct rpcrdma_mr *mr;
 	unsigned int pos;
-	int nsegs;
+	int ret;
 
 	if (rtype == rpcrdma_noch_pullup || rtype == rpcrdma_noch_mapped)
 		goto done;
@@ -347,24 +309,20 @@ static int rpcrdma_encode_read_list(struct rpcrdma_xprt *r_xprt,
 	pos = rqst->rq_snd_buf.head[0].iov_len;
 	if (rtype == rpcrdma_areadch)
 		pos = 0;
-	seg = req->rl_segments;
-	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_snd_buf, pos,
-				     rtype, seg);
-	if (nsegs < 0)
-		return nsegs;
+	rpcrdma_xdr_cursor_init(&cur, &rqst->rq_snd_buf, pos, rtype);
 
 	do {
-		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, false, &mr);
-		if (IS_ERR(seg))
-			return PTR_ERR(seg);
+		ret = rpcrdma_mr_prepare(r_xprt, req, &cur, false, &mr);
+		if (ret)
+			return ret;
 
 		if (encode_read_segment(xdr, mr, pos) < 0)
 			return -EMSGSIZE;
 
-		trace_xprtrdma_chunk_read(rqst->rq_task, pos, mr, nsegs);
+		trace_xprtrdma_chunk_read(rqst->rq_task, pos, mr,
+					  rpcrdma_xdr_cursor_done(&cur));
 		r_xprt->rx_stats.read_chunk_count++;
-		nsegs -= mr->mr_nents;
-	} while (nsegs);
+	} while (!rpcrdma_xdr_cursor_done(&cur));
 
 done:
 	if (xdr_stream_encode_item_absent(xdr) < 0)
@@ -394,20 +352,16 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 {
 	struct xdr_stream *xdr = &req->rl_stream;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	struct rpcrdma_mr_seg *seg;
+	struct rpcrdma_xdr_cursor cur;
 	struct rpcrdma_mr *mr;
-	int nsegs, nchunks;
+	int nchunks, ret;
 	__be32 *segcount;
 
 	if (wtype != rpcrdma_writech)
 		goto done;
 
-	seg = req->rl_segments;
-	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf,
-				     rqst->rq_rcv_buf.head[0].iov_len,
-				     wtype, seg);
-	if (nsegs < 0)
-		return nsegs;
+	rpcrdma_xdr_cursor_init(&cur, &rqst->rq_rcv_buf,
+				rqst->rq_rcv_buf.head[0].iov_len, wtype);
 
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return -EMSGSIZE;
@@ -418,30 +372,30 @@ static int rpcrdma_encode_write_list(struct rpcrdma_xprt *r_xprt,
 
 	nchunks = 0;
 	do {
-		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, true, &mr);
-		if (IS_ERR(seg))
-			return PTR_ERR(seg);
+		ret = rpcrdma_mr_prepare(r_xprt, req, &cur, true, &mr);
+		if (ret)
+			return ret;
 
 		if (encode_rdma_segment(xdr, mr) < 0)
 			return -EMSGSIZE;
 
-		trace_xprtrdma_chunk_write(rqst->rq_task, mr, nsegs);
+		trace_xprtrdma_chunk_write(rqst->rq_task, mr,
+					   rpcrdma_xdr_cursor_done(&cur));
 		r_xprt->rx_stats.write_chunk_count++;
 		r_xprt->rx_stats.total_rdma_request += mr->mr_length;
 		nchunks++;
-		nsegs -= mr->mr_nents;
-	} while (nsegs);
+	} while (!rpcrdma_xdr_cursor_done(&cur));
 
 	if (xdr_pad_size(rqst->rq_rcv_buf.page_len)) {
 		if (encode_rdma_segment(xdr, ep->re_write_pad_mr) < 0)
 			return -EMSGSIZE;
 
 		trace_xprtrdma_chunk_wp(rqst->rq_task, ep->re_write_pad_mr,
-					nsegs);
+					true);
 		r_xprt->rx_stats.write_chunk_count++;
-		r_xprt->rx_stats.total_rdma_request += mr->mr_length;
+		r_xprt->rx_stats.total_rdma_request +=
+			ep->re_write_pad_mr->mr_length;
 		nchunks++;
-		nsegs -= mr->mr_nents;
 	}
 
 	/* Update count of segments in this Write chunk */
@@ -471,9 +425,9 @@ static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
 				      enum rpcrdma_chunktype wtype)
 {
 	struct xdr_stream *xdr = &req->rl_stream;
-	struct rpcrdma_mr_seg *seg;
+	struct rpcrdma_xdr_cursor cur;
 	struct rpcrdma_mr *mr;
-	int nsegs, nchunks;
+	int nchunks, ret;
 	__be32 *segcount;
 
 	if (wtype != rpcrdma_replych) {
@@ -482,10 +436,7 @@ static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
 		return 0;
 	}
 
-	seg = req->rl_segments;
-	nsegs = rpcrdma_convert_iovs(r_xprt, &rqst->rq_rcv_buf, 0, wtype, seg);
-	if (nsegs < 0)
-		return nsegs;
+	rpcrdma_xdr_cursor_init(&cur, &rqst->rq_rcv_buf, 0, wtype);
 
 	if (xdr_stream_encode_item_present(xdr) < 0)
 		return -EMSGSIZE;
@@ -496,19 +447,19 @@ static int rpcrdma_encode_reply_chunk(struct rpcrdma_xprt *r_xprt,
 
 	nchunks = 0;
 	do {
-		seg = rpcrdma_mr_prepare(r_xprt, req, seg, nsegs, true, &mr);
-		if (IS_ERR(seg))
-			return PTR_ERR(seg);
+		ret = rpcrdma_mr_prepare(r_xprt, req, &cur, true, &mr);
+		if (ret)
+			return ret;
 
 		if (encode_rdma_segment(xdr, mr) < 0)
 			return -EMSGSIZE;
 
-		trace_xprtrdma_chunk_reply(rqst->rq_task, mr, nsegs);
+		trace_xprtrdma_chunk_reply(rqst->rq_task, mr,
+					   rpcrdma_xdr_cursor_done(&cur));
 		r_xprt->rx_stats.reply_chunk_count++;
 		r_xprt->rx_stats.total_rdma_request += mr->mr_length;
 		nchunks++;
-		nsegs -= mr->mr_nents;
-	} while (nsegs);
+	} while (!rpcrdma_xdr_cursor_done(&cur));
 
 	/* Update count of segments in the Reply chunk */
 	*segcount = cpu_to_be32(nchunks);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8147d2b41494..37bba72065e8 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -283,19 +283,36 @@ struct rpcrdma_mr {
  * registered or invalidated. Must handle a Reply chunk:
  */
 enum {
-	RPCRDMA_MAX_IOV_SEGS	= 3,
+	RPCRDMA_MAX_IOV_SEGS	= 3,	/* head, page-boundary, tail */
 	RPCRDMA_MAX_DATA_SEGS	= ((1 * 1024 * 1024) / PAGE_SIZE) + 1,
 	RPCRDMA_MAX_SEGS	= RPCRDMA_MAX_DATA_SEGS +
 				  RPCRDMA_MAX_IOV_SEGS,
 };
 
-/* Arguments for DMA mapping and registration */
-struct rpcrdma_mr_seg {
-	u32		mr_len;		/* length of segment */
-	struct page	*mr_page;	/* underlying struct page */
-	u64		mr_offset;	/* IN: page offset, OUT: iova */
+/**
+ * struct rpcrdma_xdr_cursor - tracks position within an xdr_buf
+ *     for iterative MR registration
+ * @xc_buf: the xdr_buf being iterated
+ * @xc_page_offset: byte offset into the page region consumed so far
+ * @xc_flags: combination of XC_* bits
+ *
+ * Each XC_*_DONE flag indicates that this region has no
+ * remaining MR registration work.  That condition holds both when the region
+ * has already been registered by a prior frwr_map() call and
+ * when the region is excluded from this chunk type (pre-set
+ * at init time by rpcrdma_xdr_cursor_init()).  frwr_map()
+ * treats the two cases identically: skip the region.
+ */
+struct rpcrdma_xdr_cursor {
+	const struct xdr_buf		*xc_buf;
+	unsigned int			xc_page_offset;
+	unsigned int			xc_flags;
 };
 
+#define XC_HEAD_DONE	BIT(0)
+#define XC_PAGES_DONE	BIT(1)
+#define XC_TAIL_DONE	BIT(2)
+
 /* The Send SGE array is provisioned to send a maximum size
  * inline request:
  * - RPC-over-RDMA header
@@ -330,7 +347,6 @@ struct rpcrdma_req {
 
 	struct list_head	rl_free_mrs;
 	struct list_head	rl_registered;
-	struct rpcrdma_mr_seg	rl_segments[RPCRDMA_MAX_SEGS];
 };
 
 static inline struct rpcrdma_req *
@@ -450,8 +466,8 @@ rpcrdma_portstr(const struct rpcrdma_xprt *r_xprt)
 }
 
 /* Setting this to 0 ensures interoperability with early servers.
- * Setting this to 1 enhances certain unaligned read/write performance.
- * Default is 0, see sysctl entry and rpc_rdma.c rpcrdma_convert_iovs() */
+ * Setting this to 1 enhances unaligned read/write performance.
+ * Default is 0, see sysctl entry and rpc_rdma.c */
 extern int xprt_rdma_pad_optimize;
 
 /* This setting controls the hunt for a supported memory
@@ -535,10 +551,10 @@ void frwr_reset(struct rpcrdma_req *req);
 int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device);
 int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr);
 void frwr_mr_release(struct rpcrdma_mr *mr);
-struct rpcrdma_mr_seg *frwr_map(struct rpcrdma_xprt *r_xprt,
-				struct rpcrdma_mr_seg *seg,
-				int nsegs, bool writing, __be32 xid,
-				struct rpcrdma_mr *mr);
+int frwr_map(struct rpcrdma_xprt *r_xprt,
+	     struct rpcrdma_xdr_cursor *cur,
+	     bool writing, __be32 xid,
+	     struct rpcrdma_mr *mr);
 int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs);
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
-- 
2.53.0


