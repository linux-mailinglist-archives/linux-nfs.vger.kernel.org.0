Return-Path: <linux-nfs+bounces-13694-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF5AB288C9
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D7E189DB34
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D60283C8E;
	Fri, 15 Aug 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xy9gN6PY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CD22D373B
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300613; cv=none; b=mqKzaOHLjB+uoQM9+L8CQdCYwSoxaqhyJBSrFqHCE1eksEvsb5X/vsyZbwHr3E4r8QuaIpza8qSdOjJxXZL+vVR9TiqbMlOksyrupv/mbzuHX67qgpbPoaJjXBqKRzGF22zSdrs0P6+nvw3oHle+BoDtc67CYTa/OFZy91i/ltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300613; c=relaxed/simple;
	bh=ijJfPdWBQmeOVlUzH4Ej/XVooFs+46GiVdeiPPf89v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pe76qx6SZagpd6WeZj6xpOlmqQa+BVD7HJE1aKoRKKFseKkx8j2SFhPC05K3i24SOA+vzk3JTDn5uHFcI8BOT89E/oLyBTPTtbf/hsA5cQIB3qBqsAtSw0V/fVHkgFl6W29vIUBoeuM5LAgj1wofT+KdSLa72PVh8JtTX+T6Dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xy9gN6PY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52ADC4CEF4;
	Fri, 15 Aug 2025 23:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300612;
	bh=ijJfPdWBQmeOVlUzH4Ej/XVooFs+46GiVdeiPPf89v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xy9gN6PYmI4F1w4kkwACVwyR04mm4QEx0ESqhhFEmA4ZYIrirD8OnpyISorwLUpkM
	 UgbfRBQ/5+NEFPvFKe0PbO9dWNzyfqPKGFDAShuG6SCYQU5UMVpobzQorqjwoPmZPj
	 gNFKXiPSm++cdM3n4LU9ZdpWZfJYFQAOvNzoP7N/rKUIaP/4WljzlQGcVVDCoIXecX
	 QfeCuL1b3V3Pd4I77s4tHPG87OMCq42RckyI8DOrXm+jxAE2QhL+LkbceJd8sqcxKI
	 u6d6Tp8cPfKYGDKQ/lQAjBD8yiEbKd4CpHPOXMhAR0cr6+g6k3oJlU2GXWyTpUPpeg
	 mqQ9reb4/POAw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 6/9] nfs/direct: add misaligned READ handling
Date: Fri, 15 Aug 2025 19:30:00 -0400
Message-ID: <20250815233003.55071-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815233003.55071-1-snitzer@kernel.org>
References: <20250815233003.55071-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because the NFS client will already happily handle misaligned O_DIRECT
IO (by sending it out to NFSD via RPC) this commit's new capabilities
are for the benefit of LOCALIO and require the nfs modparam:
  localio_O_DIRECT_align_misaligned_IO=Y

Add 'localio_O_DIRECT_align_misaligned_IO' modparm, which depends on
localio_O_DIRECT_semantics=Y, to control if LOCALIO will make best
effort to transform misaligned IO to DIO-aligned extents when possible.

When enabled, a misaligned DIO READ is split into a head, middle and
tail as needed. The large middle extent is DIO-aligned and the head
and/or tail are misaligned (due to each being a partial page).

The misaligned head and/or tail extents are issued using buffered IO
and the DIO-aligned middle is issued using O_DIRECT.

A new 'pg_doio_now' flag is added to the nfs_pageio_descriptor struct
and if set nfs_pageio_add_request() will issue all IO up to the
nfs_page being added. This allows for NFS DIRECT to issue the
misaligned head and/or tail and middle extents separately.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c          | 89 ++++++++++++++++++++++++++++++++++++----
 fs/nfs/internal.h        | 13 ++++++
 fs/nfs/localio.c         | 11 +++++
 fs/nfs/pagelist.c        |  9 +++-
 include/linux/nfs_page.h |  1 +
 5 files changed, 113 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 48d89716193a7..fc011571c5d29 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -363,9 +363,16 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 						  rsize, &pgbase);
 		if (result < 0)
 			break;
