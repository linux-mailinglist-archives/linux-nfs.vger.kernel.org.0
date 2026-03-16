Return-Path: <linux-nfs+bounces-20187-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN0XJcEfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20187-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 369D229C2AD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 430C0309E2BD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CABA3A0B26;
	Mon, 16 Mar 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ7rGU+k"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278D53A0E80;
	Mon, 16 Mar 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674115; cv=none; b=HO2yGOeXobmDtkR13OMflMRik4efngPKt45cDVw8vS7C7uNVj6jxr/jcam0CfgFjLkD50P+9lm0pMR/+Gm7DLo5nPlSQEa5xIKlxoG837WXf1s+adSRcR9cwYkUDGkWFSSoNG/UldabrnDou3Byigfle/jW9Gz3MJvPY3JHDgy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674115; c=relaxed/simple;
	bh=zt2/sd0q9/IbNJ/McsmnmQOqytwxOWzYyjmVxUWCOTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uRUgYGLYA72JNquBwb48p+M/65/LsKMq6D5lo8hW59FlbLTyyvImbNXnmv0Sqf0qSAaZK0bfBq7vGwCMYKFFYxEeCCuBsbXxZz5ImnUcbN+jj8yBCHwAbxi/So5vuF/YO16jBgnfJnH48RVzTqa5SanpQHXJCu5ysY+y3O3R1uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ7rGU+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB467C19425;
	Mon, 16 Mar 2026 15:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674114;
	bh=zt2/sd0q9/IbNJ/McsmnmQOqytwxOWzYyjmVxUWCOTg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nJ7rGU+k4LrBVsBrLjfECqHKESvwMyMiJZjUO9HseahPvgZl/hIttvEM8lON1scen
	 sJhdqGEfDmxuHykKILXNL+sIEmq0NoT6Ij4VFgBvxEgfsxnWJTiB2wctMA5rbDX7+1
	 enbtvNG+Gv/itTSbv1VTJ+LzOn5sgFdqnUEPxAUi7tVYqKt/hk4Pqi3cPVZcm19DRK
	 Y1BXgQft9koTk0HsRJDf2QgOCA6ECA8MhgpOZ0Wx9SqHpCMln1sJYfJlZhOARq28Hj
	 NsACova4XxTolgODbbSq+9ET4LYBZuy4lunzTMCoLyg0tos7yjXgLzfUJDfuGKC0TW
	 5tyJUwtqAh52w==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:37 -0400
