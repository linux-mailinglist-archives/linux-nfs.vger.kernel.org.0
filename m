Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A3C2A699E
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgKDQ1E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgKDQ1D (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:03 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FFEC0613D3
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:03 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r8so12562512qtp.13
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iVOPQh/Nw9au0O2zbDnw8gr6il9f7JgK6I5cvBRdmLQ=;
        b=kONCFN3KdretUHUraqryE4iv2IhWxZN4rCHMJ33daWrcT5w5IX76WWufUMufpCGXJL
         F7YeA9C4zXeHkV6ERr5i1svwramXESH+vUgnsy6keVQm9yMQ0aLK3F4x3rmnVdw3CsgC
         82IeyOG0AwQCDa2wDcgR56O11tXFBSjyYAUJdIF9zO5LkkLN0CixeXNuEy/EHZNQRysJ
         H6L3kvG1qUax16rrLlvKNXk+AmCfcQ+EYHg+yF82mcPsRUjczNoIt5/hlHsidzUw9NKK
         2+4Ki9cHcwncjjoZCHsPLFflPOSH1N0M7ZmAYjz9yb7ZedcwCfZj5Mp3YDx1LYD1VPbP
         IU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVOPQh/Nw9au0O2zbDnw8gr6il9f7JgK6I5cvBRdmLQ=;
        b=fmhRLKlQo6sprSzFu9nY8pdwPZR76SnMICHJmMP4hLSvT8fwFkv1He02GzOJ9rm0VT
         b9j3GJSljfzWFQtOKTs3oSOAdDximLPiSaIyJ4dbutMzjf9a9iUnl+8PyveiT0R8vtm4
         aYrEayE1jkyptDiNUmtJnuCLmS7+3FMhFr0CkV6q6RclLpEK5xtwz96hx0Zt+fDneVC3
         olOr7joPv5VHjlvn1a5qf7NmtUMQkQQzCkkCZt/g9MO74gVYIFY1UflakDsoEV8nH9LS
         RGQcStIVmPhe97J3JwtMFaGKXaZAIgl5f/Ak0ZteRpnEFs6wkOVxmrDcHj0+IPqb6Qu3
         tecA==
X-Gm-Message-State: AOAM532bMHk7gaB7ysq85NkUU6wIxo6qfEmbl0Xb6gNHasd5+weHTkBL
        Gq5Nyqwp6WzH69tr68SyVgrvR25azQbj
X-Google-Smtp-Source: ABdhPJwdVrEOMYwmRma9aqDCzE/vyfXvWVVUc5O1zZCO8ZT+HUQSsWrMBSNx6F2YehcuQ5dcKj55CQ==
X-Received: by 2002:ac8:6752:: with SMTP id n18mr2325975qtp.204.1604507222141;
        Wed, 04 Nov 2020 08:27:02 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.00
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:01 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 01/17] NFS: Ensure contents of struct nfs_open_dir_context are consistent
Date:   Wed,  4 Nov 2020 11:16:22 -0500
Message-Id: <20201104161638.300324-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that the contents of struct nfs_open_dir_context are consistent
by setting them under the file->f_lock from a private copy (that is
known to be consistent).

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 72 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4e011adaf967..67d8595cd6e5 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,20 +144,23 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
-typedef struct {
+typedef struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
 	unsigned long	page_index;
-	u64		*dir_cookie;
+	u64		dir_cookie;
 	u64		last_cookie;
+	u64		dup_cookie;
 	loff_t		current_index;
 	loff_t		prev_index;
 
 	unsigned long	dir_verifier;
 	unsigned long	timestamp;
 	unsigned long	gencount;
+	unsigned long	attr_gencount;
 	unsigned int	cache_entry_index;
+	signed char duped;
 	bool plus;
 	bool eof;
 } nfs_readdir_descriptor_t;
@@ -273,7 +276,7 @@ int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descri
 	}
 
 	index = (unsigned int)diff;
-	*desc->dir_cookie = array->array[index].cookie;
+	desc->dir_cookie = array->array[index].cookie;
 	desc->cache_entry_index = index;
 	return 0;
 out_eof:
