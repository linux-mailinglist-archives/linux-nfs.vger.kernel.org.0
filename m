Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9082231340A
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 14:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBHN4o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 08:56:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231704AbhBHN4c (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Feb 2021 08:56:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8622464E4F;
        Mon,  8 Feb 2021 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612792549;
        bh=KgjE87lOd8x6hjJA30x57vQAmDl5ZJxJhOVvaJ9dOB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QVV8ut8CLaIcY/Q5lBiWdcEVIn79tXXq+x8DlsHNMYyB9yZpqDS9V4lA45c92Gbr4
         xVDM/QxJum/uTPXXTyX7SacTb1MNY4oEexhRiQuE6UOSZkFtNo/qrGqDHjKQyRKFZL
         qqwU314/Pw/Io8ba+TpXF6cwCors0pxFU5HJI4IyITJ0mvqjoCXktocozxapassCgj
         8rpTlICs679w/VMpXfNtYcje37hdiz0KBw7R39zxeab9mNnPCJiejZfJpx0+c5knxJ
         PDfIaF1L0Jud64XzZ4KbJGLIGiDLMdXbu5JeEEdxrUmk2PL3daCZAhoHLyqm2Rw9ia
         fprpNGzLlcW3g==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Optimise sparse writes past the end of file
Date:   Mon,  8 Feb 2021 08:55:46 -0500
Message-Id: <20210208135547.27153-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210208135547.27153-1-trondmy@kernel.org>
References: <20210208135547.27153-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're doing a write, and the entire page lies beyond the end-of-file,
then we can assume the write can be extended to cover the beginning of
the page, since we know the data in that region will be all zeros.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c  |  4 +---
 fs/nfs/write.c | 20 ++++++++++++--------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index d02a63af9c15..02795a01c7ef 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -626,13 +626,11 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	/*
 	 * O_APPEND implies that we must revalidate the file length.
 	 */
-	if (iocb->ki_flags & IOCB_APPEND) {
+	if (iocb->ki_flags & IOCB_APPEND || iocb->ki_pos > i_size_read(inode)) {
 		result = nfs_revalidate_file_size(inode, file);
 		if (result)
 			goto out;
 	}
-	if (iocb->ki_pos > i_size_read(inode))
-		nfs_revalidate_mapping(inode, file->f_mapping);
 
 	since = filemap_sample_wb_err(file->f_mapping);
 	nfs_start_io_write(inode);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 639c34fec04a..6193350356a8 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1278,19 +1278,21 @@ bool nfs_ctx_key_to_expire(struct nfs_open_context *ctx, struct inode *inode)
  * the PageUptodate() flag. In this case, we will need to turn off
  * write optimisations that depend on the page contents being correct.
  */
-static bool nfs_write_pageuptodate(struct page *page, struct inode *inode)
+static bool nfs_write_pageuptodate(struct page *page, struct inode *inode,
+				   unsigned int pagelen)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	if (nfs_have_delegated_attributes(inode))
 		goto out;
-	if (nfsi->cache_validity & NFS_INO_REVAL_PAGECACHE)
+	if (nfsi->cache_validity &
+	    (NFS_INO_REVAL_PAGECACHE | NFS_INO_INVALID_SIZE))
 		return false;
 	smp_rmb();
-	if (test_bit(NFS_INO_INVALIDATING, &nfsi->flags))
+	if (test_bit(NFS_INO_INVALIDATING, &nfsi->flags) && pagelen != 0)
 		return false;
 out:
-	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
+	if (nfsi->cache_validity & NFS_INO_INVALID_DATA && pagelen != 0)
 		return false;
 	return PageUptodate(page) != 0;
 }
@@ -1310,7 +1312,8 @@ is_whole_file_wrlock(struct file_lock *fl)
  * If the file is opened for synchronous writes then we can just skip the rest
  * of the checks.
  */
-static int nfs_can_extend_write(struct file *file, struct page *page, struct inode *inode)
+static int nfs_can_extend_write(struct file *file, struct page *page,
+				struct inode *inode, unsigned int pagelen)
 {
 	int ret;
 	struct file_lock_context *flctx = inode->i_flctx;
@@ -1318,7 +1321,7 @@ static int nfs_can_extend_write(struct file *file, struct page *page, struct ino
 
 	if (file->f_flags & O_DSYNC)
 		return 0;
-	if (!nfs_write_pageuptodate(page, inode))
+	if (!nfs_write_pageuptodate(page, inode, pagelen))
 		return 0;
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_WRITE))
 		return 1;
@@ -1356,6 +1359,7 @@ int nfs_updatepage(struct file *file, struct page *page,
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	struct address_space *mapping = page_file_mapping(page);
 	struct inode	*inode = mapping->host;
+	unsigned int	pagelen = nfs_page_length(page);
 	int		status = 0;
 
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
@@ -1366,8 +1370,8 @@ int nfs_updatepage(struct file *file, struct page *page,
 	if (!count)
 		goto out;
 
-	if (nfs_can_extend_write(file, page, inode)) {
-		count = max(count + offset, nfs_page_length(page));
+	if (nfs_can_extend_write(file, page, inode, pagelen)) {
+		count = max(count + offset, pagelen);
 		offset = 0;
 	}
 
-- 
2.29.2

