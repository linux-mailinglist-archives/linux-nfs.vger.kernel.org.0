Return-Path: <linux-nfs+bounces-7799-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295A79C282C
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Nov 2024 00:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D68EB22B3A
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Nov 2024 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F10F1F26ED;
	Fri,  8 Nov 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rClBk5iX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6341F26E0
	for <linux-nfs@vger.kernel.org>; Fri,  8 Nov 2024 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109214; cv=none; b=Tcliarz7cDSmhWidJ5DBdydOCuUmoN35TvzpTL4X3EX2ljdLae4BEe3Ixbg1b4A1uMu0z5YQQxMisgCbb/PDsI4fNHbd4JAZdnMp5anYx8gncjEduFeIc+x5/gFrEHX6o5tSXtGa529FHT6z4lP5Kw+nx4AAiDNHowoKha7Y95M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109214; c=relaxed/simple;
	bh=9gjhMrEuA9ZA9K5kKsTIeYaHi6xW2/DlMbaKV4nDF+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1KyuSaStoo3QWe0sowFSPVLjZtlgUikKnkYeiyr+6s7+O9zKL5h/dWHKWs+WlXnrqpDcIQxRp15CB0np34t8IKzOyrLPM0kcmhJXzup2MfaC/P3utziYSUjhJA1wQEpTONHwrPm2L7R21sNvk0iRWTsjlf/dhoCzEsrhfAUm+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rClBk5iX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BD4C4CED2;
	Fri,  8 Nov 2024 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731109213;
	bh=9gjhMrEuA9ZA9K5kKsTIeYaHi6xW2/DlMbaKV4nDF+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rClBk5iX+e98H+c+9UfqY3k0KYzGjHM7GcFGK3A+jAatsrrbZgjDxGmaxi9Ynu3bE
	 avjnKn7WZlieYqnbizA5G5cGSUZaOwCc4lm1lWWqWmGz/BOj9OZdUslcGsaauH9Oom
	 ZOITQlTiWbpQ3lYOOZvxBqsG3tvP6ehrVoUL7iM28biO37CRt4uc2WhWkk3LEAf855
	 dyTAGmy+yy+MHVQEVlfYDuVosSiyN5UsX43GWlBnKavoj9/PtzngCXhafyvmi0NsOA
	 Tugmb+INO9hVZZejq9JkteoXbSYce2dZw5W6SgBaJ7pDCyLHGu45vpCjVbEOS9RD08
	 ajoJbVJJLUS4A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>
Subject: [for-6.13 PATCH 07/19] nfs/localio: add direct IO enablement with sync and async IO support
Date: Fri,  8 Nov 2024 18:39:50 -0500
Message-ID: <20241108234002.16392-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241108234002.16392-1-snitzer@kernel.org>
References: <20241108234002.16392-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit simply adds the required O_DIRECT plumbing.  It doesn't
address the fact that NFS doesn't ensure all writes are page aligned
(nor device logical block size aligned as required by O_DIRECT).

Because NFS will read-modify-write for IO that isn't aligned, LOCALIO
will not use O_DIRECT semantics by default if/when an application
requests the use of O_DIRECT.  Allow the use of O_DIRECT semantics by:
1: Adding a flag to the nfs_pgio_header struct to allow the NFS
   O_DIRECT layer to signal that O_DIRECT was used by the application
2: Adding a 'localio_O_DIRECT_semantics' NFS module parameter that
   when enabled will cause LOCALIO to use O_DIRECT semantics (this may
   cause IO to fail if applications do not properly align their IO).

Adding Direct IO support helps side-step the problem that LOCALIO
currently double buffers buffered IO (by using page cache in both NFS
and the underlying filesystem).  More care is needed to craft a proper
solution for LOCALIO's redundant use of page cache for buffered IO,
e.g.: https://marc.info/?l=linux-nfs&m=171996211625151&w=2

This commit is derived from code developed by Weston Andros Adamson.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c         |  1 +
 fs/nfs/localio.c        | 92 ++++++++++++++++++++++++++++++++++++-----
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 84 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 90079ca134dd..4b92493d6ff0 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -303,6 +303,7 @@ static void nfs_read_sync_pgio_error(struct list_head *head, int error)
 static void nfs_direct_pgio_init(struct nfs_pgio_header *hdr)
 {
 	get_dreq(hdr->dreq);
+	set_bit(NFS_IOHDR_ODIRECT, &hdr->flags);
 }
 
 static const struct nfs_pgio_completion_ops nfs_direct_read_completion_ops = {
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 4b8618cf114c..de0dcd76d84d 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -35,6 +35,7 @@ struct nfs_local_kiocb {
 	struct bio_vec		*bvec;
 	struct nfs_pgio_header	*hdr;
 	struct work_struct	work;
+	void (*aio_complete_work)(struct work_struct *);
 	struct nfsd_file	*localio;
 };
 
@@ -48,6 +49,10 @@ struct nfs_local_fsync_ctx {
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
+static bool localio_O_DIRECT_semantics __read_mostly = false;
+module_param(localio_O_DIRECT_semantics, bool, 0644);
+MODULE_PARM_DESC(localio_O_DIRECT_semantics, "Use O_DIRECT semantics");
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!test_bit(NFS_CS_LOCAL_IO, &clp->cl_flags);
@@ -285,10 +290,19 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		kfree(iocb);
 		return NULL;
 	}
-	init_sync_kiocb(&iocb->kiocb, file);
+
+	if (localio_O_DIRECT_semantics &&
+	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
+		iocb->kiocb.ki_filp = file;
+		iocb->kiocb.ki_flags = IOCB_DIRECT;
+	} else
+		init_sync_kiocb(&iocb->kiocb, file);
+
 	iocb->kiocb.ki_pos = hdr->args.offset;
 	iocb->hdr = hdr;
 	iocb->kiocb.ki_flags &= ~IOCB_APPEND;
+	iocb->aio_complete_work = NULL;
+
 	return iocb;
 }
 
