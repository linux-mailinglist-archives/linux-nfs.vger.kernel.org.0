Return-Path: <linux-nfs+bounces-18848-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP6RNPJdi2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18848-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:33:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B5E11D3E9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5586530601BD
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE9230C348;
	Tue, 10 Feb 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAJk7wBm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD02130B529;
	Tue, 10 Feb 2026 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741150; cv=none; b=laUfJ8heEzzQ5XeDnYFfzRVKiT2xgwpJP83d5oWPmrIxo3KofHE49M8mBJIKHAtM5yHhQOsjuAm8Uvuv2OmUFvMXmUT6y8qibL6oeh4uKXNfTxO7D8p3fZFuFMcbZ1RKg9OsVwN6tMML4IE8c1s7NOtfO/ehHEClRRD4xdE7g7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741150; c=relaxed/simple;
	bh=RlZKYDxdq4OEd398zArSVLGUABwLiHZjZWitFrRtmao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm5iXbXxA1ScEZC2oSPBwQifiqMvAyMDUA7Z2MTl1MfSKXO47CtJMOR4Ji7KFSExJ3FBxpjySbxOUaKx/3xe/Kkh+UBsNfO13e8GKw8eDBSV+XKqb2ysxq9dVS4fMcKwTGGPL9cuynep8f/I3ogeTYog2i/p1CaLMvGIuXMUhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAJk7wBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D37C19424;
	Tue, 10 Feb 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741150;
	bh=RlZKYDxdq4OEd398zArSVLGUABwLiHZjZWitFrRtmao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cAJk7wBmg3aoR7yLeNoPszZhiIuT+OtdJoWZSRIVzlU/TfbcV/5Z2zY9vyqHb8xAR
	 f6KRZEeOEmepuxnPOXzdLf0LRwrt4JH7NIY6iUwmlhxKxnNIA2U3ygSSAciZNf9eDc
	 vrz78QLGuyr/zo+cnca9bvAS0PmuRJZpl4fcXgCJf97VBJLzclbpv+DwtiWHaE8CoN
	 6LWbIXuPTPiBYdLcKXjISXXsJgKIqDy7gcR0BVEB9mYjOdt+3L5wiBA1Hd7XccVr3K
	 gKBd7CD6zoyhm3OlQ35ZM6UOx5XaxpUSM3BHr+Zi8sDcwlTnaU2vKM6h3AeggwckTU
	 tUdlbjNlw9thg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 05/15] svcrdma: Factor out WR chain linking into helper
Date: Tue, 10 Feb 2026 11:32:12 -0500
Message-ID: <20260210163222.2356793-6-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210163222.2356793-1-cel@kernel.org>
References: <20260210163222.2356793-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18848-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 43B5E11D3E9
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
index 6057966d3502..9ac6a73e4b5d 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -610,15 +610,32 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
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
+static inline void svc_rdma_cc_link_wrs(struct svcxprt_rdma *rdma,
+					struct svc_rdma_send_ctxt *sctxt,
+					struct svc_rdma_chunk_ctxt *cc)
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
@@ -627,10 +644,7 @@ static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
-	struct ib_send_wr *first_wr;
 	struct xdr_buf payload;
-	struct list_head *pos;
-	struct ib_cqe *cqe;
 	int ret;
 
 	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
@@ -650,18 +664,7 @@ static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
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
@@ -723,9 +726,6 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 {
 	struct svc_rdma_write_info *info = &sctxt->sc_reply_info;
 	struct svc_rdma_chunk_ctxt *cc = &info->wi_cc;
-	struct ib_send_wr *first_wr;
-	struct list_head *pos;
-	struct ib_cqe *cqe;
 	int ret;
 
 	info->wi_rdma = rdma;
@@ -739,18 +739,7 @@ int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
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
2.52.0


