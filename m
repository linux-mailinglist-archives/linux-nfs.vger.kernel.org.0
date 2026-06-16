Return-Path: <linux-nfs+bounces-22632-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OTk/IyNTMWpKgwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22632-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:44:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC566900BE
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 15:44:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JeUUe7+B;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22632-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22632-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 111EA31BA35F
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E159F305688;
	Tue, 16 Jun 2026 13:40:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5432B113
	for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 13:40:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617207; cv=none; b=p+Z6MtEKlWjqyAfCguBYcO461/1pyLHuIQdOWBXR/KylTi3i9nbNwZfOH/5dthk/eY59GBO7hyBfO6f09vwv02AaQs/Rau+pdNsIJmC/ESWufliZTY2slv7U6yeDm2pOyJDvowu+95yDXWdIOo9NhjjCsrzNrdq5w8C03EKa2Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617207; c=relaxed/simple;
	bh=rIGLshW+X166l81xCwoWf0q5ZuoxJonDlbcxM3hXdzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+3WzGP3gNP6t0sWw02KMu1qQfgoJ6VLGlhJLrmHAv1ENcyGZfSnu9uap7rf4iJ/FNkdOg6hzyYSh8gU7q7jvFa4yu5gudos9aMy6xFmk/iB0g8VLQY7Tp6ka7KxduL1BZbyiJM7V/6t/GKoRdvfsYtDe/Ptxpa6vIIeRTkjfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JeUUe7+B; arc=none smtp.client-ip=209.85.216.74
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36d982d932aso6024623a91.0
        for <linux-nfs@vger.kernel.org>; Tue, 16 Jun 2026 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781617206; x=1782222006; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mweXAOR38Xgx261y16hhaEqqdbuo1oE3edAA0tndrpY=;
        b=JeUUe7+BcSy68h5go0DpYMf0oxhCaZqoNW0HGKnkYqgsSVFg+Ovb8gxCxGbxeF66ZJ
         9USAUVGfhhG4Wr3p+lHp/e6QA8e6oVkpLqhrGP8QnzvXWAjFwLKXyQf2FpKDTUbTl/Ub
         IlhHOGI15aJCVduIjf2ReFMiqOwLos+IZA0Nsq+UFXAlpKs5gIukwmeacYTKaYy+Ny8B
         vX4L6sVriX1qFjik9/WDFbLqn9+p9vySQMzAVLQvzEUhw9irOMghxd8oxCtG57bsOXdF
         VliH3tgya/Td4UxuX9VkjsKqVBygf94dl8oF6M7+hBZCfE2QSdpWkWJIK2pjB4TeDqmR
         E49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781617206; x=1782222006;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mweXAOR38Xgx261y16hhaEqqdbuo1oE3edAA0tndrpY=;
        b=FZUCxorO9kbRXIauTekthR6N5DEb4Jo9FyvI9r31RYASh8XYvFhiqCM+LFV/qkwTlP
         Vz1zthLj/Oa3ngO1R963NAYGC30KxCkco1AFHcvQR4kC4711jtHuDKHa2LmpQKi3JMZ3
         j+vJxkTFVmgQCI7S+/nKj11mnrf6mxUhZogRroWBfopv7JnzEyLiWQD+NhLjiASQWOiM
         1gSo5QZUS4PO41vhXXWhxAGOp2w4BYbh79yKGpD5h06A2i5Gr26Bpy+D80uDolPxZYPD
         i4sKmKZyPU3jTQw0l6YU1A9EIbIgReYMynTe3qPAi7BxUfwfn6+QB9x2Y0nFTLBrJAPC
         kCFQ==
X-Gm-Message-State: AOJu0YxJ2dq141GIV6WkAu7iBRRKAHnfxNEMWtAHfByza/dr/hmwoPRW
	6/jIg8DG2puoD8Daz2u255GuI+L2oXNminC70peBslzgJLZiOEqC0RBy/8vO576OP/ExxKY/9hi
	XTTRFcIefSiEMiNcIDmBG5MFrzL7Bx3NAo664AV31ne5+QDg+MdtuzeswBRAZzoZyz0vGtAz2m9
	eh73cMEW+2EA6eZkkos3ofDN7V5sVubrr37TE=
X-Received: from pjbfa6.prod.google.com ([2002:a17:90a:f0c6:b0:365:ca4c:7afb])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:7344:b0:37c:6975:2e3d
 with SMTP id 98e67ed59e1d1-37c697534e4mr558882a91.8.1781617205226; Tue, 16
 Jun 2026 06:40:05 -0700 (PDT)
