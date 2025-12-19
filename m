Return-Path: <linux-nfs+bounces-17232-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E3FCD0389
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 15:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C2D130322AB
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Dec 2025 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCEB32AAB8;
	Fri, 19 Dec 2025 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrNJsfV0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0813132AAB0
	for <linux-nfs@vger.kernel.org>; Fri, 19 Dec 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153471; cv=none; b=R+MmmTXrImp7fv23PgcVSZnW4WOc2+DpwnFFm6xM3NMMa4C8kFRogVsVTSpyK4VZuvagx0UHLrLqEIF+WdaMQfzQIMXoxAcXyFknZ09WWawXH9LRWMJRa5K38FFvnMeUZJZJ537yyBqrZOikFnf9Z0iSrl+0Ufuw1iQlmX+iaR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153471; c=relaxed/simple;
	bh=X6kV8tDpFRnU7H8zbUeJRexUNcNnj+1pXOGLBqcJqLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bh3paV06dtAbDViCGe01+Uq7vAyypoNytfbGaQL006qdrOrwJr//U5Vi4DypL6SP9N6cyTH+xeXFy45NklTK6t+4ofF7w1X6howp3W8uN6rPv/xROcV3doCMVFGuZF1Y1kRs+jujZa4Nr7obHXGJ8C12NaPpWENz4H7yBBkbuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrNJsfV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367AFC113D0;
	Fri, 19 Dec 2025 14:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766153470;
	bh=X6kV8tDpFRnU7H8zbUeJRexUNcNnj+1pXOGLBqcJqLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LrNJsfV0MKD1P7udEn5gwgF01ZcLjCqc9QVeD/uI+d5TlHpnpAjarkXU/V+r/9IFz
	 vg6096rRd0MfiIxZzP7AX0fVeYlz4rwmc5I6lbToJJr01xxuDflAlcRNQaBwfRmYx6
	 zawZLz/8KKor/dVpcIvln/29GFRV91BUL+lN8V68t7orjDOqHmSaqNNSW8y+G+If4z
	 qpYPXPP+kFhduD5JltOm5G+NLAkiQTphbcQ3BSpSUYRjSPomonKQgraIOtPPlIW9sO
	 fAbCHM5GSad3hsgI48rzjZqlJ07SGug5hCPtLB/FbeyGqPGCIf7uEFyAtn9znOIX+g
	 t1SIqyk80PcrQ==
From: Chuck Lever <cel@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/2] NFSD: Add asynchronous write throttling support
Date: Fri, 19 Dec 2025 09:11:05 -0500
Message-ID: <20251219141105.1247093-3-cel@kernel.org>
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

When memory pressure occurs during buffered writes, the traditional
approach is for balance_dirty_pages() to put the writing thread to
sleep until dirty pages are flushed. For NFSD, this means server
threads block waiting for I/O, reducing overall server throughput.

Add support for asynchronous write throttling using the BDP_ASYNC
flag to balance_dirty_pages_ratelimited_flags(). When enabled via:

  /sys/kernel/debug/nfsd/write_async_throttle

NFSD checks memory pressure before attempting buffered writes. If
balance_dirty_pages_ratelimited_flags() returns -EAGAIN (indicating
memory exhaustion), NFSD returns NFS4ERR_DELAY (or NFSERR_JUKEBOX for
NFSv3) to the client instead of blocking.

This allows clients to back off and retry rather than having server
threads tied up waiting for writeback. The setting defaults to 0
(synchronous throttling) and can be combined with write_throttle for
layered throttling strategies.

Note: NFSv2 does not support NFSERR_JUKEBOX, so async throttling is
automatically disabled for NFSv2 requests regardless of the setting.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c | 34 ++++++++++++++++++++++++++++++++++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/vfs.c     | 17 +++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index f3d9e957cc5c..f2cce37589ce 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -152,6 +152,37 @@ static int nfsd_write_throttle_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(nfsd_write_throttle_fops, nfsd_write_throttle_get,
 			 nfsd_write_throttle_set, "%llu\n");
 
+/*
+ * /sys/kernel/debug/nfsd/write_async_throttle
+ *
+ * Contents:
+ *   %0: Synchronous throttling (default) - writes sleep in balance_dirty_pages()
+ *   %1: Asynchronous throttling - return NFS4ERR_DELAY when memory is tight
+ *
+ * When set to 1, NFSD uses BDP_ASYNC mode which returns -EAGAIN from
+ * balance_dirty_pages_ratelimited_flags() instead of sleeping. This allows
+ * NFSD to return NFS4ERR_DELAY (or NFSERR_JUKEBOX for NFSv3), letting
+ * clients back off and retry rather than having NFSD threads blocked.
+ *
+ * This setting takes immediate effect for all NFS versions, all exports,
+ * and in all NFSD net namespaces.
+ */
+
+static int nfsd_async_throttle_get(void *data, u64 *val)
+{
+	*val = nfsd_async_write_throttle ? 1 : 0;
+	return 0;
+}
+
+static int nfsd_async_throttle_set(void *data, u64 val)
+{
+	nfsd_async_write_throttle = (val > 0);
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(nfsd_async_throttle_fops, nfsd_async_throttle_get,
+			 nfsd_async_throttle_set, "%llu\n");
+
 void nfsd_debugfs_exit(void)
 {
 	debugfs_remove_recursive(nfsd_top_dir);
@@ -173,4 +204,7 @@ void nfsd_debugfs_init(void)
 
 	debugfs_create_file("write_throttle", 0644, nfsd_top_dir, NULL,
 			    &nfsd_write_throttle_fops);
+
+	debugfs_create_file("write_async_throttle", 0644, nfsd_top_dir, NULL,
+			    &nfsd_async_throttle_fops);
 }
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 16a259839768..ea61db58ef95 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -166,6 +166,7 @@ enum {
 extern u64 nfsd_io_cache_read __read_mostly;
 extern u64 nfsd_io_cache_write __read_mostly;
 extern bool nfsd_aggressive_write_throttle __read_mostly;
+extern bool nfsd_async_write_throttle __read_mostly;
 
 /*
  * Aggressive write throttling reduces nr_dirtied_pause to force more
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 33805b9ac7e4..0fcfd29e843d 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -52,6 +52,7 @@ bool nfsd_disable_splice_read __read_mostly;
 u64 nfsd_io_cache_read __read_mostly = NFSD_IO_BUFFERED;
 u64 nfsd_io_cache_write __read_mostly = NFSD_IO_BUFFERED;
 bool nfsd_aggressive_write_throttle __read_mostly;
+bool nfsd_async_write_throttle __read_mostly;
 
 /**
  * nfserrno - Map Linux errnos to NFS errnos
@@ -1473,6 +1474,22 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		}
 	}
 
+	/*
+	 * If async throttling is enabled, check memory pressure
+	 * before attempting buffered writes. Return -EAGAIN if
+	 * the system is low on memory, allowing NFSD to return
+	 * an NFS error code asking the client to retry later.
+	 *
+	 * Skip this for NFSv2 since it lacks NFSERR_JUKEBOX.
+	 */
+	if (nfsd_async_write_throttle && rqstp->rq_vers >= 3) {
+		host_err =
+			balance_dirty_pages_ratelimited_flags(file->f_mapping,
+							      BDP_ASYNC);
+		if (host_err == -EAGAIN)
+			break;
+	}
+
 	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, rqstp->rq_maxpages, payload);
 
 	since = READ_ONCE(file->f_wb_err);
-- 
2.52.0


