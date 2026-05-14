Return-Path: <linux-nfs+bounces-21623-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMjKHvY2BmqWgQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21623-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9862546D99
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 22:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 411DD303C7C8
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2026 20:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACFD3C196F;
	Thu, 14 May 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPKvetl5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8864E3F4121
	for <linux-nfs@vger.kernel.org>; Thu, 14 May 2026 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778792175; cv=none; b=N+eQljsOerrrDrGagnBw18XJc7KoLiXJwwMyMwbgsFNQu1bA/c2/OaidqhoH3w8uTYsXrgUgpss1k5EDqlY5fO3GovYPepazEn3r9TX1QDFgcBLXx9+w7uP41p5PKtfcvUSPWqu9LexPr2jFA1wBa2FuWWltVgUfWXvEoeBQEA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778792175; c=relaxed/simple;
	bh=LEUBIiNlhIwLVoS07r7CEgQFYEL3sJFAgY7Ax/ZODxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dx8gUP4Xv2PCaPEqojVn3ec3D//M/JP5GnVFNoYBT4Ng3NnegdFS5Q35aDKjlGaVb/sEajSxazi8ccDlwWkdfDywgWeilhRRaH/9ycfxY0L/u6eUEbHWpJIZzlJTxSlTgdhE2d6DtB2oTcfGNRK1t0zF/PX/eI4rRYqzkmkBRzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPKvetl5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0EBC2BCC7;
	Thu, 14 May 2026 20:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778792175;
	bh=LEUBIiNlhIwLVoS07r7CEgQFYEL3sJFAgY7Ax/ZODxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nPKvetl58vEjZSxV/Zlw/Yoy63uh2A2Hdsfv27rweQnkkC3zlaH1MPPCcLz6qFBAF
	 ddoV223chiotplCk56VWxn1H8GVJNWi/sUtmmyBMgiqjZQ4d+iSwNMceVrP3fEU+0E
	 3dKZI8pgqVv9YI7uT8S+NoaTYg3MvTRlOeMdSNQExrZqR7omPy+57Ml4Ewfe/A7cdm
	 XD2C+uZB1yECFvE01l4w3tnAM9zaoqeX0LkjS983QUgW0KP4kzxwhL+0NkDewiWDo1
	 oqGtSRXXxtmwvj0i+Tz+v0+NaJMGeITyYEmX1LTUY9E+4Q7RpVw6hkrZt9+qqYIBPb
	 txGU4FozYk8bw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] tls: Preserve sk_err across recvmsg() when data has been copied
Date: Thu, 14 May 2026 16:56:05 -0400
Message-ID: <20260514205607.348291-3-cel@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514205607.348291-1-cel@kernel.org>
References: <20260514205607.348291-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9862546D99
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21623-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The sk_err check in tls_rx_rec_wait() consumes the error via
sock_error(), which clears sk_err atomically. When the caller
(tls_sw_recvmsg, tls_sw_splice_read, or tls_sw_read_sock) already
has bytes copied to userspace, it returns those bytes and discards
the error from this call. sk_err is now zero on the socket, so the
next read syscall observes only RCV_SHUTDOWN and reports a clean
EOF instead of the actual error (typically -ECONNRESET).

The race is reachable when tls_read_flush_backlog()'s periodic
sk_flush_backlog() triggers tcp_reset() in the middle of a
multi-record read.

Pass a has_copied flag to tls_rx_rec_wait(). When has_copied is
false, consume sk_err via sock_error() as before. When has_copied
is true, report the error from READ_ONCE() but leave sk_err set:
the caller returns the byte count and discards the err from this
call, and the next read syscall surfaces the preserved sk_err. This
mirrors the tcp_recvmsg() preserve-and-surface pattern.

The decrypt-abort path is unaffected: tls_err_abort() raises
sk_err to EBADMSG after tls_rx_rec_wait() returns, and nothing
on the caller's return path consumes it, so the EBADMSG surfaces
on the next read.

tls_sw_splice_read() passes has_copied=false: it processes
one record per call, so no bytes have been copied within the
function when tls_rx_rec_wait() runs. A reset that arrives
between iterations of splice_direct_to_actor() (the sendfile()
path) is still consumed by sock_error() in the later call, and the
outer loop returns the prior iterations' byte count and drops the
error. tcp_splice_read() exhibits the same pattern at the iteration
boundary; addressing it belongs at the splice_direct_to_actor()
layer and is out of scope here.

Fixes: c46b01839f7a ("tls: rx: periodically flush socket backlog")
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2590e855f6a5..c4cc4e357848 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1356,9 +1356,14 @@ void tls_sw_splice_eof(struct socket *sock)
 	mutex_unlock(&tls_ctx->tx_lock);
 }
 
+/* When has_copied is true the caller has already moved bytes to
+ * userspace. Report sk_err but leave it set so the next read
+ * surfaces it instead of a spurious EOF, otherwise sk_err is
+ * consumed via sock_error().
+ */
 static int
 tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
-		bool released)
+		bool released, bool has_copied)
 {
 	struct tls_context *tls_ctx = tls_get_ctx(sk);
 	struct tls_sw_context_rx *ctx = tls_sw_ctx_rx(tls_ctx);
@@ -1376,8 +1381,11 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 		if (!sk_psock_queue_empty(psock))
 			return 0;
 
-		if (sk->sk_err)
+		if (sk->sk_err) {
+			if (has_copied)
+				return -READ_ONCE(sk->sk_err);
 			return sock_error(sk);
+		}
 
 		if (ret < 0)
 			return ret;
@@ -1413,7 +1421,7 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
 	}
 
 	if (unlikely(!tls_strp_msg_load(&ctx->strp, released)))
-		return tls_rx_rec_wait(sk, psock, nonblock, false);
+		return tls_rx_rec_wait(sk, psock, nonblock, false, has_copied);
 
 	return 1;
 }
@@ -2100,7 +2108,7 @@ int tls_sw_recvmsg(struct sock *sk,
 		int to_decrypt, chunk;
 
 		err = tls_rx_rec_wait(sk, psock, flags & MSG_DONTWAIT,
-				      released);
+				      released, !!(decrypted + copied));
 		if (err <= 0) {
 			if (psock) {
 				chunk = sk_msg_recvmsg(sk, psock, msg, len,
@@ -2287,7 +2295,7 @@ ssize_t tls_sw_splice_read(struct socket *sock,  loff_t *ppos,
 		struct tls_decrypt_arg darg;
 
 		err = tls_rx_rec_wait(sk, NULL, flags & SPLICE_F_NONBLOCK,
-				      true);
+				      true, false);
 		if (err <= 0)
 			goto splice_read_end;
 
@@ -2373,7 +2381,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			struct tls_decrypt_arg darg;
 
-			err = tls_rx_rec_wait(sk, NULL, true, released);
+			err = tls_rx_rec_wait(sk, NULL, true, released, !!copied);
 			if (err <= 0)
 				goto read_sock_end;
 
-- 
2.54.0


