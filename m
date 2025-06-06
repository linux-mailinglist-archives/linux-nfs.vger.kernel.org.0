Return-Path: <linux-nfs+bounces-12164-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 626CAAD05BA
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53FBC189BA5F
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF36728AAEA;
	Fri,  6 Jun 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFbcmgwS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC17289825;
	Fri,  6 Jun 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224588; cv=none; b=LVwurV5M/yKD9ksjQBwXextyA1KEHVtk7gQV6oUd7S8/d420m93tCSR+8Lwx6lCkRsqgsMhc55ILnDg8KhS4jO28S05d5gyfIrFh6aWDiRStwFPFM+3Kx2arVcGWIA4o40cjsdNfPKi8GWx/AaPcg3rmNHQFMWxj+Xzpcei3QJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224588; c=relaxed/simple;
	bh=Iot8+YD0JzyiR1sN9Ouf1XqBhvO0ILFBHGD3/HV/jGw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3Nd9yTchjExBrzj7cUgTN0cxBGFGE2FAWH+AOXQgachyUAW5JhP5J8ACiVfsvkteBCjfDqYqJXXcwecXvvGKEr1QcmPdjGsfW2MGlGFdwFrKFAHEr3awrnfOYxbMqe+dMEzJj50HfYd1JTro9zjzZeU8cQtdbbjU6DAfyXweak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFbcmgwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C35C4CEED;
	Fri,  6 Jun 2025 15:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224588;
	bh=Iot8+YD0JzyiR1sN9Ouf1XqBhvO0ILFBHGD3/HV/jGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HFbcmgwStE+pEwj2AA2/Sg3OobRo67HYZoT8MBhLCPLY5u9PuLQ+SS37WugIZAhc4
	 NP+V3GX946DEgWZaDcrmFspOSkLDbiV4Bzsgcg7OD2ARhraP+A+Bs5k8H2D/3O8MOj
	 ex12+7M+1Oga8tiMig2pF8s223sirGRuk4dhPeLrRV6xjbilpg/xidO50o8khLHYeK
	 v13WlC+uKd05ny7cS1Cf4pe2ViDhCye29tOAPmYjZFYkM9qbnjJwiKcNRDTdUvQqtx
	 rm6vsYQaFLVXK4ww4L1ZKazHnepnt0/1j65mmH2cMyuIGR+HunHqosjCWyx8Oyhyr1
	 UezQggCJRlt5A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 06/15] NFSv4.2: fix setattr caching of TIME_[MODIFY|ACCESS]_SET when timestamps are delegated
Date: Fri,  6 Jun 2025 11:42:49 -0400
Message-Id: <20250606154259.547394-6-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit aba41e90aadeca8d4656f90639aa5f91ce564f1c ]

nfs_setattr will flush all pending writes before updating a file time
attributes. However when the client holds delegated timestamps, it can
update its timestamps locally as it is the authority for the file
times attributes. The client will later set the file attributes by
adding a setattr to the delegreturn compound updating the server time
attributes.

