Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207092C9003
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Nov 2020 22:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbgK3V0W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 30 Nov 2020 16:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388445AbgK3V0W (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 30 Nov 2020 16:26:22 -0500
Received: from leira.hammer.space (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B416E21973;
        Mon, 30 Nov 2020 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606771505;
        bh=4xTUhw5ZJatyL9r2+gRgO4Sidr3s+3rE+Mp+QVeUqTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkrxXM1wgLe7ABZ8VAvy43Vc9MmzSjQlM8iaEsJ9HqM9wp2W38Fdf/XtDWHf6eMc7
         fmsDP7v+yWINDtFm9SrMLeDWvoqc975xQu7eheXYFtSY6AiT2ORTrdq1GsHlUPBcfw
         NIy3fOIQFn41rhj7yuQzzcZAbxDHiFVIfsjOQ2rw=
From:   trondmy@kernel.org
To:     "J. Bruce Fields" <bfields@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] nfsd: Set PF_LOCAL_THROTTLE on local filesystems only
Date:   Mon, 30 Nov 2020 16:24:55 -0500
Message-Id: <20201130212455.254469-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130212455.254469-6-trondmy@kernel.org>
References: <20201130212455.254469-1-trondmy@kernel.org>
 <20201130212455.254469-2-trondmy@kernel.org>
 <20201130212455.254469-3-trondmy@kernel.org>
 <20201130212455.254469-4-trondmy@kernel.org>
 <20201130212455.254469-5-trondmy@kernel.org>
 <20201130212455.254469-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Don't set PF_LOCAL_THROTTLE on remote filesystems like NFS, since they
aren't expected to ever be subject to double buffering.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/export.c          |  3 ++-
 fs/nfsd/vfs.c            | 13 +++++++++++--
 include/linux/exportfs.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 5428713af5fe..48b879cfe6e3 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -171,5 +171,6 @@ const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
-	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|EXPORT_OP_CLOSE_BEFORE_UNLINK,
+	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
+		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS,
 };
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 79cba942087e..04937e51de56 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -978,18 +978,25 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 				__be32 *verf)
 {
 	struct file		*file = nf->nf_file;
+	struct super_block	*sb = file_inode(file)->i_sb;
 	struct svc_export	*exp;
 	struct iov_iter		iter;
 	__be32			nfserr;
 	int			host_err;
 	int			use_wgather;
 	loff_t			pos = offset;
+	unsigned long		exp_op_flags = 0;
 	unsigned int		pflags = current->flags;
 	rwf_t			flags = 0;
+	bool			restore_flags = false;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
-	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
+	if (sb->s_export_op)
+		exp_op_flags = sb->s_export_op->flags;
+
+	if (test_bit(RQ_LOCAL, &rqstp->rq_flags) &&
+	    !(exp_op_flags & EXPORT_OP_REMOTE_FS)) {
 		/*
 		 * We want throttling in balance_dirty_pages()
 		 * and shrink_inactive_list() to only consider
@@ -998,6 +1005,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		 * the client's dirty pages or its congested queue.
 		 */
 		current->flags |= PF_LOCAL_THROTTLE;
+		restore_flags = true;
+	}
 
 	exp = fhp->fh_export;
 	use_wgather = (rqstp->rq_vers == 2) && EX_WGATHER(exp);
@@ -1049,7 +1058,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 		trace_nfsd_write_err(rqstp, fhp, offset, host_err);
 		nfserr = nfserrno(host_err);
 	}
-	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
+	if (restore_flags)
 		current_restore_flags(pflags, PF_LOCAL_THROTTLE);
 	return nfserr;
 }
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 846df3c96730..d93e8a6737bb 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -216,6 +216,7 @@ struct export_operations {
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
+#define EXPORT_OP_REMOTE_FS		(0x8) /* Filesystem is remote */
 	unsigned long	flags;
 };
 
-- 
2.28.0

