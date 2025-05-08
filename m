Return-Path: <linux-nfs+bounces-11604-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73EAB018B
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C622BB24783
	for <lists+linux-nfs@lfdr.de>; Thu,  8 May 2025 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4EF262FEC;
	Thu,  8 May 2025 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dx9N6Usa"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA1A213E8B
	for <linux-nfs@vger.kernel.org>; Thu,  8 May 2025 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725864; cv=none; b=iDxHoeQTFM90nkL5ERs77HkQ/+r52ccWuRU/HwuWr3BhB7kvkSmm6zr3fn7+tnaNf9X8NPvRTTZ9y76ooazi7rSTyeAl/Y30l/M8uK4FPgKCH0sEQuF+M1L22EeDtNIYGqtR4iWSAxn6RWOL6gVyjW1NQRfLBTLpsAwMgEsH4N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725864; c=relaxed/simple;
	bh=mC7txgzqvC4mHEYa2I90JjaCeywya+h19AS+HqaGBEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0eAZLSZ9FJfUtYPLi7A/uIn2dmW7HlIvWKk3F+nEWuU+ccbOLq7DP71RAn9cFxEanuqPKHs6XzetcZ8TfJhzOzLLjwWg30TgzC87psDVdt4c/gi3GJCikn5Q65CTKoqt8MWjcdFr7gyxQi8Qa/Cg+LOrFH/F0NtSPMGA/tXPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dx9N6Usa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD42C4CEEE;
	Thu,  8 May 2025 17:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746725863;
	bh=mC7txgzqvC4mHEYa2I90JjaCeywya+h19AS+HqaGBEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dx9N6UsaTP6oUEeXNp5+3tsfoUa3wLvaVUrbGErFTdBDZhHp8CY9OTvVN0Ak3OHhd
	 9l17j/wBcImLu4EDFYZIHvXfUDEMt/PAXiKuVqgwb6uOAnDhXW64wfH+y8PuuI08gw
	 2f+PmZj9ZVhOKre9Vj7gbmqhRi1kACPRxnwocdPrLdMcnNRgqk+q/NCv+0TdxK9Y/c
	 T2DH3if0CyGJvULshZMPH7iGgm5vgkxiC6V+SxgCya27vi3yg5GPsTh627OPh7P94A
	 4Sk+qlcFp7m4iU2Ll0tZz2rER5MJ5Jd0brkvlb8EsxJW0rhc0EWz2RZMULhKFo2v5Z
	 zdstYKsLo5blA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 1/6] NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
Date: Thu,  8 May 2025 13:37:35 -0400
Message-ID: <20250508173740.5475-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508173740.5475-1-cel@kernel.org>
References: <20250508173740.5475-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

If we can get rid of all uses of rq_vec, then it can be removed.
Replace one use of rqstp::rq_vec with rqstp::rq_bvec.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index c5370d14cbfc..f964fd393f8a 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1083,23 +1083,23 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	unsigned long v, total;
 	struct iov_iter iter;
 	loff_t ppos = offset;
-	struct page *page;
 	ssize_t host_err;
+	size_t len;
 
 	v = 0;
 	total = *count;
 	while (total) {
-		page = *(rqstp->rq_next_page++);
-		rqstp->rq_vec[v].iov_base = page_address(page) + base;
-		rqstp->rq_vec[v].iov_len = min_t(size_t, total, PAGE_SIZE - base);
-		total -= rqstp->rq_vec[v].iov_len;
+		len = min_t(size_t, total, PAGE_SIZE - base);
+		bvec_set_page(&rqstp->rq_bvec[v], *(rqstp->rq_next_page++),
+			      len, base);
+		total -= len;
 		++v;
 		base = 0;
 	}
 	WARN_ON_ONCE(v > rqstp->rq_maxpages);
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
 	host_err = vfs_iter_read(file, &iter, &ppos, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
-- 
2.49.0


