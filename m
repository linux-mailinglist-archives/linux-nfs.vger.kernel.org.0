Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4A2A69A7
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgKDQ1L (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1L (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:11 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44327C0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:11 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id 12so15909975qkl.8
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=cKSCPDB+ZJlQ0/xbh0s71VG8EqQc1gl1B4gKjfQUU6o=;
        b=FSeJ8ZGYtXi2/DIxDjnZy/tPw/iZ6FDlpFa0KTwbpmWplhJhO/VOzMPRLmwfApUK5u
         gCON5VeKjL3Ams7TvX4B80KsPxt3iVD0U8HZK3rfPqHqkaEE6/nfxiQ5l6vybmWDy3cT
         qruidVmuADl86K27umJELkbvLHGcveiGRsSeqMZsVbOIhgKOiIjoHn/AtzrV6SzzTRLz
         taYmSNM72NQcgk4eGwB5WMUjwbWmFFeXC7Nk/zPJsy2FWaFisWPFc3/APkRy42IgVr58
         Sbh/BKPLZ8bIKbAFYLdb4u8p2WiL94XNaSLEPPqYFPYL0F2EZmZmfVf6Rfk3L7Zk9Z4B
         diDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cKSCPDB+ZJlQ0/xbh0s71VG8EqQc1gl1B4gKjfQUU6o=;
        b=PjS2JIx0cOrOpBU0yJK4nyrJKKKHtAFMcIJZ4HDv7cYDfRX1HHswrdmE9ArHI3cXzg
         88ADMMpZfqhYCyDqCqET0OVUD0Ah81dgmPbo5nRdw9ku/8eixhMC7GromTDemT5PWBvW
         Blz9okUtWDZtNk+1kNmJXkK6KUMt+eyk5HGKY9eRDP8RkFZAMb86M10er5BLGyV/UL5B
         m0lbaKiIguHmaCEyUw0drwzYrOqMDmegT2hzGgWm1KuoKy6CslgSYWsa2NJ4vtCcTK5W
         YZ6+By+aTSzCuCWpoicnFT9wOwHYgiH1mgeEXdA3eKDCg3rwKryi/Uyyp50Y3eZAqRoE
         ihGg==
X-Gm-Message-State: AOAM533Suq//TTE1qmfsdc6WpYIYzterxR2qEADQs1xu2lObFJQfDEMk
        Q70IoJowOfQb0gVGfWnw6vdr/oNUMjky
X-Google-Smtp-Source: ABdhPJypCjEbr+ONpoZ81chXzEG/lPkQQOU6NXnGyLKCd32mWqcH4DH0lybH4kS0IYwNIEjaceZUCQ==
X-Received: by 2002:a37:6309:: with SMTP id x9mr26347362qkb.493.1604507230149;
        Wed, 04 Nov 2020 08:27:10 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.09
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:09 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 08/17] NFS: Simplify struct nfs_cache_array_entry
Date:   Wed,  4 Nov 2020 11:16:29 -0500
Message-Id: <20201104161638.300324-9-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-8-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
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
index b9001123ec84..be0e2891fecc 100644
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
 
@@ -413,9 +418,8 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
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
@@ -888,7 +892,7 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		struct nfs_cache_array_entry *ent;
 
 		ent = &array->array[i];
-		if (!dir_emit(desc->ctx, ent->string.name, ent->string.len,
+		if (!dir_emit(desc->ctx, ent->name, ent->name_len,
 		    nfs_compat_user_ino64(ent->ino), ent->d_type)) {
 			desc->eof = true;
 			break;
-- 
2.28.0

