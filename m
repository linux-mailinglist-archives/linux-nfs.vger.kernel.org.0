Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62436612BC
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Jul 2019 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfGFSzD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 Jul 2019 14:55:03 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42225 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfGFSzC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 Jul 2019 14:55:02 -0400
Received: by mail-io1-f66.google.com with SMTP id u19so25988778ior.9
        for <linux-nfs@vger.kernel.org>; Sat, 06 Jul 2019 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wO6raJIQQ4+pygU0RevYLFTwQqkys77MRwhfIB1KQK8=;
        b=ksNCQqicO43650HHjG7psoZNBgbtLfY9hKUgaRmzwE2E6KPBSuMgtIPfvHaVQJ+ma1
         09KjO2iitzElN8LDdE3A59a7PcAEzs0zYLGSGMbUrqntsH8CIJamuUoU50Txqmx5CGBQ
         SzLw+gFopbJuq1ECWeMrx1jkTWxVkdh78na4WBkzCnXD8/xoD/XgDj/8toOfxcTBqtZe
         kvHukUdpcOZcJGOK+x/O5DdFxq3NvhSZ4nawLm7ud7aevoG+pudo7yZpM70SqCk4fb9h
         vwyTU+0PguO0LEoEDPdDiFRJ7zc9a9PJLNZ+jbl14Yh1JnRS4IFiPFr87MGbl0azLCm/
         42nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wO6raJIQQ4+pygU0RevYLFTwQqkys77MRwhfIB1KQK8=;
        b=NA43XbC6Geqh1Ox6a2R4nK/Z/hAWHB8PqA2fSGNbXB8ExRxOAEB/1KlbbKeDrXVz9i
         Y/eMemYD45jSGeRTunMhgvAObxWgNd4vVBFPLF47RGj68OIiZS8QFuB72nb9O1LNTaSP
         wHiZzru46wcUJamXI5qhaMslWt+0X7Ytezo561azMn3qXGKnSwSb57f7UfMJjHRhnVJz
         VjOYsFI5gLG0Zs5povzvV9+PoohILUPxHpLUlM/TgRTxP1LT9cVH6qUEjFvcZFdaT0K8
         JupRl23nnFG8LwojmWFsvXavBaOhjvk0qk5JssiAQ8jfAB6FFXxhhfu9qeKpAo0jYvTc
         5pFA==
X-Gm-Message-State: APjAAAWxteyMMp7FUe5y2M/rZX7C3WaR4WIQhP8tJK2fzmnjJ0ifE4Ne
        D1zVXOw8QBMSbQGYSusklaBCKbfXIg==
X-Google-Smtp-Source: APXvYqxqh47cp3Z9vl5qMQl6Kv8zOqI6LUGhmosGvX9AzX+wr/Ni2hHG3nCpt1t5tpXS0f9uwtuhZA==
X-Received: by 2002:a5d:94d7:: with SMTP id y23mr10704790ior.296.1562439301480;
        Sat, 06 Jul 2019 11:55:01 -0700 (PDT)
Received: from localhost.localdomain (50-124-245-189.alma.mi.frontiernet.net. [50.124.245.189])
        by smtp.gmail.com with ESMTPSA id x22sm9117780ioh.87.2019.07.06.11.55.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 06 Jul 2019 11:55:01 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>
Subject: [PATCH 2/3] NFS: Reduce stack usage in nfs_readdir()
Date:   Sat,  6 Jul 2019 14:52:51 -0400
Message-Id: <20190706185252.32488-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190706185252.32488-1-trond.myklebust@hammerspace.com>
References: <20190706185252.32488-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

64 pointers is 512bytes on a typical 64-bit system.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e44f3c9fad5b..6ccf0e6c9c84 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -646,12 +646,12 @@ void nfs_readdir_rapages_init(nfs_readdir_descriptor_t *desc)
 static
 int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
 {
-	struct page *pages[NFS_MAX_READDIR_PAGES];
+	const unsigned int array_size = NFS_MAX_READDIR_PAGES;
+	struct page **pages;
 	struct nfs_entry entry;
 	struct file	*file = desc->file;
 	struct nfs_cache_array *array;
 	int status = -ENOMEM;
-	unsigned int array_size = ARRAY_SIZE(pages);
 
 	/*
 	 * This means we hit readdir rdpages miss, the preallocated rdpages
@@ -674,12 +674,17 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		goto out;
 	}
 
-	array = kmap(page);
-	memset(array, 0, sizeof(struct nfs_cache_array));
+	pages = kmalloc_array(array_size, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		goto out_release_array;
 
 	status = nfs_readdir_alloc_pages(pages, array_size);
 	if (status < 0)
 		goto out_release_array;
+
+	array = kmap(page);
+	memset(array, 0, sizeof(struct nfs_cache_array));
+
 	do {
 		unsigned int pglen;
 		status = nfs_readdir_xdr_filler(pages, desc, &entry, file, inode);
@@ -695,9 +700,10 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		}
 	} while (!array->eof);
 
+	kunmap(page);
 	nfs_readdir_free_pages(pages, array_size);
 out_release_array:
-	kunmap(page);
+	kfree(pages);
 	nfs4_label_free(entry.label);
 out:
 	nfs_free_fattr(entry.fattr);
@@ -896,10 +902,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
-	nfs_readdir_descriptor_t my_desc,
-			*desc = &my_desc;
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
-	int res = 0;
+	nfs_readdir_descriptor_t *desc;
+	int res = -ENOMEM;
 	unsigned int max_rapages = NFS_MAX_READDIR_RAPAGES;
 
 	dfprintk(FILE, "NFS: readdir(%pD2) starting at cookie %llu\n",
@@ -912,7 +917,9 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	memset(desc, 0, sizeof(*desc));
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	if (!desc)
+		goto free_desc;
 
 	desc->file = file;
 	desc->ctx = ctx;
@@ -922,7 +929,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 	res = nfs_readdir_alloc_pages(desc->pvec.pages, max_rapages);
 	if (res < 0)
-		return -ENOMEM;
+		goto free_desc;
 
 	nfs_readdir_rapages_init(desc);
 
@@ -964,6 +971,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	nfs_readdir_free_pages(desc->pvec.pages, max_rapages);
 	if (res > 0)
 		res = 0;
+free_desc:
+	kfree(desc);
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
 }
-- 
2.21.0

