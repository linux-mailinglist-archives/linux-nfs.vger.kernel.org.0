Return-Path: <linux-nfs+bounces-13383-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA3B18654
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 19:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956AA7ADA68
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B891DED4C;
	Fri,  1 Aug 2025 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuScS1TM"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185E1A23A6
	for <linux-nfs@vger.kernel.org>; Fri,  1 Aug 2025 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068256; cv=none; b=sOhh4UTLP/B1P85YEGpDi8uFZxLC0InkopzdeQA+Tj4wed2H3cbaDzpspK0q89x8JYz7TsNDEnPt4navmeCBsfvsSyArIjroMpVV0RPDUWFdLI1beUIkcnERb7qi16IYvrjAcxS2tR8yk7XYx8kQcSN7ZmfXKloM8nw0lZJomo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068256; c=relaxed/simple;
	bh=09nQNbLEX29US/grLkc19/m1QsBC16nHeNzdKG0bhjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=avMASvgmU9Gy0jiIwuOi0X1Vc6MIVG77JboaqzLYULAqOaR3QYHJiI330Q+g9Lj1m0oWQ6QNPCDEUOYkVWieoD9KFZnQlDer5L0vdREJ7sb7KkPKGmjjnY0gn2g8OYtfX0oAg/vvT27DjLdFAJ26GFMKLK1pMCmZ1paq+6nwkSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuScS1TM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B42C4CEE7;
	Fri,  1 Aug 2025 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068254;
	bh=09nQNbLEX29US/grLkc19/m1QsBC16nHeNzdKG0bhjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuScS1TMctM4baBaLlvb4Te8HK/Jq8jQYTugDstU8lLwautJE13z1bk0TLlyyaaaJ
	 lYEcxqL3Vt0Wj+Nzq8h7bkjkRd8IOBWh6ZcvyRul0u2SpCr+c9tLwzhCcn24g+5ibN
	 cPXEAGPnOsqzGRlce6pjdtIOGl5VEXB9GxKvNpxJUzoxMKRKVohvBeCQjG3Ntrx66y
	 Pj3vIJRlSFj0qhkvBbeVZT0rvbPglqdobpFiwnQEInnWsx/JDh4TkXUdPnqZfRcEi7
	 c8d9vQsa/LULTRj/8jJzmpgJ0W69bnkyzH7tZH/ARhvIALMXYVHqSz+q1ArySDXTKR
	 37Xuo8RtFh90g==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v6 3/7] nfs/localio: add nfsd_file_dio_alignment
Date: Fri,  1 Aug 2025 13:10:45 -0400
Message-ID: <20250801171049.94235-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250801171049.94235-1-snitzer@kernel.org>
References: <20250801171049.94235-1-snitzer@kernel.org>
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
 fs/nfs/localio.c           | 26 ++++++++++++++++++++++----
 fs/nfsd/localio.c          | 11 +++++++++++
 include/linux/nfslocalio.h |  2 ++
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 0b54f01299d2c..0c48db38f74f0 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -322,12 +322,10 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
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
@@ -346,6 +344,26 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 		      hdr->args.count + hdr->args.pgbase);
 	if (hdr->args.pgbase != 0)
 		iov_iter_advance(i, hdr->args.pgbase);
+
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		u32 nf_dio_mem_align, nf_dio_offset_align, nf_dio_read_offset_align;
+		/* Verify the IO is DIO-aligned as required */
+		nfs_to->nfsd_file_dio_alignment(iocb->localio, &nf_dio_mem_align,
+						&nf_dio_offset_align,
+						&nf_dio_read_offset_align);
+		if (dir == READ)
+			nf_dio_offset_align = nf_dio_read_offset_align;
+		/* direct I/O must be aligned to device logical sector size */
+		if (nf_dio_mem_align && nf_dio_offset_align &&
+		    (((hdr->args.offset | hdr->args.count) & (nf_dio_offset_align-1)) == 0) &&
+		    iov_iter_is_aligned(i, nf_dio_mem_align - 1,
+					nf_dio_offset_align - 1))
+			return 0;
+
+		/* Fallback to using buffered for this misaligned IO */
+		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
+		iocb->kiocb.ki_filp->f_flags &= ~O_DIRECT;
+	}
 }
 
 static void
diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
index 269fa9391dc46..be710d809a3ba 100644
--- a/fs/nfsd/localio.c
+++ b/fs/nfsd/localio.c
@@ -117,12 +117,23 @@ nfsd_open_local_fh(struct net *net, struct auth_domain *dom,
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
 	.nfsd_open_local_fh = nfsd_open_local_fh,
 	.nfsd_file_put_local = nfsd_file_put_local,
 	.nfsd_file_file = nfsd_file_file,
+	.nfsd_file_dio_alignment = nfsd_file_dio_alignment,
 };
 
 void nfsd_localio_ops_init(void)
diff --git a/include/linux/nfslocalio.h b/include/linux/nfslocalio.h
index 59ea90bd136b6..3d91043254e64 100644
--- a/include/linux/nfslocalio.h
+++ b/include/linux/nfslocalio.h
@@ -64,6 +64,8 @@ struct nfsd_localio_operations {
 						const fmode_t);
 	struct net *(*nfsd_file_put_local)(struct nfsd_file __rcu **);
 	struct file *(*nfsd_file_file)(struct nfsd_file *);
+	void (*nfsd_file_dio_alignment)(struct nfsd_file *,
+					u32 *, u32 *, u32 *);
 } ____cacheline_aligned;
 
 extern void nfsd_localio_ops_init(void);
-- 
2.44.0


