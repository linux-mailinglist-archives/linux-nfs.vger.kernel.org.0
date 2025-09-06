Return-Path: <linux-nfs+bounces-14097-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73DDB474E3
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C36E7AAEDE
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC55F2571B9;
	Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLRppbyh"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85172566D2
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176939; cv=none; b=cXdPH92qcT2Dawyirt4BBvLHLfPTX+b3eUM1hmJEKb8EXcst0p+W37BCW0p66YCQVs4Wly3Zye7LsVzyb5OGAnTT7wiKdQe3ZV/IyFoX00duXvrSbA0Hxt1SMYm7QOsT89P1hCuJ6DqnAE3oGbAHyQmnQGThphpvyB7P5gDU0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176939; c=relaxed/simple;
	bh=G1cQUR3ZPjNtognwlwKPNnd9NzXSS0ShchyQRWyg4Ec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHwREnbcv4OdonXvZF9E3GHQiXzHDB/2Ckofv5tifhO8/UNLqjEV3/DRXzumDf/ACkznZDbKud3u7HwBMZVNzk3XgQy5LlOefmZi+rixoZeuVm+xhiLKSJ2uHwic6P297XpkdNcy0ymAu31ynENTaJXsmUQk/OqklS+9eq0pgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLRppbyh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2204CC4CEF8
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176939;
	bh=G1cQUR3ZPjNtognwlwKPNnd9NzXSS0ShchyQRWyg4Ec=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pLRppbyhe33TtTEkNvgEI5Urlk7XTTiJGGJ8+sLiAVlmZcb1hsHm267ltoST5tkCu
	 6jZNYj/Cr3b/YOASQB1XBBUb+jTHgmqbEu1CFotHOKGwOGX09+OHqy37E4fnpXdGKZ
	 PlQaHGjrC3LMtCBuz0h4JVHwcR0+mFKLfigHYDdZWUmAKDEFoYoAdg97aYVR1+6uKh
	 YLfSx03ObUEZPR+zko1pUz4x1oaOIx+C6p+wTuWcz/abfPTsU5PE2wzjb8Ah+3SBwi
	 hgI5Ggr9gIqB04H6q1gIEO1W4X4i72DDf+kiha+3Xh9+Y/VPC8AMeza3aJ3Fd5rU18
	 +EqVE/8wVMaLw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/8] NFS: Protect against 'eof page pollution'
Date: Sat,  6 Sep 2025 12:42:09 -0400
Message-ID: <4e6f13c67bf08fceedad3082b9d9454baf981ae3.1757176392.git.trond.myklebust@hammerspace.com>
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

This commit fixes the failing xfstest 'generic/363'.

When the user mmaps() an area that extends beyond the end of file, and
proceeds to write data into the folio that straddles that eof, we're
required to discard that folio data if the user calls some function that
extends the file length.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c      | 33 +++++++++++++++++++++++++++++++++
 fs/nfs/inode.c     |  9 +++++++--
 fs/nfs/internal.h  |  2 ++
 fs/nfs/nfs42proc.c | 14 +++++++++++---
 fs/nfs/nfstrace.h  |  1 +
 5 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 86e36c630f09..a3105f944a0e 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -28,6 +28,7 @@
 #include <linux/mm.h>
 #include <linux/pagemap.h>
 #include <linux/gfp.h>
+#include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/compaction.h>
 
@@ -280,6 +281,37 @@ nfs_file_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 }
 EXPORT_SYMBOL_GPL(nfs_file_fsync);
 
