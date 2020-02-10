Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94A17158334
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Feb 2020 20:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBJTB7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Feb 2020 14:01:59 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40200 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgBJTB7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Feb 2020 14:01:59 -0500
Received: by mail-yw1-f66.google.com with SMTP id i126so3918629ywe.7
        for <linux-nfs@vger.kernel.org>; Mon, 10 Feb 2020 11:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3aTTcTTQRTwfDNsiN9EuNcVVxYAi8YGgFB6Ju05TBU=;
        b=RYsvQgdyQDq84mPTk3nGopmHrqZ2JR5XdNGkJpxCHxQNGquALzml6+y3anujQXFsxY
         9b1HxDBvQCFhvhP/TBOAIMnvVN3FSWv80f5RL7azkIvzJZ+iS1EAhFPJp9LRf+x5S0dS
         G0q6GuQ2H0DG/8etUc2igFU+TNKgGQ454q+FMuTj06kDdM7x7BnOSpP6DkJQfPAtEdZW
         BBfS4AlX4dor7XtCtV/WXmdlDyKTBBwxqqBf1QeLX4zo68/TBEkkEc4yzd7kGWu4ReQm
         CBlty2E74O4TxGWQS/1odzDzq9yJ2lP8BIAw15b6G+iL0tVYQ9lwT2qvf6H8RuV0XnQ4
         5QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3aTTcTTQRTwfDNsiN9EuNcVVxYAi8YGgFB6Ju05TBU=;
        b=k+nYYjA98a0iTZsi8yVYeJUbyf3vA+gvRGKQWZBUCagOx37Au24WHwVUxqxEOlqVDx
         1M9dwKnoFEV7lEmft8BcxH9d4wfENNM5MqudLEb+qZWnh2lpkjpbq8uUNExDjnKM8f5t
         VnYyooAKLFNLLjTN6+9xoBGodKYltisoCWfJRuvT6u26RFkycsCkafCJP2h08/x5lY1z
         RQdDK77aNAn0DT5CEiensIMU9sJzurQoBp5y3THOx0+Do20i8gqHAln+RwcZyXpMn/MM
         5H2swwhxU8eOszU3Uu0svgKtmPpQwEnhdOiGB3t4S92EB+gDWK3YIkcQ5LlytGDttSTD
         OObw==
X-Gm-Message-State: APjAAAWJ7BAWY5JfBPb8jxaWcKaVvLUhHMAJRVVkzR3jdzw2o0Z5Z0tz
        QCM14U/n0pzLFhSdi4+yLfGSQtypTw==
X-Google-Smtp-Source: APXvYqwEyG5JuPQ9PZx6b6nr+6rA+vVHNk3Uf0B3+5R3Di7Ud6lptfr6MGRYfORCnHmpEiBwY3cGQQ==
X-Received: by 2002:a81:34a:: with SMTP id 71mr2159379ywd.221.1581361317734;
        Mon, 10 Feb 2020 11:01:57 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id w5sm682829yww.106.2020.02.10.11.01.56
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:01:57 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Use the 64-bit server readdir cookies when possible
Date:   Mon, 10 Feb 2020 13:59:48 -0500
Message-Id: <20200210185948.556860-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When we're running as a 64-bit architecture and are not running in
32-bit compatibility mode, it is better to use the 64-bit readdir
cookies that supplied by the server. Doing so improves the accuracy
of telldir()/seekdir(), particularly when the directory is changing,
for instance, when doing 'rm -rf'.

We still fall back to using the 32-bit offsets on 32-bit architectures
and when in compatibility mode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 61 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2856e04c20d6..09bcbdc67135 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,7 +144,6 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[0];
 };
 