@@ -298,33 +301,32 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 	int status = -EAGAIN;
 
 	for (i = 0; i < array->size; i++) {
-		if (array->array[i].cookie == *desc->dir_cookie) {
+		if (array->array[i].cookie == desc->dir_cookie) {
 			struct nfs_inode *nfsi = NFS_I(file_inode(desc->file));
-			struct nfs_open_dir_context *ctx = desc->file->private_data;
 
 			new_pos = desc->current_index + i;
-			if (ctx->attr_gencount != nfsi->attr_gencount ||
+			if (desc->attr_gencount != nfsi->attr_gencount ||
 			    !nfs_readdir_inode_mapping_valid(nfsi)) {
-				ctx->duped = 0;
-				ctx->attr_gencount = nfsi->attr_gencount;
+				desc->duped = 0;
+				desc->attr_gencount = nfsi->attr_gencount;
 			} else if (new_pos < desc->prev_index) {
-				if (ctx->duped > 0
-				    && ctx->dup_cookie == *desc->dir_cookie) {
+				if (desc->duped > 0
+				    && desc->dup_cookie == desc->dir_cookie) {
 					if (printk_ratelimit()) {
 						pr_notice("NFS: directory %pD2 contains a readdir loop."
 								"Please contact your server vendor.  "
 								"The file: %.*s has duplicate cookie %llu\n",
 								desc->file, array->array[i].string.len,
-								array->array[i].string.name, *desc->dir_cookie);
+								array->array[i].string.name, desc->dir_cookie);
 					}
 					status = -ELOOP;
 					goto out;
 				}
-				ctx->dup_cookie = *desc->dir_cookie;
-				ctx->duped = -1;
+				desc->dup_cookie = desc->dir_cookie;
+				desc->duped = -1;
 			}
 			if (nfs_readdir_use_cookie(desc->file))
-				desc->ctx->pos = *desc->dir_cookie;
+				desc->ctx->pos = desc->dir_cookie;
 			else
 				desc->ctx->pos = new_pos;
 			desc->prev_index = new_pos;
@@ -334,7 +336,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 	}
 	if (array->eof_index >= 0) {
 		status = -EBADCOOKIE;
-		if (*desc->dir_cookie == array->last_cookie)
+		if (desc->dir_cookie == array->last_cookie)
 			desc->eof = true;
 	}
 out:
@@ -349,7 +351,7 @@ int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
 
 	array = kmap(desc->page);
 
-	if (*desc->dir_cookie == 0)
+	if (desc->dir_cookie == 0)
 		status = nfs_readdir_search_for_pos(array, desc);
 	else
 		status = nfs_readdir_search_for_cookie(array, desc);
@@ -801,7 +803,6 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 	int i = 0;
 	int res = 0;
 	struct nfs_cache_array *array = NULL;
-	struct nfs_open_dir_context *ctx = file->private_data;
 
 	array = kmap(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
@@ -814,22 +815,22 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 			break;
 		}
 		if (i < (array->size-1))
-			*desc->dir_cookie = array->array[i+1].cookie;
+			desc->dir_cookie = array->array[i+1].cookie;
 		else
-			*desc->dir_cookie = array->last_cookie;
+			desc->dir_cookie = array->last_cookie;
 		if (nfs_readdir_use_cookie(file))
-			desc->ctx->pos = *desc->dir_cookie;
+			desc->ctx->pos = desc->dir_cookie;
 		else
 			desc->ctx->pos++;
-		if (ctx->duped != 0)
-			ctx->duped = 1;
+		if (desc->duped != 0)
+			desc->duped = 1;
 	}
 	if (array->eof_index >= 0)
 		desc->eof = true;
 
 	kunmap(desc->page);
 	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n",
-			(unsigned long long)*desc->dir_cookie, res);
+			(unsigned long long)desc->dir_cookie, res);
 	return res;
 }
 
@@ -851,10 +852,9 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	struct page	*page = NULL;
 	int		status;
 	struct inode *inode = file_inode(desc->file);
-	struct nfs_open_dir_context *ctx = desc->file->private_data;
 
 	dfprintk(DIRCACHE, "NFS: uncached_readdir() searching for cookie %Lu\n",
-			(unsigned long long)*desc->dir_cookie);
+			(unsigned long long)desc->dir_cookie);
 
 	page = alloc_page(GFP_HIGHUSER);
 	if (!page) {
@@ -863,9 +863,9 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	}
 
 	desc->page_index = 0;
-	desc->last_cookie = *desc->dir_cookie;
+	desc->last_cookie = desc->dir_cookie;
 	desc->page = page;
-	ctx->duped = 0;
+	desc->duped = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, page, inode);
 	if (status < 0)
@@ -894,7 +894,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	nfs_readdir_descriptor_t my_desc = {
 		.file = file,
 		.ctx = ctx,
-		.dir_cookie = &dir_ctx->dir_cookie,
 		.plus = nfs_use_readdirplus(inode, ctx),
 	},
 			*desc = &my_desc;
@@ -915,13 +914,20 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	if (res < 0)
 		goto out;
 
+	spin_lock(&file->f_lock);
+	desc->dir_cookie = dir_ctx->dir_cookie;
+	desc->dup_cookie = dir_ctx->dup_cookie;
+	desc->duped = dir_ctx->duped;
+	desc->attr_gencount = dir_ctx->attr_gencount;
+	spin_unlock(&file->f_lock);
+
 	do {
 		res = readdir_search_pagecache(desc);
 
 		if (res == -EBADCOOKIE) {
 			res = 0;
 			/* This means either end of directory */
-			if (*desc->dir_cookie && !desc->eof) {
+			if (desc->dir_cookie && !desc->eof) {
 				/* Or that the server has 'lost' a cookie */
 				res = uncached_readdir(desc);
 				if (res == 0)
@@ -946,6 +952,14 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		if (res < 0)
 			break;
 	} while (!desc->eof);
+
+	spin_lock(&file->f_lock);
+	dir_ctx->dir_cookie = desc->dir_cookie;
+	dir_ctx->dup_cookie = desc->dup_cookie;
+	dir_ctx->duped = desc->duped;
+	dir_ctx->attr_gencount = desc->attr_gencount;
+	spin_unlock(&file->f_lock);
+
 out:
 	if (res > 0)
 		res = 0;
-- 
2.28.0

