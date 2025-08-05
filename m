Return-Path: <linux-nfs+bounces-13457-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E8AB1BD10
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Aug 2025 01:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83100181B1A
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 23:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82752BDC20;
	Tue,  5 Aug 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5dpDRX/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0129C347
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 23:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754436083; cv=none; b=En9w/MtZeR18Qn+1UtswkXIFUKgwUy0FzseAubkItZVlXgNB1/dJDtJ7rLZ+RKSKLhRrCiymYse1+AxazTlJS80vmpB2PnXmZ97K4MyJZ9iO3C2dNUy17/314m1HcFOWFbuI0nxKiXGs5Xm7wkHNbEGLLf3yFqlPkVz7Bw3fgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754436083; c=relaxed/simple;
	bh=XlxOu9NQHyJ1Etv8miW/JeCLHIfPV/bizUgCEad3Qxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qkWkMVT4QrJYLSGpk8t4tetncydOLKqJoLX0h8mdMWg+X9BX8bzOEbCfkL0OVB8QZxFvz7QhpCigjo+ilvn58SHZpnPS5XsWjtzT7ioob5VQP1rjMaemID0twnwBMRbORRxofQDRDrbYQQwkz0SWy8xocH+RyiczpOZPK29kf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5dpDRX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0962AC4CEF4;
	Tue,  5 Aug 2025 23:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754436083;
	bh=XlxOu9NQHyJ1Etv8miW/JeCLHIfPV/bizUgCEad3Qxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V5dpDRX/SdMSckRqwYa3vxTgItBFhvqL1aoPTpfxWbGzXyhYadNwUbTX2Q6anaVGQ
	 PPMfwoLit2ffTCVUX7cygk6yEr4lLtJyh07f8rZUyRhmJKcFuFGqhZz+vLR2Mkj3LM
	 lQlIB/Jc96nHLJ1qno+Mq/IFu/otJrD+SLD1/VVh35jvKq7Pd5WfATcBrBNQEQ7RPw
	 JNJEDEvz1Ksy/V0HEnrGIVxP5fuJdO7SWcUQiHoG41iQWHn3gvtEyVI/UHy602QLLG
	 Hc/kJm/cLFHMaPjXwrlI+QjEYYaB/UHaFXoa9dVxlhRSqGd4RFMBs9IzW74ezbZI8k
	 knbyaNryFZe0A==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v7 10/11] nfs/direct: add misaligned WRITE handling
Date: Tue,  5 Aug 2025 19:21:05 -0400
Message-ID: <20250805232106.8656-11-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805232106.8656-1-snitzer@kernel.org>
References: <20250805232106.8656-1-snitzer@kernel.org>
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
nfs_analyze_write_dio trace event shows how the NFS client splits a
given misaligned IO into a mix of misaligned page(s) and a DIO-aligned
extent.

This combination of trace events is useful for LOCALIO WRITEs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_analyze_write_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

Which for this dd command:

  dd if=/dev/zero of=/mnt/share1/test bs=47008 count=2 oflag=direct

Results in:
              dd-34927   [042] ..... 39070.896951: nfs_analyze_write_dio: fileid=00:2e:1739 fhandle=0x9b43f225 offset=0 count=47008 start=0+0 middle=0+45056 end=45056+1952
              dd-34927   [042] ..... 39070.896958: nfs_initiate_write: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=0 count=45056 stable=UNSTABLE
              dd-34927   [042] ..... 39070.896961: nfs_initiate_write: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=45056 count=1952 stable=UNSTABLE
  kworker/u194:3-33963   [029] ..... 39070.896963: xfs_file_direct_write: dev 259:16 ino 0x3e00008f disize 0x0 pos 0x0 bytecount 0xb000
  kworker/u194:3-33963   [029] ..... 39070.896999: nfs_writeback_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=0 count=45056 res=45056 stable=UNSTABLE verifier=73268c6866702410
  kworker/u194:0-34670   [041] ..... 39070.897005: nfs_writeback_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=45056 count=1952 res=1952 stable=UNSTABLE verifier=73268c6866702410

              dd-34927   [042] ..... 39070.897083: nfs_analyze_write_dio: fileid=00:2e:1739 fhandle=0x9b43f225 offset=47008 count=47008 start=47008+2144 middle=49152+40960 end=90112+3904
              dd-34927   [042] ..... 39070.897093: nfs_initiate_write: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=47008 count=2144 stable=UNSTABLE
              dd-34927   [042] ..... 39070.897096: nfs_initiate_write: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=49152 count=40960 stable=UNSTABLE
              dd-34927   [042] ..... 39070.897098: nfs_initiate_write: fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=90112 count=3904 stable=UNSTABLE
  kworker/u194:0-34670   [041] ..... 39070.897098: nfs_writeback_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=47008 count=2144 res=2144 stable=UNSTABLE verifier=73268c6866702410
  kworker/u194:3-33963   [029] ..... 39070.897099: xfs_file_direct_write: dev 259:16 ino 0x3e00008f disize 0xb7a0 pos 0xc000 bytecount 0xa000
  kworker/u194:3-33963   [029] ..... 39070.897120: nfs_writeback_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=49152 count=40960 res=40960 stable=UNSTABLE verifier=73268c6866702410
  kworker/u194:0-34670   [041] ..... 39070.897124: nfs_writeback_done: error=0 fileid=00:2e:1739 fhandle=0x4d34e6c1 offset=90112 count=3904 res=3904 stable=UNSTABLE verifier=73268c6866702410

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 118782070c5e8..96999184453fb 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -1046,11 +1046,19 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
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
@@ -1066,6 +1074,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			}
 
 			pgbase = 0;
+			result -= req_len;
 			bytes -= req_len;
 			requested_bytes += req_len;
 			pos += req_len;
@@ -1075,9 +1084,27 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
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
@@ -1118,6 +1145,48 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 	return requested_bytes;
 }
 
+/*
+ * If localio_O_DIRECT_align_misaligned_WRITE enabled, split misaligned
+ * WRITE to a DIO-aligned middle and misaligned head and/or tail.
+ */
+static bool nfs_analyze_write_dio(loff_t offset, ssize_t len,
+				  struct nfs_direct_req *dreq)
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
+	trace_nfs_analyze_write_dio(offset, len, dreq);
+	return true;
+#else
+	return false;
+#endif
+}
+
 /**
  * nfs_file_direct_write - file direct write operation for NFS files
  * @iocb: target I/O control block
@@ -1175,8 +1244,11 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	dreq->max_count = count;
-	dreq->io_start = pos;
+	if (swap || !nfs_analyze_write_dio(pos, count, dreq)) {
+		dreq->max_count = count;
+		dreq->io_start = pos;
+	}
+
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
-- 
2.44.0