@@ -343,6 +357,18 @@ nfs_local_pgio_release(struct nfs_local_kiocb *iocb)
 	nfs_local_hdr_release(hdr, hdr->task.tk_ops);
 }
 
+/*
+ * Complete the I/O from iocb->kiocb.ki_complete()
+ *
+ * Note that this function can be called from a bottom half context,
+ * hence we need to queue the rpc_call_done() etc to a workqueue
+ */
+static inline void nfs_local_pgio_aio_complete(struct nfs_local_kiocb *iocb)
+{
+	INIT_WORK(&iocb->work, iocb->aio_complete_work);
+	queue_work(nfsiod_workqueue, &iocb->work);
+}
+
 static void
 nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 {
@@ -365,6 +391,23 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 			status > 0 ? status : 0, hdr->res.eof);
 }
 
+static void nfs_local_read_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+
+	nfs_local_pgio_release(iocb);
+}
+
+static void nfs_local_read_aio_complete(struct kiocb *kiocb, long ret)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(kiocb, struct nfs_local_kiocb, kiocb);
+
+	nfs_local_read_done(iocb, ret);
+	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_read_aio_complete_work */
+}
+
 static void nfs_local_call_read(struct work_struct *work)
 {
 	struct nfs_local_kiocb *iocb =
@@ -379,10 +422,10 @@ static void nfs_local_call_read(struct work_struct *work)
 	nfs_local_iter_init(&iter, iocb, READ);
 
 	status = filp->f_op->read_iter(&iocb->kiocb, &iter);
-	WARN_ON_ONCE(status == -EIOCBQUEUED);
-
-	nfs_local_read_done(iocb, status);
-	nfs_local_pgio_release(iocb);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_read_done(iocb, status);
+		nfs_local_pgio_release(iocb);
+	}
 
 	revert_creds(save_cred);
 }
@@ -410,6 +453,11 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_read_aio_complete;
+		iocb->aio_complete_work = nfs_local_read_aio_complete_work;
+	}
+
 	INIT_WORK(&iocb->work, nfs_local_call_read);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
@@ -534,6 +582,24 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 	nfs_local_pgio_done(hdr, status);
 }
 
+static void nfs_local_write_aio_complete_work(struct work_struct *work)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(work, struct nfs_local_kiocb, work);
+
+	nfs_local_vfs_getattr(iocb);
+	nfs_local_pgio_release(iocb);
+}
+
+static void nfs_local_write_aio_complete(struct kiocb *kiocb, long ret)
+{
+	struct nfs_local_kiocb *iocb =
+		container_of(kiocb, struct nfs_local_kiocb, kiocb);
+
+	nfs_local_write_done(iocb, ret);
+	nfs_local_pgio_aio_complete(iocb); /* Calls nfs_local_write_aio_complete_work */
+}
+
 static void nfs_local_call_write(struct work_struct *work)
 {
 	struct nfs_local_kiocb *iocb =
@@ -552,11 +618,11 @@ static void nfs_local_call_write(struct work_struct *work)
 	file_start_write(filp);
 	status = filp->f_op->write_iter(&iocb->kiocb, &iter);
 	file_end_write(filp);
-	WARN_ON_ONCE(status == -EIOCBQUEUED);
-
-	nfs_local_write_done(iocb, status);
-	nfs_local_vfs_getattr(iocb);
-	nfs_local_pgio_release(iocb);
+	if (status != -EIOCBQUEUED) {
+		nfs_local_write_done(iocb, status);
+		nfs_local_vfs_getattr(iocb);
+		nfs_local_pgio_release(iocb);
+	}
 
 	revert_creds(save_cred);
 	current->flags = old_flags;
@@ -592,10 +658,16 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 	case NFS_FILE_SYNC:
 		iocb->kiocb.ki_flags |= IOCB_DSYNC|IOCB_SYNC;
 	}
+
 	nfs_local_pgio_init(hdr, call_ops);
 
 	nfs_set_local_verifier(hdr->inode, hdr->res.verf, hdr->args.stable);
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		iocb->kiocb.ki_complete = nfs_local_write_aio_complete;
+		iocb->aio_complete_work = nfs_local_write_aio_complete_work;
+	}
+
 	INIT_WORK(&iocb->work, nfs_local_call_write);
 	queue_work(nfslocaliod_workqueue, &iocb->work);
 
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index e0ae0a14257f..f30e94d105b7 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1632,6 +1632,7 @@ enum {
 	NFS_IOHDR_RESEND_PNFS,
 	NFS_IOHDR_RESEND_MDS,
 	NFS_IOHDR_UNSTABLE_WRITES,
+	NFS_IOHDR_ODIRECT,
 };
 
 struct nfs_io_completion;
-- 
2.44.0


