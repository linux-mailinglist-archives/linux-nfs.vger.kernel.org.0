Return-Path: <linux-nfs+bounces-21812-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJGBEe+cEGpuawYAu9opvQ
	(envelope-from <linux-nfs+bounces-21812-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 20:14:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB855B8E33
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 20:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F18330027C8
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 18:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530F22A7F0;
	Fri, 22 May 2026 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChBc3FSF"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC854313283
	for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 18:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473643; cv=none; b=OQE+vqiojjQkGQKxIHgyBk2UpwO2ze5MGtkh3PauUK9nDqoEGCkKJwZIKsKwuQqzJildcT29xBhwGtaP9gBGgZWrpVkin2QfuYwC3qsNCw5KhdA5h/pU6ilZZVbdnYeyaIYAaxbmlfsym1kvcP7/jXaThJzIe1UxAySJ90B4okw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473643; c=relaxed/simple;
	bh=/TIiNGIcboELpayUjYiC/8+tuhj4j15T0KxhFvOT278=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ya78l2mAjr2z3Kt9KAPk2WZ7dQnRhRaqx2kIZjLJSac0G2YxrPS161pbg/15CobsAfQl6LKzEt66sQv28RUblmig7szHDFhUH9XkZqQibiJn6CtDrs6SG8Zq6wasmjl7z40Ln+QJh0HxWg1rAVLYSMkeZqCCffTPfPY5Df7+MDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChBc3FSF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88C21F000E9;
	Fri, 22 May 2026 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473641;
	bh=i/KWmuysaky0ztzr12qomoOA/NS6fZMR8J7dd1EVw74=;
	h=From:To:Cc:Subject:Date;
	b=ChBc3FSFvEbNg1dcZPEyU5MZPgL0egcR5+4u6TnzV5t3THpbLvpiohq0lIZIRRlQy
	 2NlhS7O1WCJVTnMpeyuZfjwpq1buUBiwGbrTDr7SAsiIouOhmTWchh6yWDY8oQfsvw
	 GBw/sgeFhjelLvbBm3jeQKIRnYzkSQFlyBHdciDuuSedIe0bxEBEo079tw+vDUlT9k
	 Dwp/G6uSvewUIKdOi0d44dmoWiaLvgVaLlzhakjzI0kWCNtgbomFzoFZ2NZSy3zOe4
	 LkTqpFFLOiVUlfW0jc3ZM0Gp6NXetRVz0ObtnKGZh1eml415A2RifgzXt/LgtIHGAn
	 tjI1w546awVyQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] svcrdma: wake sq waiters when the transport closes
Date: Fri, 22 May 2026 14:13:57 -0400
Message-ID: <20260522181358.412998-1-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21812-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,meta.com:email,oracle.com:email]
X-Rspamd-Queue-Id: AFB855B8E33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

Threads parked in svc_rdma_sq_wait() on sc_sq_ticket_wait or
sc_send_wait can hang indefinitely in TASK_UNINTERRUPTIBLE state
across transport teardown, pinning svc_xprt references and
blocking svc_rdma_free().

The close path sets XPT_CLOSE before invoking xpo_detach and both
wait_event predicates include an XPT_CLOSE term, but the
predicates are re-evaluated only on wakeup. sc_sq_ticket_wait has
no completion-driven wake path; it is advanced solely by the
chained ticket handoff inside svc_rdma_sq_wait() itself. Without
an explicit wake at close, parked threads never observe
XPT_CLOSE, hold their svc_xprt_get reference forever, and
svc_rdma_free() blocks on xpt_ref dropping to zero.

Two close entry points reach this transport. Local teardown runs
svc_rdma_detach() from svc_handle_xprt() -> svc_delete_xprt() ->
xpo_detach() on a worker thread. A remote disconnect arrives at
svc_rdma_cma_handler(), which calls svc_xprt_deferred_close():
that sets XPT_CLOSE and enqueues the transport but does not
access either RDMA waitqueue, so a worker already parked in
svc_rdma_sq_wait() never re-evaluates its predicate. With every
worker parked on this transport, no thread is available to run
the local teardown either, and the wake site there is
unreachable.

Introduce svc_rdma_xprt_deferred_close(), a thin svcrdma wrapper
that calls svc_xprt_deferred_close() and then wakes both
sc_sq_ticket_wait and sc_send_wait. Convert the svcrdma producers
that called svc_xprt_deferred_close() directly:
svc_rdma_cma_handler(), qp_event_handler(),
svc_rdma_post_send_err(), svc_rdma_wc_send(), the sendto drop
path, the rw completion error paths, and the recvfrom flush and
read-list error paths.

Wake both waitqueues from svc_rdma_detach() as well. The
synchronous svc_xprt_close() path (backchannel ENOTCONN, device
removal via svc_rdma_xprt_done) reaches detach without flowing
through svc_xprt_deferred_close() and therefore does not invoke
the new helper.

