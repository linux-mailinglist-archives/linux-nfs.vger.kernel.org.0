Return-Path: <linux-nfs+bounces-21804-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM/bDJteEGoLWwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21804-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:48:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB155B5760
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 15:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6049C3000FCD
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C96B3D75C3;
	Fri, 22 May 2026 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m52htbsy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8C93FF8AE
	for <linux-nfs@vger.kernel.org>; Fri, 22 May 2026 13:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779457153; cv=none; b=avDPTqtUNApbfoVOjbi9Yw32EZo6RfySydfjirH5nF0MgZDx25bzhcR9g3WzyRBftj/TPk5jpNHOu724wa6BCSzC7MXLn7zOUir0x1OvCzp/vw9SsHD08H9XqxG4GRPDEQVB+Goku+HgedvBGefvfwF2dYJ3n1Z0o9KuXtS/qVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779457153; c=relaxed/simple;
	bh=IcQ16TeRL4XPBVPjQjeO1I5YrMj18EWbXTgOTegEjjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFV8jx1T+mC7XL695j1tpE7fl1+kxtb4lZc2EAQMtfF8E17TLreMlqKQUpjlMgHmjjFWfg+2s+wAqw3EfBO7dl4e1+ZEp9FQPyPTqFGQLYqypbP4Vp8rDVRtECMV3w8WIFqAyOQMtCJqptVkuBXhiPq5vE8aevPjg1xx8tm04WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m52htbsy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085961F000E9;
	Fri, 22 May 2026 13:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779457151;
	bh=dhnveStHr5YYjLFAOKY7x/m7MDZ+17twHizjrDJsIJA=;
	h=From:To:Cc:Subject:Date;
	b=m52htbsyg3dndAokzIUDVyuCiySZD/Q3mGWVcCDLQZHSYI6O0BDVRTitzfaKXkZrD
	 pTldXGVPyoESylhzKLxseucJXARjP6mjuPDuVzGVGF+qy7acpOJHIZbXGb2P6CkVYl
	 9zvkq49V8NngHCQOMDRZS4mGWCMNpVcuyyBjU4GEr3a8rN7wRB88kAxROlyY7bElYv
	 wmy/bpI5/RlMm7rD7qRuNuLa1VBnaZ0xdOJWuZnABc2z+N4hd1YTWn5u8XQN2MWhlU
	 Z64XM6WjGG7hhFw75jhsLVP8qUtMcLCrxleneo/NSOtCCaP0DXHAoUXmwzmTpjV3Xg
	 b7CAvpSjMb8NQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chris Mason <clm@meta.com>
Subject: [PATCH v2 1/2] sunrpc: pin svc_xprt across the asynchronous TLS handshake callback
Date: Fri, 22 May 2026 09:39:06 -0400
Message-ID: <20260522133907.326296-1-cel@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21804-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CFB155B5760
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

svc_tcp_handshake() stores the raw svc_xprt pointer in
tls_handshake_args.ta_data and submits the request through
tls_server_hello_x509(). The handshake core takes only
sock_hold(req->hr_sk); nothing references the embedding struct
svc_sock that svc_tcp_handshake_done() reaches via container_of().

Two close races leave the in-flight callback writing through a freed
svc_sock. svc_sock_free() calls tls_handshake_cancel() and discards
its return value: a false return means handshake_complete() has
already set HANDSHAKE_F_REQ_COMPLETED but hp_done() may not have
finished, yet svc_sock_free() proceeds to kfree(svsk). The
cancel-loser fall-through inside svc_tcp_handshake() itself produces
the same window: when wait_for_completion_interruptible_timeout()
returns <= 0 (timeout or signal) and tls_handshake_cancel() returns
false, the function does not drain, returns, and svc_handle_xprt()
calls svc_xprt_received(), which clears XPT_BUSY and can drop the
last reference. A concurrent close then runs svc_sock_free() while
svc_tcp_handshake_done() is still updating xpt_flags and walking
svsk->sk_handshake_done.

The corruption surfaces as set_bit/clear_bit RMW into the freed
xpt_flags slab slot and as complete_all() walking and writing the
freed wait_queue_head_t list embedded in sk_handshake_done -- a
slab-corruption primitive, not a benign read. The path is reachable
on any TLS-enabled NFS server whenever a connection close overlaps
the tlshd downcall delivery window; the interruptible wait means
signal delivery suffices, not just SVC_HANDSHAKE_TO expiry.

Take svc_xprt_get(xprt) immediately before tls_server_hello_x509()
so the in-flight callback owns its own reference. Release it on the
two edges where the callback is guaranteed not to fire -- submission
failure from tls_server_hello_x509() and a successful
tls_handshake_cancel() -- and at the tail of
svc_tcp_handshake_done() after complete_all().

Fixes: b3cbf98e2fdf ("SUNRPC: Support TLS handshake in the server-side TCP socket code")
Assisted-by: kres (claude-opus-4-7)
Signed-off-by: Chris Mason <clm@meta.com>
[cel: rewrote commit message to describe the actual change]
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 7be3de1a1aed..c8e194fce622 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -471,6 +471,7 @@ static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
 	}
 	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
 	complete_all(&svsk->sk_handshake_done);
+	svc_xprt_put(xprt);
 }
 
 /**
@@ -494,9 +495,13 @@ static void svc_tcp_handshake(struct svc_xprt *xprt)
 	clear_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
 	init_completion(&svsk->sk_handshake_done);
 
+	/* Pin the transport across the asynchronous handshake callback. */
+	svc_xprt_get(xprt);
+
 	ret = tls_server_hello_x509(&args, GFP_KERNEL);
 	if (ret) {
 		trace_svc_tls_not_started(xprt);
+		svc_xprt_put(xprt);
 		goto out_failed;
 	}
 
@@ -505,6 +510,7 @@ static void svc_tcp_handshake(struct svc_xprt *xprt)
 	if (ret <= 0) {
 		if (tls_handshake_cancel(sk)) {
 			trace_svc_tls_timed_out(xprt);
+			svc_xprt_put(xprt);
 			goto out_close;
 		}
 	}
-- 
2.54.0


