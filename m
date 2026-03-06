Return-Path: <linux-nfs+bounces-19851-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABjRG9lNq2lYcAEAu9opvQ
	(envelope-from <linux-nfs+bounces-19851-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED87A22825B
	for <lists+linux-nfs@lfdr.de>; Fri, 06 Mar 2026 22:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68FE3074138
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2026 21:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F67D3EF0D8;
	Fri,  6 Mar 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAZ9Iyor"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E5349B02;
	Fri,  6 Mar 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772834195; cv=none; b=oSFtwKiINQvP1AhbcCccK5oz/oxtGWyZAY1U6D+iqo2mdPU4eBiGgznySK36WrYQmxRQGsw4ysOXOHFeOac/ruefHjP9wNiVSANnmkUsdxMPEbJVwA5WYtaSrgvgBGsL44LMrfdeGC9RYnmFdQ+EwB6Et+ZrXlbJcXoAWAXFtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772834195; c=relaxed/simple;
	bh=JoHnB+hEOdt0RDk7MkYUyVXmPLQfiIYySS3DTCMwrCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS9LF58i5POXqgs0OVu4Fw/gXZmUUruhdBFanO7iclY1iUcxSj3VJIaZxaYIV0IrsQ+7IMlcS58xh9r1ObLBFe+iCEi15b+de07jIJCXmtnslq0hsLxsYLctbeDBYLfZHgR9d6e1rIrN/azvGIi8UnAVzDFQ2wGsgAlpLlcdUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAZ9Iyor; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFA8C2BC9E;
	Fri,  6 Mar 2026 21:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772834195;
	bh=JoHnB+hEOdt0RDk7MkYUyVXmPLQfiIYySS3DTCMwrCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aAZ9Iyor8MqPI5k32843mqFctyZz3CnMTbnJbPSy5flF3k+HrEp3a+/xZQTC3nv/O
	 cW2XB9jLwBT06NLaTTtV7pfq9REUxwXxbVvE8+WENDq13Z6H9C3KhFQK0pYxyATS9w
	 VksnRL+7aYu0HFt8aZ9MV7dcTzMRl7OYHaPIWfJPPQZhVDpyKUUPQ+8IvWDEAKd6JN
	 wf8t805Xw9+3j+b8e7pepqC7cR999y7Qw/Ibxd0XK4YDD860IOh/hUTrlJz8J7sZRT
	 7yz7A40Ni9V3JrP909mrChVQi0knM2iG5FU5aEmOdflQk1k5Tu3WuMPzlBzdE4Jdlb
	 MEHHpRxGHBkUQ==
From: Chuck Lever <cel@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	<linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 4/7] xprtrdma: Decouple frwr_wp_create from frwr_map
Date: Fri,  6 Mar 2026 16:56:25 -0500
Message-ID: <20260306215620.3668-13-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306215620.3668-9-cel@kernel.org>
References: <20260306215620.3668-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542; i=chuck.lever@oracle.com; h=from:subject; bh=CWjYGjf0teI7A/d6aez5Ld3HwZtIWt188Yba0L+ue14=; b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBpq02NhJiTg9aBRUoKoH+B/j6PxstWmBKxoPCJP t6bq55T14mJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaatNjQAKCRAzarMzb2Z/ lxiMD/oC90HJhUqbmLgR0HVFDgqLPAJ20AveKiGCNxq8dlNMDaX2I9fppHGOzxMr7qOxqFaU50Z ZA+L7hZPLoTrsbNRDCvBltYmY1Di2BEYhhm7gZXW5QzuIjwqNMzjeTvd+o+jD5mx/4bg2+0gGyj hOUkVd5x513YAlmoEWYKDwD5ozRqFodiprVaTc415VdnyDu2znXKJvt1z4uQqhP+tvW36IRCv03 aculyiSOPLVVWrwZgUKY6LuM06syxdmVrE0gzm3Jlopg0H25CL73CDKt8scavVJBacEF2Llp2to +xGsHD57jq3jJHcA+C9j73TRJey017vQixfkymWFbeJ8fVm2hLhFBrfi+DfFKgp8mVqE80/lqUk Ym26UsiwQrXgqXDblC1tN7179g/xqEgvH4f3E1Y23BfQBPKAi7n3EQDKtEweppwB1+n9gFmGJ7p B8owuhTKtG3xswPizDJJN+ZvwdCd/e8pD4yHteZMiSEm5jprokPtW47IGke1ZHTYRsBLLwrYgpd Lko5uiTBAT/1YNVrnMwkI7jc0Kf3os/VkFKTXv3AB54COxRWGY8SH3hdFyOFb5NCyCxISKlDKL/ 6jqroRRh0VOs2yHUscmjZKLhhS5wGuE2vXgrz1jjdGVuIH6qgniMomN2cMm0V2DAmA3qO1qzqSq rkZVRcabwbFD8Pg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED87A22825B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19851-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.983];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

