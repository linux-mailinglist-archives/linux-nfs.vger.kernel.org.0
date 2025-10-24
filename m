Return-Path: <linux-nfs+bounces-15594-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 170F2C06C02
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 16:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAFA94EC609
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Oct 2025 14:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224831CA4E;
	Fri, 24 Oct 2025 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GViSMq9i"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50231B823
	for <linux-nfs@vger.kernel.org>; Fri, 24 Oct 2025 14:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761316997; cv=none; b=f0kHtwoNnDYzS5Ayf3uztepJEiSGHiGj9ja4beB1DcVWqftL++XBWnv66oCk3Irx4obGUwN9bgFEyUmazBZ3tD6ML9Vf6h1cMINon3IkR/9gIfwDhJ3ftUw4CW91VZjrL0baA9PpytsQoXpICIWTMjVYzarRN8DVj1apnjazIgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761316997; c=relaxed/simple;
	bh=XcCxOhbQuP5Q7R4rOpgIw1/ty72tnpNjzShHR8nwm+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbKLveNDV1BcwkHxvZoPEz4hfRsnzovpaanveY4OaPlbpNrelWEGvC8qEcxazJQvLJmWE2oM0yNMzKl4YUPWNyFRmP4KQAnmLJS7KQ2+ZKvxsZlE+GnlsS8JjOr7d26RS2OD+fpkOVOiDwhDie24CKzXVQtNwn1VVNeZaDdO2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GViSMq9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46413C116B1;
	Fri, 24 Oct 2025 14:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761316996;
	bh=XcCxOhbQuP5Q7R4rOpgIw1/ty72tnpNjzShHR8nwm+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GViSMq9iXuq4Tdle0RLmFWscfRTONO4TTN1gCudJzcgS433zt6nLpuThyPNHMRvFs
	 m83xXUDOFaJG4iB6ZgM3MIIaJiYHLMPmW9u6miNHqHbpFCufykzPttg+FczgpIeQrC
	 WPmNpgi1XOYOkmd0QpT3jRqkGajkPrZad7SusEpAoWVB5RZHUUFHxOXKPtoWrdr29T
	 2vnQzQLotBQ8OWQYz616vDInRO5TSVynSBEki1c4VUn6cI+uzPOge4xxv+vsQ5EvqE
	 8VXZgtn4cC9EuA4lSfglm1vj5YjaPOK5OFVkymQ6WjjfZxHvEIO68Y2jRJBFf8+ytc
	 0acxJex150g4g==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v7 10/14] NFSD: Clean up synopsis of nfsd_iov_iter_aligned_bvec()
Date: Fri, 24 Oct 2025 10:43:02 -0400
Message-ID: <20251024144306.35652-11-cel@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024144306.35652-1-cel@kernel.org>
References: <20251024144306.35652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Clean up: Keep the specifics of the alignment checking inside of
nfsd_iov_iter_aligned_bvec(). Move the calculations of the alignment
parameters into the function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index f6810630bb65..e7c3458bd178 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1285,8 +1285,9 @@ nfsd_is_write_dio_possible(loff_t offset, unsigned long len,
 }
 
 static bool
-nfsd_iov_iter_aligned_bvec(const struct iov_iter *i, unsigned int addr_mask)
+nfsd_iov_iter_aligned_bvec(const struct nfsd_file *nf, const struct iov_iter *i)
 {
+	unsigned int addr_mask = nf->nf_dio_mem_align - 1;
 	const struct bio_vec *bvec = i->bvec;
 	size_t skip = i->iov_offset;
 	size_t size = i->count;
@@ -1333,9 +1334,7 @@ nfsd_setup_write_dio_iters(struct iov_iter **iterp, bool *iter_is_dio_aligned,
 		iov_iter_advance(&iters[n_iters], write_dio->start_len);
 	iters[n_iters].count -= write_dio->end_len;
 	iter_is_dio_aligned[n_iters] =
-		nfsd_iov_iter_aligned_bvec(&iters[n_iters],
-					   nf->nf_dio_mem_align - 1,
-					   nf->nf_dio_offset_align - 1);
+		nfsd_iov_iter_aligned_bvec(nf, &iters[n_iters]);
 	if (unlikely(!iter_is_dio_aligned[n_iters]))
 		return 0; /* no DIO-aligned IO possible */
 	++n_iters;
-- 
2.51.0


