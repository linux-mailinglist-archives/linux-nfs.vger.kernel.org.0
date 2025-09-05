Return-Path: <linux-nfs+bounces-14077-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D563B45B37
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EA9484D36
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Sep 2025 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8A7306B3F;
	Fri,  5 Sep 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IflA98N8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC9306B36
	for <linux-nfs@vger.kernel.org>; Fri,  5 Sep 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084117; cv=none; b=R5Gj/NyzCW2viWqXg3C2U/f2vjbuv5bRqZY3mXCHJxfWGc8ldzTQ8d9+a1q8+DXCOh4jTDokQnbbHLLZELDYWrvK7mdZc+9ppf9e+3KOYGOzW5g0sYVX10haJ1jv4rOWpGQsYK1kKjli0s0uh0GQE9+AvdCi4fF78IY82LoZZuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084117; c=relaxed/simple;
	bh=5l+Y7U+D/Lcw/bNPh8h41y3ZffproPECeDmFmJb9pHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anvqmUpJ2mMDk614iLbQUG+SS5yTivWZDgAf2UO7wlVzvhp9pHX33nMKodws6NDgcvkgBsssPnzzM/ALEI72Jx22rOTBmL0+CD/tpPzfsmavJNkFl5gSgYd9g7ZAH9wv3N4p5qNZ/dytBlqFvb0ngpgvjjFv75WK+PxxHKzZiJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IflA98N8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF0BC4CEF1;
	Fri,  5 Sep 2025 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084114;
	bh=5l+Y7U+D/Lcw/bNPh8h41y3ZffproPECeDmFmJb9pHw=;
	h=From:To:Cc:Subject:Date:From;
	b=IflA98N8O8r5n+aaA6ixec2id7fJIGHSBavxcHGDgOZIwOhPWmqBtGopOoowqhfGg
	 GMWFdxWk+nV3XeWbNaodAL+v1xu854/Z3lkVBqKaPvMZLgP3B8F8++zrtQ3E54ntP7
	 Q9hfYNi5+etdwZbTDVpSHlWTkDah3P4fYOZPYRlcEgDOoTaS+AkdK2Oea2H8+GxNei
	 1ptJQFPrtUdEiPQYXyA+h82zNCQ+EysK6xvv717rB8j2PbqwFTXP0MViatn1jedcBL
	 3bySr+TAPUDOZjXpFNsZv5r01nRSS9W4xrQ/o45NtN/weKz1FY30EVu3TdfMEvDU8t
	 bgioU6/pX/zzw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH] NFSD: Add io_cache_{read,write} controls to debugfs
Date: Fri,  5 Sep 2025 10:55:09 -0400
Message-ID: <20250905145509.8678-1-cel@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add 'io_cache_read' to NFSD's debugfs interface so that any data
read by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=0)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=1).

io_cache_read may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_read

Add 'io_cache_write' to NFSD's debugfs interface so that any data
written by NFSD will either be:
- cached using page cache (NFSD_IO_BUFFERED=0)
- cached but removed from the page cache upon completion
  (NFSD_IO_DONTCACHE=1).

io_cache_write may be set by writing to:
  /sys/kernel/debug/nfsd/io_cache_write

The default value for both settings is NFSD_IO_BUFFERED, which is
NFSD's existing behavior for both read and write. Changes to these
settings take immediate effect for all exports and NFS versions.

If NFSD_IO_DONTCACHE is specified, all exported filesystems must
implement FOP_DONTCACHE, otherwise IO flagged with RWF_DONTCACHE
will fail with -EOPNOTSUPP.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  9 +++++
 fs/nfsd/vfs.c     | 19 ++++++++++
 3 files changed, 121 insertions(+)

Changes from Mike's v9:
- Squashed the "io controls" patches together
- Removed NFSD_IO_DIRECT for the moment
- Addressed a few more checkpatch.pl nits

This gives a cleaner platform on which to build the direct I/O code
paths, and does not expose partially implemented I/O modes to users.

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 84b0c8b559dc..2b1bb716b608 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -27,11 +27,98 @@ static int nfsd_dsr_get(void *data, u64 *val)
 static int nfsd_dsr_set(void *data, u64 val)
 {
 	nfsd_disable_splice_read = (val > 0) ? true : false;
+	if (!nfsd_disable_splice_read) {
+		/*
+		 * Must use buffered I/O if splice_read is enabled.
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
+		/*
+		 * Must disable splice_read when enabling
+		 * NFSD_IO_DONTCACHE.
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
+/*
+ * /sys/kernel/debug/nfsd/io_cache_write
+ *
+ * Contents:
+ *   %0: NFS WRITE will use buffered IO
+ *   %1: NFS WRITE will use dontcache (buffered IO w/ dropbehind)
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
@@ -44,4 +131,10 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("disable-splice-read", S_IWUSR | S_IRUGO,
 			    nfsd_top_dir, NULL, &nfsd_dsr_fops);
+
+	debugfs_create_file("io_cache_read", 0644, nfsd_top_dir, NULL,
+			    &nfsd_io_cache_read_fops);
+
+	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
+			    &nfsd_io_cache_write_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 1cd0bed57bc2..809729d41e08 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -153,6 +153,15 @@ static inline void nfsd_debugfs_exit(void) {}
 
 extern bool nfsd_disable_splice_read __read_mostly;
 
+enum {
+	/* Any new NFSD_IO enum value must be added at the end */
+	NFSD_IO_BUFFERED,
+	NFSD_IO_DONTCACHE,
+};
+
+extern u64 nfsd_io_cache_read __read_mostly;
+extern u64 nfsd_io_cache_write __read_mostly;
+
 extern int nfsd_max_blksize;
 
 static inline int nfsd_v4client(struct svc_rqst *rq)
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 3cd3b9e069f4..b081824f5528 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -49,6 +49,8 @@
 #define NFSDDBG_FACILITY		NFSDDBG_FILEOP
 
 bool nfsd_disable_splice_read __read_mostly;
+u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
+u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1099,6 +1101,15 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	size_t len;
 
 	init_sync_kiocb(&kiocb, file);
+
+	switch (nfsd_io_cache_read) {
+	case NFSD_IO_BUFFERED:
+		break;
+	case NFSD_IO_DONTCACHE:
+		kiocb.ki_flags = IOCB_DONTCACHE;
+		break;
+	}
+
 	kiocb.ki_pos = offset;
 
 	v = 0;
@@ -1224,6 +1235,14 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
+
+	switch (nfsd_io_cache_write) {
+	case NFSD_IO_BUFFERED:
+		break;
+	case NFSD_IO_DONTCACHE:
+		kiocb.ki_flags |= IOCB_DONTCACHE;
+		break;
+	}
 	host_err = vfs_iocb_iter_write(file, &kiocb, &iter);
 	if (host_err < 0) {
 		commit_reset_write_verifier(nn, rqstp, host_err);
-- 
2.50.0


