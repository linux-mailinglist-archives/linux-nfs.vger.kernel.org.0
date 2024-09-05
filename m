Return-Path: <linux-nfs+bounces-6263-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947DA96E2C9
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C51F1F21A82
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D5118CC0A;
	Thu,  5 Sep 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzHAREJV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0D018BC31
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563418; cv=none; b=QFfYMXZWcY0tA+eG7MZZaoKugTK/dIXtPCNEf0r/XyLneqp8oznXyo3cuq7gBuMtCXavp+ZQ6WMPgX/ywiL5NZlUscUS7VbYqh+2g4evjN8oP8jFsWGiwJM7lpta0Gi7kBnkxJB2PgxEFaq6Vjg/XM/Nrj+vavXy1Aksh/1eFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563418; c=relaxed/simple;
	bh=iUatsXEnTmL3rn9cQJVw/n3/YwziO1sK8/B0fwSrp1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiH5vrtL6ruWdleJ8y57A5v+MfIfsGKySZ8gTLuw388qd6SeVF6LMvynRW95fojnYJ81xfPfNpn7jbcQ8PKYbj6BgU+Rz6WJvS/AHoEin6v7TXyrPkPSfEdX2y31+ZkbEBY61P35syjyUWIsca85imsJGAbTiaQun2uoBKS0faY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzHAREJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6062FC4CEC3;
	Thu,  5 Sep 2024 19:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563418;
	bh=iUatsXEnTmL3rn9cQJVw/n3/YwziO1sK8/B0fwSrp1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KzHAREJVfpfUn6YaMWik76imQSz63uvrGK6u19tDX4k9/Rd6WsB35BzefsFmN7RqW
	 +jlfLzhmdSl1RQMdj8/4EjlN5TIfmwCWgXr98FG8sioD9+Q+9jDTyIBft6H9p1cKBs
	 JlprbTL+k3aG1h30z5bE6hAsOpyEtpK2MPfEnlUrlBndz0YzViucVhyyyKjsHf5s0F
	 ApVHn12yGW5wO9Bayxodpr/CegxspRxi0FhuXfOsusrTf7z8oVkiP7D0HxBEqDwP+9
	 KoEcBmoBO9nxuWBdsmoZ7W/tz0F1Xd69T4w62eFZDLhbneQ8s83kMhMBl3kDV6PASR
	 r1AxqwId0dzLA==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 04/26] NFSD: Handle @rqstp == NULL in check_nfsd_access()
Date: Thu,  5 Sep 2024 15:09:38 -0400
Message-ID: <20240905191011.41650-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240905191011.41650-1-snitzer@kernel.org>
References: <20240905191011.41650-1-snitzer@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/export.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 7bb4f2075ac5..c82d8e3e0d4f 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -1074,10 +1074,30 @@ static struct svc_export *exp_find(struct cache_detail *cd,
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
+	 * If rqstp is NULL, this is a LOCALIO request which will only
+	 * ever use a filehandle/credential pair for which access has
+	 * been affirmed (by ACCESS or OPEN NFS requests) over the
+	 * wire. So there is no need for further checks here.
+	 */
+	if (!rqstp)
+		return nfs_ok;
+
+	xprt = rqstp->rq_xprt;
 
 	if (exp->ex_xprtsec_modes & NFSEXP_XPRTSEC_NONE) {
 		if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags))
@@ -1098,17 +1118,17 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
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
@@ -1118,7 +1138,7 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp)
 	 */
 
 	if (nfsd4_spo_must_allow(rqstp))
-		return 0;
+		return nfs_ok;
 
 denied:
 	return nfserr_wrongsec;
-- 
2.44.0


