Return-Path: <linux-nfs+bounces-12153-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9CAAD0567
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE75162603
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFEF193077;
	Fri,  6 Jun 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eml82dER"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728C013DBA0;
	Fri,  6 Jun 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224515; cv=none; b=QueA75HKhQSMnDosTIp/dGzEUOkyU1Y3lGfEDO+xYeClD60uqWoElB5mcUsczL3X/1vSEqZPFFsCh5DBHbHFmgIuSTukc04/KZo3YfhJapRWtfLzBv0KtuSGOf9VnATH9/bTXzQorpY2ZokWfJEsbkg3USBra4MA9D/5NoPDFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224515; c=relaxed/simple;
	bh=Dv+nWQH86r4lM0mfXsvKsfDhua0xq1i3yr9NrX0avbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxk/04C0sjm8KK93bcbKqoE+5sWc/iuaNITMe+cD+81VM54a0s3fg4JAsM5Hcjep+SRmYBikPW22PbjTvXIOoD3y4VObQlPTS3dv/Yk33DK8jt90W3FiErpyYARmTeEXTBXxCAYhJx7/WOlDpB9vW6A2Agkb+TqJ7usTDnvOT38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eml82dER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57685C4CEF2;
	Fri,  6 Jun 2025 15:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224515;
	bh=Dv+nWQH86r4lM0mfXsvKsfDhua0xq1i3yr9NrX0avbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eml82dERjp7KHR+hRBIdr+a7EyDrb2IXjqqsLC8glLjt0wm8gVGYNCkSRSEaUEIl+
	 BrEFPxCz5LgOuGCmm3VnY+euVDCeEHOwvyjWXuYAovoGXarqR4AXCnpZ52ADufYgwh
	 l33XE/Zmrmkp7fKlpBbeA3C59kgrts6EMJcoh9PiXBQchjBBr5Ehq51/5gJ1F/fFEW
	 l9KxS2zANqTtTYPjWkYkgmLjwDoF7vLGc4miA+SBEfjpZDZfQO5UHCpEu7cpEjInXw
	 2csqyn9HLxHyoDzqbTQKOYKcYakOWI0I+dS6u5Z38UTA+CiC2EEMODmeRfjtteIpj1
	 pmyyOoWEBiEhg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 05/21] NFSv4.2: fix listxattr to return selinux security label
Date: Fri,  6 Jun 2025 11:41:30 -0400
Message-Id: <20250606154147.546388-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154147.546388-1-sashal@kernel.org>
References: <20250606154147.546388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.1
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
index b1d2122bd5a74..a3a6fc4e3e7f5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -10852,7 +10852,7 @@ const struct nfs4_minor_version_ops *nfs_v4_minor_ops[] = {
 
 static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
 {
-	ssize_t error, error2, error3;
+	ssize_t error, error2, error3, error4;
 	size_t left = size;
 
 	error = generic_listxattr(dentry, list, left);
@@ -10875,8 +10875,16 @@ static ssize_t nfs4_listxattr(struct dentry *dentry, char *list, size_t size)
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


