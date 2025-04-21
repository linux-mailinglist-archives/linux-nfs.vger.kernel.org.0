Return-Path: <linux-nfs+bounces-11208-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36157A95629
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 20:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173CD3B0515
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Apr 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DD81DF27D;
	Mon, 21 Apr 2025 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICIJdf0s"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348DA134BD
	for <linux-nfs@vger.kernel.org>; Mon, 21 Apr 2025 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261565; cv=none; b=rLfupY1vMDzgfyWi3dz/2iiBZYp7093yf3g9j1eQBtPkZx9SVwy8KQRH2MFSD1DqgR5bWko0l1O1VE7l+/4PxT0lGRz459OF0iM8FsaAhEpyhJNqPcIzGv660IjsOt+HU4YQUNFGCEg1dOd+rXWUqxDsbv17gItPnSrkY4Sa620=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261565; c=relaxed/simple;
	bh=7Rz0BGp4Zg85WjhaAqlWtX6BSucs5Notf53gZ41DloE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GxAp2ea4d4EYalsAtVnwz9oh6aX1DQRymZQTKKDxK1bCjCq+Fc9x5BM/zwsIyz5FEyjH3zTvz/IjZMaT0yxW17cFq0iAzJr2LVOBZkUI8vgyZUzfPPDbgdGIG+thfrSK+EnjIpTbLLJYgrTcvU0p6Ge9I8ZqilQw5L8+VMF+HTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICIJdf0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54085C4CEE4;
	Mon, 21 Apr 2025 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261564;
	bh=7Rz0BGp4Zg85WjhaAqlWtX6BSucs5Notf53gZ41DloE=;
	h=From:To:Cc:Subject:Date:From;
	b=ICIJdf0s3fhTrgUZ42sY4+hrN8zK+cxukt1fSLGd3IXK8QRkGtR6BsfMOG1m3REmy
	 ZYwrqhp0oN/LNAUN/5UQ12fG3x2Erbpbh+1JKJkhELjt09b/wgqCoz8zz+5CqPASXD
	 yxiIxCN+81XWpwb//M2wY1fCM4AGQFXzVnx/iiQMA1NQ1uZ56GE2OX5SuuBJWQsMvT
	 MRZ/SXj6s+vaKzyWR1AwfdGaRUkkAx1OE0a5XH7+aMcHAj7vEXmG1FGdVVHhXajEec
	 OPdflyes+CK0TBfl1rM3+Q8AuYZJqjZk2gGhO7rh1NzOosPtn7BlMW4bw9rOfKlNh0
	 S0lLofx6wRFkg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH] NFS/localio: Fix a race in nfs_local_open_fh()
Date: Mon, 21 Apr 2025 14:52:42 -0400
Message-ID: <3d2d3ade569302f7d52307d71e0fe1c46fc95f32.1745261446.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Once the clp->cl_uuid.lock has been dropped, another CPU could come in
and free the struct nfsd_file that was just added. To prevent that from
happening, take the RCU read lock before dropping the spin lock.

Fixes: 86e00412254a ("nfs: cache all open LOCALIO nfsd_file(s) in client")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/localio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 5c21caeae075..4ec952f9f47d 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -278,6 +278,7 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 		new = __nfs_local_open_fh(clp, cred, fh, nfl, mode);
 		if (IS_ERR(new))
 			return NULL;
+		rcu_read_lock();
 		/* try to swap in the pointer */
 		spin_lock(&clp->cl_uuid.lock);
 		nf = rcu_dereference_protected(*pnf, 1);
@@ -287,7 +288,6 @@ nfs_local_open_fh(struct nfs_client *clp, const struct cred *cred,
 			rcu_assign_pointer(*pnf, nf);
 		}
 		spin_unlock(&clp->cl_uuid.lock);
-		rcu_read_lock();
 	}
 	nf = nfs_local_file_get(nf);
 	rcu_read_unlock();
-- 
2.49.0


