Return-Path: <linux-nfs+bounces-3660-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B43A904957
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 05:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2706FB22744
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2024 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BE91DDEB;
	Wed, 12 Jun 2024 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuRNMMUB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E503C1D6A5
	for <linux-nfs@vger.kernel.org>; Wed, 12 Jun 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161680; cv=none; b=GrNtYy+CMr6Sm/HUCQnE0hwm7HyWqLUH1IQmKDYXOx8CUWDyl1xIHfmOlSyFgbRf1pwpO9+rTVF/teI6HhruC8W//cdWaMRm5Dw8je3eAhqAn23+jnQQl6O7Z1DnVDLF3r544ysFlX7KKI7zH9DBc9nx2DxztOYkO8XesIu4Czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161680; c=relaxed/simple;
	bh=vFT0uYJpz+sxIxJhT3VxHIZ3AQfAlFMvKRk7QsI9K+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CvgC5/6tYQBcQ87/HTHNCtWwPWdM4eoTDqG4XJmPu4JTr1tBLDGHuj+E67OtnCyolZ4O5DltgkenCouVBVwoN8CDiwq2TxieOpnwj1WI9FIAAUItdUrRvuVhmp8U1rqbMBZTgsjD+I9SXh+5cqEjPSU2P+LwSkm9yKu0i4TvXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuRNMMUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414D1C2BD10;
	Wed, 12 Jun 2024 03:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161679;
	bh=vFT0uYJpz+sxIxJhT3VxHIZ3AQfAlFMvKRk7QsI9K+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tuRNMMUBp3GR0UK5IGD7cmwmU1P7tqan6GeyZnPiN5CBJBOBjh6O8c46aYJfR/6Nn
	 XV4nutyeu9ew+c5P8h4MqD0TUbYWqj7mfyYKGspEpXP1VLisI9LJckBqI3eg20qf+5
	 bWQYf9uGYbdYqyUCOMJuhVUMCpcgAJlV4qbVpzMg9o0GoXnzs0SBGwGX1Y7FPgaVo9
	 mQzpuCPw4ByAreh9D9tv3J+sA5t4rs5JneE/WrqxWujYZkFNdPOGDvvj9W3l7rNSEZ
	 4GofwTSc70B7DuE3B5mWZ+pOW4cksojh3W6qSqpKtf+fb59jrNLYTqwue9VRs/DWhf
	 UEOuQHdJlJvAg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [RFC PATCH v2 04/15] sunrpc: add rpcauth_map_to_svc_cred_local
Date: Tue, 11 Jun 2024 23:07:41 -0400
Message-ID: <20240612030752.31754-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240612030752.31754-1-snitzer@kernel.org>
References: <20240612030752.31754-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add new funtion rpcauth_map_to_svc_cred_local which maps a generic
rpc_cred to an svc_cred suitable for use in nfsd.

This is needed by the localio code to map nfs client creds to nfs
server credentials.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/auth.h |  4 ++++
 net/sunrpc/auth.c           | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 61e58327b1aa..f8b561cf78ab 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -11,6 +11,7 @@
 #define _LINUX_SUNRPC_AUTH_H
 
 #include <linux/sunrpc/sched.h>
+#include <linux/sunrpc/svcauth.h>
 #include <linux/sunrpc/msg_prot.h>
 #include <linux/sunrpc/xdr.h>
 
@@ -184,6 +185,9 @@ int			rpcauth_uptodatecred(struct rpc_task *);
 int			rpcauth_init_credcache(struct rpc_auth *);
 void			rpcauth_destroy_credcache(struct rpc_auth *);
 void			rpcauth_clear_credcache(struct rpc_cred_cache *);
+bool			rpcauth_map_to_svc_cred_local(struct rpc_auth *,
+						      const struct cred *,
+						      struct svc_cred *);
 char *			rpcauth_stringify_acceptor(struct rpc_cred *);
 
 static inline
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 04534ea537c8..f75728922d57 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -308,6 +308,23 @@ rpcauth_init_credcache(struct rpc_auth *auth)
 }
 EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
 
+bool
+rpcauth_map_to_svc_cred_local(struct rpc_auth *auth, const struct cred *cred,
+			      struct svc_cred *svc)
+{
+	svc->cr_uid = cred->uid;
+	svc->cr_gid = cred->gid;
+	svc->cr_flavor = auth->au_flavor;
+	if (cred->group_info)
+		svc->cr_group_info = get_group_info(cred->group_info);
+	/* These aren't relevant for local (network is bypassed) */
+	svc->cr_principal = NULL;
+	svc->cr_gss_mech = NULL;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(rpcauth_map_to_svc_cred_local);
+
 char *
 rpcauth_stringify_acceptor(struct rpc_cred *cred)
 {
-- 
2.44.0


