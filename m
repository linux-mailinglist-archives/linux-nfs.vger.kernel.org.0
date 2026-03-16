Return-Path: <linux-nfs+bounces-20211-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNQ3D/QguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20211-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:40 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 617FC29C447
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEAC7303A267
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E51C3A6B7E;
	Mon, 16 Mar 2026 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HukQ+yGp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC23A0B1C
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674227; cv=none; b=KCIfWv7mcs/DrJ4A8iATN644Gwsj2n7lD9pP1Jifhut/tLCs4ODPsd9lYI6MshpmIS9QOXZ+QEiuZ9K0P66MH2f35KBwEDp40hiJSXOwmvamBf8zjOpUQtcweUBsDK44dYo5jatN7946GRYjJWmngRILgHZplkTbaWM8hc6DhLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674227; c=relaxed/simple;
	bh=I4uBVcx8FSgS4psUNqHj5/Dpd/xkvsY1z39PDwrHgT0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6eho4D8kgDWiZDe8JxMDpfhii0OfjyPltUCvQvdUadpyz7QPVfimEgrtUIqHLI20RJMH7TtT5x47Hr7NMDjgWwHoWJApK51AcMNaW9y6Q1vOAVzyVHVzQUnsoLioM1CwLgWrhBK0pjVUk+9RfAXCgzw1imhSaddRjsVLBY3/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HukQ+yGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88274C19421;
	Mon, 16 Mar 2026 15:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674226;
	bh=I4uBVcx8FSgS4psUNqHj5/Dpd/xkvsY1z39PDwrHgT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HukQ+yGpFr/xcb4pQiCUDAf+i5RHYjK4TjekxroXj95l/D5s4dLEOgYhG36HK1ng0
	 B9IQUxKGog2SIDUOaMQXA4QyiUokJGOVPh+i8ZAu/ZIhevD4pF561yStRNCp47U3Dm
	 iuobATZ0r6YSGTkxciciOJmKCVnroeujClyLEsQxpfrymtUU0KYnMpsdEWFC62PZan
	 2Af+eSeJ+MncL6wFPXRuWl8Fe5z2yWZ7y6aAe4q0ikuvUyCTXkvoLERgCo15uqlIgZ
	 GREpDYCiMvwhz40OqpV60cwXYa5tpv8f/MV0ZGksBwYJIrFb87//4RKIO9SuQMPbUp
	 s/kTMs2XnDnZg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:50 -0400
Subject: [PATCH nfs-utils 12/17] support/export: check for pending requests
 after opening netlink sockets
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-12-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=I4uBVcx8FSgS4psUNqHj5/Dpd/xkvsY1z39PDwrHgT0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7iIfeQO6b88WdVevh11k3LmL00l1xOmmo1R
 9A7qU4qp+GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4gAKCRAADmhBGVaC
 FYuZD/9d3Jd04TWThzqxAYUmkBgVYBDWu2DIL+47IqGO3rI/abZ4IJXK/Y9ikQwT5dZLgmY/U2j
 QlPK4WLB+z3Mtp4pshe+xDI2aalsk7SHbFGcuKxShT6T0SfV7JLDOh4xrYZN5hvSbx21I2njSvh
 g1l0sSRMsf24PsOZyh9jvtMKb2MJtxkEderk2WeZFgIRVLj6lzRDC+pWEJhpQG6u2r+uYrZqig7
 PEzOV/LSFy8nLmQiQdvRK89QICLrNMr8WCDAZ1XwKH4W3bWJ8a5EI0S2ydHHbyGWmvXrt18pD+f
 mIT4qcYzo9A0f4mIuDJBuwjpJN7PJri6Rf2oAREPY87fLLB0pq8G+RgASix7Zt9RjQkqwAEvxO1
 d+clVSidYxS3j2MXDBLkN4pK3z6Kcbo1fuqYcZ1OY2W8X6qgqFweIoBJRx/XpxmVjN/Kbdr5UjM
 eUgSMR3mXpQTFBhwXI7BMF3cXu5rrg8L1vtLJVhASZRoli3D9kbh+5IUBQKvoYKRk9EdNCKwVd2
 RvkiYiDmDpzHmRZuuKlRJWUOlRybUGyp/ntNzbRLpYcbXDMfZfedsBKh8uItMvGbEuHWq8lm5p5
 YbJTNqM2sEEoLt/ieTpFAeBWU0r9LmeSKnSkhxiABf0xuqu5IgghncQYwcrzpMf/aJ4S+c9QsfR
 ghdFjCmNG5GL3JA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20211-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 617FC29C447
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

It's possible for there to be requests queued before mountd comes
online. Always check for already-pending requests after opening netlink
sockets.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 19cfbf6594b0a51d85814460f3153add89aa3a8a..4261e1861215ea53183dd8ce14890b0195d841e8 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -3014,8 +3014,19 @@ void cache_open(void)
 	int i;
 
 	if (cache_nfsd_nl_open() == 0) {
-		if (cache_sunrpc_nl_open() == 0)
+		if (cache_sunrpc_nl_open() == 0) {
+			/*
+			 * Check for pending requests, in case any
+			 * were queued before we opened the socket.
+			 */
+			auth_reload();
+			cache_nl_process_export();
+			cache_nl_process_expkey();
+			cache_nl_process_ip_map();
+			if (manage_gids)
+				cache_nl_process_unix_gid();
 			return;
+		}
 		xlog(L_NOTICE, "sunrpc netlink family unavailable, falling back to /proc");
 		nl_socket_free(nfsd_nl_notify_sock);
 		nfsd_nl_notify_sock = NULL;

-- 
2.53.0


