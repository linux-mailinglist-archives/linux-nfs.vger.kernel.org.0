Return-Path: <linux-nfs+bounces-13177-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 817F8B0CFE3
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 04:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76C4F1C2008E
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Jul 2025 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E92737F0;
	Tue, 22 Jul 2025 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tqClIM95"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D82737F6
	for <linux-nfs@vger.kernel.org>; Tue, 22 Jul 2025 02:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152575; cv=none; b=a/MtOJsbnkvcLQv88KR7E2vJ55m6qiuOfQQGNQ3Zt3NtjcIJ2Bygb3Ma2T5bDpuSEs0DU4BRst/1EfUpl6qB0QsoFGo83qjwrL1ZuIL9feg9SmbHNH+JBwHv8S53PWZ/KZyYSx5otgf40XE940mUYvxdLZAGvPT00c67QNedIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152575; c=relaxed/simple;
	bh=wov69qENfBrFT/PH4OZDJ6UGbmziPZOft/tz15DpcKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1BBs+uMaRsBZydVzIkuBxgaeaOd7ij8K7qmlT0X4OIa/CxxQp2RE20KTWuUhR09z8/0craUCZ6s50TPyzd0KQEaxVvsXwbEqLs1b5UBKkchwCxr7/2LiECE8CWfRtlkBs9EHGiRmbZdUHNMwSoQ76Vz6JsEP4aovrWigdXXG/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tqClIM95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31078C4CEED;
	Tue, 22 Jul 2025 02:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753152575;
	bh=wov69qENfBrFT/PH4OZDJ6UGbmziPZOft/tz15DpcKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tqClIM952TNc70SBXgr3SYUvPIvz4lN8fX5q6k3AHjPnQ5Y2/wgrdsKSkOoefNcyL
	 fqroPl6qWAwpn0Amp0bXPPosBu4RaRXEK8dDbMhZkiXQmdhraMKwF8XjnigvU19QSZ
	 w2yzBlR+ivX3YM/k+8l2KF1TKXZI4zDPzlhaQhFUF/F4FbR2KG4ahUwF+FHUFt1PLR
	 Z1NQKObmaDFkIopjcwO/Pos7XZb8N3zSkWNnQ5B9PP2svTnplo0zQ6NqIb8rYfJx+f
	 JjTkVM3yDlevyo1bqxh5bWViLg3Ywdv6YTnU+WFadMJDpqVh69pzFxYa/zyOlWreMl
	 JFueWrsMZEu3g==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/7] nfs/direct: add misaligned WRITE handling
Date: Mon, 21 Jul 2025 22:49:24 -0400
Message-ID: <20250722024924.49877-8-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250722024924.49877-1-snitzer@kernel.org>
References: <20250722024924.49877-1-snitzer@kernel.org>
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

When enabled, misaligned WRITE IO is split into a start, middle and
end as needed. The large middle extent is DIO-aligned and the start
and/or end are misaligned (due to each being a partial page).

Like the READ support that came before this WRITE support, the
nfs_analyze_dio trace event shows how the NFS client split a given
misaligned IO into a mix of misaligned page(s) and a DIO-aligned
extent.

This combination of trace events is useful for LOCALIO WRITEs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_analyze_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

Which for this dd command:

  dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct

Results in:

              dd-63257   [001] ..... 83742.427650: nfs_analyze_dio: WRITE offset=0 len=47008 start=0+0 middle=0+45056 end=45056+1952
              dd-63257   [001] ..... 83742.427659: nfs_initiate_write: fileid=00:2e:219750 fhandle=0xf6927a01 offset=0 count=45056 stable=UNSTABLE
              dd-63257   [001] ..... 83742.427662: nfs_initiate_write: fileid=00:2e:219750 fhandle=0xf6927a01 offset=45056 count=1952 stable=UNSTABLE
  kworker/u193:3-62985   [011] ..... 83742.427664: xfs_file_direct_write: dev 259:22 ino 0x5e0000a3 disize 0x0 pos 0x0 bytecount 0xb000
  kworker/u193:3-62985   [011] ..... 83742.427695: nfs_writeback_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=0 count=45056 res=45056 stable=UNSTABLE verifier=a8b37e6803d1eb1e
  kworker/u193:4-63221   [004] ..... 83742.427699: nfs_writeback_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=45056 count=1952 res=1952 stable=UNSTABLE verifier=a8b37e6803d1eb1e

              dd-63257   [001] ..... 83742.427755: nfs_analyze_dio: WRITE offset=47008 len=47008 start=47008+2144 middle=49152+40960 end=90112+3904
              dd-63257   [001] ..... 83742.427758: nfs_initiate_write: fileid=00:2e:219750 fhandle=0xf6927a01 offset=47008 count=2144 stable=UNSTABLE
              dd-63257   [001] ..... 83742.427760: nfs_initiate_write: fileid=00:2e:219750 fhandle=0xf6927a01 offset=49152 count=40960 stable=UNSTABLE
  kworker/u193:4-63221   [004] ..... 83742.427761: nfs_writeback_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=47008 count=2144 res=2144 stable=UNSTABLE verifier=a8b37e6803d1eb1e
              dd-63257   [001] ..... 83742.427763: nfs_initiate_write: fileid=00:2e:219750 fhandle=0xf6927a01 offset=90112 count=3904 stable=UNSTABLE
  kworker/u193:4-63221   [004] ..... 83742.427763: xfs_file_direct_write: dev 259:22 ino 0x5e0000a3 disize 0xb7a0 pos 0xc000 bytecount 0xa000
  kworker/u193:4-63221   [004] ..... 83742.427783: nfs_writeback_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=49152 count=40960 res=40960 stable=UNSTABLE verifier=a8b37e6803d1eb1e
  kworker/u193:3-62985   [011] ..... 83742.427788: nfs_writeback_done: error=0 fileid=00:2e:219750 fhandle=0xf6927a01 offset=90112 count=3904 res=3904 stable=UNSTABLE verifier=a8b37e6803d1eb1e

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c   | 89 ++++++++++++++++++++++++++++++++++++++++++++---
 fs/nfs/internal.h |  1 +
 2 files changed, 85 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index ba644daa5e14..a4f6827072c5 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -1043,11 +1043,19 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 		if (result < 0)
 			break;
 
