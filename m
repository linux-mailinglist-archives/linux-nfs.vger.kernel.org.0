Return-Path: <linux-nfs+bounces-4235-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03256913AE1
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 15:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37D5281C85
	for <lists+linux-nfs@lfdr.de>; Sun, 23 Jun 2024 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1C181B86;
	Sun, 23 Jun 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmyFxm9E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEC6181B83;
	Sun, 23 Jun 2024 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719150248; cv=none; b=gLUbf+9vI7adIyJi+WGYECwOcABVnHRmH3Rnd5JxM2OOAehMbDTy+n5oBzdadpM00jXHsLnKQic6QWEQMtEdstNCXhh+XjSc8ycXCOCnAMCq/qscC7VRZ8Sw1ElMd38KmIvLbtlNlrQExAj/ipucMzFljwO/c1fHY9agUROjBZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719150248; c=relaxed/simple;
	bh=K88EB347w1XW/mFGJCPW6e2Qqna7CBJejTjWi3zUidk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3Vb294RalHUOuogYaxl1fF5Tq+3ImyHYOg34VIDhLmj7AaQH2MlZbRXLSU63eCA7TR/kxcUf9Hk/KKWq/koBXzbknsHy6nQUXI2iN4q6FfcR63cuF+jjwP5Nc9hJNx//sAoUSE9KaPpqfCiimImuF4DFunRL7/Yiv1Zqko3XdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmyFxm9E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49060C2BD10;
	Sun, 23 Jun 2024 13:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150248;
	bh=K88EB347w1XW/mFGJCPW6e2Qqna7CBJejTjWi3zUidk=;
	h=From:To:Cc:Subject:Date:From;
	b=GmyFxm9ECfbGkrVvdrJumx5lMg6YXvaqLmI0xs8MYJv4AyMXDo6Xx0z5VVq3ZO5vA
	 sS9mFTuKbDXz/TSZHS7xlsOTePBmL5S/KcTrfVRBSFLY701CFZAZ/fPYAKUHBijC+y
	 sdBgHEarK9ctFUgoTBHavIA03ZEVX6K9bhXTkOjVrffqLZ2MZDq80OssXDxPRnQ3Zv
	 EDM8yr3zlXw8aG4bX0PgLVvT7dyytj7xlm5pzz8uHZkHJUzssA2Q5czfd5AV+/mgOS
	 GCe+Eikg4a7GjqVx2yk1ox5Jb4KoemnQ1+NFW+fE/KVWk4505x6w2hOnU96N3+vdpp
	 sEDgBU3dnwM9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Mastykin <mastichi@gmail.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>,
	trondmy@kernel.org,
	anna@kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 01/21] NFSv4: Fix memory leak in nfs4_set_security_label
Date: Sun, 23 Jun 2024 09:43:34 -0400
Message-ID: <20240623134405.809025-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.6
Content-Transfer-Encoding: 8bit

From: Dmitry Mastykin <mastichi@gmail.com>

[ Upstream commit aad11473f8f4be3df86461081ce35ec5b145ba68 ]

We leak nfs_fattr and nfs4_label every time we set a security xattr.

Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 3a816c4a6d5e2..a691fa10b3e95 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6289,6 +6289,7 @@ nfs4_set_security_label(struct inode *inode, const void *buf, size_t buflen)
 	if (status == 0)
 		nfs_setsecurity(inode, fattr);
 
+	nfs_free_fattr(fattr);
 	return status;
 }
 #endif	/* CONFIG_NFS_V4_SECURITY_LABEL */
-- 
2.43.0