Fixes: ccc89b9d1ed2 ("svcrdma: Add fair queuing for Send Queue access")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
[ cel: add svc_rdma_xprt_deferred_close() to complete the fix ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h          |  1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  4 ++--
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |  6 ++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  6 ++---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 30 ++++++++++++++++++++++--
 5 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 4ba39f07371d..5aadb47b3b0e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -328,6 +328,7 @@ extern int svc_rdma_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 				   unsigned int length);
 
 /* svc_rdma_transport.c */
+extern void svc_rdma_xprt_deferred_close(struct svcxprt_rdma *rdma);
 extern struct svc_xprt_class svc_rdma_class;
 #ifdef CONFIG_SUNRPC_BACKCHANNEL
 extern struct svc_xprt_class svc_rdma_bc_class;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 19503a12d0a2..fe9bf0371b6e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -383,7 +383,7 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_recv_err(wc, &ctxt->rc_cid);
 dropped:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -1010,7 +1010,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		if (ret == -EINVAL)
 			svc_rdma_send_error(rdma_xprt, ctxt, ret);
 		svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
-		svc_xprt_deferred_close(xprt);
+		svc_rdma_xprt_deferred_close(rdma_xprt);
 		return ret;
 	}
 	return 0;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index cca8ec973de4..c535e6de9654 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -304,7 +304,7 @@ static void svc_rdma_reply_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_reply_err(wc, &cc->cc_cid);
 	}
 
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -336,7 +336,7 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	 * some of the outgoing RPC message. Signal the loss
 	 * to the client by closing the connection.
 	 */
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -381,7 +381,7 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	 */
 	svc_rdma_cc_release(rdma, cc, DMA_FROM_DEVICE);
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index eceefd21bec8..7f6d17bf8c1f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -438,7 +438,7 @@ int svc_rdma_post_send_err(struct svcxprt_rdma *rdma,
 			   int sqecount, int ret)
 {
 	trace_svcrdma_sq_post_err(rdma, cid, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 
 	/* If even one WR was posted, a Send completion will
 	 * return the reserved SQ slots.
@@ -480,7 +480,7 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 	else
 		trace_svcrdma_wc_send_flush(wc, &ctxt->sc_cid);
 	svc_rdma_send_ctxt_put(rdma, ctxt);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 }
 
 /**
@@ -1201,7 +1201,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	svc_rdma_send_ctxt_put(rdma, sctxt);
 drop_connection:
 	trace_svcrdma_send_err(rqstp, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
+	svc_rdma_xprt_deferred_close(rdma);
 	return -ENOTCONN;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f99cd6177504..7ca71741106b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -98,10 +98,27 @@ struct svc_xprt_class svc_rdma_class = {
 	.xcl_ident = XPRT_TRANSPORT_RDMA,
 };
 
+/**
+ * svc_rdma_xprt_deferred_close - Close an RDMA transport (deferred)
+ * @rdma: transport to close
+ */
+void svc_rdma_xprt_deferred_close(struct svcxprt_rdma *rdma)
+{
+	svc_xprt_deferred_close(&rdma->sc_xprt);
+
+	/* Release parked sc_sq_ticket_wait and sc_send_wait waiters.
+	 * Once XPT_CLOSE is observed each returns -ENOTCONN.
+	 */
+	wake_up_all(&rdma->sc_sq_ticket_wait);
+	wake_up_all(&rdma->sc_send_wait);
+}
+
 /* QP event handler */
 static void qp_event_handler(struct ib_event *event, void *context)
 {
 	struct svc_xprt *xprt = context;
+	struct svcxprt_rdma *rdma =
+		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
 	trace_svcrdma_qp_error(event, (struct sockaddr *)&xprt->xpt_remote);
 	switch (event->event) {
@@ -119,7 +136,7 @@ static void qp_event_handler(struct ib_event *event, void *context)
 	case IB_EVENT_QP_ACCESS_ERR:
 	case IB_EVENT_DEVICE_FATAL:
 	default:
-		svc_xprt_deferred_close(xprt);
+		svc_rdma_xprt_deferred_close(rdma);
 		break;
 	}
 }
@@ -341,7 +358,7 @@ static int svc_rdma_cma_handler(struct rdma_cm_id *cma_id,
 		svc_xprt_enqueue(xprt);
 		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
-		svc_xprt_deferred_close(xprt);
+		svc_rdma_xprt_deferred_close(rdma);
 		break;
 	default:
 		break;
@@ -598,6 +615,15 @@ static void svc_rdma_detach(struct svc_xprt *xprt)
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
 
 	rdma_disconnect(rdma->sc_cm_id);
+
+	/*
+	 * Most close paths go through svc_rdma_xprt_deferred_close(),
+	 * which wakes the SQ waitqueues. svc_xprt_close() reaches
+	 * detach without that helper, so wake any threads parked in
+	 * svc_rdma_sq_wait() here as well.
+	 */
+	wake_up_all(&rdma->sc_sq_ticket_wait);
+	wake_up_all(&rdma->sc_send_wait);
 }
 
 /**
-- 
2.54.0


