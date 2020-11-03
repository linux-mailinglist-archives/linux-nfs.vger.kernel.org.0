Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5E2A4A25
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgKCPnn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbgKCPnn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:43 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C86E120780
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418223;
        bh=ABicvRzGH776VY0sINCLtXLG73UOddTfLgXTNLcrawI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sRB/iRek1qPqn5ihEEpOXW70vgIK62abbh69A8GJwPV6ltcusGg62/6GJxhnglF3D
         feog1pioUBQxH8KZbFTu3QOyV1N7cDyGF3ftujOpfKbGTQEhBBKW57Cz3oL/n3cwYU
         cdR6xFQsIdY7vAfxn+Oe1cpSyvEFYFZ05oO1yvqk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 05/16] NFS: Don't discard readdir results
Date:   Tue,  3 Nov 2020 10:33:18 -0500
Message-Id: <20201103153329.531942-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103153329.531942-5-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <20201103153329.531942-2-trondmy@kernel.org>
 <20201103153329.531942-3-trondmy@kernel.org>
 <20201103153329.531942-4-trondmy@kernel.org>
 <20201103153329.531942-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a readdir call returns more data than we can fit into one page
cache page, then allocate a new one for that data rather than
discarding the data.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 46 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index b4861a33ad60..788c2a2eeaa3 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -321,6 +321,26 @@ static void nfs_readdir_page_set_eof(struct page *page)
 	kunmap_atomic(array);
 }
 
+static void nfs_readdir_page_unlock_and_put(struct page *page)
+{
+	unlock_page(page);
+	put_page(page);
+}
+
+static struct page *nfs_readdir_page_get_next(struct address_space *mapping,
+					      pgoff_t index, u64 cookie)
+{
+	struct page *page;
+
+	page = nfs_readdir_page_get_locked(mapping, index, cookie);
+	if (page) {
+		if (nfs_readdir_page_last_cookie(page) == cookie)
+			return page;
+		nfs_readdir_page_unlock_and_put(page);
+	}
+	return NULL;
+}
+
 static inline
 int is_32bit_api(void)
 {
@@ -638,13 +658,15 @@ void nfs_prime_dcache(struct dentry *parent, struct nfs_entry *entry,
 }
 
 /* Perform conversion from xdr to cache array */
-static
-int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *entry,
-				struct page **xdr_pages, struct page *page, unsigned int buflen)
+static int nfs_readdir_page_filler(struct nfs_readdir_descriptor *desc,
+				   struct nfs_entry *entry,
+				   struct page **xdr_pages,
+				   struct page *fillme, unsigned int buflen)
 {
+	struct address_space *mapping = desc->file->f_mapping;
 	struct xdr_stream stream;
 	struct xdr_buf buf;
-	struct page *scratch;
+	struct page *scratch, *new, *page = fillme;
 	int status;
 
 	scratch = alloc_page(GFP_KERNEL);
@@ -667,6 +689,19 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 					desc->dir_verifier);
 
 		status = nfs_readdir_add_to_array(entry, page);
+		if (status != -ENOSPC)
+			continue;
+
+		if (page->mapping != mapping)
+			break;
+		new = nfs_readdir_page_get_next(mapping, page->index + 1,
+						entry->prev_cookie);
+		if (!new)
+			break;
+		if (page != fillme)
+			nfs_readdir_page_unlock_and_put(page);
+		page = new;
+		status = nfs_readdir_add_to_array(entry, page);
 	} while (!status && !entry->eof);
 
 	switch (status) {
@@ -682,6 +717,9 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 		break;
 	}
 
+	if (page != fillme)
+		nfs_readdir_page_unlock_and_put(page);
+
 	put_page(scratch);
 	return status;
 }
-- 
2.28.0

