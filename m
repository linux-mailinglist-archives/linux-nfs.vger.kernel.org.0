Return-Path: <linux-nfs+bounces-21379-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QN4oNu11+GlavgIAu9opvQ
	(envelope-from <linux-nfs+bounces-21379-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 12:33:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4EC4BBC73
	for <lists+linux-nfs@lfdr.de>; Mon, 04 May 2026 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025FB303A902
	for <lists+linux-nfs@lfdr.de>; Mon,  4 May 2026 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453B391E57;
	Mon,  4 May 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVfhBo0f"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166A37DE85;
	Mon,  4 May 2026 10:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890526; cv=none; b=aYGHlGGqqbLce6OQRw90ukOFM8V0uilVL2tjMv5ayvLN/YR7q91hDr2gYv7OZwxUmkoETpzng6lDQjp2wcHH5i7bErapTxByA2ln8dDRXduyiuUWsJFgQaXa1Pf2k66FAW6J2TSw9bQfk9m5chpdGMOhEhn20N8U10HbRJOBjdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890526; c=relaxed/simple;
	bh=c3EP/jNSTpUl4gYMTStdcpwi50hc2vbRXGrWSqt4MfA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eSq0LuxlVIq8ADFKBvYCdJr8gL8m6c3R0/rCvQ9+AgPFmiZN1dNGUveznv4Vb5oSleDiGjj1GAFPVtZFx8HqIfByC+8BMaojDZSqzRDFKHLFfn03UQOR+mOizgrRq/6B22w/JVkvZWOv60J35NV7CIv57/V9brdyzrbJ2uKIagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVfhBo0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7BEC2BCB8;
	Mon,  4 May 2026 10:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777890526;
	bh=c3EP/jNSTpUl4gYMTStdcpwi50hc2vbRXGrWSqt4MfA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XVfhBo0fdyALAL26sIrDGYLMGJdx+Nx+Tk7jcu5RXVzYe6/CHcDVnAiFfSuouswWa
	 mAcvfyaENr6ZVj+zeR6kGfM3bLjlsjhKeHcx6rXJ3BaGjwRJNdTdb2dyykggkmtj0D
	 KFH7AJ778GpZGrcEkHCfHlhXWYE+Q/ky2IbeqlIQaB3TaltQ5ztAoPeGY30BRjCUG/
	 C3nc56O/OTc5Ght4AlVftcffcfqHLeh8f2PBoNBdlgTz9UhjpEZWfTgVzUdVQFtuY4
	 6UnLrD2H0SLO2Fmt+5gKwKIceBIeSe+h2aHCEy+qiNQooRZj2J33IUXw9s27WLRPZC
	 QyEi9dSnWQTkA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 04 May 2026 06:28:18 -0400
Subject: [PATCH 1/2] SUNRPC: release lower rpc_clnt if killed waiting for
 XPRT_LOCKED
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-sunrpc-tls-clnt-pin-v1-1-197f359c6072@oracle.com>
References: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
In-Reply-To: <20260504-sunrpc-tls-clnt-pin-v1-0-197f359c6072@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=S1VOGWFooMQUwyDOWH5mzbgk3Q7RPVAKbbGIwOa9cnQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp+HTYRQbHU4HJ9AA2ZRQFWK8zh79rOBrKtXuQd
 uKbAzgqWBWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafh02AAKCRAzarMzb2Z/
 l5AND/9ulSNp0TrXQ7ewpOd2LMeEopRC5WoEiqyIw7F17JtjpHKG6yjB9XdO9xk+obY8ybhGINf
 olNQvUCwHy+xNMVBAy1j7JpBZQBn8MxKYYZ0tOfDVfhEauWqy+LS1N0tuJuQlAawdSppuCJQOc+
 iWU1NuBG6NjxUZOJzIQa66ufpXOXhGbopIbgOkW37a9J+ja2de3O9jNHP21s0zjN2/+9KDqDWDp
 gwPzj9Zp9o2TND4zBtKtsJDhNcYqCaqtnG3lx1n1IR4L9I9uE3KBviookZCztGneKQGIqEiVlKm
 krAXmI5GxXyM5Z3oXBten4kSFkLFf5A1Ib+kZ16RHhjeONsETiymFA3gdq31/xSZ1UOFAduCz1/
 iubFIGiLWKZQbxWhEIt/lX+kacbKw0M+dq672L+/FvZOAE09d2dBQKlpbpEyraQYrF8YgRhO09c
 YYe7HtVI56N7+dgf3V3PLBUv2AnLvb62uv8cIU+Aan4KgTG1SJ013w4/q64AFdPxnN7MeLr3O3c
 imH3kwqQCRPlncr9HZ895luNXHaxn+zpttjR2RjM5u3zTc2HdHlYuTt0iPeH/lUUCKUZpJMfrwX
 NQBbs31aU3Ng8jIYFwRAkTdeK6x60vX7Gr+YJ8VCg6GXGmH6LG6E7slmy59+3kdbfFBQ5845Nfv
 qqwQsaEdEWJCNsQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 3F4EC4BBC73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21379-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

xs_tcp_tls_setup_socket() creates a temporary "lower" rpc_clnt with
rpc_create() to drive the inner TLS handshake, then waits for
XPRT_LOCKED on its xprt with TASK_KILLABLE so a stuck handshake can
be aborted by signal. When the wait is interrupted, the function
jumps to out_unlock without releasing lower_clnt. The success path
and the out_close error path both call
rpc_shutdown_client(lower_clnt); only the killed-wait path skips it,
leaking the clnt and its underlying xprt.

Call rpc_shutdown_client() on this path before joining out_unlock.
xprt_release_write() is not needed here because XPRT_LOCKED was
never acquired.

Fixes: 26e8bfa30dac ("SUNRPC/TLS: Lock the lower_xprt during the tls handshake")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtsock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 2e1fe6013361..3eccd4923e6c 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2734,8 +2734,11 @@ static void xs_tcp_tls_setup_socket(struct work_struct *work)
 	lower_xprt = rcu_dereference(lower_clnt->cl_xprt);
 	rcu_read_unlock();
 
-	if (wait_on_bit_lock(&lower_xprt->state, XPRT_LOCKED, TASK_KILLABLE))
+	if (wait_on_bit_lock(&lower_xprt->state, XPRT_LOCKED, TASK_KILLABLE)) {
+		/* XPRT_LOCKED was never acquired. */
+		rpc_shutdown_client(lower_clnt);
 		goto out_unlock;
+	}
 
 	status = xs_tls_handshake_sync(lower_xprt, &upper_xprt->xprtsec);
 	if (status) {

-- 
2.53.0


