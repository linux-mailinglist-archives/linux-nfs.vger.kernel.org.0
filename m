Return-Path: <linux-nfs+bounces-14443-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7AFB58117
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 17:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51497171100
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Sep 2025 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCD92DC786;
	Mon, 15 Sep 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfaQ5rT6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637127442
	for <linux-nfs@vger.kernel.org>; Mon, 15 Sep 2025 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950880; cv=none; b=E3O8fgLCazFOLX3uqBtmGALFgVu0TYkqikpitiKgrhPGqtdMDwA6FT2UoUH9bjXZqdASQaxrHv1riS+sq3JhWj3J/1oltfw51UWZAjBxSzIIrMswJ20tRhU1h/9Q8TOASQdkv/3IT4LsKDoicObdWGoSZ6qwJ/700eV3Yd+chiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950880; c=relaxed/simple;
	bh=j95xuByIqE8j2AS2l7mc5MMBDSXFcqG0QCgbYN4k3Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGSwuIIDWDtr9twy5ZR6RqnnIguvl48J9FNQKj7gmgrOF8auwes0ViqfBGw3PmcfqLzEsLm/jFvnmG639m1DZbWYJrwWXJBd5FaKmsCl57Vmpka9MQQDw6uVGEegoc9I/T39DK7Uy8iW3cQ4o6m0KOVJ3dW1Nk5iO+lIVA33ZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfaQ5rT6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A1EC4CEF7;
	Mon, 15 Sep 2025 15:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757950880;
	bh=j95xuByIqE8j2AS2l7mc5MMBDSXFcqG0QCgbYN4k3Ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RfaQ5rT61QiRfN0KWaCss047axtfakN3U7YUt4qC6SllLuv0hPI2AWC/qQdFhZVCn
	 h87arRUimN8IRAg5MC/Ou5Xt1HjUkJWXSg1ogYzmB4WHPnyAz4b5Vx1KD9UuFrKauz
	 BcwkA0jtyV8WdkaO51Tw4xfR73sCW5wKAk3CKJA4NmY6qq1Hd5Zr8iKaB5W+DcfQqA
	 MiIegoqmzhCm3nsopTm6mzGps3TfyyUd8LW76cgpwhWHUTaGI5yosb2g9SE3hdX+6w
	 5aNsw4c5Iesw4W7woTBzZQo74ZHfs2RaQLL9b5TEBrPWd2hlxSLpECGICsnCrLcVkS
	 PZ+2Xg3IPatmQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 2/7] nfs/localio: avoid issuing misaligned IO using O_DIRECT
Date: Mon, 15 Sep 2025 11:41:10 -0400
Message-ID: <20250915154115.19579-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250915154115.19579-1-snitzer@kernel.org>
References: <20250915154115.19579-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
using O_DIRECT. Any misaligned DIO falls back to using buffered IO.

Because misaligned DIO is now handled safely, remove the nfs modparam
'localio_O_DIRECT_semantics' that was added to require users opt-in to
the requirement that all O_DIRECT be properly DIO-aligned.

Also, introduce nfs_iov_iter_aligned_bvec() which is a variant of
iov_iter_aligned_bvec() that also verifies the offset associated with
an iov_iter is DIO-aligned.  NOTE: in a parallel effort,
iov_iter_aligned_bvec() is being removed along with
iov_iter_is_aligned().

Lastly, add pr_info_ratelimited if underlying filesystem returns
-EINVAL because it was made to try O_DIRECT for IO that is not
DIO-aligned (shouldn't happen, so its best to be louder if it does).

Fixes: 3feec68563d ("nfs/localio: add direct IO enablement with sync and async IO support")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           | 69 ++++++++++++++++++++++++++++++++------
 fs/nfsd/localio.c          | 11 ++++++
 include/linux/nfslocalio.h |  2 ++
 3 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 42ea50d42c995..380407c41822c 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -49,11 +49,6 @@ struct nfs_local_fsync_ctx {
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
-static bool localio_O_DIRECT_semantics __read_mostly = false;
-module_param(localio_O_DIRECT_semantics, bool, 0644);
-MODULE_PARM_DESC(localio_O_DIRECT_semantics,
-		 "LOCALIO will use O_DIRECT semantics to filesystem.");
-
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!rcu_access_pointer(clp->cl_uuid.net);
@@ -322,12 +317,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 		return NULL;
 	}
 
-	if (localio_O_DIRECT_semantics &&
-	    test_bit(NFS_IOHDR_ODIRECT, &hdr->flags)) {
-		iocb->kiocb.ki_filp = file;
+	init_sync_kiocb(&iocb->kiocb, file);
+	if (test_bit(NFS_IOHDR_ODIRECT, &hdr->flags))
 		iocb->kiocb.ki_flags = IOCB_DIRECT;
-	} else
-		init_sync_kiocb(&iocb->kiocb, file);
 
 	iocb->kiocb.ki_pos = hdr->args.offset;
 	iocb->hdr = hdr;
@@ -337,6 +329,30 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
+static bool nfs_iov_iter_aligned_bvec(const struct iov_iter *i,
+		loff_t offset, unsigned int addr_mask, unsigned int len_mask)
+{
+	const struct bio_vec *bvec = i->bvec;
+	size_t skip = i->iov_offset;
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
@@ -346,6 +362,25 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
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
+	}
 }
 
 static void
@@ -406,6 +441,13 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct file *filp = iocb->kiocb.ki_filp;
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		if (status == -EINVAL) {
+			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
+			pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure\n");
+		}
+	}
+
 	nfs_local_pgio_done(hdr, status);
 
 	/*
@@ -598,6 +640,13 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 
 	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
 
+	if (iocb->kiocb.ki_flags & IOCB_DIRECT) {
+		if (status == -EINVAL) {
+			/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
+			pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
+		}
+	}
+
 	/* Handle short writes as if they are ENOSPC */
 	if (status > 0 && status < hdr->args.count) {
 		hdr->mds_offset += status;
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


