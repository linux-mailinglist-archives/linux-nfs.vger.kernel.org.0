Return-Path: <linux-nfs+bounces-16411-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCEC5F3E0
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 911D834AA1B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Nov 2025 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9ECD348860;
	Fri, 14 Nov 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6VGLlHg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3F342536
	for <linux-nfs@vger.kernel.org>; Fri, 14 Nov 2025 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763152178; cv=none; b=j+i298XkDLdK6fHkgS/pVkj2uKU7vmLm9iQP3aL2zOhz/m3YKOq8jBC8cJcxQYjcXJwmz69l67S5gPMh8PllBa2rYCElR5xp388W8LthWrmXr7p0xQFVpK1rTa/CJhEJtf8VszLCQHGTqbnEgWUzYf8/rnVmuAvoZtB3YGQtU4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763152178; c=relaxed/simple;
	bh=dA6cCOY9N/6JlEbBxivA2F67fiOTM0397iuxNDhejho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtKJkkY1SGkns+KJyfET0+75+VYLnI5Bl2efPOMdP9eZvYYC7CmIzoKgQuEmH0s5kQ7KDThFxYwQuODVi6C2N8rOmZtYtRNoI3odEQ2Ft4vZEJll5UPdntRN2YqapLhE0GDuYfShihtZeLXg7IHI8b84Wfz/ivGfIzsBxv5cnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6VGLlHg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF887C2BC87;
	Fri, 14 Nov 2025 20:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763152178;
	bh=dA6cCOY9N/6JlEbBxivA2F67fiOTM0397iuxNDhejho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6VGLlHgzKYxj1LWCifgPcuXPnhUxuHzoR8OjZ5zZR0DHz0XOjjNyG3FTgcmuJHoN
	 t17m//dKf8oBsAQXEyIFvlHpt/fayw6HVN2itEg3PGaAsM0nht39fbtIYeeoGCsBMI
	 f/Uhf/iHyH8pkdEAbmonpOyMl0XN2kT3g2k3e4HmcuiHXeeDY1vrBdJlF6tRHleiMW
	 qF6lt4QSvbBQF7nJ3LKzUetInbD5xksMIQPtWmq/nCw0BcYp242PjXUpZqWDDzgLCk
	 d2hcZXI5i61llyx52HPYj6VcS+qg06Or/42+aSL1118tbV1WDLUExwjR4n/vA4FkOy
	 4FvlUNsrKlSig==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 3/3] NFSD: Clean up nfsd4_check_open_attributes()
Date: Fri, 14 Nov 2025 15:29:33 -0500
Message-ID: <20251114202933.6133-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251114202933.6133-1-cel@kernel.org>
References: <20251114202933.6133-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The @rqstp parameter was introduced in commit 3c8e03166ae2 ("NFSv4:
do exact check about attribute specified") but has never been used.

Reduce indentation in callers to improve readability.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7f7e6bb23a90..dcad50846a97 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -81,8 +81,8 @@ static u32 nfsd41_ex_attrmask[] = {
 };
 
 static __be32
-check_attr_support(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
-		   u32 *bmval, u32 *writable)
+check_attr_support(struct nfsd4_compound_state *cstate, u32 *bmval,
+		   u32 *writable)
 {
 	struct dentry *dentry = cstate->current_fh.fh_dentry;
 	struct svc_export *exp = cstate->current_fh.fh_export;
@@ -103,21 +103,25 @@ check_attr_support(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 }
 
 static __be32
-nfsd4_check_open_attributes(struct svc_rqst *rqstp,
-	struct nfsd4_compound_state *cstate, struct nfsd4_open *open)
+nfsd4_check_open_attributes(struct nfsd4_compound_state *cstate,
+			    struct nfsd4_open *open)
 {
 	__be32 status = nfs_ok;
 
-	if (open->op_create == NFS4_OPEN_CREATE) {
-		if (open->op_createmode == NFS4_CREATE_UNCHECKED
-		    || open->op_createmode == NFS4_CREATE_GUARDED)
-			status = check_attr_support(rqstp, cstate,
-					open->op_bmval, nfsd_attrmask);
-		else if (open->op_createmode == NFS4_CREATE_EXCLUSIVE4_1)
-			status = check_attr_support(rqstp, cstate,
-					open->op_bmval, nfsd41_ex_attrmask);
-	}
+	if (open->op_create != NFS4_OPEN_CREATE)
+		return status;
 
+	switch (open->op_createmode) {
+	case NFS4_CREATE_UNCHECKED:
+	case NFS4_CREATE_GUARDED:
+		status = check_attr_support(cstate, open->op_bmval,
+					    nfsd_attrmask);
+		break;
+	case NFS4_CREATE_EXCLUSIVE4_1:
+		status = check_attr_support(cstate, open->op_bmval,
+					    nfsd41_ex_attrmask);
+		break;
+	}
 	return status;
 }
 
@@ -583,7 +587,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		goto out;
 	}
 
-	status = nfsd4_check_open_attributes(rqstp, cstate, open);
+	status = nfsd4_check_open_attributes(cstate, open);
 	if (status)
 		goto out;
 
@@ -795,8 +799,7 @@ nfsd4_create(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
-	status = check_attr_support(rqstp, cstate, create->cr_bmval,
-				    nfsd_attrmask);
+	status = check_attr_support(cstate, create->cr_bmval, nfsd_attrmask);
 	if (status)
 		return status;
 
@@ -1216,8 +1219,7 @@ nfsd4_setattr(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return nfserrno(err);
 	status = nfs_ok;
 
-	status = check_attr_support(rqstp, cstate, setattr->sa_bmval,
-				    nfsd_attrmask);
+	status = check_attr_support(cstate, setattr->sa_bmval, nfsd_attrmask);
 	if (status)
 		goto out;
 
@@ -2270,7 +2272,7 @@ _nfsd4_verify(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (status)
 		return status;
 
-	status = check_attr_support(rqstp, cstate, verify->ve_bmval, NULL);
+	status = check_attr_support(cstate, verify->ve_bmval, NULL);
 	if (status)
 		return status;
 
-- 
2.51.0


