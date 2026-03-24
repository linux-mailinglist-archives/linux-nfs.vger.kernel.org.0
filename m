Return-Path: <linux-nfs+bounces-20351-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WD3IOLaOwmnDewQAu9opvQ
	(envelope-from <linux-nfs+bounces-20351-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 14:16:38 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D0B309277
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352AF31C7EA4
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1DE390999;
	Tue, 24 Mar 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl5JZKrh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B9A241665
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357495; cv=none; b=BfA913y4VaOwYYzxrgsB2RlR1UeoVACFtRETdKCZmBeItvMbvCb9RkPnV4lPwvF8KWqvlo24Xe55TXR+TpznuFocvNFIz2sMU4nmG+zmZF4twUb5SR/IVjo18U/Wo6ifgBs47JuwDfGfra+w8bxqFuxY04LWD84lspOG2jSb9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357495; c=relaxed/simple;
	bh=V81B/ANI+9mC2RgoYz+9iFMrifbJjiz2wbafSndLrTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2Wzcr1WLpxumIuCqS/qgkNF2U5QzuEUnYposAORLBOdSys9hSca55kaQkQ7r6yCngz9+G50xFmi973TFHayOLZmwYRmQdraN+m4/iLYwbesCY/BektH+C5X+wtXEAnAxo66r4VJny5QkWL5ZWuWBYNiMqz/S/xlv0Acwx3qhh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl5JZKrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F5FC2BCB4;
	Tue, 24 Mar 2026 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774357495;
	bh=V81B/ANI+9mC2RgoYz+9iFMrifbJjiz2wbafSndLrTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gl5JZKrhdmK6YyaI+p5EDi04ey6x00bS5T0xvpmStA6VD+19HphZwBrcxnrCni7y6
	 HCwoRqwbaWRLwf4ikYtFgpKr+5Z+ozVBP6u9vc+otGZs8/lyc1CpNcymOzeceJsKQ+
	 IaBimSVRG5gGOCy1fhZbO6HcdWTOaNrkhkgQVb1+mVgBDjmrhmdY8P5WOL4xnT9VdB
	 KEWaezI9P1nnDUK5EATGtrKd8B5NAItQcr41TWjJriczIfbZdDVcuDo557U3K8bivn
	 bV8VOJlOjRov982ZGqxt2cDGm1YikDCLXp8xp73jbNsGGv7EUiKWSUUXSJ2iga5fBp
	 D6uiSXgnqP4Kg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 1/3] sunrpc: skip svc_xprt_enqueue when no work is pending
Date: Tue, 24 Mar 2026 09:04:47 -0400
Message-ID: <20260324130449.16437-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324130449.16437-1-cel@kernel.org>
References: <20260324130449.16437-1-cel@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20351-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 69D0B309277
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


