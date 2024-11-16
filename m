Return-Path: <linux-nfs+bounces-8025-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE3A9CFC43
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 02:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F58B279D7
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Nov 2024 01:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357619007E;
	Sat, 16 Nov 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGS+I+m5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F256190063
	for <linux-nfs@vger.kernel.org>; Sat, 16 Nov 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721280; cv=none; b=jv8OJw16DxmEB85LEAuQl3jP/AkUVZEY4CGdzJ16L50rnEha7d5NAJsMbRAlR/s9SdChZMlX3JoH7wNgyj0o1ZgbqmumI2vtr+J4wBVP3NITVq36Y3V8TJuxeuALZ2Hqf9xzoCMKYcQftL9ibTZPZikPXjwbKE5x3ipu2JpUWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721280; c=relaxed/simple;
	bh=/UuCYvOSvt7cCffPKdRRc7N08KwkO0534EhYAUum0oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGLWW2BqwKpAcm2fiZqBY7EBFTuQLaqTD8lmYpyUWafyTIJBGo/QFrNirz6rFUaXBagIkm3yhAYeP6eTBXMAFLb8/usdSE8FsbvmR+gkXM4wTRhn61PAE+cL1jzpY3sNN9D9KQ/WFug6FunmzGrGXAHDlXav2ogzWmfpoARAZQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGS+I+m5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DDBC4CED6;
	Sat, 16 Nov 2024 01:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731721278;
	bh=/UuCYvOSvt7cCffPKdRRc7N08KwkO0534EhYAUum0oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGS+I+m5yjJOtNMEtdHXndeSWmDN2GPV2Tr/gHO6O1eYqlbgpbUjB8Bmc0HkmLeCn
	 lq3lh9+SPeAxIJBi2lFdLN89d1I3B8szhByVf2RRDAer1KGGQAkwQ+2tCUZT2V38rW
	 hq1KzOEr7OzUItSeJefwkiLz80QtpTEnZVoIOXDTdIlq2JNliB/WqnliQjHQ9e27Au
	 ikXB0iIToIyMe4RNOaHE9dRPgP0vBTgTxNYkftUV0JjmIMDqwDxNjoXeiyZ01Cnivf
	 gfu7/Pom5Gdyr2keNc95lnebp8YGg+VzbzeNoShHNJX+qcIi8F9BTmU6H/smvXg+qE
	 rYoFVYM6WkAPg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH v3 08/14] nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
Date: Fri, 15 Nov 2024 20:41:00 -0500
Message-ID: <20241116014106.25456-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241116014106.25456-1-snitzer@kernel.org>
References: <20241116014106.25456-1-snitzer@kernel.org>
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


