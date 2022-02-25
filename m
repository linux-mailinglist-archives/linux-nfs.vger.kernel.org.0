Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658714C4DD9
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiBYSfU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2591A9065
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EE425B83310
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DDA5C340F2
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814078;
        bh=wyphtBVOrciOafgkmSmjOTa2CK88i7ifLzxtXSYTGKs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tm+qgWyRBURKvIDtcoRHTGMvYwuDEqAoWwiCxT+uP/S5oVvHNfjQM6jKV/ZbWcFPE
         kcGk1YoO1pNhWNFBepxN+y+AVfJ+1tUYYHJxt5iKBGPifcI3Bsjz4/CLRvK6tPqrWw
         kPC03hMaMo6cUv885TLdin1SIae61r0WxifbbZOdKtq1vno+JSAx8+4jOjAyKg8kAl
         nGgk+MQrgrYh2mF3Yw+kf0ua3SCEvW3lFww8YLIm1EXTABSLpnDlQuJI0ZMeFmNzf5
         RIAJwkkoiBr4RhPoIr3eubpDfv3HN5HvtHImXYoVRvCplVdlrjhaWUgtGnVAyUlBtB
         WDVYdGIKGvNuw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 07/24] NFS: Store the change attribute in the directory page cache
Date:   Fri, 25 Feb 2022 13:28:12 -0500
Message-Id: <20220225182829.1236093-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-7-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
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
 fs/nfs/dir.c | 67 ++++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 6f0a38db6c37..8cab7edd7420 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -140,6 +140,7 @@ struct nfs_cache_array_entry {
 };
 
 struct nfs_cache_array {
+	u64 change_attr;
 	u64 last_cookie;
 	unsigned int size;
 	unsigned char page_full : 1,
@@ -176,7 +177,8 @@ static void nfs_readdir_array_init(struct nfs_cache_array *array)
 	memset(array, 0, sizeof(struct nfs_cache_array));
 }
 
-static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie)
+static void nfs_readdir_page_init_array(struct page *page, u64 last_cookie,
+					u64 change_attr)
 {
 	struct nfs_cache_array *array;
 
@@ -208,7 +210,7 @@ nfs_readdir_page_array_alloc(u64 last_cookie, gfp_t gfp_flags)
 {
 	struct page *page = alloc_page(gfp_flags);
 	if (page)
-		nfs_readdir_page_init_array(page, last_cookie);
+		nfs_readdir_page_init_array(page, last_cookie, 0);
 	return page;
 }
 
@@ -305,19 +307,43 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
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
 
@@ -357,12 +383,6 @@ static void nfs_readdir_page_set_eof(struct page *page)
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
@@ -419,16 +439,6 @@ static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
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
@@ -457,8 +467,7 @@ static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
 
 			new_pos = nfs_readdir_page_offset(desc->page) + i;
-			if (desc->attr_gencount != nfsi->attr_gencount ||
-			    !nfs_readdir_inode_mapping_valid(nfsi)) {
+			if (desc->attr_gencount != nfsi->attr_gencount) {
 				desc->duped = 0;
 				desc->attr_gencount = nfsi->attr_gencount;
 			} else if (new_pos < desc->prev_index) {
@@ -1095,11 +1104,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
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

