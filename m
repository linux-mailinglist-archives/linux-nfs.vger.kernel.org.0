Return-Path: <linux-nfs+bounces-13480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F7B1DB9B
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 18:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC4BC7E02CE
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Aug 2025 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9887269D18;
	Thu,  7 Aug 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rr5ta1Ql"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F625BEFE
	for <linux-nfs@vger.kernel.org>; Thu,  7 Aug 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754583950; cv=none; b=FB22rsIMice/bFbWCD44F6fTv+Y7KTyeRZe6g90jdJ9XD2zScRbTnILA+zEiPkEhDaxwjNZV6aU+vuK2AavMNyNyVI0LbhGJeXTFLc6dcdAh/2qr6+XZ/tJZhoh83NmSFKdXVrrbWehHy4RzSCs42VWKtTzrH1GwmJZG2bgF0Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754583950; c=relaxed/simple;
	bh=hrlcCBJRLatGsMbhqOqxhFlxKXXIbbJAcKZ5GsmSGzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfM9z3chTDCLicwcvN76VXGvnzvMvmQoSDI2BVo68aQZm8G2jowjfGUD1ucTmVtbtTSks7A7yrsaP6jwvADheEzhTTd2wcAxsNaIiC9ElCYoFdaoNRpnMCOWlgQnTnO7y5JN1znKYtmHcUtIerjasI290dxdChMtbLj5sW7lQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rr5ta1Ql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E02DC4CEF1;
	Thu,  7 Aug 2025 16:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754583950;
	bh=hrlcCBJRLatGsMbhqOqxhFlxKXXIbbJAcKZ5GsmSGzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rr5ta1QlbClFJ49y1iJ6hdHz01ESXS88vFGv24Rx7GD24M+XpPMXgM5D894D3zpn2
	 enQ8VtAjlOIP/Sk4bNk7eLVwmQEVtBZtOKELhsjfha5jb/rRJLW5TUunGwXJVxfohY
	 7PNUv/Q+HgtJe0FaKib4m5yLVzq7IyjlSJlgeCqu+PSGICxyyqORPSsUKrH2oTajkf
	 uYoN9C8aI0yeOj6T1sbSOnD0dgWoFaL2dCtJ+7NefYZJeD0snxgHuPNnFp7jV0FEPb
	 E0MUHQMRUMWJL+0Eiq1xIE+MApuOp/SZRHmWh29NSkVqSmMlen9egwn8XjQsrbPSbe
	 Ofv1HaCky2PWQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v5 3/7] NFSD: add io_cache_read controls to debugfs interface
Date: Thu,  7 Aug 2025 12:25:40 -0400
Message-ID: <20250807162544.17191-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250807162544.17191-1-snitzer@kernel.org>
References: <20250807162544.17191-1-snitzer@kernel.org>
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
 fs/nfsd/vfs.c     | 19 +++++++++++++---
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc9..c07f71d4e84f4 100644
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
index 79439ad93880a..26b6d96258711 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1099,17 +1100,29 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	size_t len;
 
 	init_sync_kiocb(&kiocb, file);
+
+	if (nfsd_io_cache_read == NFSD_IO_DIRECT) {
+		/* Verify ondisk DIO alignment, memory addrs checked below */
+		if (nf->nf_dio_mem_align && nf->nf_dio_read_offset_align &&
+		    (((offset | *count) & (nf->nf_dio_read_offset_align - 1)) == 0))
+			kiocb.ki_flags = IOCB_DIRECT;
+	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
+		kiocb.ki_flags = IOCB_DONTCACHE;
+
 	kiocb.ki_pos = offset;
 
 	v = 0;
 	total = *count;
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
-		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
-			      len, base);
+		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
+		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
+		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) && base &&
+			     (base & (nf->nf_dio_mem_align - 1))))
+			kiocb.ki_flags &= ~IOCB_DIRECT;
 		total -= len;
-		++v;
 		base = 0;
+		v++;
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
-- 
2.44.0


