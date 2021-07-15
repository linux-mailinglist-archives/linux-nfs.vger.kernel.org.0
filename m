Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F72E3C9655
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Jul 2021 05:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhGODTD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Jul 2021 23:19:03 -0400
Received: from foss.arm.com ([217.140.110.172]:45980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233500AbhGODTD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68E531042;
        Wed, 14 Jul 2021 20:16:10 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C81BB3F7D8;
        Wed, 14 Jul 2021 20:16:07 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH RFC 04/13] NFS: Remove the number postfix of '%pD' in format string
Date:   Thu, 15 Jul 2021 11:15:24 +0800
Message-Id: <20210715031533.9553-5-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the previous number postfix is pointless.

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna.schumaker@netapp.com>
Cc: linux-nfs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 fs/nfs/dir.c      | 12 ++++++------
 fs/nfs/direct.c   |  4 ++--
 fs/nfs/file.c     | 26 +++++++++++++-------------
 fs/nfs/nfs4file.c |  2 +-
 fs/nfs/write.c    |  2 +-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1a6d2867fba4..77e210bf42aa 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -108,7 +108,7 @@ nfs_opendir(struct inode *inode, struct file *filp)
 	int res = 0;
 	struct nfs_open_dir_context *ctx;
 
-	dfprintk(FILE, "NFS: open dir(%pD2)\n", filp);
+	dfprintk(FILE, "NFS: open dir(%pD)\n", filp);
 
 	nfs_inc_stats(inode, NFSIOS_VFSOPEN);
 
