Return-Path: <linux-nfs+bounces-22012-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wPfOCoEIF2oo1wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22012-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:06:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B73735E689B
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9C835307244D
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D8D346ACC;
	Wed, 27 May 2026 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfmqbNz1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A5426EC1;
	Wed, 27 May 2026 15:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894024; cv=none; b=p0TfiBnchOOjXxYAx/9QETqNy4OTN1A5x/3uFmnUbXpvsIkjnWd/Cv6Q0r2CO5bJkXNZJq663/ISpEK8HrDyfBQEKzuHg3EdQRo1Jabb+YV5STjowRgsRfLYkGoAKgyYfsU5maBfCcZvMaBXbUmKWrYYNcdtBwkiBCa/s3Oz7LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894024; c=relaxed/simple;
	bh=Ig2E+xB6/d1uKxMRO1YmF7fVtBz79m0HL+k/daNVnOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Si+A0d/2clzXNxbD8LMvRkzhYS2MJEIJ6TQtiLDsGxdwT7c6yFnpx4c/hIvTSjrJRY+QwCBKOAn2I1u+Bb6DD3y1/USvCz/ZkV/NuAT2/lnR4Aw9nvaBbN37Bc+KbLzCfyo46SIUbQhKLtm3vzGhI2uUY/0hNaCWoaj0ujHp3nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfmqbNz1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164D11F00A3E;
	Wed, 27 May 2026 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894022;
	bh=7Vul4q6CJBDKHMvGqAT1wnfR9cKfeLcV2cPai8VO3NI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JfmqbNz1d4Ta6mB/Zz4SkXGg7IIy4/e65oEzR5LrC9IUS/6AttiQlWJYW1lI8Xewt
	 c2X3tqfLIarA4WxCopXpXbDhZwOObLzk+RfUKQ+H5H3VpJacXtLSuLc+yiS0JGQYQU
	 47nWH9yqxeTLdsekbjdeGWSG8ChEbMrUbKBa/idLUdeqkksYTVTDFP1ZQoxqNZ5xW2
	 qtmbVqSHiZ4N9m8vEpqawEj/ziKmLMCFfEGndHf+cP9+TN6uuzdLGhGHGnjYQOy5t+
	 uS7awTig+U1Nd41kYOxGu/AA+r/es7uQM9b4GTZtxxKtJx+g2eV5Gh9mjEELdN8GEq
	 U0QmevQx6nJ8A==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:11 -0400
Subject: [PATCH 1/5] svcrdma: Fix unmatched rn_unregister on failed accept
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-rdma-follow-on-v1-1-1b09bd87b6cd@oracle.com>
References: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
In-Reply-To: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chris Mason <clm@meta.com>, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=6275;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=sKz70iJDbMZIDqsIah5lW/Z6TPm3JtQ2opK/qnIceGI=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFwcEaR0ofkwkUJ+NrQhgWvlhWGUoF5BQH6JIP
 S+Ry69Mk4qJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahcHBAAKCRAzarMzb2Z/
 l6D3EACeFuag3ZhK4HrjB1wxJXsCuGHr0ZETyJp2rhAit0q55rCv5kAAwN4QGhjIR/GmxshRg5y
 JxRDgHzf8ulvO4+mpRwPPuwLAK3+JbOO+1yPFO6ey8Gh6CU9pcOriKfcdOufRaVID+kowZvFAgy
 PmCm/CAjxpTIhSFFrZlcO+treGeI0+ILwCF6Ol/zwcf+9j7ty2TQKY/4fVeZP6FshSzHzL6NBZP
 PzgUGzWL9H/MLFemaxNoV3Oa67FsUno6Q7jOpdPRui8FggYsDHAg8ftEIYGhq7GPIiCfkgBhpLw
 lK8shNkdFY2rMBjQDyLEZt+bRF5TeAvFeS7ARvnnTe4tszV+nmfHtOLOoqWooz07kVDP0U7RA0T
 GdUU8R0yKqNdAgSZycu3n1NzxDinGuu6Y7MyXIrbOktLDiG1m8hEZxMZOi/7x74Zv8eR4RnM4JO
 jygmNp8TuSZC+PMFWiJ0BpE5LlfSqIOFdYz78p3WBQN8J9npDqOnZtz2lSEelAXbz3pajC0TwaN
 k79ZOXYvCDc+6pjamIRDwd8ghMbAtkislq0wPnKhfMGNBhHqQVjOjOXfBFTiUf/gb6tMxYkqoXD
 2Hi/f4NsysRNeSeiaYDkJrgzOV9eyNB8lyRXtiOyGRzh9zxuGiI0C0HJ2ITAF/fUlMf80ObN1EZ
 ZPMuJYzkT4RRYNw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22012-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email,meta.com:email]
X-Rspamd-Queue-Id: B73735E689B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

When svc_rdma_accept() takes the errout path before
rpcrdma_rn_register() has succeeded, the existing cleanup block
calls rpcrdma_rn_unregister(dev, &newxprt->sc_rn) unconditionally.
svcxprt_rdma is kzalloc'd, so on that path sc_rn.rn_index is 0 and
sc_rn.rn_done is NULL; the unregister therefore xa_erase()s another
caller's slot 0 and performs an unmatched kref_put() on the
rpcrdma_device's rd_kref.

The same errout also brackets the cleanup with svc_xprt_get()/
svc_xprt_put() around the kref_init() birth reference. The kref
goes 1 -> 2 -> 1 and never reaches 0, so the svcxprt_rdma (and the
net/ns_tracker it pinned) is leaked on every failed accept.

