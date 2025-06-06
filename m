Return-Path: <linux-nfs+bounces-12166-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B3AD05D2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E53E1883C7F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04637289E05;
	Fri,  6 Jun 2025 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oj98G8Cc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA5F276048;
	Fri,  6 Jun 2025 15:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224603; cv=none; b=uZo+Eef1FQUPVgToxOSdLY8AxgXxzzEWYHKLMkM0GHDxJIWY3bnfngL7rrGd5Glw3QSFIyNcc8b7VG7U7pI3J9Q5eB2i63gzBvC4rRmQUTMAAyDCfxX26cb4Hchlm3nbouNN6E47DnAnWRVhIQXZUNLwfvyKc2527Pw6tiuw2UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224603; c=relaxed/simple;
	bh=K2Vvlx49bKxac1Q2s8TQjgXQKkFutvARuvM9UVZEOnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYCoWjM/Y65GaGTjIaSMHoJWoqfkDnO055jjTxQX0zU+T7SP964oyNapCs9LTBS/DNTQKhHRfilO8H3VbUDUG109XUbBRD925P11+n1SXvTcnj8/5kStIhiqPRj5uRMDuiFFDztMfBlxVt1aOZoRBA/TSQDXNXCSqPPyRKIwB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oj98G8Cc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5EBC4CEEB;
	Fri,  6 Jun 2025 15:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224603;
	bh=K2Vvlx49bKxac1Q2s8TQjgXQKkFutvARuvM9UVZEOnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oj98G8CckT7lgd8biBa4rUMUH7Sd/xnk1Jg9q18J8BgMcOP0FYhM6PrN8lyYB+MMy
	 tlORTe3kxOukXT+txbRVLtfii+ibB8FZvkrEAd0zh3dS+DYGtpUUjiRfF78cj1pjAn
	 +kONDgqySv0gu/a7rpyBZIyxXjwSGgQt7esyU6RYUtkLBRPfyn/4nNLuIVhQHr8WDs
	 W2pSqflcz7fRcef5GBDODzo6Pi9paf0Ks4+9kIcPIVO05kHFcdJw2ZQ7CnqlX/atE4
	 JxtZ7uQOkjnQNbJiRUrD7CAykzEymcpaxrnPcVCfm3wiiSUfGWusKrEPyGSfknBYXT
	 6HaE/Um5Ivvhg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Scott Mayhew <smayhew@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 14/15] NFSv4: xattr handlers should check for absent nfs filehandles
Date: Fri,  6 Jun 2025 11:42:57 -0400
Message-Id: <20250606154259.547394-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154259.547394-1-sashal@kernel.org>
References: <20250606154259.547394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Transfer-Encoding: 8bit

From: Scott Mayhew <smayhew@redhat.com>

[ Upstream commit 6e9a2f8dbe93c8004c2af2c0158888628b7ca034 ]

The nfs inodes for referral anchors that have not yet been followed have
their filehandles zeroed out.

Attempting to call getxattr() on one of these will cause the nfs client
to send a GETATTR to the nfs server with the preceding PUTFH sans
filehandle.  The server will reply NFS4ERR_NOFILEHANDLE, leading to -EIO
being returned to the application.

For example:

$ strace -e trace=getxattr getfattr -n system.nfs4_acl /mnt/t/ref
getxattr("/mnt/t/ref", "system.nfs4_acl", NULL, 0) = -1 EIO (Input/output error)
/mnt/t/ref: system.nfs4_acl: Input/output error
+++ exited with 1 +++

Have the xattr handlers return -ENODATA instead.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit, I can now provide my assessment.

**YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **It fixes a real user-visible bug**: The commit addresses an issue
   where attempting to call `getxattr()` on NFS referral anchors that
   haven't been followed yet causes an I/O error (-EIO) to be returned
   to applications. The example in the commit message clearly
   demonstrates this:
  ```
  $ strace -e trace=getxattr getfattr -n system.nfs4_acl /mnt/t/ref
  getxattr("/mnt/t/ref", "system.nfs4_acl", NULL, 0) = -1 EIO
  (Input/output error)
  ```

2. **The fix is minimal and contained**: The changes are very small -
   just adding two simple checks:
  ```c
  if (unlikely(NFS_FH(inode)->size == 0))
  return -ENODATA;
  ```
  These checks are added to both `nfs4_proc_get_acl()` and
  `nfs4_proc_set_acl()` functions.

3. **Low risk of regression**: The fix is straightforward and only
   affects the specific error path when filehandles are zero-sized
   (which occurs for referral anchors that haven't been followed). It
   doesn't change any core logic or introduce new features.

4. **Improves application compatibility**: Returning -ENODATA instead of
   -EIO is more semantically correct. Applications expect -ENODATA when
   extended attributes are not available, while -EIO suggests a more
   serious I/O problem.

5. **Follows stable kernel rules**: This fix:
   - Fixes a real bug that affects users
   - Is small and self-contained
   - Has minimal risk of introducing new issues
   - Doesn't add new features or make architectural changes

The commit addresses a specific edge case in NFSv4 where referral
anchors (mount points that redirect to other servers) have zero-length
filehandles until they are actually accessed. When applications try to
read extended attributes on these special inodes, the kernel would
previously send invalid GETATTR requests to the server, resulting in
confusing I/O errors. This fix makes the behavior more predictable and
correct by returning -ENODATA, which indicates that the requested
attribute doesn't exist.

 fs/nfs/nfs4proc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index c70e84e55dcdb..de71f04b2702a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6173,6 +6173,8 @@ static ssize_t nfs4_proc_get_acl(struct inode *inode, void *buf, size_t buflen,
 	struct nfs_server *server = NFS_SERVER(inode);
 	int ret;
 
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	if (!nfs4_server_supports_acls(server, type))
 		return -EOPNOTSUPP;
 	ret = nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
@@ -6247,6 +6249,9 @@ static int nfs4_proc_set_acl(struct inode *inode, const void *buf,
 {
 	struct nfs4_exception exception = { };
 	int err;
+
+	if (unlikely(NFS_FH(inode)->size == 0))
+		return -ENODATA;
 	do {
 		err = __nfs4_proc_set_acl(inode, buf, buflen, type);
 		trace_nfs4_set_acl(inode, err);
-- 
2.39.5


