Return-Path: <linux-nfs+bounces-13214-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB52DB0F753
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEB1AA7ECA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Jul 2025 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA6120013A;
	Wed, 23 Jul 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+i2nHYq"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3920C20B81B
	for <linux-nfs@vger.kernel.org>; Wed, 23 Jul 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285439; cv=none; b=R90rTSRi7+OxfL5wIto+BBDzfWVwFwUpNMUDqcWcqhB3tQuQhi+1FnTkP2qAksOLRcQSKDdsRtsfDOEsTzGJptrzMYUut5Ja97qM51InES1eLwFRM5eMVkHm52Bx8OeXgNnHnymmRug+juKZzRGaQcBh8nl6/Lf5s0Vi3MFXU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285439; c=relaxed/simple;
	bh=u7JZFgp2paj+yPH9KpjK3/Ow9GQNwL8TnTBLXQdFkKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9izq7n9dL4kD+uHlA6qRNMMK3CR7bHdfff4CiRB4lesldMVfsG+HA4jcjObc5kQtMM8GdPM4s0kwEOyZpWhWZVAQQCClLMMksVFg/krCv7Viegw8IFyc46pJXFcR6qoklWwWhop+838Tyb6BytLY1aYtdvZ0F5iFggZZNMxPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+i2nHYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EE3C4CEEF;
	Wed, 23 Jul 2025 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753285438;
	bh=u7JZFgp2paj+yPH9KpjK3/Ow9GQNwL8TnTBLXQdFkKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+i2nHYqFOvzX14bCw+Chc062acjNlMDdRntRo6ICi/8fOZ+b1uEO0pRngZ5Yuwvo
	 b1os1iOoNufoJEQGADB6rKsdFYLEc+HsiD5UPSMKlWu+UYMaXvn2C4tkjBImsu0qvI
	 kOtoi08BA457p9uCKh9Rlu7WKi5oFTo5Y9Av2dfn7kuAivE5uq823F06/zVplV+8uX
	 c9GiejKJko9zZ9iOJF7CgYsm3hRb1RCaqHOqyoF896HzPVG3zGJkqW8Qqti/TCmFlD
	 s2ZLtzcNmBSwtU3CRujgtcFooPmTT9F3CYRCYGrHLM0zyq+//KEjK4DMH3TCV+WHlz
	 U/b1uD8e2v+GA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 4/5] NFSD: add io_cache_write controls to debugfs interface
Date: Wed, 23 Jul 2025 11:43:50 -0400
Message-ID: <20250723154351.59042-5-snitzer@kernel.org>
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
index 2066fe17db2b..fac8be5a825d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -50,6 +50,7 @@
 
 bool nfsd_disable_splice_read __read_mostly;
 u64 nfsd_io_cache_read __read_mostly;
+u64 nfsd_io_cache_write __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1237,6 +1238,23 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
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


