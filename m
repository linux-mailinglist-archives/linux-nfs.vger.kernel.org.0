Return-Path: <linux-nfs+bounces-19403-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBlKFlWmoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19403-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2081B8815
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B703630E1B43
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0E29898B;
	Fri, 27 Feb 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ceo9Dbo6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A729274FD0
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201033; cv=none; b=bQx9H3S91pHRv/77skFd6gQOX4NKB7tBMUoPr5Uvz95m95QoZdqtbTdabmBiaGY8rWHc9t8/Mj+c/3SP9APW2kN00JjIp7yZZxpEAsbvv63dQ8+5wqCrRmR3Bb9STBC7ZxkPtJffZtLsl2v4fFcL5t5rWyrnoH4t5u0gteTMEuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201033; c=relaxed/simple;
	bh=JufAxXItDjAnxJk5QgPL29Wrn/8lpzF/IU5I9Sncsp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6+AF38V0vKzJ/i/Wxa3FhlSICp6ZRCntsuqZ6hmhl8jn+GGGWnDG1u5/FH4RMUNf1pEmGiGAOxjMZg80KuyFtCQS5zGRjJjLFQUntW+vlgS6qd3PUL5jOb/A3Izpu/60fWKBQtcFjMZu95QIpNPVZIRpv4KYwdrH29w0rXNqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ceo9Dbo6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408DEC116C6;
	Fri, 27 Feb 2026 14:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201032;
	bh=JufAxXItDjAnxJk5QgPL29Wrn/8lpzF/IU5I9Sncsp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ceo9Dbo61ZQpaUWJ6JwVyoZ8gy7pZH1BoDchH59ThN7qvkbmYCXoiEF/ATzdWR8vo
	 8yoUihLHW2CsNKQ/aoPZEe0uZjB9V1VaKvifDv1VlS5B07TDeso06ttT0/1w9ibfTM
	 ppHKhbRB73g/PpoHNwwHr+a8Hz/waOux1BajKeFENA4W5eCSq5utt1w2qPHUq6fI1n
	 xtOxxcJnyktV2fQjcb9VUidAYz+S77SjhqiqeFtHJpqL/nzwtGgEQzp7VIVugvSIhF
	 YTzIVBiG/8fpqMaCzLT3Jmw3m/8WFLL/nICsF+5pe7MZK3EmNra1ZpHfnPhIRszqCm
	 c8slyaAdg5Yyg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 06/18] svcrdma: Reduce false sharing in struct svcxprt_rdma
Date: Fri, 27 Feb 2026 09:03:33 -0500
Message-ID: <20260227140345.40488-7-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19403-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: CA2081B8815
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

Insert ____cacheline_aligned_in_smp annotations to place the Send
context cache, R/W context cache, and receive-path fields into
separate cache lines.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h | 48 ++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index df6e08aaad57..3cc4408831a3 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -73,13 +73,30 @@ extern struct percpu_counter svcrdma_stat_recv;
 extern struct percpu_counter svcrdma_stat_sq_starve;
 extern struct percpu_counter svcrdma_stat_write;
 
+/*
+ * struct svcxprt_rdma - server-side RDMA transport
+ *
+ * Fields are grouped into cache-line-aligned zones to avoid false
+ * sharing between concurrent code paths. Each zone is marked with
+ * ____cacheline_aligned_in_smp on its first field.
+ *
+ *  SQ reservation	sc_sq_avail, ticket ordering, and connection
+ *			state -- no alignment constraint (struct head).
+ *  Send context cache	sc_send_lock, sc_send_ctxts, sc_pd, and
+ *			related
+ *  R/W context cache	sc_rw_ctxt_lock, sc_rw_ctxts, sc_qp, etc.
+ *  Receive path	sc_pending_recvs, sc_rq_dto_q, etc.
+ *
+ * When adding a field, place it in the zone whose code path modifies the
+ * field under load. Read-only fields can fill padding in any zone that
+ * accesses them. Fields modified by multiple paths remain at the end,
+ * outside any aligned zone.
+ */
 struct svcxprt_rdma {
 	struct svc_xprt      sc_xprt;		/* SVC transport structure */
 	struct rdma_cm_id    *sc_cm_id;		/* RDMA connection id */
 	struct list_head     sc_accept_q;	/* Conn. waiting accept */
 	struct rpcrdma_notification sc_rn;	/* removal notification */
-	int		     sc_ord;		/* RDMA read limit */
-	int                  sc_max_send_sges;
 	bool		     sc_snd_w_inv;	/* OK to use Send With Invalidate */
 
 	atomic_t             sc_sq_avail;	/* SQEs ready to be consumed */
@@ -91,23 +108,30 @@ struct svcxprt_rdma {
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
2.53.0


