Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA1C191DB6
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgCXXto (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgCXXto (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:44 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02AE820719
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093784;
        bh=MndP8/Rbk2/z0nAKJxncvbhzUO1YBScofE5SoxyUJ/4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1bdxFS89vsuLQJ/IcJEZZUJsOhlYlDAaOStrg5CT2ruhniTBpW3BkvTQNEkMrmKjN
         75bgHXQqE0ys8waW5S7O/5v4OCHfEKCZHTw2J5cenJ4Tk5V6O0LmocLv3V7OGlf8LF
         rJMiIw3+no3DbHYlrqWSu1D50DD8QwJAkMhgRQMk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 14/22] NFS/pNFS: Add a helper pnfs_generic_search_commit_reqs()
Date:   Tue, 24 Mar 2020 19:47:20 -0400
Message-Id: <20200324234728.8997-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-14-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
 <20200324234728.8997-8-trondmy@kernel.org>
 <20200324234728.8997-9-trondmy@kernel.org>
 <20200324234728.8997-10-trondmy@kernel.org>
 <20200324234728.8997-11-trondmy@kernel.org>
 <20200324234728.8997-12-trondmy@kernel.org>
 <20200324234728.8997-13-trondmy@kernel.org>
 <20200324234728.8997-14-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Lift filelayout_search_commit_reqs() into the generic pnfs/nfs code,
and add support for commit arrays.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/filelayout/filelayout.c | 32 +--------------------
 fs/nfs/pnfs.h                  |  2 ++
 fs/nfs/pnfs_nfs.c              | 51 ++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 90c660aad337..05c97b6ba15d 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -1083,36 +1083,6 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
 	return -EAGAIN;
 }
 
-/* filelayout_search_commit_reqs - Search lists in @cinfo for the head reqest
- *				   for @page
- * @cinfo - commit info for current inode
- * @page - page to search for matching head request
- *
- * Returns a the head request if one is found, otherwise returns NULL.
- */
-static struct nfs_page *
-filelayout_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page)
-{
-	struct nfs_page *freq, *t;
-	struct pnfs_commit_bucket *b;
-	int i;
-
-	/* Linearly search the commit lists for each bucket until a matching
-	 * request is found */
-	for (i = 0, b = cinfo->ds->buckets; i < cinfo->ds->nbuckets; i++, b++) {
-		list_for_each_entry_safe(freq, t, &b->written, wb_list) {
-			if (freq->wb_page == page)
-				return freq->wb_head;
-		}
-		list_for_each_entry_safe(freq, t, &b->committing, wb_list) {
-			if (freq->wb_page == page)
-				return freq->wb_head;
-		}
-	}
-
-	return NULL;
-}
-
 static int
 filelayout_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 			   int how, struct nfs_commit_info *cinfo)
@@ -1217,7 +1187,7 @@ static struct pnfs_layoutdriver_type filelayout_type = {
 	.clear_request_commit	= pnfs_generic_clear_request_commit,
 	.scan_commit_lists	= pnfs_generic_scan_commit_lists,
 	.recover_commit_reqs	= pnfs_generic_recover_commit_reqs,
-	.search_commit_reqs	= filelayout_search_commit_reqs,
+	.search_commit_reqs	= pnfs_generic_search_commit_reqs,
 	.commit_pagelist	= filelayout_commit_pagelist,
 	.read_pagelist		= filelayout_read_pagelist,
 	.write_pagelist		= filelayout_write_pagelist,
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index 434503875f7f..20acd5108ddf 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -388,6 +388,8 @@ void pnfs_generic_prepare_to_resend_writes(struct nfs_commit_data *data);
 void pnfs_generic_rw_release(void *data);
 void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 				      struct nfs_commit_info *cinfo);
+struct nfs_page *pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo,
+						 struct page *page);
 int pnfs_generic_commit_pagelist(struct inode *inode,
 				 struct list_head *mds_pages,
 				 int how,
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 5b426a090ee3..9b55919e64ac 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -375,6 +375,57 @@ void pnfs_generic_recover_commit_reqs(struct list_head *dst,
 }
 EXPORT_SYMBOL_GPL(pnfs_generic_recover_commit_reqs);
 
+static struct nfs_page *
+pnfs_bucket_search_commit_reqs(struct pnfs_commit_bucket *buckets,
+		unsigned int nbuckets, struct page *page)
+{
+	struct nfs_page *req;
+	struct pnfs_commit_bucket *b;
+	unsigned int i;
+
+	/* Linearly search the commit lists for each bucket until a matching
+	 * request is found */
+	for (i = 0, b = buckets; i < nbuckets; i++, b++) {
+		list_for_each_entry(req, &b->written, wb_list) {
+			if (req->wb_page == page)
+				return req->wb_head;
+		}
+		list_for_each_entry(req, &b->committing, wb_list) {
+			if (req->wb_page == page)
+				return req->wb_head;
+		}
+	}
+	return NULL;
+}
+
+/* pnfs_generic_search_commit_reqs - Search lists in @cinfo for the head reqest
+ *				   for @page
+ * @cinfo - commit info for current inode
+ * @page - page to search for matching head request
+ *
+ * Returns a the head request if one is found, otherwise returns NULL.
+ */
+struct nfs_page *
+pnfs_generic_search_commit_reqs(struct nfs_commit_info *cinfo, struct page *page)
+{
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
+	struct pnfs_commit_array *array;
+	struct nfs_page *req;
+
+	req = pnfs_bucket_search_commit_reqs(fl_cinfo->buckets,
+			fl_cinfo->nbuckets, page);
+	if (req)
+		return req;
+	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
+		req = pnfs_bucket_search_commit_reqs(array->buckets,
+				array->nbuckets, page);
+		if (req)
+			return req;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pnfs_generic_search_commit_reqs);
+
 static struct pnfs_layout_segment *
 pnfs_bucket_get_committing(struct list_head *head,
 			   struct pnfs_commit_bucket *bucket,
-- 
2.25.1

