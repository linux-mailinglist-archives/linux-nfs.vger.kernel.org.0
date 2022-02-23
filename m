Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CCE4C1D91
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242443AbiBWVUF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242403AbiBWVUD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17824ECC9
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A7A7618A0
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908E8C340EC
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651173;
        bh=YSlSxEp6sfdTAeiWJPOv6KCIoNl1N+23KqA1vIEZPNA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=L4WIoPOHAW5mXdcL61OFcp1HZeuKh0q22RikZTM5ev9rW+3DYp0xskq7aMH7zMIku
         r5+J5T1o+KXTQKf9DkKZlb9bhzCNKqtFeZfk7EXbLWNF1R3nVTKrBwQsvSgiEKjlj4
         VvckhG22YekPrp/r2DCEyjBHu9HUF7rPx3Zd7n7Z4Ip7b44Ieo4nToHfh59cdGldof
         TXqDlLxOjGIrnMBKS+weEC37gG10rpgtYpw6mU6tO1EC4hVDRmuIRZ5tLkXZ7xW1pX
         PJFqO5F13zur6w8h6x+QWlsJYO5esuIdvzv4fn6q6fLhfECY8hSWohWC9Xdsh2syDV
         VHsSNpZvekFSQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 05/21] NFS: Store the change attribute in the directory page cache
Date:   Wed, 23 Feb 2022 16:12:49 -0500
Message-Id: <20220223211305.296816-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-5-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
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

Use the change attribute and the first cookie in a directory page cache
entry to validate that the page is up to date.

Suggested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 68 ++++++++++++++++++++++++++++------------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index f2258e926df2..5d9367d9b651 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -139,6 +139,7 @@ struct nfs_cache_array_entry {
 };
 
 struct nfs_cache_array {
+	u64 change_attr;
 	u64 last_cookie;
 	unsigned int size;
 	unsigned char page_full : 1,
@@ -175,7 +176,8 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
 	memset(array, 0, sizeof(struct nfs_cache_array));
 }
 
-static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
+static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
+					u64 change_attr)
 {
 	struct nfs_cache_array *array;
 
@@ -207,7 +209,7 @@ nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 {
 	struct page *page = alloc_page(gfp_flags);
 	if (page)
-		nfs_readdir_page_init_array(page, last_cookie);
+		nfs_readdir_page_init_array(page, last_cookie, 0);
 	return page;
 }
 
@@ -304,19 +306,44 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static bool nfs_readdir_page_cookie_match(struct page *page, u64 last_cookie,
+					  u64 change_attr)
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
+		if (nfs_readdir_page_cookie_match(page, last_cookie,
+						  change_attr))
+			return page;
+		nfs_readdir_clear_array(page);
 	}
-
+	nfs_readdir_page_init_array(page, last_cookie, change_attr);
+	SetPageUptodate(page);
 	return page;
 }
 
@@ -356,12 +383,6 @@ static void nfs_readdir_page_set_eof(struct page *page)
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
@@ -418,16 +439,6 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
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
@@ -456,8 +467,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
 			new_pos = nfs_readdir_page_offset(desc->page) + i;
-			if (desc->attr_gencount != nfsi->attr_gencount ||
-			    !nfs_readdir_inode_mapping_valid(nfsi)) {
+			if (desc->attr_gencount != nfsi->attr_gencount) {
 				desc->duped = 0;
 				desc->attr_gencount = nfsi->attr_gencount;
 			} else if (new_pos < desc->prev_index) {
@@ -1094,11 +1104,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
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

