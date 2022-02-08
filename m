Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AFD4AE048
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Feb 2022 19:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbiBHSDz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Feb 2022 13:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiBHSDz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Feb 2022 13:03:55 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033EFC061579
        for <linux-nfs@vger.kernel.org>; Tue,  8 Feb 2022 10:03:54 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id k9so14679977qvv.9
        for <linux-nfs@vger.kernel.org>; Tue, 08 Feb 2022 10:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bgVqjwd8phiapwe9qPuYwU+xLT9k2nR/NvfQllF+gBM=;
        b=NC0WgIDS9WzKQbL/rkUVGjqq8GL2Im9Q/mlBPhoO61FXeQEQWPP/hu3EEvO5ViVu8i
         hF5QGb+b69I8zv0VCiyRm87QQbJd/96r25m3yNhcRHuaWknhxArey22XCKqmfIg5PJ/L
         pV5A/6u26W3pA7hjC3bOGrGNmxr8fJlfj6e25ZnuvvPuEewtopKO//0hZ+q/UGxFL375
         rCThsZFqbfk+MyreFWSABy6G4YHwmMkBaccgqGan5iYBDEWCEwGOyO7bi6Si+vZMzDJL
         CKP+nO0SRdSeu6U2HREliYLAIAlvw1Ga6k6fgA3YZUpqwid16cq56e2usVhrm3U1yFr1
         35Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bgVqjwd8phiapwe9qPuYwU+xLT9k2nR/NvfQllF+gBM=;
        b=HYGtcbUvTE3ULp38k88SZeKWp0qrlxTSW9sGzG2d9YXfK69bDRPwWN6cY1VGNrF/dF
         ez0/IfRSRNEnSB2eTUqK//DyqfuSf1xEroQNTyFKQvOYbxYBKlpDQsWW6ra8rGh22EgE
         DqPDouNaz0bssfdUWnjYukNVySLrkEyoEC+Futb9mfkFW2wExQYglMkhi9+shkq1gZFj
         8h83rBBHhWKMoswFxCbIsB6j2qY95w1tWHucc2UGwsSlEsMpzDJaTlDUq5HFBKZjKP6v
         PGdULwhFBytwKYDcc53vO2jdJGi0lNDLE6PkM9C1EUGSbW0829wJj9750b2/PsS5dCmv
         Y7Hg==
X-Gm-Message-State: AOAM532TK+EXQcttu051Ykr5dSgQ7iAMcXE7yODdOB06IaD+VCUBMXth
        V87eRh2qD3R8u87P2Mw0r5XjN0CtQQ==
X-Google-Smtp-Source: ABdhPJygP5HdSGVTvuxbX1AImZelRfT/NOok3WKmGr2ddjhYz463kM4+evMzIjSnn0kJY4Id8KWUrA==
X-Received: by 2002:a05:6214:20e6:: with SMTP id 6mr3964804qvk.29.1644343432346;
        Tue, 08 Feb 2022 10:03:52 -0800 (PST)
Received: from localhost.localdomain (c-68-56-145-227.hsd1.mi.comcast.net. [68.56.145.227])
        by smtp.gmail.com with ESMTPSA id s2sm7000723qks.60.2022.02.08.10.03.51
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:03:51 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] NFS: Adjust the amount of readahead performed by NFS readdir
Date:   Tue,  8 Feb 2022 12:57:01 -0500
Message-Id: <20220208175702.1389115-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208175702.1389115-1-trond.myklebust@hammerspace.com>
References: <20220208175702.1389115-1-trond.myklebust@hammerspace.com>
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
 fs/nfs/dir.c           | 50 +++++++++++++++++++++++++++++++++++++++++-
 include/linux/nfs_fs.h |  1 +
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 71fa551da956..a3d1f949b2e6 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -69,6 +69,8 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
+#define NFS_INIT_DTSIZE	PAGE_SIZE
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
@@ -167,12 +171,35 @@ struct nfs_readdir_descriptor {
 	unsigned long	gencount;
 	unsigned long	attr_gencount;
 	unsigned int	cache_entry_index;
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
@@ -759,6 +786,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 				break;
 			arrays++;
 			*arrays = page = new;
+			desc->page_index_max++;
 		} else {
 			new = nfs_readdir_page_get_next(mapping,
 							page->index + 1,
@@ -768,6 +796,7 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 			if (page != *arrays)
 				nfs_readdir_page_unlock_and_put(page);
 			page = new;
+			desc->page_index_max = new->index;
 		}
 		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
@@ -833,7 +862,7 @@ static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
 	struct nfs_entry *entry;
 	size_t array_size;
 	struct inode *inode = file_inode(desc->file);
-	size_t dtsize = NFS_SERVER(inode)->dtsize;
+	unsigned int dtsize = desc->dtsize;
 	int status = -ENOMEM;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -916,6 +945,7 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	if (!desc->page)
 		return -ENOMEM;
 	if (nfs_readdir_page_needs_filling(desc->page)) {
+		desc->page_index_max = desc->page_index;
 		res = nfs_readdir_xdr_to_array(desc, nfsi->cookieverf, verf,
 					       &desc->page, 1);
 		if (res < 0) {
@@ -1047,6 +1077,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	desc->cache_entry_index = 0;
 	desc->last_cookie = desc->dir_cookie;
 	desc->duped = 0;
+	desc->page_index_max = 0;
 
 	status = nfs_readdir_xdr_to_array(desc, desc->verf, verf, arrays, sz);
 
@@ -1056,10 +1087,19 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 	}
 	desc->page = NULL;
 
+	/*
+	 * Grow the dtsize if we have to go back for more pages,
+	 * or shrink it if we're reading too many.
+	 */
+	if (!desc->eob)
+		nfs_grow_dtsize(desc);
+	else if (desc->page_index_max && i <= (desc->page_index_max >> 1))
+		nfs_shrink_dtsize(desc);
 
 	for (i = 0; i < sz && arrays[i]; i++)
 		nfs_readdir_page_array_free(arrays[i]);
 out:
+	desc->page_index_max = -1;
 	kfree(arrays);
 	dfprintk(DIRCACHE, "NFS: %s: returns %d\n", __func__, status);
 	return status;
@@ -1102,6 +1142,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->file = file;
 	desc->ctx = ctx;
 	desc->plus = nfs_use_readdirplus(inode, ctx);
+	desc->page_index_max = -1;
 
 	spin_lock(&file->f_lock);
 	desc->dir_cookie = dir_ctx->dir_cookie;
@@ -1110,6 +1151,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	page_index = dir_ctx->page_index;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
+	nfs_set_dtsize(desc, dir_ctx->dtsize);
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
 	spin_unlock(&file->f_lock);
 
@@ -1151,6 +1193,11 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
+		if (desc->eob || desc->eof)
+			break;
+		/* Grow the dtsize if we have to go back for more pages */
+		if (desc->page_index == desc->page_index_max)
+			nfs_grow_dtsize(desc);
 	} while (!desc->eob && !desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1160,6 +1207,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
 	dir_ctx->eof = desc->eof;
+	dir_ctx->dtsize = desc->dtsize;
 	memcpy(dir_ctx->verf, desc->verf, sizeof(dir_ctx->verf));
 	spin_unlock(&file->f_lock);
 out_free:
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 333ea05e2531..034d95809b97 100644
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
2.34.1

