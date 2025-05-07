Return-Path: <linux-nfs+bounces-11565-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD5AADDD6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E061B65370
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 11:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEAB257441;
	Wed,  7 May 2025 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BymuZhDV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1103221F13
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618997; cv=none; b=c3o0cp8wQuMVlJVoPbKXUzN/286n3NRP7rESEUaa4iIN3t+yGmvc7BIUxtNDztLdcKbIYbpqzv/IRVlhTI/RocsUKx9uJEzsJwobrU/IsHk+voMJ1ku0O32pn/XdkYXsw7bN2ORQb/4GHD6RiTjp0y3LEPN/F/a3pAvQujLfODY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618997; c=relaxed/simple;
	bh=qblzoMOC1XzCT1W4y9KKWqF43Am8gUMF+xTzKueFhmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRafEv1rddiL4Knr4ngK5EZyLXrOETegq5z6ZNe+HGdEOk0Bp48vONOvkGy4tlDLv+IM5dnI2xCSUhRn+MsJMKK2+aXEQ0kjTEyOmRwCYxORcfn/Pm0rZ4znQkqDBC1d/VMEo0C54s/CPe2giTElEo0ccXDewwJpWKP7J90Z3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BymuZhDV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=WthCZc9msKLLDrlG175hnnRlR6EYAPjuRcYPU4BZoRg=; b=BymuZhDVa3iuYnOnGkTIISd8dF
	CPuDmn70s6hhbm4m1DuYBLKrkmbaonMLWsKDpMZxfJG2dM51RkPoseekQxr5znledPdGRtz4Vz4RM
	Ie2eSMbjDj8fYYa5Ntp4BvNgjaFuDJHmkLmfOLqAtsyvlxlWDj9r/nYA3o4lwZR/g0AOCi4HWfase
	kDsV8NgegORDqbxEB5Rvb7r/a+XL1ZBbBGwnTe7cBagnkrzSlcmoVJaD44IwiOlkJmRq86HW+/wWW
	c/Xk3huuT5/Kn9QMTx9AY1Xf+sxnPb4JVwfHYmCvmBgj0NQVTdM48YRcbVVU5Qjg7cYvPcSuCU0kV
	5osJ8Rnw==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdO5-0000000FHnW-1se5;
	Wed, 07 May 2025 11:56:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Neil Brown <neilb@suse.de>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 3/3] nfsd: use rq_bvec in nfsd_iter_read
Date: Wed,  7 May 2025 13:55:52 +0200
Message-ID: <20250507115617.3995150-4-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507115617.3995150-1-hch@lst.de>
References: <20250507115617.3995150-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Using a bvec array vs a kvec one slightly simplifies the logic, and allow
to remove the rq_vecs array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/vfs.c              | 27 ++++++++++++++++-----------
 include/linux/sunrpc/svc.h |  1 -
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0cc9639fba79..1804aed0739b 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1078,26 +1078,31 @@ __be32 nfsd_iter_read(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		      struct file *file, loff_t offset, unsigned long *count,
 		      unsigned int base, u32 *eof)
 {
-	unsigned long v, total;
+	unsigned long total = *count;
 	struct iov_iter iter;
 	loff_t ppos = offset;
-	struct page *page;
+	unsigned int v = 0;
 	ssize_t host_err;
 
-	v = 0;
-	total = *count;
+	/*
+	 * Note: if this request is served through the socket transport, rq_bvec
+	 * will be rebuilt again in the transport, including the XDR header and
+	 * trailer.  It would be nice to fully build it in one place, but that
+	 * needs more work.
+	 */
 	while (total) {
-		page = *(rqstp->rq_next_page++);
-		rqstp->rq_vec[v].iov_base = page_address(page) + base;
-		rqstp->rq_vec[v].iov_len = min_t(size_t, total, PAGE_SIZE - base);
-		total -= rqstp->rq_vec[v].iov_len;
-		++v;
+		unsigned int len = min(total, PAGE_SIZE - base);
+		struct page *page = *(rqstp->rq_next_page++);
+
+		bvec_set_page(&rqstp->rq_bvec[v++], page, len, base);
+		if (WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_bvec)))
+			return -EIO;
+		total -= len;
 		base = 0;
 	}
-	WARN_ON_ONCE(v > ARRAY_SIZE(rqstp->rq_vec));
 
 	trace_nfsd_read_vector(rqstp, fhp, offset, *count);
-	iov_iter_kvec(&iter, ITER_DEST, rqstp->rq_vec, v, *count);
+	iov_iter_bvec(&iter, ITER_DEST, rqstp->rq_bvec, v, *count);
 	host_err = vfs_iter_read(file, &iter, &ppos, 0);
 	return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, host_err);
 }
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index c25456738315..a040583a29da 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -194,7 +194,6 @@ struct svc_rqst {
 	struct page *		*rq_page_end;  /* one past the last page */
 
 	struct folio_batch	rq_fbatch;
-	struct kvec		rq_vec[RPCSVC_MAXPAGES]; /* generally useful.. */
 	struct bio_vec		rq_bvec[RPCSVC_MAXPAGES];
 
 	__be32			rq_xid;		/* transmission id */
-- 
2.47.2