frwr_wp_create is the only caller of frwr_map outside the encode
path. It registers a single 4-byte write-pad region from a stack-
local rpcrdma_mr_seg. Inlining the registration logic directly
(sg_init_table + sg_set_page + ib_dma_map_sg + ib_map_mr_sg +
IOVA mangle + reg_wr setup) eliminates the coupling that would
otherwise complicate the removal of rpcrdma_mr_seg from frwr_map's
interface.

The inlined version adds a proper error-unwind ladder: on failure,
the DMA mapping (if established) is released, ep->re_write_pad_mr is
cleared, and the MR is returned to the transport free list. The old
frwr_map-based code relied on rpcrdma_mrs_destroy at teardown to
reclaim partially-initialized MRs.

This is a one-time setup path; duplicating ~20 lines is a reasonable
tradeoff for decoupling the write-pad registration from the data-
path MR registration.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 57 +++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 31434aeb8e29..4331b0b65f4c 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -669,9 +669,13 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
  */
 int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
 {
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	struct rpcrdma_mr_seg seg;
+	struct ib_reg_wr *reg_wr;
 	struct rpcrdma_mr *mr;
+	struct ib_mr *ibmr;
+	int dma_nents;
+	int ret;
 
 	mr = rpcrdma_mr_get(r_xprt);
 	if (!mr)
@@ -679,11 +683,39 @@ int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
 	mr->mr_req = NULL;
 	ep->re_write_pad_mr = mr;
 
-	seg.mr_len = XDR_UNIT;
-	seg.mr_page = virt_to_page(ep->re_write_pad);
-	seg.mr_offset = offset_in_page(ep->re_write_pad);
-	if (IS_ERR(frwr_map(r_xprt, &seg, 1, true, xdr_zero, mr)))
-		return -EIO;
+	sg_init_table(mr->mr_sg, 1);
+	sg_set_page(mr->mr_sg, virt_to_page(ep->re_write_pad),
+		    XDR_UNIT, offset_in_page(ep->re_write_pad));
+
+	mr->mr_dir = DMA_FROM_DEVICE;
+	mr->mr_nents = 1;
+	dma_nents = ib_dma_map_sg(ep->re_id->device, mr->mr_sg,
+				  mr->mr_nents, mr->mr_dir);
+	if (!dma_nents) {
+		ret = -EIO;
+		goto out_mr;
+	}
+	mr->mr_device = ep->re_id->device;
+
+	ibmr = mr->mr_ibmr;
+	if (ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL,
+			 PAGE_SIZE) != dma_nents) {
+		ret = -EIO;
+		goto out_unmap;
+	}
+
+	/* IOVA is not tagged with an XID; the write-pad is not RPC-specific. */
+	ib_update_fast_reg_key(ibmr, ib_inc_rkey(ibmr->rkey));
+
+	reg_wr = &mr->mr_regwr;
+	reg_wr->mr = ibmr;
+	reg_wr->key = ibmr->rkey;
+	reg_wr->access = IB_ACCESS_REMOTE_WRITE | IB_ACCESS_LOCAL_WRITE;
+
+	mr->mr_handle = ibmr->rkey;
+	mr->mr_length = ibmr->length;
+	mr->mr_offset = ibmr->iova;
+
 	trace_xprtrdma_mr_fastreg(mr);
 
 	mr->mr_cqe.done = frwr_wc_fastreg;
@@ -693,5 +725,16 @@ int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
 	mr->mr_regwr.wr.opcode = IB_WR_REG_MR;
 	mr->mr_regwr.wr.send_flags = 0;
 
-	return ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
+	ret = ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
+	if (!ret)
+		return 0;
+
+out_unmap:
+	frwr_mr_unmap(mr);
+out_mr:
+	ep->re_write_pad_mr = NULL;
+	spin_lock(&buf->rb_lock);
+	rpcrdma_mr_push(mr, &buf->rb_mrs);
+	spin_unlock(&buf->rb_lock);
+	return ret;
 }
-- 
2.53.0


