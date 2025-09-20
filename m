Return-Path: <linux-nfs+bounces-14608-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84DB8BCB2
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Sep 2025 03:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4871C0221E
	for <lists+linux-nfs@lfdr.de>; Sat, 20 Sep 2025 01:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B11156F45;
	Sat, 20 Sep 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cif2Rh1p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0DD2D7BF
	for <linux-nfs@vger.kernel.org>; Sat, 20 Sep 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758331137; cv=none; b=UT2fYbMNB+OC0h2LaQFxTJ6+FKc2mflPzFJ32NAvu02vV9ZCgdAHXd4Hbs6Kau1Ogos8Govl8J4eePwxLD9Usantb6kF1Kd6hflFCe00kix9CAla3Ze/l4GWQI3cn86Tjl7ll6jxL76gbdmsw4Iu5lPOTL8IdojWsYtIj0DGKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758331137; c=relaxed/simple;
	bh=fKV6cfgnGCWUqgj7HP9Xn0U9eB7bWi+n9Z7eQeMKuE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTQXNDmqMt6W2WK1aJY3WfxhUjMatVnmNMXiTUegh14FY4R6q71QO9z/y1nmI0xR/WKlP16ywtzQR796H0l1YtfwNoVn/A4IEf0Qu02mUapF1nBL2AI8z0MBYDHbeyx5maAW8m2fUoe/TqV9r4fvXNlWmFwvtSZh5Nd2zwCUMQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cif2Rh1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29128C4CEF0;
	Sat, 20 Sep 2025 01:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758331137;
	bh=fKV6cfgnGCWUqgj7HP9Xn0U9eB7bWi+n9Z7eQeMKuE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cif2Rh1pBy6TrlWP4CluS2n28XbwTYwh0EIaLJPlBhMw6rSdVKbQIFzPILVc0yNFK
	 bWGi9yRIqXoBbNhxEBXbOklPFR8VpTjWr2GxzgLRvD3f5JXdqerNB+kEioTMo7VDwg
	 yLM9BGPYzTwerJKEwHdiWFHRG99yWByovFHNOjwwSwAnZb6J/Li0s3YPnzrX5WA+h5
	 Uz5nVsR7Q/8b+N3jUbAE5RMYzyw/Qki8h4WqgqzYopE3roNU/9rth5vB0mEr5JoHng
	 /UH5/Hi42p3wB9B7wBSiFisJw7AUriHMzR6b1XPMudfeLykjq1gPWVlerl0/I/4685
	 f1TeZEqOrirKg==
Date: Fri, 19 Sep 2025 21:18:55 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v11b 2/7] nfs/localio: avoid issuing misaligned IO using
 O_DIRECT
Message-ID: <aM4A_wAoxv4LNlAx@kernel.org>
References: <20250919143631.44851-1-snitzer@kernel.org>
 <20250919143631.44851-3-snitzer@kernel.org>
 <2416a8b9683a37eeb7b29a6c0fb32b5cded4fe64.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2416a8b9683a37eeb7b29a6c0fb32b5cded4fe64.camel@kernel.org>

[this will be posted as patch 2/7 in v12 if needed]

Add nfsd_file_dio_alignment and use it to avoid issuing misaligned IO
using O_DIRECT. Any misaligned DIO falls back to using buffered IO.

Because misaligned DIO is now handled safely, disable the nfs modparam
'localio_O_DIRECT_semantics' that was added to require users opt-in to
the requirement that all O_DIRECT be properly DIO-aligned. The
modparam is only left in place for compatibility purposes.

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
 fs/nfs/localio.c           | 64 +++++++++++++++++++++++++++++++++-----
 fs/nfsd/localio.c          | 11 +++++++
 include/linux/nfslocalio.h |  2 ++
 3 files changed, 70 insertions(+), 7 deletions(-)

[changes from v11 to v11b: keep but disable localio_O_DIRECT_semantics modparam]

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 42ea50d42c995..9ea830d144818 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -49,10 +49,10 @@ struct nfs_local_fsync_ctx {
 static bool localio_enabled __read_mostly = true;
 module_param(localio_enabled, bool, 0644);
 
-static bool localio_O_DIRECT_semantics __read_mostly = false;
+static bool localio_O_DIRECT_semantics __read_mostly = true;
 module_param(localio_O_DIRECT_semantics, bool, 0644);
 MODULE_PARM_DESC(localio_O_DIRECT_semantics,
-		 "LOCALIO will use O_DIRECT semantics to filesystem.");
+		 "Deprecated, does nothing, LOCALIO handles misaligned DIO.");
 
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
@@ -322,12 +322,9 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
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
@@ -337,6 +334,30 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
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
@@ -346,6 +367,25 @@ nfs_local_iter_init(struct iov_iter *i, struct nfs_local_kiocb *iocb, int dir)
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
@@ -406,6 +446,11 @@ nfs_local_read_done(struct nfs_local_kiocb *iocb, long status)
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct file *filp = iocb->kiocb.ki_filp;
 
+	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status == -EINVAL) {
+		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
+		pr_info_ratelimited("nfs: Unexpected direct I/O read alignment failure\n");
+	}
+
 	nfs_local_pgio_done(hdr, status);
 
 	/*
@@ -598,6 +643,11 @@ nfs_local_write_done(struct nfs_local_kiocb *iocb, long status)
 
 	dprintk("%s: wrote %ld bytes.\n", __func__, status > 0 ? status : 0);
 
+	if ((iocb->kiocb.ki_flags & IOCB_DIRECT) && status == -EINVAL) {
+		/* Underlying FS will return -EINVAL if misaligned DIO is attempted. */
+		pr_info_ratelimited("nfs: Unexpected direct I/O write alignment failure\n");
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


