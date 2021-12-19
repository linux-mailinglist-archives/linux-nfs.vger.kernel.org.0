Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7FF479EBE
	for <lists+linux-nfs@lfdr.de>; Sun, 19 Dec 2021 02:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhLSBo4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 18 Dec 2021 20:44:56 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60862 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbhLSBo4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 18 Dec 2021 20:44:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA6760C8A
        for <linux-nfs@vger.kernel.org>; Sun, 19 Dec 2021 01:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A4FC36AE5;
        Sun, 19 Dec 2021 01:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639878295;
        bh=0s/YrDE9wWIpyqHRdcF+SoTQu3BUO7YN1DUITLJ5H+I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=atTd80dyC0P2W98e7u1/8UqpKZFU8pzdpm0mwul3RHwncO0rAygFo2bzbjrTInE+Z
         XPSxiWztMuauuvUiBWTj5MEF361VoAsqnPalyb2wtvIaiRIn4U0JpNbFMKwWoxOrdO
         gsMwTXMNLztA8kuPo7KnS91G9FN8CY50NVVVaH9qbI2R7Sqzx6Wcji6z42+Ri2qMTM
         Y69mhn7AruzEoFYO8DtKdGqfWqoCajYaAdUbC1HM3vnc3KSwOGbGxWUyPyxSmTQDqW
         EosG7l3Z5bL8JTd55tb5K2KuhclkaPHXHIeiVo/K31FSJkpeXy65YHN/3svEwMCtSq
         XeYeXVZ221pEQ==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 08/10] nfsd: Replace use of rwsem with errseq_t
Date:   Sat, 18 Dec 2021 20:38:01 -0500
Message-Id: <20211219013803.324724-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211219013803.324724-8-trondmy@kernel.org>
References: <20211219013803.324724-1-trondmy@kernel.org>
 <20211219013803.324724-2-trondmy@kernel.org>
 <20211219013803.324724-3-trondmy@kernel.org>
 <20211219013803.324724-4-trondmy@kernel.org>
 <20211219013803.324724-5-trondmy@kernel.org>
 <20211219013803.324724-6-trondmy@kernel.org>
 <20211219013803.324724-7-trondmy@kernel.org>
 <20211219013803.324724-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The nfsd_file nf_rwsem is currently being used to separate file write
and commit instances to ensure that we catch errors and apply them to
the correct write/commit.
We can improve scalability at the expense of a little accuracy (some
extra false positives) by replacing the nf_rwsem with more careful
use of the errseq_t mechanism to track errors across the different
operations.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfsd/filecache.c |  1 -
 fs/nfsd/filecache.h |  1 -
 fs/nfsd/nfs4proc.c  | 16 +++++++++-------
 fs/nfsd/vfs.c       | 40 +++++++++++++++-------------------------
 4 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fdf89fcf1a0c..36f5a06d1067 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -194,7 +194,6 @@ nfsd_file_alloc(struct inode *inode, unsigned int may, unsigned int hashval,
 				__set_bit(NFSD_FILE_BREAK_READ, &nf->nf_flags);
 		}
 		nf->nf_mark = NULL;
