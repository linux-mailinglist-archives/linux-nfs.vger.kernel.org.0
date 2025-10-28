Return-Path: <linux-nfs+bounces-15734-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A55C1701B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4164F3571FD
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 21:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4622350D76;
	Tue, 28 Oct 2025 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc2EcUZT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43A350D71
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686868; cv=none; b=jiXzOLGQQG5tDCrFPW07rwCCEjvHmKmcgTZ2UraEo5poUM2VY8mOsWPLc9DeglSkw92QoZB4XAFk0zJNZqsxhSxjLr+eN/Wy9EWysYWydIO9T47KWu0xorvDjgS+6xXIX/Gqx3Man2INZe31LHMDc+IEpQJvHjabxnV45uIBz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686868; c=relaxed/simple;
	bh=tX3WEQUkuRAFyVxhbbo7FittSjc2P2+qSl+7OnIoEzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAgUl6Qmlm7gND3HlmYG0jyDcSXcq9I+3FMUUBj4h9ktQhsnXSIlLZ0PaJ2eJR/slquGXuYX3BqT1pHqLpD/0vmaW9zrmyNxA0aw5ZtoMtRsHOciDF7oF56nLFLk7zwRzdrea5E2032fv+Ks6PxAFFBpER3+RkO7o1GGNTqoEWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mc2EcUZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2928C113D0;
	Tue, 28 Oct 2025 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761686867;
	bh=tX3WEQUkuRAFyVxhbbo7FittSjc2P2+qSl+7OnIoEzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mc2EcUZTQ+VCwKXngHjjIdqCeOm/mPTD5V6lTSGWs/RtvSz5Z2MPmG6qfDDkZPExm
	 Cr4MAl8HS1Z28HwFvM6YTjUoEMpnO35/81thIClVRWvkr/894nW1V1yPa9rdiRhGQo
	 nalJzjOc0VjHHmapvSxrcuhdP2LOvWpNWgxqV4bkpvsqcRfQUkjrQmpzmscwK4VLQ4
	 3XVyXVfV29zaf6RjFJjj4Ae2Q7bJnPiRUjxA3LzSKKg8p7j7Uvgezm1Tjd58Y7g+X6
	 zyaHiCxYtOxLpezsiVVQidEVEpnM4NRG0EKPdUsNciqtNS+EVnpjCaI3cEb8HDJ7s3
	 FgHkyNH+OLHfA==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Stephen Abbene <sabbene87@gmail.com>,
	NeilBrown <neilb@ownmail.net>
Subject: [PATCH v2 2/2] NFSv2/v3: Fix handling of O_DIRECTORY in nfs_atomic_open_v23()
Date: Tue, 28 Oct 2025 17:27:44 -0400
Message-ID: <733195cf9970e6590f556548a18a57dfe6114ab9.1761686833.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <03e3a5a82187cfc7936b87ce92ee001b27e18878.1761686833.git.trond.myklebust@hammerspace.com>
References: <03e3a5a82187cfc7936b87ce92ee001b27e18878.1761686833.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the application sets the O_DIRECTORY flag, and tries to open a
regular file, the correct response is to return -ENOTDIR as is done in
the NFSv4 atomic open case.

Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correctly.")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index ea9f6ca8f30f..dedd12cc1fc8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2259,6 +2259,7 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 			umode_t mode)
 {
 	struct dentry *res = NULL;
+	struct inode *inode;
 	/* Same as look+open from lookup_open(), but with different O_TRUNC
 	 * handling.
 	 */
@@ -2267,7 +2268,7 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		return -ENAMETOOLONG;
 
-	if (open_flags & O_CREAT) {
+	if ((open_flags & O_CREAT) && !(open_flags & O_DIRECTORY)) {
 		error = nfs_do_create(dir, dentry, mode, open_flags);
 		if (!error) {
 			file->f_mode |= FMODE_CREATED;
@@ -2275,12 +2276,27 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 		} else if (error != -EEXIST || open_flags & O_EXCL)
 			return error;
 	}
+
 	if (d_in_lookup(dentry)) {
 		/* The only flags nfs_lookup considers are
 		 * LOOKUP_EXCL and LOOKUP_RENAME_TARGET, and
 		 * we want those to be zero so the lookup isn't skipped.
 		 */
 		res = nfs_lookup(dir, dentry, 0);
+		if (!res) {
+			inode = d_inode(dentry);
+			if ((open_flags & O_DIRECTORY) && inode &&
+			    !(S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode)))
+				res = ERR_PTR(-ENOTDIR);
+		} else if (!IS_ERR(res)) {
+			inode = d_inode(res);
+			if ((open_flags & O_DIRECTORY) && inode &&
+			    !(S_ISDIR(inode->i_mode) ||
+			      S_ISLNK(inode->i_mode))) {
+				dput(res);
+				res = ERR_PTR(-ENOTDIR);
+			}
+		}
 	}
 	return finish_no_open(file, res);
 
-- 
2.51.0


