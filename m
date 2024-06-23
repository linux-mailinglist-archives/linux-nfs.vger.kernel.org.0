Return-Path: <linux-nfs+bounces-4245-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54604913B53
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842951C20CA0
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A36198A11;
	Sun, 23 Jun 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyKCnfA6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA2E19885E;
	Sun, 23 Jun 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150323; cv=none; b=CrTvwQ6DKHFMlJ8suTplNAVLuDSS+o1S/ajSrK641IGIFo19oSLQYnjGoNdGdrqQX2aN6Z2TFul+ZGsNAAqa6kOj98Nq9XCHz5O4Z2yZSWIanaysQavAsn3FpXV1bDxdVIN2PW+kMWHP7g5ce7hAEy/awFlkljglh7tJUFlJAMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150323; c=relaxed/simple;
	bh=UUo2SyS75Bj4bJ/S5uK/Xt4YbdlqtzPoRRbmj8jZGEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1z/UGiUAPQ2QvXOXrRhZwMzVh/zWoIl6BSI08lJ+fvyUXdxH1Ka0l6K8XLBRtXzQCT03bxzH1Al/M1ZqQmQ++meSCNnKMJVl92RCT/6SSGC/Rt5npxuoKordkt6xEnjAfKwJ4ohVb8XzZT5/sxNd/LvQoHgjzX9V9vi2sU9+w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyKCnfA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C46AC4AF07;
	Sun, 23 Jun 2024 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150323;
	bh=UUo2SyS75Bj4bJ/S5uK/Xt4YbdlqtzPoRRbmj8jZGEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MyKCnfA6e+0Z7iY5QjqlUs/IMb5zADsrSnpEcG45U/oW9kGN2EWGRktpaA7BO5eP9
	 6eg65QHvV1QW6T7QcwNhRaSMSsR60/QamlgOKannhHFiextvsog+mCiS6XolQW9kmh
	 gsgj1IWi7Zz8PSvM889PEYVC+nvc4v8Po0MbMpBopLjwbzIq1AnkhB+C9SSL69R99o
	 +8pRezcsPMBBCbm88HVjaIYxsabWMCLkeUdC1mKj9PPCSg6Nquo3j6ss79iwfRPBFK
	 adXcHGM3PZpNt2N0WLcVo6RAvzd5D8CPe29VzMB3ywH4hjMy5fMgzMJOxhWqYdabbp
	 KrSlP/+lZpNNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Scott Mayhew <smayhew@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/12] nfs: don't invalidate dentries on transient errors
Date: Sun, 23 Jun 2024 09:45:06 -0400
Message-ID: <20240623134518.809802-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 0c8c7c559740d2d8b66048162af6c4dba8f0c88c ]

This is a slight variation on a patch previously proposed by Neil Brown
that never got merged.

Prior to commit 5ceb9d7fdaaf ("NFS: Refactor nfs_lookup_revalidate()"),
any error from nfs_lookup_verify_inode() other than -ESTALE would result
in nfs_lookup_revalidate() returning that error (-ESTALE is mapped to
zero).

Since that commit, all errors result in nfs_lookup_revalidate()
returning zero, resulting in dentries being invalidated where they
previously were not (particularly in the case of -ERESTARTSYS).

Fix it by passing the actual error code to nfs_lookup_revalidate_done(),
and leaving the decision on whether to  map the error code to zero or
one to nfs_lookup_revalidate_done().

A simple reproducer is to run the following python code in a
subdirectory of an NFS mount (not in the root of the NFS mount):

---8<---
import os
import multiprocessing
import time

if __name__=="__main__":
    multiprocessing.set_start_method("spawn")

    count = 0
    while True:
        try:
            os.getcwd()
            pool = multiprocessing.Pool(10)
            pool.close()
            pool.terminate()
            count += 1
        except Exception as e:
            print(f"Failed after {count} iterations")
            print(e)
            break
---8<---

Prior to commit 5ceb9d7fdaaf, the above code would run indefinitely.
After commit 5ceb9d7fdaaf, it fails almost immediately with -ENOENT.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/dir.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a5a4d9422d6ed..70660ff248b79 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1615,7 +1615,16 @@ nfs_lookup_revalidate_done(struct inode *dir, struct dentry *dentry,
 	switch (error) {
 	case 1:
 		break;
-	case 0:
+	case -ETIMEDOUT:
+		if (inode && (IS_ROOT(dentry) ||
+			      NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL))
+			error = 1;
+		break;
+	case -ESTALE:
+	case -ENOENT:
+		error = 0;
+		fallthrough;
+	default:
 		/*
 		 * We can't d_drop the root of a disconnected tree:
 		 * its d_hash is on the s_anon list and d_drop() would hide
@@ -1670,18 +1679,8 @@ static int nfs_lookup_revalidate_dentry(struct inode *dir,
 
 	dir_verifier = nfs_save_change_attribute(dir);
 	ret = NFS_PROTO(dir)->lookup(dir, dentry, fhandle, fattr);
-	if (ret < 0) {
-		switch (ret) {
-		case -ESTALE:
-		case -ENOENT:
-			ret = 0;
-			break;
-		case -ETIMEDOUT:
-			if (NFS_SERVER(inode)->flags & NFS_MOUNT_SOFTREVAL)
-				ret = 1;
-		}
+	if (ret < 0)
 		goto out;
-	}
 
 	/* Request help from readdirplus */
 	nfs_lookup_advise_force_readdirplus(dir, flags);
@@ -1725,7 +1724,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 			 unsigned int flags)
 {
 	struct inode *inode;
-	int error;
+	int error = 0;
 
 	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
 	inode = d_inode(dentry);
@@ -1770,7 +1769,7 @@ nfs_do_lookup_revalidate(struct inode *dir, struct dentry *dentry,
 out_bad:
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
-	return nfs_lookup_revalidate_done(dir, dentry, inode, 0);
+	return nfs_lookup_revalidate_done(dir, dentry, inode, error);
 }
 
 static int
-- 
2.43.0