-	
-		bytes = result;
-		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
+
+		/* Limit the amount of bytes serviced each iteration to aligned batches */
+		if (pos < dreq->middle_offset && dreq->start_len)
+			bytes = min_t(size_t, dreq->start_len, result);
+		else if (pos < dreq->end_offset && dreq->middle_len)
+			bytes = min_t(size_t, dreq->middle_len, result);
+		else
+			bytes = result;
+		npages = (bytes + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
+
 		for (i = 0; i < npages; i++) {
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
@@ -376,15 +383,35 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 				result = PTR_ERR(req);
 				break;
 			}
+
+			pgbase = 0;
+			result -= req_len;
+			bytes -= req_len;
+			requested_bytes += req_len;
+			pos += req_len;
+
+			/* Issue IO if this req was the end of the start or middle */
+			if (bytes == 0) {
+				if ((dreq->start_len &&
+				     pos == dreq->middle_offset && result >= dreq->middle_len) ||
+				    (dreq->end_len &&
+				     pos == dreq->end_offset && result == dreq->end_len))
+					desc.pg_doio_now = 1;
+			}
+
 			if (!nfs_pageio_add_request(&desc, req)) {
+				desc.pg_doio_now = 0;
 				result = desc.pg_error;
 				nfs_release_request(req);
 				break;
 			}
-			pgbase = 0;
-			bytes -= req_len;
-			requested_bytes += req_len;
-			pos += req_len;
+
+			if (desc.pg_doio_now) {
+				/* Reset and handle iter to next aligned boundary */
+				iov_iter_revert(iter, result);
+				desc.pg_doio_now = 0;
+				break;
+			}
 		}
 		nfs_direct_release_pages(pagevec, npages);
 		kvfree(pagevec);
@@ -409,6 +436,47 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 	return requested_bytes;
 }
 
+/*
+ * If localio_O_DIRECT_align_misaligned_IO enabled, split misaligned
+ * IO to a DIO-aligned middle and misaligned head and/or tail.
+ */
+static bool nfs_analyze_dio(loff_t offset, ssize_t len,
+			    struct nfs_direct_req *dreq)
+{
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	/* Hardcoded to PAGE_SIZE (since don't have LOCALIO nfsd_file's
+	 * dio_alignment), works for smaller alignment too (e.g. 512b).
+	 */
+	u32 dio_blocksize = PAGE_SIZE;
+	loff_t start_end, orig_end, middle_end;
+
+	/* Return early if feature disabled, if IO is irreparably
+	 * misaligned (len < PAGE_SIZE) or if IO is already DIO-aligned.
+	 */
+	if (!nfs_localio_O_DIRECT_align_misaligned_IO() ||
+	    unlikely(len < dio_blocksize) ||
+	    (((offset | len) & (dio_blocksize-1)) == 0))
+		return false;
+
+	start_end = round_up(offset, dio_blocksize);
+	orig_end = offset + len;
+	middle_end = round_down(orig_end, dio_blocksize);
+
+	dreq->io_start = offset;
+	dreq->max_count = orig_end - offset;
+
+	dreq->start_len = start_end - offset;
+	dreq->middle_offset = start_end;
+	dreq->middle_len = middle_end - start_end;
+	dreq->end_offset = middle_end;
+	dreq->end_len = orig_end - middle_end;
+
+	return true;
+#else
+	return false;
+#endif
+}
+
 /**
  * nfs_file_direct_read - file direct read operation for NFS files
  * @iocb: target I/O control block
@@ -456,8 +524,11 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	dreq->max_count = count;
-	dreq->io_start = iocb->ki_pos;
+	if (swap || !nfs_analyze_dio(iocb->ki_pos, count, dreq)) {
+		dreq->max_count = count;
+		dreq->io_start = iocb->ki_pos;
+	}
+
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 522011eea5f2f..a9b03a5df243d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -469,6 +469,7 @@ extern int nfs_local_commit(struct nfsd_file *,
 			    struct nfs_commit_data *,
 			    const struct rpc_call_ops *, int);
 extern bool nfs_server_is_local(const struct nfs_client *clp);
+extern bool nfs_localio_O_DIRECT_align_misaligned_IO(void);
 
 #else /* CONFIG_NFS_LOCALIO */
 static inline void nfs_local_probe(struct nfs_client *clp) {}
