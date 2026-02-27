Return-Path: <linux-nfs+bounces-19410-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH86MP6ooWm1vQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19410-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:23:58 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062C1B8D45
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41A4931DCEDC
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C629D280;
	Fri, 27 Feb 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dulq7NxO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6F643CEEC
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201038; cv=none; b=vGnjZoP0DKeXcm1DipdQtoPGhWXDi2IPHCTpCPnuXtFqdch1xXAocQwm4N0m6huNbv1UAHl1uoS3zsjo7TS7QKeT3/exM8yCLEtzYzrUQqE7g8X4NgaQrMVfFCb3gMkSOJL/68UvoxWnHKWdyhvlhDMmtGRd1L8O7JAtVF4eF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201038; c=relaxed/simple;
	bh=H7cr6ofeZ9OabP1VVcOpdJauyruXrR8SZa5Lq4V6h68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ENlminUrbRoyCALVx/pYRUZumybpe61GJmQOLyIJ6q0CfR5AyxH9TdF/CS9NrTKmZm/qAayOpO5Nk/tugiLzfsOGwO6yqIQCAcabgdAzNXrGTMdyTr1Qk//65Fw0/uaDT8uU8c5mHhYkYCVwlunTFDQVKHpPGumgsW2C+cqTUR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dulq7NxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00579C19423;
	Fri, 27 Feb 2026 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201038;
	bh=H7cr6ofeZ9OabP1VVcOpdJauyruXrR8SZa5Lq4V6h68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dulq7NxOC4QnAU863wDi9UNUCQpOcznrzPksEPnfNoHFot4guDZ2kWe2/Xc3Fsqgy
	 hsr17Dtmfoa2fq6GT1hxb/u0i2wo9jX0woyEIQ6xQ48isAz84sXw54nlXmsReepNwB
	 h9VT2R+d84QoVi7akwPIewqXf56jNfLVnYSR2KrEoF4BZ3UV43SZZjTT2JOTDfppGR
	 WEubpi1KRsqmigkwZUPZyVHvU9ElErfM1DVLlF/MVTiiuj7HzT6usbAnVVPJsr5iHM
	 ABvGtTJE2r25GPFeWCy953/fMu0TYMZpzSl4uzCB1Wk/tPEt1riDHD0L7N76fCjBzO
	 eSqGWncf1jR4g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 13/18] svcrdma: clear XPT_DATA on sc_read_complete_q consumption
Date: Fri, 27 Feb 2026 09:03:40 -0500
Message-ID: <20260227140345.40488-14-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19410-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3062C1B8D45
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_rdma_wc_read_done() sets XPT_DATA when adding a
completed RDMA Read context to sc_read_complete_q. The
consumer in svc_rdma_recvfrom() takes the context but
leaves XPT_DATA set. The subsequent svc_xprt_received()
clears XPT_BUSY and re-enqueues the transport; because
XPT_DATA remains set, a second thread awakens. That thread
finds both queues empty, accomplishes nothing, and releases
its slot and reservation.

Trace data from a 256KB NFSv3 WRITE workload over RDMA
shows approximately 14 enqueue attempts per RPC, with 62%
returning immediately due to no pending data. The majority
originate from this spurious dispatch path.

After clearing XPT_DATA to acknowledge consumption, the
XPT_DATA state must be recomputed from both queue states.
A concurrent producer may call llist_add and then
set_bit(XPT_DATA) between this consumer's llist_del_first
and the clear_bit, causing clear_bit to erase the producer's
signal. An smp_mb__after_atomic() barrier after clear_bit
pairs with the implicit barrier in each producer's llist_add
cmpxchg, ensuring llist_empty rechecks observe any add whose
set_bit was erased. This barrier requirement applies at both
call sites: the new sc_read_complete_q path and the
pre-existing sc_rq_dto_q "both queues empty" path.

A new helper svc_rdma_update_xpt_data() centralizes this
clear/barrier/recheck/set pattern to ensure both locations
maintain the required memory ordering.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 33 ++++++++++++++++---------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 45edf57c7285..54545fcd8762 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -917,6 +917,25 @@ static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
 	trace_svcrdma_read_finished(&ctxt->rc_cid);
 }
 
+/*
+ * Recompute XPT_DATA from queue state after consuming a completion. A
+ * concurrent producer may have called llist_add and then set_bit(XPT_DATA)
+ * between this consumer's llist_del_first and the clear_bit below, causing
+ * clear_bit to erase the producer's signal. The barrier pairs with the
+ * implicit barrier in each producer's llist_add so that the llist_empty
+ * rechecks observe any add whose set_bit was erased.
+ */
+static void svc_rdma_update_xpt_data(struct svcxprt_rdma *rdma)
+{
+	struct svc_xprt *xprt = &rdma->sc_xprt;
+
+	clear_bit(XPT_DATA, &xprt->xpt_flags);
+	smp_mb__after_atomic();
+	if (!llist_empty(&rdma->sc_rq_dto_q) ||
+	    !llist_empty(&rdma->sc_read_complete_q))
+		set_bit(XPT_DATA, &xprt->xpt_flags);
+}
+
 /**
  * svc_rdma_recvfrom - Receive an RPC call
  * @rqstp: request structure into which to receive an RPC Call
@@ -965,6 +984,8 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	node = llist_del_first(&rdma_xprt->sc_read_complete_q);
 	if (node) {
 		ctxt = llist_entry(node, struct svc_rdma_recv_ctxt, rc_node);
+
+		svc_rdma_update_xpt_data(rdma_xprt);
 		svc_xprt_received(xprt);
 		svc_rdma_read_complete(rqstp, ctxt);
 		goto complete;
@@ -975,17 +996,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	} else {
 		ctxt = NULL;
 		/* No new incoming requests, terminate the loop */
-		clear_bit(XPT_DATA, &xprt->xpt_flags);
-
-		/*
-		 * If a completion arrived after llist_del_first but
-		 * before clear_bit, the producer's set_bit would be
-		 * cleared above. Recheck both queues to close this
-		 * race window.
-		 */
-		if (!llist_empty(&rdma_xprt->sc_rq_dto_q) ||
-		    !llist_empty(&rdma_xprt->sc_read_complete_q))
-			set_bit(XPT_DATA, &xprt->xpt_flags);
+		svc_rdma_update_xpt_data(rdma_xprt);
 	}
 
 	/* Unblock the transport for the next receive */
-- 
2.53.0


