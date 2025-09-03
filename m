Return-Path: <linux-nfs+bounces-14018-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15103B42B51
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 22:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3086916BDAD
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Sep 2025 20:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798FF2DCF73;
	Wed,  3 Sep 2025 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuXbUYdN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55267292B44
	for <linux-nfs@vger.kernel.org>; Wed,  3 Sep 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932687; cv=none; b=cLZwIZtiuesQDzuCKkWJ2D0IiNEIJQRBw6baxt0a28H90sASAzmMI+zE4ZyWrugJqBqwpUzScngF1guaOdS9IncY0HD5du/ThskhBvpCbGvXx7ZX03FXvLCyc0GowwySl+rl4Cw/rEoQ5mXhIqf7hQnFIt9f2YYVDh+79AkTe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932687; c=relaxed/simple;
	bh=bSSrRmOATquWkd/sIs5v/xPwzYy8SvqdL5yYkwxN5Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FSUJU3oVHKLLYl0jjKxRAAr+t7MzRm+k2j5bxGxj/+LwfNzY12tybUknvk4bpleVJsK9FuIIe7UPWReRwyB6AiuzezwhyEjL/mkgBx6CU39N38DpmlRtsxNwPu0d+/w5PWYDu3E6DU/pfy3M7Mj8AHrttNxTmXoOh9Fdzp5UOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuXbUYdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99BC4C4CEE7;
	Wed,  3 Sep 2025 20:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756932686;
	bh=bSSrRmOATquWkd/sIs5v/xPwzYy8SvqdL5yYkwxN5Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuXbUYdN+BcRFo6bgNoAhdjby7rRyyQBAU0RPRxwmg3qLLsivC2e51Oo/D2uYkmvD
	 ttL/OIb0jfI+Twi1GBH+9QOlo/SgfFSQ+TeUXPZTOqExpku/VlGH/bEzzNmruiLk0X
	 fDs6bJ0T+uRofsGNoD7tQqEZXHgEmdKHGqd0ZA09XBiiQSn7DiODldn4APXtLQwkIv
	 kX+bigsY2yK17PB5dqfHSe/3YYWvyiJen+2W0VSD5jSD/4xZIexZZNK4Wg3P4oNRL7
	 PtJ/bVA4boJ6ambOgFHS6VA0Zzeh/XLCKP41nVVLwmGSexW+16kEyfMpYEl14MGjcs
	 ldzaHWZvj5N4g==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v9 3/9] NFSD: add io_cache_read controls to debugfs interface
Date: Wed,  3 Sep 2025 16:51:15 -0400
Message-ID: <20250903205121.41380-4-snitzer@kernel.org>
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

Add 'io_cache_read' to NFSD's debugfs interface so that: Any data
read by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=0)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=1).
- not cached (NFSD_IO_DIRECT=2)

io_cache_read may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_read

The default value for io_cache_read reflects NFSD's current default IO
mode (NFSD_IO_BUFFERED=0).

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
 fs/nfsd/debugfs.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  9 ++++++++
 fs/nfsd/vfs.c     | 17 ++++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc9..dd1dc28a53784 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -27,11 +27,64 @@ static int nfsd_dsr_get(void *data, u64 *val)
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
+ *   %0: NFS READ will use buffered IO
+ *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
+ *   %2: NFS READ will use direct IO
+ *
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
@@ -44,4 +97,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+
+	debugfs_create_file("io_cache_read", S_IWUSR | S_IRUGO,
+			    nfsd_top_dir, NULL, &nfsd_io_cache_read_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2f..41cb7c7feff3e 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
 
 extern bool nfsd_disable_splice_read __read_mostly;
 
+enum {
+	/* Any new NFSD_IO enum value must be added at the end */
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
index 79439ad93880a..21441745df69a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,7 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1099,6 +1100,22 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+		break;
+	case NFSD_IO_BUFFERED:
+		break;
+	}
+
 	kiocb.ki_pos = offset;
 
 	v = 0;
-- 
2.44.0


