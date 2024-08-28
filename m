Return-Path: <linux-nfs+bounces-5830-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD5C961B26
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D561F2495B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCA516415;
	Wed, 28 Aug 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwOzL4gb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B96A18D
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805892; cv=none; b=fJCLpNp3dISYTUuOWAhdzjwKFH+x4ZgtGZ6vx6SwtfF/zpzQ9WIyiTzEQ9u11TpCin+CT5DVL9w8QHDwUot4hacrzf55GEeqm/wK4GRZRaVFNy8zfQznmL97aSrzvgxcPlO9TkxQTFsGA3THJya6FSpjSusWh1D2N4+8TMTDb2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805892; c=relaxed/simple;
	bh=ut9N99Mf3TfW0dNvgE1WXcpvz+4rjxdLbddrpcSa7IA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uO1Ib6cJg6VoB4mNoN8ZcSPpWJriw8uQzL9EE5HR97ZVxe1SjV3lbrdD+LSE0vY6j82y347T3OrA3dzJUdIXjMNQf6kjb+PdK8/jUjy6FH2m5r0Jnx0xRsPdWBcxiHW0RqlLih5mH8ZQk2tDDWtY7atoc5A9mIYdbDV4lxS/4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwOzL4gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF34C4DDED;
	Wed, 28 Aug 2024 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805892;
	bh=ut9N99Mf3TfW0dNvgE1WXcpvz+4rjxdLbddrpcSa7IA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HwOzL4gbs8NXDcGQXreJDw/caQZwUBSMzJVbgakiMQ92Xvk34Gji/3OfWO69fIKvv
	 7PFkuUzHpPCwsrT9x0ravxEmMyDCEw9p68U5INk4twY9oEIM8rIEr13cnu4erniILd
	 QBjWwxrSY2pGnSb2sEm+EOjetRi2SuLMngfJ1MoCIaFoODKmjKMA+0tcVKf9+F0vlH
	 6T0EwfgGnXXZfK3O2rPfOAiglITBN5cqYIKHtFV/jGw2Js19cYKRIwrcj9NU0w6GFn
	 kdjHhIy/dmpmWaSW9biWT9qqGtRckZQjFU639qZvAoSrdiKAz7u6lWKca/rKW3PV+r
	 FfN8O3pBeSEmw==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>
Subject: [RFC PATCH 1/6] NFSD: Handle @rqstp == NULL in check_nfsd_access()
Date: Tue, 27 Aug 2024 20:44:40 -0400
Message-ID: <20240828004445.22634-2-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240828004445.22634-1-cel@kernel.org>
References: <20240828004445.22634-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neilb@suse.de>

LOCALIO-initiated open operations are not running in an nfsd thread
and thus do not have an associated svc_rqst context.

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7bb4f2075ac5..46a4d989c850 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1074,10 +1074,29 @@ static struct svc_export *exp_find(struct cache_detail *cd,
 	return exp;
 }
 
+/**
+ * check_nfsd_access - check if access to export is allowed.
+ * @exp: svc_export that is being accessed.
+ * @rqstp: svc_rqst attempting to access @exp (will be NULL for LOCALIO).
+ *
+ * Return values:
+ *   %nfs_ok if access is granted, or
+ *   %nfserr_wrongsec if access is denied
+ */
 __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 {
 	struct exp_flavor_info *f, *end = exp->ex_flavors + exp->ex_nflavors;
-	struct svc_xprt *xprt = rqstp->rq_xprt;
+	struct svc_xprt *xprt;
+
+	/*
+	 * The target use case for rqstp being NULL is LOCALIO, which
+	 * currently only supports AUTH_UNIX. The behavior for LOCALIO
+	 * is therefore the same as the AUTH_UNIX check below.
+	 */
+	if (!rqstp)
+		return nfs_ok;
+
+	xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
@@ -1098,17 +1117,17 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 ok:
 	/* legacy gss-only clients are always OK: */
 	if (exp->ex_client == rqstp->rq_gssclient)
-		return 0;
+		return nfs_ok;
 	/* ip-address based client; check sec= export option: */
 	for (f = exp->ex_flavors; f < end; f++) {
 		if (f->pseudoflavor == rqstp->rq_cred.cr_flavor)
-			return 0;
+			return nfs_ok;
 	}
 	/* defaults in absence of sec= options: */
 	if (exp->ex_nflavors == 0) {
 		if (rqstp->rq_cred.cr_flavor == RPC_AUTH_NULL ||
 		    rqstp->rq_cred.cr_flavor == RPC_AUTH_UNIX)
-			return 0;
+			return nfs_ok;
 	}
 
 	/* If the compound op contains a spo_must_allowed op,
@@ -1118,7 +1137,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	 */
 
 	if (nfsd4_spo_must_allow(rqstp))
-		return 0;
+		return nfs_ok;
 
 denied:
 	return nfserr_wrongsec;
-- 
2.45.2


