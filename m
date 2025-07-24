Return-Path: <linux-nfs+bounces-13232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33958B111BE
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B595586E1B
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E422ED85C;
	Thu, 24 Jul 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoU7xrtH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EF82ED847
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385468; cv=none; b=okwyniwzd7MG26o/acE5a9tjb+NxV6eVgAQiWxWoqf0flf7ZIRcP2KOKhjopZwwOPpO4jw8045k28JQlVDzOxXvJWCEgtjadsr9ZvXggz34Jy+6oeyBY4FxalRiDLpiYPGtPVINgzmampEbQ6pgRQl9OjxJkKbuHqXIEW87jWvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385468; c=relaxed/simple;
	bh=bfxGurubjhYHxpiq8AxsCNBSBFuttP/MuFX6xje9VHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ra8FoIpvwRB/dahLkvrPmZLLjOEvrV79dT0FjQA77DLJ9Egv5DfaydOo4ICkfY3LjjhSgzlb9vvQ9DTCYiWtFTOUpAf7Po3AFAto1qW3ouB7OtPdvMuO3ppVuos/9xEUbEsbfh7cN231CUM1XlRORATrwg2xqFefCSuiRIR17wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoU7xrtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893C2C4CEED;
	Thu, 24 Jul 2025 19:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385467;
	bh=bfxGurubjhYHxpiq8AxsCNBSBFuttP/MuFX6xje9VHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoU7xrtHshu6rxS+tmHNwvpkynRp1VfeMOGUy2oMRS5SSIjxizp1fLdcHAyiEnEpX
	 vVwPEWCTexByXqcyft745/ojkr90ccr4sgOZPsP/AXZEcZWbXBPew0UDhn8qGZT3Pq
	 P0E7gbEhTK1zSQ9VMsN8Bxh9YTfFpejWdaVD24DrNeb3dNCqpHJ0cmE++V4cb8PTxv
	 ZR4gLydZgdGtV3RcX52mWPThEH1zMnLKkFzApUwBVI88WLa3wqzqtnx+6NN7+lQ6n0
	 Mqwee7klmIW3nb+qzaC3qI1NuF3KznX1FTQSUUQa6TKPUMo6ind9MCIz8K+C1jh9IT
	 shbpJXiZ0SkPQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 03/13] NFSD: add io_cache_read controls to debugfs interface
Date: Thu, 24 Jul 2025 15:30:52 -0400
Message-ID: <20250724193102.65111-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250724193102.65111-1-snitzer@kernel.org>
References: <20250724193102.65111-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
read by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=1)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=2).
- not cached (NFSD_IO_DIRECT=3)

io_cache_read may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_read

If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
advertised as supported by the underlying filesystem (e.g. XFS),
otherwise all IO flagged with RWF_DONTCACHE will fail with
-EOPNOTSUPP.

If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
relative to the underlying block device's logical_block_size. Also the
memory buffer used to store the read must be aligned relative to the
underlying block device's dma_alignment.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/debugfs.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  9 ++++++++
 fs/nfsd/vfs.c     | 16 +++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc..c07f71d4e84f 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -27,11 +27,66 @@ static int nfsd_dsr_get(void *data, u64 *val)
 static int nfsd_dsr_set(void *data, u64 val)
 {
 	nfsd_disable_splice_read = (val > 0) ? true : false;
+	if (!nfsd_disable_splice_read) {
+		/*
+		 * Cannot use NFSD_IO_DONTCACHE or NFSD_IO_DIRECT
+		 * if splice_read is enabled.
+		 */
+		nfsd_io_cache_read = NFSD_IO_BUFFERED;
+	}
 	return 0;
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
 
+/*
+ * /sys/kernel/debug/nfsd/io_cache_read
+ *
+ * Contents:
+ *   %1: NFS READ will use buffered IO
+ *   %2: NFS READ will use dontcache (buffered IO w/ dropbehind)
+ *   %3: NFS READ will use direct IO
+ *
+ * The default value of this setting is zero (UNSPECIFIED).
+ * This setting takes immediate effect for all NFS versions,
+ * all exports, and in all NFSD net namespaces.
+ */
+
+static int nfsd_io_cache_read_get(void *data, u64 *val)
+{
+	*val = nfsd_io_cache_read;
+	return 0;
+}
+
+static int nfsd_io_cache_read_set(void *data, u64 val)
+{
+	int ret = 0;
+
+	switch (val) {
+	case NFSD_IO_BUFFERED:
+		nfsd_io_cache_read = NFSD_IO_BUFFERED;
+		break;
+	case NFSD_IO_DONTCACHE:
+	case NFSD_IO_DIRECT:
+		/*
+		 * Must disable splice_read when enabling
+		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
+		 */
+		nfsd_disable_splice_read = true;
+		nfsd_io_cache_read = val;
+		break;
+	default:
+		nfsd_io_cache_read = NFSD_IO_UNSPECIFIED;
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
+			 nfsd_io_cache_read_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -44,4 +99,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+
+	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2..6ef799405145 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
 
 extern bool nfsd_disable_splice_read __read_mostly;
 
+enum {
+	NFSD_IO_UNSPECIFIED = 0,
+	NFSD_IO_BUFFERED,
+	NFSD_IO_DONTCACHE,
+	NFSD_IO_DIRECT,
+};
+
+extern u64 nfsd_io_cache_read __read_mostly;
+
 extern int nfsd_max_blksize;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9bbc97aebbea..145f6d635ac7 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1116,6 +1117,21 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+
+	switch (nfsd_io_cache_read) {
+	case NFSD_IO_DIRECT:
+		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
+		    iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
+					nf->nf_dio_read_offset_align - 1))
+			kiocb.ki_flags = IOCB_DIRECT;
+		break;
+	case NFSD_IO_DONTCACHE:
+		kiocb.ki_flags = IOCB_DONTCACHE;
+		break;
+	case NFSD_IO_BUFFERED:
+		break;
+	}
+
 	host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
-- 
2.44.0


