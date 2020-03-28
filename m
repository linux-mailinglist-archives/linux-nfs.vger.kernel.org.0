Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EF6196706
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgC1Pem (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbgC1Pel (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:41 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C4CA2073B
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409681;
        bh=+SFShDxnoX+gVXJT4uPxAaGlDjkIaMd8lZ0ElJY57m0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=oypH7GgjQyt+jYGpGipTemTdSliCmkNLEGUfdnxdNvrQjo0Q6gWhUrOYNcI77jnMT
         EZxvNeTMJXgm/v0HO7Xd+blFKearldO3IkvklyMy+104WBgYWpmEJEnVRvLou0mtJY
         6rqQSdyZ4DuEA/vRlSrkyoSlQTq9qZusUFqOvOIQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 18/22] NFS/pNFS: Fix pnfs_layout_mark_request_commit() invalid layout segment handling
Date:   Sat, 28 Mar 2020 11:32:16 -0400
Message-Id: <20200328153220.1352010-19-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-18-trondmy@kernel.org>
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
 <20200328153220.1352010-15-trondmy@kernel.org>
 <20200328153220.1352010-16-trondmy@kernel.org>
 <20200328153220.1352010-17-trondmy@kernel.org>
 <20200328153220.1352010-18-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Fix up pnfs_layout_mark_request_commit() to alway reschedule the write
if the layout segment is invalid. Also minor cleanup.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index abf16fc98346..25f135572fc8 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1166,26 +1166,22 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 {
 	struct list_head *list;
 	struct pnfs_commit_array *array;
-	struct pnfs_commit_bucket *buckets;
+	struct pnfs_commit_bucket *bucket;
 
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	array = pnfs_lookup_commit_array(cinfo->ds, lseg);
-	if (!array)
+	if (!array || !pnfs_is_valid_lseg(lseg))
 		goto out_resched;
-	buckets = array->buckets;
-	list = &buckets[ds_commit_idx].written;
-	if (list_empty(list)) {
-		if (!pnfs_is_valid_lseg(lseg))
-			goto out_resched;
-		/* Non-empty buckets hold a reference on the lseg.  That ref
-		 * is normally transferred to the COMMIT call and released
-		 * there.  It could also be released if the last req is pulled
-		 * off due to a rewrite, in which case it will be done in
-		 * pnfs_common_clear_request_commit
-		 */
-		if (!buckets[ds_commit_idx].lseg)
-			buckets[ds_commit_idx].lseg = pnfs_get_lseg(lseg);
-	}
+	bucket = &array->buckets[ds_commit_idx];
+	list = &bucket->written;
+	/* Non-empty buckets hold a reference on the lseg.  That ref
+	 * is normally transferred to the COMMIT call and released
+	 * there.  It could also be released if the last req is pulled
+	 * off due to a rewrite, in which case it will be done in
+	 * pnfs_common_clear_request_commit
+	 */
+	if (!bucket->lseg)
+		bucket->lseg = pnfs_get_lseg(lseg);
 	set_bit(PG_COMMIT_TO_DS, &req->wb_flags);
 	cinfo->ds->nwritten++;
 
-- 
2.25.1

