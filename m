Return-Path: <linux-nfs+bounces-11423-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F5AA828B
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB11D1B627DF
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B72836A3;
	Sat,  3 May 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch5uZBcR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDD6283691;
	Sat,  3 May 2025 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302395; cv=none; b=D+Ik2Stzk1fhClIROER5JaX8DLm8FTxbqO4ybGIXdZOqLgMfUsrHaUROikfa6TPUB5/0ojbX9o/VWpdQwdFMrc1RGD/Iua/dC47bEJIBz2boNkWt606KtpDBVFQMKQ90zMAYPxRVg9CNCAtr7XDVVy5GvMWXx5R0mKIpfRGP/nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302395; c=relaxed/simple;
	bh=igopUQe57zKtfrfTWB997I8/C9AiNjZWaNL+X86qkLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o6c6vLCE6X8N6FeyXcl5Js9lJYg8yh1k3tJWDkwLX927QGnKloFa03nl6QNUGruwZ8OEMt4C3S4E24GxI1SaFgc8VecjHbx4SB4dXHyQD51pdgpfoL3D54X2o7XROyeWAgbHsWfwdcPtcQwj1dWqz2S3F3wJewELOkNKR85Dte0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ch5uZBcR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B265BC4CEE3;
	Sat,  3 May 2025 19:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302395;
	bh=igopUQe57zKtfrfTWB997I8/C9AiNjZWaNL+X86qkLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ch5uZBcR6aP8yCeWPJKOIA+iOu4wINJFidaHVikgq1WPq2h9yFxtjY3qrCkLKdOmr
	 nRocF18eJmjc2fzYB1QL5F9stgE3NVvpo/v33MNqLp/H9UmXLZPOcmdvRIex3evbU+
	 BNvQKJzU9vQmZY9OFJVkz1Cptl4TLn2WoSlE4iyIbymPDIm5bIyR4aDBQTILhyDx7+
	 cilwB/cCC1JeCyPirrOD6WW95knECecyX930zqU6cWxUkW9sY9Thwsh/7S2G8rcpVW
	 pTAq7OYOZvW0gzO8qQs14GSNMPGALaOpWyAVcOS8p8ctlOJkmkYVCt6WlaX7D/Suyo
	 QtbCYR3NTuZbQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: sargun@sargun.me,
	<linux-nfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 15/18] nfsd: remove REMOVE/RMDIR dprintks
Date: Sat,  3 May 2025 15:59:33 -0400
Message-ID: <20250503195936.5083-16-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250503195936.5083-1-cel@kernel.org>
References: <20250503195936.5083-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

Observability here is now covered by static tracepoints.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 10 ----------
 fs/nfsd/nfsproc.c  |  5 -----
 2 files changed, 15 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index ebf9bcac9e7f..3b1d63d51bb2 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -496,11 +496,6 @@ nfsd3_proc_remove(struct svc_rqst *rqstp)
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: REMOVE(3)   %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	/* Unlink. -S_IFDIR means file must not be a directory */
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, -S_IFDIR,
@@ -518,11 +513,6 @@ nfsd3_proc_rmdir(struct svc_rqst *rqstp)
 	struct nfsd3_diropargs *argp = rqstp->rq_argp;
 	struct nfsd3_attrstat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RMDIR(3)    %s %.*s\n",
-				SVCFH_fmt(&argp->fh),
-				argp->len,
-				argp->name);
-
 	fh_copy(&resp->fh, &argp->fh);
 	resp->status = nfsd_unlink(rqstp, &resp->fh, S_IFDIR,
 				   argp->name, argp->len);
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 6636fd075ca8..7581b1ef4183 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -445,9 +445,6 @@ nfsd_proc_remove(struct svc_rqst *rqstp)
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: REMOVE   %s %.*s\n", SVCFH_fmt(&argp->fh),
-		argp->len, argp->name);
-
 	/* Unlink. -SIFDIR means file must not be a directory */
 	resp->status = nfsd_unlink(rqstp, &argp->fh, -S_IFDIR,
 				   argp->name, argp->len);
@@ -565,8 +562,6 @@ nfsd_proc_rmdir(struct svc_rqst *rqstp)
 	struct nfsd_diropargs *argp = rqstp->rq_argp;
 	struct nfsd_stat *resp = rqstp->rq_resp;
 
-	dprintk("nfsd: RMDIR    %s %.*s\n", SVCFH_fmt(&argp->fh), argp->len, argp->name);
-
 	resp->status = nfsd_unlink(rqstp, &argp->fh, S_IFDIR,
 				   argp->name, argp->len);
 	fh_put(&argp->fh);
-- 
2.49.0


