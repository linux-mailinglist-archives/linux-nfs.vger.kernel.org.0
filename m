Return-Path: <linux-nfs+bounces-4012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D398C90DD2C
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 22:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF98284E15
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jun 2024 20:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3881741E5;
	Tue, 18 Jun 2024 20:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INkk7jdq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDE51741DA
	for <linux-nfs@vger.kernel.org>; Tue, 18 Jun 2024 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718741996; cv=none; b=idZbhAU2TUg8o6/tPTIkmQYaM/t57daSHdyCJ62EWUCHJmo7DpMHqBRDvofhZRr/wW7dyPpHJcG6YUC0VpEnxhes+KC8ugY+siF3hq3iu5dYhXjMDeofcYjuf4wsFgoU4NU1LwMnY3B3zO4lP6DiTU10PtxiE56lG24MNMgz42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718741996; c=relaxed/simple;
	bh=tmkERfoTUiJ8+89vv7FT3X2MSkEEVlz9hWozpswzLCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGYRgdbxhfd22p33deO7vUB52w7cImKvan8ChZNujUTABAtf9ACIkQWSdu4xrMKY1OsP9jC0cawE/XqigBnvZYaGrB/Bh7fXaROY0EMtbrmEzwPbhsJw/JWEPMPb2W1B2z7kqWfmEiTdF3RrDbLPAGnDCeeStYt4Jpq95Q5UOhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INkk7jdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 632C6C3277B;
	Tue, 18 Jun 2024 20:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718741995;
	bh=tmkERfoTUiJ8+89vv7FT3X2MSkEEVlz9hWozpswzLCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=INkk7jdq46q44wzhN8kEbrF6wka1FrMBa+GlODGvZ/reHqjFLzTlcJBBbA8byvgI5
	 pdCG6O7EkE+jzwjqjZlBcyWi6pPfW0r2CS1eaMGB8D3ax1MwZQJJWO+5YZuICMA/JW
	 oi/ereJ/G1D0ZXAKm7X5t2p/tjexABNe29gdFd2Wb+g/LF4C9qKTjJQH5vke0jje2B
	 BAgU/X1a+KuTX2lcUdSjdEuZmP4yxyW4a6t3A4ZpO9+ue6ln6kQIeAOqy01Oq2BQJ6
	 Pd6nbDGfCzSNN/UzS6iSKEN8U3+RKMsjAwVr6mgT3GDRPcB0zozjMKZ99xXzpIPKAh
	 OtY6vNVcEOOyQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v5 04/19] sunrpc: add rpcauth_map_to_svc_cred_local
Date: Tue, 18 Jun 2024 16:19:34 -0400
Message-ID: <20240618201949.81977-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618201949.81977-1-snitzer@kernel.org>
References: <20240618201949.81977-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

Add new funtion rpcauth_map_to_svc_cred_local which maps a generic
cred to a svc_cred suitable for use in nfsd.

This is needed by the localio code to map nfs client creds to nfs
server credentials.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 include/linux/sunrpc/auth.h |  4 ++++
 net/sunrpc/auth.c           | 15 +++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 61e58327b1aa..872f594a924c 100644
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
+void			rpcauth_map_to_svc_cred_local(struct rpc_auth *,
+						      const struct cred *,
+						      struct svc_cred *);
 char *			rpcauth_stringify_acceptor(struct rpc_cred *);
 
 static inline
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 04534ea537c8..00f12ca779c5 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -308,6 +308,21 @@ rpcauth_init_credcache(struct rpc_auth *auth)
 }
 EXPORT_SYMBOL_GPL(rpcauth_init_credcache);
 
+void
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
+}
+EXPORT_SYMBOL_GPL(rpcauth_map_to_svc_cred_local);
+
 char *
 rpcauth_stringify_acceptor(struct rpc_cred *cred)
 {
-- 
2.44.0


