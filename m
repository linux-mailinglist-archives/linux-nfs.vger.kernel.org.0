Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26D5191DAE
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCXXtl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgCXXtk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:40 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19552073C
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093780;
        bh=asZPu00uS55iLq65hnYce26g4HNvsBAKVZEYJOk+hl8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ivo0NeoGuYpZiPYNbCxYu5JLfqWEsN8rfx1QgLLA+lLwbG9yUJ8yr/VGA9H3V6xT2
         yI1ZZqZNPyqQoIUgcbrfbDrpsbP4gL0kVE7qBsyU/NxRLDcH+TnrdAXxjC+nqk11K9
         /3pw0N8rmgiLXuvWuJz1+UjrCLDfEmfvcUNx5RNo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/22] NFSv4/pNFS: Scan the full list of commit arrays when committing
Date:   Tue, 24 Mar 2020 19:47:11 -0400
Message-Id: <20200324234728.8997-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-5-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for scanning the full list of per-layout segment commit
arrays to pnfs_generic_scan_commit_lists()

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 52 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index c8518ce3a4ef..81fd85e66fd9 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -118,10 +118,14 @@ pnfs_free_commit_array(struct pnfs_commit_array *p)
 }
 EXPORT_SYMBOL_GPL(pnfs_free_commit_array);
 
+/*
+ * Locks the nfs_page requests for commit and moves them to
+ * @bucket->committing.
+ */
 static int
-pnfs_generic_scan_ds_commit_list(struct pnfs_commit_bucket *bucket,
-				 struct nfs_commit_info *cinfo,
-				 int max)
+pnfs_bucket_scan_ds_commit_list(struct pnfs_commit_bucket *bucket,
+				struct nfs_commit_info *cinfo,
+				int max)
 {
 	struct list_head *src = &bucket->written;
 	struct list_head *dst = &bucket->committing;
@@ -142,20 +146,44 @@ pnfs_generic_scan_ds_commit_list(struct pnfs_commit_bucket *bucket,
 	return ret;
 }
 
+static int pnfs_bucket_scan_array(struct nfs_commit_info *cinfo,
+				  struct pnfs_commit_bucket *buckets,
+				  unsigned int nbuckets,
+				  int max)
+{
+	unsigned int i;
+	int rv = 0, cnt;
+
+	for (i = 0; i < nbuckets && max != 0; i++) {
+		cnt = pnfs_bucket_scan_ds_commit_list(&buckets[i], cinfo, max);
+		rv += cnt;
+		max -= cnt;
+	}
+	return rv;
+}
+
 /* Move reqs from written to committing lists, returning count
  * of number moved.
  */
-int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo,
-				   int max)
+int pnfs_generic_scan_commit_lists(struct nfs_commit_info *cinfo, int max)
 {
-	int i, rv = 0, cnt;
-
-	lockdep_assert_held(&NFS_I(cinfo->inode)->commit_mutex);
-	for (i = 0; i < cinfo->ds->nbuckets && max != 0; i++) {
-		cnt = pnfs_generic_scan_ds_commit_list(&cinfo->ds->buckets[i],
-						       cinfo, max);
-		max -= cnt;
+	struct pnfs_ds_commit_info *fl_cinfo = cinfo->ds;
+	struct pnfs_commit_array *array;
+	int rv = 0, cnt;
+
+	cnt = pnfs_bucket_scan_array(cinfo, fl_cinfo->buckets,
+			fl_cinfo->nbuckets, max);
+	rv += cnt;
+	max -= cnt;
+	if (!max)
+		return rv;
+	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list) {
+		cnt = pnfs_bucket_scan_array(cinfo, array->buckets,
+				array->nbuckets, max);
 		rv += cnt;
+		max -= cnt;
+		if (!max)
+			break;
 	}
 	return rv;
 }
-- 
2.25.1

