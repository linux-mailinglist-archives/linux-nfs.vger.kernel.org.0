Return-Path: <linux-nfs+bounces-16786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C4C937CF
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 05:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF20E4E2347
	for <lists+linux-nfs@lfdr.de>; Sat, 29 Nov 2025 04:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807843C17;
	Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYDmeGpw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB52264DC
	for <linux-nfs@vger.kernel.org>; Sat, 29 Nov 2025 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764389195; cv=none; b=Mq92uO5NGoEWE8APtgBtxw6ZTY2tJH9GF8rbJvXR6JqNeAH7qd2ghhnY8CIleG0s0CLPgvREKxyyiqIZp3HhEuxnJK9tyFgBEZ2neXTNeSVSCd1T8OG3emoyBHbr7tupzJaEhFpyY6BDwgWhTCfpr8kjEaqEdctCjZIPGMj9ZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764389195; c=relaxed/simple;
	bh=/xWu/Vxel/w0kVwAtXD8WGnZ5rIChmlg0er1g87ZLxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYLBTMAkQezQGm62pEQlvf5tD1RHyvzwEJReoLGvpLO8h9uX+8ifi09+aflWjg6e3N6ZX6yYiNjSN7ZCiXBIiBtvINEV1D3KWWaOQOf+bui8CTvtVcVOIn1B7FcG8sTtXnqnbWlpFzi/iHRZMkqXmKQ+otAjHxzILsMjcGgu6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYDmeGpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A73C16AAE;
	Sat, 29 Nov 2025 04:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764389195;
	bh=/xWu/Vxel/w0kVwAtXD8WGnZ5rIChmlg0er1g87ZLxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYDmeGpwRprDXXJ3XuptNTNZEUPw1OZ+wXXJ1GcJGZQBzrd6CqX5HbVOqce/wmkg+
	 SOdlZpy2AHcvXLkRRugVTww/3LfWZ5GGpeapKPlIpiOHAolu9QDkkaocnxRaQvppaw
	 cOa6OlkNrJGUOr2bQx9fnFM1T1J2gNgL8Udk/rBZ7VEPHZVeW9TuqXpQ1Z8pCLHTQE
	 iQOauy3kemoLV6rU1ZUYRn+eQTMJNzOrbKsaMgU7CrOakgYdczOBDq7dvTgBjMET5M
	 4mRIL21jf8asKXaaVdLUViP4LGwmgR6D2K0CN5o6uQIlwSwzr9u5WPietmWEPkpP+L
	 daEz/U7seNWHw==
From: Trond Myklebust <trondmy@kernel.org>
To: Alkis Georgopoulos <alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 2/6] Revert "nfs: clear SB_RDONLY before getting superblock"
Date: Fri, 28 Nov 2025 23:06:28 -0500
Message-ID: <c782d1c1673e9a67b61a24dadef46d6f82f54311.1764388528.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1764388528.git.trond.myklebust@hammerspace.com>
References: <cbd4d74d-21c4-42d6-9442-276fd98313ee@gmail.com> <cover.1764388528.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This reverts commit 8cd9b785943c57a136536250da80ba1eb6f8eb18.

Silently ignoring the "ro" and "rw" mount options causes user confusion,
and is a regression.

Reported-by: Alkis Georgopoulos<alkisg@gmail.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>
Fixes: 8cd9b785943c ("nfs: clear SB_RDONLY before getting superblock")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/super.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 527000f5d150..9b9464e70a7f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1308,17 +1308,8 @@ int nfs_get_tree_common(struct fs_context *fc)
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
-	/*
-	 * When NFS_MOUNT_UNSHARED is not set, NFS forces the sharing of a
-	 * superblock among each filesystem that mounts sub-directories
-	 * belonging to a single exported root path.
-	 * To prevent interference between different filesystems, the
-	 * SB_RDONLY flag should be removed from the superblock.
-	 */
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
-	else
-		fc->sb_flags &= ~SB_RDONLY;
 
 	/* -o noac implies -o sync */
 	if (server->flags & NFS_MOUNT_NOAC)
-- 
2.52.0


