Return-Path: <linux-nfs+bounces-11246-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A837A99223
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 17:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F9E3AF38C
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Apr 2025 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC45288C9E;
	Wed, 23 Apr 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ep64U+W0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042F62853F3
	for <linux-nfs@vger.kernel.org>; Wed, 23 Apr 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421691; cv=none; b=dCVl/fqXxS2HAcsktRsRolUAUz4VxX15zn/6k8K4iNGSzsAtB1ViqLdMLjAWfJgT9dysmrC4k97+Lp/gvA9Xv7PKGJzuQHUC+n6MIzegiAcfk65W8fKd5R8txN1AoVL7bxjACc9xYNV2CNfDzKyhIrMra/XNfyjC1Khw6fKBNRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421691; c=relaxed/simple;
	bh=XcMdj2D0M7vOLfmtMP5O8q4WsZiAeUcrcknnmdzOtTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSSC7mSpZvkS2GmJ7QrTma23SsircghU+jNIVmDf50DT675towE7vbntUipmEHUY9QEbnhNFKFEP3l3pw7fqWfmk/RWiDWPob9OuttYAJj10jSn4A6Nsmt9vGrx3n8+a/EBim/tVl9fOVfejLf6L9SXkWbPMr71f786+5Uds+bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ep64U+W0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAFDC4CEE3;
	Wed, 23 Apr 2025 15:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745421690;
	bh=XcMdj2D0M7vOLfmtMP5O8q4WsZiAeUcrcknnmdzOtTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ep64U+W0lcCo9DZ7dH/uTpAPMh4LcmXjLUC+PCK8mxuaIuM2wjKs3nabooxXfwTRH
	 uc015BEsGFBkQfpgyInOrtNiHUn9E+zUtjBRY7ds187gI0sgVQqHdzZlhZ1dlP4Flt
	 txVnU6Vlj8vS6mmPy7KfolnfLX+Wgp2BQ0wNWHlZUinJo48y5ufjeAiZ/UxcbweFbO
	 yyBdRUxP7X9CWPVDvAj5wHPX5IeUoFfJtFQynw+TVZa2yxzr+gSus9D0blWN2IK67b
	 0XgA9LrkUBJqjgC8F8gOcf/6JE/9txM7OaJWsnRx9w3u0QW4J1PgCE/K8nP2uQVgsl
	 Ed2IGBdY0KR5w==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 11/11] NFSD: Remove NFSSVC_MAXBLKSIZE from .pc_xdrressize
Date: Wed, 23 Apr 2025 11:21:17 -0400
Message-ID: <20250423152117.5418-12-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423152117.5418-1-cel@kernel.org>
References: <20250423152117.5418-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The value in the .pc_xdrressize field is used to "reserve space in
the output queue". Relevant only to UDP transports, AFAICT.

The fixed value of NFSSVC_MAXBLKSIZE is added to that field for
NFSv2 and NFSv3 read requests, even though nfsd_proc_read() is
already careful to reserve the actual size of the read payload.
Adding the maximum payload size to .pc_xdrressize seems to be
unnecessary.

Also, instead of adding a constant 4 bytes for each payload's
XDR pad, add the actual size of the pad for better accuracy of
the reservation size.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 4 ++--
 fs/nfsd/nfsproc.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 372bdcf5e07a..dbb750a7b5db 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -202,7 +202,7 @@ nfsd3_proc_read(struct svc_rqst *rqstp)
 	 */
 	resp->count = argp->count;
 	svc_reserve_auth(rqstp, ((1 + NFS3_POST_OP_ATTR_WORDS + 3) << 2) +
-			 resp->count + 4);
+			 xdr_align_size(resp->count));
 
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_read(rqstp, &resp->fh, argp->offset,
@@ -921,7 +921,7 @@ static const struct svc_procedure nfsd_procedures3[22] = {
 		.pc_argzero = sizeof(struct nfsd3_readargs),
 		.pc_ressize = sizeof(struct nfsd3_readres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST+pAT+4+NFSSVC_MAXBLKSIZE/4,
+		.pc_xdrressize = ST+pAT+3,
 		.pc_name = "READ",
 	},
 	[NFS3PROC_WRITE] = {
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6dda081eb24c..a95faf726e58 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -219,7 +219,7 @@ nfsd_proc_read(struct svc_rqst *rqstp)
 	/* Obtain buffer pointer for payload. 19 is 1 word for
 	 * status, 17 words for fattr, and 1 word for the byte count.
 	 */
-	svc_reserve_auth(rqstp, (19<<2) + argp->count + 4);
+	svc_reserve_auth(rqstp, (19<<2) + xdr_align_size(argp->count));
 
 	resp->count = argp->count;
 	fh_copy(&resp->fh, &argp->fh);
@@ -739,7 +739,7 @@ static const struct svc_procedure nfsd_procedures2[18] = {
 		.pc_argzero = sizeof(struct nfsd_readargs),
 		.pc_ressize = sizeof(struct nfsd_readres),
 		.pc_cachetype = RC_NOCACHE,
-		.pc_xdrressize = ST+AT+1+NFSSVC_MAXBLKSIZE_V2/4,
+		.pc_xdrressize = ST+AT+1,
 		.pc_name = "READ",
 	},
 	[NFSPROC_WRITECACHE] = {
-- 
2.49.0


