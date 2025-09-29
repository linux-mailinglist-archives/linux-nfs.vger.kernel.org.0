Return-Path: <linux-nfs+bounces-14775-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E73BBA9E47
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 17:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA419225F8
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Sep 2025 15:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B97A30C113;
	Mon, 29 Sep 2025 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMvoXAPQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7769B30C0EA
	for <linux-nfs@vger.kernel.org>; Mon, 29 Sep 2025 15:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161412; cv=none; b=Fq/XJ6LmZTG4LcKtISOGmc+EOPX7Zyaxn1sTV+qh73xYlziCMVKjm2Iu4witcjZfoQd9TnpwzUokl9RrajyDO9p3V+nRp2ODR1vVZqpbzyLB/Oxw9BU7yrLFz1F1KUQNvdvj9+EOY/MCYkoT79zpzYm3VYrCiKAjnVdbTdn0FAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161412; c=relaxed/simple;
	bh=yQGPc4Icht6H+17Ihh8B64S7Fe6GxxxfDnwhwbaBUHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGZ2W5FhKWDPSZHyxYcsJmj19VTgMcP/T6xkj7ZMFtXfBdEiJgmhG0N9lbrk3b7TOCbUAyozb+0yyxaRqh6bTKpndBvrve8a65aoyhXIBoXzmp7W7R8UdZKIYY5nTrtWyQM1c21gR1CrPx5HwuGvu1W796WAKLc/Xdy52CyV+i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMvoXAPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D9EC4CEF4;
	Mon, 29 Sep 2025 15:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161411;
	bh=yQGPc4Icht6H+17Ihh8B64S7Fe6GxxxfDnwhwbaBUHo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMvoXAPQJ58s++iNlbBLWJNiAosWTdrctc24dCy+W9GaGUDTgXGOLU/S+CDNdxq7g
	 ldsF/T7f6kWjO0GIkyQaD08uMSS6UXnCvH7MhCH77PS3NewMlto0UXFteNf729tI3V
	 8VxUcCP9yG+wsGdoPKvbnMmypnfVzy37/A4SUmbRhefCM9YrU6cqquqO37IEiQFYvn
	 FYNyecIUw2cnp4HqRoT51PBTeaSWKFhIlAvoqcCs5Vq+aEq9lx5geRloK/8kZy81yB
	 Zi3/at9HgDEh8j/cn80q1dcCyrpunt70lxktsfI6xeRxOEKF4xKlbi4l3FrHOH4V4B
	 xq8/g+NBVy38g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v5 4/6] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Date: Mon, 29 Sep 2025 11:56:44 -0400
Message-ID: <20250929155646.4818-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929155646.4818-1-cel@kernel.org>
References: <20250929155646.4818-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Add an experimental option that forces NFS READ operations to use
direct I/O instead of reading through the NFS server's page cache.

There is already at least one other layer of read caching: the page
cache on NFS clients.

The server's page cache, in many cases, is unlikely to provide
additional benefit. Some benchmarks have demonstrated that the
server's page cache is actively detrimental for workloads whose
working set is larger than the server's available physical memory.

For instance, on small NFS servers, cached NFS file content can
squeeze out local memory consumers. For large sequential workloads,
an enormous amount of data flows into and out of the page cache
and is consumed by NFS clients exactly once -- caching that data
is expensive to do and totally valueless.

For now this is a hidden option that can be enabled on test
systems for benchmarking. In the longer term, this option might
be enabled persistently or per-export. When the exported file
system does not support direct I/O, NFSD falls back to using
either DONTCACHE or buffered I/O to fulfill NFS READ requests.

Suggested-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c |  2 ++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/trace.h   |  1 +
 fs/nfsd/vfs.c     | 85 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/fs/nfsd/debugfs.c b/fs/nfsd/debugfs.c
index ed2b9e066206..00eb1ecef6ac 100644
--- a/fs/nfsd/debugfs.c
+++ b/fs/nfsd/debugfs.c
@@ -44,6 +44,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(nfsd_dsr_fops, nfsd_dsr_get, nfsd_dsr_set, "%llu\n");
  * Contents:
  *   %0: NFS READ will use buffered IO
  *   %1: NFS READ will use dontcache (buffered IO w/ dropbehind)
+ *   %2: NFS READ will use direct IO
  *
  * This setting takes immediate effect for all NFS versions,
  * all exports, and in all NFSD net namespaces.
@@ -64,6 +65,7 @@ static int nfsd_io_cache_read_set(void *data, u64 val)
 		nfsd_io_cache_read = NFSD_IO_BUFFERED;
 		break;
 	case NFSD_IO_DONTCACHE:
