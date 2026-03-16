Return-Path: <linux-nfs+bounces-20186-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CQyJKkfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20186-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:09 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 334B529C296
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B2F6308C2D8
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB639F177;
	Mon, 16 Mar 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVkc5eZX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96513A0B24;
	Mon, 16 Mar 2026 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674113; cv=none; b=hilkBpyeFXH67/PVI+dGqAlElKGyWzetGPBpcuWvB1JFDvh08IsC9abti600kBcX44ill1fOqHJW8traeTtpURu4/XFujB753OZCk54upabRlY6V9/q8y5HyIBWSOuvx9GU2UlZSrdMNlFyel6wXp4nco92cbUpNwwei8SZ974I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674113; c=relaxed/simple;
	bh=NoO6ZhN61vrVI769RdauWaqike+0l8sHT/NIJRC45ZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rB1XigGO4fcVt8+T6WNh/U4gSHV6ejQ09AMfc+xzrmh9qyZyzSf6dzaDln4ceP3sqzuUr0nmLMpMO2B2dtvmp/fktt4gelHLsfU5rL0Az+yUtLYrg5SI4OXU5MY9GRc43NpGZin31iLSl733Avz5L/E96GM8vAj7Ywh/XjacZTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVkc5eZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDEDC2BCB0;
	Mon, 16 Mar 2026 15:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674113;
	bh=NoO6ZhN61vrVI769RdauWaqike+0l8sHT/NIJRC45ZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OVkc5eZX8Qpw2W8bs8l9ZOXp82/VUvLYB8GBJ28yWYePR/sgllaVNw3MsEa3fLlNn
	 PJ3Ro9AcGumMDRMPRqaE/dBleHXDJ2jmTPDrJeNRF7Nxf/KzgUlBN92GI5g/Wp78lm
	 IHqbue+HhjYX1h7fOLVlxqzlyU610GLzKESJzgYS8UGccJcAqmwhaDiKaTQVRXckqj
	 OHpGKw9SKAGNaEAx8XZQBd1vloCqFMBNf+ZvooL6ZI84nz092D99DKwMpEDuAC5OHp
	 tkSVVyCkhkV6a5uumNQS9Kuccghe2MfRZTWKmCE4YFxJGgYXXu1zGWPKAdO8cJ6TkM
	 10d/mRtBoLW/g==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:36 -0400
Subject: [PATCH 02/14] sunrpc: rename sunrpc_cache_pipe_upcall() to
 sunrpc_cache_upcall()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-2-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=NoO6ZhN61vrVI769RdauWaqike+0l8sHT/NIJRC45ZA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB57/hehqqrJdLZN83YthvxBCLSUSigaK6OhG
 1L3rg0Wq5KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgeewAKCRAADmhBGVaC
 FXE8EACuwMF15qrjMbRPZZj/vqbISL7xnS47Ki+j0EHBEPDkBjJIz4CB+6BkvBiZXy5w2/ov+7g
 LhvpXkz22Wrd/5bi7vH0ep2HHOn74h73l+tzyhKyEK8BO4s+dPTS1dplbQKRnN3y364Rr6WR4q7
 Yknz6nhTfziTaKsGXtziRF5VduDPnP21cFk24dx2gOjHLj+lAvVY0zQPCVQ34Ov4tuf2FwTT0C9
 CD8vJ5c+FxLnb40yh87VTZYkDULngBewpIaWI6McTgEKDJW2bwdpA9gLjnDeIbl9bEzjs70nwH1
 JF9+NFCiB7BBtp9baD7xAvd9RsiutVQYGMvdWaQjDDUm4JvtBrvLQgojLbuIpbfxQc7udyTBOrF
 Dcor4tkuJ6FeWlLrMV3Wm+qnpnrheJmz5pDUTcH0GBh54IWd8axjRYgf9PVtVDJNNWSeL3ByO++
 xcnMZwFLu0NhQ+Ioiw5pr/MDJmNZ7BBWbmbPm4W8MC0MTvEmiWN4X9RKHzxIgXPc720hS1ystqh
 Q3ZPXit5LEu7PswJHhWKP4nbrmoXDVvaHD5RfLeC6oDMRC5iiEjKyqD2PzLdZzj/2orqTe/NtGJ
 jsnkXxg/LM1bRExn0B9iO6K3cx+71TzSO3AGVZHoB9Yxo3W4V5w1fdcae19+S6k9VaV6GqEk/Cm
 fnoRab9qJmhjUVA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20186-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 334B529C296
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
index d5941cc24303d1a80a974a4625a0b91d36da5d3f..5553a1182c9b8d0d9c8b2be9e9b1bed5bfa58057 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1247,13 +1247,13 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
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
@@ -1263,7 +1263,7 @@ int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
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


