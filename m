Return-Path: <linux-nfs+bounces-14019-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721C2B42B50
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F321A86B72
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7032DE6FC;
	Wed,  3 Sep 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnisvmQN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B247292B44
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932688; cv=none; b=DX2zBVrjKHrsrYH0Xk8nsrxSRcczFoLODRSRczP91iM8wploaOHkoiw9pBa5La8SiCsJZ6tYI1jxSaTeqIvFmJ2s+/F2qHfoyptdXhK6c/WFpBCdR+nk/7+kwgB7WhjFxL8f3HV2dAX9UaakQKofDv4ik45e2U/6OrcGtbViqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932688; c=relaxed/simple;
	bh=qC95KkQufc8ofeKhe163gS0DeiP6XtpnVFCCKfGL1hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVY8p/rJMcpscZYwobzvLR+IpwAGMK84diQdQCsOwVkBsrQ6lf5cD3cRFT8NlUiUX41Hf8uvnkyaWR6kG6y8bzDPuzXuTw0TxwZWKJxqSiIG/7cARhNMP03ENdNoqgcZP3JUnyJ0/j82f1+PL/VIGsrYC2kERd2bSYHeHTY1Z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnisvmQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01794C4CEE7;
	Wed,  3 Sep 2025 20:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932688;
	bh=qC95KkQufc8ofeKhe163gS0DeiP6XtpnVFCCKfGL1hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnisvmQNdsb8sHPjVyhWNPrFF2YkuxAR73T/fMIDnHoJTgc5kkWgf6jxQmvU4+jDd
	 4LlklswrNxbmsiSeWDknZG5iCtJTrR7FnaCGf7K5o3TRiOzXP2jveTQC3tbWICbFYA
	 vxOEWbcdh8gJiQpIg3pFk2MUXs8752Tnz2jiCFHaJtdIKUv9NXZKFYnDqU+LFKRnkT
	 K/hfitEeg06ATI/c3aTURm8NDrIoefFyvOzkefQn/z5MtIgqt3vkKsijW2tDCqkben
	 1YUrZxKXHjMBMHw0tck6r2kOaDS4wlmZMt/XJ7+AXJuLgSRIP2drNpQtCZMLOJrARG
	 ilb88pxioAgpQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 4/9] NFSD: add io_cache_write controls to debugfs interface
Date: Wed,  3 Sep 2025 16:51:16 -0400
Message-ID: <20250903205121.41380-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250903205121.41380-1-snitzer@kernel.org>
References: <20250903205121.41380-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add 'io_cache_write' to NFSD's debugfs interface so that: Any data
written by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=0)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=1).
- not cached (NFSD_IO_DIRECT=2)

io_cache_write may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_write

The default value for io_cache_write reflects NFSD's current default
IO mode (NFSD_IO_BUFFERED=0).

If NFSD_IO_DONTCACHE is specified using 1, FOP_DONTCACHE must be
advertised as supported by the underlying filesystem (e.g. XFS),
otherwise all IO flagged with RWF_DONTCACHE will fail with
-EOPNOTSUPP.

If NFSD_IO_DIRECT is specified using 2, the IO must be aligned
relative to the underlying block device's logical_block_size. Also the
memory buffer used to store the WRITE payload must be aligned relative
to the underlying block device's dma_alignment.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/debugfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/vfs.c     | 15 +++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index dd1dc28a53784..173032a04cdec 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -85,6 +85,45 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_read_fops, nfsd_io_cache_read_get,
 			 nfsd_io_cache_read_set, "%llu\n");
 
+/*
+ * /sys/kernel/debug/nfsd/io_cache_write
+ *
+ * Contents:
+ *   %0: NFS WRITE will use buffered IO
+ *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
+ *   %2: NFS WRITE will use direct IO
+ *
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
@@ -100,4 +139,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
+
+	debugfs_create_file("io_cache_write", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_write_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 41cb7c7feff3e..c491eb258ecd3 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -161,6 +161,7 @@ enum {
 };
 
 extern u64 nfsd_io_cache_read __read_mostly;
+extern u64 nfsd_io_cache_write __read_mostly;
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 21441745df69a..358d10a0665f6 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -50,6 +50,7 @@
 
 bool nfsd_disable_splice_read __read_mostly;
 u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
+u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1241,6 +1242,20 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+		break;
+	case NFSD_IO_BUFFERED:
+		break;
+	}
 	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
-- 
2.44.0


