Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781EB2A32B6
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgKBSRa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgKBSR0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:26 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E873120731
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341045;
        bh=P+gKQ4MjV3jdvlWiXWP8qEdbKRV5Fl83U5wVoIuPAt0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BzGYq66v9UpAv2Ig7v6Je0i5/6YNeXAwnvqiyd/vUlZgjar3X8LUwFtYB+Wussoeb
         mCJTnltii+rOpdH0gXJmIEy+Q4r9RhaHG6OW6b1/W+vUQF6yA0oyf7Jel47k9K9pld
         HM3/QxRBFqcAOmtIbURoFqnYCaXpcAgkWXrpHqBo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 09/12] NFS: Support larger readdir buffers
Date:   Mon,  2 Nov 2020 13:06:55 -0500
Message-Id: <20201102180658.6218-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102180658.6218-9-trondmy@kernel.org>
References: <20201102180658.6218-1-trondmy@kernel.org>
 <20201102180658.6218-2-trondmy@kernel.org>
 <20201102180658.6218-3-trondmy@kernel.org>
 <20201102180658.6218-4-trondmy@kernel.org>
 <20201102180658.6218-5-trondmy@kernel.org>
 <20201102180658.6218-6-trondmy@kernel.org>
 <20201102180658.6218-7-trondmy@kernel.org>
 <20201102180658.6218-8-trondmy@kernel.org>
 <20201102180658.6218-9-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Support readdir buffers of up to 1MB in size so that we can read
large directories using few RPC calls.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c   |  4 ++--
 fs/nfs/dir.c      | 33 +++++++++++++++++++--------------
 fs/nfs/internal.h |  6 ------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 4b8cc93913f7..f6454ba53d05 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -781,8 +781,8 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 	server->wtmult = nfs_block_bits(fsinfo->wtmult, NULL);
 
 	server->dtsize = nfs_block_size(fsinfo->dtpref, NULL);
-	if (server->dtsize > PAGE_SIZE * NFS_MAX_READDIR_PAGES)
-		server->dtsize = PAGE_SIZE * NFS_MAX_READDIR_PAGES;
+	if (server->dtsize > NFS_MAX_FILE_IO_SIZE)
+		server->dtsize = NFS_MAX_FILE_IO_SIZE;
 	if (server->dtsize > server->rsize)
 		server->dtsize = server->rsize;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c82f1bde4f13..272b856147af 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -727,44 +727,47 @@ static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
 	return status;
 }
 
-static
-void nfs_readdir_free_pages(struct page **pages, unsigned int npages)
+static void nfs_readdir_free_pages(struct page **pages, size_t npages)
 {
-	unsigned int i;
-	for (i = 0; i < npages; i++)
-		put_page(pages[i]);
+	while (npages--)
+		put_page(pages[npages]);
+	kfree(pages);
 }
 
 /*
  * nfs_readdir_alloc_pages() will allocate pages that must be freed with a call
  * to nfs_readdir_free_pages()
  */
-static
-int nfs_readdir_alloc_pages(struct page **pages, unsigned int npages)
+static struct page **nfs_readdir_alloc_pages(size_t npages)
 {
-	unsigned int i;
+	struct page **pages;
+	size_t i;
 
+	pages = kmalloc_array(npages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return NULL;
 	for (i = 0; i < npages; i++) {
 		struct page *page = alloc_page(GFP_KERNEL);
 		if (page == NULL)
 			goto out_freepages;
 		pages[i] = page;
 	}
-	return 0;
+	return pages;
 
 out_freepages:
 	nfs_readdir_free_pages(pages, i);
-	return -ENOMEM;
+	return NULL;
 }
 
 static
 int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
 {
-	struct page *pages[NFS_MAX_READDIR_PAGES];
+	struct page **pages;
 	struct nfs_entry entry;
 	struct file	*file = desc->file;
+	size_t array_size;
+	size_t dtsize = NFS_SERVER(inode)->dtsize;
 	int status = -ENOMEM;
-	unsigned int array_size = ARRAY_SIZE(pages);
 
 	entry.prev_cookie = 0;
 	entry.cookie = nfs_readdir_page_last_cookie(page);
@@ -781,9 +784,11 @@ int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page,
 		goto out;
 	}
 
-	status = nfs_readdir_alloc_pages(pages, array_size);
-	if (status < 0)
+	array_size = (dtsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pages = nfs_readdir_alloc_pages(array_size);
+	if (!pages)
 		goto out_release_label;
+
 	do {
 		unsigned int pglen;
 		status = nfs_readdir_xdr_filler(pages, desc, &entry, file, inode);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6673a77884d9..b840d0a91c9d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -56,12 +56,6 @@ static inline bool nfs_lookup_is_soft_revalidate(const struct dentry *dentry)
 #define NFS_UNSPEC_RETRANS	(UINT_MAX)
 #define NFS_UNSPEC_TIMEO	(UINT_MAX)
 
-/*
- * Maximum number of pages that readdir can use for creating
- * a vmapped array of pages.
- */
-#define NFS_MAX_READDIR_PAGES 8
-
 struct nfs_client_initdata {
 	unsigned long init_flags;
 	const char *hostname;			/* Hostname of the server */
-- 
2.28.0