@@ -453,7 +453,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 				if (desc->duped > 0
 				    && desc->dup_cookie == desc->dir_cookie) {
 					if (printk_ratelimit()) {
-						pr_notice("NFS: directory %pD2 contains a readdir loop."
+						pr_notice("NFS: directory %pD contains a readdir loop."
 								"Please contact your server vendor.  "
 								"The file: %s has duplicate cookie %llu\n",
 								desc->file, array->array[i].name, desc->dir_cookie);
@@ -1081,7 +1081,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	struct nfs_readdir_descriptor *desc;
 	int res;
 
-	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
+	dfprintk(FILE, "NFS: readdir(%pD) starting at cookie %llu\n",
 			file, (long long)ctx->pos);
 	nfs_inc_stats(inode, NFSIOS_VFSGETDENTS);
 
@@ -1155,7 +1155,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	kfree(desc);
 
 out:
-	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
+	dfprintk(FILE, "NFS: readdir(%pD) returns %d\n", file, res);
 	return res;
 }
 
@@ -1163,7 +1163,7 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 {
 	struct nfs_open_dir_context *dir_ctx = filp->private_data;
 
-	dfprintk(FILE, "NFS: llseek dir(%pD2, %lld, %d)\n",
+	dfprintk(FILE, "NFS: llseek dir(%pD, %lld, %d)\n",
 			filp, offset, whence);
 
 	switch (whence) {
@@ -1205,7 +1205,7 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 static int nfs_fsync_dir(struct file *filp, loff_t start, loff_t end,
 			 int datasync)
 {
-	dfprintk(FILE, "NFS: fsync dir(%pD2) datasync %d\n", filp, datasync);
+	dfprintk(FILE, "NFS: fsync dir(%pD) datasync %d\n", filp, datasync);
 
 	nfs_inc_stats(file_inode(filp), NFSIOS_VFSFSYNC);
 	return 0;
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 2e894fec036b..762675a837a5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -450,7 +450,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	size_t count = iov_iter_count(iter);
 	nfs_add_stats(mapping->host, NFSIOS_DIRECTREADBYTES, count);
 
-	dfprintk(FILE, "NFS: direct read(%pD2, %zd@%Ld)\n",
+	dfprintk(FILE, "NFS: direct read(%pD, %zd@%Ld)\n",
 		file, count, (long long) iocb->ki_pos);
 
 	result = 0;
@@ -902,7 +902,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter)
 	struct nfs_lock_context *l_ctx;
 	loff_t pos, end;
 
-	dfprintk(FILE, "NFS: direct write(%pD2, %zd@%Ld)\n",
+	dfprintk(FILE, "NFS: direct write(%pD, %zd@%Ld)\n",
 		file, iov_iter_count(iter), (long long) iocb->ki_pos);
 
 	result = generic_write_checks(iocb, iter);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 1fef107961bc..fbdec0e0dcce 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -66,7 +66,7 @@ nfs_file_open(struct inode *inode, struct file *filp)
 {
 	int res;
 
-	dprintk("NFS: open file(%pD2)\n", filp);
+	dprintk("NFS: open file(%pD)\n", filp);
 
 	nfs_inc_stats(inode, NFSIOS_VFSOPEN);
 	res = nfs_check_flags(filp->f_flags);
@@ -80,7 +80,7 @@ nfs_file_open(struct inode *inode, struct file *filp)
 int
 nfs_file_release(struct inode *inode, struct file *filp)
 {
-	dprintk("NFS: release(%pD2)\n", filp);
+	dprintk("NFS: release(%pD)\n", filp);
 
 	nfs_inc_stats(inode, NFSIOS_VFSRELEASE);
 	nfs_file_clear_open_context(filp);
@@ -114,7 +114,7 @@ static int nfs_revalidate_file_size(struct inode *inode, struct file *filp)
 
 loff_t nfs_file_llseek(struct file *filp, loff_t offset, int whence)
 {
-	dprintk("NFS: llseek file(%pD2, %lld, %d)\n",
+	dprintk("NFS: llseek file(%pD, %lld, %d)\n",
 			filp, offset, whence);
 
 	/*
@@ -142,7 +142,7 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 	struct inode	*inode = file_inode(file);
 	errseq_t since;
 
-	dprintk("NFS: flush(%pD2)\n", file);
+	dprintk("NFS: flush(%pD)\n", file);
 
 	nfs_inc_stats(inode, NFSIOS_VFSFLUSH);
 	if ((file->f_mode & FMODE_WRITE) == 0)
@@ -163,7 +163,7 @@ nfs_file_read(struct kiocb *iocb, struct iov_iter *to)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return nfs_file_direct_read(iocb, to);
 
-	dprintk("NFS: read(%pD2, %zu@%lu)\n",
+	dprintk("NFS: read(%pD, %zu@%lu)\n",
 		iocb->ki_filp,
 		iov_iter_count(to), (unsigned long) iocb->ki_pos);
 
@@ -185,7 +185,7 @@ nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
 	struct inode *inode = file_inode(file);
 	int	status;
 
-	dprintk("NFS: mmap(%pD2)\n", file);
+	dprintk("NFS: mmap(%pD)\n", file);
 
 	/* Note: generic_file_mmap() returns ENOSYS on nommu systems
 	 *       so we call that before revalidating the mapping
@@ -210,7 +210,7 @@ nfs_file_fsync_commit(struct file *file, int datasync)
 	struct inode *inode = file_inode(file);
 	int ret;
 
-	dprintk("NFS: fsync file(%pD2) datasync %d\n", file, datasync);
+	dprintk("NFS: fsync file(%pD) datasync %d\n", file, datasync);
 
 	nfs_inc_stats(inode, NFSIOS_VFSFSYNC);
 	ret = nfs_commit_inode(inode, FLUSH_SYNC);
@@ -325,7 +325,7 @@ static int nfs_write_begin(struct file *file, struct address_space *mapping,
 	struct page *page;
 	int once_thru = 0;
 
-	dfprintk(PAGECACHE, "NFS: write_begin(%pD2(%lu), %u@%lld)\n",
+	dfprintk(PAGECACHE, "NFS: write_begin(%pD(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
 start:
@@ -357,7 +357,7 @@ static int nfs_write_end(struct file *file, struct address_space *mapping,
 	struct nfs_open_context *ctx = nfs_file_open_context(file);
 	int status;
 
-	dfprintk(PAGECACHE, "NFS: write_end(%pD2(%lu), %u@%lld)\n",
+	dfprintk(PAGECACHE, "NFS: write_end(%pD(%lu), %u@%lld)\n",
 		file, mapping->host->i_ino, len, (long long) pos);
 
 	/*
@@ -548,7 +548,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
 	vm_fault_t ret = VM_FAULT_NOPAGE;
 	struct address_space *mapping;
 
-	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
+	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD(%lu), offset %lld)\n",
 		filp, filp->f_mapping->host->i_ino,
 		(long long)page_offset(page));
 
@@ -618,7 +618,7 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT)
 		return nfs_file_direct_write(iocb, from);
 
-	dprintk("NFS: write(%pD2, %zu@%Ld)\n",
+	dprintk("NFS: write(%pD, %zu@%Ld)\n",
 		file, iov_iter_count(from), (long long) iocb->ki_pos);
 
 	if (IS_SWAPFILE(inode))
@@ -800,7 +800,7 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 	int ret = -ENOLCK;
 	int is_local = 0;
 
-	dprintk("NFS: lock(%pD2, t=%x, fl=%x, r=%lld:%lld)\n",
+	dprintk("NFS: lock(%pD, t=%x, fl=%x, r=%lld:%lld)\n",
 			filp, fl->fl_type, fl->fl_flags,
 			(long long)fl->fl_start, (long long)fl->fl_end);
 
@@ -838,7 +838,7 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 	struct inode *inode = filp->f_mapping->host;
 	int is_local = 0;
 
-	dprintk("NFS: flock(%pD2, t=%x, fl=%x)\n",
+	dprintk("NFS: flock(%pD, t=%x, fl=%x)\n",
 			filp, fl->fl_type, fl->fl_flags);
 
 	if (!(fl->fl_flags & FL_FLOCK))
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index c820de58a661..c06257b23027 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -113,7 +113,7 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 	struct inode	*inode = file_inode(file);
 	errseq_t since;
 
-	dprintk("NFS: flush(%pD2)\n", file);
+	dprintk("NFS: flush(%pD)\n", file);
 
 	nfs_inc_stats(inode, NFSIOS_VFSFLUSH);
 	if ((file->f_mode & FMODE_WRITE) == 0)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index eae9bf114041..c75b43e2bba9 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1368,7 +1368,7 @@ int nfs_updatepage(struct file *file, struct page *page,
 
 	nfs_inc_stats(inode, NFSIOS_VFSUPDATEPAGE);
 
-	dprintk("NFS:       nfs_updatepage(%pD2 %d@%lld)\n",
+	dprintk("NFS:       nfs_updatepage(%pD %d@%lld)\n",
 		file, count, (long long)(page_file_offset(page) + offset));
 
 	if (!count)
-- 
2.17.1

