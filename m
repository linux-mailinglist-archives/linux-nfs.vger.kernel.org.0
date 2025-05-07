Return-Path: <linux-nfs+bounces-11564-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B4AADDD4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 13:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6573A9268
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 11:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531C0257AF5;
	Wed,  7 May 2025 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="33SvoJzs"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D7257441
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618994; cv=none; b=XwDUhwppMqOOZE/LuoRk0sQS3hFKRHXdrTdPvlIKkr/ymtV+prqoadUHdGo4ETQ7WkYXDJ84cmMv+490sSxjmEO6YbtwTcyG1M4B0XBdYmk2NkzE8WhG+sikCWu4jPgy02vtAwK9EEIO2rCAzZuzYl6vqMuX4qsqW2/Y+auUChc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618994; c=relaxed/simple;
	bh=DeaERzSY+uV+luw/yLG6REPVZNatL3Mp1/MRS8R9Epw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmoB+rXjBn4K9DpXY1smc7VQmadEATxI8m86L9dKS7sdfYW+QnC4pEfE8zWXTeoJuua0f3Z80F1HVS5UcVQvdpedkXlhSv+mR8U/zYWhC7AlTt1AURw6cRJ+4LSJNBxtTAdJI2irB1raQvZD8JK89H1O5XbfakITXEXV2zZNkNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=33SvoJzs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1WSTfpVnug1YtNUm/0ugrk52YqQZ9rwnlFJ6rZ+c5tE=; b=33SvoJzsqKsDhKZzprSLo2oliv
	yW7dX6ZyF37TfojJ59oO1DthfFdDe3suVmWkVugMks5iipUmodgG/jKXEp4FOSuEkIhtyia2FlhWZ
	4hWKn1LD15JIybWNHodt/cfeiRfhKNDXtYaZRoG4OV+2y3pjw+6VHjUX7nalHgOHDX8hU3nO2ngx1
	jYDQFEapucc40ScopfUNFhdnTTUWHnCDK7rsjbcLmmmuLcew9AwD8sNc3vlc7tgilgSWCnQpH4Y/9
	HzNTDkWE1NkpaW4lLjoiPMZAibMfvRghr57/rM40Ee7262O6ETPsG8L/h6Vh3f4oWWNaTp7iFBH1f
	5ujFjEbA==;
Received: from [2001:4bb8:2cc:5a47:1fe7:c9d0:5f76:7c02] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdO1-0000000FHnI-2ebV;
	Wed, 07 May 2025 11:56:30 +0000
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
Subject: [PATCH 2/3] nfsd: use rq_bvec instead of rq_vec in nfsd_vfs_write
Date: Wed,  7 May 2025 13:55:51 +0200
Message-ID: <20250507115617.3995150-3-hch@lst.de>
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

There is no benefit in using a kvec vs a bvec for in-kernel writes,
but phasing out the kvec here will allow us to eventually remove that
array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/vfs.c              | 10 +++++++---
 include/linux/sunrpc/svc.h |  2 --
 net/sunrpc/svc.c           | 40 --------------------------------------
 3 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index da62082d06dc..0cc9639fba79 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1161,8 +1161,12 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 
 	trace_nfsd_write_opened(rqstp, fhp, offset, *cnt);
 
-	nvecs = svc_fill_write_vector(rqstp, payload);
-	if (WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec)))
+	if (WARN_ON_ONCE(payload->tail->iov_len))
+		return -EIO;
+
+	nvecs = xdr_buf_to_bvec(rqstp->rq_bvec, ARRAY_SIZE(rqstp->rq_bvec),
+			payload);
+	if (WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_bvec)))
 		return -EIO;
 
 	if (sb->s_export_op)
@@ -1189,7 +1193,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
 	if (stable && !fhp->fh_use_wgather)
 		flags |= RWF_SYNC;
 
-	iov_iter_kvec(&iter, ITER_SOURCE, rqstp->rq_vec, nvecs, *cnt);
+	iov_iter_bvec(&iter, ITER_SOURCE, rqstp->rq_bvec, nvecs, *cnt);
 	since = READ_ONCE(file->f_wb_err);
 	if (verf)
 		nfsd_copy_write_verifier(verf, nn);
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 74658cca0f38..c25456738315 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -452,8 +452,6 @@ const char *	   svc_proc_name(const struct svc_rqst *rqstp);
 int		   svc_encode_result_payload(struct svc_rqst *rqstp,
 					     unsigned int offset,
 					     unsigned int length);
-unsigned int	   svc_fill_write_vector(struct svc_rqst *rqstp,
-					 struct xdr_buf *payload);
 char		  *svc_fill_symlink_pathname(struct svc_rqst *rqstp,
 					     struct kvec *first, void *p,
 					     size_t total);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e7f9c295d13c..9fd370d6676c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1713,46 +1713,6 @@ int svc_encode_result_payload(struct svc_rqst *rqstp, unsigned int offset,
 }
 EXPORT_SYMBOL_GPL(svc_encode_result_payload);
 
-/**
- * svc_fill_write_vector - Construct data argument for VFS write call
- * @rqstp: svc_rqst to operate on
- * @payload: xdr_buf containing only the write data payload
- *
- * Fills in rqstp::rq_vec, and returns the number of elements.
- */
-unsigned int svc_fill_write_vector(struct svc_rqst *rqstp,
-				   struct xdr_buf *payload)
-{
-	struct page **pages = payload->pages;
-	struct kvec *first = payload->head;
-	struct kvec *vec = rqstp->rq_vec;
-	size_t total = payload->len;
-	unsigned int i;
-
-	/* Some types of transport can present the write payload
-	 * entirely in rq_arg.pages. In this case, @first is empty.
-	 */
-	i = 0;
-	if (first->iov_len) {
-		vec[i].iov_base = first->iov_base;
-		vec[i].iov_len = min_t(size_t, total, first->iov_len);
-		total -= vec[i].iov_len;
-		++i;
-	}
-
-	while (total) {
-		vec[i].iov_base = page_address(*pages);
-		vec[i].iov_len = min_t(size_t, total, PAGE_SIZE);
-		total -= vec[i].iov_len;
-		++i;
-		++pages;
-	}
-
-	WARN_ON_ONCE(i > ARRAY_SIZE(rqstp->rq_vec));
-	return i;
-}
-EXPORT_SYMBOL_GPL(svc_fill_write_vector);
-
 /**
  * svc_fill_symlink_pathname - Construct pathname argument for VFS symlink call
  * @rqstp: svc_rqst to operate on
-- 
2.47.2


