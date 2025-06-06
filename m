Return-Path: <linux-nfs+bounces-12152-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6533CAD0565
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E18F1625F6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DB28937F;
	Fri,  6 Jun 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVdJcXJT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D35193077;
	Fri,  6 Jun 2025 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224514; cv=none; b=qE3Xd77AeNiWnblsnvSwA7YXIPiywUrF3DPoaLBkFInvNc7oubkNRn35slsan5TeQY46zRiDQfx8ffRLyx6Y3mGro7q7MoaNPgASqb9j9JkjlIHEvW68Ywc7AaLTeNcJNtJjx2d7LTcSF+Z3F5p4sxZY8U/Zdk0cFtgOc69+9Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224514; c=relaxed/simple;
	bh=GNhp/OFVEyqdKPrWBtDxirglDPwhP2RviNfwKcCBmfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1/y0Lx3+zledoL88JfUR02SIQfrNmRUdUYYJU1SEpppiR2xTbQ8RN/wwWJcPXzu7TlL9CPUjM1ILPj9swjgnrIPxtNtDVYfdt0QljgaVwtkkLvvUZ4RTGEfHXfeN+VPW4Mj54f1cqeO1QaanYsKKzyRLk1EmgDciWWtf6Hvvg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVdJcXJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABD2C4CEF0;
	Fri,  6 Jun 2025 15:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224513;
	bh=GNhp/OFVEyqdKPrWBtDxirglDPwhP2RviNfwKcCBmfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qVdJcXJTZZpVl/sRPn+82VKMM2chnKCTLzm3PZPboDZv3bmseVbayYyjiZ+uLYAl3
	 gXOZ2CsN9HCV6m44ofK6QkaAl5D1I2kJmfs1iWFgFPcTlnGIMrGPIQVQ4a5+AIjMd+
	 +ecnp1vu2K3Wqp28k8eYLJmT63ZCp0mM0TIYg4vZwRw1NnIb1BXc+d2NU3xd7maXrA
	 hCH3IOPYhXMKW9Zz34TrGae+ms1HQKssvCy1lfKJjhp9ulmDjf/kCOsATgFmTbX0+m
	 P1HiZdeDQceOXTgvpL+fZtpdHi4l1ALlyOSzvIGjraLUOt6esG/0IlLEYP7WUIW3qY
	 dK/0MqaCWHpJA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 04/21] NFSv4: Always set NLINK even if the server doesn't support it
Date: Fri,  6 Jun 2025 11:41:29 -0400
Message-Id: <20250606154147.546388-4-sashal@kernel.org>
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
index 119e447758b99..4695292378bbe 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -557,6 +557,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
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