Subject: [PATCH 03/14] sunrpc: rename sunrpc_cache_pipe_upcall_timeout()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-3-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=zt2/sd0q9/IbNJ/McsmnmQOqytwxOWzYyjmVxUWCOTg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB57+kbFQkQ3C7Pi5mFFn7vMhq/xLT9dvlGI5
 US3sYPhiquJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgeewAKCRAADmhBGVaC
 FR+uD/0YoV/R4gu4rAAbNl0GXIyuLqG9S0eQUFI8AfwixNN2Cf540AEQVcMFYR+RSWFdcEgmlUq
 6HQqoszrCLlwjmL0wTXznEs7SmqoI33kiWORWM5X23cRkK6rkMI4JOeXrrUhofInjsJTZKkelau
 BtIm7RAcmkiU0BpH56t3CnofwW6XbdCq18lz6dUIvfI2lBRjrre0CjNZfzOL3s3LCWkrf3hg5mT
 JOarikZi6014KxEjfur/96pOeRGYQR3WoAYRTkiNc6NeZER0XuWwtcqcyrsBI0nvzzuIkIGrSvq
 g79+yne2f6DGhJiFdzf6YHyn0tkWw1TVaXFz9DRoV1DT9wyZnWloaKgJdTxVY2swe1wZWDzmrj1
 7BZ791OZJrlcJKcJf7VLI6J2j1CevplcUYtYsz/QAQivymYZK5MN8xazGk/3bB3Ze4BQsjEojyU
 BRwDpSRwSNTHyC5j5TKtLcu1Cwelq49I+IfIypyVkCLQeQzst2sOF7kfnaej5pHw2yOrhhoBa+L
 d//KsBwCb0OYxWJgfpF5eLoPwZSXX0PIqWwccZhvvSqr5vQ/ZnjKI0hNbxON4yD+MxfW2Kz3aPe
 M4Q0M3Nme9uyFGc/HfsFYh+a2PqF9/zCoaEYL90edICZvDkTQQqIeslbIRz7y5xwVBHDdOD4EPl
 i3FhxyN8hBBkPSw==
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
	TAGGED_FROM(0.00)[bounces-20187-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 369D229C2AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This function doesn't have anything to do with a timeout. The only
difference is that it warns if there are no listeners. Rename it to
sunrpc_cache_upcall_warn().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/dns_resolve.c              | 2 +-
 fs/nfsd/nfs4idmap.c               | 4 ++--
 include/linux/sunrpc/cache.h      | 2 +-
 net/sunrpc/auth_gss/svcauth_gss.c | 2 +-
 net/sunrpc/cache.c                | 6 +++---
 net/sunrpc/svcauth_unix.c         | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/dns_resolve.c b/fs/nfs/dns_resolve.c
index 2ed2126201f4185fa9d6341f661e23be08d422ea..acd3511c04a6c74301c393e05e39aa8fcd52b390 100644
--- a/fs/nfs/dns_resolve.c
+++ b/fs/nfs/dns_resolve.c
@@ -156,7 +156,7 @@ static int nfs_dns_upcall(struct cache_detail *cd,
 	if (!nfs_cache_upcall(cd, key->hostname))
 		return 0;
 	clear_bit(CACHE_PENDING, &ch->flags);
-	return sunrpc_cache_pipe_upcall_timeout(cd, ch);
+	return sunrpc_cache_upcall_warn(cd, ch);
 }
 
 static int nfs_dns_match(struct cache_head *ca,
diff --git a/fs/nfsd/nfs4idmap.c b/fs/nfsd/nfs4idmap.c
index ba06d3d3e6dd9eeb368be42b5d1d83c05049a70c..71ba61b5d0a3aacfc196e8d3aa3c06b00fe0765b 100644
--- a/fs/nfsd/nfs4idmap.c
+++ b/fs/nfsd/nfs4idmap.c
@@ -126,7 +126,7 @@ idtoname_hash(struct ent *ent)
 static int
 idtoname_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+	return sunrpc_cache_upcall_warn(cd, h);
 }
 
 static void
@@ -306,7 +306,7 @@ nametoid_hash(struct ent *ent)
 static int
 nametoid_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+	return sunrpc_cache_upcall_warn(cd, h);
 }
 
 static void
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 981af830a0033f80090c5f6140e22e02f21ceccc..80a3f17731d8fbc1c5252a830b202016faa41a18 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -191,7 +191,7 @@ sunrpc_cache_update(struct cache_detail *detail,
 extern int
 sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h);
 extern int
-sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
+sunrpc_cache_upcall_warn(struct cache_detail *detail,
 				 struct cache_head *h);
 
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 161d02cc1c2c97321f311815c0324fade1e703fe..d14209031e1807e4ec19de44a2829d48e81e4d6c 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -206,7 +206,7 @@ static struct cache_head *rsi_alloc(void)
 
 static int rsi_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+	return sunrpc_cache_upcall_warn(cd, h);
 }
 
 static void rsi_request(struct cache_detail *cd,
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 5553a1182c9b8d0d9c8b2be9e9b1bed5bfa58057..5e36f6404400aea5700d0893c00b6d69c1ec128e 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1255,8 +1255,8 @@ int sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h)
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_upcall);
 
-int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
-				     struct cache_head *h)
+int sunrpc_cache_upcall_warn(struct cache_detail *detail,
+			     struct cache_head *h)
 {
 	if (!cache_listeners_exist(detail)) {
 		warn_no_listener(detail);
@@ -1265,7 +1265,7 @@ int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
 	}
 	return sunrpc_cache_upcall(detail, h);
 }
-EXPORT_SYMBOL_GPL(sunrpc_cache_pipe_upcall_timeout);
+EXPORT_SYMBOL_GPL(sunrpc_cache_upcall_warn);
 
 /*
  * parse a message from user-space and pass it
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 9d5e07b900e11a8f6da767557eb6a46a65a57c26..87732c4cb8383c64b440538a0d3f3113a3009b4e 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -467,7 +467,7 @@ static struct cache_head *unix_gid_alloc(void)
 
 static int unix_gid_upcall(struct cache_detail *cd, struct cache_head *h)
 {
-	return sunrpc_cache_pipe_upcall_timeout(cd, h);
+	return sunrpc_cache_upcall_warn(cd, h);
 }
 
 static void unix_gid_request(struct cache_detail *cd,

-- 
2.53.0


