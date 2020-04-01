Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A819B61B
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbgDAS7G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732244AbgDAS7F (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:05 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07262206F5
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767544;
        bh=1fAQ+2HjVn0b61pX52glVqCznBmuioLA+3ZGbWmcHxY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=2cSonekyqTYm2q2xSmIJTG6bfHpZcfH8icd2Ra77QdoiuT9tERi0s2hqdvTstiCOy
         Kbtp9213UTQpsxK/bArgwdYq5jXERLsuQv3C9GH29jWiQFbDPNSADHTMxvs81RRTEt
         x7X9RuodyNqJMBF5V+WxRiG5W0Xkodkx3r7p4zxs=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/10] NFS: Reverse the submission order of requests in __nfs_pageio_add_request()
Date:   Wed,  1 Apr 2020 14:56:50 -0400
Message-Id: <20200401185652.1904777-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-8-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
 <20200401185652.1904777-3-trondmy@kernel.org>
 <20200401185652.1904777-4-trondmy@kernel.org>
 <20200401185652.1904777-5-trondmy@kernel.org>
 <20200401185652.1904777-6-trondmy@kernel.org>
 <20200401185652.1904777-7-trondmy@kernel.org>
 <20200401185652.1904777-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we have to split the request up into subrequests, we have to submit
the request pointed to by the function call parameter last, in case
there is an error or other issue that causes us to exit before the
last request is submitted. The reason is that the caller is expected
to perform cleanup in those cases.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 133 ++++++++++++++++++++++------------------------
 1 file changed, 64 insertions(+), 69 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 261236157e33..b9805d1dac75 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -454,15 +454,23 @@ nfs_create_request(struct nfs_open_context *ctx, struct page *page,
 }
 
 static struct nfs_page *
