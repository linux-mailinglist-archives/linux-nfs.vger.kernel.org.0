Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603D52A32AF
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgKBSRZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgKBSRZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:25 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7DD22265
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341044;
        bh=dhy8SWVBTv52epzoDjAtFn5LTxuP0LqdundAR6q1KbM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PYNHqYBSQ1m3aJ1EDVcpw1hMAHMd2GprPgHxOAkrKNXHttMQLXbh/zVTldCVoqthU
         tmkQjsuqPy38sO5ZKUtqZGag/qOGulQq2IyAzmn9tQyVyhNv+6std4kGPdr0vwX9tc
         dpDcGPtMZM5s22fQx0quzFMHYQVKq0QRRKD6cb1k=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/12] NFS: Simplify struct nfs_cache_array_entry
Date:   Mon,  2 Nov 2020 13:06:54 -0500
Message-Id: <20201102180658.6218-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102180658.6218-8-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
 <20201102180658.6218-5-trondmy@kernel.org>
 <20201102180658.6218-6-trondmy@kernel.org>
 <20201102180658.6218-7-trondmy@kernel.org>
 <20201102180658.6218-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We don't need to store a hash, so replace struct qstr with a simple
const char pointer and length.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 46 +++++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index a91f9ea87611..c82f1bde4f13 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -133,7 +133,8 @@ nfs_closedir(struct inode *inode, struct file *filp)
 struct nfs_cache_array_entry {
 	u64 cookie;
 	u64 ino;
-	struct qstr string;
+	const char *name;
+	unsigned int name_len;
 	unsigned char d_type;
 };
 
@@ -192,7 +193,7 @@ void nfs_readdir_clear_array(struct page *page)
 
 	array = kmap_atomic(page);
 	for (i = 0; i < array->size; i++)
-		kfree(array->array[i].string.name);
+		kfree(array->array[i].name);
 	nfs_readdir_array_init(array);
 	kunmap_atomic(array);
 }
@@ -213,20 +214,17 @@ static bool nfs_readdir_array_is_full(struct nfs_cache_array *array)
  * when called by nfs_readdir_add_to_array, the strings will be freed in
  * nfs_clear_readdir_array()
  */
-static
-int nfs_readdir_make_qstr(struct qstr *string, const char *name, unsigned int len)
+static const char *nfs_readdir_copy_name(const char *name, unsigned int len)
 {
-	string->len = len;
-	string->name = kmemdup_nul(name, len, GFP_KERNEL);
-	if (string->name == NULL)
-		return -ENOMEM;
+	const char *ret = kmemdup_nul(name, len, GFP_KERNEL);
+
 	/*
 	 * Avoid a kmemleak false positive. The pointer to the name is stored
 	 * in a page cache page which kmemleak does not scan.
 	 */
-	kmemleak_not_leak(string->name);
-	string->hash = full_name_hash(NULL, name, len);
-	return 0;
+	if (ret != NULL)
+		kmemleak_not_leak(ret);
+	return ret;
 }
 
 /*
@@ -249,27 +247,34 @@ static int nfs_readdir_array_can_expand(struct nfs_cache_array *array)
 static
 int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 {
-	struct nfs_cache_array *array = kmap(page);
+	struct nfs_cache_array *array;
 	struct nfs_cache_array_entry *cache_entry;
+	const char *name;
 	int ret;
 
+	name = nfs_readdir_copy_name(entry->name, entry->len);
+	if (!name)
+		return -ENOMEM;
+
+	array = kmap_atomic(page);
 	ret = nfs_readdir_array_can_expand(array);
-	if (ret)
+	if (ret) {
+		kfree(name);
 		goto out;
+	}
 
 	cache_entry = &array->array[array->size];
 	cache_entry->cookie = entry->prev_cookie;
 	cache_entry->ino = entry->ino;
 	cache_entry->d_type = entry->d_type;
-	ret = nfs_readdir_make_qstr(&cache_entry->string, entry->name, entry->len);
-	if (ret)
-		goto out;
+	cache_entry->name_len = entry->len;
+	cache_entry->name = name;
 	array->last_cookie = entry->cookie;
 	array->size++;
 	if (entry->eof != 0)
 		nfs_readdir_array_set_eof(array);
 out:
-	kunmap(page);
+	kunmap_atomic(array);
 	return ret;
 }
 
@@ -409,9 +414,8 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 					if (printk_ratelimit()) {
 						pr_notice("NFS: directory %pD2 contains a readdir loop."
 								"Please contact your server vendor.  "
-								"The file: %.*s has duplicate cookie %llu\n",
-								desc->file, array->array[i].string.len,
-								array->array[i].string.name, desc->dir_cookie);
+								"The file: %s has duplicate cookie %llu\n",
+								desc->file, array->array[i].name, desc->dir_cookie);
 					}
 					status = -ELOOP;
 					goto out;
@@ -882,7 +886,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		struct nfs_cache_array_entry *ent;
 
 		ent = &array->array[i];
-		if (!dir_emit(desc->ctx, ent->string.name, ent->string.len,
+		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
 		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
 			desc->eof = true;
 			break;
-- 
2.28.0