-typedef int (*decode_dirent_t)(struct xdr_stream *, struct nfs_entry *, bool);
 typedef struct {
 	struct file	*file;
 	struct page	*page;
@@ -153,7 +152,7 @@ typedef struct {
 	u64		*dir_cookie;
 	u64		last_cookie;
 	loff_t		current_index;
-	decode_dirent_t	decode;
+	loff_t		prev_index;
 
 	unsigned long	dir_verifier;
 	unsigned long	timestamp;
@@ -240,6 +239,25 @@ int nfs_readdir_add_to_array(struct nfs_entry *entry, struct page *page)
 	return ret;
 }
 
+static inline
+int is_32bit_api(void)
+{
+#ifdef CONFIG_COMPAT
+	return in_compat_syscall();
+#else
+	return (BITS_PER_LONG == 32);
+#endif
+}
+
+static
+bool nfs_readdir_use_cookie(const struct file *filp)
+{
+	if ((filp->f_mode & FMODE_32BITHASH) ||
+	    (!(filp->f_mode & FMODE_64BITHASH) && is_32bit_api()))
+		return false;
+	return true;
+}
+
 static
 int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
 {
@@ -289,7 +307,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 			    !nfs_readdir_inode_mapping_valid(nfsi)) {
 				ctx->duped = 0;
 				ctx->attr_gencount = nfsi->attr_gencount;
-			} else if (new_pos < desc->ctx->pos) {
+			} else if (new_pos < desc->prev_index) {
 				if (ctx->duped > 0
 				    && ctx->dup_cookie == *desc->dir_cookie) {
 					if (printk_ratelimit()) {
@@ -305,7 +323,11 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 				ctx->dup_cookie = *desc->dir_cookie;
 				ctx->duped = -1;
 			}
-			desc->ctx->pos = new_pos;
+			if (nfs_readdir_use_cookie(desc->file))
+				desc->ctx->pos = *desc->dir_cookie;
+			else
+				desc->ctx->pos = new_pos;
+			desc->prev_index = new_pos;
 			desc->cache_entry_index = i;
 			return 0;
 		}
@@ -376,9 +398,10 @@ int nfs_readdir_xdr_filler(struct page **pages, nfs_readdir_descriptor_t *desc,
 static int xdr_decode(nfs_readdir_descriptor_t *desc,
 		      struct nfs_entry *entry, struct xdr_stream *xdr)
 {
+	struct inode *inode = file_inode(desc->file);
 	int error;
 
-	error = desc->decode(xdr, entry, desc->plus);
+	error = NFS_PROTO(inode)->decode_dirent(xdr, entry, desc->plus);
 	if (error)
 		return error;
 	entry->fattr->time_start = desc->timestamp;
@@ -756,6 +779,7 @@ int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
 
 	if (desc->page_index == 0) {
 		desc->current_index = 0;
+		desc->prev_index = 0;
 		desc->last_cookie = 0;
 	}
 	do {
@@ -786,11 +810,14 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 			desc->eof = true;
 			break;
 		}
-		desc->ctx->pos++;
 		if (i < (array->size-1))
 			*desc->dir_cookie = array->array[i+1].cookie;
 		else
 			*desc->dir_cookie = array->last_cookie;
+		if (nfs_readdir_use_cookie(file))
+			desc->ctx->pos = *desc->dir_cookie;
+		else
+			desc->ctx->pos++;
 		if (ctx->duped != 0)
 			ctx->duped = 1;
 	}
@@ -860,9 +887,14 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
-	nfs_readdir_descriptor_t my_desc,
-			*desc = &my_desc;
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
+	nfs_readdir_descriptor_t my_desc = {
+		.file = file,
+		.ctx = ctx,
+		.dir_cookie = &dir_ctx->dir_cookie,
+		.plus = nfs_use_readdirplus(inode, ctx),
+	},
+			*desc = &my_desc;
 	int res = 0;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
@@ -875,14 +907,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	memset(desc, 0, sizeof(*desc));
-
-	desc->file = file;
-	desc->ctx = ctx;
-	desc->dir_cookie = &dir_ctx->dir_cookie;
-	desc->decode = NFS_PROTO(inode)->decode_dirent;
-	desc->plus = nfs_use_readdirplus(inode, ctx);
-
 	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
 		res = nfs_revalidate_mapping(inode, file->f_mapping);
 	if (res < 0)
@@ -954,7 +978,10 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	}
 	if (offset != filp->f_pos) {
 		filp->f_pos = offset;
-		dir_ctx->dir_cookie = 0;
+		if (nfs_readdir_use_cookie(filp))
+			dir_ctx->dir_cookie = offset;
+		else
+			dir_ctx->dir_cookie = 0;
 		dir_ctx->duped = 0;
 	}
 	inode_unlock(inode);
-- 
2.24.1

