Return-Path: <linux-nfs+bounces-13672-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DBBB28258
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66428188DE14
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 14:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF525A65B;
	Fri, 15 Aug 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAq3EDmE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E73A25A357
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755269174; cv=none; b=Me289GEQNHgIrIcyXC+mbYG0Rn4XNa9eRsQa4ti5qt1uXoIp1BjKQTSvEbE7YiklLIBUscS5NHPsW1SrDr2I7Lkm/RNkPKbquIf5Cqw/E93Iwt2k+mggqgOoUJMN9NaJ+KOijoaLyQ/RuemWImc8nSQDR3arXj7Jf+XKTK0ADzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755269174; c=relaxed/simple;
	bh=GK6SVWb4QuNmaoSVe6fh23uNESjFt+AgWm2pham7n9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bC254ejqHPXri/M9zXYZ/PKVJda4/B4fj/T0zgYKnat46ZS/ZU0UU1B5j3v+MiANMd0p3pi/EXx0O4ELWnMFfGfn0OneVdypGjBF306VOUVFQDkCPhHjO6IBtrbQz+yDLxm7WlGzmApelVXp+kHx+WOnpyPlDZ5YNH5ML7xTFO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAq3EDmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261CFC4CEF0;
	Fri, 15 Aug 2025 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755269173;
	bh=GK6SVWb4QuNmaoSVe6fh23uNESjFt+AgWm2pham7n9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TAq3EDmE9rRwb9csmB6r3v4pK2BJXorc82R/UNYJjDNNoKLdcRpWZ+Fedr6DsSsIa
	 NEGbINKZn4Ekt3qHNfSDcVUGMrho4tMIlREISYoxve2biowRyLi148C+6JB/UIWGVn
	 pt5AMtv0dxlQNv9Qlj4+MAC9PnO33WJ0d+ZEH7NNUhnW4L2EOSUxlOomcgEPXO2nRa
	 xEoNF0y5Krxd/NXXsOxbeVSNFZVkIjFD4Nbn4a6S/pPw5LMbqs+zvVGv9MkkRP6oI/
	 VdUIu+L4qewrm3qAfDqNM1DAuc3yB99pWMoltWXb2fYKgOZiP7HzQ9XLYx4FzmZ9Ke
	 gvMQ5oAWGc+5w==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 3/7] NFSD: add io_cache_read controls to debugfs interface
Date: Fri, 15 Aug 2025 10:46:03 -0400
Message-ID: <20250815144607.50967-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815144607.50967-1-snitzer@kernel.org>
References: <20250815144607.50967-1-snitzer@kernel.org>
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
 fs/nfsd/debugfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  9 ++++++++
 fs/nfsd/vfs.c     | 18 +++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc9..3cadd45868b48 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -27,11 +27,65 @@ static int nfsd_dsr_get(void *data, u64 *val)
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
@@ -44,4 +98,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+
+	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2f..6ef799405145f 100644
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
index 79439ad93880a..8ea8b80097195 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1099,6 +1100,23 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	size_t len;
 
 	init_sync_kiocb(&kiocb, file);
+
+	switch (nfsd_io_cache_read) {
+	case NFSD_IO_DIRECT:
+		/* Verify ondisk and memory DIO alignment */
+		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
+		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0) &&
+		    (base & (nf->nf_dio_mem_align - 1)) == 0)
+			kiocb.ki_flags = IOCB_DIRECT;
+		break;
+	case NFSD_IO_DONTCACHE:
+		kiocb.ki_flags = IOCB_DONTCACHE;
+		fallthrough;
+	case NFSD_IO_UNSPECIFIED:
+	case NFSD_IO_BUFFERED:
+		break;
+	}
+
 	kiocb.ki_pos = offset;
 
 	v = 0;
-- 
2.44.0


