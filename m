Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F30931A717
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBLVui (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:50:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229798AbhBLVug (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 16:50:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E565E64E26;
        Fri, 12 Feb 2021 21:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166595;
        bh=MGBYksKj9YOAWZcv1wlY9+qUNr0pAjdxQkdH40fJq6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AIjlfvBMBYldwgNJwC6RDDvbaOl2bibqIp9RhKaNXyPmlwR42h433Ph5sVdNL7WZV
         M7DjPRdTzVhYtFCOzAalHr/xgeiEU0MxFQpkMXAUt1lduJy4aMFFFJ/qilFyy+5Ahp
         Vz2tay86tFXsmprhsa7KBy7ODkMWzGTisrNsMbaWHiC5sLzyBj0L0wJd6lzW3h4dcb
         1GGMHrAH2K3kB0Cg6b2w3+ZtAw8FURQlBeTBgfiRZyet5zOSPrPvNdMU/7Is3n2jvZ
         chIy+ohF22NE1d/NRkeWbMg7KReH2/I0q5Q3otsK3OVjFlijPIADZyFpGQK+gNbOxH
         0ySxleRHWswmQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Add support for eager writes
Date:   Fri, 12 Feb 2021 16:49:48 -0500
Message-Id: <20210212214949.4408-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210212214949.4408-2-trondmy@kernel.org>
References: <20210212214949.4408-1-trondmy@kernel.org>
 <20210212214949.4408-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Support eager writing to the server, meaning that we write the data to
cache on the server, and wait for that to complete. This ensures that we
see ENOSPC errors immediately.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c             | 19 +++++++++++++++++--
 fs/nfs/write.c            | 17 ++++++++++++-----
 include/linux/nfs_fs_sb.h |  2 ++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 03fd1dcc96bd..16ad5050e046 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -606,8 +606,8 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
-	unsigned long written = 0;
-	ssize_t result;
+	unsigned int mntflags = NFS_SERVER(inode)->flags;
+	ssize_t result, written;
 	errseq_t since;
 	int error;
 
@@ -648,6 +648,21 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 
 	written = result;
 	iocb->ki_pos += written;
+
+	if (mntflags & NFS_MOUNT_WRITE_EAGER) {
+		result = filemap_fdatawrite_range(file->f_mapping,
+						  iocb->ki_pos - written,
+						  iocb->ki_pos - 1);
+		if (result < 0)
+			goto out;
+	}
+	if (mntflags & NFS_MOUNT_WRITE_WAIT) {
+		result = filemap_fdatawait_range(file->f_mapping,
+						 iocb->ki_pos - written,
+						 iocb->ki_pos - 1);
+		if (result < 0)
+			goto out;
+	}
 	result = generic_write_sync(iocb, written);
 	if (result < 0)
 		goto out;
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 6193350356a8..82bdcb982186 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -712,16 +712,23 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
 	struct nfs_pageio_descriptor pgio;
-	struct nfs_io_completion *ioc;
+	struct nfs_io_completion *ioc = NULL;
+	unsigned int mntflags = NFS_SERVER(inode)->flags;
+	int priority = 0;
 	int err;
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
 
-	ioc = nfs_io_completion_alloc(GFP_KERNEL);
-	if (ioc)
-		nfs_io_completion_init(ioc, nfs_io_completion_commit, inode);
+	if (!(mntflags & NFS_MOUNT_WRITE_EAGER) || wbc->for_kupdate ||
+	    wbc->for_background || wbc->for_sync || wbc->for_reclaim) {
+		ioc = nfs_io_completion_alloc(GFP_KERNEL);
+		if (ioc)
+			nfs_io_completion_init(ioc, nfs_io_completion_commit,
+					       inode);
+		priority = wb_priority(wbc);
+	}
 
-	nfs_pageio_init_write(&pgio, inode, wb_priority(wbc), false,
+	nfs_pageio_init_write(&pgio, inode, priority, false,
 				&nfs_async_write_completion_ops);
 	pgio.pg_io_completion = ioc;
 	err = write_cache_pages(mapping, wbc, nfs_writepages_callback, &pgio);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 962e8313f007..6f76b32a0238 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -153,6 +153,8 @@ struct nfs_server {
 #define NFS_MOUNT_LOCAL_FCNTL		0x200000
 #define NFS_MOUNT_SOFTERR		0x400000
 #define NFS_MOUNT_SOFTREVAL		0x800000
+#define NFS_MOUNT_WRITE_EAGER		0x01000000
+#define NFS_MOUNT_WRITE_WAIT		0x02000000
 
 	unsigned int		caps;		/* server capabilities */
 	unsigned int		rsize;		/* read size */
-- 
2.29.2