+	case NFSD_IO_DIRECT:
 		/*
 		 * Must disable splice_read when enabling
 		 * NFSD_IO_DONTCACHE.
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index ea87b42894dd..bdb60ee1f1a4 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -157,6 +157,7 @@ enum {
 	/* Any new NFSD_IO enum value must be added at the end */
 	NFSD_IO_BUFFERED,
 	NFSD_IO_DONTCACHE,
+	NFSD_IO_DIRECT,
 };
 
 extern u64 nfsd_io_cache_read __read_mostly;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6e2c8e2aab10..bfd41236aff2 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -464,6 +464,7 @@ DEFINE_EVENT(nfsd_io_class, nfsd_##name,	\
 DEFINE_NFSD_IO_EVENT(read_start);
 DEFINE_NFSD_IO_EVENT(read_splice);
 DEFINE_NFSD_IO_EVENT(read_vector);
+DEFINE_NFSD_IO_EVENT(read_direct);
 DEFINE_NFSD_IO_EVENT(read_io_done);
 DEFINE_NFSD_IO_EVENT(read_done);
 DEFINE_NFSD_IO_EVENT(write_start);
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 35880d3f1326..8172a063db07 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1074,6 +1074,84 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
 
+/*
+ * The byte range of the client's READ request is expanded on both
+ * ends until it meets the underlying file system's direct I/O
+ * alignment requirements. After the internal read is complete, the
+ * byte range of the NFS READ payload is reduced to the byte range
+ * that was originally requested.
+ *
+ * Note that a direct read can be done only when the xdr_buf
+ * containing the NFS READ reply does not already have contents in
+ * its .pages array. This is due to potentially restrictive
+ * alignment requirements on the read buffer. When .page_len and
+ * @base are zero, the .pages array is guaranteed to be page-
+ * aligned.
+ */
+static noinline_for_stack __be32
+nfsd_direct_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
+		 struct nfsd_file *nf, loff_t offset, unsigned long *count,
+		 u32 *eof)
+{
+	u64 dio_start, dio_end;
+	unsigned long v, total;
+	struct iov_iter iter;
+	struct kiocb kiocb;
+	ssize_t host_err;
+	size_t len;
+
+	init_sync_kiocb(&kiocb, nf->nf_file);
+	kiocb.ki_flags |= IOCB_DIRECT;
+
+	/* Read a properly-aligned region of bytes into rq_bvec */
+	dio_start = round_down(offset, nf->nf_dio_read_offset_align);
+	dio_end = round_up((u64)offset + *count, nf->nf_dio_read_offset_align);
+
+	kiocb.ki_pos = dio_start;
+
+	v = 0;
+	total = dio_end - dio_start;
+	while (total && v < rqstp->rq_maxpages &&
+	       rqstp->rq_next_page < rqstp->rq_page_end) {
+		len = min_t(size_t, total, PAGE_SIZE);
+		bvec_set_page(&rqstp->rq_bvec[v], *rqstp->rq_next_page,
+			      len, 0);
+
+		total -= len;
+		++rqstp->rq_next_page;
+		++v;
+	}
+
+	trace_nfsd_read_direct(rqstp, fhp, offset, *count - total);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v,
+		      dio_end - dio_start - total);
+
+	host_err = vfs_iocb_iter_read(nf->nf_file, &kiocb, &iter);
+	if (host_err >= 0) {
+		unsigned int pad = offset - dio_start;
+
+		/* The returned payload starts after the pad */
+		rqstp->rq_res.page_base = pad;
+
+		/* Compute the count of bytes to be returned */
+		if (host_err > pad + *count)
+			host_err = *count;
+		else if (host_err > pad)
+			host_err -= pad;
+		else
+			host_err = 0;
+	} else if (unlikely(host_err == -EINVAL)) {
+		struct inode *inode = d_inode(fhp->fh_dentry);
+
+		pr_info_ratelimited("nfsd: Direct I/O alignment failure on %s/%ld\n",
+				    inode->i_sb->s_id, inode->i_ino);
+		host_err = -ESERVERFAULT;
+	}
+
+	return nfsd_finish_read(rqstp, fhp, nf->nf_file, offset, count,
+				eof, host_err);
+}
+
 /**
  * nfsd_iter_read - Perform a VFS read using an iterator
  * @rqstp: RPC transaction context
@@ -1106,6 +1184,13 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	switch (nfsd_io_cache_read) {
 	case NFSD_IO_BUFFERED:
 		break;
+	case NFSD_IO_DIRECT:
+		/* When dio_read_offset_align is zero, dio is not supported */
+		if (nf->nf_dio_read_offset_align &&
+		    !rqstp->rq_res.page_len)
+			return nfsd_direct_read(rqstp, fhp, nf, offset,
+						count, eof);
+		fallthrough;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags = IOCB_DONTCACHE;
-- 
2.51.0


