Return-Path: <linux-nfs+bounces-11570-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44403AAE293
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 16:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668289C729D
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C2202C26;
	Wed,  7 May 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtFIvMLT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB522E40E
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626853; cv=none; b=GYy8Jy+RkMfv8EZ3BsS5xzN1/flUKgkpG9OCgLxowIHsm+OtbXjUYZ2kQQH+BjwaOMroyGAhyw0rBpeBAJ8ylRzqpAJ0q/yBsYGIoONtYZR5DyO4w8mD6EYamrYWoTGBPhHpUvSAli0SJ6dFPRwWKg6zOGsbgRLBPNFzsDVnI6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626853; c=relaxed/simple;
	bh=cICiQsn19O86a0usu+CGYL9ZPazJ2V6kxWOq8qtaUAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jf+nl2q7U0e0rjpWh6rhF6OGG8n/GFEduRyI8+oFNXTomBCZ2QXBR/fSjd1uoL2iLu9HVw4edP31j9dM4mSLjBtGDgEblPC/xlYJIe1abbQnepft7KilxJKaUrSR0Ph1iG/Rzu6yZ6+rrC0yM2yK39/EU5DDGrGnuA7+jp/jlCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtFIvMLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54292C4CEEE;
	Wed,  7 May 2025 14:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746626853;
	bh=cICiQsn19O86a0usu+CGYL9ZPazJ2V6kxWOq8qtaUAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtFIvMLTr2kQFGPOBWpSFGb4IjmCZvIeMYlew69Xpe/QYyfpKpJo54zUffas0Kj6X
	 k6n8MdI675jspt63fMwQ8lef3wFkQDW4Hr169+shiW9w9lJ8r2hAHjEFzqSSCIVQjE
	 sijOJ2+L/ayI1W92+6keEzsOnoGwrCYPUXwDQ7gpzPKnf5SwXw1q4zFKpLdXV+RPUv
	 lorgwEuTDNQyYvMdt+LUL9rw1oXw0ArA4T18kN9tjAX5mAxGAYpe/LTxDPyuJyVYGc
	 bkF4HJhOUZyfx4s/VTa8CbqAU9KvQB6EDhc87OaoeSF6Shb7FRZgOAruSfxOy9g9Px
	 OojS9Dcsjz7DA==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v1 1/4] NFSD: Use rqstp->rq_bvec in nfsd_iter_read()
Date: Wed,  7 May 2025 10:07:25 -0400
Message-ID: <20250507140728.6497-2-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507140728.6497-1-cel@kernel.org>
References: <20250507140728.6497-1-cel@kernel.org>
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/vfs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index ea0773bb7c05..d3aa5b82d02d 100644
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


