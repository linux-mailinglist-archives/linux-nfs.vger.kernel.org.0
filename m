Return-Path: <linux-nfs+bounces-16457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA7DC6503D
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 17:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB1074E6CF6
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Nov 2025 16:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8252874E3;
	Mon, 17 Nov 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2ksF4rW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895592BEFE7
	for <linux-nfs@vger.kernel.org>; Mon, 17 Nov 2025 16:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763395256; cv=none; b=daf7Yb64gpgNGGaDmwj5/8urEm4lYtloSNwTbrneJIQxU0fK8VfI044UWk+cjgfJYsAe4ErdhkRfUavs4IDTfs0mz/ZanVwxZZ+9w+bzNrK3+vft5M14e9UYV6KcgUr9uL+I/ZCl4AOgKcBePo6Ncbj/YM3SNIDn9l8mpahhbIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763395256; c=relaxed/simple;
	bh=dA6cCOY9N/6JlEbBxivA2F67fiOTM0397iuxNDhejho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPLn2g/n6sf6vm/WOYxgiqWxZrLi6LdYY1xp644GaSWU5LsBTQyOv1ujMMp7YjWXj/opxPcUxzgXXEUF+324+S7BYgt96Pfg4W49fMDmyy9GKP2sLjJA+y4Ea/NZTPPHmXCQEq6FiH4fzGITVI2ng82QsJUTMB7EH/da4ggCFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2ksF4rW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 986B9C4CEF1;
	Mon, 17 Nov 2025 16:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763395256;
	bh=dA6cCOY9N/6JlEbBxivA2F67fiOTM0397iuxNDhejho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W2ksF4rWU972W3CnLSI4jlSzLtTCbM7jq55jpS3IubuPbIK1VZ6IXwgroVw7eVOyW
	 rwi8P7K8ePC5OkVeGFibondBe9OCHVA1gnx3Cv1zBK+ETt6EU2pDDKsY73TlCbGojG
	 1DRtYxOpKtkwyMOjz3afn+5jg+Y8QRwEyb9XR9PDL0YcRFy1OL4+4eGtNNLZQaflZj
	 /kfMRHOLmMSyEjtpgj32BP61mzbIcid7EqQGag/lndNNfV0up/XokVWAIY2mkZ0Rne
	 nVfhRKKsX6AbyIlpRRmTUocT/32I54PDh6uVjHQDhzlESsICBbUrWGEcMJ96T3qrz4
	 S5RT+rtyfhuIw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/3] NFSD: Clean up nfsd4_check_open_attributes()
Date: Mon, 17 Nov 2025 11:00:51 -0500
Message-ID: <20251117160051.10213-4-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117160051.10213-1-cel@kernel.org>
References: <20251117160051.10213-1-cel@kernel.org>
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