@@ -497,6 +498,10 @@ static inline bool nfs_server_is_local(const struct nfs_client *clp)
 {
 	return false;
 }
+static inline bool nfs_localio_O_DIRECT_align_misaligned_IO(void)
+{
+	return false;
+}
 #endif /* CONFIG_NFS_LOCALIO */
 
 /* super.c */
@@ -987,4 +992,12 @@ struct nfs_direct_req {
 	/* for read */
 #define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
 #define NFS_ODIRECT_DONE		INT_MAX	/* write verification failed */
+
+	/* State for expanding/splitting misaligned IO to be DIO-aligned (for LOCALIO) */
+	struct bio_vec *        start_extra_bvec;
+	loff_t			middle_offset;
+	loff_t			end_offset;
+	ssize_t			start_len;
+	ssize_t			middle_len;
+	ssize_t			end_len;
 };
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index b219999afee18..89d505e4ef359 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -55,6 +55,11 @@ module_param(localio_O_DIRECT_semantics, bool, 0644);
 MODULE_PARM_DESC(localio_O_DIRECT_semantics,
 		 "LOCALIO will use O_DIRECT semantics to filesystem.");
 
+static bool localio_O_DIRECT_align_misaligned_IO __read_mostly = true;
+module_param(localio_O_DIRECT_align_misaligned_IO, bool, 0644);
+MODULE_PARM_DESC(localio_O_DIRECT_align_misaligned_IO,
+		 "If LOCALIO_O_DIRECT_semantics=Y make best effort to transform misaligned IO to DIO-aligned.");
+
 static inline bool nfs_client_is_local(const struct nfs_client *clp)
 {
 	return !!rcu_access_pointer(clp->cl_uuid.net);
@@ -66,6 +71,12 @@ bool nfs_server_is_local(const struct nfs_client *clp)
 }
 EXPORT_SYMBOL_GPL(nfs_server_is_local);
 
+bool nfs_localio_O_DIRECT_align_misaligned_IO(void)
+{
+	return localio_O_DIRECT_align_misaligned_IO;
+}
+EXPORT_SYMBOL_GPL(nfs_localio_O_DIRECT_align_misaligned_IO);
+
 /*
  * UUID_IS_LOCAL XDR functions
  */
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 11968dcb72431..b30b1e8f9ff4b 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -824,6 +824,7 @@ void nfs_pageio_init(struct nfs_pageio_descriptor *desc,
 		     int io_flags)
 {
 	desc->pg_moreio = 0;
+	desc->pg_doio_now = 0;
 	desc->pg_inode = inode;
 	desc->pg_ops = pg_ops;
 	desc->pg_completion_ops = compl_ops;
@@ -1190,8 +1191,11 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 		size = nfs_pageio_do_add_request(desc, subreq);
 		if (size == subreq_size) {
 			/* We successfully submitted a request */
-			if (subreq == req)
+			if (subreq == req) {
+				if (desc->pg_doio_now)
+					goto doio_now;
 				break;
+			}
 			req->wb_pgbase += size;
 			req->wb_bytes -= size;
 			req->wb_offset += size;
@@ -1207,12 +1211,15 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 			nfs_page_group_lock(req);
 		}
 		if (!size) {
+doio_now:
 			/* Can't coalesce any more, so do I/O */
 			nfs_page_group_unlock(req);
 			desc->pg_moreio = 1;
 			nfs_pageio_doio(desc);
 			if (desc->pg_error < 0 || mirror->pg_recoalesce)
 				return 0;
+			if (desc->pg_doio_now)
+				return 1;
 			/* retry add_request for this subreq */
 			nfs_page_group_lock(req);
 			continue;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 169b4ae30ff47..2e88dc2ff3fea 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -117,6 +117,7 @@ struct nfs_pageio_descriptor {
 	u32			pg_mirror_idx;	/* current mirror */
 	unsigned short		pg_maxretrans;
 	unsigned char		pg_moreio : 1;
+	unsigned char		pg_doio_now : 1;
 };
 
 /* arbitrarily selected limit to number of mirrors */
-- 
2.44.0


