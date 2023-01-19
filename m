Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F4F674D05
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 07:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjATGIX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 01:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjATGIW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 01:08:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603CF4E510
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 22:08:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 267A5B82743
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB39C433F0;
        Thu, 19 Jan 2023 21:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164425;
        bh=7OiDhjmwOvjfo/TsR3JaT2r2J2Uo7jzmX5lHs7AA8aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IcUmVQYUxx94eS0OS70WI5uG4HoYBdkIuqavROMSCGbwYvkg5xDyBbhRvibW7KUFd
         a0lBrgEN49K7cArSYLMrelhxLiZn4kDNg05gpI4F66gnJcXAkBbX1sB/y2VQunkv2R
         JjBAMi/rXpR2DG7R5FR9BLpKRR3V1X4FEJK4hbDUc2THFuOaN9jrvlFoKINnWkcPIL
         vkhiXJOrZLRt1024Eb62FwImh9AQ9EjZ48CoEG+PGD1nn7TXXDPTN5s6pc0nl+j9Wy
         dBeZqQ2vzxSfxaGb+G7l/FiI3aavP8CQmw5Xmbv/hXr4FvfM8Gm6eiMA8H2hy3z6gy
         /nQk2Pvbmvshg==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/18] NFS: Clean up O_DIRECT request allocation
Date:   Thu, 19 Jan 2023 16:33:47 -0500
Message-Id: <20230119213351.443388-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-14-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
 <20230119213351.443388-7-trondmy@kernel.org>
 <20230119213351.443388-8-trondmy@kernel.org>
 <20230119213351.443388-9-trondmy@kernel.org>
 <20230119213351.443388-10-trondmy@kernel.org>
 <20230119213351.443388-11-trondmy@kernel.org>
 <20230119213351.443388-12-trondmy@kernel.org>
 <20230119213351.443388-13-trondmy@kernel.org>
 <20230119213351.443388-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Rather than adjusting the index+offset after the call to
nfs_create_request(), add a function nfs_page_create_from_page() that
takes an offset.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/direct.c          | 12 ++++--------
 fs/nfs/pagelist.c        | 15 +++++++++------
 include/linux/nfs_page.h |  9 +++++----
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1707f46b1335..9a18c5a69ace 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -343,14 +343,12 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 			/* XXX do we need to do the eof zeroing found in async_filler? */
-			req = nfs_create_request(dreq->ctx, pagevec[i],
-						 pgbase, req_len);
+			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
+							pgbase, pos, req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
 				break;
 			}
-			req->wb_index = pos >> PAGE_SHIFT;
-			req->wb_offset = pos & ~PAGE_MASK;
 			if (!nfs_pageio_add_request(&desc, req)) {
 				result = desc.pg_error;
 				nfs_release_request(req);
@@ -802,8 +800,8 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			struct nfs_page *req;
 			unsigned int req_len = min_t(size_t, bytes, PAGE_SIZE - pgbase);
 
-			req = nfs_create_request(dreq->ctx, pagevec[i],
-						 pgbase, req_len);
+			req = nfs_page_create_from_page(dreq->ctx, pagevec[i],
+							pgbase, pos, req_len);
 			if (IS_ERR(req)) {
 				result = PTR_ERR(req);
 				break;
@@ -816,8 +814,6 @@ static ssize_t nfs_direct_write_schedule_iovec(struct nfs_direct_req *dreq,
 			}
 
 			nfs_lock_request(req);
-			req->wb_index = pos >> PAGE_SHIFT;
-			req->wb_offset = pos & ~PAGE_MASK;
 			if (!nfs_pageio_add_request(&desc, req)) {
 				result = desc.pg_error;
 				nfs_unlock_and_release_request(req);
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 7a622263a9fc..0b4c07c93a52 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -514,26 +514,29 @@ static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
 }
 
 /**
- * nfs_create_request - Create an NFS read/write request.
+ * nfs_page_create_from_page - Create an NFS read/write request.
  * @ctx: open context to use
  * @page: page to write
- * @offset: starting offset within the page for the write
+ * @pgbase: starting offset within the page for the write
+ * @offset: file offset for the write
  * @count: number of bytes to read/write
  *
  * The page must be locked by the caller. This makes sure we never
  * create two different requests for the same page.
  * User should ensure it is safe to sleep in this function.
  */
-struct nfs_page *
-nfs_create_request(struct nfs_open_context *ctx, struct page *page,
-		   unsigned int offset, unsigned int count)
+struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
+					   struct page *page,
+					   unsigned int pgbase, loff_t offset,
+					   unsigned int count)
 {
 	struct nfs_lock_context *l_ctx = nfs_get_lock_context(ctx);
 	struct nfs_page *ret;
 
 	if (IS_ERR(l_ctx))
 		return ERR_CAST(l_ctx);
-	ret = nfs_page_create(l_ctx, offset, page_index(page), offset, count);
+	ret = nfs_page_create(l_ctx, pgbase, offset >> PAGE_SHIFT,
+			      offset_in_page(offset), count);
 	if (!IS_ERR(ret)) {
 		nfs_page_assign_page(ret, page);
 		nfs_page_group_init(ret, NULL);
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 3c71493d5cc3..a2f1ca657623 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -121,10 +121,11 @@ struct nfs_pageio_descriptor {
 
 #define NFS_WBACK_BUSY(req)	(test_bit(PG_BUSY,&(req)->wb_flags))
 
-extern	struct nfs_page *nfs_create_request(struct nfs_open_context *ctx,
-					    struct page *page,
-					    unsigned int offset,
-					    unsigned int count);
+extern struct nfs_page *nfs_page_create_from_page(struct nfs_open_context *ctx,
+						  struct page *page,
+						  unsigned int pgbase,
+						  loff_t offset,
+						  unsigned int count);
 extern struct nfs_page *nfs_page_create_from_folio(struct nfs_open_context *ctx,
 						   struct folio *folio,
 						   unsigned int offset,
-- 
2.39.0

