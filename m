Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1624661097
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjAGRmM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGRmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC71111
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0455260B94
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A43BC433F0
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113328;
        bh=PnIJNi97MQcKeEh9IXkDIPFsdikR+gdWTzjJx/w77pA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Bs1aqnPJqfONJ1Ci3im5j3vIwTDw+VNPuyNUs0rjqxJEgM/MTTLXwefccRw2kyGxE
         pKpo5EsGFLJhzZjy+FpBPX4UCykvzru2cc18fSFftVbh2nTyyCs25OBN03dfLTYk6L
         A61XGuVeVyrfZFZsFbeE2IpxJfIdkO+Yf5lwbNYMmE8vEPu+WPoRDu7HOqxop8gS7h
         eSidJ1Zec6eLwoR9Dn9bq4yKItN9rTfOp7E5NsMHfeK0eQKDiMZsaBYeEZUS+UkJHX
         yofnNxxpQdNdrj4o5CiDPFZZTb1Nx7EaP/TAkMUgGG8HDQasrer6nLp3Dmf9Yi2T+A
         DmNVkAjJYdaxg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/17] NFS: Add basic functionality for tracking folios in struct nfs_page
Date:   Sat,  7 Jan 2023 12:36:20 -0500
Message-Id: <20230107173635.2025233-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-2-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        |  5 +++--
 include/linux/nfs_page.h | 38 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index b4b3e80e64cd..f496774d9d97 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -500,9 +500,10 @@ nfs_create_subreq(struct nfs_page *req,
 {
 	struct nfs_page *last;
 	struct nfs_page *ret;
+	struct page *page = nfs_page_to_page(req, pgbase);
 
-	ret = __nfs_create_request(req->wb_lock_context, req->wb_page,
-			pgbase, offset, count);
+	ret = __nfs_create_request(req->wb_lock_context, page, pgbase, offset,
+				   count);
 	if (!IS_ERR(ret)) {
 		/* find the last request */
 		for (last = req->wb_head;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index ba7e2e4b0926..d2ddc9a594c5 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -25,6 +25,7 @@
 enum {
 	PG_BUSY = 0,		/* nfs_{un}lock_request */
 	PG_MAPPED,		/* page private set for buffered io */
+	PG_FOLIO,		/* Tracking a folio (unset for O_DIRECT) */
 	PG_CLEAN,		/* write succeeded */
 	PG_COMMIT_TO_DS,	/* used by pnfs layouts */
 	PG_INODE_REF,		/* extra ref held by inode when in writeback */
@@ -41,7 +42,10 @@ enum {
 struct nfs_inode;
 struct nfs_page {
 	struct list_head	wb_list;	/* Defines state of page: */
-	struct page		*wb_page;	/* page to read in/write out */
+	union {
+		struct page	*wb_page;	/* page to read in/write out */
+		struct folio	*wb_folio;
+	};
 	struct nfs_lock_context	*wb_lock_context;	/* lock context info */
 	pgoff_t			wb_index;	/* Offset >> PAGE_SHIFT */
 	unsigned int		wb_offset,	/* Offset & ~PAGE_MASK */
@@ -153,6 +157,38 @@ extern	int nfs_page_set_headlock(struct nfs_page *req);
 extern void nfs_page_clear_headlock(struct nfs_page *req);
 extern bool nfs_async_iocounter_wait(struct rpc_task *, struct nfs_lock_context *);
 
+/**
+ * nfs_page_to_folio - Retrieve a struct folio for the request
+ * @req: pointer to a struct nfs_page
+ *
+ * If a folio was assigned to @req, then return it, otherwise return NULL.
+ */
+static inline struct folio *nfs_page_to_folio(const struct nfs_page *req)
+{
+	if (test_bit(PG_FOLIO, &req->wb_flags))
+		return req->wb_folio;
+	return NULL;
+}
+
+/**
+ * nfs_page_to_page - Retrieve a struct page for the request
+ * @req: pointer to a struct nfs_page
+ * @pgbase: folio byte offset
+ *
+ * Return the page containing the byte that is at offset @pgbase relative
+ * to the start of the folio.
+ * Note: The request starts at offset @req->wb_pgbase.
+ */
+static inline struct page *nfs_page_to_page(const struct nfs_page *req,
+					    size_t pgbase)
+{
+	struct folio *folio = nfs_page_to_folio(req);
+
+	if (folio == NULL)
+		return req->wb_page;
+	return folio_page(folio, pgbase >> PAGE_SHIFT);
+}
+
 /*
  * Lock the page of an asynchronous request
  */
-- 
2.39.0

