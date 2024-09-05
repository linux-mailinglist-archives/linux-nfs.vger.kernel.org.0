Return-Path: <linux-nfs+bounces-6265-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD5396E2CB
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 21:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A838287DA4
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2024 19:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360118D655;
	Thu,  5 Sep 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CazXe+sT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFC818D650
	for <linux-nfs@vger.kernel.org>; Thu,  5 Sep 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563421; cv=none; b=CWU63ffmEFfHucKf1u0B4BSK6UURmpT7Rwm5EbdDJ17DcRmkQb6Vck6PUDtGHO6+mxN6AahU+ncy6xXr0wXB2XTAhK20peSETPwSNYGyXEc0as2/dj1RNv6DtSnTL2DJ/j9lh2bqSmgF7k/HcXZEK58e6gJbKt6AvskhWBdWsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563421; c=relaxed/simple;
	bh=MXyt8wZ2VIIBkFKiLhPMGmjazwnXkHapJteKHx4rikY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0Qq1RP9JC1186wFv0XwrAxlbOVV07ySYYoDpweY+aR5LBXgISluUAJUGdBRipGr+/iF5TUTxXXfr9gkOtq9OK4z/E000YBCB8wENGIuqEq6kfg6Jy9qNgNqkMDcIop3JyXODZst4lBdX6TTYOk+Tcr3Mbl4UD6b16wnLeGyrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CazXe+sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BE2C4CEC3;
	Thu,  5 Sep 2024 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725563421;
	bh=MXyt8wZ2VIIBkFKiLhPMGmjazwnXkHapJteKHx4rikY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CazXe+sTWXGh4X7K1FxvN0FjEfmPOUQiE2TqVOgZNl1RM/QJJtx7YX1rtIB40ptW/
	 uohJTzx7Qe689RHX8MJ0uVgc22lfbJN15YQjRfovveR/x3T48KfSSWN6W7IS4B5fEt
	 z48p/hDw6nPBcDqndIexVkKRQmYKT1Ot5vE2bj1WdXkHG0SuR/vRlTdjNs7s3nOUll
	 3eldH2UVIEam4SkiZ4MXaOxXMPFJvRsXF6l0A5f/bw+sEbVcaTvGpR935CjIzhhaEE
	 6AX6AblIwmRRFEtZZ7NJJpm/os3XeYhDJ+VQP8jEFYpnl7FI7pIEjttS0BZXGcciR5
	 pohF8vO4XBfxg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>
Subject: [PATCH v16 06/26] NFSD: Avoid using rqstp->rq_vers in nfsd_set_fh_dentry()
Date: Thu,  5 Sep 2024 15:09:40 -0400
Message-ID: <20240905191011.41650-7-snitzer@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

Currently, fh_verify() makes some daring assumptions about which
version of file handle the caller wants, based on the things it can
find in the passed-in rqstp. The about-to-be-introduced LOCALIO use
case sometimes has no svc_rqst context, so this logic won't work in
that case.

Instead, examine the passed-in file handle. It's .max_size field
should carry information to allow nfsd_set_fh_dentry() to initialize
the file handle appropriately.

The file handle used by lockd and the one created by write_filehandle
never need any of the version-specific fields (which affect things
like write and getattr requests and pre/post attributes).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsfh.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index 4b964a71a504..60c2395d7af7 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -267,20 +267,20 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp)
 	fhp->fh_dentry = dentry;
 	fhp->fh_export = exp;
 
-	switch (rqstp->rq_vers) {
-	case 4:
+	switch (fhp->fh_maxsize) {
+	case NFS4_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOATOMIC_ATTR)
 			fhp->fh_no_atomic_attr = true;
 		fhp->fh_64bit_cookies = true;
 		break;
-	case 3:
+	case NFS3_FHSIZE:
 		if (dentry->d_sb->s_export_op->flags & EXPORT_OP_NOWCC)
 			fhp->fh_no_wcc = true;
 		fhp->fh_64bit_cookies = true;
 		if (exp->ex_flags & NFSEXP_V4ROOT)
 			goto out;
 		break;
-	case 2:
+	case NFS_FHSIZE:
 		fhp->fh_no_wcc = true;
 		if (EX_WGATHER(exp))
 			fhp->fh_use_wgather = true;
-- 
2.44.0


