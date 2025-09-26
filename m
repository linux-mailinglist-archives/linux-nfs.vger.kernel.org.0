Return-Path: <linux-nfs+bounces-14742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1A9BA44C2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C110E3862BD
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Sep 2025 14:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50131F1317;
	Fri, 26 Sep 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niDasCHH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA451DF261
	for <linux-nfs@vger.kernel.org>; Fri, 26 Sep 2025 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758898316; cv=none; b=KD7t/V0HIlmTt4R6ul2lCyisv/7P50R1qYKzzCpyWHM+h0SdH9OzwDuW6hIrieYnZfQPYNiQh+GdEDI0WCZ/IWQW63WQJRJNq0YH9mG3Wc4YBYDjhnCN9vPqXu9OiDgtLw9aAq0Ry4H6UHKCo0dG3toY0w1V9tsHxpPEVW63ViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758898316; c=relaxed/simple;
	bh=P+zhA1xLgvRhGLPWAJsTS3q6DeycPLF1IWUvB5Iepeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+ur4FmVARiKfsSJM79T/8zPuzZctRo9TWN8u6vFRWUhbHJt8lCAGtrUaKY9qj+b1fmy8QdvMpbk8VxbkZu7SnLzhAustkXrVpWDodISOgM5rNEbN6EHJmXpa/qd4VfOA6yzYPmspHnr4T7wiEpFNjMt32ZJAJGD3JpZBy4V+4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niDasCHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9ABC4CEF7;
	Fri, 26 Sep 2025 14:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758898316;
	bh=P+zhA1xLgvRhGLPWAJsTS3q6DeycPLF1IWUvB5Iepeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=niDasCHHksFPRq22bRsyuWocprsrrXl/DXXfOFi4OmQ1uzZB8J4AedzSJHFfggBgl
	 ZTtcIOEoM/ULQdmGTRrDZ3LtAGDaa/WvJXFzQQGb7CJkgbjvisMbpffSA3Gm9VK5NT
	 V5ezHT4jzM55KxLzHqi/wNj4UGarOVo8E1EfqORl1iYYDlxY8W8l0Ojvp7bEzciKEM
	 A9uLj+I8sqEtvpbI01PPb4fAesUfSRJdNp4obrPsAd/xRNaemiR52j8BsyCDXk/Ez1
	 L5+l52FZQoXFtnmu7Fs+RZFYyzFlCHE3jEitxXbmlTlEnmRsXDF+apAft6rWJxej1E
	 kGcKEdmYGpBqQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v4 4/4] NFSD: Implement NFSD_IO_DIRECT for NFS READ
Date: Fri, 26 Sep 2025 10:51:51 -0400
Message-ID: <20250926145151.59941-5-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926145151.59941-1-cel@kernel.org>
References: <20250926145151.59941-1-cel@kernel.org>
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

There are already other layers of caching:
 - The page cache on NFS clients
 - The block device underlying the exported file system

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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/debugfs.c |  2 ++
 fs/nfsd/nfsd.h    |  1 +
 fs/nfsd/trace.h   |  1 +
 fs/nfsd/vfs.c     | 82 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+)

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
index 35880d3f1326..2f12d68e5356 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1074,6 +1074,82 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
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
+	loff_t dio_start, dio_end;
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
+	dio_end = round_up(offset + *count, nf->nf_dio_read_offset_align);
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
+		if (host_err > pad + *count) {
+			host_err = *count;
+		} else if (host_err > pad) {
+			host_err -= pad;
+		} else {
+			host_err = 0;
+		}
+	} else if (unlikely(host_err == -EINVAL)) {
+		pr_info_ratelimited("nfsd: Unexpected direct I/O alignment failure\n");
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
@@ -1106,6 +1182,12 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	switch (nfsd_io_cache_read) {
 	case NFSD_IO_BUFFERED:
 		break;
+	case NFSD_IO_DIRECT:
+		if (nf->nf_dio_read_offset_align &&
+		    !rqstp->rq_res.page_len && !base)
+			return nfsd_direct_read(rqstp, fhp, nf, offset,
+						count, eof);
+		fallthrough;
 	case NFSD_IO_DONTCACHE:
 		if (file->f_op->fop_flags & FOP_DONTCACHE)
 			kiocb.ki_flags = IOCB_DONTCACHE;
-- 
2.51.0


