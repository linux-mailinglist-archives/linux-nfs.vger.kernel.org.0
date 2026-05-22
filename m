Return-Path: <linux-nfs+bounces-21805-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EZNI3deEGoLWwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21805-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:47:35 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E75745B5721
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33A97306E512
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD54A3FF8AE;
	Fri, 22 May 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2B65TDQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A43A63E3
	for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 13:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457153; cv=none; b=c8BKQVFZ6DJBgF4WKf66/r2qvi6483Y+BffZMhxSGlDBT0Ao4hsLZhWcRfjAq1vr1Kg8RZ8az1/RyuIHbcVfxmdoQ2sF4Z/maumvn+aN1YLaxCv5HNpdBTRpcafXNLFiFGmU2v3vvbCe7mI4z2mUEZJDuujx8Af7sA8oHW4RDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457153; c=relaxed/simple;
	bh=pBAEff7qGvfLZbBD4lMd2IruoYvi4bsUl4YNwNo6xa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dpe3s0eBTAOPSKGZpToxO2Oeei4yyT/Sfojk3x5BTetIeF6fVDSqG+L3hrjagKIis5VEhpzC4Ec1bR2Rj2UUmSHI/1u9G1F4S/qvWPsYy5SMI6cLV4peUQ0y/3uDVVyvfRqwbMcqQKZK1hDy/Elv8rdW3KGrQ7CrIt2DMRtWXD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2B65TDQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8C91F00A3F;
	Fri, 22 May 2026 13:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457152;
	bh=VrSBg3rVtqyxziO8ftCqlkqg7u+10HkjEqfK5M4dki0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y2B65TDQT0b3+NZtgTDANaMY6Nc5A63S7xsRcZNBx66arugCaxzh8VIJdqi+8/J7F
	 IjhIQhDsXOgiHnh2NvtgGQObTEu5ZFVawE1eFSlMvIQifShUCWV+gTbPDAo9nr9Lhu
	 Wqw0vLi2/scDNfJAVOxCt2HKvNHHxCTKLJomzB0Y8OYIgl1JqiN9JV7/uy+Wj77Rwf
	 qlQTeO2ehW82uH3Dt7L6NASaD3dDHZomMxrkjny9cvaTMoG11QUxx2vpnkxxjE/Rj6
	 gtV6RP+v3GNL7hCbn6Fyg0PqcBAfXSNVciZFG1iM/WiUNDo2D+egZss1mS2Tw2/rV6
	 p3IxErYKZsG+w==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 2/2] sunrpc: wait for in-flight TLS handshake callback when cancel loses race
Date: Fri, 22 May 2026 09:39:07 -0400
Message-ID: <20260522133907.326296-2-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522133907.326296-1-cel@kernel.org>
References: <20260522133907.326296-1-cel@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21805-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E75745B5721
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

When wait_for_completion_interruptible_timeout() in
svc_tcp_handshake() returns 0 (timeout) or -ERESTARTSYS (signal) and
tls_handshake_cancel() then returns false, handshake_complete() has
won the cancellation race: it has set HANDSHAKE_F_REQ_COMPLETED and
is about to invoke svc_tcp_handshake_done(), but the callback's
side effects on xpt_flags and on svsk->sk_handshake_done have not
yet committed.

The current code reads xpt_flags immediately to decide whether the
session succeeded. Two races result.

If the callback has executed set_bit(XPT_TLS_SESSION) but not yet
clear_bit(XPT_HANDSHAKE), svc_tcp_handshake() sees a session,
enqueues the transport, and returns. svc_xprt_received() then
clears XPT_BUSY, a worker thread picks the transport up, the
dispatcher in svc_handle_xprt() observes XPT_HANDSHAKE still set,
and xpo_handshake is invoked a second time. That svc_tcp_handshake()
calls init_completion(&svsk->sk_handshake_done) while the original
callback concurrently calls complete_all() on it, corrupting the
embedded swait_queue.

If the callback has set HANDSHAKE_F_REQ_COMPLETED but not yet
entered svc_tcp_handshake_done(), svc_tcp_handshake() reads
XPT_TLS_SESSION as clear and tears the connection down even though
the handshake is about to succeed.

Wait for the callback to commit before inspecting xpt_flags. The
completion is guaranteed to fire because handshake_complete()
invokes svc_tcp_handshake_done() unconditionally once it has set
HANDSHAKE_F_REQ_COMPLETED.

Fixes: b3cbf98e2fdf ("SUNRPC: Support TLS handshake in the server-side TCP socket code")
Closes: https://sashiko.dev/#/patchset/20260522014850.206768-1-cel%40kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index c8e194fce622..eb747493db82 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -513,6 +513,10 @@ static void svc_tcp_handshake(struct svc_xprt *xprt)
 			svc_xprt_put(xprt);
 			goto out_close;
 		}
+		/* Cancellation lost to handshake_complete(): the
+		 * callback is in flight and should finish quickly.
+		 */
+		wait_for_completion(&svsk->sk_handshake_done);
 	}
 
 	if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags)) {
-- 
2.54.0


