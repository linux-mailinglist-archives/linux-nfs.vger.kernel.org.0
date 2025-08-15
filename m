Return-Path: <linux-nfs+bounces-13691-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8CDB288C3
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5C5AC3E13
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290F124887E;
	Fri, 15 Aug 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tojMGOZy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0503E2D47F7
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300609; cv=none; b=SPSBh5ouMOlTm8lugKyd9DBfpXjcvj8qFajPOuJILezb0cuSW10P7RDkAiUCPCGK04CW2Jyc17VAAj2tUBOpdfEUuLPWmtVmgeGJhktZx/8s9L+zR2sSt050xgjZyNNnONhzEV3jWkqgxPrYTjf6p2MGvMI2ZnVB2dPQmPvzIE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300609; c=relaxed/simple;
	bh=xHKEXvf0au3VBjN8z6WX4xBpmdtL97DxC2iUtPnlY08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI/hTTtRuYyCfUIqwmdiBrev/AZnpnw6mRMOYEP1MOdL1dvSK7APZq1nYGAAugZZng6ZIco5gQCZK3nU2qiF7VC6S9IRUi2eT4OoIbEGlHlAnFHBCnPLFGKS544KZoFK0lUzBIsp2c8WN4T02kwrLgMHrTa2HHNV33OriNIFciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tojMGOZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A49C4CEF4;
	Fri, 15 Aug 2025 23:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300608;
	bh=xHKEXvf0au3VBjN8z6WX4xBpmdtL97DxC2iUtPnlY08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tojMGOZyW80yVZ5yRx3Qu6zFe3eoPTy7hUzxc9jY2gTwBL+TVtGp0Omo5/CQcOSYJ
	 3etUzIPRiFElGtZ8b4NzuivlLZ7W4gj2g7NENaLneIce1TuVq6Mbz7qG8j+Qt7hCm6
	 ZBBtRow8IBDaFdjrOJJdU9QvOCElGCs1DZIoixojONatqDf3jjB2Ifere3O0DhKHa3
	 e0hCW303dN6X4f0pQbnKPBGkV4fi8CZbQXTZE6rBLTlghC4NudR9vMDg8zUcASJZn6
	 VsuM0OJWP+JcmUHz+Ic/qM15a/ePluwp8EifgP1FJlcfbRZ0CbD07TI2MbmyH/Ght5
	 +BAhEEjUfVEQw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 3/9] nfs/localio: avoid issuing misaligned IO using O_DIRECT
Date: Fri, 15 Aug 2025 19:29:57 -0400
Message-ID: <20250815233003.55071-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815233003.55071-1-snitzer@kernel.org>
References: <20250815233003.55071-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
using O_DIRECT.

Also introduce nfs_iov_iter_aligned_bvec() which is a variant of
iov_iter_aligned_bvec() that also verifies the offset associated with
an iov_iter is DIO-aligned.

NOTE: in a parallel effort, iov_iter_aligned_bvec() is being removed
along with iov_iter_is_aligned().

Lastly, add WARN_ON_ONCE if underlying filesystem returns -EINVAL
because it was made to try O_DIRECT for IO that is not DIO-aligned
(shouldn't happen, so its best to be loud if it does).

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           | 66 +++++++++++++++++++++++++++++++++++---
 fs/nfsd/localio.c          | 11 +++++++
 include/linux/nfslocalio.h |  2 ++
 3 files changed, 74 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 42ea50d42c995..9b12ddc19485f 100644
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
@@ -337,6 +335,30 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
+static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
+		loff_t offset, unsigned addr_mask, unsigned len_mask)
+{
+	const struct bio_vec *bvec = i->bvec;
+	unsigned skip = i->iov_offset;
+	size_t size = i->count;
+
+	if ((offset | size) & len_mask)
+		return false;
+	do {
+		size_t len = bvec->bv_len;
+
+		if (len > size)
+			len = size;
+		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
+			return false;
+		bvec++;
+		size -= len;
+		skip = 0;
+	} while (size);
+
+	return true;
+}
+
 static void
 nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
 {
@@ -346,6 +368,26 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
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
+
+		if (nf_dio_mem_align && nf_dio_offset_align &&
+		    nfs_iov_iter_aligned_bvec(i, hdr->args.offset,
+					      nf_dio_mem_align - 1,
+					      nf_dio_offset_align - 1))
+			return; /* is DIO-aligned */
+
+		/* Fallback to using buffered for this misaligned IO */
+		iocb->kiocb.ki_flags &= ~IOCB_DIRECT;
+		iocb->kiocb.ki_filp->f_flags &= ~O_DIRECT;
+	}
 }
 
 static void
@@ -406,6 +448,14 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct file *filp = iocb->kiocb.ki_filp;
 
+	if (status < 0) {
+		/* Underlying FS will return -EINVAL if misaligned
+		 * DIO is attempted because it shouldn't be.
+		 */
+		WARN_ON_ONCE((iocb->kiocb.ki_flags & IOCB_DIRECT) &&
+			     status == -EINVAL);
+	}
+
 	nfs_local_pgio_done(hdr, status);
 
 	/*
@@ -607,8 +657,14 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 		nfs_set_pgio_error(hdr, -ENOSPC, hdr->args.offset);
 		status = -ENOSPC;
 	}
-	if (status < 0)
+	if (status < 0) {
 		nfs_reset_boot_verifier(inode);
+		/* Underlying FS will return -EINVAL if misaligned
+		 * DIO is attempted because it shouldn't be.
+		 */
+		WARN_ON_ONCE((iocb->kiocb.ki_flags & IOCB_DIRECT) &&
+			     status == -EINVAL);
+	}
 
 	nfs_local_pgio_done(hdr, status);
 }
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