-		bytes = result;
-		npages = (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
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
+			bool issue_dio_now = false;
 
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
 							pgbase, pos, req_len);
@@ -1063,6 +1071,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			}
 
 			pgbase = 0;
+			result -= req_len;
 			bytes -= req_len;
 			requested_bytes += req_len;
 			pos += req_len;
@@ -1072,9 +1081,27 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 				continue;
 			}
 
+			/* Looking ahead, is this req the end of the start or middle? */
+			if (bytes == 0) {
+				if ((dreq->start_len &&
+				     pos == dreq->middle_offset && result >= dreq->middle_len) ||
+				    (dreq->end_len &&
+				     pos == dreq->end_offset && result == dreq->end_len)) {
+					desc.pg_doio_now = 1;
+					issue_dio_now = true;
+					/* Reset iter to the last boundary, isse the current
+					 * req and then handle iter to next boundary or end.
+					 */
+					iov_iter_revert(iter, result);
+				}
+			}
+
 			nfs_lock_request(req);
-			if (nfs_pageio_add_request(&desc, req))
+			if (nfs_pageio_add_request(&desc, req)) {
+				if (issue_dio_now)
+					break;
 				continue;
+			}
 
 			/* Exit on hard errors */
 			if (desc.pg_error < 0 && desc.pg_error != -EAGAIN) {
@@ -1115,6 +1142,55 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	return requested_bytes;
 }
 
+/*
+ * If localio_O_DIRECT_align_misaligned_WRITE enabled, split misaligned
+ * WRITE to a DIO-aligned middle and misaligned head and/or tail.
+ */
+static bool nfs_analyze_write_dio(loff_t offset, __u32 len,
+				  struct nfs_direct_req *dreq)
+{
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+	/* Hardcoded to PAGE_SIZE (since don't have LOCALIO nfsd_file's
+	 * dio_alignment), works for smaller alignment too (e.g. 512b).
+	 */
+	u32 dio_blocksize = PAGE_SIZE;
+	loff_t start_end, orig_end, middle_end;
+	ssize_t start_len = len;
+	bool aligned = true;
+
+	if (!nfs_localio_O_DIRECT_align_misaligned_IO())
+		return false;
+
+	if (unlikely(len < dio_blocksize)) {
+		dreq->io_start = offset;
+		dreq->max_count = len;
+		aligned = false;
+		goto out;
+	}
+
+	start_end = round_up(offset, dio_blocksize);
+	start_len = start_end - offset;
+	orig_end = offset + len;
+	middle_end = round_down(orig_end, dio_blocksize);
+
+	dreq->io_start = offset;
+	dreq->max_count = orig_end - offset;
+
+	dreq->start_len = start_len;
+	dreq->middle_offset = start_end;
+	dreq->middle_len = middle_end - start_end;
+	dreq->end_offset = middle_end;
+	dreq->end_len = orig_end - middle_end;
+out:
+	trace_nfs_analyze_dio(WRITE, offset, len, offset, start_len,
+			      dreq->middle_offset, dreq->middle_len,
+			      dreq->end_offset, dreq->end_len);
+	return aligned;
+#else
+	return false;
+#endif
+}
+
 /**
  * nfs_file_direct_write - file direct write operation for NFS files
  * @iocb: target I/O control block
@@ -1171,9 +1247,12 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 	if (!dreq)
 		goto out;
 
+	if (swap || !nfs_analyze_write_dio(pos, count, dreq)) {
+		dreq->max_count = count;
+		dreq->io_start = pos;
+	}
+
 	dreq->inode = inode;
-	dreq->max_count = count;
-	dreq->io_start = pos;
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6ab9d345518a..d07dc3e6316d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -995,6 +995,7 @@ struct nfs_direct_req {
 	struct bio_vec *        start_extra_bvec;
 	loff_t			middle_offset;	/* Offset for start of DIO-aligned middle */
 	loff_t			end_offset;	/* Offset for start of DIO-aligned end */
+	ssize_t			start_len;	/* Length for misaligned first page */
 	ssize_t			middle_len;	/* Length for DIO-aligned middle */
 	ssize_t			end_len;	/* Length for misaligned last page */
 };
-- 
2.44.0


