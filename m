Return-Path: <linux-nfs+bounces-6773-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB6698C6DC
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 22:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48A9E285A17
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Oct 2024 20:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB881CC16E;
	Tue,  1 Oct 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3znZkSm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A311BDABD
	for <linux-nfs@vger.kernel.org>; Tue,  1 Oct 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814841; cv=none; b=QpEqjQcPFiFYj6xJNDtJ079xc7o80toRUkbwVePqQemOI6bBtpEjYouCEXYrxaIZ8egimCzPhV2v8/yt4JaaA5hyJ7ZbNsJjFadH4czHUhQZz5D7lkNNmUtzFFeBuYfEzoXSF82nG5E+ZOivgS/AE21di9fmmY+OCdfxbG7DGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814841; c=relaxed/simple;
	bh=5aTu02U4n+sG8r2Ub9RmKO/jP1weOoJsVyE7+AikJu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMcjPooLyz2gKJ6isCBD8odbbjClP+MRt1t54agOIoNKRqREnHbiXYGb+Lybi2Xa/4XLJG1pnYAb99oJMpaj3IJO+7U/pDhkspUI4ZB5B9rEpwpQ4bJqVavj3XzKiI1Bzwa2+clmFZlry+ZXtRK3lqgEeWu9WpQc9DXPaD68NHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3znZkSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E9DC4CECD;
	Tue,  1 Oct 2024 20:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727814840;
	bh=5aTu02U4n+sG8r2Ub9RmKO/jP1weOoJsVyE7+AikJu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3znZkSmH2Gj+KZTSjlf3wlMFpylzNPXmaYNfQ5nQIVrGLhH1xL3PkUhR43OZN7Wc
	 avzn/hlkzRz+mj1+sQ7S3OCbxpKSy+5L3M9JuLt3fb0LfFZrgucEgKDFeC1z5SzYFj
	 ElyrPY9//j/RqeMOIQFNxVtv8xIXul+JD4XBM0PNfAs1r2x7rRVHSs43iFPkxRUaIP
	 tvy3EQgCL5aCJw2nyHCk3riMMShBJ43Yl6QbBEgBX7jJLp6FPXFR9uJpZSJDHsfwyq
	 rvmqQVDH034euYnrfwGfHwr6JjUVO6JmyVIfq7+tRRZ3IWnobQ75rGHLj7EE154Kz0
	 ukY8c79KOt3gQ==
From: Anna Schumaker <anna@kernel.org>
To: linux-nfs@vger.kernel.org,
	trond.myklebust@hammerspace.com
Cc: anna@kernel.org
Subject: [PATCH 4/5] NFS: Clean up find_nfs_version()
Date: Tue,  1 Oct 2024 16:33:43 -0400
Message-ID: <20241001203344.327044-5-anna@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001203344.327044-1-anna@kernel.org>
References: <20241001203344.327044-1-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

It's good practice to check the return value of request_module() to see
if the module has been found. It's also a little easier to follow the
code if __find_nfs_version() doesn't attempt to convert NULL pointers
into -EPROTONOSUPPORT.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
---
 fs/nfs/client.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 63620766f2a1..4fe5a635f329 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -87,9 +87,6 @@ static struct nfs_subversion *__find_nfs_version(unsigned int version)
 	read_lock(&nfs_version_lock);
 	nfs = nfs_version_mods[version];
 	read_unlock(&nfs_version_lock);
-
-	if (nfs == NULL)
-		return ERR_PTR(-EPROTONOSUPPORT);
 	return nfs;
 }
 
@@ -97,13 +94,15 @@ struct nfs_subversion *find_nfs_version(unsigned int version)
 {
 	struct nfs_subversion *nfs = __find_nfs_version(version);
 
-	if (IS_ERR(nfs)) {
-		request_module("nfsv%d", version);
+	if (!nfs && request_module("nfsv%d", version) == 0)
 		nfs = __find_nfs_version(version);
-	}
 
-	if (!IS_ERR(nfs) && !try_module_get(nfs->owner))
+	if (!nfs)
+		return ERR_PTR(-EPROTONOSUPPORT);
+
+	if (!try_module_get(nfs->owner))
 		return ERR_PTR(-EAGAIN);
+
 	return nfs;
 }
 
-- 
2.46.2


