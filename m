Return-Path: <linux-nfs+bounces-13441-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F60B1BA6C
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AC9188E1EE
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD56299944;
	Tue,  5 Aug 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZByf8shJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872DB25394C
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419471; cv=none; b=g7TfkSkn4ui8x2OE4NCsVo0/XI11XUslTS/Kj6q7YH728yOwTTrai3YfsEe2M6Qee8hGwNLytU734MWYxad0Aj1d9988Kntc4KuBUHfaWTZkk1yGsbRor9TKht0HZAejXErs/Yg0gtEGgIon5VBHi4GjW9x/K3As/IR+ahtQv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419471; c=relaxed/simple;
	bh=Phetx1Z0yj6+Gkn9ZxDbDyywbvLSkhkFuvJZYSc2wiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d656Oj03kdk81mPlOJn5X0vtnQRFdxVtsPD+RyLuGFhQnnQ0z5KN4m13CDvLAP4GKH2IsuJe7c/Ag5XRZYNPmSg0vQEv8Fb36oMaWOgsFalvUtN8cI60HW987/nMmcsx/UrF8ysWLNgIMmdeQDlh1V2VAv0EoaFL8wBFKjnwA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZByf8shJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4401C4CEF0;
	Tue,  5 Aug 2025 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419471;
	bh=Phetx1Z0yj6+Gkn9ZxDbDyywbvLSkhkFuvJZYSc2wiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZByf8shJmE/gcYYoDeKJzLUfiWxeeuehL80ZP8wy77Qhz6jxm5tmyXbNtUmb1jeoH
	 KSvTCdw5ml57LVu49YkoKPiEjSvbqGqWcXFyjkFIsOkuQY3vSjJwaZl149fmVQz16W
	 3OYw2xh67frni9x3nqwk4AcIl3qJR7HLupjvvQV01ezb2gKM5gb070SNymqd9Zdgxp
	 QavUyGOKN3WGXLYYDbRtFOwF1HO+fano9OWkgH1AyXyd9C8DBFwjb0wwuvPKhW/SNp
	 E++SZbHVuOCcZPmp8oy69E5fYfGSnMyNn78pD5VapO4npFIKGPQvV5JDqD4D2AvDYy
	 kRuZ3D6BvU6CA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 1/4] NFSD: avoid using iov_iter_is_aligned() in nfsd_iter_read()
Date: Tue,  5 Aug 2025 14:44:25 -0400
Message-ID: <20250805184428.5848-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805184428.5848-1-snitzer@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Check the bvec is DIO-aligned while creating it, saves CPU cycles by
avoiding iterating the bvec elements a second time using
iov_iter_is_aligned().

This prepares for Keith Busch's near-term removal of the
iov_iter_is_aligned() interface.  This fixes cel/nfsd-testing commit
5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is
misaligned") and it should be folded into that commit so that NFSD
doesn't require iov_iter_is_aligned() while it is being removed
upstream in parallel.

Fixes: cel/nfsd-testing 5d78ac1e674b4 ("NFSD: issue READs using O_DIRECT even if IO is misaligned")
Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/vfs.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 46189020172fb..e1751d3715264 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1226,7 +1226,10 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			 */
 			offset = read_dio.start;
 			in_count = read_dio.end - offset;
-			kiocb.ki_flags = IOCB_DIRECT;
+			/* Verify ondisk DIO alignment, memory addrs checked below */
+			if (likely(((offset | in_count) &
+				    (nf->nf_dio_read_offset_align - 1)) == 0))
+				kiocb.ki_flags = IOCB_DIRECT;
 		}
 	} else if (nfsd_io_cache_read == NFSD_IO_DONTCACHE)
 		kiocb.ki_flags = IOCB_DONTCACHE;
@@ -1236,16 +1239,24 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	v = 0;
 	total = in_count;
 	if (read_dio.start_extra) {
-		bvec_set_page(&rqstp->rq_bvec[v++], read_dio.start_extra_page,
+		bvec_set_page(&rqstp->rq_bvec[v], read_dio.start_extra_page,
 			      read_dio.start_extra, PAGE_SIZE - read_dio.start_extra);
+		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
+			     rqstp->rq_bvec[v].bv_offset & (nf->nf_dio_mem_align - 1)))
+			kiocb.ki_flags &= ~IOCB_DIRECT;
 		total -= read_dio.start_extra;
+		v++;
 	}
 	while (total) {
 		len = min_t(size_t, total, PAGE_SIZE - base);
-		bvec_set_page(&rqstp->rq_bvec[v++], *(rqstp->rq_next_page++),
-			      len, base);
+		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++), len, base);
+		/* No need to verify memory is DIO-aligned since bv_offset is 0 */
+		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) && base &&
+			     (base & (nf->nf_dio_mem_align - 1))))
+			kiocb.ki_flags &= ~IOCB_DIRECT;
 		total -= len;
 		base = 0;
+		v++;
 	}
 	if (WARN_ONCE(v > rqstp->rq_maxpages,
 		      "%s: v=%lu exceeds rqstp->rq_maxpages=%lu\n", __func__,
@@ -1256,16 +1267,6 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!host_err) {
 		trace_nfsd_read_vector(rqstp, fhp, offset, in_count);
 		iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, in_count);
-
-		/* Double check nfsd_analyze_read_dio's DIO-aligned result */
-		if (unlikely((kiocb.ki_flags & IOCB_DIRECT) &&
-			     !iov_iter_is_aligned(&iter,
-				nf->nf_dio_mem_align - 1,
-				nf->nf_dio_read_offset_align - 1))) {
-			/* Fallback to buffered IO */
-			kiocb.ki_flags &= ~IOCB_DIRECT;
-		}
-
 		host_err = vfs_iocb_iter_read(file, &kiocb, &iter);
 	}
 
-- 
2.44.0


