Return-Path: <linux-nfs+bounces-14084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E73B463BB
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 21:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 251101C82A5B
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 19:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A2827E07F;
	Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+uUG+/b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4527B337
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100923; cv=none; b=fC5/islPkJTpUdpynnqGg1aOXfIltx7NehKMyjCOP3wtsp8A1JaiFw0lBwjED2dfP3SlNogoi++SfklvQY8C3GG4GkW0sCrOgkqlpGxgio0YdHf23x8lgZrjR66WAydGcaHSXKiM3YWwKr57KkIWQhes47/Gy4MvxCeaNWh/wXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100923; c=relaxed/simple;
	bh=CMGXWG+sZhSmZsAqoDTFnyzeO7lsKn7E6kOWxA3FOvI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQR90nfofj9aER2NLuZpItTU6pOtI511FGdEs3h5+RPjrF3ZYcdMO4KTaB6bkTvqady7oZeR2jHIJvmMm6wTdTo1n+fkf8z6dJdMwLsr/B8yIQ9fYuw09OmJgupGi9GIxTUJBRR//jidTzO2YHu//evg8lTeKJqubhN7X2wECOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+uUG+/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E142FC4CEF9
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 19:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757100923;
	bh=CMGXWG+sZhSmZsAqoDTFnyzeO7lsKn7E6kOWxA3FOvI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=D+uUG+/bj2xbSjAB5Gcv1L+EgLREWncjScBPpXf35cODEmcmCtArsRBRMMBs9UAyH
	 Hbm1heauUddz7a7vAs+xjmmdPk129qy9Dd07DLfmpmsWTB/pDtCEghOpxbgT7Yt9Tr
	 VF2YErBEzcTRaoY4O2XzmmBrMpacHCSZsapc6ikEF+DBwEhIZMwXCmWhDs4Inu2B5D
	 o2mmar6Gx8woL7lVYBWWWHG1A6lYfLJ2vrV7iltHCYBulOJsVSgdE3oxNBS3oFxmti
	 wLA+GtQtpq6Udtq+89gTnAVn/6nzS6iAcR05MtUUCdFuCwe8Sw5IfmJEV746EYG/o1
	 eqcQZIYHSF18w==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH 2/5] NFS: Serialise O_DIRECT i/o and truncate()
Date: Fri,  5 Sep 2025 15:35:17 -0400
Message-ID: <87918d0741fa333e163f85889a6faa19d45740ff.1757100278.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757100278.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all O_DIRECT reads and writes are complete, and prevent the
initiation of new i/o until the setattr operation that will truncate the
file is complete.

Fixes: a5864c999de6 ("NFS: Do not serialise O_DIRECT reads and writes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    |  4 +++-
 fs/nfs/internal.h | 10 ++++++++++
 fs/nfs/io.c       | 13 ++-----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0b141feacc52..49df9debb1a6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -768,8 +768,10 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	trace_nfs_setattr_enter(inode);
 
 	/* Write all dirty data */
-	if (S_ISREG(inode->i_mode))
+	if (S_ISREG(inode->i_mode)) {
+		nfs_file_block_o_direct(NFS_I(inode));
 		nfs_sync_inode(inode);
+	}
 
 	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	if (fattr == NULL) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1433ae13dba0..c0a44f389f8f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -532,6 +532,16 @@ static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
 	return test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0;
 }
 
+/* Must be called with exclusively locked inode->i_rwsem */
+static inline void nfs_file_block_o_direct(struct nfs_inode *nfsi)
+{
+	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
+		clear_bit(NFS_INO_ODIRECT, &nfsi->flags);
+		inode_dio_wait(&nfsi->vfs_inode);
+	}
+}
+
+
 /* namespace.c */
 #define NFS_PATH_CANONICAL 1
 extern char *nfs_path(char **p, struct dentry *dentry,
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index 3388faf2acb9..d275b0a250bf 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -14,15 +14,6 @@
 
 #include "internal.h"
 
-/* Call with exclusively locked inode->i_rwsem */
-static void nfs_block_o_direct(struct nfs_inode *nfsi, struct inode *inode)
-{
-	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
-		clear_bit(NFS_INO_ODIRECT, &nfsi->flags);
-		inode_dio_wait(inode);
-	}
-}
-
 /**
  * nfs_start_io_read - declare the file is being used for buffered reads
  * @inode: file inode
@@ -57,7 +48,7 @@ nfs_start_io_read(struct inode *inode)
 	err = down_write_killable(&inode->i_rwsem);
 	if (err)
 		return err;
-	nfs_block_o_direct(nfsi, inode);
+	nfs_file_block_o_direct(nfsi);
 	downgrade_write(&inode->i_rwsem);
 
 	return 0;
@@ -90,7 +81,7 @@ nfs_start_io_write(struct inode *inode)
 
 	err = down_write_killable(&inode->i_rwsem);
 	if (!err)
-		nfs_block_o_direct(NFS_I(inode), inode);
+		nfs_file_block_o_direct(NFS_I(inode));
 	return err;
 }
 
-- 
2.51.0


