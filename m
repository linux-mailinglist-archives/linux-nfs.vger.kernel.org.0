Return-Path: <linux-nfs+bounces-15700-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D98E1C0F1F2
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 17:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9683B179E
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Oct 2025 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3142331A7E6;
	Mon, 27 Oct 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwvgZ1xn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D57431A7F8
	for <linux-nfs@vger.kernel.org>; Mon, 27 Oct 2025 15:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580002; cv=none; b=J8FBYywTMY3VuPMG8GyFZ9Up/yxDIQHeavCkxynnELy/oOmvN6+qkdJaGuSbYRgFwFOlK/P3LX+DC6gn+ROdP+WiSMAByJfLbB308hM31Ly0IfnEemgNuh5jclbqXFPlFulbKXminu0rL0q9YfJDgBqilboYVwZrB/AvxCIlXrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580002; c=relaxed/simple;
	bh=4jC58G4qZSOSF/xmijGOlC71TOsztZpZsiCKbMpAkfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T5ALI2NSu8ZgAdbNNZphOKj8UEHE34cF9AHd6YshB3Fgdzfe6SLvttYZUnXljqvyrIqseUJMkdu/Ia63bD0ymMVHh8cTgEm97T/e1OJfQeff24IxeM6fDNr5O86CDz387VRxrPEdU39oFRnhquVyCZ4H0vPGcmtkghB359bOufw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwvgZ1xn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF95FC113D0;
	Mon, 27 Oct 2025 15:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761580001;
	bh=4jC58G4qZSOSF/xmijGOlC71TOsztZpZsiCKbMpAkfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwvgZ1xndxj6PTRPJr0cRLNf5ziX9G5XIesYSZzg4ju3cHnmke1T7MRnt5QoENhxR
	 JK19hiVuw82nWFIBXEVm8766bLWzT0VWmOvCEc7DfI09w85T4bE6/xneyHL4H87xV2
	 0hxa54yJ5phY++SwdPV0hDun4G9mtMPgSR3gKpwwkSFD9B1W9GF1heV9ENlTwCoRLm
	 9X2Aiq1QJqwuVQvzkRKqCYeUNPMGDZmMmpGoMx69dMWOLRxu629YcnsyjS3heVhKqM
	 4y0hY0vsbAmr1j5vnlekxBvYY+h86K/gRqcfrRDhMM4M5y1VO8bCzv2n0SgwgqJEPO
	 iwP8uslKRgCEg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v8 08/12] NFSD: Simplify nfsd_iov_iter_aligned_bvec()
Date: Mon, 27 Oct 2025 11:46:26 -0400
Message-ID: <20251027154630.1774-9-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027154630.1774-1-cel@kernel.org>
References: <20251027154630.1774-1-cel@kernel.org>
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


