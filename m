Return-Path: <linux-nfs+bounces-5831-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D06B961B28
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 02:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 476651C22F13
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 00:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5A1804E;
	Wed, 28 Aug 2024 00:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzKf59Ya"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1547217C7C
	for <linux-nfs@vger.kernel.org>; Wed, 28 Aug 2024 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724805894; cv=none; b=A82iqXg/MJi20Tc9kT9TpVqYXFGepvq3zrhl7bXWeTG2gJcKNnyjZMkfhHuU6uxY/E1A35C0EpLCdjcs26uXNtgGDVNFOKs9rZ5bF5zbjLDw0ovjiYDqT9C6TU08QoXKOaquMnEnKa1CwYTfP0iKLIOdf7HpRpNOQqCpLOFe1aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724805894; c=relaxed/simple;
	bh=zQlI4DI4zHhcv21oEfLRiwfFWAei0sV+Ptbq/I5/kyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLOmN6nU8QMofUx/XcOFa9TKZy324r5FkiQzzJpTcxw1dUC0GR1Yqam8a+FLCLvroXlhy6FX95UtQvBxhSm7sGZazwK0h0HWyy5KNIeZop/3cu9npt46x7p1JCfjQyMohBRG9M9TVEzhbwYY1nTmYVswiy6GPHNGveHyIM7TNhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzKf59Ya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2A9C4DDED;
	Wed, 28 Aug 2024 00:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724805893;
	bh=zQlI4DI4zHhcv21oEfLRiwfFWAei0sV+Ptbq/I5/kyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RzKf59Yab/NTqZRFLmKtXyq+MwZ0Vf8+knKQVsjpWjlr7Q8p3CfrYYxkvBRdX2ITs
	 oeYzZCqhF8LYNmGa/XzdZCRTC3K6qWkYW9uvFmJYG+djo9/WfK7Ca8t8spIOsld08r
	 0cOnP7jR3I5MXIZ4vt/JQ+afomS3a74hpglHrvpiAbPvAb6QDAHL5MN3M0IXZkE07P
	 GI5wijBzvegMtLwW3FvHAmVlT9hroA2bkYflYLq9gibYK/NZOFPxXX/o01azL5WJJo
	 i1uJNuLniXbYjE/THRdIaIo+AY7Xa5g9tzePeutFXf5x72TmdmcNIBvAxiuUVlChAJ
	 BZx/75mFTPw1A==
From: cel@kernel.org
To: Neil Brown <neilb@suse.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>
Subject: [RFC PATCH 2/6] NFSD: Refactor nfsd_setuser_and_check_port()
Date: Tue, 27 Aug 2024 20:44:41 -0400
Message-ID: <20240828004445.22634-3-cel@kernel.org>
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

There are several places where __fh_verify unconditionally dereferences
rqstp to check that the connection is suitably secure.  They look at
rqstp->rq_xprt which is not meaningful in the target use case of
"localio" NFS in which the client talks directly to the local server.

Prepare these to always succeed when rqstp is NULL.

Signed-off-by: NeilBrown <neilb@suse.de>
Co-developed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfsfh.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 50d23d56f403..4b964a71a504 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -87,23 +87,24 @@ nfsd_mode_check(struct dentry *dentry, umode_t requested)
 	return nfserr_wrong_type;
 }
 
-static bool nfsd_originating_port_ok(struct svc_rqst *rqstp, int flags)
+static bool nfsd_originating_port_ok(struct svc_rqst *rqstp,
+				     struct svc_cred *cred,
+				     struct svc_export *exp)
 {
-	if (flags & NFSEXP_INSECURE_PORT)
+	if (nfsexp_flags(cred, exp) & NFSEXP_INSECURE_PORT)
 		return true;
 	/* We don't require gss requests to use low ports: */
-	if (rqstp->rq_cred.cr_flavor >= RPC_AUTH_GSS)
+	if (cred->cr_flavor >= RPC_AUTH_GSS)
 		return true;
 	return test_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
 static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
+					  struct svc_cred *cred,
 					  struct svc_export *exp)
 {
-	int flags = nfsexp_flags(&rqstp->rq_cred, exp);
-
 	/* Check if the request originated from a secure port. */
-	if (!nfsd_originating_port_ok(rqstp, flags)) {
+	if (rqstp && !nfsd_originating_port_ok(rqstp, cred, exp)) {
 		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 		dprintk("nfsd: request from insecure port %s!\n",
 		        svc_print_addr(rqstp, buf, sizeof(buf)));
@@ -111,7 +112,7 @@ static __be32 nfsd_setuser_and_check_port(struct svc_rqst *rqstp,
 	}
 
 	/* Set user creds for this exportpoint */
-	return nfserrno(nfsd_setuser(&rqstp->rq_cred, exp));
+	return nfserrno(nfsd_setuser(cred, exp));
 }
 
 static inline __be32 check_pseudo_root(struct dentry *dentry,
@@ -219,7 +220,7 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 		put_cred(override_creds(new));
 		put_cred(new);
 	} else {
-		error = nfsd_setuser_and_check_port(rqstp, exp);
+		error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
 		if (error)
 			goto out;
 	}
@@ -358,7 +359,7 @@ fh_verify(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type, int access)
 	if (error)
 		goto out;
 
-	error = nfsd_setuser_and_check_port(rqstp, exp);
+	error = nfsd_setuser_and_check_port(rqstp, &rqstp->rq_cred, exp);
 	if (error)
 		goto out;
 
-- 
2.45.2


