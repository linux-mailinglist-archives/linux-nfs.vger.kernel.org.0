Return-Path: <linux-nfs+bounces-19404-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wD+wIlimoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19404-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EBD1B881E
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85B723049506
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3686274FD0;
	Fri, 27 Feb 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWpq6i6z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C115B40FD88
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201033; cv=none; b=oQv4KXNX9F497ANNart4I0bmLfXbDnAhBaGI7ggQ0s5J4H526xIbToIml/B8m3RA9rjZHiDRVJmdWCVWxolEBSgidX6EzKHyIkr7UqNOJHEVNADzL8dpny8xcs1gOIRf2ss7E25VJq9nnW9UmuH//xHqDN9aee/EliZP5abDeSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201033; c=relaxed/simple;
	bh=ajqpsXYGpm6jKWA7vTQJ8KZYkmxKo2XVi9SxSuBER/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvkbEgE8SqtBU8RKafJlbncJqwR6H7xIxY8dFceu+XgWSjnFhVuf6XKdz9xEPebtel1GwgrrYo8Zt+R8xfHyBs5t/SyrpiHXq0bCDeE4yEYD2eLVH0N/lETEUSdltGxFwPtDGBbUditb2614PJ+knG03aQJTiDHlDmXaA17HmyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWpq6i6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144CCC19425;
	Fri, 27 Feb 2026 14:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201033;
	bh=ajqpsXYGpm6jKWA7vTQJ8KZYkmxKo2XVi9SxSuBER/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fWpq6i6zyeAHiX/PJchHmqae+ycm+9Fnwo5PWz9O6xuvGwpQIksVDdqjhq+L8cw3/
	 39r5iX6FxgvLyVWH0hBkRjpzydt4imERO7roG/dXpc7yh8XImaaDtW2lSHlsjBRg6o
	 T47TdgpUiaCRwwtyelrdPelbKnpQYDOM+F105kEcWcC5h0aLDWc1rJWf2d7nI4xFbQ
	 H2JQNi13Zw5uz6NjPwuYFIM2B8YCoairyoS1IrOOOmCxqAYPdLW+brneSbQ+/8AK/Q
	 6NpdEJ7JXBYBwPKosRGSehh7ZrDlDy9qVUXLhQCocDIlh1b0PvLZA+jymPpLgQ8ele
	 qCf6bXz4W+1dw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 07/18] svcrdma: Use lock-free list for Receive Queue tracking
Date: Fri, 27 Feb 2026 09:03:34 -0500
Message-ID: <20260227140345.40488-8-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19404-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 42EBD1B881E
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
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 49 ++++++++++++++++++------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  2 +-
 3 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 3cc4408831a3..884a29cecfa0 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -129,7 +129,7 @@ struct svcxprt_rdma {
 	/* Receive path */
 	u32		     sc_pending_recvs ____cacheline_aligned_in_smp;
 	u32		     sc_recv_batch;
-	struct list_head     sc_rq_dto_q;
+	struct llist_head    sc_rq_dto_q;
 	struct list_head     sc_read_complete_q;
 	spinlock_t	     sc_rq_dto_lock;
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 0b388d324c4f..e99adf14fa9b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -361,11 +361,13 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 	/* All wc fields are now known to be valid */
 	ctxt->rc_byte_len = wc->byte_len;
 
-	spin_lock(&rdma->sc_rq_dto_lock);
-	list_add_tail(&ctxt->rc_list, &rdma->sc_rq_dto_q);
-	/* Note the unlock pairs with the smp_rmb in svc_xprt_ready: */
+	llist_add(&ctxt->rc_node, &rdma->sc_rq_dto_q);
+	/*
+	 * llist_add's cmpxchg provides full memory ordering,
+	 * pairing with the smp_rmb in svc_xprt_ready to ensure
+	 * the list update is visible before XPT_DATA is observed.
+	 */
 	set_bit(XPT_DATA, &rdma->sc_xprt.xpt_flags);
-	spin_unlock(&rdma->sc_rq_dto_lock);
 	if (!test_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags))
 		svc_xprt_enqueue(&rdma->sc_xprt);
 	return;
@@ -388,13 +390,16 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
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
@@ -930,6 +935,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	struct svcxprt_rdma *rdma_xprt =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	struct svc_rdma_recv_ctxt *ctxt;
+	struct llist_node *node;
 	int ret;
 
 	/* Prevent svc_xprt_release() from releasing pages in rq_pages
@@ -949,13 +955,34 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
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
+
+		/* Recheck sc_read_complete_q under lock for the same
+		 * reason -- svc_rdma_wc_read_done() may have added an
+		 * entry and set XPT_DATA between our earlier unlock
+		 * and the clear_bit above.
+		 */
+		spin_lock(&rdma_xprt->sc_rq_dto_lock);
+		if (!list_empty(&rdma_xprt->sc_read_complete_q))
+			set_bit(XPT_DATA, &xprt->xpt_flags);
+		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+	}
 
 	/* Unblock the transport for the next receive */
 	svc_xprt_received(xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index b62d0a0ea816..ff9bae18a1aa 100644
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
2.53.0


