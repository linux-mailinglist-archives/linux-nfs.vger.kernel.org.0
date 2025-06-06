Return-Path: <linux-nfs+bounces-12163-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B65EAD05AB
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157EE17987D
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBD289E2E;
	Fri,  6 Jun 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBxP1cgc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B3193077;
	Fri,  6 Jun 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224587; cv=none; b=kUW2AAO/lsW9UQA+lO2SYPd9PcLNZkvg6+tcKR8m4keGSG/ZJDboe9GW4XHmsHc3Dp0Gh3ajfInwKYMDPSlVOXPKckyQTop13YqL69DWhq61PmF0FVLbBdB9lep68UASLOwFcIExVyVISHoKCinvBD1vBWA+k219F6i3/PWFshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224587; c=relaxed/simple;
	bh=2U8fu/FsqR+Va/O73Ag0GGC816gkjPxU3U8h3PBJqK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogVCXlUe7VBQ2l7tkP4KlpevNEUDCua5MoDNdGkdsDzOj6Hkcg8BKSIq7jtVBW/jjp6c3nlB6sZmDUNegHcDSHrzd1vonUgTuRVcT+Co1kgOZ3+tFMo7nMF0AjLshSfeAvjHazzZ4g97SaHDzATe/9cUNwVCGe9S4/FrbD32yiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBxP1cgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D75EC4CEEB;
	Fri,  6 Jun 2025 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224587;
	bh=2U8fu/FsqR+Va/O73Ag0GGC816gkjPxU3U8h3PBJqK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBxP1cgc0I3ZAObqG2yubGJ36NXzdnP4++6UNyQUH/h41rVtyzYp1htIB2XgvWJtn
	 btRdud3V9x1GrmzJaZn3MBexTAyVS+oXk3DVur1/TWD8scJWbf2ELVl83Rppzy5rK5
	 7FkOkps4UUJWTfk5ihZ9XiwRyqRsrWnib5PhPnxmkQF1D4tYtEU4OY0/ZNRoY03kiu
	 fMAYqFsveOqCGfv7KC22xnuwneEbQM8cch+iYunKfpPYk0TyGjjSThXQudCyhAx2om
	 i3sw16hH/3qP68Fxxto605SDnk8g1xPxCYf2xwq/2J+RViT9j0EWH/HvZLjRgCNoTJ
	 B5nJWsJWhVQcQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 05/15] NFSv4.2: fix listxattr to return selinux security label
Date: Fri,  6 Jun 2025 11:42:48 -0400
Message-Id: <20250606154259.547394-5-sashal@kernel.org>
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
index 11f2b5cb3b06b..9754af4c26f23 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10813,7 +10813,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3;
+	ssize_t error, error2, error3, error4;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10836,8 +10836,16 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
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


