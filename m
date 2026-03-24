Return-Path: <linux-nfs+bounces-20352-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNS/L6+PwmkXfAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20352-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 14:20:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD8230940C
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 14:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D9B47306A586
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Mar 2026 13:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E12A3F7E6F;
	Tue, 24 Mar 2026 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTxm1FQf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04B5241665
	for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774357495; cv=none; b=JC6F5ywDXKCsqV32Zs5vF++WgVlwoWNngYo+nQbSKU6t3Wj0BujxEhVrEiWKRfJTZtJhpi2U946iwzhmPeGeF8wj8PcR0FA0pCC+i4UtE3dRwx351sGsTwBa1l4QsNJkPS/hklXGSh3qLgYyj9U4fKGzbyxip5Bb507vAu2kbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774357495; c=relaxed/simple;
	bh=ZQUCoTSOuetgU65z+aORZVWRuQ+TP43ReL9UCzmKKvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KqghU/uLxmkE+G5jYoBHdkSr1eqCr03zfiGv5Jn49i7DAMntB92+C0DPY73WeyftUwaDm7V5yeISjcTzZztHHNBbyXgKjLc8J58AqWsfbWjpGGMbBLf17FgVUxjIEWPikKWB4oLS/sIhDOTT2VnwfgwnvVBPFHKfI0rskuQv2c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTxm1FQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3073FC2BC87;
	Tue, 24 Mar 2026 13:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774357495;
	bh=ZQUCoTSOuetgU65z+aORZVWRuQ+TP43ReL9UCzmKKvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TTxm1FQfOFtNkBjQRTP2XkGwYNyC6vw3FevNua6TTvDshXqy4nO+KDlRNhxZGQbtu
	 irpgg+ns3bukYoESPTZ/Jn5NCz+LdVm/hEbXbp1o0v3FvIIPRIA7PGDQGRj4s7pxNw
	 PjOe+SY6QH33LLi8CMfM9vxbTFBHEg3outZlLSrcX8PfYSEuAVrZHf82vCemd6DMwY
	 0bvh2arADLOo+Hr2MI385xyzWqKAC2L3+7By9I04et3Yeugb1LSLa21/oBwFXDTi22
	 366QDFglZXNG6nTvNXIlUCzsU82CztPc7PM5s+jL5Qj0VbrisqevlDCfn7tvud2pmV
	 CKJsnH+phzakg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 2/3] sunrpc: skip svc_xprt_enqueue in svc_xprt_received when idle
Date: Tue, 24 Mar 2026 09:04:48 -0400
Message-ID: <20260324130449.16437-3-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20352-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: DBD8230940C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

svc_xprt_received() unconditionally calls
svc_xprt_enqueue() after clearing XPT_BUSY. When no
work flags are pending, the enqueue traverses
svc_xprt_ready() -- executing an smp_rmb(), READ_ONCE(),
and tracepoint -- before returning false.

Trace data from a 256KB NFSv3 workload over RDMA shows
85% of svc_xprt_received() invocations reach
svc_xprt_enqueue() with no pending work flags. In the
WRITE phase, 167,335 of 196,420 calls find no work; in
the READ phase, 97,165 of 98,276. Each unnecessary call
executes a memory barrier, a flags read, and (when
tracing is active) fires the svc_xprt_enqueue
tracepoint.

Add a flags pre-check between clear_bit(XPT_BUSY) and
svc_xprt_enqueue(). Both the clear and the subsequent
READ_ONCE operate on the same xpt_flags word, so
cache-line serialization of the atomic bitops ensures
the read observes any flag set by a concurrent producer
before the line was acquired for the clear. If a
producer's set_bit occurs after the clear_bit, that
producer's own svc_xprt_enqueue() call observes
!XPT_BUSY and dispatches the transport.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 73149280167c..36c8437cfd8d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -234,7 +234,19 @@ void svc_xprt_received(struct svc_xprt *xprt)
 	svc_xprt_get(xprt);
 	smp_mb__before_atomic();
 	clear_bit(XPT_BUSY, &xprt->xpt_flags);
-	svc_xprt_enqueue(xprt);
+
+	/*
+	 * Skip the enqueue when no actionable flags are set.
+	 * Each producer both sets its flag (XPT_DATA, XPT_CLOSE,
+	 * etc.) and calls svc_xprt_enqueue(); if a set_bit races
+	 * with this check, the producer's own enqueue observes
+	 * !XPT_BUSY and dispatches the transport.
+	 */
+	if (READ_ONCE(xprt->xpt_flags) &
+	    (BIT(XPT_CONN) | BIT(XPT_CLOSE) | BIT(XPT_HANDSHAKE) |
+	     BIT(XPT_DATA) | BIT(XPT_DEFERRED)))
+		svc_xprt_enqueue(xprt);
+
 	svc_xprt_put(xprt);
 }
 EXPORT_SYMBOL_GPL(svc_xprt_received);
-- 
2.53.0


