Return-Path: <linux-nfs+bounces-12176-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41220AD060F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B13318843C2
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643FD28A41B;
	Fri,  6 Jun 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrxltWvp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F58289800;
	Fri,  6 Jun 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224665; cv=none; b=arj+kinIPPBhZmlvMQhucyt0Axj/jGqKW9tg1g94iejP1/aJEs7i3fMICDQ9u4WzWAaI+QCOGa7hea3D17bIa2pOmsNIWr/c1Uq+/VsKl/zhXpczTXFGLD3TLhzJ3ZPic3NeIbXiRj+Gk7Ea5sq3zs4fkt3BPDMRjVrVB9baO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224665; c=relaxed/simple;
	bh=ZJlegHO9KmjdIJV9wMobS9d/AF1kTCLe3V0sQp+kV+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KQvoicwioFAr3HTIkdQDqEFDyjOdgbU+yspGmA7Qi8QC/in+8ypScR2f4IYluzyDnDSmjfg6vzIw0tF2zk7Yo1wRBKzHWr3QMZ5Y8+2FuA8rZIA/vsczKO0Cw4FFDqM0LHBdJns0N44vB8zwL+Q3m97ZzZIWiWy54VVVgNck4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrxltWvp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D627C4CEEB;
	Fri,  6 Jun 2025 15:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224665;
	bh=ZJlegHO9KmjdIJV9wMobS9d/AF1kTCLe3V0sQp+kV+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrxltWvpQoxG5lEeUSM1GsMPSYD25PWXnghzhp0MRfVQwvaaCYERcsUPZgp+mD5GL
	 3nOjgdlo8rCFZ+FBJdYh+CdzPw/uarzgS6TceOCKEKK/LPxHdF9p9oKny28OBnOkLJ
	 YcIxDyqDzjApKTOPle/WOr4JnW78+CN2kIfLWrF3FMo+GQ7jlU0vaYbl32i/+9QbQj
	 wD5vWCegKEAC2OzqxSlp2aG6ebc4r/2InF0qU56hjP12vLCLvr5DsfVHR9FVkb7tAx
	 /aUzMBZLbYc54+qMC9U5krRWlEzGjPWUDaFA9AIEvjusFyVrL5G6c2uQPgnBQkiY5W
	 pqTyNoRG5RcxA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/6] NFSv4.2: fix listxattr to return selinux security label
Date: Fri,  6 Jun 2025 11:44:16 -0400
Message-Id: <20250606154421.548570-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154421.548570-1-sashal@kernel.org>
References: <20250606154421.548570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.238
Content-Transfer-Encoding: 8bit

From: Olga Kornievskaia <okorniev@redhat.com>

[ Upstream commit 243fea134633ba3d64aceb4c16129c59541ea2c6 ]

Currently, when NFS is queried for all the labels present on the
file via a command example "getfattr -d -m . /mnt/testfile", it
does not return the security label. Yet when asked specifically for
the label (getfattr -n security.selinux) it will be returned.
Include the security label when all attributes are queried.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Bug Analysis The commit fixes a clear
functional bug in NFSv4.2's `listxattr` implementation in
`fs/nfs/nfs4proc.c:10853`. When users run `getfattr -d` to list all
extended attributes, the security label (like SELinux context) is
missing from the output, even though it's correctly returned when
specifically requested with `getfattr -n security.selinux`. ## Code
Change Analysis The fix is minimal and well-contained: 1. **Variable
addition**: Adds `error4` to track the security label listing result 2.
**Function call**: Adds `error4 =
security_inode_listsecurity(d_inode(dentry), list, left)` 3. **Pointer
management**: Updates `list` and `left` after `error3` processing
(missing in original) 4. **Total calculation**: Changes `error += error2
+ error3` to `error += error2 + error3 + error4` ## Why This Qualifies
for Backport **1. Clear User-Facing Bug**: The inconsistency between
`getfattr -d` and `getfattr -n security.selinux` affects real-world
usage and user expectations. **2. Minimal Risk**: The change is
architecturally simple - it just adds another xattr source to the
listing function, following the exact same pattern as existing `error2`
and `error3` handling. **3. Follows Existing Patterns**: The commit uses
the same error handling, pointer arithmetic, and function call pattern
established by `nfs4_listxattr_nfs4_label()` and
`nfs4_listxattr_nfs4_user()`. **4. No Feature Addition**: This fixes
existing functionality rather than adding new features. **5. Critical
Subsystem**: Extended attributes and security labels are fundamental for
SELinux environments, making this fix important for security-conscious
deployments. **6. Similar Historical Precedent**: All 5 provided
reference commits with "Backport Status: YES" are NFSv4 security label
fixes with similar characteristics - small, contained bugfixes in the
same subsystem. **7. Contained Scope**: The change is isolated to one
function (`nfs4_listxattr`) in one file, with no cross-subsystem
implications. The fix correctly implements the missing piece: while
`nfs4_listxattr_nfs4_label()` calls `security_inode_listsecurity()` when
`CONFIG_NFS_V4_SECURITY_LABEL` is enabled, the main `nfs4_listxattr()`
function wasn't calling it directly for the general xattr listing case,
creating the inconsistent behavior reported.

 fs/nfs/nfs4proc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1005ecf7c250b..77cc1c4219e15 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10378,7 +10378,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3;
+	ssize_t error, error2, error3, error4;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10401,8 +10401,16 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 	error3 = nfs4_listxattr_nfs4_user(d_inode(dentry), list, left);
 	if (error3 < 0)
 		return error3;
+	if (list) {
+		list += error3;
+		left -= error3;
+	}
+
+	error4 = security_inode_listsecurity(d_inode(dentry), list, left);
+	if (error4 < 0)
+		return error4;
 
-	error += error2 + error3;
+	error += error2 + error3 + error4;
 	if (size && error > size)
 		return -ERANGE;
 	return error;
-- 
2.39.5


