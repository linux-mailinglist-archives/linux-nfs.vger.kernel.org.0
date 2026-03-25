Return-Path: <linux-nfs+bounces-20377-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKt5K6/3w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20377-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:56:47 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3930B32742A
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF6031EFDB3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229A03E8C68;
	Wed, 25 Mar 2026 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmmckKiX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9473EFD25;
	Wed, 25 Mar 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449655; cv=none; b=KCu2+dUSnm5sjrYfHHhy0nezd/rwXKF6+wVt+9DYjjwOmzPGDnBfWjf2EWyNAzTo0K5yzFDbJ7A0k1rs8U6dnaLtNh+ngbKx6lECuDoYpuggbulzBeG1ICr7MItbcPiBAg0ZY1C8Jy4kDpNb6+b3tk3aXwYEASe0b1S8pT4PKeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449655; c=relaxed/simple;
	bh=7BXop0Fp9UyPm/+D9R6GkrQSaUlGooUSVMVmxCMPli4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfI7t9qcDriIgMZeU1S6FvZjyJoeYn8nGKtsRYlgcPnh+CdNVjW+mtiBfElaS2HcC+XfC1ELw6nUT92n9lrP7CBsounuhLUc5krqUs75UQhN1u7kzIfLBGOF5Mx3touKcNLIb0zk7qw8Pg844xORWLcf1ltbxFyK5j8powegifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmmckKiX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA542C116C6;
	Wed, 25 Mar 2026 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449655;
	bh=7BXop0Fp9UyPm/+D9R6GkrQSaUlGooUSVMVmxCMPli4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AmmckKiX6xiCFXxwHVYKE+UqSit1gsPLrE/hObogoZHof27XgchuaZCDYc+CmoYW3
	 2S2LW8pi6Qcz9E0MDOvbUyuXaT8eFEOpjcUCyfRn1mvD/8fvfH1POv89QIW4w4ASdi
	 w1W03hftfBaF5xmhQrC42u/EFJo2ag0rEFS6pDRWfGx8jYESn7F7LGdU9JpgMgAhkG
	 6LHymTKN1WKmZZ4nVq80ZY4MqQ0x4AYxjZgFn1khJ8hXEa+u/60XSe/u8b3n/Tt+Nc
	 rmLKX5Uz20pY3CQ1fw1p9q91CGj+k8Y/ZexjMbj9SzyCzsHNGyZY6gVJeL83dbmJhQ
	 y5h3xhCabM4QQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:24 -0400
Subject: [PATCH v2 03/13] sunrpc: rename sunrpc_cache_pipe_upcall_timeout()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-3-067df016ea95@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4376; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7BXop0Fp9UyPm/+D9R6GkrQSaUlGooUSVMVmxCMPli4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/Pt+jgSD4Kh3oSApgx1OTUEuzDfU/XcBJgvM
 lvC+vIbYheJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7QAKCRAADmhBGVaC
 FTLCEAC/pcWyPX2M5PmGYPtuuF1sHNuRJiH6W/fb8lVaciRQRh34hsjoBwYgdhNXc1jADhLYfq0
 c8sWarYyJ1vpS5gIhblbCC4LF5XL5buI+O9uGZKCgl4cuEocvtkf7bRWsjFQofX1sZBrtVfw6mC
 FYxyUhuL11pWR2qj0dGHW3eX5KCCf/ovpHr7rsI5boVZc+cwynaYhFudAw3PMlZT1p1mZHOxJgY
 Kd/k6mus5mpT2y0cmKeKoeTZVUUWIJyfF3rK673ZX7kU26cDRyGwLXQlNHNZC9tTHc0hXEj/6rn
 tyZOJDkf0pvE41WSdj1VzwWGPtnIDsXgTY7qEQligcTNmSoS6zc3KGOw/GKY3CX+ECWNtlvGv3O
 HwK6mJEJ8o5KnwMzyn9W3Cwhovuh+0/mGTpYiN02jHaCZ1qAU1QxPUwfVNVJaljJLQI4jTIEWWh
 O1BhhXL3d8nYxdne62p273vLdI+3SBEEq6OsQ8GbpecBKEvR7ZM999soOkpQ8RZe1jdQFBj2Dkt
 nXyhfghV9P8JpIpMTQ5ISVfg1wdukKjjihrpWz2OEsmGJkQqS9x8MO320xAxHCML+4dXO2E3NSa
 pcJ5CtR/DCbmpUfe9xywvrCQ548ccRgndCJumrTf4Ms+wKiiEOfHQVnPKPLKGWh8pAj58xEMxqu
 I/TspdLNZ44pGsg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20377-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3930B32742A
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
index 4729412ecd72241cb050dbed0ee2863629a8bef4..1b97102790f6642fa649ad6aab94fcba8158fa8e 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1249,8 +1249,8 @@ int sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h)
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_upcall);
 
-int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
-				     struct cache_head *h)
+int sunrpc_cache_upcall_warn(struct cache_detail *detail,
+			     struct cache_head *h)
 {
 	if (!cache_listeners_exist(detail)) {
 		warn_no_listener(detail);
@@ -1259,7 +1259,7 @@ int sunrpc_cache_pipe_upcall_timeout(struct cache_detail *detail,
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


