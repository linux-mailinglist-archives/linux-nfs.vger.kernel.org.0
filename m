Return-Path: <linux-nfs+bounces-23324-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mPceBOqeV2oiYAAAu9opvQ
	(envelope-from <linux-nfs+bounces-23324-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 16:53:30 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5855175F9C7
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 16:53:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=J0vBnbcY;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23324-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23324-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC7C732A4348
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2026 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E23976A9;
	Wed, 15 Jul 2026 14:35:48 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E738E8A5
	for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 14:35:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126147; cv=none; b=eNZHD/+/IAtrmPEJYSbgQ1b6RfQJf2L2tzWsQK1rpV0rGak+zYQJl83ZOBfU9urNvaWGh94SmNDMGyl8zyInTxvHFKKqz/iD+p6IGcuCfxW72tcg/1orW49LqkV3Qq0Tci2zRo3jeYBFcrh1lgQzaZOe2csvZOgk3RB5Uu9qnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126147; c=relaxed/simple;
	bh=l4XGtm3sO0V2v0lCEoKhQG/tCtAAedrAcsw+qJsqHes=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OQu6d68kxE15QrGcG9fIiYo6uCbHhzizMb1qwy8YBEMf9WJTibhHx9DrJov7UMgqC6HSZ9TdfdWw2MYc+Iop8wrs5nOAu9Ay9VDiDeAaOf63St5c2xFZ4MO8KBmcz4jIyTQBSl8fWvJEPZLLsqbgvn6z9kgOktHdkJhN2x0cJiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0vBnbcY; arc=none smtp.client-ip=209.85.215.201
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-ca860baea9fso5229901a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 15 Jul 2026 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784126145; x=1784730945; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8tfUyk6Z0T2pecuznR1vX6/r4MCXD0HXFkirQr6U57M=;
        b=J0vBnbcYYslEKbU7D8VZjrsuAQ4RR6wFMMx5sGr8lzgfMYEhZTxGQBSoMRdias8buP
         5iFYURo2pd6hYkjMgXYZ66OM/cRQ/bjM4R8avaDIemLHrTjqIKY8WpKZZNjtU1XCD5qN
         BGAoVuZQpTPXuo3qfTJ3hR+ooqi1LmDuVJ3tNleTzfqNeGD/TAY4JGmGWP/79snXY1Sy
         qy/S+xjOixe3hPXFgOJmA/eIGF448FUMrRsMZVgHBXo0zKmFz++UAC1gGLEozOSDN7yw
         9aqtwRmPyudabK+xEmlkRJmZIiAXYfjZKJagW13hDpbu03Y+73ni1sYd/1oytikzOrc5
         IP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126145; x=1784730945;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8tfUyk6Z0T2pecuznR1vX6/r4MCXD0HXFkirQr6U57M=;
        b=IfexpiX7e2J6O+3eDCXzfQg77oxXl08pF1fLb8TXzOizNjAnLkHWe/PRtt6xKeU2E5
         fU758vNcB9KfBZRwMvrY/cwjfr/pJww+i2mgXl3lYc6F8kbHFYGbrwoaE/3oH4RK9lOQ
         cRyo/+dNPssH4toDoF0mO/WZ2yfKPFnAgoRnbNLXCl8KdszOJk40V9LrqiHNsVSCWxQ3
         NeTgO4LO62wTCLmQMFJF7XVi22lRwktIhFlpeiweRsuYXmPEFKX0iadvRnAW2RFU6KHl
         IU/qXbFti/9B108bt6P7YG7HLsYsmb91OZQAtNFrN6zqoc5nU6l1YCgbij0SnzD9e41F
         QArw==
X-Forwarded-Encrypted: i=1; AHgh+RpCEAPLOgMkftcDmLWErlY1MUU6Zt5leFpr9mR3Suww1Exrl/V58miv43MEiKaSR0LOttADbcbAFpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTq0wXFw+STOU5dWcmUb/qW1h31LWpGKovd6544kqCPY6O8I6
	ouAOpinNeuhjapxKygV/SnqUHHlVg9HO/6Nkp19vsUJROhXiBQ4MGQMceoDrMcRLMhMh0T48Kf5
	fAg==
X-Received: from pggr6.prod.google.com ([2002:a63:d906:0:b0:c9f:3143:b204])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:21d2:b0:848:48e9:2ecb
 with SMTP id d2e1a72fcca58-84889600e32mr15737708b3a.10.1784126145074; Wed, 15
 Jul 2026 07:35:45 -0700 (PDT)
Date: Wed, 15 Jul 2026 14:35:36 +0000
In-Reply-To: <20260715143540.3597616-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260715143540.3597616-1-praan@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260715143540.3597616-2-praan@google.com>
Subject: [PATCH v3 1/5] nfs: make nfs_page pin-aware
From: Pranjal Shrivastava <praan@google.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	Shivaji Kant <shivajikant@google.com>, Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,m:cel@kernel.org,m:jlayton@kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:logang@deltatee.com,m:jgg@ziepe.ca,m:linux-pci@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:shivajikant@google.com,m:praan@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23324-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praan@google.com,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5855175F9C7
X-Rspamd-Action: no action

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
index d2b03ceaeb4f..e565b811d8b7 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1088,7 +1088,7 @@ static struct nfs_page *nfs_setup_write_request(struct nfs_open_context *ctx,
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
2.55.0.229.g6434b31f56-goog