+void nfs_truncate_last_folio(struct address_space *mapping, loff_t from,
+			     loff_t to)
+{
+	struct folio *folio;
+
+	if (from >= to)
+		return;
+
+	folio = filemap_lock_folio(mapping, from >> PAGE_SHIFT);
+	if (IS_ERR(folio))
+		return;
+
+	if (folio_mkclean(folio))
+		folio_mark_dirty(folio);
+
+	if (folio_test_uptodate(folio)) {
+		loff_t fpos = folio_pos(folio);
+		size_t offset = from - fpos;
+		size_t end = folio_size(folio);
+
+		if (to - fpos < end)
+			end = to - fpos;
+		folio_zero_segment(folio, offset, end);
+		trace_nfs_size_truncate_folio(mapping->host, to);
+	}
+
+	folio_unlock(folio);
+	folio_put(folio);
+}
+EXPORT_SYMBOL_GPL(nfs_truncate_last_folio);
+
 /*
  * Decide whether a read/modify/write cycle may be more efficient
  * then a modify/write/read cycle when writing to a page in the
@@ -356,6 +388,7 @@ static int nfs_write_begin(const struct kiocb *iocb,
 
 	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
+	nfs_truncate_last_folio(mapping, i_size_read(mapping->host), pos);
 
 	fgp |= fgf_set_order(len);
 start:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 338ef77ae423..0b141feacc52 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -716,6 +716,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 {
 	struct inode *inode = d_inode(dentry);
 	struct nfs_fattr *fattr;
+	loff_t oldsize = i_size_read(inode);
 	int error = 0;
 
 	nfs_inc_stats(inode, NFSIOS_VFSSETATTR);
@@ -731,7 +732,7 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (error)
 			return error;
 
-		if (attr->ia_size == i_size_read(inode))
+		if (attr->ia_size == oldsize)
 			attr->ia_valid &= ~ATTR_SIZE;
 	}
 
@@ -777,8 +778,12 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	}
 
 	error = NFS_PROTO(inode)->setattr(dentry, fattr, attr);
-	if (error == 0)
+	if (error == 0) {
+		if (attr->ia_valid & ATTR_SIZE)
+			nfs_truncate_last_folio(inode->i_mapping, oldsize,
+						attr->ia_size);
 		error = nfs_refresh_inode(inode, fattr);
+	}
 	nfs_free_fattr(fattr);
 out:
 	trace_nfs_setattr_exit(inode, error);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 74d712b58423..1433ae13dba0 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -437,6 +437,8 @@ int nfs_file_release(struct inode *, struct file *);
 int nfs_lock(struct file *, int, struct file_lock *);
 int nfs_flock(struct file *, int, struct file_lock *);
 int nfs_check_flags(int);
+void nfs_truncate_last_folio(struct address_space *mapping, loff_t from,
+			     loff_t to);
 
 /* inode.c */
 extern struct workqueue_struct *nfsiod_workqueue;
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 01c01f45358b..4420b8740e2f 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -137,6 +137,7 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ALLOCATE],
 	};
 	struct inode *inode = file_inode(filep);
+	loff_t oldsize = i_size_read(inode);
 	int err;
 
 	if (!nfs_server_capable(inode, NFS_CAP_ALLOCATE))
@@ -145,7 +146,11 @@ int nfs42_proc_allocate(struct file *filep, loff_t offset, loff_t len)
 	inode_lock(inode);
 
 	err = nfs42_proc_fallocate(&msg, filep, offset, len);
-	if (err == -EOPNOTSUPP)
+
+	if (err == 0)
+		nfs_truncate_last_folio(inode->i_mapping, oldsize,
+					offset + len);
+	else if (err == -EOPNOTSUPP)
 		NFS_SERVER(inode)->caps &= ~(NFS_CAP_ALLOCATE |
 					     NFS_CAP_ZERO_RANGE);
 
@@ -183,6 +188,7 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
 		.rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_ZERO_RANGE],
 	};
 	struct inode *inode = file_inode(filep);
+	loff_t oldsize = i_size_read(inode);
 	int err;
 
 	if (!nfs_server_capable(inode, NFS_CAP_ZERO_RANGE))
@@ -191,9 +197,11 @@ int nfs42_proc_zero_range(struct file *filep, loff_t offset, loff_t len)
 	inode_lock(inode);
 
 	err = nfs42_proc_fallocate(&msg, filep, offset, len);
-	if (err == 0)
+	if (err == 0) {
+		nfs_truncate_last_folio(inode->i_mapping, oldsize,
+					offset + len);
 		truncate_pagecache_range(inode, offset, (offset + len) -1);
-	if (err == -EOPNOTSUPP)
+	} else if (err == -EOPNOTSUPP)
 		NFS_SERVER(inode)->caps &= ~NFS_CAP_ZERO_RANGE;
 
 	inode_unlock(inode);
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 96b1323318c2..627115179795 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -272,6 +272,7 @@ DECLARE_EVENT_CLASS(nfs_update_size_class,
 			TP_ARGS(inode, new_size))
 
 DEFINE_NFS_UPDATE_SIZE_EVENT(truncate);
+DEFINE_NFS_UPDATE_SIZE_EVENT(truncate_folio);
 DEFINE_NFS_UPDATE_SIZE_EVENT(wcc);
 DEFINE_NFS_UPDATE_SIZE_EVENT(update);
 DEFINE_NFS_UPDATE_SIZE_EVENT(grow);
-- 
2.51.0


