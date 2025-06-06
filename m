Return-Path: <linux-nfs+bounces-12174-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866E6AD05F9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A843B3BAB
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F68E28A726;
	Fri,  6 Jun 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn/Cq16g"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906328A725;
	Fri,  6 Jun 2025 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224652; cv=none; b=dWiyP8jsvu6ncFErzahU3MlNF4/6INZqw2IlEJMEAOsEFVfOp3xIwgf8LqNrqB1zS+FbGeMtTkyWL/IuMS5KZvWJvGK62KO6qt771OzvsjtE8956kcf7oHEWLZ4P5ZauuqXaDy5JuGAFdVhz9xe3aVT1l93kWhvhqSJs/+LA2kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224652; c=relaxed/simple;
	bh=R1/9uEky6ybEArKh9jIfVupi3rSCS9vnZkPxDdYzE+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hbMRoj9zTRXLhPmaI9d1dLyKv1SXUidx4NMk+MCL0nsYnjeoQ2+odpRLgvgEP9oEXDwl0HuQRkOWyqlFZ5VR+3eG15qgHKRmlaxV0B+AAUAMOoNZs7FSD04gR3ETT84d8lPjX04SAns3/tIZBD5CnG6abL06hnbOg32HHZhlHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn/Cq16g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD4C4CEF1;
	Fri,  6 Jun 2025 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224651;
	bh=R1/9uEky6ybEArKh9jIfVupi3rSCS9vnZkPxDdYzE+I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fn/Cq16gIUxFjPhCwkKZI42iGeJDgKZilzVFfNx+lebsTV8JUz72vNt7ot6Axkub1
	 0TTzRvI+W+g6+9tmNwqYMpWXhr0M4fm/b6wKCfLirwrf8hxpu4GOvBzbECA2/MoTNk
	 iMhnPu1Sa30NEE2ey+M/JLzk3xhBtkEmoa3rJ4qfGiPQEjfsG1W+rUYPjMfnJEATSd
	 zcoviJCt4MCFHh5VX8mq/F/c+f1Brce1wYb5bX6EVgGgWkhd9pUq65zFDLe1DyGAw6
	 SWw9Zh0v893UfGfsNncVBp1FhSaoGeQRuS14/EXRicLe98rrWX1HG1NohMsgIDWxcY
	 42NKqO+omA8oA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 2/7] NFSv4: Always set NLINK even if the server doesn't support it
Date: Fri,  6 Jun 2025 11:44:02 -0400
Message-Id: <20250606154408.548320-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154408.548320-1-sashal@kernel.org>
References: <20250606154408.548320-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.185
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Han Young <hanyang.tony@bytedance.com>

[ Upstream commit 3a3065352f73381d3a1aa0ccab44aec3a5a9b365 ]

fattr4_numlinks is a recommended attribute, so the client should emulate
it even if the server doesn't support it. In decode_attr_nlink function
in nfs4xdr.c, nlink is initialized to 1. However, this default value
isn't set to the inode due to the check in nfs_fhget.

So if the server doesn't support numlinks, inode's nlink will be zero,
the mount will fail with error "Stale file handle". Set the nlink to 1
if the server doesn't support it.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my analysis of the commit and the kernel source code, here is
my determination: **YES** This commit should be backported to stable
kernel trees. Here's my extensive analysis: ## Critical Bug Fix Analysis
### 1. **Root Cause Understanding** The commit addresses a critical
issue where NFSv4 mounts fail with "Stale file handle" errors when the
server doesn't support the `fattr4_numlinks` (NLINK) attribute. Looking
at the code: - In `/home/sasha/linux/fs/nfs/nfs4xdr.c:3969`, the
`decode_attr_nlink` function initializes `*nlink = 1` as a default -
However, in `/home/sasha/linux/fs/nfs/inode.c:556-559`, the current
logic only sets the inode's nlink if `fattr->valid &
NFS_ATTR_FATTR_NLINK` is true - When the server doesn't support
numlinks, the `fattr->valid` flag isn't set, so the inode's nlink
remains 0 (from initial inode allocation) ### 2. **Impact of Zero
nlink** From `/home/sasha/linux/fs/nfs/dir.c:1578-1582`, I can see the
critical check: ```c if (inode->i_nlink > 0 || (inode->i_nlink == 0 &&
test_bit(NFS_INO_PRESERVE_UNLINKED, &NFS_I(inode)->flags))) return 0;
else return -ESTALE; ``` When `i_nlink == 0` and the
`NFS_INO_PRESERVE_UNLINKED` flag isn't set, NFS returns `-ESTALE`,
causing "Stale file handle" errors and mount failures. ### 3. **Backport
Suitability Criteria** **✅ Fixes important user-affecting bug**: Mount
failures prevent basic filesystem functionality **✅ Small and contained
fix**: The change adds only 2 lines: ```c else if (fattr_supported &
NFS_ATTR_FATTR_NLINK) nfs_set_cache_invalid(inode,
NFS_INO_INVALID_NLINK); +else + set_nlink(inode, 1); ``` **✅ Minimal
regression risk**: Setting nlink=1 as fallback is safe and follows the
NFSv4 spec (fattr4_numlinks is a "recommended" attribute, so emulation
is appropriate) **✅ No architectural changes**: This is a targeted fix
within existing error handling logic **✅ Follows stable tree rules**:
It's an important bugfix with minimal risk ### 4. **Comparison with
Similar Commits** Unlike the provided similar commits that were marked
"NO" (which involved more complex nlink management, cache invalidation
changes, or feature additions), this commit: - Fixes a fundamental
compatibility issue - Prevents complete mount failures - Is minimal and
defensive - Addresses server interoperability problems ### 5. **Server
Compatibility** This fix ensures NFSv4 clients remain functional with
servers that don't fully implement all recommended attributes, which is
critical for real-world deployments where server implementations vary.
The commit directly prevents mount failures that would otherwise require
server-side fixes or workarounds, making it essential for stable kernel
trees where users expect reliable NFS functionality.

 fs/nfs/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 09922258f5a11..28c24079c57a8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -567,6 +567,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			set_nlink(inode, fattr->nlink);
 		else if (fattr_supported & NFS_ATTR_FATTR_NLINK)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_NLINK);
+		else
+			set_nlink(inode, 1);
 		if (fattr->valid & NFS_ATTR_FATTR_OWNER)
 			inode->i_uid = fattr->uid;
 		else if (fattr_supported & NFS_ATTR_FATTR_OWNER)
-- 
2.39.5


