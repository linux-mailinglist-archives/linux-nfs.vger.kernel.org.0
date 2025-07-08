Return-Path: <linux-nfs+bounces-12941-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFACBAFD07C
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16CC93B4FF0
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC752E3AE8;
	Tue,  8 Jul 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPfZM5mu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7D2E266B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991674; cv=none; b=Pz/jwJONk1REaS1hh2wHt/YeWzp8m7I2/uzJKOdMcpEK6D8irAIduYtPm5PRpfvkUlS3l3TmupatPBzILIla5wtcT4CqbtgG4NbE8Cn7PkP+ghLcVzjcfVedqzoUyMRIauYbzTMse1d3ugls59zKswlGLy0jMHwSWNfysAcKwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991674; c=relaxed/simple;
	bh=79yZnvxEu1ZQcxFnvuuzxdyj1Uo3SWUQLpypFKCMhww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sG3GOYBUcIfqR/P5o8AJjMh21dfCHqpXlg9fXQw5huywFufSZageb/+e3xmFIYeYxCkvxKweOOHjgVRJ2RSHSe8f7JjYhbyxofw98x09Fekd+wECbvrkNFxr8nLK5OdgAg1fek4r+Xwrql3Q/zzQwx/WpWNudn7YediTbr43/cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPfZM5mu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270BBC4CEED;
	Tue,  8 Jul 2025 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991674;
	bh=79yZnvxEu1ZQcxFnvuuzxdyj1Uo3SWUQLpypFKCMhww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPfZM5mu/brsTM7dSVxwfFZLCdN4+1xDGQQ4F5r23BOA4O54J/+PNna6OJlmsnKHn
	 +MkT+Uu0PxYhwQVFVglUR2OeMgwtN4qO/v4fjZP9x56vlfTqqsbA5eJ0DMPOxWAh92
	 4FTNn2kfPvvnK301XvunXoeq4EjLcCQO6Kdl83NTNhI0g37dHLk4avB8rZl9Ub8spX
	 BM7EbUCGZFQDbG282y0U2AMVzCpu/jtpq4dqfPn+0xBl0ipsf6LFTNJXONuFlZkQvF
	 yMZoohZkv4Rwg3fZ6uukqk1UY6d7OXWvI7+ffTNrR65TlkCBWvhwmeZnp2tV+KkG9S
	 a7JjHSfaLhiMA==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	snitzer@kernel.org,
	Mike Snitzer <snitzer@hammerspace.com>
Subject: [RFC PATCH 4/6] nfs/localio: add nfsd_file_dio_alignment
Date: Tue,  8 Jul 2025 12:20:45 -0400
Message-ID: <20250708162047.65017-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708162047.65017-1-snitzer@kernel.org>
References: <20250708162047.65017-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

And use it to avoid issuing misaligned IO using O_DIRECT.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfs/localio.c           | 34 ++++++++++++++++++++++++++++++----
 fs/nfsd/localio.c          | 11 +++++++++++
 include/linux/nfslocalio.h |  2 ++
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 67de26392c4a..e551690e3f6b 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -37,6 +37,10 @@ struct nfs_local_kiocb {
 	struct work_struct	work;
 	void (*aio_complete_work)(struct work_struct *);
 	struct nfsd_file	*localio;
+	/* local copy of nfsd_file's dio alignment attrs */
+	u32			nf_dio_mem_align;
+	u32			nf_dio_offset_align;
+	u32			nf_dio_read_offset_align;
 };
 
 struct nfs_local_fsync_ctx {
@@ -323,12 +327,10 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		return NULL;
 	}
 
+	init_sync_kiocb(&iocb->kiocb, file);
 	if (localio_O_DIRECT_semantics &&
-	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
-		iocb->kiocb.ki_filp = file;
+	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
 		iocb->kiocb.ki_flags = IOCB_DIRECT;
-	} else
-		init_sync_kiocb(&iocb->kiocb, file);
 
 	iocb->kiocb.ki_pos = hdr->args.offset;
 	iocb->hdr = hdr;
@@ -342,11 +344,29 @@ static void
 nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 {
 	struct nfs_pgio_header *hdr = iocb->hdr;
+	u32 nf_dio_mem_align, nf_dio_offset_align;
+
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		nf_dio_mem_align = iocb->nf_dio_mem_align;
+		if (dir == READ)
+			nf_dio_offset_align = iocb->nf_dio_read_offset_align;
+		else
+			nf_dio_offset_align = iocb->nf_dio_offset_align;
+	}
 
 	iov_iter_bvec(i, dir, iocb->bvec, hdr->page_array.npages,
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
+	/* Verify the IO is DIO-aligned as needed */
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT &&
+	    !iov_iter_is_aligned(i, nf_dio_mem_align - 1,
+				 nf_dio_offset_align - 1)) {
+		/* Fallback to buffered IO */
+		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
+		iocb->kiocb.ki_complete = NULL;
+		iocb->aio_complete_work = NULL;
+	}
 }
 
 static void
@@ -481,6 +501,9 @@ nfs_do_local_read(struct nfs_pgio_header *hdr,
 	if (iocb == NULL)
 		return -ENOMEM;
 	iocb->localio = localio;
+	nfs_to->nfsd_file_dio_alignment(localio, &iocb->nf_dio_mem_align,
+					&iocb->nf_dio_offset_align,
+					&iocb->nf_dio_read_offset_align);
 
 	nfs_local_pgio_init(hdr, call_ops);
 	hdr->res.eof = false;
@@ -680,6 +703,9 @@ nfs_do_local_write(struct nfs_pgio_header *hdr,
 	if (iocb == NULL)
 		return -ENOMEM;
 	iocb->localio = localio;
+	nfs_to->nfsd_file_dio_alignment(localio, &iocb->nf_dio_mem_align,
+					&iocb->nf_dio_offset_align,
+					&iocb->nf_dio_read_offset_align);
 
 	switch (hdr->args.stable) {
 	default:
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 4f6468eb2adf..3eb1997289fe 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -116,6 +116,16 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
 	return localio;
 }
 
+static void nfsd_file_dio_alignment(struct nfsd_file *nf,
+				    u32 *nf_dio_mem_align,
+				    u32 *nf_dio_offset_align,
+				    u32 *nf_dio_read_offset_align)
+{
+	*nf_dio_mem_align = nf->nf_dio_mem_align;
+	*nf_dio_offset_align = nf->nf_dio_offset_align;
+	*nf_dio_read_offset_align = nf->nf_dio_read_offset_align;
+}
+
 static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_net_try_get  = nfsd_net_try_get,
 	.nfsd_net_put  = nfsd_net_put,
@@ -123,6 +133,7 @@ static const struct nfsd_localio_operations nfsd_localio_ops = {
 	.nfsd_file_put_local = nfsd_file_put_local,
 	.nfsd_file_get_local = nfsd_file_get_local,
 	.nfsd_file_file = nfsd_file_file,
+	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
 };
 
 void nfsd_localio_ops_init(void)
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 453d9de3d70b..f9d07fef7dba 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -65,6 +65,8 @@ struct nfsd_localio_operations {
 	struct net *(*nfsd_file_put_local)(struct nfsd_file *);
 	struct nfsd_file *(*nfsd_file_get_local)(struct nfsd_file *);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
+	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
+					u32 *, u32 *, u32 *);
 } ____cacheline_aligned;
 
 extern void nfsd_localio_ops_init(void);
-- 
2.44.0


