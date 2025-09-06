Return-Path: <linux-nfs+bounces-14099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1409B474E4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714B25849B9
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E104257844;
	Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zuk1poC4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED82257831
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176941; cv=none; b=MJHB3hLmDEP+kggiUlBDdfnsI6GukYyEGz9IVbpcL5FS4RUE7ZEKTUiWr/5zN9Z5fxOQhD9w0ZHIgigyA3Ll8ehNgWInnGnSjfIxX6NNBGZZ2eRU7BUOqUxbI3qKSGON3xH8EnWCx8C/pZMnW0KoVz1Rez0LkOPVk2DJOD6u/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176941; c=relaxed/simple;
	bh=Kn/KTChfymEdZ7e11OEPg9I5yx3H/pAAslTQNxDC0Bc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nW5h2+ZiWGRtRXlFtb18Kv2XvFcUqhBcvLLU+Cx1QrEAbDQXuBb8Hy8D/dE2jVXF2rcXPqr0ax6WnhWRnDUhOUFYckLSQpF4LkKLWJ3ObTt+S/e1cweJqEj4dXbsVm81yC34j91som1/GS9Y/zFCcZWz9hujX5aGmdoJHtqMO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zuk1poC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9994C4CEF9
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176940;
	bh=Kn/KTChfymEdZ7e11OEPg9I5yx3H/pAAslTQNxDC0Bc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zuk1poC4qxDWOIuWVTL8MTEdpWOuSQyhr3d98MKNklonZCb4hqyf2ZLOh+r3EY3ef
	 V9+fLs4g7KFTbmMp3FeQIyWhPz3dw1d89LiRQVkcqMDhRe3ABZQub65CIH8HFkAMcP
	 o9WI798sEaqhk9qUPJe+P5JFCYwvhJZIuyyhxC+ikFxS10gfA7cakdsqT4iyAMlcZb
	 R+X/loBimQYyfaY27BWweXxVWLZkFZGF+Q9tH/VRMMFfyi1Z2siDxEomzYBIciIPMI
	 twBJH41bjzhABsJYSEcVd81WlZfwD96Rftpdwh+/KFhGyQV2vYA0p7XKxqt1WnbhSN
	 ldbEWjZmfn+qw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/8] NFSv4.2: Serialise O_DIRECT i/o and clone range
Date: Sat,  6 Sep 2025 12:42:13 -0400
Message-ID: <944b06a03cffa8b988ea648a2ba915a418ee853d.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757176392.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com> <cover.1757176392.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all O_DIRECT reads and writes complete before cloning a file
range, so that both the source and destination are up to date.

Fixes: a5864c999de6 ("NFS: Do not serialise O_DIRECT reads and writes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 1d6b5f4230c9..c9a0d1e420c6 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -278,9 +278,11 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	lock_two_nondirectories(src_inode, dst_inode);
 	/* flush all pending writes on both src and dst so that server
 	 * has the latest data */
+	nfs_file_block_o_direct(NFS_I(src_inode));
 	ret = nfs_sync_inode(src_inode);
 	if (ret)
 		goto out_unlock;
+	nfs_file_block_o_direct(NFS_I(dst_inode));
 	ret = nfs_sync_inode(dst_inode);
 	if (ret)
 		goto out_unlock;
-- 
2.51.0


