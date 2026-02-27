Return-Path: <linux-nfs+bounces-19414-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK9hDnymoWmqvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19414-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:16 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BAA1B888F
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 15:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77B1E30EF324
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Feb 2026 14:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6881643DA2E;
	Fri, 27 Feb 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6ZbxaVp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643F413224
	for <linux-nfs@vger.kernel.org>; Fri, 27 Feb 2026 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772201042; cv=none; b=QhaSM15gkBjiX6RXQKbTm93CIr76+MdwhSiiM1Ev8bL2ScSfrjlSWplXopwJojRwNb7Qs2MQ4g13NvwAfhhEAQC9v4rzmfmS9/SHw2DNXYn7Hcomrz1csKnDNAF5WuqY3b0IykKLqbrNLTgh6sBdWOif4SJfjFxX+TRrQ3l1bLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772201042; c=relaxed/simple;
	bh=ZQUCoTSOuetgU65z+aORZVWRuQ+TP43ReL9UCzmKKvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJL8gtDhP2UzBtM9LWTIYpnDFA6OH+qNjzdLCf41p/vvxJlfxyrjSgqXJCH/zfLltrRIsMWcnz0ruLbIinplPFm5oDP5B7Kh341DZZ3LjRaF9NvqYIKDxX73qZyAdGVW2XVhTAj3X0e1cONsVxNRHgUiUOQwkf2yk5Lnb9tR6ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6ZbxaVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559E0C116C6;
	Fri, 27 Feb 2026 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772201041;
	bh=ZQUCoTSOuetgU65z+aORZVWRuQ+TP43ReL9UCzmKKvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6ZbxaVp3NIPDE8d7uscypgKB+0zAtz10O0IWJcivrCgmunZjvWKHkqN70ygQB5O/
	 CmyuFdgOCumXjXfAgbTTZWPqIHEoRMLgqqI/Kw3a8rQwgA0JY+CeJjdwklKFl0JQqV
	 bgfaxucJJGClKIHeHf69NKezZqziBFip8n657JkQfF+IJylv+yhyK4WxRWVIpfXWJS
	 DAz1iNAc4uiEWQowJ1+jjur8ugMJ5uJPwS/5kxC4SP3DS/YXbnlpy5ITyuL/cF5eg5
	 h/QqQ3uehc7FN3SvGR15Q7EwkavWDSRMBmrKfTiPiNNuGB3udUjxsXggxvRm1LA8tm
	 MDfXiFmP9qSCA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 17/18] sunrpc: skip svc_xprt_enqueue in svc_xprt_received when idle
Date: Fri, 27 Feb 2026 09:03:44 -0500
Message-ID: <20260227140345.40488-18-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-19414-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5BAA1B888F
X-Rspamd-Action: no action

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


