Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6C4BC214
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239780AbiBRVbH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 16:31:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiBRVbH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 16:31:07 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C1F178958
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:49 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p7so17244765qvk.11
        for <linux-nfs@vger.kernel.org>; Fri, 18 Feb 2022 13:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ug+CvjIUCep1DGuaKq+iPrJGVw6RMMz4iggvbhHn/M0=;
        b=keL2ho5WOeY3PdjVQlQRqrZDf5Z3DpLzO+N/44hZozmIkciY7bXsPrWG1VcF//pp6F
         8EN9X0nopHcviEz62i4/dXM5WC2BrtXr0Hy9ka57ySKZisXXcw4O6BlcHaVf3+uUS5bf
         a/uG7Do5TeQK7UiQSLE03ao2C5Ft8JKdNvwZc3SFZGQVkoEZhS3G/Ovr8pnszRzpW2Du
         qhl6F202xhU5Nx7X47hjUAV1Ym/+PvpcoZT8qe1Y0Hs8uyk0irkmp1ZhfPQf4vqPGaTQ
         hhpKYKl5Nn0fWNs5bkpJG1/mP7diM+r+nJj82fbiD/7R6nVm5bPFCYWqFJ53MG8JLDY0
         ptTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ug+CvjIUCep1DGuaKq+iPrJGVw6RMMz4iggvbhHn/M0=;
        b=QSlInsKy2aFKJliWzkhYNS+EFUUOe4cQ9p+pFz+naCQ4pYckXAOxUvh8jf6BKwlfUw
         4UmYANMvn1gW9SMlyK9ItcRcABYWuuj7LFBIBgOLFWvxXf81BBdkUEqtMcrslq0F+KOC
         v/5CyjtKssQ1AQSB42KGEMg0jPh6wU+SDFCBt0JVWIT4w1Aa4BUTw/3EssfZLRraHy7+
         wqw547F2hFFecH7h6jJmdb2P25rhOCQpY6/suyP38bHXI0w/aCgWR49WlcAJbgZ06zqs
         Kaw31ADqV4AVgZ6sQ99DaNlTT5JxyF9maofwkp9uoHPmadJxWG3OfoRL1R7SP5m+Rlqh
         wOjA==
X-Gm-Message-State: AOAM531vESla+TgrmqExN+czbXKdg3V2UOWUwPaQa9OZrvDJ6BYT7Eli
        LiaInFApx3FUWLnjjavGNqfH9gNIfg==
X-Google-Smtp-Source: ABdhPJwz/+FGNPLOusDDO3gEylmjEbjhgHYE6DFEtK6V8qs2xqLbzvAlV2+auux3lAQ9kSei4KVcTg==
X-Received: by 2002:a05:622a:1786:b0:2ca:9f6c:221e with SMTP id s6-20020a05622a178600b002ca9f6c221emr8607009qtk.478.1645219848313;
        Fri, 18 Feb 2022 13:30:48 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id w22sm26928656qtk.7.2022.02.18.13.30.46
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:30:47 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 1/6] NFS: Adjust the amount of readahead performed by NFS readdir
Date:   Fri, 18 Feb 2022 16:24:19 -0500
Message-Id: <20220218212424.1840077-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
References: <20220218212424.1840077-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

This patch therefore tries to tone down the amount of readahead we
perform, and adjust it to try to match the amount of data being
requested by user space.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 55 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/nfs_fs.h |  1 +
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 8b190c8e4a45..b0ee3a0e0f81 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -69,6 +69,8 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
+#define NFS_INIT_DTSIZE PAGE_SIZE
+
 static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
@@ -80,6 +82,7 @@ static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir
 		ctx->dir_cookie = 0;
 		ctx->dup_cookie = 0;
 		ctx->page_index = 0;
+		ctx->dtsize = NFS_INIT_DTSIZE;
 		ctx->eof = false;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
@@ -155,6 +158,7 @@ struct nfs_readdir_descriptor {
 	struct page	*page;
 	struct dir_context *ctx;
 	pgoff_t		page_index;
+	pgoff_t		page_index_max;
 	u64		dir_cookie;
 	u64		last_cookie;
 	u64		dup_cookie;
@@ -167,12 +171,36 @@ struct nfs_readdir_descriptor {
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
 	unsigned int	cache_entry_index;
+	unsigned int	buffer_fills;
+	unsigned int	dtsize;
 	signed char duped;
 	bool plus;
 	bool eob;
 	bool eof;
 };
 
+static void nfs_set_dtsize(struct nfs_readdir_descriptor *desc, unsigned int sz)
+{
+	struct nfs_server *server = NFS_SERVER(file_inode(desc->file));
+	unsigned int maxsize = server->dtsize;
+
+	if (sz > maxsize)
+		sz = maxsize;
+	if (sz < NFS_MIN_FILE_IO_SIZE)
+		sz = NFS_MIN_FILE_IO_SIZE;
+	desc->dtsize = sz;
+}
+
+static void nfs_shrink_dtsize(struct nfs_readdir_descriptor *desc)
+{
+	nfs_set_dtsize(desc, desc->dtsize >> 1);
+}
+
+static void nfs_grow_dtsize(struct nfs_readdir_descriptor *desc)
+{
+	nfs_set_dtsize(desc, desc->dtsize << 1);
+}
+
 static void nfs_readdir_array_init(struct nfs_cache_array *array)
 {
 	memset(array, 0, sizeof(struct nfs_cache_array));
@@ -759,6 +787,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
+			desc->page_index_max++;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
 							page->index + 1,
@@ -768,6 +797,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
+			desc->page_index_max = new->index;
 		}
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
@@ -833,7 +863,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
-	size_t dtsize = NFS_SERVER(inode)->dtsize;
+	unsigned int dtsize = desc->dtsize;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -869,6 +899,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 
 		status = nfs_readdir_page_filler(desc, entry, pages, pglen,
 						 arrays, narrays);
+		desc->buffer_fills++;
 	} while (!status && nfs_readdir_page_needs_filling(page) &&
 		page_mapping(page));
 
@@ -916,6 +947,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
+		desc->page_index_max = desc->page_index;
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
@@ -1047,6 +1079,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
 	desc->duped = 0;
+	desc->page_index_max = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
@@ -1056,10 +1089,22 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	}
 	desc->page = NULL;
 
+	/*
+	 * Grow the dtsize if we have to go back for more pages,
+	 * or shrink it if we're reading too many.
+	 */
+	if (!desc->eof) {
+		if (!desc->eob)
+			nfs_grow_dtsize(desc);
+		else if (desc->buffer_fills == 1 &&
+			 i < (desc->page_index_max >> 1))
+			nfs_shrink_dtsize(desc);
+	}
 
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
+	desc->page_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
 	return status;
@@ -1102,6 +1147,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->file = file;
 	desc->ctx = ctx;
 	desc->plus = nfs_use_readdirplus(inode, ctx);
+	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1110,6 +1156,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	page_index = dir_ctx->page_index;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
+	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
@@ -1151,6 +1198,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->eob || desc->eof)
+			break;
+		/* Grow the dtsize if we have to go back for more pages */
+		if (desc->page_index == desc->page_index_max)
+			nfs_grow_dtsize(desc);
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1160,6 +1212,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
 	dir_ctx->eof = desc->eof;
+	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
 out_free:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 6e10725887d1..d27f7e788624 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -106,6 +106,7 @@ struct nfs_open_dir_context {
 	__u64 dir_cookie;
 	__u64 dup_cookie;
 	pgoff_t page_index;
+	unsigned int dtsize;
 	signed char duped;
 	bool eof;
 };
-- 
2.35.1

