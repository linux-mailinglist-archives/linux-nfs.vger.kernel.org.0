Return-Path: <linux-nfs+bounces-19402-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMQEKFGmoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19402-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D4F1B880D
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF60130E11C7
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E682BE02A;
	Fri, 27 Feb 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vk2fUNro"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29229898B
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201032; cv=none; b=OjPQHbak9M7aw2OE7iyNFytATCKuZYEM9mokoezUOOWJ8nlLCmqRxHMf4FRSWH0opNJUWl9mZpm4zQWM6mtpsHD7mB2jmt7MEMfUPqW9M/Z/24m+f96wa/Q9uMc9bDjjf9rN2g0ykiXRbnsw3FrOD5Svuzqi1838zFl3+tKokCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201032; c=relaxed/simple;
	bh=5KKFBoYVzOeBvMG0B5hJG1d6rEvruwjvcwLYrnbl7DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=niGvhxMNaE7gOYpC61lfJepjZynlwpPOKHSkhoSvHMKEPIvx1GiCJt5glQIq9bebTcH+AgcK38FbQb1uzcjituO2Bw6HyH7tjPJTEGrLY6mjghLVxkFPQnLvPvs92Whw9tjy4vU0chf2DYPING23Pl3A6fBifChcfTLyyi7IIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vk2fUNro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC01C2BC86;
	Fri, 27 Feb 2026 14:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201032;
	bh=5KKFBoYVzOeBvMG0B5hJG1d6rEvruwjvcwLYrnbl7DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vk2fUNro80HV4tL71lqB0LRlqcy/QZZLS0fsb+t7Dn4O0bDEMEa9cv0ayxW6v0Phf
	 kSB2ltiqwVEF8QmOTxlrh9mk1CACwi/dWd//JrjHv5uj5Yjyg2ggIXkvtxhpdaB+Il
	 tq2pMH1k0J5cy9LrDmlKuiR+QrFcG31GgANygAvOLLUCMhvXJom9qCkk9OY5Qa/+E3
	 lpncMETMPgRdI2PM6zl2+yRRXAWYRkA3/wAVlLUCMIrvwXQpqd5KwHKmPJeRCIIZJM
	 oDf5Y/5GEKbPa/wKD+eDeW+XKf+yjNxvuRvLTbeDCiI9rAHTaUzC7uKhaTXLbzBnSf
	 h/8UgcvzNTQLg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 05/18] svcrdma: Factor out WR chain linking into helper
Date: Fri, 27 Feb 2026 09:03:32 -0500
Message-ID: <20260227140345.40488-6-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19402-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 58D4F1B880D
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_prepare_write_chunk() and svc_rdma_prepare_reply_chunk()
contain identical code for linking RDMA R/W work requests onto a
Send context's WR chain. This duplication increases maintenance
burden and risks divergent bug fixes.

Introduce svc_rdma_cc_link_wrs() to consolidate the WR chain
linking logic. The helper walks the chunk context's rwctxts list,
chains each WR via rdma_rw_ctx_wrs(), and updates the Send
context's chain head and SQE count. Completion signaling is
requested only for the tail WR (posted first).

No functional change.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c | 67 +++++++++++++------------------
 1 file changed, 28 insertions(+), 39 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index c5d65164eae2..b1237d81075b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -619,15 +619,32 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 	return xdr->len;
 }
 
-/*
- * svc_rdma_prepare_write_chunk - Link Write WRs for @chunk onto @sctxt's chain
- *
- * Write WRs are prepended to the Send WR chain so that a single
- * ib_post_send() posts both RDMA Writes and the final Send. Only
- * the first WR in each chunk gets a CQE for error detection;
- * subsequent WRs complete without individual completion events.
- * The Send WR's signaled completion indicates all chained
- * operations have finished.
+/* Link chunk WRs onto @sctxt's WR chain. Completion is requested
+ * for the tail WR, which is posted first.
+ */
+static void svc_rdma_cc_link_wrs(struct svcxprt_rdma *rdma,
+				 struct svc_rdma_send_ctxt *sctxt,
+				 struct svc_rdma_chunk_ctxt *cc)
+{
+	struct ib_send_wr *first_wr;
+	struct list_head *pos;
+	struct ib_cqe *cqe;
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
+}
+
+/* Link Write WRs for @chunk onto @sctxt's WR chain.
  */
 static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
 					struct svc_rdma_send_ctxt *sctxt,
@@ -636,10 +653,7 @@ static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
-	struct ib_send_wr *first_wr;
 	struct xdr_buf payload;
-	struct list_head *pos;
-	struct ib_cqe *cqe;
 	int ret;
 
 	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
@@ -659,18 +673,7 @@ static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
 	if (unlikely(sctxt->sc_sqecount + cc->cc_sqecount > rdma->sc_sq_depth))
 		goto out_err;
 
-	first_wr = sctxt->sc_wr_chain;
-	cqe = &cc->cc_cqe;
-	list_for_each(pos, &cc->cc_rwctxts) {
-		struct svc_rdma_rw_ctxt *rwc;
-
-		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
-		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
-					   rdma->sc_port_num, cqe, first_wr);
-		cqe = NULL;
-	}
-	sctxt->sc_wr_chain = first_wr;
-	sctxt->sc_sqecount += cc->cc_sqecount;
+	svc_rdma_cc_link_wrs(rdma, sctxt, cc);
 	list_add(&info->wi_list, &sctxt->sc_write_info_list);
 
 	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
@@ -732,9 +735,6 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_write_info *info = &sctxt->sc_reply_info;
 	struct svc_rdma_chunk_ctxt *cc = &info->wi_cc;
-	struct ib_send_wr *first_wr;
-	struct list_head *pos;
-	struct ib_cqe *cqe;
 	int ret;
 
 	info->wi_rdma = rdma;
@@ -748,18 +748,7 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 	if (ret < 0)
 		return ret;
 
-	first_wr = sctxt->sc_wr_chain;
-	cqe = &cc->cc_cqe;
-	list_for_each(pos, &cc->cc_rwctxts) {
-		struct svc_rdma_rw_ctxt *rwc;
-
-		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
-		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
-					   rdma->sc_port_num, cqe, first_wr);
-		cqe = NULL;
-	}
-	sctxt->sc_wr_chain = first_wr;
-	sctxt->sc_sqecount += cc->cc_sqecount;
+	svc_rdma_cc_link_wrs(rdma, sctxt, cc);
 
 	trace_svcrdma_post_reply_chunk(&cc->cc_cid, cc->cc_sqecount);
 	return xdr->len;
-- 
2.53.0


