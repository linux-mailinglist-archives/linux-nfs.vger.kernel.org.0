Return-Path: <linux-nfs+bounces-18849-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oObqFa1di2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18849-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:32:45 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED211D379
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 64945300F1D2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B3F3033D2;
	Tue, 10 Feb 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma03cR7U"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14582F3C02;
	Tue, 10 Feb 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741151; cv=none; b=mXsHjJ/X5i3+elgnx6q7bHPan2eNEdOLn4lgAuBA7W7pPqbmdfimE1rDvyHzzD6Vii2KOr3sOe7RGWJLA+roRB13XsWsNy7eRNedll9X7A76A4Fx3tmiCS8hJ3ciYhzA70dmjGHxIHj+TZKTXrT1RT0DQE5ywCd3+O8JViVJNso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741151; c=relaxed/simple;
	bh=bYTm8YyhQJdCqGCyN3x64Zown9DkSNlSA/sSuBD9mm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C23m/LVO+fWL+7P8d0DanX4yNML3DJ/kFcvnKFr0vB+nRnC7LAXH0LMXR6EHN3QUBWLlxodxyvoE50RUHEgsyvorwJN/x4LD+qLJ38k+18hsN+FOGbL38psBZ6+HPtq+NYTIjU1Tdz5cAZCEotb7WgsXI0zuE540fUEfbxA7F0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ma03cR7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030C2C19425;
	Tue, 10 Feb 2026 16:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741151;
	bh=bYTm8YyhQJdCqGCyN3x64Zown9DkSNlSA/sSuBD9mm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ma03cR7UAv+HzLtuh1xOGx+yu1fGOBZFalV2T0k0Z3x1jSGvhl/ETlR+O/H0O1ySy
	 IF/OXzwhnm2Gp5c5otICwD6qOQHRLadaz839XQK1d5M8/BTtdlqtJ7Gv5FjNOQHF4E
	 +RJrn3Zbgebf5UncGthaiXrnk1xgNpfcf3aG204Ff/i8Z5d8PkR/mMU0eT+3H1PQAM
	 2O1TZLStlu9g1fkrZz/wNNzoKuyEBNql1iJgvQFWwi1bPziCDwoAcYaKU2Zx/s8zh/
	 stpV0ZbD0Aqd4lsK2fCRJALzYoKXVjSvSIFqXqLfEKlnZ0AXl12WVZ+nosMkuvEK+i
	 qzReZDj2F75mg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 06/15] svcrdma: Reduce false sharing in struct svcxprt_rdma
Date: Tue, 10 Feb 2026 11:32:13 -0500
Message-ID: <20260210163222.2356793-7-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18849-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1ED211D379
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Several frequently-modified fields in struct svcxprt_rdma reside
in the same cache line, causing false sharing between independent
code paths:

 - sc_sq_avail: atomic, modified on every ib_post_send and
   completion
 - sc_send_lock/sc_send_ctxts: Send context cache, accessed during
   reply construction
 - sc_rw_ctxt_lock/sc_rw_ctxts: R/W context cache, accessed during
   Read/Write chunk processing

When any of these fields is modified, the entire cache line is
invalidated on other CPUs. Under load, concurrent operations on
different code paths cause the cache line to bounce between cores,
degrading performance.

Insert ____cacheline_aligned_in_smp annotations to place the Send
context cache, R/W context cache, and receive-path fields into
separate cache lines. To utilize the padding this creates:

 - Move sc_pd, sc_ord, sc_max_send_sges into the Send cache line
   (sc_pd is accessed during send context setup)
 - Move sc_qp, sc_port_num, sc_rq_cq, sc_sq_cq into the R/W cache
   line (sc_qp and sc_port_num are accessed together during every
   rdma_rw_ctx_wrs call)

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index d84946cf6176..972d446439a6 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -78,8 +78,6 @@ struct svcxprt_rdma {
 	struct rdma_cm_id    *sc_cm_id;		/* RDMA connection id */
 	struct list_head     sc_accept_q;	/* Conn. waiting accept */
 	struct rpcrdma_notification sc_rn;	/* removal notification */
-	int		     sc_ord;		/* RDMA read limit */
-	int                  sc_max_send_sges;
 	bool		     sc_snd_w_inv;	/* OK to use Send With Invalidate */
 
 	atomic_t             sc_sq_avail;	/* SQEs ready to be consumed */
@@ -90,23 +88,30 @@ struct svcxprt_rdma {
 	u32		     sc_max_requests;	/* Max requests */
 	u32		     sc_max_bc_requests;/* Backward credits */
 	int                  sc_max_req_size;	/* Size of each RQ WR buf */
-	u8		     sc_port_num;
 
-	struct ib_pd         *sc_pd;
-
-	spinlock_t	     sc_send_lock;
+	/* Send context cache */
+	spinlock_t	     sc_send_lock ____cacheline_aligned_in_smp;
 	struct llist_head    sc_send_ctxts;
-	spinlock_t	     sc_rw_ctxt_lock;
-	struct llist_head    sc_rw_ctxts;
+	/* sc_pd accessed during send context alloc */
+	struct ib_pd         *sc_pd;
+	int		     sc_ord;		/* RDMA read limit */
+	int                  sc_max_send_sges;
 
-	u32		     sc_pending_recvs;
+	/* R/W context cache */
+	spinlock_t	     sc_rw_ctxt_lock ____cacheline_aligned_in_smp;
+	struct llist_head    sc_rw_ctxts;
+	/* sc_qp and sc_port_num accessed together */
+	struct ib_qp         *sc_qp;
+	u8		     sc_port_num;
+	struct ib_cq         *sc_rq_cq;
+	struct ib_cq         *sc_sq_cq;
+
+	/* Receive path */
+	u32		     sc_pending_recvs ____cacheline_aligned_in_smp;
 	u32		     sc_recv_batch;
 	struct list_head     sc_rq_dto_q;
 	struct list_head     sc_read_complete_q;
 	spinlock_t	     sc_rq_dto_lock;
-	struct ib_qp         *sc_qp;
-	struct ib_cq         *sc_rq_cq;
-	struct ib_cq         *sc_sq_cq;
 
 	spinlock_t	     sc_lock;		/* transport lock */
 
-- 
2.52.0