-		init_rwsem(&nf->nf_rwsem);
 		trace_nfsd_file_alloc(nf);
 	}
 	return nf;
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 7872df5a0fe3..435ceab27897 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -46,7 +46,6 @@ struct nfsd_file {
 	refcount_t		nf_ref;
 	unsigned char		nf_may;
 	struct nfsd_file_mark	*nf_mark;
-	struct rw_semaphore	nf_rwsem;
 };
 
 int nfsd_file_cache_init(void);
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 35f33959a083..8d2b9ad3b84a 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1510,6 +1510,9 @@ static void nfsd4_init_copy_res(struct nfsd4_copy *copy, bool sync)
 
 static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 {
+	struct file *dst = copy->nf_dst->nf_file;
+	struct file *src = copy->nf_src->nf_file;
+	errseq_t since;
 	ssize_t bytes_copied = 0;
 	u64 bytes_total = copy->cp_count;
 	u64 src_pos = copy->cp_src_pos;
@@ -1522,9 +1525,8 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	do {
 		if (kthread_should_stop())
 			break;
-		bytes_copied = nfsd_copy_file_range(copy->nf_src->nf_file,
-				src_pos, copy->nf_dst->nf_file, dst_pos,
-				bytes_total);
+		bytes_copied = nfsd_copy_file_range(src, src_pos, dst, dst_pos,
+						    bytes_total);
 		if (bytes_copied <= 0)
 			break;
 		bytes_total -= bytes_copied;
@@ -1534,11 +1536,11 @@ static ssize_t _nfsd_copy_file_range(struct nfsd4_copy *copy)
 	} while (bytes_total > 0 && !copy->cp_synchronous);
 	/* for a non-zero asynchronous copy do a commit of data */
 	if (!copy->cp_synchronous && copy->cp_res.wr_bytes_written > 0) {
-		down_write(&copy->nf_dst->nf_rwsem);
-		status = vfs_fsync_range(copy->nf_dst->nf_file,
-					 copy->cp_dst_pos,
+		since = READ_ONCE(dst->f_wb_err);
+		status = vfs_fsync_range(dst, copy->cp_dst_pos,
 					 copy->cp_res.wr_bytes_written, 0);
-		up_write(&copy->nf_dst->nf_rwsem);
+		if (!status)
+			status = filemap_check_wb_err(dst->f_mapping, since);
 		if (!status)
 			copy->committed = true;
 	}
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 4d2964d08097..8a48bf18028c 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -530,10 +530,11 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 {
 	struct file *src = nf_src->nf_file;
 	struct file *dst = nf_dst->nf_file;
+	errseq_t since;
 	loff_t cloned;
 	__be32 ret = 0;
 
-	down_write(&nf_dst->nf_rwsem);
+	since = READ_ONCE(dst->f_wb_err);
 	cloned = vfs_clone_file_range(src, src_pos, dst, dst_pos, count, 0);
 	if (cloned < 0) {
 		ret = nfserrno(cloned);
@@ -547,6 +548,8 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 		loff_t dst_end = count ? dst_pos + count - 1 : LLONG_MAX;
 		int status = vfs_fsync_range(dst, dst_pos, dst_end, 0);
 
+		if (!status)
+			status = filemap_check_wb_err(dst->f_mapping, since);
 		if (!status)
 			status = commit_inode_metadata(file_inode(src));
 		if (status < 0) {
@@ -562,7 +565,6 @@ __be32 nfsd4_clone_file_range(struct svc_rqst *rqstp,
 		}
 	}
 out_err:
-	up_write(&nf_dst->nf_rwsem);
 	return ret;
 }
 
@@ -970,6 +972,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	struct super_block	*sb = file_inode(file)->i_sb;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
+	errseq_t		since;
 	__be32			nfserr;
 	int			host_err;
 	int			use_wgather;
@@ -1010,21 +1013,18 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		flags |= RWF_SYNC;
 
 	iov_iter_kvec(&iter, WRITE, vec, vlen, *cnt);
+	since = READ_ONCE(file->f_wb_err);
 	if (flags & RWF_SYNC) {
-		down_write(&nf->nf_rwsem);
 		host_err = vfs_iter_write(file, &iter, &pos, flags);
 		if (host_err < 0)
 			nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
 						 nfsd_net_id));
-		up_write(&nf->nf_rwsem);
 	} else {
-		down_read(&nf->nf_rwsem);
 		if (verf)
 			nfsd_copy_boot_verifier(verf,
 					net_generic(SVC_NET(rqstp),
 					nfsd_net_id));
 		host_err = vfs_iter_write(file, &iter, &pos, flags);
-		up_read(&nf->nf_rwsem);
 	}
 	if (host_err < 0) {
 		nfsd_reset_boot_verifier(net_generic(SVC_NET(rqstp),
@@ -1034,6 +1034,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	*cnt = host_err;
 	nfsd_stats_io_write_add(exp, *cnt);
 	fsnotify_modify(file);
+	host_err = filemap_check_wb_err(file->f_mapping, since);
+	if (host_err < 0)
+		goto out_nfserr;
 
 	if (stable && use_wgather) {
 		host_err = wait_for_concurrent_writes(file);
@@ -1114,19 +1117,6 @@ nfsd_write(struct svc_rqst *rqstp, struct svc_fh *fhp, loff_t offset,
 }
 
 #ifdef CONFIG_NFSD_V3
-static int
-nfsd_filemap_write_and_wait_range(struct nfsd_file *nf, loff_t offset,
-				  loff_t end)
-{
-	struct address_space *mapping = nf->nf_file->f_mapping;
-	int ret = filemap_fdatawrite_range(mapping, offset, end);
-
-	if (ret)
-		return ret;
-	filemap_fdatawait_range_keep_errors(mapping, offset, end);
-	return 0;
-}
-
 /*
  * Commit all pending writes to stable storage.
  *
@@ -1157,25 +1147,25 @@ nfsd_commit(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (err)
 		goto out;
 	if (EX_ISSYNC(fhp->fh_export)) {
-		int err2 = nfsd_filemap_write_and_wait_range(nf, offset, end);
+		errseq_t since = READ_ONCE(nf->nf_file->f_wb_err);
+		int err2;
 
-		down_write(&nf->nf_rwsem);
-		if (!err2)
-			err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
+		err2 = vfs_fsync_range(nf->nf_file, offset, end, 0);
 		switch (err2) {
 		case 0:
 			nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
 						nfsd_net_id));
+			err2 = filemap_check_wb_err(nf->nf_file->f_mapping,
+						    since);
 			break;
 		case -EINVAL:
 			err = nfserr_notsupp;
 			break;
 		default:
-			err = nfserrno(err2);
 			nfsd_reset_boot_verifier(net_generic(nf->nf_net,
 						 nfsd_net_id));
 		}
-		up_write(&nf->nf_rwsem);
+		err = nfserrno(err2);
 	} else
 		nfsd_copy_boot_verifier(verf, net_generic(nf->nf_net,
 					nfsd_net_id));
-- 
2.33.1

