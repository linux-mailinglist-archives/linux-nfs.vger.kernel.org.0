Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC172A69B5
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Nov 2020 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKDQ1Z (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Nov 2020 11:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731201AbgKDQ1N (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Nov 2020 11:27:13 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9461AC0613D4
        for <linux-nfs@vger.kernel.org>; Wed,  4 Nov 2020 08:27:12 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id a65so17572482qkg.13
        for <linux-nfs@vger.kernel.org>; Wed, 04 Nov 2020 08:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PiwfpfNYPIszRF1iL4k5zXYxNelrn1vUwBxUeMpkK3U=;
        b=mF8JnYJf7FvrDO096NGPhi4uME5ZhMW6BkmWD8FV5dg/doBR4jTnofQwfD3NI0eALa
         4W27KimIy7D5VlVZiX2Tx16QLR87TnPeQ29O3jnf+DBeMivtVAHz3819Mty4drLAM2z+
         qimj/FLpg2NEqQ5l/XlDKb1D0TJK9+5wU9YIsN6pJDd3IYIQGqMoUlV2r1ZsLQoonR87
         1jgimyj9Ty850UYkB9cuyuVeASiZ/atApRNm1rSeuQVTZQzxoh9hO37XBxDrtx2cppPU
         jgMgl0iC6imHbaAbMetNqbVzd4xxa8ZaVkoK2BJHrnAs52RMD3yTw7VPwe2c/JmJ3WWl
         3fNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PiwfpfNYPIszRF1iL4k5zXYxNelrn1vUwBxUeMpkK3U=;
        b=tN1emf3m6/1+ewwx1DtUZ0K3cM7Psh190noBMR2+b90I8+pr1eWEgDWm7axCJN4UQC
         5o2XK6EQ8nmhNbi60f+G5Bf3uNCtB0IUTFZta5Gc1aGr/sI5UVuIf30Z+X1qAIbn4sQE
         OKTho8bMjxWqh8cSmMBLg7KnbmlfTAsNl/aCLPg0ZOgOyHpzf3YTP6VpdFBUicbo2UfZ
         g20itV0NMV/oRXycaivbnjJUParG4yDtYJXpJXr5evfmFiqlSt3EHde+oRza6xku77RQ
         ocuWyv0vJuf4CaJ6cfho0K94dUlofBJoG+f4wdPxAjNBqmmITee76pmBdur2SYiVNuJx
         6zcw==
X-Gm-Message-State: AOAM531XZJfdr83e3qYAP/UukkUvQTFVfOCi3zGaHrLfJjdLWlTKQM2e
        7+ye8xBGEkXwLxYfoP0+B+22Y9zwguNu
X-Google-Smtp-Source: ABdhPJyh6f1Tg5SpXXWj8QRVmSkhX/U4TD8xW7aOHe+tpphoHW0ZxUgAOwBvQsEslwsne5xoTK4XPg==
X-Received: by 2002:a37:474b:: with SMTP id u72mr27416683qka.333.1604507231443;
        Wed, 04 Nov 2020 08:27:11 -0800 (PST)
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net. [68.36.133.222])
        by smtp.gmail.com with ESMTPSA id g78sm2896924qke.88.2020.11.04.08.27.10
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:27:10 -0800 (PST)
From:   trondmy@gmail.com
X-Google-Original-From: trond.myklebust@hammerspace.com
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 09/17] NFS: Support larger readdir buffers
Date:   Wed,  4 Nov 2020 11:16:30 -0500
Message-Id: <20201104161638.300324-10-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201104161638.300324-9-trond.myklebust@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <20201104161638.300324-2-trond.myklebust@hammerspace.com>
 <20201104161638.300324-3-trond.myklebust@hammerspace.com>
 <20201104161638.300324-4-trond.myklebust@hammerspace.com>
 <20201104161638.300324-5-trond.myklebust@hammerspace.com>
 <20201104161638.300324-6-trond.myklebust@hammerspace.com>
 <20201104161638.300324-7-trond.myklebust@hammerspace.com>
 <20201104161638.300324-8-trond.myklebust@hammerspace.com>
 <20201104161638.300324-9-trond.myklebust@hammerspace.com>
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
index be0e2891fecc..438906dae083 100644
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

