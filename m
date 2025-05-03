Return-Path: <linux-nfs+bounces-11421-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB56AA8287
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 22:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439A418896E9
	for <lists+linux-nfs@lfdr.de>; Sat,  3 May 2025 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4952127E7DC;
	Sat,  3 May 2025 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pm88v6bw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2179327EC64;
	Sat,  3 May 2025 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746302394; cv=none; b=TAsMFJFDC2N2k2EN+G7WYqufkUPpW9Z8c3u+KU88lv9rw7fi2Fi8u3OybphY5O8Y2ix6/cft6/4H9/5K8bgxLe2xRVtlhApRFoyaQQPSIAT4PFOiWahGNQZD1hkDxI57iExSDYdkRmS7w+BhtR6LxTYLndFnAZ1xpVpgiqBrSB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746302394; c=relaxed/simple;
	bh=VFdE7daLYTIqpnRRpPG79EzLxFLGC+mrG75NvGdLqRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYVAH2+VkJrdTZBb4jtWrZ5ORHCnRd18GhebvNgzJNoF2OqbbVm1LjoMowFlG4oSOoNsf2csOZcPDFXk/v3ceVbBSLZXpe6cUWsOQHEllPIv98nYnCVGgH8jGC+wkiEOif07a6877+bsG//em2AdToCzwHujiEYZNDUivSm4gOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pm88v6bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF32DC4CEF1;
	Sat,  3 May 2025 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746302393;
	bh=VFdE7daLYTIqpnRRpPG79EzLxFLGC+mrG75NvGdLqRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pm88v6bw7MiYV57rLO15wyO10EbMVrIXRv82nJYbwzur+xgxPeAQJEDjPdG3SyelA
	 CbAygPkV0CM+O3hcdOBXRlBCg3K+DRKwU1apQnWeP2D0dYZNTo85ALi55xbd/s6sEY
	 al7hS3QWPO3v8Z0Lp8U++09lETRSp7LZPPlytuWES602DZbdBC+SPH5tir+s+YE7f4
	 zSpILJGdSIzKd7QJyEaS7d0qXOeMJWa/wc+cIICdpYtLMwikfGKOSaJfe8CZvT28FU
	 AR4ZVkqqbQzfu0ULmyCsMLCxZGWNr99v33mjXkT2B1x+baWvbWii8y4dVOOs67BejE
	 2Zp2TkZs2xYAw==
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
Subject: [PATCH v4 13/18] nfsd: remove old v2/3 SYMLINK dprintks
Date: Sat,  3 May 2025 15:59:31 -0400
Message-ID: <20250503195936.5083-14-cel@kernel.org>
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
 fs/nfsd/nfs3proc.c | 5 -----
 fs/nfsd/nfsproc.c  | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index a4dd1f7c202f..f207fba722eb 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -440,11 +440,6 @@ nfsd3_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	dprintk("nfsd: SYMLINK(3)  %s %.*s -> %.*s\n",
-				SVCFH_fmt(&argp->ffh),
-				argp->flen, argp->fname,
-				argp->tlen, argp->tname);
-
 	fh_copy(&resp->dirfh, &argp->ffh);
 	fh_init(&resp->fh, NFS3_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &resp->dirfh, argp->fname,
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index eec925d84410..a12ad08b000a 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -519,10 +519,6 @@ nfsd_proc_symlink(struct svc_rqst *rqstp)
 		goto out;
 	}
 
-	dprintk("nfsd: SYMLINK  %s %.*s -> %.*s\n",
-		SVCFH_fmt(&argp->ffh), argp->flen, argp->fname,
-		argp->tlen, argp->tname);
-
 	fh_init(&newfh, NFS_FHSIZE);
 	resp->status = nfsd_symlink(rqstp, &argp->ffh, argp->fname, argp->flen,
 				    argp->tname, &attrs, &newfh);
-- 
2.49.0