-nfs_create_subreq(struct nfs_page *req, struct nfs_page *last,
-		  unsigned int pgbase, unsigned int offset,
+nfs_create_subreq(struct nfs_page *req,
+		  unsigned int pgbase,
+		  unsigned int offset,
 		  unsigned int count)
 {
+	struct nfs_page *last;
 	struct nfs_page *ret;
 
 	ret = __nfs_create_request(req->wb_lock_context, req->wb_page,
 			pgbase, offset, count);
 	if (!IS_ERR(ret)) {
+		/* find the last request */
+		for (last = req->wb_head;
+		     last->wb_this_page != req->wb_head;
+		     last = last->wb_this_page)
+			;
+
 		nfs_lock_request(ret);
 		ret->wb_index = req->wb_index;
 		nfs_page_group_init(ret, last);
@@ -988,7 +996,7 @@ static bool nfs_match_lock_context(const struct nfs_lock_context *l1,
 }
 
 /**
- * nfs_can_coalesce_requests - test two requests for compatibility
+ * nfs_coalesce_size - test two requests for compatibility
  * @prev: pointer to nfs_page
  * @req: pointer to nfs_page
  * @pgio: pointer to nfs_pagio_descriptor
@@ -997,41 +1005,36 @@ static bool nfs_match_lock_context(const struct nfs_lock_context *l1,
  * page data area they describe is contiguous, and that their RPC
  * credentials, NFSv4 open state, and lockowners are the same.
  *
- * Return 'true' if this is the case, else return 'false'.
+ * Returns size of the request that can be coalesced
  */
-static bool nfs_can_coalesce_requests(struct nfs_page *prev,
+static unsigned int nfs_coalesce_size(struct nfs_page *prev,
 				      struct nfs_page *req,
 				      struct nfs_pageio_descriptor *pgio)
 {
-	size_t size;
 	struct file_lock_context *flctx;
 
 	if (prev) {
 		if (!nfs_match_open_context(nfs_req_openctx(req), nfs_req_openctx(prev)))
-			return false;
+			return 0;
 		flctx = d_inode(nfs_req_openctx(req)->dentry)->i_flctx;
 		if (flctx != NULL &&
 		    !(list_empty_careful(&flctx->flc_posix) &&
 		      list_empty_careful(&flctx->flc_flock)) &&
 		    !nfs_match_lock_context(req->wb_lock_context,
 					    prev->wb_lock_context))
-			return false;
+			return 0;
 		if (req_offset(req) != req_offset(prev) + prev->wb_bytes)
-			return false;
+			return 0;
 		if (req->wb_page == prev->wb_page) {
 			if (req->wb_pgbase != prev->wb_pgbase + prev->wb_bytes)
-				return false;
+				return 0;
 		} else {
 			if (req->wb_pgbase != 0 ||
 			    prev->wb_pgbase + prev->wb_bytes != PAGE_SIZE)
-				return false;
+				return 0;
 		}
 	}
-	size = pgio->pg_ops->pg_test(pgio, prev, req);
-	WARN_ON_ONCE(size > req->wb_bytes);
-	if (size && size < req->wb_bytes)
-		req->wb_bytes = size;
-	return size > 0;
+	return pgio->pg_ops->pg_test(pgio, prev, req);
 }
 
 /**
@@ -1039,15 +1042,16 @@ static bool nfs_can_coalesce_requests(struct nfs_page *prev,
  * @desc: destination io descriptor
  * @req: request
  *
- * Returns true if the request 'req' was successfully coalesced into the
- * existing list of pages 'desc'.
+ * If the request 'req' was successfully coalesced into the existing list
+ * of pages 'desc', it returns the size of req.
  */
-static int nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
-				     struct nfs_page *req)
+static unsigned int
+nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
+		struct nfs_page *req)
 {
 	struct nfs_pgio_mirror *mirror = nfs_pgio_current_mirror(desc);
-
 	struct nfs_page *prev = NULL;
+	unsigned int size;
 
 	if (mirror->pg_count != 0) {
 		prev = nfs_list_entry(mirror->pg_list.prev);
@@ -1067,11 +1071,12 @@ static int nfs_pageio_do_add_request(struct nfs_pageio_descriptor *desc,
 		return 0;
 	}
 
-	if (!nfs_can_coalesce_requests(prev, req, desc))
-		return 0;
+	size = nfs_coalesce_size(prev, req, desc);
+	if (size < req->wb_bytes)
+		return size;
 	nfs_list_move_request(req, &mirror->pg_list);
 	mirror->pg_count += req->wb_bytes;
-	return 1;
+	return req->wb_bytes;
 }
 
 /*
@@ -1111,7 +1116,8 @@ nfs_pageio_cleanup_request(struct nfs_pageio_descriptor *desc,
  * @req: request
  *
  * This may split a request into subrequests which are all part of the
- * same page group.
+ * same page group. If so, it will submit @req as the last one, to ensure
+ * the pointer to @req is still valid in case of failure.
  *
  * Returns true if the request 'req' was successfully coalesced into the
  * existing list of pages 'desc'.
@@ -1120,51 +1126,50 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 			   struct nfs_page *req)
 {
 	struct nfs_pgio_mirror *mirror = nfs_pgio_current_mirror(desc);
-
 	struct nfs_page *subreq;
-	unsigned int bytes_left = 0;
-	unsigned int offset, pgbase;
+	unsigned int size, subreq_size;
 
 	nfs_page_group_lock(req);
 
 	subreq = req;
-	bytes_left = subreq->wb_bytes;
-	offset = subreq->wb_offset;
-	pgbase = subreq->wb_pgbase;
-
-	do {
-		if (!nfs_pageio_do_add_request(desc, subreq)) {
-			/* make sure pg_test call(s) did nothing */
-			WARN_ON_ONCE(subreq->wb_bytes != bytes_left);
-			WARN_ON_ONCE(subreq->wb_offset != offset);
-			WARN_ON_ONCE(subreq->wb_pgbase != pgbase);
-
+	subreq_size = subreq->wb_bytes;
+	for(;;) {
+		size = nfs_pageio_do_add_request(desc, subreq);
+		if (size == subreq_size) {
+			/* We successfully submitted a request */
+			if (subreq == req)
+				break;
+			req->wb_pgbase += size;
+			req->wb_bytes -= size;
+			req->wb_offset += size;
+			subreq_size = req->wb_bytes;
+			subreq = req;
+			continue;
+		}
+		if (WARN_ON_ONCE(subreq != req)) {
+			nfs_page_group_unlock(req);
+			nfs_pageio_cleanup_request(desc, subreq);
+			subreq = req;
+			subreq_size = req->wb_bytes;
+			nfs_page_group_lock(req);
+		}
+		if (!size) {
+			/* Can't coalesce any more, so do I/O */
 			nfs_page_group_unlock(req);
 			desc->pg_moreio = 1;
 			nfs_pageio_doio(desc);
 			if (desc->pg_error < 0 || mirror->pg_recoalesce)
-				goto out_cleanup_subreq;
+				return 0;
 			/* retry add_request for this subreq */
 			nfs_page_group_lock(req);
 			continue;
 		}
-
-		/* check for buggy pg_test call(s) */
-		WARN_ON_ONCE(subreq->wb_bytes + subreq->wb_pgbase > PAGE_SIZE);
-		WARN_ON_ONCE(subreq->wb_bytes > bytes_left);
-		WARN_ON_ONCE(subreq->wb_bytes == 0);
-
-		bytes_left -= subreq->wb_bytes;
-		offset += subreq->wb_bytes;
-		pgbase += subreq->wb_bytes;
-
-		if (bytes_left) {
-			subreq = nfs_create_subreq(req, subreq, pgbase,
-					offset, bytes_left);
-			if (IS_ERR(subreq))
-				goto err_ptr;
-		}
-	} while (bytes_left > 0);
+		subreq = nfs_create_subreq(req, req->wb_pgbase,
+				req->wb_offset, size);
+		if (IS_ERR(subreq))
+			goto err_ptr;
+		subreq_size = size;
+	}
 
 	nfs_page_group_unlock(req);
 	return 1;
@@ -1172,10 +1177,6 @@ static int __nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 	desc->pg_error = PTR_ERR(subreq);
 	nfs_page_group_unlock(req);
 	return 0;
-out_cleanup_subreq:
-	if (req != subreq)
-		nfs_pageio_cleanup_request(desc, subreq);
-	return 0;
 }
 
 static int nfs_do_recoalesce(struct nfs_pageio_descriptor *desc)
@@ -1244,7 +1245,7 @@ int nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 {
 	u32 midx;
 	unsigned int pgbase, offset, bytes;
-	struct nfs_page *dupreq, *lastreq;
+	struct nfs_page *dupreq;
 
 	pgbase = req->wb_pgbase;
 	offset = req->wb_offset;
@@ -1258,13 +1259,7 @@ int nfs_pageio_add_request(struct nfs_pageio_descriptor *desc,
 	for (midx = 1; midx < desc->pg_mirror_count; midx++) {
 		nfs_page_group_lock(req);
 
-		/* find the last request */
-		for (lastreq = req->wb_head;
-		     lastreq->wb_this_page != req->wb_head;
-		     lastreq = lastreq->wb_this_page)
-			;
-
-		dupreq = nfs_create_subreq(req, lastreq,
+		dupreq = nfs_create_subreq(req,
 				pgbase, offset, bytes);
 
 		nfs_page_group_unlock(req);
-- 
2.25.1

