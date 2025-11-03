Return-Path: <linux-nfs+bounces-15946-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D71B2C2D45D
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 00188347D73
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D13E319879;
	Mon,  3 Nov 2025 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGamJYRG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F53195EC
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188848; cv=none; b=YW893WOm6Qq1v57wZ7VwOqApjGV5gWZ5VGMz1Zz0hbC9ALQ+0xjue43yON+n+7qgEtPsVzzAG/hVilPSr5jiqgIksvWHi8fpy9LdkDNL7mwHHN+Sw8xulbYFvfSw8mcYCnfH2kh0uQbPHNcNRJZbQfdvdAm1BzRW+Boo+euZxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188848; c=relaxed/simple;
	bh=AG4OtKNHlhEkttlU+qwI2BhJpWCwZY7jCxbi+Xo87pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TGfBsykX6QboXU0X8dblVLxHk/Qyf4J5sm4gvVXqzzyJWljBS2/RP/mA2qIfShAMBGGum+EcnjpVTnW6d7DWNCaGtJcI3LjcL1zHjOnzOjb5/SgzXF5Yl8fdwdaKHuHRr4/8bhxnRXZzAAIfbi5RdFv4++QjKeyEHNPGr3IKiFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGamJYRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF58EC4CEFD;
	Mon,  3 Nov 2025 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188844;
	bh=AG4OtKNHlhEkttlU+qwI2BhJpWCwZY7jCxbi+Xo87pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uGamJYRGN9hHuZCeXAmcNl2v9mvjm3SzdtzcgOwzepYbPShLb3RdSMfIFmJCkQPQF
	 jmr7mtq6C1GgNUTNuIwyBl3US2mMU5sXwUujWH3vZ9uWS8pCva1a/stoXcDZM/S25w
	 645t62zph7eSG/9XD/4yADmhzmcYBNBuTNHXTj8neEZBHtg/XyOpaZsxqrI6JQgkoD
	 VMPxMMSHXSk75Gt7A/f6d++x63MGvf4MAEeI7Wsi+UKxR/r2QsDugP1j5TJ5jO7EiY
	 ukOe29IRpJ1E2pnnrUBLyZnNJWdbr2JYuZu/5ZJXz2Tmszf72LBRP8uE54j3yvtUvS
	 SVPkzG3xxzxcg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 11/12] NFSD: Refactor nfsd_vfs_write
Date: Mon,  3 Nov 2025 11:53:50 -0500
Message-ID: <20251103165351.10261-12-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103165351.10261-1-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

There is now only one caller of nfsd_buffered_write(), so it can
be folded back into nfsd_vfs_write().

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0e5e82b286f1..8518fb619f56 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1357,23 +1357,6 @@ nfsd_write_dio_iters_init(struct bio_vec *bvec, unsigned int nvecs,
 	args->nsegs = 1;
 }
 
-static int
-nfsd_buffered_write(struct svc_rqst *rqstp, struct file *file,
-		    unsigned int nvecs, unsigned long *cnt,
-		    struct kiocb *kiocb)
-{
-	struct iov_iter iter;
-	int host_err;
-
-	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
-	host_err = vfs_iocb_iter_write(file, kiocb, &iter);
-	if (host_err < 0)
-		return host_err;
-	*cnt = host_err;
-
-	return 0;
-}
-
 static int
 nfsd_issue_dio_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		     struct kiocb *kiocb, unsigned int nvecs,
@@ -1457,6 +1440,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	u32			stable = *stable_how;
 	struct kiocb		kiocb;
 	struct svc_export	*exp;
+	struct iov_iter		iter;
 	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
@@ -1517,10 +1501,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags |= IOCB_DONTCACHE;
-		fallthrough; /* must call nfsd_buffered_write */
+		fallthrough;
 	case NFSD_IO_BUFFERED:
-		host_err = nfsd_buffered_write(rqstp, file,
-					       nvecs, cnt, &kiocb);
+		iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+		host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
+		if (host_err < 0)
+			break;
+		*cnt = host_err;
 		break;
 	}
 	if (host_err < 0) {
-- 
2.51.0


