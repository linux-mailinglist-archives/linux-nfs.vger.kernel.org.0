Return-Path: <linux-nfs+bounces-15942-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9DC2D457
	for <lists+linux-nfs@lfdr.de>; Mon, 03 Nov 2025 17:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 835D14E8074
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Nov 2025 16:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5DC3191D1;
	Mon,  3 Nov 2025 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSg+9Ro6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563633195EC
	for <linux-nfs@vger.kernel.org>; Mon,  3 Nov 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188842; cv=none; b=sEu03ViNtxoq5Iu5ibLGSO4NlvN7Y9ZnAwo9U0L4fyN1yVDsg3chsibQnEfuRq4qnO1aJSBuke9AxNqzxeRiKbu6wgDXB5mud5zlrZ6DyfeaioNXz49OhbCKGP0zS2fUShA/37RzkIZwIIBL23k0q/yO9lm90O97lwJ7/IGnZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188842; c=relaxed/simple;
	bh=ufsqCLhgLz590I+8JCjbhHHCNBKW8d/LMrqC1VXA27o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qG7JGQoPyEl98vUz4htKOzcCGAGSguJxNPiIYq7RiT1RvvxTmq6I97OzxUZ3LMy7CBWfx87hrPVx6ANc0zdFsr0vnz+Qsf+GSWErmZSqiff0uyM33ZGaOlxbYKDSYLGGCmD1+hd9iLzWpF372K54Pnlxo1uPGO0HWYIoTB55hT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSg+9Ro6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33810C116D0;
	Mon,  3 Nov 2025 16:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762188841;
	bh=ufsqCLhgLz590I+8JCjbhHHCNBKW8d/LMrqC1VXA27o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YSg+9Ro6FdZPdRF2a+ucugGqY9Sr3M8sXVBb1zUeNTtF4Xqw0c9AbVAbB8KepM6gN
	 BEjWG8QTkjRr7JlqAOPWjxmHGtxFSk8r7K5S1VckW/AcbB8r1Uxb+rohiX/CYPSAuA
	 Fd5ih916t0bCSsaB5uMDQLdPCwA3gGWPoDrEfpdOHf6Y5qHxV2aFvzjjMSKYND5qwr
	 gOMvb9OXnRcGS/IR6umCCkdKXY/JockWYwCfOL/IXtsCLlSFegFjkdPci1JdSXKa6J
	 7GnO1ImG4VjZBqPF33CYYCaTNFy/9TYJ9Yqekiw0bRwSCNKrzdFgueSOH69k8B+7tJ
	 Vr/3YY/Yh3yhQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 08/12] NFSD: Simplify nfsd_iov_iter_aligned_bvec()
Date: Mon,  3 Nov 2025 11:53:47 -0500
Message-ID: <20251103165351.10261-9-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103165351.10261-1-cel@kernel.org>
References: <20251103165351.10261-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Pages in the RPC receive buffer are contiguous. Practically
speaking, this means that, after the first bvec, the bv_offset
field is always zero.

The loop in nfsd_iov_iter_aligned_bvec() also sets "skip" to zero
after the first bvec is checked. Thus, for bvecs following the first
one, bv_offset = 0 and skip = 0, and the check becomes:

  (0 + 0) & addr_mask = 0

This always passes regardless of the alignment mask.

Since all bvecs after the first one start at bv_offset zero (page-
aligned), they are inherently aligned for DIO. Therefore, only the
first bvec needs to be checked for DIO alignment.

Note that for RDMA transports, the incoming payload always starts on
page alignment, since svcrdma sets up the RDMA Read sink buffers
that way. For RDMA, this loop visits every bvec in each payload, and
never finds an unaligned bvec.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5d6efcceb8c9..37353fb48d58 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1288,30 +1288,20 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 	return true;
 }
 
+/*
+ * Check if the bvec iterator is aligned for direct I/O.
+ *
+ * bvecs generated from RPC receive buffers are contiguous: After the first
+ * bvec, all subsequent bvecs start at bv_offset zero (page-aligned).
+ * Therefore, only the first bvec is checked.
+ */
 static bool
 nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
 {
-	unsigned int len_mask = nf->nf_dio_offset_align - 1;
 	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
 	const struct bio_vec *bvec = i->bvec;
-	size_t skip = i->iov_offset;
-	size_t size = i->count;
 
-	if (size & len_mask)
-		return false;
-	do {
-		size_t len = bvec->bv_len;
-
-		if (len > size)
-			len = size;
-		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
-			return false;
-		bvec++;
-		size -= len;
-		skip = 0;
-	} while (size);
-
-	return true;
+	return !((unsigned long)(bvec->bv_offset + i->iov_offset) & addr_mask);
 }
 
 static void
-- 
2.51.0


