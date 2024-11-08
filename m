Return-Path: <linux-nfs+bounces-7806-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFDF9C2833
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D062B226CA
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD108F54;
	Fri,  8 Nov 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHs5bGUu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC21F26C7
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109223; cv=none; b=dYPv8wvewTyKDejP0xjy4OeJYPr6aTFdx84ilyCWIAii+5MvlBLKnVUyZzRXSbT02HI+dGk41HLyrSPi7Rkl7b8Suct2Y5gm5n8xS8G7hikXeVZA7wns9iNT8kAHVgT9FeXav7j84pmZF9p2jRHmLqlm9U90DnDj4UMqSYeKRmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109223; c=relaxed/simple;
	bh=fwqHCDnVEEiG1LcWsLeB504CZmExgi5cxZc9NR+RKg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMjj9t9bT+UKZ3UvN/kr0tKTV+9b8BvGX1QVq9RDNijvo7iTAUI9WJJMnhlFBCun8FO4lG6nXX1h/TXSBmRaC55apjOFYw29/FLRkAa42iSeqGWS9KIrBOFQ1H0zw2PjT4qrX19ZJERjv1P0Bx0ATX3gRAhWef4xrZw/ZVJLPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHs5bGUu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA50FC4CECE;
	Fri,  8 Nov 2024 23:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109223;
	bh=fwqHCDnVEEiG1LcWsLeB504CZmExgi5cxZc9NR+RKg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BHs5bGUuB+W7ex2F0n2EuTh8svESm3R8Y4AhHsMq/79tPT9g9UWBK738ekufYzwIy
	 617g4kVISefF4uVQcHn+BAH94Dz+4cjUO9X/tdQoNckRN3FmshMaKdyqHWHP4rFmqc
	 W1ACSkMXGMnKD+PVsSDLW4iXedhchQMSI2mC70PvdYTF1wQ7vsOTalPmxvM23gNQ5j
	 5Dz134ng/Mp/e2CfrIPof3zZ54uf9TWbTVwlie2ZzrKQudQayWpqNPXauOGApoIEdu
	 g88QnoH5bYIB+Er2ov3aoxbECkE7YMnUwZWGQMJyexdgreix+wQcPmm3HGI+NMOvCd
	 uF0qpq6/gMCAg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 14/19] nfsd: nfsd_file_acquire_local no longer returns GC'd nfsd_file
Date: Fri,  8 Nov 2024 18:39:57 -0500
Message-ID: <20241108234002.16392-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
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
index fac98b2cb463..ab9942e42054 100644
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


