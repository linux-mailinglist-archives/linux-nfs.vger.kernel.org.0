Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6952674575
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jan 2023 23:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjASWDW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Jan 2023 17:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjASWCk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Jan 2023 17:02:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C2CC41F5
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 13:40:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4426A61D84
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74347C433F1;
        Thu, 19 Jan 2023 21:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164422;
        bh=4/4I6sCY4E/uPcUZWLR+fcZEcbmWOVB26502wIU2hZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNwapJg0hcc1e2OPxxq9K4gTN5wOXk5sRT5xz2G6XtHCQbxhCQEc8o/Dev79EnAVR
         fDTiRnia4LPDMc1gt472HMroXwoN7RwzNHma8hCGkeWMsIPHV498xH11z8svXuyIA1
         Bbcv04EGrpCC6KLKb0PfaLDiuBbJ6fg3ZWyVvvXJHQt9WP4SpVZiKd9JBVQzGsSqiH
         4etA+ffzkUhaWOlFc4L3n1H88ikdVRaWko9ICPes8YSl/J7i1Xp6X+a2MqaP9AOAQK
         y97ykppxSGUYQTFKjlDxhV56aRonyd7MprTEPmsqOJ976SGR+eN+sLE5LIFuDlEmQH
         8vDSKJlEcFXJQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 09/18] NFS: Convert the function nfs_wb_page() to use folios
Date:   Thu, 19 Jan 2023 16:33:42 -0500
Message-Id: <20230119213351.443388-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119213351.443388-9-trondmy@kernel.org>
References: <20230119213351.443388-1-trondmy@kernel.org>
 <20230119213351.443388-2-trondmy@kernel.org>
 <20230119213351.443388-3-trondmy@kernel.org>
 <20230119213351.443388-4-trondmy@kernel.org>
 <20230119213351.443388-5-trondmy@kernel.org>
 <20230119213351.443388-6-trondmy@kernel.org>
 <20230119213351.443388-7-trondmy@kernel.org>
 <20230119213351.443388-8-trondmy@kernel.org>
 <20230119213351.443388-9-trondmy@kernel.org>
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

Convert to use the folio functions, but pass the struct page to
nfs_writepage_locked() for now.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/write.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c80a57801b2e..0d63f03436d3 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2069,13 +2069,18 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 	return ret;
 }
 
-/*
- * Write back all requests on one page - we do this before reading it.
+/**
+ * nfs_wb_folio - Write back all requests on one page
+ * @inode: pointer to page
+ * @folio: pointer to folio
+ *
+ * Assumes that the folio has been locked by the caller, and will
+ * not unlock it.
  */
-int nfs_wb_page(struct inode *inode, struct page *page)
+int nfs_wb_folio(struct inode *inode, struct folio *folio)
 {
-	loff_t range_start = page_file_offset(page);
-	loff_t range_end = range_start + (loff_t)(PAGE_SIZE - 1);
+	loff_t range_start = folio_file_pos(folio);
+	loff_t range_end = range_start + (loff_t)folio_size(folio) - 1;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = 0,
@@ -2087,15 +2092,15 @@ int nfs_wb_page(struct inode *inode, struct page *page)
 	trace_nfs_writeback_page_enter(inode);
 
 	for (;;) {
-		wait_on_page_writeback(page);
-		if (clear_page_dirty_for_io(page)) {
-			ret = nfs_writepage_locked(page, &wbc);
+		folio_wait_writeback(folio);
+		if (folio_clear_dirty_for_io(folio)) {
+			ret = nfs_writepage_locked(&folio->page, &wbc);
 			if (ret < 0)
 				goto out_error;
 			continue;
 		}
 		ret = 0;
-		if (!PagePrivate(page))
+		if (!folio_test_private(folio))
 			break;
 		ret = nfs_commit_inode(inode, FLUSH_SYNC);
 		if (ret < 0)
@@ -2106,17 +2111,9 @@ int nfs_wb_page(struct inode *inode, struct page *page)
 	return ret;
 }
 
-/**
- * nfs_wb_folio - Write back all requests on one page
- * @inode: pointer to page
- * @folio: pointer to folio
- *
- * Assumes that the folio has been locked by the caller, and will
- * not unlock it.
- */
-int nfs_wb_folio(struct inode *inode, struct folio *folio)
+int nfs_wb_page(struct inode *inode, struct page *page)
 {
-	return nfs_wb_page(inode, &folio->page);
+	return nfs_wb_folio(inode, page_folio(page));
 }
 
 #ifdef CONFIG_MIGRATION
-- 
2.39.0

