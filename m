Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5326F4D7718
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235117AbiCMRNT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbiCMRNR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11481139CDC
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C376DB80CB3
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D63C340EE
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191526;
        bh=nAkgAnoC68H8WXGvb3X6kwP1/KNqjLl8An7UgPcZqUI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=r0XDu+/cdL+ZTtm90dvjwvz8KfHLHqIzNq8SYtWMrqi8daFLMBx0Yoz7xmykgByoT
         27k6qM8rrqDPDAbWHTVT6y9hM24sE0qhYPd2sJkQ4T+0MKxMTGCulbagsBwAT62zDc
         UPaaAaul7GiJuRyWrNtrBUxwXk3VfOOrS6i7AxI882MLLG6R+YB7VZ5XWeKiXnnuSH
         oY3sM6VpWFXCEZpCG1YUs5hm6FarZBfmqKQmVzgDRWJo6jkhdh88Crf/48MdmB8ICX
         YrHRZQWwqWg4K4rbrhjt30418VXiI4gN1FeoAWuR110tvcgpadrUuvVKlLikHC5D4U
         tZsHwBvSNwTiA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 07/26] NFS: Store the change attribute in the directory page cache
Date:   Sun, 13 Mar 2022 13:05:38 -0400
Message-Id: <20220313170557.5940-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313170557.5940-7-trondmy@kernel.org>
References: <20220313170557.5940-1-trondmy@kernel.org>
 <20220313170557.5940-2-trondmy@kernel.org>
 <20220313170557.5940-3-trondmy@kernel.org>
 <20220313170557.5940-4-trondmy@kernel.org>
 <20220313170557.5940-5-trondmy@kernel.org>
 <20220313170557.5940-6-trondmy@kernel.org>
 <20220313170557.5940-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 6f0a38db6c37..a1767f755460 100644
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
+	nfs_revalidate_mapping(inode, file->f_mapping);
 
 	res = -ENOMEM;
 	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
-- 
2.35.1

