Return-Path: <linux-nfs+bounces-13903-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E709BB372B4
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 20:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A478916BFA8
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Aug 2025 18:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBED0372893;
	Tue, 26 Aug 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm3Bwaui"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62FD2E336E
	for <linux-nfs@vger.kernel.org>; Tue, 26 Aug 2025 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756234646; cv=none; b=eUcnf2yUHqw+DfOHB1CsdEH2BMNqh4SfmWiKHBPzNyFcRdSbUCxg6+nw1pOk0+B2z5INIV7dbC9XzcE3J4qhNFgU2cmexFrf+pxMnDqNDtkT9GqKvWVLhGxjJgHKrCoiseUvGL4SSs+7o3VHpaeHeIXPb3qsiHI0nR2uVgKl4LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756234646; c=relaxed/simple;
	bh=djwzTSRiP1dXP8M1v53fhmxKtyJzyXjrGFUYh9QN7j0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOTtlZmA2qvdC7HFD/KGmE4alUxi4L/K/kGNO+eBESA9nLh4DypU0sS4AQ+DL4KEsTclx+zH6QWcdsQwQvVb3wzxYxXJ3E4zlHifN6TsxRFz2GsrP1/CBjZ7kwMFGK8OJx5U0dI6jgPXt3uvZ+HoiJ96XiS13XfuygflAYj+2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm3Bwaui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A01C4CEF1;
	Tue, 26 Aug 2025 18:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756234646;
	bh=djwzTSRiP1dXP8M1v53fhmxKtyJzyXjrGFUYh9QN7j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm3BwauiKP7vQnS67IIQ/UMfPGOeM7OE7q56bAPdpGtJvDNRa9zxyb3JgnpS39v3w
	 IvAKrDBcemdn1DHPcH7d+WPinQGaA1ILbkzdlvYAmFm0Xn4cxTPvXemsDHLkkrLsYk
	 4U5B1H/zab3knwdH1zIwE3ljh3O/myrprvy+49A4mz199vkHnBWToPjSophBB7xN5H
	 EI1+1igkwaqBhQ888dTFlS1ensJ/gLWzZFfl3+dRS83j0Re2EAXbobOJJcvLiSWAlg
	 J5dayLgkiccRuz66fyTVz76kAFAB0WuUZJlOOS5KEqtZzORQyHewh8agqaYSeLVRlc
	 JYOf/AHRNT/CA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 4/7] NFSD: add io_cache_write controls to debugfs interface
Date: Tue, 26 Aug 2025 14:57:15 -0400
Message-ID: <20250826185718.5593-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250826185718.5593-1-snitzer@kernel.org>
References: <20250826185718.5593-1-snitzer@kernel.org>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>x
---
 fs/nfsd/debugfs.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/vfs.c     | 16 ++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 3cadd45868b48..8878c3519b30c 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -86,6 +86,46 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
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
@@ -101,4 +141,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
+
+	debugfs_create_file("io_cache_write", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_write_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 6ef799405145f..fe935b4cda538 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -161,6 +161,7 @@ enum {
 };
 
 extern u64 nfsd_io_cache_read __read_mostly;
+extern u64 nfsd_io_cache_write __read_mostly;
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 8ea8b80097195..c340708fbab4d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -50,6 +50,7 @@
 
 bool nfsd_disable_splice_read __read_mostly;
 u64 nfsd_io_cache_read __read_mostly;
+u64 nfsd_io_cache_write __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1242,6 +1243,21 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
+
+	switch (nfsd_io_cache_write) {
+	case NFSD_IO_DIRECT:
+		/* direct I/O must be aligned to device logical sector size */
+		if (nf->nf_dio_mem_align && nf->nf_dio_offset_align &&
+		    (((offset | *cnt) & (nf->nf_dio_offset_align-1)) == 0))
+			kiocb.ki_flags |= IOCB_DIRECT;
+		break;
+	case NFSD_IO_DONTCACHE:
+		kiocb.ki_flags |= IOCB_DONTCACHE;
+		fallthrough;
+	case NFSD_IO_UNSPECIFIED:
+	case NFSD_IO_BUFFERED:
+		break;
+	}
 	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
-- 
2.44.0


