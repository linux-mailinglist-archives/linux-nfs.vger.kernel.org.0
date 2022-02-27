Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0781B4C5FC9
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiB0XTQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbiB0XTP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BD322527
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5AB5611D4
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE57C340E9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003916;
        bh=F6cIFzb322lA5LYmOGHKbW31HBMZnxMHH/samvy5LRg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=n+EbAYDEcWODmLs3lf5hxkfQ85Zpv80MVy8tg8j9e6RaMoNGO5n5FlfIiTXGhpa9p
         QOq6ddNRTh1jnDalzIbGwzTxF5AWoPVk3gEVGYgh0dZ7CHarBKDDpF52LCGhIl+tKs
         /Ed6IF2zgHGCx5GA9oJ0Wm4v58b6e/LIOkx2ssISblGqNoSabA+DA7OvQIwxLcRYMt
         Z+8v99cMY3bhe5Bpp+IgJqAtmJH1KPl9r2/Rhuz14cjQ5FKp1sQbfMzuh8WKtpa8og
         shWauK2OFF6vgpd7xEkbMJjeE0wH2zLe2Si0rCPORY08d00knlkP/8rMQWYlvcxXxw
         pNuW6wz56eHoQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 07/27] NFS: Store the change attribute in the directory page cache
Date:   Sun, 27 Feb 2022 18:12:07 -0500
Message-Id: <20220227231227.9038-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-7-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Use the change attribute and the first cookie in a directory page cache
entry to validate that the page is up to date.

Suggested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 68 ++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6f0a38db6c37..bfb553c57274 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -140,6 +140,7 @@ struct nfs_cache_array_entry {
 };
 
 struct nfs_cache_array {
+	u64 change_attr;
 	u64 last_cookie;
 	unsigned int size;
 	unsigned char page_full : 1,
@@ -176,12 +177,14 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
 	memset(array, 0, sizeof(struct nfs_cache_array));
 }
 
-static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
+static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
+					u64 change_attr)
 {
 	struct nfs_cache_array *array;
 
 	array = kmap_atomic(page);
 	nfs_readdir_array_init(array);
+	array->change_attr = change_attr;
 	array->last_cookie = last_cookie;
 	array->cookies_are_ordered = 1;
 	kunmap_atomic(array);
@@ -208,7 +211,7 @@ nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 {
 	struct page *page = alloc_page(gfp_flags);
 	if (page)
-		nfs_readdir_page_init_array(page, last_cookie);
+		nfs_readdir_page_init_array(page, last_cookie, 0);
 	return page;
 }
 
@@ -305,19 +308,43 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static bool nfs_readdir_page_validate(struct page *page, u64 last_cookie,
+				      u64 change_attr)
+{
+	struct nfs_cache_array *array = kmap_atomic(page);
+	int ret = true;
+
+	if (array->change_attr != change_attr)
+		ret = false;
+	if (array->size > 0 && array->array[0].cookie != last_cookie)
+		ret = false;
+	kunmap_atomic(array);
+	return ret;
+}
+
+static void nfs_readdir_page_unlock_and_put(struct page *page)
+{
+	unlock_page(page);
+	put_page(page);
+}
+
 static struct page *nfs_readdir_page_get_locked(struct address_space *mapping,
 						pgoff_t index, u64 last_cookie)
 {
 	struct page *page;
+	u64 change_attr;
 
 	page = grab_cache_page(mapping, index);
-	if (page && !PageUptodate(page)) {
-		nfs_readdir_page_init_array(page, last_cookie);
-		if (invalidate_inode_pages2_range(mapping, index + 1, -1) < 0)
-			nfs_zap_mapping(mapping->host, mapping);
-		SetPageUptodate(page);
+	if (!page)
+		return NULL;
+	change_attr = inode_peek_iversion_raw(mapping->host);
+	if (PageUptodate(page)) {
+		if (nfs_readdir_page_validate(page, last_cookie, change_attr))
+			return page;
+		nfs_readdir_clear_array(page);
 	}
-
+	nfs_readdir_page_init_array(page, last_cookie, change_attr);
+	SetPageUptodate(page);
 	return page;
 }
 
@@ -357,12 +384,6 @@ static void nfs_readdir_page_set_eof(struct page *page)
 	kunmap_atomic(array);
 }
 
-static void nfs_readdir_page_unlock_and_put(struct page *page)
-{
-	unlock_page(page);
-	put_page(page);
-}
-
 static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
 					      pgoff_t index, u64 cookie)
 {
@@ -419,16 +440,6 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
 	return -EBADCOOKIE;
 }
 
-static bool
-nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
-{
-	if (nfsi->cache_validity & (NFS_INO_INVALID_CHANGE |
-				    NFS_INO_INVALID_DATA))
-		return false;
-	smp_rmb();
-	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
-}
-
 static bool nfs_readdir_array_cookie_in_range(struct nfs_cache_array *array,
 					      u64 cookie)
 {
@@ -457,8 +468,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
 			new_pos = nfs_readdir_page_offset(desc->page) + i;
-			if (desc->attr_gencount != nfsi->attr_gencount ||
-			    !nfs_readdir_inode_mapping_valid(nfsi)) {
+			if (desc->attr_gencount != nfsi->attr_gencount) {
 				desc->duped = 0;
 				desc->attr_gencount = nfsi->attr_gencount;
 			} else if (new_pos < desc->prev_index) {
@@ -1095,11 +1105,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode)) {
-		res = nfs_revalidate_mapping(inode, file->f_mapping);
-		if (res < 0)
-			goto out;
-	}
+	nfs_revalidate_inode(inode, NFS_INO_INVALID_CHANGE);
 
 	res = -ENOMEM;
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-- 
2.35.1

