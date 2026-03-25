Return-Path: <linux-nfs+bounces-20376-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAH3Iqj2w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20376-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:52:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C3327297
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52BA831A5281
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155133EF0CF;
	Wed, 25 Mar 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK6/Z+3E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C1F3E639C;
	Wed, 25 Mar 2026 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449654; cv=none; b=XZO4sgByHysJjkaThgta6SL7DWsSg/zKer4C0770q5WFYSgqlPyEFK7m/71MpYweohKgGq1m2a0wH9fsAAxpvf/iMK2Qe79pLN5+Up75nyY95hkhTLhSfiucwnPd+D61HI2silvsUjhNhAEM4DSuaU99g9iuMiLRJINjuy3R/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449654; c=relaxed/simple;
	bh=W0WCKgToW3dYYaxKd6T2t+Xr1kwru6qNqfGRBso4ZN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TGXXZfytzfcHUTGH5W+Dt9tUslMjP0JLBYITX66Vw8YdvwnsE4fhyDeK5M7+ZBXX1IU9Dh9C66MHfmnkR0mVhkjbW5kWu+lKAP+Um/gsi5nTJ8RHAfM+yZXMuxJcHr1F0OTbEt2/3lDY87O9BGABKVZMKt2Kq7z+O2imMpYVJgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK6/Z+3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31236C4CEF7;
	Wed, 25 Mar 2026 14:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449653;
	bh=W0WCKgToW3dYYaxKd6T2t+Xr1kwru6qNqfGRBso4ZN8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LK6/Z+3Ew2vMzcH9Y3O8/lZZsYXW7Rh/2pzokcbhGGztIwDPFMgaqYwGBwdJS/WCH
	 RWEQ/QPD+5wtuYs1TvrqNQ99UVJacHy/BRMKms5y2BdguIO14MnJTiD6Oq4wAbPGMK
	 1qT1Vy/sBPGE2YRuIDjdhFogWQbFwpgplRo+PlbU0BkJGyJ1iCWvAxYrt7Zw+Cl4Gk
	 pk/c8J7hzPSQf7H+3vGFDh6kP4ZVWEpm5KOH6lhs08Spd/kaB66C9wBAxYrXegYlIl
	 TtKYGXmEWjjVWnnHYrFZRvSAp3RIk27nCXrTlhNBG738L6LZfsBR3KJIi81xZgoa+u
	 qAwsgGLqQ5hdQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:23 -0400
Subject: [PATCH v2 02/13] sunrpc: rename sunrpc_cache_pipe_upcall() to
 sunrpc_cache_upcall()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-2-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=W0WCKgToW3dYYaxKd6T2t+Xr1kwru6qNqfGRBso4ZN8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/Pt/NdiuKiRT8ZjEaqA96P6UIgCysMsOAMHM
 n5klb0qYcCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7QAKCRAADmhBGVaC
 FUicD/9jLPzBHdNptiukdzhjpva4kktYxBVk+kzu8iPD6tVQV94SSZSRSg0DCX6pZqs+oouzZrq
 3nmFQjcug+lC5/uNKazus+/1Dp0rKa3siD1mGZAt61fTv+CIJ0GivUjKHfGiLP3roF+y5Sv5OXi
 60fdKEew1fwtsYqDVqiEpMghQacwbI8HlCLo6xmDqI4BmEwTqCscu2PsoJPMQWcpOUZY6VFDmYq
 wWIAC1hcWI++gUKDJMGe26d9YzN8dZpTwlCL7AZGiKYSi1C5swRvVWm831CErxidk6Z6xnHsXWM
 tv7iU/ZTjXXX3U81JoamYbuR7sKKNlUJefA1TsEe+TD2DEZmD66N9LrkeBEA32Fe+zv99/5nJC1
 dXU8xRpxzIQj6Yfoh+IkRXh96FfY0kwLUhecqWE/eArJX67fXJ3yfgq6T4RsP+ULtQpud5w4Oo6
 nP4u6H2u6Zwz/zVDhu31nRrGq34zoXjyUnigVeicFwgfhoCFomai9ZWFwu47OtzjwtUQHVxfJU5
 kF+91rYTAVmp5dIr8MySGDUq90fdgY8hnjDlDE1thV5u+SxlqAig6VTX+Y2SspLQAfLXsRSR83K
 FYP2QxqFBi4Q86IWlIDjFV5yFLYSgkL/y0vYeV27HqYYsZ80EhGOpp/deEePFCGEZfF/jM466fH
 md9WDqDlhWT+MWw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20376-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 112C3327297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since it will soon also send an upcall via netlink, if configured.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c             | 4 ++--
 include/linux/sunrpc/cache.h | 2 +-
 net/sunrpc/cache.c           | 6 +++---
 net/sunrpc/svcauth_unix.c    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7f4a51b832ef75f6ecf1b70e7ab4ca9da2e5a1dc..e83e88e69d90ab48c7aff58ac2b36cd1a6e1bb71 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -64,7 +64,7 @@ static void expkey_put(struct kref *ref)
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall(cd, h);
+	return sunrpc_cache_upcall(cd, h);
 }
 
 static void expkey_request(struct cache_detail *cd,
@@ -388,7 +388,7 @@ static void svc_export_put(struct kref *ref)
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall(cd, h);
+	return sunrpc_cache_upcall(cd, h);
 }
 
 static void svc_export_request(struct cache_detail *cd,
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index b1e595c2615bd4be4d9ad19f71a8f4d08bd74a9b..981af830a0033f80090c5f6140e22e02f21ceccc 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -189,7 +189,7 @@ sunrpc_cache_update(struct cache_detail *detail,
 		    struct cache_head *new, struct cache_head *old, int hash);
 
 extern int
-sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h);
+sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h);
 extern int
 sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
 				 struct cache_head *h);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 7081c1214e6c3226f8ac82c8bc7ff6c36f598744..4729412ecd72241cb050dbed0ee2863629a8bef4 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1241,13 +1241,13 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	return ret;
 }
 
-int sunrpc_cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
+int sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h)
 {
 	if (test_and_set_bit(CACHE_PENDING, &h->flags))
 		return 0;
 	return cache_pipe_upcall(detail, h);
 }
-EXPORT_SYMBOL_GPL(sunrpc_cache_pipe_upcall);
+EXPORT_SYMBOL_GPL(sunrpc_cache_upcall);
 
 int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
 				     struct cache_head *h)
@@ -1257,7 +1257,7 @@ int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
 		trace_cache_entry_no_listener(detail, h);
 		return -EINVAL;
 	}
-	return sunrpc_cache_pipe_upcall(detail, h);
+	return sunrpc_cache_upcall(detail, h);
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_pipe_upcall_timeout);
 
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 3be69c145d2a8055acd39ff5e0faacb1084936b7..9d5e07b900e11a8f6da767557eb6a46a65a57c26 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -152,7 +152,7 @@ static struct cache_head *ip_map_alloc(void)
 
 static int ip_map_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall(cd, h);
+	return sunrpc_cache_upcall(cd, h);
 }
 
 static void ip_map_request(struct cache_detail *cd,

-- 
2.53.0


