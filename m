Return-Path: <linux-nfs+bounces-17231-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFF3CD0396
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B51A0300E15B
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8532AAA9;
	Fri, 19 Dec 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTuXE+6N"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25D328B75
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153470; cv=none; b=iLV8V3vzCWVOMxLzOjxSZQzQ2gwc2WhhRk2/GQH811GI+WlXPNGMzF5Kv21eJgb8+hf8XKJltFchmAnol7A73ppir6RdIWizYKUm8ggMPFE689PJSs2xJse3XQEvYiJwAlmBIBaOjWwa3v6QWT3UAq19zmG68iu1TChpeHh38l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153470; c=relaxed/simple;
	bh=6d0FUZiTm0I42P4FRdxikimCh4X1Aks4AKD30LDnxtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3vkpvrb9S7AqQaU+Zd3UE4alL1/kv0+Tcc79r7+4YKUhoUWmnrHXeNAVKE7hehWd9ioEZjl4xB7vdItzAOpEYKyEXwCRT9oeatZRFNFag1ZafNy65S0WnjPkTJPYV17bvVKRyaIgM70n6E/4JZb8pqjoDCuwoI5f12L09AQMDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTuXE+6N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943FBC4CEF1;
	Fri, 19 Dec 2025 14:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153470;
	bh=6d0FUZiTm0I42P4FRdxikimCh4X1Aks4AKD30LDnxtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bTuXE+6NgwBw1303kH2F7Sk5+NNVqLM0WTeFgbzSxmuViFQWWP05StIUpoSu1XZmd
	 n922ij0XRccklFgA6UdSYF+fqxkj6sEdvnLuhqQSPOdm8gUeZs1Q3EwIx652N5L5q7
	 K4Edz5rV2XG4XNWF2+ZXCzTcx7eTyULr4PNAooZ9kgI7q71R5i7XgDSDp8YNC0lEZP
	 QB5CI5lH1ME46vaXFnd7QFIdLVhBW8BRrYSehtIYZlTS6+O1oAiGziZ6RT/Glq8uGd
	 +VTFeyVkZ8ZcF5RUNAQLvB4MOs6rIUDCICUDOXYQsizwlpHCw91+akBllUxIb+6Mat
	 jvXuxIJ3hgUaA==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/2] NFSD: Add aggressive write throttling control
Date: Fri, 19 Dec 2025 09:11:04 -0500
Message-ID: <20251219141105.1247093-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219141105.1247093-1-cel@kernel.org>
References: <20251219141105.1247093-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

On NFS servers with fast network links but slow storage, clients can
generate WRITE requests faster than the server can flush payloads to
durable storage. This can push the server into memory exhaustion as
dirty pages accumulate across hundreds of concurrent NFSD threads.

The existing dirty page throttling (balance_dirty_pages()) uses
per-task accounting with default ratelimits that allow each thread
to dirty ~32 pages before throttling occurs. With many NFSD threads,
this allows significant dirty page accumulation before any
throttling kicks in.

Add a debugfs control to enable aggressive write throttling for
NFSD:

  /sys/kernel/debug/nfsd/write_throttle

When set to 1, NFSD write operations reduce nr_dirtied_pause to
force balance_dirty_pages() to be called more frequently. This uses
the same page-size-adjusted limit that
balance_dirty_pages_ratelimited_flags() applies when
wb->dirty_exceeded is true, providing 4x more frequent throttling on
systems with 4KB pages.

The setting defaults to 0 (normal throttling) and can be changed at
runtime without restarting NFSD.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c | 33 +++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  9 +++++++++
 fs/nfsd/vfs.c     | 17 +++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index 7f44689e0a53..f3d9e957cc5c 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -122,6 +122,36 @@ static int nfsd_io_cache_write_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(nfsd_io_cache_write_fops, nfsd_io_cache_write_get,
 			 nfsd_io_cache_write_set, "%llu\n");
 
+/*
+ * /sys/kernel/debug/nfsd/write_throttle
+ *
+ * Contents:
+ *   %0: Normal throttling (default)
+ *   %1: Aggressive throttling for NFSD writes
+ *
+ * When set to 1, NFSD write operations are throttled more aggressively
+ * to prevent memory exhaustion when fast network clients overwhelm slow
+ * storage. This is useful when the server has limited memory or slow disks.
+ *
+ * This setting takes immediate effect for all NFS versions, all exports,
+ * and in all NFSD net namespaces.
+ */
+
+static int nfsd_write_throttle_get(void *data, u64 *val)
+{
+	*val = nfsd_aggressive_write_throttle ? 1 : 0;
+	return 0;
+}
+
+static int nfsd_write_throttle_set(void *data, u64 val)
+{
+	nfsd_aggressive_write_throttle = (val > 0);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_write_throttle_fops, nfsd_write_throttle_get,
+			 nfsd_write_throttle_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -140,4 +170,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("io_cache_write", 0644, nfsd_top_dir, NULL,
 			    &nfsd_io_cache_write_fops);
+
+	debugfs_create_file("write_throttle", 0644, nfsd_top_dir, NULL,
+			    &nfsd_write_throttle_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index b0283213a8f5..16a259839768 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -165,6 +165,15 @@ enum {
 
 extern u64 nfsd_io_cache_read __read_mostly;
 extern u64 nfsd_io_cache_write __read_mostly;
+extern bool nfsd_aggressive_write_throttle __read_mostly;
+
+/*
+ * Aggressive write throttling reduces nr_dirtied_pause to force more
+ * frequent calls to balance_dirty_pages(). This uses the same page-size
+ * adjusted formula as balance_dirty_pages_ratelimited_flags() when
+ * wb->dirty_exceeded is true (see mm/page-writeback.c:2066).
+ */
+#define NFSD_AGGRESSIVE_DIRTY_LIMIT	(32 >> (PAGE_SHIFT - 10))
 
 extern int nfsd_max_blksize;
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 168d3ccc8155..33805b9ac7e4 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -51,6 +51,7 @@
 bool nfsd_disable_splice_read __read_mostly;
 u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
 u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
+bool nfsd_aggressive_write_throttle __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1420,6 +1421,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned int		pflags = current->flags;
 	bool			restore_flags = false;
 	unsigned int		nvecs;
+	int			saved_nr_dirtied_pause = 0;
+	bool			throttle_adjusted = false;
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
@@ -1441,6 +1444,18 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	exp = fhp->fh_export;
 
+	/*
+	 * If aggressive write throttling is enabled, reduce the per-task
+	 * dirty page limit to throttle NFSD writes more aggressively.
+	 * This helps prevent memory exhaustion when fast network clients
+	 * overwhelm slow storage.
+	 */
+	if (nfsd_aggressive_write_throttle) {
+		saved_nr_dirtied_pause = current->nr_dirtied_pause;
+		current->nr_dirtied_pause = NFSD_AGGRESSIVE_DIRTY_LIMIT;
+		throttle_adjusted = true;
+	}
+
 	if (!EX_ISSYNC(exp))
 		stable = NFS_UNSTABLE;
 	init_sync_kiocb(&kiocb, file);
@@ -1505,6 +1520,8 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		trace_nfsd_write_err(rqstp, fhp, offset, host_err);
 		nfserr = nfserrno(host_err);
 	}
+	if (throttle_adjusted)
+		current->nr_dirtied_pause = saved_nr_dirtied_pause;
 	if (restore_flags)
 		current_restore_flags(pflags, PF_LOCAL_THROTTLE);
 	return nfserr;
-- 
2.52.0


