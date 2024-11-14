Return-Path: <linux-nfs+bounces-7960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008A9C819C
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 05:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127A81F226EC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Nov 2024 04:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CC31EABA2;
	Thu, 14 Nov 2024 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtAwlprt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344A1E22E4
	for <linux-nfs@vger.kernel.org>; Thu, 14 Nov 2024 04:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556806; cv=none; b=MuDMOeLsteJOVOa2Z0fAjVcn7Eqzwmd+Fq8ZyysGBcXab1iJdG+iIGH0OHRZvDRnw3Bjgnatk0ruFK2Eo1d2cgQF8zw+8CfaGA782M653HNPw9GOfkxZAOQeeiFUJQO/gLuEgjLHNrPpHldOA/vLjZj0ViEeDYuf5yh95COHuZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556806; c=relaxed/simple;
	bh=/UuCYvOSvt7cCffPKdRRc7N08KwkO0534EhYAUum0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKxGVXA0N1XHHO2oxwtsG9aJB+39Bs52fb1NiJ6/OnAmG4IJVS4HlcgvgzOaxrzLOv8mcGsPWjMkUyhDfbuJOMmoy0K9D4h1CR/I6mLgSyY2JZq/cHPbBTiOM7tesomf4vh8/PN26h8whJsBhpEmz6jwSVaI0EDs6mQsjqKDCdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtAwlprt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEEFC4CED0;
	Thu, 14 Nov 2024 04:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556805;
	bh=/UuCYvOSvt7cCffPKdRRc7N08KwkO0534EhYAUum0oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtAwlprtI+J+0yRSdSo+31jpqd77xinsmhplPY7D9DWfdxD0cM3mHBe9rU0MeFfV4
	 IQTpcv+OTjRXVGP1ncf8l/wVZRtA1MlA+rdFgOKDmUc/ukpoQMEwscxZFxE7RqmJBv
	 oKYvVFRZKHg2SB+Ct5BDpUvPnOpBcjmJFTDgGItJ99Xex6rlRcjnSVr3AJgYU3WkeJ
	 f2lsFYl6bG86Po7Da0YtCNmF+EPJOvEGs7MYzg7lQzqyGNvHsoY8CcCT4QMonkG8fc
	 i9MrKLPlYhvJJQ2vEDTYck7kKe+duE2dclkkrvukaKSTUI2O5jDRxt7NGNlu11veNo
	 EnGtiviqvqEtw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v2 09/15] nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
Date: Wed, 13 Nov 2024 22:59:46 -0500
Message-ID: <20241114035952.13889-10-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114035952.13889-1-snitzer@kernel.org>
References: <20241114035952.13889-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that LOCALIO no longer leans on NFSD's filecache for caching open
files (and instead uses NFS client-side open nfsd_file caching) there
is no need to use NFSD filecache's GC feature.  Avoiding GC will speed
up nfsd_file initial opens.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fac98b2cb463a..ab9942e420543 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1225,10 +1225,9 @@ nfsd_file_acquire(struct svc_rqst *rqstp, struct svc_fh *fhp,
  * a file.  The security implications of this should be carefully
  * considered before use.
  *
- * The nfsd_file object returned by this API is reference-counted
- * and garbage-collected. The object is retained for a few
- * seconds after the final nfsd_file_put() in case the caller
- * wants to re-use it.
+ * The nfsd_file_object returned by this API is reference-counted
+ * but not garbage-collected. The object is unhashed after the
+ * final nfsd_file_put().
  *
  * Return values:
  *   %nfs_ok - @pnf points to an nfsd_file with its reference
@@ -1250,7 +1249,7 @@ nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 	__be32 beres;
 
 	beres = nfsd_file_do_acquire(NULL, net, cred, client,
-				     fhp, may_flags, NULL, pnf, true);
+				     fhp, may_flags, NULL, pnf, false);
 	revert_creds(save_cred);
 	return beres;
 }
-- 
2.44.0


