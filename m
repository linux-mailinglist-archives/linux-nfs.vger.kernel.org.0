Return-Path: <linux-nfs+bounces-11673-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77173AB4EA3
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 10:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254721887940
	for <lists+linux-nfs@lfdr.de>; Tue, 13 May 2025 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5A020F079;
	Tue, 13 May 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f0ud9l8E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEE1EB19F
	for <linux-nfs@vger.kernel.org>; Tue, 13 May 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126670; cv=none; b=C1E9pXzcssOAkymq0rCJ1CVGAeRKtXt33dnhg1LMjagF+xqIOBwS5z+MgNnWdJw9yS6aSYawth0URYKxWZjkzZAZwvN6jK6xKi8NLunqpfE8Mpq1Nk0mcbTRTkjyGd5pf+JpClKQYeEskdko3xzQlUiY4E519E6voWeyQxDXvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126670; c=relaxed/simple;
	bh=mtVZjs5gyQQIlt6N76+0OL1TEtzwExf9s4OvM783zGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTYBJX3gE+zYxYuq8TOMAlT04/vIozUJzGI1Xmgxn/tvryyrv7Yq1NcNkg80d0waUud+hXUmW1FUhF3jqU911pxjcG4ddaB06tUgKrG3fC2CbGW3HXZPuyiGCEEUzN7vK25Uyrm5uOf3Og5ftTGBLicBXQb8n6g4wB0ksR7pMTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f0ud9l8E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=A+qR+pj+FLHn3xNysO4GufepGlHzLf4kDQ11PezcvvI=; b=f0ud9l8EeXt/thcXVquU+SznYJ
	6Z/yHjbMTrzhr01vePdw6/jdYeJIyqLTB6fvSdji8QnYREP9oUNiLthcjHKvOlag4d+p1Tv5oks8I
	PNio2qyMECgDNG7QPPtAit4dm+QdhX8YJvJVHO5wwklEWg2VpdTjslPisPjJpZ/PO9543dot98m+J
	bMZzprnJkFWvjNj9xI+kDgplr8pnuhiMN1uBdYyu8GsSTvQc6rJDFpNcrjbTT646L/CnN+KyOtMmx
	hTUesm9EPf4PFPiRjs8xI9Dgguilreuf6SGNU/y4cOszF8JjWnS2KsSSWzRTVdaHnjw8zcEezAGvi
	V9ov+PRw==;
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uElSM-0000000BpBU-2Vaj;
	Tue, 13 May 2025 08:57:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] sunrpc: simplify xdr_init_encode_pages
Date: Tue, 13 May 2025 10:57:24 +0200
Message-ID: <20250513085739.894150-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513085739.894150-1-hch@lst.de>
References: <20250513085739.894150-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The rqst argument to xdr_init_encode_pages is set to NULL by all callers,
and pages is always set to buf->pages.  Remove the two arguments and
hardcode the assignments.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/nfs3proc.c         |  2 +-
 fs/nfsd/nfsproc.c          |  2 +-
 include/linux/sunrpc/xdr.h |  3 +--
 net/sunrpc/xdr.c           | 11 ++++-------
 4 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 8902fae8c62d..6c94042b03fa 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -562,7 +562,7 @@ static void nfsd3_init_dirlist_pages(struct svc_rqst *rqstp,
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page += (buf->buflen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
-	xdr_init_encode_pages(xdr, buf, buf->pages,  NULL);
+	xdr_init_encode_pages(xdr, buf);
 }
 
 /*
diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
index 7c573d792252..f1c2c096804b 100644
--- a/fs/nfsd/nfsproc.c
+++ b/fs/nfsd/nfsproc.c
@@ -577,7 +577,7 @@ static void nfsd_init_dirlist_pages(struct svc_rqst *rqstp,
 	buf->pages = rqstp->rq_next_page;
 	rqstp->rq_next_page++;
 
-	xdr_init_encode_pages(xdr, buf, buf->pages,  NULL);
+	xdr_init_encode_pages(xdr, buf);
 }
 
 /*
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index a2ab813a9800..29d3a7659727 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -242,8 +242,7 @@ typedef int	(*kxdrdproc_t)(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 
 extern void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
-extern void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
-			   struct page **pages, struct rpc_rqst *rqst);
+void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf);
 extern __be32 *xdr_reserve_space(struct xdr_stream *xdr, size_t nbytes);
 extern int xdr_reserve_space_vec(struct xdr_stream *xdr, size_t nbytes);
 extern void __xdr_commit_encode(struct xdr_stream *xdr);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 4e003cb516fe..1ab973d3e324 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -992,21 +992,18 @@ EXPORT_SYMBOL_GPL(xdr_init_encode);
  * xdr_init_encode_pages - Initialize an xdr_stream for encoding into pages
  * @xdr: pointer to xdr_stream struct
  * @buf: pointer to XDR buffer into which to encode data
- * @pages: list of pages to decode into
- * @rqst: pointer to controlling rpc_rqst, for debugging
  *
  */
-void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
-			   struct page **pages, struct rpc_rqst *rqst)
+void xdr_init_encode_pages(struct xdr_stream *xdr, struct xdr_buf *buf)
 {
 	xdr_reset_scratch_buffer(xdr);
 
 	xdr->buf = buf;
-	xdr->page_ptr = pages;
+	xdr->page_ptr = buf->pages;
 	xdr->iov = NULL;
-	xdr->p = page_address(*pages);
+	xdr->p = page_address(*xdr->page_ptr);
 	xdr->end = (void *)xdr->p + min_t(u32, buf->buflen, PAGE_SIZE);
-	xdr->rqst = rqst;
+	xdr->rqst = NULL;
 }
 EXPORT_SYMBOL_GPL(xdr_init_encode_pages);
 
-- 
2.47.2


