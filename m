Return-Path: <linux-nfs+bounces-18850-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMHXKwRei2mYUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18850-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800611D3F9
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFC683067787
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AA83033D2;
	Tue, 10 Feb 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzOVU2Mb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C92EDD58;
	Tue, 10 Feb 2026 16:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741153; cv=none; b=ULVkKYV0ZXCw1I4J0a80PPn4P5eqRholrUQua/uUfRrko4fcxeABoa0AYxWoUajywg4ZNG4E1X1+l8xm6zJzQH+7ymF9Lkpcjrc3UvrNUlYDwe17ikoE77b/e1aceWH4zMzYOvD9VThE8AK4ouTGcnBVuUs7+5UMdzUM+4luGP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741153; c=relaxed/simple;
	bh=9GFU1ermKRaO5E7EmoQrrBCIjwsXzYZnkONzAyWR7nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K2KOVn4v/SVozDkr+nfN1AIG71Q/lvnFVsPQv3gylMxClRF0A6tod/pfC4aakm9WuryEY4hJvORJHm+qebXG5mLNm/xfM4HXZ1j93dso3SLK+qEEGmtvV81Ebklwy6r5MDmEJC27CU6ypNfQEsWTeF2z6J0KgAgRr0wNSXtmE/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzOVU2Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40A5C19424;
	Tue, 10 Feb 2026 16:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770741152;
	bh=9GFU1ermKRaO5E7EmoQrrBCIjwsXzYZnkONzAyWR7nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzOVU2MbYcZqZuMaASh+Wt2TibEMHjhGGQ47XD4ZRg+LfU0xlvZa7CLfPB3pf/WOE
	 tYGPPEJ7AA10s+RboOSIyLzZdY/orDTNMAT6kOJfOK+ibcBbfHnLvLay1xgyHRaOOO
	 cKJVU9qMKVRIxA+gfC22ANkpnzbgx1GiihPYQZW603hfkVunC0K2BrY4VZ+AXOH7Ze
	 L6BFfSo1bpoDXqiVGioaPRrz7jXRFul+JOqD7Dx9rlxXwdtJBImIA5pR+meTtjJQgz
	 Kl3dm4h0z+LnWWredncpJb2BoGin70b1xpBOWEenGe9n6EppMnEpp6hCkPXWbTmiDD
	 1LF5ZS+QEFbfw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 07/15] svcrdma: Use lock-free list for Receive Queue tracking
Date: Tue, 10 Feb 2026 11:32:14 -0500
Message-ID: <20260210163222.2356793-8-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18850-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 4800611D3F9
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The sc_rq_dto_lock spinlock is acquired on every receive completion
to add the completed receive context to the sc_rq_dto_q list. Under
high message rates this creates contention between softirq contexts
processing completions.

Replace sc_rq_dto_q with a lock-free llist. Receive completions now
use llist_add() which requires no locking. The consumer uses
llist_del_first() to retrieve one item at a time.

The lock remains for sc_read_complete_q, but the primary hot path
(receive completion and consumption) no longer requires it. This
eliminates producer-side contention entirely.

Note that llist provides LIFO ordering rather than FIFO. For
independent RPC requests this has no semantic impact and avoids
the overhead of reversing the list on the consumer side.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  2 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 38 +++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 972d446439a6..ae4300364491 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -109,7 +109,7 @@ struct svcxprt_rdma {
 	/* Receive path */
 	u32		     sc_pending_recvs ____cacheline_aligned_in_smp;
 	u32		     sc_recv_batch;
-	struct list_head     sc_rq_dto_q;
+	struct llist_head    sc_rq_dto_q;
 	struct list_head     sc_read_complete_q;
 	spinlock_t	     sc_rq_dto_lock;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 29a71fa79e2b..fd4d3fbd7054 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -361,11 +361,12 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
 
-	spin_lock(&rdma->sc_rq_dto_lock);
-	list_add_tail(&ctxt->rc_list, &rdma->sc_rq_dto_q);
-	/* Note the unlock pairs with the smp_rmb in svc_xprt_ready: */
+	llist_add(&ctxt->rc_node, &rdma->sc_rq_dto_q);
+	/*
+	 * The implicit barrier of llist_add's cmpxchg pairs with
+	 * the smp_rmb in svc_xprt_ready.
+	 */
 	set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
-	spin_unlock(&rdma->sc_rq_dto_lock);
 	if (!test_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags))
 		svc_xprt_enqueue(&rdma->sc_xprt);
 	return;
@@ -388,13 +389,16 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 
 	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_read_complete_q))) {
 		list_del(&ctxt->rc_list);
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 	}
-	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_rq_dto_q))) {
-		list_del(&ctxt->rc_list);
+	node = llist_del_all(&rdma->sc_rq_dto_q);
+	while (node) {
+		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+		node = node->next;
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
 	}
 }
@@ -930,6 +934,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	struct svcxprt_rdma *rdma_xprt =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 	int ret;
 
 	/* Prevent svc_xprt_release() from releasing pages in rq_pages
@@ -949,13 +954,24 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		svc_rdma_read_complete(rqstp, ctxt);
 		goto complete;
 	}
-	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
-	if (ctxt)
-		list_del(&ctxt->rc_list);
-	else
+	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+
+	node = llist_del_first(&rdma_xprt->sc_rq_dto_q);
+	if (node) {
+		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+	} else {
+		ctxt = NULL;
 		/* No new incoming requests, terminate the loop */
 		clear_bit(XPT_DATA, &xprt->xpt_flags);
-	spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+
+		/*
+		 * If a completion arrived after llist_del_first but
+		 * before clear_bit, the producer's set_bit would be
+		 * cleared above. Recheck to close this race window.
+		 */
+		if (!llist_empty(&rdma_xprt->sc_rq_dto_q))
+			set_bit(XPT_DATA, &xprt->xpt_flags);
+	}
 
 	/* Unblock the transport for the next receive */
 	svc_xprt_received(xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index d1dcffbf2fe7..e7f8898d09db 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -173,7 +173,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
-	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
+	init_llist_head(&cma_xprt->sc_rq_dto_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
-- 
2.52.0