Date: Tue, 16 Jun 2026 13:39:54 +0000
In-Reply-To: <20260616134000.2733403-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616134000.2733403-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616134000.2733403-2-praan@google.com>
Subject: [PATCH v2 1/7] nfs: make nfs_page pin-aware
From: Pranjal Shrivastava <praan@google.com>
To: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Christoph Hellwig <hch@infradead.org>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22632-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:hch@lst.de,m:hch@infradead.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFC566900BE

Modernizing the NFS Direct I/O path to use iov_iter_extract_pages()
introduces page pinning (GUP) instead of standard page referencing.
To handle this correctly, nfs_page must track whether it holds a
pin or a standard reference.

Introduce a new flag, PG_PINNED, to struct nfs_page. Update the creation
path (nfs_page_create_from_page and nfs_page_create_from_folio) to
accept a pinned bool and set the flag accordingly. If the page is pinned,
we skip the existing reference increment (get_page/folio_get) as the pin
itself acts as a reference.

Update nfs_clear_request() & nfs_direct_release_pages() to use
unpin_user_page() or unpin_user_folio() instead of only refcount
decrement (put_page) when PG_PINNED flag is set. Finally, ensure
subrequests inherit the pinning status from their parent request.

Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 fs/nfs/direct.c          | 22 +++++++++++++++-------
 fs/nfs/pagelist.c        | 38 ++++++++++++++++++++++++++++----------
 fs/nfs/read.c            |  2 +-
 fs/nfs/write.c           |  2 +-
 include/linux/nfs_page.h |  3 +++
 5 files changed, 48 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index e626c72495e6..19792a38c924 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -165,11 +165,17 @@ int nfs_swap_rw(struct kiocb *iocb, struct iov_iter *iter)
 	return 0;
 }
 
-static void nfs_direct_release_pages(struct page **pages, unsigned int npages)
+static void nfs_direct_release_pages(struct page **pages, unsigned int npages,
+				     bool pinned)
 {
 	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
+
+	if (pinned) {
+		unpin_user_pages(pages, npages);
+	} else {
+		for (i = 0; i < npages; i++)
+			put_page(pages[i]);
+	}
 }
 
 void nfs_init_cinfo_from_dreq(struct nfs_commit_info *cinfo,
@@ -371,7 +377,8 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 			/* XXX do we need to do the eof zeroing found in async_filler? */
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							pgbase, pos, req_len);
+							false, pgbase, pos,
+							req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
 				break;
@@ -386,7 +393,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			requested_bytes += req_len;
 			pos += req_len;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		nfs_direct_release_pages(pagevec, npages, false);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
@@ -907,7 +914,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 
 			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
-							pgbase, pos, req_len);
+							false, pgbase, pos,
+							req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
 				break;
@@ -950,7 +958,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			desc.pg_error = 0;
 			defer = true;
 		}
-		nfs_direct_release_pages(pagevec, npages);
+		nfs_direct_release_pages(pagevec, npages, false);
 		kvfree(pagevec);
 		if (result < 0)
 			break;
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 7dd478ffc2fa..faa8bc1c6526 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -404,20 +404,26 @@ static struct nfs_page *nfs_page_create(struct nfs_lock_context *l_ctx,
 	return req;
 }
 
-static void nfs_page_assign_folio(struct nfs_page *req, struct folio *folio)
+static void nfs_page_assign_folio(struct nfs_page *req, struct folio *folio, bool pinned)
 {
 	if (folio != NULL) {
 		req->wb_folio = folio;
-		folio_get(folio);
+		if (pinned)
+			set_bit(PG_PINNED, &req->wb_flags);
+		else
+			folio_get(folio);
 		set_bit(PG_FOLIO, &req->wb_flags);
 	}
 }
 
-static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
+static void nfs_page_assign_page(struct nfs_page *req, struct page *page, bool pinned)
 {
 	if (page != NULL) {
 		req->wb_page = page;
-		get_page(page);
+		if (pinned)
+			set_bit(PG_PINNED, &req->wb_flags);
+		else
+			get_page(page);
 	}
 }
 
@@ -425,6 +431,7 @@ static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
  * nfs_page_create_from_page - Create an NFS read/write request.
  * @ctx: open context to use
  * @page: page to write
+ * @pinned: true if page is pinned
  * @pgbase: starting offset within the page for the write
  * @offset: file offset for the write
  * @count: number of bytes to read/write
@@ -435,6 +442,7 @@ static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
  */
 struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 					   struct page *page,
