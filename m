Return-Path: <linux-nfs+bounces-12171-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21075AD05ED
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DED0189F54B
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Jun 2025 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A63128C2A8;
	Fri,  6 Jun 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo69xmq0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5128428A414;
	Fri,  6 Jun 2025 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224636; cv=none; b=uudzqN8yMKIjTeWPANrycy+SctMfGNukeA/ki8b6QwRHgHKd6N787YRuwjTjwwgCVt/8WntEOXGHSlIyWGv6dN9Bpu5nfEHtLPZiIdiEZq3UCdQ2fDmvk3XxaDmns4UPspOUf9mS9A+1ulR6SxrOMHH+zlWFjSSG8vv12isuhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224636; c=relaxed/simple;
	bh=TF5sC5UfQvayV0pmpxghEWpWDAwZXepvOiLUi0VJX38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KP9kuYXQGA5V+SW1lViHpWQsNv4n91HcjHG2bceeVu9g+tFWEZX8a8unZgSbeT3+f8VZtKZsD9tBETL5NKpbHr7PGApQDEY9BRqWmLLTc5xMCbj3eoicsM+4ymKEsdENAI+05GQPxV6PgAD5VW5Q33Ihr0H25jEA5qWa4JHKcGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo69xmq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CB0C4CEF0;
	Fri,  6 Jun 2025 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224636;
	bh=TF5sC5UfQvayV0pmpxghEWpWDAwZXepvOiLUi0VJX38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zo69xmq0orewgiYZyh1sqCowxMuHPkdCs1eQaHRATVdZCk5/EdOet7t44Okcps9S9
	 dSYI1USLcX10MyZFoODz8CDRdHooNNNBVvsDHSdRletK18qO5o6MyMzrqLxLkbC/E/
	 vozxraVQ3bedYaR+G2SDlxDcQ94gBh4vZu3xg2TICBtgA1c9+x9w5T4nwD4Kzv1sOV
	 UPIxNBG5rwn/rDx5iowuf3gcN6/mwtB9V2D10d3HqGY9aDYHlmDOAnGabYWxfRJ1DO
	 YD/yVp2g53UtaChYEC8oWMrZXsjGwjOQ0xVjLb6+l5IoNF8vCIHFxEAZ/pl0mzGu6l
	 9y2dW8zPP8nAA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Han Young <hanyang.tony@bytedance.com>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/9] NFSv4: Always set NLINK even if the server doesn't support it
Date: Fri,  6 Jun 2025 11:43:44 -0400
Message-Id: <20250606154350.548104-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154350.548104-1-sashal@kernel.org>
References: <20250606154350.548104-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.141
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
index f2e66b946f4b4..e774cfc85eeed 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -555,6 +555,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
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


