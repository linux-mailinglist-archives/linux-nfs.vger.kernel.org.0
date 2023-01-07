Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEEF66109D
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjAGRmP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjAGRmP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CFEB91
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7776B80139
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E50EC433EF
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113331;
        bh=eeJcFpFh4ocFW0njBQuDY0es/RJO+nAhvHS8VpnwhWI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WItv+Ppt/P4oi8/llPB+1Z112CnvXVdSSSqFd6v/hy0DQ26J0d/5J3XeeGMnWCKm6
         zxI+dQNQ314yx8iL7zgBkq6mvVNkKtsaARCRargHTnSlY8XAuD/hKdqqTaNupqJKCh
         ePRL+hFt+ZObmPXVKit/tO1QHu5CITlaBbBvXI27jTcIMnlEbSJ6p5owSiXq/En6du
         ChNnrW3UC0ZW+TdrWjvoW0oArHpcVpv9zoFI2I0yI/kgCMxnWVqYmG0aTS0ryxuway
         FBT9qUdBnJQoM+Sv9Sp6o2/gxGe/48ws1RTFxASoeP8iRcB+W+IvLIT6hM+qMBiioi
         vl3wzyGLqyuTQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/17] NFS: Convert the function nfs_wb_page() to use folios
Date:   Sat,  7 Jan 2023 12:36:27 -0500
Message-Id: <20230107173635.2025233-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230107173635.2025233-9-trondmy@kernel.org>
References: <20230107173635.2025233-1-trondmy@kernel.org>
 <20230107173635.2025233-2-trondmy@kernel.org>
 <20230107173635.2025233-3-trondmy@kernel.org>
 <20230107173635.2025233-4-trondmy@kernel.org>
 <20230107173635.2025233-5-trondmy@kernel.org>
 <20230107173635.2025233-6-trondmy@kernel.org>
 <20230107173635.2025233-7-trondmy@kernel.org>
 <20230107173635.2025233-8-trondmy@kernel.org>
 <20230107173635.2025233-9-trondmy@kernel.org>
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
 fs/nfs/write.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 0fbb119022d9..14f98c452595 100644
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
+			ret = nfs_writepage_locked(folio, &wbc);
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