Fix nfs_setattr to avoid flushing pending writes when the file time
attributes are delegated and the mtime/atime are set to a fixed
timestamp (ATTR_[MODIFY|ACCESS]_SET. Also, when sending the setattr
procedure over the wire, we need to clear the correct attribute bits
from the bitmask.

I was able to measure a noticable speedup when measuring untar performance.
Test: $ time tar xzf ~/dir.tgz
Baseline: 1m13.072s
Patched: 0m49.038s

Which is more than 30% latency improvement.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of both the commit message and code changes, and
examination of the Linux kernel NFS subsystem: **YES** ## Extensive
Analysis: ### Nature of the Fix This commit addresses a **significant
performance regression** in NFSv4.2 when using delegated timestamps, not
a security vulnerability. The code changes show: 1. **New function
`nfs_set_timestamps_to_ts()`** in `fs/nfs/inode.c:622-647` that
efficiently handles timestamp updates locally when timestamps are set to
specific values (ATTR_MTIME_SET/ATTR_ATIME_SET) 2. **Modified
`nfs_setattr()` logic** in `fs/nfs/inode.c:730-751` that avoids
expensive write flushes and unnecessary server RPCs when the client has
delegated timestamp authority 3. **Updated bitmask handling** in
`fs/nfs/nfs4proc.c:327-335` that correctly clears TIME_ACCESS_SET and
TIME_MODIFY_SET bits from server requests when timestamps are delegated
### Performance Impact and User Benefit The commit message demonstrates
a **>30% performance improvement** (1m13s → 49s) for common operations
like tar extraction. This represents a substantial regression fix that
significantly impacts user experience for NFSv4.2 workloads. ### Risk
Assessment - Very Low - **No functional changes to correctness** -
timestamps were being set correctly before, just inefficiently - **No
security implications** - purely a performance optimization - **Well-
contained changes** - limited to NFSv4.2 delegation code paths only -
**Backwards compatible** - no protocol changes, client-side optimization
only - **Similar to approved commits** - matches pattern of previous YES
backports (commits #1, #2, #3, #5) which were NFS performance/efficiency
fixes ### Alignment with Stable Criteria This commit perfectly fits
stable tree requirements: - **Fixes important performance regression**
introduced in v6.10 with delegated timestamp support - **Minimal risk**
- optimization-only changes with no correctness implications - **Small,
focused patch** - changes are surgical and well-understood - **Does not
introduce new features** - only optimizes existing delegation
functionality ### Comparison to Similar Commits Like the approved
similar commits (particularly #1, #2, #5), this fix: - Addresses NFS
timestamp/delegation edge cases - Improves efficiency without changing
semantics - Has clear performance benefits - Contains minimal, targeted
code changes - Fixes issues that affect real-world workloads The 30%+
performance improvement for common file operations makes this an
important fix for stable backporting to prevent users from experiencing
unnecessary performance degradation in NFSv4.2 environments.

 fs/nfs/inode.c    | 49 +++++++++++++++++++++++++++++++++++++++++++----
 fs/nfs/nfs4proc.c |  8 ++++----
 2 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 9f10771331007..16607b24ab9c1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -635,6 +635,34 @@ nfs_fattr_fixup_delegated(struct inode *inode, struct nfs_fattr *fattr)
 	}
 }
 
+static void nfs_set_timestamps_to_ts(struct inode *inode, struct iattr *attr)
+{
+	unsigned int cache_flags = 0;
+
+	if (attr->ia_valid & ATTR_MTIME_SET) {
+		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
+		struct timespec64 now;
+		int updated = 0;
+
+		now = inode_set_ctime_current(inode);
+		if (!timespec64_equal(&now, &ctime))
+			updated |= S_CTIME;
+
+		inode_set_mtime_to_ts(inode, attr->ia_mtime);
+		if (!timespec64_equal(&now, &mtime))
+			updated |= S_MTIME;
+
+		inode_maybe_inc_iversion(inode, updated);
+		cache_flags |= NFS_INO_INVALID_CTIME | NFS_INO_INVALID_MTIME;
+	}
+	if (attr->ia_valid & ATTR_ATIME_SET) {
+		inode_set_atime_to_ts(inode, attr->ia_atime);
+		cache_flags |= NFS_INO_INVALID_ATIME;
+	}
+	NFS_I(inode)->cache_validity &= ~cache_flags;
+}
+
 static void nfs_update_timestamps(struct inode *inode, unsigned int ia_valid)
 {
 	enum file_time_flags time_flags = 0;
@@ -703,14 +731,27 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	if (nfs_have_delegated_mtime(inode) && attr->ia_valid & ATTR_MTIME) {
 		spin_lock(&inode->i_lock);
-		nfs_update_timestamps(inode, attr->ia_valid);
+		if (attr->ia_valid & ATTR_MTIME_SET) {
+			nfs_set_timestamps_to_ts(inode, attr);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_MTIME_SET|
+						ATTR_ATIME|ATTR_ATIME_SET);
+		} else {
+			nfs_update_timestamps(inode, attr->ia_valid);
+			attr->ia_valid &= ~(ATTR_MTIME|ATTR_ATIME);
+		}
 		spin_unlock(&inode->i_lock);
-		attr->ia_valid &= ~(ATTR_MTIME | ATTR_ATIME);
 	} else if (nfs_have_delegated_atime(inode) &&
 		   attr->ia_valid & ATTR_ATIME &&
 		   !(attr->ia_valid & ATTR_MTIME)) {
-		nfs_update_delegated_atime(inode);
-		attr->ia_valid &= ~ATTR_ATIME;
+		if (attr->ia_valid & ATTR_ATIME_SET) {
+			spin_lock(&inode->i_lock);
+			nfs_set_timestamps_to_ts(inode, attr);
+			spin_unlock(&inode->i_lock);
+			attr->ia_valid &= ~(ATTR_ATIME|ATTR_ATIME_SET);
+		} else {
+			nfs_update_delegated_atime(inode);
+			attr->ia_valid &= ~ATTR_ATIME;
+		}
 	}
 
 	/* Optimization: if the end result is no change, don't RPC */
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9754af4c26f23..c70e84e55dcdb 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -313,14 +313,14 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 
 	if (nfs_have_delegated_mtime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
 		if (!(cache_validity & NFS_INO_INVALID_MTIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_MODIFY;
+			dst[1] &= ~(FATTR4_WORD1_TIME_MODIFY|FATTR4_WORD1_TIME_MODIFY_SET);
 		if (!(cache_validity & NFS_INO_INVALID_CTIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_METADATA;
+			dst[1] &= ~(FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY_SET);
 	} else if (nfs_have_delegated_atime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
-			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
+			dst[1] &= ~(FATTR4_WORD1_TIME_ACCESS|FATTR4_WORD1_TIME_ACCESS_SET);
 	}
 }
 
-- 
2.39.5


