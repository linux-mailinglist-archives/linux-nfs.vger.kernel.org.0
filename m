Return-Path: <linux-nfs+bounces-11735-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2785AB8537
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 13:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F99E176DBB
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AED9298251;
	Thu, 15 May 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnN/vLNr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E216329826D
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309762; cv=none; b=VPdVt9j4CIIFG4i9pR/k3M4nDma8GSkJH4kvi7SrmpT2brkXKBolJxdDVkmiKsiTL32MNNbXEjs1Vs9khsaX/szioHcndgD500n8m+UZeILA4U3YPHx30mLqgT8e1FmGJsj29ww1FYpZ84cai7zF2QKkoleagGI/Q0ncs1pZf90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309762; c=relaxed/simple;
	bh=s7W97FlbZo7VeAIV77wl3B+9poq+OBEla2OEDZBns8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IenySgpg+AjSWKIHJ66TX6zdWtgABBFKIXkwsEkJYHrwDnRGM7+Yl0FO7DkcYB7A361yaooPlQz7cbuiedcqfISi/0X6XfT+q5W694YLWmHlXrmOeK51ll4Gk48b4UTWDGIq/gxcymXbO6JQ9i409hAdWDTSvDZYVeIH7UbNXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cnN/vLNr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pGhb2xSPd7tcY+D3VQDtN5/qkiX8fZCPtv9Ydp2wGTA=; b=cnN/vLNrexYSi4ePyE3r1F5rv8
	w9TVIeRuXVfEAQMBFn1/vF7cMnpMBd0CtQclxBe9GT4qTuxEvGkSbODKxa84b3GG6gFsZ+5pW6bi0
	I9bPqA1HM9Zhjm7cMFOrKSuViSIghP4KvLXd6CsG++qycY4JnA7zo7MD8QIVvXl3EfIKs23hscJEO
	qxjLkWa1CZo5C1ppkkeAlsv0/ygqrbH+gLeNjhIKrWEHGV30yFOyoyFxmEivSNudW7HnTySKxjdry
	Ze+CKjRTqJjuJSiN9yQmfSd+rddYT229DDoniAIuFavHrk5MoYrtDVzgh1RY+rtvpADHhNPcitK01
	7eyZ8w0Q==;
Received: from 2a02-8389-2341-5b80-81b5-a24e-41ab-85a6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:81b5:a24e:41ab:85a6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFX5Q-00000000S63-3Rs9;
	Thu, 15 May 2025 11:49:17 +0000
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
Date: Thu, 15 May 2025 13:48:45 +0200
Message-ID: <20250515114906.32559-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515114906.32559-1-hch@lst.de>
References: <20250515114906.32559-1-hch@lst.de>
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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


