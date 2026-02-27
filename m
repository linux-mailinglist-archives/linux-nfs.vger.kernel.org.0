Return-Path: <linux-nfs+bounces-19413-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iA7YLHimoWmivQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19413-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F21B8879
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B1C5030EE1B1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85959413237;
	Fri, 27 Feb 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HL7L/Vwb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D18413224
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201041; cv=none; b=J9aujvKxkjB8j3mR/OZtZdh6yNF3jevQmSjUQ1p5NYia+9rTsjoiGr5QjRWhXXV8Uw5LEWOD12Fj5h0TUMhew2dnTC9k/PMtTssoHiZnKwNOcIdhiDiGUe96Ov+Ktv5PxLetwUk/ZyAPAbs9Po/ums3/bUjOgsdmNEe98JzEZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201041; c=relaxed/simple;
	bh=V81B/ANI+9mC2RgoYz+9iFMrifbJjiz2wbafSndLrTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ui+6X+dqjyPgwZhjtGPIuL0/F5F3wu6l5qOMD9ExlfhUfPefrxYfR9sbxAUpLaxMvlhMGc5XCWoD+RD44ZBy960/CwYQP3nlAxlK2N8Rj18KXT/97jCc9XDO6h1kUnOklEh87xye5C3dW4pg5LdGfyQH0Jn1sC4QOmhMF+9YP68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HL7L/Vwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA2C2BC86;
	Fri, 27 Feb 2026 14:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201041;
	bh=V81B/ANI+9mC2RgoYz+9iFMrifbJjiz2wbafSndLrTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HL7L/Vwbdm4b/LCKqJYk/M2CscdlBYcH2jgY154SjgkLa/YyWff6LSMaut2iTmaAn
	 KTrKWKG8/uvL3ui5euW/ptWsoSl33E65SWyrOMJlyAjpyrEJBY3TFPOD1RTat3SF9K
	 +Y5+6MAuLoJ7ECWvVPl5AhakJO8717HLsNS9F1GjjXUYQfSJnIQT7VTnQOSY7jo9zt
	 Zj7XAuqw05QrqpavhlGQtJxDtu77xytcrrXfpcadKznymVt0xeXqSoY2fqC/BMG2+K
	 hu8/zY5Z9dR834nqzM4T+0BPb/GEBzz56GDSZ5O/hWiEfagAwWAdC7GVPKBHtvWGRd
	 4zmYkEBbesw9A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 16/18] sunrpc: skip svc_xprt_enqueue when no work is pending
Date: Fri, 27 Feb 2026 09:03:43 -0500
Message-ID: <20260227140345.40488-17-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19413-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B6F21B8879
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

svc_reserve() and svc_xprt_release_slot() call
svc_xprt_enqueue() after modifying xpt_reserved or
xpt_nr_rqsts. The purpose is to re-dispatch the
transport when write-space or a slot becomes available.
However, when neither XPT_DATA nor XPT_DEFERRED is
set, no thread can make progress on the transport and
the enqueue accomplishes nothing.

Trace data from a 256KB NFSv3 WRITE workload over RDMA
shows 11.2 svc_xprt_enqueue() calls per RPC. Of these,
6.9 per RPC lack XPT_DATA and exit svc_xprt_ready()
immediately after executing the smp_rmb(), READ_ONCE(),
and tracepoint. svc_reserve() and svc_xprt_release_slot()
account for roughly five of these per RPC.

A new helper, svc_xprt_resource_released(), checks
XPT_DATA | XPT_DEFERRED before calling
svc_xprt_enqueue(). The existing smp_wmb() barriers
are upgraded to smp_mb() to ensure the flags check
observes a concurrent producer's set_bit(XPT_DATA).
Each producer (svc_rdma_wc_receive, etc.) both sets
XPT_DATA and calls svc_xprt_enqueue(), so even if the
check reads a stale value, the producer's own enqueue
provides a fallback path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 56a663b8939f..73149280167c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -425,13 +425,28 @@ static bool svc_xprt_reserve_slot(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 	return true;
 }
 
+/*
+ * After a caller releases write-space or a request slot,
+ * re-enqueue the transport only when there is pending
+ * work that a thread could act on. The smp_mb() pairs
+ * with the smp_rmb() in svc_xprt_ready() and orders the
+ * preceding counter update before the flags read so a
+ * concurrent set_bit(XPT_DATA) is visible here.
+ */
+static void svc_xprt_resource_released(struct svc_xprt *xprt)
+{
+	smp_mb();
+	if (READ_ONCE(xprt->xpt_flags) &
+	    (BIT(XPT_DATA) | BIT(XPT_DEFERRED)))
+		svc_xprt_enqueue(xprt);
+}
+
 static void svc_xprt_release_slot(struct svc_rqst *rqstp)
 {
 	struct svc_xprt	*xprt = rqstp->rq_xprt;
 	if (test_and_clear_bit(RQ_DATA, &rqstp->rq_flags)) {
 		atomic_dec(&xprt->xpt_nr_rqsts);
-		smp_wmb(); /* See smp_rmb() in svc_xprt_ready() */
-		svc_xprt_enqueue(xprt);
+		svc_xprt_resource_released(xprt);
 	}
 }
 
@@ -525,10 +540,10 @@ void svc_reserve(struct svc_rqst *rqstp, int space)
 	space += rqstp->rq_res.head[0].iov_len;
 
 	if (xprt && space < rqstp->rq_reserved) {
-		atomic_sub((rqstp->rq_reserved - space), &xprt->xpt_reserved);
+		atomic_sub((rqstp->rq_reserved - space),
+			   &xprt->xpt_reserved);
 		rqstp->rq_reserved = space;
-		smp_wmb(); /* See smp_rmb() in svc_xprt_ready() */
-		svc_xprt_enqueue(xprt);
+		svc_xprt_resource_released(xprt);
 	}
 }
 EXPORT_SYMBOL_GPL(svc_reserve);
-- 
2.53.0


