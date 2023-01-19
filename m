Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0070B67456F
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjASWDO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjASWCf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57097C41EB
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 832E561D68
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B364C433F0;
        Thu, 19 Jan 2023 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164421;
        bh=RNZMIVOi/tSWqhdzNoGX+yIszDCN3Rf0OfoUuHCMd3E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q35r5hw03porRPMbBr1NdYDggBp4x8xDf5nxdRMQUzMJw8jzhZrwTXhi4izr0ES68
         Xldr65biJWE+Dx3t5N8mPCPKvAZRuEUFTC86MEBpaM+9DLAVgKw2uy0K1K0+a5YOGh
         yYCw+yj3bM9e0TRjrocH0BwDwJsWTPmfwtv9j9PpsLTBjgNmqnej9+9UKrsAi1360X
         t98lAoY4IWGz7Ol716xiqGPQN6Ck97fIl9GamGFp30qCwEyGh9PbbjC4c50XxEXKcq
         FRntx+d/v2ORjU/GaoHJBjGCt5KppNOnj3rndk7NBCJZfuhcPYApwL56rD1YwhCsIz
         pez+f+7c3W2MA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/18] NFS: Convert the remaining pagelist helper functions to support folios
Date:   Thu, 19 Jan 2023 16:33:39 -0500
Message-Id: <20230119213351.443388-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-6-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
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

Allow creation of subrequests from a request that is carrying a folio.
Add helpers to set up and tear down requests carrying folios.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 72 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 4bdb570184f7..dd99a5d381b3 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -466,10 +466,9 @@ nfs_page_group_destroy(struct kref *kref)
 		nfs_release_request(head);
 }
 
-static struct nfs_page *
-__nfs_create_request(struct nfs_lock_context *l_ctx, struct page *page,
-		   unsigned int pgbase, unsigned int offset,
-		   unsigned int count)
+static struct nfs_page *nfs_page_create(struct nfs_lock_context *l_ctx,
+					unsigned int pgbase, pgoff_t index,
+					unsigned int offset, unsigned int count)
 {
 	struct nfs_page		*req;
 	struct nfs_open_context *ctx = l_ctx->open_context;
@@ -488,19 +487,32 @@ __nfs_create_request(struct nfs_lock_context *l_ctx, struct page *page,
 	/* Initialize the request struct. Initially, we assume a
 	 * long write-back delay. This will be adjusted in
 	 * update_nfs_request below if the region is not locked. */
-	req->wb_page    = page;
-	if (page) {
-		req->wb_index = page_index(page);
-		get_page(page);
-	}
-	req->wb_offset  = offset;
-	req->wb_pgbase	= pgbase;
-	req->wb_bytes   = count;
+	req->wb_pgbase = pgbase;
+	req->wb_index = index;
+	req->wb_offset = offset;
+	req->wb_bytes = count;
 	kref_init(&req->wb_kref);
 	req->wb_nio = 0;
 	return req;
 }
 
+static void nfs_page_assign_folio(struct nfs_page *req, struct folio *folio)
+{
+	if (folio != NULL) {
+		req->wb_folio = folio;
+		folio_get(folio);
+		set_bit(PG_FOLIO, &req->wb_flags);
+	}
+}
+
+static void nfs_page_assign_page(struct nfs_page *req, struct page *page)
+{
+	if (page != NULL) {
+		req->wb_page = page;
+		get_page(page);
+	}
+}
+
 /**
  * nfs_create_request - Create an NFS read/write request.
  * @ctx: open context to use
@@ -521,9 +533,11 @@ nfs_create_request(struct nfs_open_context *ctx, struct page *page,
 
 	if (IS_ERR(l_ctx))
 		return ERR_CAST(l_ctx);
-	ret = __nfs_create_request(l_ctx, page, offset, offset, count);
-	if (!IS_ERR(ret))
+	ret = nfs_page_create(l_ctx, offset, page_index(page), offset, count);
+	if (!IS_ERR(ret)) {
+		nfs_page_assign_page(ret, page);
 		nfs_page_group_init(ret, NULL);
+	}
 	nfs_put_lock_context(l_ctx);
 	return ret;
 }
@@ -536,11 +550,16 @@ nfs_create_subreq(struct nfs_page *req,
 {
 	struct nfs_page *last;
 	struct nfs_page *ret;
+	struct folio *folio = nfs_page_to_folio(req);
 	struct page *page = nfs_page_to_page(req, pgbase);
 
-	ret = __nfs_create_request(req->wb_lock_context, page, pgbase, offset,
-				   count);
+	ret = nfs_page_create(req->wb_lock_context, pgbase, req->wb_index,
+			      offset, count);
 	if (!IS_ERR(ret)) {
+		if (folio)
+			nfs_page_assign_folio(ret, folio);
+		else
+			nfs_page_assign_page(ret, page);
 		/* find the last request */
 		for (last = req->wb_head;
 		     last->wb_this_page != req->wb_head;
@@ -548,7 +567,6 @@ nfs_create_subreq(struct nfs_page *req,
 			;
 
 		nfs_lock_request(ret);
-		ret->wb_index = req->wb_index;
 		nfs_page_group_init(ret, last);
 		ret->wb_nio = req->wb_nio;
 	}
@@ -587,11 +605,16 @@ void nfs_unlock_and_release_request(struct nfs_page *req)
  */
 static void nfs_clear_request(struct nfs_page *req)
 {
+	struct folio *folio = nfs_page_to_folio(req);
 	struct page *page = req->wb_page;
 	struct nfs_lock_context *l_ctx = req->wb_lock_context;
 	struct nfs_open_context *ctx;
 
-	if (page != NULL) {
+	if (folio != NULL) {
+		folio_put(folio);
+		req->wb_folio = NULL;
+		clear_bit(PG_FOLIO, &req->wb_flags);
+	} else if (page != NULL) {
 		put_page(page);
 		req->wb_page = NULL;
 	}
@@ -1471,16 +1494,21 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 {
 	struct nfs_pgio_mirror *mirror;
 	struct nfs_page *prev;
+	struct folio *folio;
 	u32 midx;
 
 	for (midx = 0; midx < desc->pg_mirror_count; midx++) {
 		mirror = nfs_pgio_get_mirror(desc, midx);
 		if (!list_empty(&mirror->pg_list)) {
 			prev = nfs_list_entry(mirror->pg_list.prev);
-			if (index != prev->wb_index + 1) {
-				nfs_pageio_complete(desc);
-				break;
-			}
+			folio = nfs_page_to_folio(prev);
+			if (folio) {
+				if (index == folio_next_index(folio))
+					continue;
+			} else if (index == prev->wb_index + 1)
+				continue;
+			nfs_pageio_complete(desc);
+			break;
 		}
 	}
 }
-- 
2.39.0

