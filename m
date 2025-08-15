Return-Path: <linux-nfs+bounces-13695-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8291CB288CA
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE6D189EDF6
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E92D0C9C;
	Fri, 15 Aug 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkSiTnTe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02882D0C81
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300614; cv=none; b=W72qvKhnMejsIGxJOJi1aOJXc+geWYtnSEyuHlroKCH1ybnKbNVJSiJqFYy68IFDQC+470Z3vHqQKXCdS+7zAbevPx6SDygmGBho24waqmLdj3kISkEfQxITKrzh2bu9kQa3diFC38+iKUHxJZABKyvQ1OjPo4sO/1AQymEjaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300614; c=relaxed/simple;
	bh=qsOSt13IrXuB4iSa9jSdFRNAyW2lCNWN3geLmMFOamc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU0rqN30W7dz+zI9TujWjpCYg8luEM0lSxJVQjVUyAq365zfxKcCOeuYyfpom1l2Q1I+hx10WmBNZ/XpfEr44eKI1JECP7+FqgrWa13MLjQbj6KZ/IhSPNQeAVpVm2OyBz8UUv33gC44GWhECu/IiEVYYUMgZr5fd68hDdkpo0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkSiTnTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AABC4CEEB;
	Fri, 15 Aug 2025 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300614;
	bh=qsOSt13IrXuB4iSa9jSdFRNAyW2lCNWN3geLmMFOamc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MkSiTnTet1poonkFjuceFwwRW612Dms/PXPKCOR7cVIgojVCDIqJTXMrUHoqhgMSd
	 XATGKdF3QtRF3DEvPYZ0h8AdINoGKT3iciY8GVpLfrWExViODsr1lBgeHZCrcstjO3
	 u99aUZvPTVDBB1+jCamemQeYClSixEXLa/1OrUyOcJtu36VkhdiZWXnvgJ7P0nvVoH
	 5B9BN4dWYDKBkVFubu3EJtYUxZpTqwQ/r2I7b2LbSTGd/86qGZeFZW02EJK3dKDS3Y
	 6YHvdyqxreIzxlz+SQY9Xxs1jE+CKxQvA7MfscLPfEzmWdP0Xt+p1dyoZtP9u9ACTz
	 efpAu2oI+htzw==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 7/9] nfs/direct: add misaligned WRITE handling
Date: Fri, 15 Aug 2025 19:30:01 -0400
Message-ID: <20250815233003.55071-8-snitzer@kernel.org>
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

When enabled, a misaligned DIO WRITE is split into a head, middle and
tail as needed. The large middle extent is DIO-aligned and the head
and/or tail are misaligned (due to each being a partial page).

The misaligned head and/or tail extents are issued using buffered IO
and the DIO-aligned middle is issued using O_DIRECT.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index fc011571c5d29..3803289a94793 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -963,8 +963,15 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
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
@@ -983,6 +990,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			}
 
 			pgbase = 0;
+			result -= req_len;
 			bytes -= req_len;
 			requested_bytes += req_len;
 			pos += req_len;
@@ -992,9 +1000,28 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 				continue;
 			}
 
+			/* Issue IO if this req was the end of the start or middle */
+			if (bytes == 0) {
+				if ((dreq->start_len &&
+				     pos == dreq->middle_offset && result >= dreq->middle_len) ||
+				    (dreq->end_len &&
+				     pos == dreq->end_offset && result == dreq->end_len))
+					desc.pg_doio_now = 1;
+			}
+
 			nfs_lock_request(req);
-			if (nfs_pageio_add_request(&desc, req))
+			if (nfs_pageio_add_request(&desc, req)) {
+				if (desc.pg_doio_now) {
+					/* Reset and handle iter to next aligned boundary */
+					iov_iter_revert(iter, result);
+					desc.pg_doio_now = 0;
+					break;
+				}
 				continue;
+			}
+
+			if (unlikely(desc.pg_doio_now))
+				desc.pg_doio_now = 0;
 
 			/* Exit on hard errors */
 			if (desc.pg_error < 0 && desc.pg_error != -EAGAIN) {
@@ -1092,8 +1119,11 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	dreq->max_count = count;
-	dreq->io_start = pos;
+	if (swap || !nfs_analyze_dio(pos, count, dreq)) {
+		dreq->max_count = count;
+		dreq->io_start = pos;
+	}
+
 	dreq->ctx = get_nfs_open_context(nfs_file_open_context(iocb->ki_filp));
 	l_ctx = nfs_get_lock_context(dreq->ctx);
 	if (IS_ERR(l_ctx)) {
-- 
2.44.0


