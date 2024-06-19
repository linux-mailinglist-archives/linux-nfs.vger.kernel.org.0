Return-Path: <linux-nfs+bounces-4093-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D261A90F79C
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE741C220E2
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C26159204;
	Wed, 19 Jun 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIAuy/RV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EEA158D6C
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829639; cv=none; b=tGcDDHG2gnYXwlhV7B2+cCU/P98POG9mk8MGZQNSRpMz1bCE2yJtGfU9sJ5EiEUmpYSZCL0ofZAReuhJqmU4EcNnjwACbVRYchzU5F1dIz5pOF7CoF/Y9dOk/ETrBEmuF3QZMwsHOMTIVbI7GmfvsrdNAucYrHdKNKYuSCxFrOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829639; c=relaxed/simple;
	bh=tmkERfoTUiJ8+89vv7FT3X2MSkEEVlz9hWozpswzLCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LiXiCC4XAlhFDufQWwH3yccIwwR5OP+1TFY+8AFQDwYotk7Lz5CyNxI2MMGp3s5XwY5Clhn0f8ggH26+ZTG1rNmsepPrl9GZxDcqVnhhOhy1OpE53kOrc7ymrDOdRcjWVWzFhS8qvgwLTM4ULp+Zum7hOmbLXYiGcdbW5ywGwqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIAuy/RV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65966C4AF0A;
	Wed, 19 Jun 2024 20:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829639;
	bh=tmkERfoTUiJ8+89vv7FT3X2MSkEEVlz9hWozpswzLCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIAuy/RVaMBMNI81Pn1DV1od4+xzQkWnac/kPvrN7ksJl/mSbbc+jMId2Ts3Kt8DL
	 Mzf0foQNPk6HJ6Fj9Eiy41LIz2nRJZaXoyqKgJ6iGeiHs2WZ9bCJF19F+k8gS4NhsE
	 AYfbzvGxmnWJ5LEqITrzTxOYzNWDWAjDvXZigmnLfitTp41cyHNU+OmbCthw22W6lN
	 pBxBaEy/Goixgwf9otzrKgujIkJnPTMkQRBAbbO2Mcyb7P8LstSZx15FyzB7WqPOrH
	 CrgieoJNor3pyzhrHe6sDPGgKBHN92AWgoGnL7WaCLknMf+aRfbk4qyUtAH4LnFaCg
	 cqymb3ymw96kg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 04/18] sunrpc: add rpcauth_map_to_svc_cred_local
Date: Wed, 19 Jun 2024 16:40:18 -0400
Message-ID: <20240619204032.93740-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
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


