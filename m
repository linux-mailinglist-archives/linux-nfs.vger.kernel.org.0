Return-Path: <linux-nfs+bounces-13213-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5798EB0F756
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFB117012A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA74920AF67;
	Wed, 23 Jul 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb5RX/3N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C699E20C01C
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285438; cv=none; b=qWYVhqz4dY31L3DA7OAV3Grj+NsFWMj222Xsu7YozC4S3m1kFHFfkaxNe+ICEu4v2DoUHS7BCAeXiyK3hZPT97gL8g1Iao8vnVIZIUTa3AgaiEl7HUcPN3EL8b+1ahV4nJAFgyBzUMVPsJtALSYDpu+GNz9guJQqy4WtqwN9Qgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285438; c=relaxed/simple;
	bh=egZrBVvfV3r5agb4/gArd0TqCVH6XBcVc61P4Lplyeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eXsIqiIZNjoav4idoH4PmSE6lhKt7OH3aLo64WpRniTYetGBmlXDTW2nWn/KuOdwKMnOTxpFL7HlK8KSNddMxUI02CNjHnBjEATSRf9v7x8acnSaXHS+LaZLrnbGxOJXSI8Wby5ZUSeuT2j9/reFR3lYH09w6bR8MnYOJ+atqWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb5RX/3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B49C4CEE7;
	Wed, 23 Jul 2025 15:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285437;
	bh=egZrBVvfV3r5agb4/gArd0TqCVH6XBcVc61P4Lplyeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lb5RX/3NRlkeUyVn8lUBIkM1V0if+7mZ54duXdzbEHpOW+zwtQfpgk1uOIAATlNHM
	 na7iVQEpqqY2Fuw0lGMGjglbleC8GD3thvT9D07Q2zxQQKon7obesdCJRegu/uksTN
	 at/PhNXfit3sff9Zwau+ILog+aHZ0Hs2ahs2xd0+M8ILqJN93BOmhBCDUPpJp+M0gw
	 rnzPaQOj0HYCCLofSeIpzop2rsbp2lL0kjMatgEaL7qFmlVv3ni+no1Xc/ViUzqSLY
	 P/ELb/EoNnAhw0YrhSrG4OAstMqsfAffF7vY16EfNK2ut7jP3GnztD2r4/KyrR+StP
	 vFAoj9vPpZvrg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/5] NFSD: add io_cache_read controls to debugfs interface
Date: Wed, 23 Jul 2025 11:43:49 -0400
Message-ID: <20250723154351.59042-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250723154351.59042-1-snitzer@kernel.org>
References: <20250723154351.59042-1-snitzer@kernel.org>
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
index 79439ad93880..2066fe17db2b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1115,6 +1116,21 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+
+	switch (nsfd_io_cache_read) {
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


