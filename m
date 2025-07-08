Return-Path: <linux-nfs+bounces-12934-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C424AFD01F
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 18:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D84F33B29F9
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jul 2025 16:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610752E4990;
	Tue,  8 Jul 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRHDSXZ4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9552E427B
	for <linux-nfs@vger.kernel.org>; Tue,  8 Jul 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990805; cv=none; b=BVKvFZBT18tggBsLMBi7yfePooahpeZCJkyEMVElesRbxMq0HN+zFSCRSu01WeYXf9OAeYg4IlFow1isur8GcUAw8KJCN35sLCOJKCY5TaQSdjQ1cRem3thMmK8HgCWvWe88yYNiqrYHaFfPBIZfp5HCjLFYuZMRLgUnXcab6+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990805; c=relaxed/simple;
	bh=qNBR2+GyUuJ6LJTu5QvQVPVfKv/JcsJ9Wf/JZpciUPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om469z8/jB8VQjmflEHXoACwCHawH5eza4T9hwq6BBnuJlsCM3vYcpCDAi+jWEWuC2eZu1nTITaXZc7jswsKqWEFa+YqZsvZKDh+RdobDRKgq3Nmw6WuHdZIsYOpL2uR9o7FmJu4IdlOefNpqZ7/NQQayWxk4cIeOOV3hrtnNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRHDSXZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E22C4CEED;
	Tue,  8 Jul 2025 16:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990805;
	bh=qNBR2+GyUuJ6LJTu5QvQVPVfKv/JcsJ9Wf/JZpciUPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rRHDSXZ4J0DKjRt2fAotsDd1n4RCB4X1CPFx3zGoFfvXkC/cT0k+l2yVIAzYA0emG
	 6SylHVrfJWAsJwt/PTe9WnMCTvuDsGp9EaEgpF2F3B2rYRSnOt92DRhha6csuCmpMF
	 ehQOt0LAKOu+ej9HHQSRpsoAqFCUJbwzMzH/tF4eD1/V7HnausAXRARuwVlOIUeGub
	 CjbwWaANVqHAxA/va9avig8Q9eySg/7DyJcDbLZG8qqeoJI9YOz/eu/RzDMMTor+2H
	 hJk+lFkqc1mXHewUv/oaeP2S1vZrbJ+y8UvL4bfJYHk/qUFKrirCd/yVsVmMZLyXSh
	 j+/klfRNSCQmQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linus-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	snitzer@kernel.org
Subject: [RFC PATCH v2 6/8] NFSD: add io_cache_read controls to debugfs interface
Date: Tue,  8 Jul 2025 12:06:17 -0400
Message-ID: <20250708160619.64800-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250708160619.64800-1-snitzer@kernel.org>
References: <20250708160619.64800-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
read by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=0)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=1).
- not cached (NFSD_IO_DIRECT=2)

io_cache_read is 0 by default.  It may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_read

If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
advertised as supported by the underlying filesystem (e.g. XFS),
otherwise all IO flagged with RWF_DONTCACHE will fail with
-EOPNOTSUPP.

If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
relative to the underlying block device's logical_block_size. Also the
memory buffer used to store the read must be aligned relative to the
underlying block device's dma_alignment.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/debugfs.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  8 +++++++
 fs/nfsd/vfs.c     | 15 ++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc..709646af797a 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -27,11 +27,61 @@ static int nfsd_dsr_get(void *data, u64 *val)
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
+ *   %0: NFS READ will use buffered IO (default)
+ *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
+ *   %2: NFS READ will use direct IO
+ *
+ * The default value of this setting is zero (buffered IO is
+ * used). This setting takes immediate effect for all NFS
+ * versions, all exports, and in all NFSD net namespaces.
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
+	switch (val) {
+	case NFSD_IO_DONTCACHE:
+	case NFSD_IO_DIRECT:
+		/*
+		 * Must disable splice_read when enabling
+		 * NFSD_IO_DONTCACHE or NFSD_IO_DIRECT.
+		 */
+		nfsd_disable_splice_read = true;
+		nfsd_io_cache_read = val;
+		break;
+	case NFSD_IO_BUFFERED:
+	default:
+		nfsd_io_cache_read = NFSD_IO_BUFFERED;
+		break;
+	}
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
+			 nfsd_io_cache_read_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -44,4 +94,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+
+	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2..4740567f4e7e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -153,6 +153,14 @@ static inline void nfsd_debugfs_exit(void) {}
 
 extern bool nfsd_disable_splice_read __read_mostly;
 
+enum {
+	NFSD_IO_BUFFERED = 0,
+	NFSD_IO_DONTCACHE,
+	NFSD_IO_DIRECT
+};
+
+extern u64 nfsd_io_cache_read __read_mostly;
+
 extern int nfsd_max_blksize;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 845c212ad10b..632ce417f4ef 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1107,6 +1108,20 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
 	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
+
+	switch (nsfd_io_cache_read) {
+	case NFSD_IO_DIRECT:
+		if (iov_iter_is_aligned(&iter, nf->nf_dio_mem_align - 1,
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


