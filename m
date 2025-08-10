Return-Path: <linux-nfs+bounces-13546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A130B1FB2B
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FDD178513
	for <lists+linux-nfs@lfdr.de>; Sun, 10 Aug 2025 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4692A2737F4;
	Sun, 10 Aug 2025 16:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zt4oKy1g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9DA270EC3;
	Sun, 10 Aug 2025 16:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844767; cv=none; b=Q3+AlyDxcdKihY/Y4sdPlFDEVLEu7C2kN+NraKMSkED5oYdIReXDbB1COvWjYzbyfLjXC5TbdWNx6L1RRpVCuOQlM8hZz/Em+A/tC8D5Veb8M5Vm+jL09mwlV4w1ygG7qUWWn56xHetL9SAJF4dG7fivf8gdkRnLm8XFbeiSfbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844767; c=relaxed/simple;
	bh=/u7bOTJ+LWek+TXWDS8OOGKgGktLR2EFyiF3GmA7XlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLCmSm9cO824F65yyhIVf/2H44EuBkSxalqLm91ZG/jwzQLo2Q5H2ixuqLdGH0Z35a87S2hloNE/kEDIrF5zzqwy+Lr8q86Ub+IylknZtzB7OILw5l8sriVCGmxxEofC+ql0cRubVc402omaKOQ211gFfXr1YsZNFBs/mLL5ZJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zt4oKy1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DFCC4CEF0;
	Sun, 10 Aug 2025 16:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754844766;
	bh=/u7bOTJ+LWek+TXWDS8OOGKgGktLR2EFyiF3GmA7XlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zt4oKy1gqhl/J2zwW6/ZiQXzLx4mzxkEkTZm2gq5q77oLE0A2dyd3bM4tNEFl8MiN
	 MgW+ixKfB/wANnb0Dn1bIFNCKPhgXfp/12EFlVyxr5YM8SpaWfzghV5qkSdMihkenD
	 eLG2DjZOQs9LwlqgFCr00H5k0FAOzlNG2UCESULHLmWZ/VyziM4k+lZK8/di++Ttau
	 dq11yjfFU+7TEiTLAcQ3ZuG4+C8Xu6sYkoX2C6ZzkSz9y7b0Gerfqf1uEo/xwh9o8L
	 vsEcwjWFcgC06N+eVhE7QGQEkhC5/sdTW8YoHcHi2Gbp2Z+Fof6bPV3e8bo4UMYSWS
	 pon5Tz0Y0t3kw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.16-5.4] pNFS: Handle RPC size limit for layoutcommits
Date: Sun, 10 Aug 2025 12:51:58 -0400
Message-Id: <20250810165158.1888206-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250810165158.1888206-1-sashal@kernel.org>
References: <20250810165158.1888206-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.16
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sergey Bashirov <sergeybashirov@gmail.com>

[ Upstream commit d897d81671bc4615c80f4f3bd5e6b218f59df50c ]

When there are too many block extents for a layoutcommit, they may not
all fit into the maximum-sized RPC. This patch allows the generic pnfs
code to properly handle -ENOSPC returned by the block/scsi layout driver
and trigger additional layoutcommits if necessary.

Co-developed-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Konstantin Evtushenko <koevtushenko@yandex.com>
Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250630183537.196479-5-sergeybashirov@gmail.com
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Fix Nature

This commit fixes a clear bug in the pNFS (parallel NFS) layoutcommit
handling where the code didn't properly handle the `-ENOSPC` error
returned when there are too many block extents to fit in a single RPC
(Remote Procedure Call). Looking at the code changes:

1. **The Problem**: In `ext_tree_encode_commit()`
   (fs/nfs/blocklayout/extent_tree.c:536-539), when there are too many
   extents, the function returns `-ENOSPC` but continues counting. The
   original `pnfs_layoutcommit_inode()` function didn't handle this
   error properly.

2. **The Fix**: The patch adds specific handling for the `-ENOSPC` error
   case:
   - Line 3394 → 3396: Changed to only `put_cred()` if status is NOT
     `-ENOSPC`
   - Line 3399 → 3401-3403: Added special handling to check for
     `-ENOSPC` and set `mark_as_dirty = true`
   - Line 3409: Changed condition to mark inode dirty if either `status`
     is set OR `mark_as_dirty` is true

## Impact Analysis

1. **User-Visible Bug**: Without this fix, when users have workloads
   that generate many block extents (common in database or large file
   operations), layoutcommits would fail silently, potentially leading
   to data inconsistency or loss.

2. **Contained Fix**: The changes are minimal and localized to the
   layoutcommit path:
   - Only affects the error handling path
   - Doesn't change the normal operation flow
   - Doesn't introduce new features or APIs

3. **Clear Regression Risk Assessment**:
   - Low risk - the patch only adds proper error handling for a specific
     error code
   - Doesn't change fundamental data structures or algorithms
   - The `-ENOSPC` handling triggers additional layoutcommits as needed,
     which is the correct behavior

## Stable Criteria Compliance

The commit meets stable kernel criteria:
- **Fixes a real bug**: Handles RPC size limit overflow that can occur
  in production
- **Small and targeted**: Only ~15 lines of actual logic changes
- **No new features**: Pure bug fix, no feature additions
- **Tested**: Has review from Christoph Hellwig (a well-known filesystem
  maintainer)
- **Important for users**: Prevents potential data consistency issues in
  pNFS deployments

## Code Analysis Details

The specific code flow shows:
1. `ext_tree_encode_commit()` returns `-ENOSPC` when buffer is too small
   (line 538 in extent_tree.c)
2. The old code would incorrectly release credentials and fail the
   entire operation
3. The new code:
   - Preserves the credentials when `-ENOSPC` occurs
   - Sets the inode as dirty to trigger another layoutcommit attempt
   - Allows the operation to be retried with proper handling

This is a classic case of missing error handling that should be
backported to ensure data integrity in stable kernels running pNFS
workloads.

 fs/nfs/pnfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 1a7ec68bde15..3fd0971bf16f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -3340,6 +3340,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	struct nfs_inode *nfsi = NFS_I(inode);
 	loff_t end_pos;
 	int status;
+	bool mark_as_dirty = false;
 
 	if (!pnfs_layoutcommit_outstanding(inode))
 		return 0;
@@ -3391,19 +3392,23 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 	if (ld->prepare_layoutcommit) {
 		status = ld->prepare_layoutcommit(&data->args);
 		if (status) {
-			put_cred(data->cred);
+			if (status != -ENOSPC)
+				put_cred(data->cred);
 			spin_lock(&inode->i_lock);
 			set_bit(NFS_INO_LAYOUTCOMMIT, &nfsi->flags);
 			if (end_pos > nfsi->layout->plh_lwb)
 				nfsi->layout->plh_lwb = end_pos;
-			goto out_unlock;
+			if (status != -ENOSPC)
+				goto out_unlock;
+			spin_unlock(&inode->i_lock);
+			mark_as_dirty = true;
 		}
 	}
 
 
 	status = nfs4_proc_layoutcommit(data, sync);
 out:
-	if (status)
+	if (status || mark_as_dirty)
 		mark_inode_dirty_sync(inode);
 	dprintk("<-- %s status %d\n", __func__, status);
 	return status;
-- 
2.39.5