rpcrdma_rn_register() writes rn->rn_done last, only after xa_alloc()
and kref_get() have both succeeded, so rn_done == NULL is a natural
"never registered" sentinel. Guard rpcrdma_rn_unregister() with an
early return when rn_done is NULL, and clear rn_done before the
matching xa_erase() so a repeated unregister is also a no-op.

With that guard in place, the accept errout drops the kref_init()
birth reference via svc_xprt_put(), which dispatches svc_rdma_free().
Teardown of sc_qp, sc_sq_cq, sc_rq_cq, and sc_pd runs under existing
IS_ERR/NULL guards in svc_rdma_free(); sc_rn is covered by the new
rn_done sentinel; sc_cm_id is non-NULL on every errout path because
svc_rdma_accept() dereferences it above the first goto errout.

svc_xprt_free() drops the module reference associated with the freed
transport, and svc_handle_xprt() drops its pre-acquired reference
when ->xpo_accept() returns NULL. Take a replacement module reference
before svc_xprt_put() so the two module_put()s remain balanced.

The rn_done guard also covers svc_rdma_free()'s non-listener call
to rpcrdma_rn_unregister() for transports whose register attempt
failed or never ran.

Fixes: 8ac6fcae5dc0 ("svcrdma: Unregister the device if svc_rdma_accept() fails")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/ib_client.c          | 24 +++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 28 +++++++++++++++++++++-------
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/ib_client.c b/net/sunrpc/xprtrdma/ib_client.c
index de49ad02053d..69166d5d9987 100644
--- a/net/sunrpc/xprtrdma/ib_client.c
+++ b/net/sunrpc/xprtrdma/ib_client.c
@@ -51,7 +51,11 @@ static struct rpcrdma_device *rpcrdma_get_client_data(struct ib_device *device)
  * to be invoked when the device is removed, unless this notification
  * is unregistered first.
  *
- * On failure, a negative errno is returned.
+ * On failure, a negative errno is returned. rn->rn_done is left
+ * NULL on every failure path (it is assigned only after xa_alloc
+ * and kref_get have both succeeded), so the @rn may safely be
+ * passed to rpcrdma_rn_unregister() without a separate
+ * registered/unregistered flag in the caller.
  */
 int rpcrdma_rn_register(struct ib_device *device,
 			struct rpcrdma_notification *rn,
@@ -83,6 +87,10 @@ static void rpcrdma_rn_release(struct kref *kref)
  * rpcrdma_rn_unregister - stop device removal notifications
  * @device: monitored device
  * @rn: notification object that no longer wishes to be notified
+ *
+ * It is safe to call this on an @rn whose registration never
+ * completed or failed; rn_done == NULL is treated as
+ * never-registered and the call is a no-op.
  */
 void rpcrdma_rn_unregister(struct ib_device *device,
 			   struct rpcrdma_notification *rn)
@@ -92,6 +100,20 @@ void rpcrdma_rn_unregister(struct ib_device *device,
 	if (!rd)
 		return;
 
+	/*
+	 * rn_done is the registration sentinel: rpcrdma_rn_register
+	 * assigns it last, after xa_alloc and kref_get have both
+	 * succeeded. A NULL rn_done means this notification was
+	 * never registered (or its registration failed) or has
+	 * already been unregistered, and the call is a no-op.
+	 * Without this guard, rn_index == 0 from a kzalloc'd
+	 * parent would erase another caller's slot 0 and underflow
+	 * rd_kref.
+	 */
+	if (!rn->rn_done)
+		return;
+	rn->rn_done = NULL;
+
 	trace_rpcrdma_client_unregister(device, rn);
 	xa_erase(&rd->rd_xa, rn->rn_index);
 	kref_put(&rd->rd_kref, rpcrdma_rn_release);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 7ca71741106b..9268b6105a74 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -43,6 +43,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -598,13 +599,26 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	return &newxprt->sc_xprt;
 
  errout:
-	/* Take a reference in case the DTO handler runs */
-	svc_xprt_get(&newxprt->sc_xprt);
-	if (newxprt->sc_qp && !IS_ERR(newxprt->sc_qp))
-		ib_destroy_qp(newxprt->sc_qp);
-	rdma_destroy_id(newxprt->sc_cm_id);
-	rpcrdma_rn_unregister(dev, &newxprt->sc_rn);
-	/* This call to put will destroy the transport */
+	/*
+	 * Drop the kref_init birth reference. svc_xprt_free will
+	 * dispatch xpo_free = svc_rdma_free, which tears down sc_qp,
+	 * sc_sq_cq, sc_rq_cq, and sc_pd under existing IS_ERR/NULL
+	 * guards, and sc_rn under the rn_done sentinel guard inside
+	 * rpcrdma_rn_unregister.
+	 *
+	 * sc_cm_id is destroyed unconditionally by svc_rdma_free; that
+	 * is safe here because sc_cm_id is non-NULL by caller invariant
+	 * on every path that reaches this errout: handle_connect_req
+	 * installs newxprt->sc_cm_id before queueing the new xprt for
+	 * accept, and svc_rdma_accept has already dereferenced it above
+	 * the first goto errout.
+	 *
+	 * svc_handle_xprt() drops its pre-acquired module reference when
+	 * ->xpo_accept() returns NULL. Take a replacement reference before
+	 * freeing @newxprt, because svc_xprt_free() drops the module
+	 * reference associated with @newxprt.
+	 */
+	__module_get(newxprt->sc_xprt.xpt_class->xcl_owner);
 	svc_xprt_put(&newxprt->sc_xprt);
 	return NULL;
 }

-- 
2.54.0


