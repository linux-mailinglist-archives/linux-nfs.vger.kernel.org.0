Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F84C5FE1
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbiB0XTZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbiB0XTY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899D22502
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FA4DB80B9D
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26834C340E9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003924;
        bh=x1tD1yPfDJ0zpUOPWu1s4QVZ2XujnA+MjnbafFTQi/E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z/UEnuIi+5L+r0EYhIgJt5QNi85MQmIkmYaEq4tcQ3vIhv6jQO2MjtOlSTS2qQam8
         o4qvJOrr5puG0JS5BZbj/BK41nfhgd+aMQRUDrrlkotx8/5m+TSAV86s4pSJN2RUVc
         JrbSC77LDw//elD7ZCQp32WWLyqWD90i/tSsoFFbh/y7biPXW0/AsI6qOITJBdzweW
         aVvQsxwi3P84PXhyxaptgHx3kRadKEIU0Ro3/4Rv0JQxQBxX7rCuvtPm+Fov1uJpbX
         koWkpZSiclQB+OnOevv6KhaxnljGMP3G4Q9k81p8665kjQPna4tCIeIGlpbpZOfs0Y
         XaF/Fl+xROXIA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 26/27] NFS: Optimise away the previous cookie field
Date:   Sun, 27 Feb 2022 18:12:26 -0500
Message-Id: <20220227231227.9038-27-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-26-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
 <20220227231227.9038-14-trondmy@kernel.org>
 <20220227231227.9038-15-trondmy@kernel.org>
 <20220227231227.9038-16-trondmy@kernel.org>
 <20220227231227.9038-17-trondmy@kernel.org>
 <20220227231227.9038-18-trondmy@kernel.org>
 <20220227231227.9038-19-trondmy@kernel.org>
 <20220227231227.9038-20-trondmy@kernel.org>
 <20220227231227.9038-21-trondmy@kernel.org>
 <20220227231227.9038-22-trondmy@kernel.org>
 <20220227231227.9038-23-trondmy@kernel.org>
 <20220227231227.9038-24-trondmy@kernel.org>
 <20220227231227.9038-25-trondmy@kernel.org>
 <20220227231227.9038-26-trondmy@kernel.org>
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

Replace the 'previous cookie' field in struct nfs_entry with the
array->last_cookie.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c            | 26 ++++++++++++++------------
 fs/nfs/nfs2xdr.c        |  1 -
 fs/nfs/nfs3xdr.c        |  1 -
 fs/nfs/nfs4xdr.c        |  1 -
 include/linux/nfs_xdr.h |  3 +--
 5 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 5a2c98b2cc15..c2c847845464 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -296,19 +296,20 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 	return 0;
 }
 
-static
-int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
+static int nfs_readdir_page_array_append(struct page *page,
+					 const struct nfs_entry *entry,
+					 u64 *cookie)
 {
 	struct nfs_cache_array *array;
 	struct nfs_cache_array_entry *cache_entry;
 	const char *name;
-	int ret;
+	int ret = -ENOMEM;
 
 	name = nfs_readdir_copy_name(entry->name, entry->len);
-	if (!name)
-		return -ENOMEM;
 
 	array = kmap_atomic(page);
+	if (!name)
+		goto out;
 	ret = nfs_readdir_array_can_expand(array);
 	if (ret) {
 		kfree(name);
@@ -316,7 +317,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	}
 
 	cache_entry = &array->array[array->size];
-	cache_entry->cookie = entry->prev_cookie;
+	cache_entry->cookie = array->last_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
 	cache_entry->name_len = entry->len;
@@ -328,6 +329,7 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
 out:
+	*cookie = array->last_cookie;
 	kunmap_atomic(array);
 	return ret;
 }
@@ -791,6 +793,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	struct xdr_stream stream;
 	struct xdr_buf buf;
 	struct page *scratch, *new, *page = *arrays;
+	u64 cookie;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
@@ -812,22 +815,21 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			nfs_prime_dcache(file_dentry(desc->file), entry,
 					desc->dir_verifier);
 
-		status = nfs_readdir_add_to_array(entry, page);
+		status = nfs_readdir_page_array_append(page, entry, &cookie);
 		if (status != -ENOSPC)
 			continue;
 
 		if (page->mapping != mapping) {
 			if (!--narrays)
 				break;
-			new = nfs_readdir_page_array_alloc(entry->prev_cookie,
-							   GFP_KERNEL);
+			new = nfs_readdir_page_array_alloc(cookie, GFP_KERNEL);
 			if (!new)
 				break;
 			arrays++;
 			*arrays = page = new;
 		} else {
-			new = nfs_readdir_page_get_next(
-				mapping, entry->prev_cookie, change_attr);
+			new = nfs_readdir_page_get_next(mapping, cookie,
+							change_attr);
 			if (!new)
 				break;
 			if (page != *arrays)
@@ -835,7 +837,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			page = new;
 		}
 		desc->page_index_max++;
-		status = nfs_readdir_add_to_array(entry, page);
+		status = nfs_readdir_page_array_append(page, entry, &cookie);
 	} while (!status && !entry->eof);
 
 	switch (status) {
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 3d5ba43f44bb..05c3b4b2b3dd 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -955,7 +955,6 @@ int nfs2_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	 * The type (size and byte order) of nfscookie isn't defined in
 	 * RFC 1094.  This implementation assumes that it's an XDR uint32.
 	 */
-	entry->prev_cookie = entry->cookie;
 	p = xdr_inline_decode(xdr, 4);
 	if (unlikely(!p))
 		return -EAGAIN;
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index d6779ceeb39e..3b0b650c9c5a 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2024,7 +2024,6 @@ int nfs3_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 			zero_nfs_fh3(entry->fh);
 	}
 
-	entry->prev_cookie = entry->cookie;
 	entry->cookie = new_cookie;
 
 	return 0;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index b7780b97dc4d..86a5f6516928 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -7508,7 +7508,6 @@ int nfs4_decode_dirent(struct xdr_stream *xdr, struct nfs_entry *entry,
 	if (entry->fattr->valid & NFS_ATTR_FATTR_TYPE)
 		entry->d_type = nfs_umode_to_dtype(entry->fattr->mode);
 
-	entry->prev_cookie = entry->cookie;
 	entry->cookie = new_cookie;
 
 	return 0;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 728cb0c1f0b6..82f7c2730b9a 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -745,8 +745,7 @@ struct nfs_auth_info {
  */
 struct nfs_entry {
 	__u64			ino;
-	__u64			cookie,
-				prev_cookie;
+	__u64			cookie;
 	const char *		name;
 	unsigned int		len;
 	int			eof;
-- 
2.35.1