+					   bool pinned,
 					   unsigned int pgbase, loff_t offset,
 					   unsigned int count)
 {
@@ -446,7 +454,7 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
 			      offset_in_page(offset), count);
 	if (!IS_ERR(ret)) {
-		nfs_page_assign_page(ret, page);
+		nfs_page_assign_page(ret, page, pinned);
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -457,6 +465,7 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
  * nfs_page_create_from_folio - Create an NFS read/write request.
  * @ctx: open context to use
  * @folio: folio to write
+ * @pinned: true if folio is pinned
  * @offset: starting offset within the folio for the write
  * @count: number of bytes to read/write
  *
@@ -466,6 +475,7 @@ struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
  */
 struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 					    struct folio *folio,
+					    bool pinned,
 					    unsigned int offset,
 					    unsigned int count)
 {
@@ -476,7 +486,7 @@ struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 		return ERR_CAST(l_ctx);
 	ret = nfs_page_create(l_ctx, offset, folio->index, offset, count);
 	if (!IS_ERR(ret)) {
-		nfs_page_assign_folio(ret, folio);
+		nfs_page_assign_folio(ret, folio, pinned);
 		nfs_page_group_init(ret, NULL);
 	}
 	nfs_put_lock_context(l_ctx);
@@ -498,9 +508,11 @@ nfs_create_subreq(struct nfs_page *req,
 			      offset, count);
 	if (!IS_ERR(ret)) {
 		if (folio)
-			nfs_page_assign_folio(ret, folio);
+			nfs_page_assign_folio(ret, folio,
+					      test_bit(PG_PINNED, &req->wb_flags));
 		else
-			nfs_page_assign_page(ret, page);
+			nfs_page_assign_page(ret, page,
+					     test_bit(PG_PINNED, &req->wb_flags));
 		/* find the last request */
 		for (last = req->wb_head;
 		     last->wb_this_page != req->wb_head;
@@ -552,11 +564,17 @@ static void nfs_clear_request(struct nfs_page *req)
 	struct nfs_open_context *ctx;
 
 	if (folio != NULL) {
-		folio_put(folio);
+		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
+			unpin_user_folio(folio, 1);
+		else
+			folio_put(folio);
 		req->wb_folio = NULL;
 		clear_bit(PG_FOLIO, &req->wb_flags);
 	} else if (page != NULL) {
-		put_page(page);
+		if (test_and_clear_bit(PG_PINNED, &req->wb_flags))
+			unpin_user_page(page);
+		else
+			put_page(page);
 		req->wb_page = NULL;
 	}
 	if (l_ctx != NULL) {
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 2b70bd2b934b..e7497b029d6c 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -324,7 +324,7 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 
 	aligned_len = min_t(unsigned int, ALIGN(len, rsize), fsize);
 
-	new = nfs_page_create_from_folio(ctx, folio, 0, aligned_len);
+	new = nfs_page_create_from_folio(ctx, folio, false, 0, aligned_len);
 	if (IS_ERR(new)) {
 		error = PTR_ERR(new);
 		if (nfs_netfs_folio_unlock(folio))
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fcffb8c9e9df..e39e62b65ce2 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1086,7 +1086,7 @@ static struct nfs_page *nfs_setup_write_request(struct nfs_open_context *ctx,
 	req = nfs_try_to_update_request(folio, offset, bytes);
 	if (req != NULL)
 		goto out;
-	req = nfs_page_create_from_folio(ctx, folio, offset, bytes);
+	req = nfs_page_create_from_folio(ctx, folio, false, offset, bytes);
 	if (IS_ERR(req))
 		goto out;
 	nfs_inode_add_request(req);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 4b9a35dbc062..fd7aafe7cb54 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -38,6 +38,7 @@ enum {
 	PG_REMOVE,		/* page group sync bit in write path */
 	PG_CONTENDED1,		/* Is someone waiting for a lock? */
 	PG_CONTENDED2,		/* Is someone waiting for a lock? */
+	PG_PINNED,		/* page is pinned by GUP */
 };
 
 struct nfs_inode;
@@ -125,11 +126,13 @@ struct nfs_pageio_descriptor {
 
 extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
 						  struct page *page,
+						  bool pinned,
 						  unsigned int pgbase,
 						  loff_t offset,
 						  unsigned int count);
 extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 						   struct folio *folio,
+						   bool pinned,
 						   unsigned int offset,
 						   unsigned int count);
 extern	void nfs_release_request(struct nfs_page *);
-- 
2.54.0.1136.gdb2ca164c4-goog


