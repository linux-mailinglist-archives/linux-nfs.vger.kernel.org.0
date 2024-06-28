Return-Path: <linux-nfs+bounces-4387-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C31991C7D5
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F4D51F23429
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jun 2024 21:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79E976C76;
	Fri, 28 Jun 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYUUlSdx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F217603A
	for <linux-nfs@vger.kernel.org>; Fri, 28 Jun 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719609072; cv=none; b=udG8V/gbAspNQS+t88W/BFL10EsuFlRkr/cAbL2lOCOrVrXM7/Sx1h8e2OlgfrmoO8lnE3aBy9N9EEnc+qqfB0nQTzAgngKuJhsVkUpHXLIFaxS4uPY+fPFJTqQhfoSVkoFZW2cKeABiu66/aQeu+1yZZ3Z+WGI2RsQZdFIj/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719609072; c=relaxed/simple;
	bh=tmkERfoTUiJ8+89vv7FT3X2MSkEEVlz9hWozpswzLCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4ecz73XQsJO/X0placCvryjTxURwPLc/gjRnmdYaH/Sjj7u/NnNOgA4ufOyBzD0I4gxyQ5HSjoTnuGlk9EJje4JeIYQrgmOghdxSjLNgYs/1dXfZeGIc9iMf+oX3kflqz94twUvhfGFf6a40RZJ8UBUkQUzHPKND5d7qd29GGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYUUlSdx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A27C116B1;
	Fri, 28 Jun 2024 21:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719609072;
	bh=tmkERfoTUiJ8+89vv7FT3X2MSkEEVlz9hWozpswzLCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uYUUlSdx69eAP9n470fGaJm+6ki8s0Zb8oOr9hag9v+FXp47amN9FjaAU9u+qRVzZ
	 edaXgCXsQFD1A+AS2wdoegQWQl4SJ4uqkxp/7gAUqNBKL2i96TuZKHiqY/Fw10Rxmp
	 tILbGWfw4Qgrl1emw6J3CF/NHmdLYah6RNYOfgy4nUoGuZSCBuagkVQau3r2DzAAwv
	 W2hH/h5P3eIvkXYlvnv0VonKb8RPT3h7jMYZhoqBoIHeGHCehwlOGje7p4I5YlBglq
	 uZ42fH/vYIcp5kiTJr4vKmldNe2ME4MvDylWThrlaYyOXYA2ttag2ahMnqUtiqCtbS
	 z7RC4v6187WRA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v9 04/19] sunrpc: add rpcauth_map_to_svc_cred_local
Date: Fri, 28 Jun 2024 17:10:50 -0400
Message-ID: <20240628211105.54736-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240628211105.54736-1-snitzer@kernel.org>
References: <20240628211105.54736-1-snitzer@kernel.org>
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


