Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5424C1D94
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242398AbiBWVUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiBWVUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D6C4ECC7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E81D56189F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27877C340E7
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651173;
        bh=BDtVy5SNX6exg3u/FD6tPHlS7Ace5WAEZPBUVrHFAsI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HY7kUNRmMBazv8m5jd2YrPEMLakbDqEHepHDOqD+IOTFqFbiMHYN8ETC7z6PpKbzw
         POC1eWGMhc2oyB213GNo1qt4KeoQCHhvm7TnnhJdCyJvu4YDLL3coyRlw8QbbUOcOC
         5lADKXhR0vEUp7n3QeJu7jqOm7EQ4aHv0/bkpF/dVoucuJWjLGqphQhBDmRnHq9TUA
         v0JHV6x+tMZNssRbcDXWpmO0AYc5x+IVZYolYdxcHHzncY7dCA1ifOLt4/QGZnNCsU
         qKO1poxbkjOqQdZeS7B73YDIgHEa93/PXj8aMmxs4dxkWoN+l4QhGWlDHH1qUXbU1r
         qL1aSWbM2nbyg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 04/21] NFS: Calculate page offsets algorithmically
Date:   Wed, 23 Feb 2022 16:12:48 -0500
Message-Id: <20220223211305.296816-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-4-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Instead of relying on counting the page offsets as we walk through the
page cache, switch to calculating them algorithmically.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8f17aaebcd77..f2258e926df2 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -248,17 +248,20 @@ static const char *nfs_readdir_copy_name(const char *name, unsigned int len)
 	return ret;
 }
 
+static size_t nfs_readdir_array_maxentries(void)
+{
+	return (PAGE_SIZE - sizeof(struct nfs_cache_array)) /
+	       sizeof(struct nfs_cache_array_entry);
+}
+
 /*
  * Check that the next array entry lies entirely within the page bounds
  */
 static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 {
-	struct nfs_cache_array_entry *cache_entry;
-
 	if (array->page_full)
 		return -ENOSPC;
-	cache_entry = &array->array[array->size + 1];
-	if ((char *)cache_entry - (char *)array > PAGE_SIZE) {
+	if (array->size == nfs_readdir_array_maxentries()) {
 		array->page_full = 1;
 		return -ENOSPC;
 	}
@@ -317,6 +320,11 @@ static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 	return page;
 }
 
+static loff_t nfs_readdir_page_offset(struct page *page)
+{
+	return (loff_t)page->index * (loff_t)nfs_readdir_array_maxentries();
+}
+
 static u64 nfs_readdir_page_last_cookie(struct page *page)
 {
 	struct nfs_cache_array *array;
@@ -447,7 +455,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
-			new_pos = desc->current_index + i;
+			new_pos = nfs_readdir_page_offset(desc->page) + i;
 			if (desc->attr_gencount != nfsi->attr_gencount ||
 			    !nfs_readdir_inode_mapping_valid(nfsi)) {
 				desc->duped = 0;
-- 
2.35.1

