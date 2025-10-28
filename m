Return-Path: <linux-nfs+bounces-15732-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0465AC16E40
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 22:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B653A8EAE
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Oct 2025 21:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A92DC35C;
	Tue, 28 Oct 2025 21:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVp+7WEX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA42DC331
	for <linux-nfs@vger.kernel.org>; Tue, 28 Oct 2025 21:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686004; cv=none; b=MsWhFAiPnumB4VSmWEaDM+UbLbsBHJ6uzIdgGy8WhMKxDlRsn4zl2qFkrniCd+oLL41l+Zt+L8mrrWf2jj5SaG63Hsqo+/02VJbF8J4j2Za5e1toWWLfgTgIhzpfm1rjws6tV8ysev6I59f4+BXIzSc3/KsDA+D0TObFtfn+B3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686004; c=relaxed/simple;
	bh=tX3WEQUkuRAFyVxhbbo7FittSjc2P2+qSl+7OnIoEzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCuoeEIxRq1XXJwmyNq7QfuaOQ9bjZVcnIW5m5SgmIYPH8aH0OZjX0TIjRs6Rn4imUKd/5JKJMKYwpaaiefGMsZGoDoQfaZWJ/zpx1Va4tvNwn0+D+NRBJE6WlrmLNtCxe6ybcccmzkxL1nUHHNRTHYnOQEc+UkLcng8UrPskk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVp+7WEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9BDC4CEFF;
	Tue, 28 Oct 2025 21:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761686003;
	bh=tX3WEQUkuRAFyVxhbbo7FittSjc2P2+qSl+7OnIoEzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MVp+7WEXJFOlh3FbsUiMXbqymtY5FIoKkWR7rlCAJQcr7MDpsUy0thZBWb2JNtkAe
	 QSif18oMLl5ZuClglqIUKNKoVHEB4wJdMTX6233ISXAuLRo4ber/x22LOohU1AZxE8
	 pn3Bq7tQjcZf0f3C14U3YCWzqgMsBUPbHB8ZDaEBUQtPgKyTk4WNSZBYytWU44NvKm
	 bEw5m2mYDYZ70F0xIpexpUymCXqrvnYIjbfR+UbkTdAS8rvLhRzac/snkGXJTIYiRK
	 Qh7kdu0Dd4tl7ZmRfe0RpCMRPsf87C45aykabwqaSLIQipPGlV4TZ+MlFFuHc6utWX
	 A+fWfqvFlS4hw==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Stephen Abbene <sabbene87@gmail.com>,
	NeilBrown <neilb@ownmail.net>
Subject: [PATCH 2/2] NFSv2/v3: Fix handling of O_DIRECTORY in nfs_atomic_open_v23()
Date: Tue, 28 Oct 2025 17:13:21 -0400
Message-ID: <e2f155bfe472fc3c669ba33b19592f8187adaf5e.1761685801.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <a523a1f55710c2b55b86e2c6c4dfcf147677b7ec.1761685801.git.trond.myklebust@hammerspace.com>
References: <a523a1f55710c2b55b86e2c6c4dfcf147677b7ec.1761685801.git.trond.myklebust@hammerspace.com>
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


