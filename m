Return-Path: <linux-nfs+bounces-13233-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC53B111C0
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 21:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1F31CE80E1
	for <lists+linux-nfs@lfdr.de>; Thu, 24 Jul 2025 19:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444092ED878;
	Thu, 24 Jul 2025 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ko6Pdua2"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B82ED848
	for <linux-nfs@vger.kernel.org>; Thu, 24 Jul 2025 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753385470; cv=none; b=kFvqCdJkA9qlEz9TawI2PRpCiAs8vDm/3jKdhf/z1pt3wxhrSYq0mFGK6hb9oanrEC2IMhatnudU5LqyZCHlr4uH57Bk13C0qsoc7Q9XSYxMxBWMeahXOsg03nuRusMwlrtQCL3NkZDAoxXANCcW1gWUG9vTG4dHNXsCNvKEwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753385470; c=relaxed/simple;
	bh=sDLH9efdm1kTt3trWi5YJW6bOzUH3Rj9+wxztaHAXvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d481w2D9zLdBhjlIoP95iMyW3Vvpy4IqyEVbHP2QA8cwoAVXQvzBYeDZSp/D3+b0MF+gzfj76MLuX+wVLh2T7Tk4SIZvp2Xj7SviqOCFX9t4Ao8wOLOXE8inUnE2ftlHzdTXmd/UcA9dZmMQMyovRB5lyPDk17qDW8nR0fZZt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ko6Pdua2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEFEC4CEED;
	Thu, 24 Jul 2025 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753385469;
	bh=sDLH9efdm1kTt3trWi5YJW6bOzUH3Rj9+wxztaHAXvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ko6Pdua27j4eTxJrgZ4Cgur2gJvIlybZPYCMlheOjYl0Wo+Nc1rn7b2doUgnip6Gs
	 EOVR+NGco0EEijCGkjGk6MbRrzFoz1E4SGJaHwSed3fjOFlno85568N2vuy1df0+TJ
	 W3vVbs3opdg80jnOkPDJgIf6So+I3242ew9Iw3RpRsvkYtKBsvQ4fbJciabitPECBO
	 tP7+NaOdsZOoX2K2TGThD/3dDOJDT/FgM9GhPXAPppEL2Vq02ywHAoEC8M9smUeNHd
	 LYduyGNPukRLPKgy1X0Hr16O1gJt8zH5pcSssUKo6OUav4TjXthxKNuKEUCxRZE0KK
	 p6QYso496ni4w==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 04/13] NFSD: add io_cache_write controls to debugfs interface
Date: Thu, 24 Jul 2025 15:30:53 -0400
Message-ID: <20250724193102.65111-5-snitzer@kernel.org>
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

Add 'io_cache_write' to NFSD's debugfs interface so that: Any data
written by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=1)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=2).
- not cached (NFSD_IO_DIRECT=3)

io_cache_write may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_write

If NFSD_IO_DONTCACHE is specified using 2, FOP_DONTCACHE must be
advertised as supported by the underlying filesystem (e.g. XFS),
otherwise all IO flagged with RWF_DONTCACHE will fail with
-EOPNOTSUPP.

If NFSD_IO_DIRECT is specified using 3, the IO must be aligned
relative to the underlying block device's logical_block_size. Also the
memory buffer used to store the WRITE payload must be aligned relative
to the underlying block device's dma_alignment.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/vfs.c     | 18 ++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index c07f71d4e84f..872de65f0e9a 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -87,6 +87,47 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
 			 nfsd_io_cache_read_set, "%llu\n");
 
+/*
+ * /sys/kernel/debug/nfsd/io_cache_write
+ *
+ * Contents:
+ *   %1: NFS WRITE will use buffered IO
+ *   %2: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
+ *   %3: NFS WRITE will use direct IO
+ *
+ * The default value of this setting is zero (UNSPECIFIED).
+ * This setting takes immediate effect for all NFS versions,
+ * all exports, and in all NFSD net namespaces.
+ */
+
+static int nfsd_io_cache_write_get(void *data, u64 *val)
+{
+	*val = nfsd_io_cache_write;
+	return 0;
+}
+
+static int nfsd_io_cache_write_set(void *data, u64 val)
+{
+	int ret = 0;
+
+	switch (val) {
+	case NFSD_IO_BUFFERED:
+	case NFSD_IO_DONTCACHE:
+	case NFSD_IO_DIRECT:
+		nfsd_io_cache_write = val;
+		break;
+	default:
+		nfsd_io_cache_write = NFSD_IO_UNSPECIFIED;
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_write_fops, nfsd_io_cache_write_get,
+			 nfsd_io_cache_write_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -102,4 +143,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
+
+	debugfs_create_file("io_cache_write", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_write_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6ef799405145..fe935b4cda53 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -161,6 +161,7 @@ enum {
 };
 
 extern u64 nfsd_io_cache_read __read_mostly;
+extern u64 nfsd_io_cache_write __read_mostly;
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 145f6d635ac7..a7a587736a22 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -50,6 +50,7 @@
 
 bool nfsd_disable_splice_read __read_mostly;
 u64 nfsd_io_cache_read __read_mostly;
+u64 nfsd_io_cache_write __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1238,6 +1239,23 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
+
+	switch (nfsd_io_cache_write) {
+	case NFSD_IO_DIRECT:
+		/* direct I/O must be aligned to device logical sector size */
+		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
+		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0) &&
+		    iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
+					nf->nf_dio_offset_align - 1))
+			kiocb.ki_flags = IOCB_DIRECT;
+		break;
+	case NFSD_IO_DONTCACHE:
+		kiocb.ki_flags = IOCB_DONTCACHE;
+		break;
+	case NFSD_IO_BUFFERED:
+		break;
+	}
+
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
-- 
2.44.0


