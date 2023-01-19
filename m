Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D3467456E
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjASWDM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjASWCf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56462C41E4
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4DC761D7F
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08747C433EF;
        Thu, 19 Jan 2023 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164420;
        bh=9rJoGpkdZvoBl+4z3ynCAkWGuEcYYf9evtX8FB8+HOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q9ilEHAfpDZiWoiZ7lnl433998OzJIyhtbVGTjmElbZMp6gr4NW4n+E9mGUtWufOD
         yy9tC6zP4jZUcT3JnPp7grgW5PrjdWeXwROV7jHEdxT3dk7uIt1HXPN6pW8ggWSaLm
         7Bg7FyyVp/3NSkGa6Vzp94UXNlhg1MHuuTsdU4VOlYgFGlGGCM09myDianUvmeIWGX
         vhLaLPX/L8y9AhGGY9RbnRJVoxl1KJf3nbEBxPphVqoKZjRrpXZRW2TrdsBGKn75o/
         mqrJWhx1RKDw6c9VQYQVwKl2FaVbq7C5rjqxnPo6xaUepO7tDNOiFaNAbJByTUp7/p
         ERSJGsjuSizlQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/18] NFS: Add a helper to convert a struct nfs_page into an inode
Date:   Thu, 19 Jan 2023 16:33:38 -0500
Message-Id: <20230119213351.443388-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-5-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
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

Replace all the open coded calls to page_file_mapping(req->wb_page)->host.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c        |  2 +-
 fs/nfs/write.c           |  7 +++----
 include/linux/nfs_page.h | 13 +++++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 16c146ca7ffc..4bdb570184f7 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -426,7 +426,7 @@ nfs_page_group_init(struct nfs_page *req, struct nfs_page *prev)
 		 * has extra ref from the write/commit path to handle handoff
 		 * between write and commit lists. */
 		if (test_bit(PG_INODE_REF, &prev->wb_head->wb_flags)) {
-			inode = page_file_mapping(req->wb_page)->host;
+			inode = nfs_page_to_inode(req);
 			set_bit(PG_INODE_REF, &req->wb_flags);
 			kref_get(&req->wb_kref);
 			atomic_long_inc(&NFS_I(inode)->nrequests);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 80c240e50952..1cbb92824791 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -421,7 +421,7 @@ static void nfs_set_page_writeback(struct page *page)
 
 static void nfs_end_page_writeback(struct nfs_page *req)
 {
-	struct inode *inode = page_file_mapping(req->wb_page)->host;
+	struct inode *inode = nfs_page_to_inode(req);
 	struct nfs_server *nfss = NFS_SERVER(inode);
 	bool is_done;
 
@@ -592,8 +592,7 @@ nfs_lock_and_join_requests(struct page *page)
 
 static void nfs_write_error(struct nfs_page *req, int error)
 {
-	trace_nfs_write_error(page_file_mapping(req->wb_page)->host, req,
-			      error);
+	trace_nfs_write_error(nfs_page_to_inode(req), req, error);
 	nfs_mapping_set_error(req->wb_page, error);
 	nfs_inode_remove_request(req);
 	nfs_end_page_writeback(req);
@@ -1420,7 +1419,7 @@ static void nfs_initiate_write(struct nfs_pgio_header *hdr,
  */
 static void nfs_redirty_request(struct nfs_page *req)
 {
-	struct nfs_inode *nfsi = NFS_I(page_file_mapping(req->wb_page)->host);
+	struct nfs_inode *nfsi = NFS_I(nfs_page_to_inode(req));
 
 	/* Bump the transmission count */
 	req->wb_nio++;
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index 192071a6e5f6..b0b03ec4a209 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -189,6 +189,19 @@ static inline struct page *nfs_page_to_page(const struct nfs_page *req,
 	return folio_page(folio, pgbase >> PAGE_SHIFT);
 }
 
+/**
+ * nfs_page_to_inode - Retrieve an inode for the request
+ * @req: pointer to a struct nfs_page
+ */
+static inline struct inode *nfs_page_to_inode(const struct nfs_page *req)
+{
+	struct folio *folio = nfs_page_to_folio(req);
+
+	if (folio == NULL)
+		return page_file_mapping(req->wb_page)->host;
+	return folio_file_mapping(folio)->host;
+}
+
 /**
  * nfs_page_max_length - Retrieve the maximum possible length for a request
  * @req: pointer to a struct nfs_page
-- 
2.39.0

