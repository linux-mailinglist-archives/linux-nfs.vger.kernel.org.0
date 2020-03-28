Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEC2D196703
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgC1Pek (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgC1Pek (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:40 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507F3207FF
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409679;
        bh=J1Chf//k42lvRNcoJ1iT6n2WMRpTbOmpYbCBBwJIA4Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HsDc2NfJ88QHju5j2wgl4qV69rOYynyeg+joA9eHcP34V9PRXmpltvPzSZ6wIFEx4
         5OMb9cRhPE1UBp2S3z6ZjOomul4zRaI/LXuhwW/we+q46UG2MS9QH6Lk7BJ4VnLm3h
         TRtsObLwHAzBvFLCI0zZNSOgF1WFvrqf8lqoeXpk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 14/22] NFS/pNFS: Add a helper pnfs_generic_search_commit_reqs()
Date:   Sat, 28 Mar 2020 11:32:12 -0400
Message-Id: <20200328153220.1352010-15-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-14-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
 <20200328153220.1352010-8-trondmy@kernel.org>
 <20200328153220.1352010-9-trondmy@kernel.org>
 <20200328153220.1352010-10-trondmy@kernel.org>
 <20200328153220.1352010-11-trondmy@kernel.org>
 <20200328153220.1352010-12-trondmy@kernel.org>
 <20200328153220.1352010-13-trondmy@kernel.org>
 <20200328153220.1352010-14-trondmy@kernel.org>
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
index e3cf42c91d80..795508054a4d 100644
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
index 9647045a60c2..faed9be6e479 100644
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

