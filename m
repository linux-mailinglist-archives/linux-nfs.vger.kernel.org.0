Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB01C1966FB
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgC1Peh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 28 Mar 2020 11:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbgC1Peg (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 28 Mar 2020 11:34:36 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48CFA2073B
        for <linux-nfs@vger.kernel.org>; Sat, 28 Mar 2020 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585409676;
        bh=7EnajCoY61wyaI04/xGUaouttgnSwwfGTe62JcRBxjE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MrjiTozTD0XEvIu+XErgUb/KqTrZ+ZprIxMDX7SQpvaujukGiKTKijDSHgmP0v8wW
         gWtsYUM4bGi7g+Qsq8pAb0fGa1rT4DHbABEfXagtXqggyRmMavyvC21j4XobpY+QVo
         5uUnMu2Q7kJd1Wpc46LIRumSNcZhhuXRvp10tGwY=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/22] pNFS: Support per-layout segment commits in pnfs_generic_commit_pagelist()
Date:   Sat, 28 Mar 2020 11:32:05 -0400
Message-Id: <20200328153220.1352010-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200328153220.1352010-7-trondmy@kernel.org>
References: <20200328153220.1352010-1-trondmy@kernel.org>
 <20200328153220.1352010-2-trondmy@kernel.org>
 <20200328153220.1352010-3-trondmy@kernel.org>
 <20200328153220.1352010-4-trondmy@kernel.org>
 <20200328153220.1352010-5-trondmy@kernel.org>
 <20200328153220.1352010-6-trondmy@kernel.org>
 <20200328153220.1352010-7-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for scanning the full list of per-layout segment commit
arrays to pnfs_generic_commit_pagelist().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pnfs_nfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index f16bd6d0e830..f895a28b1e26 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -322,6 +322,20 @@ pnfs_bucket_alloc_ds_commits(struct list_head *list,
 	return nreq;
 }
 
+static unsigned int
+pnfs_alloc_ds_commits_list(struct list_head *list,
+			   struct pnfs_ds_commit_info *fl_cinfo,
+			   struct nfs_commit_info *cinfo)
+{
+	struct pnfs_commit_array *array;
+	unsigned int ret = 0;
+
+	list_for_each_entry(array, &fl_cinfo->commits, cinfo_list)
+		ret += pnfs_bucket_alloc_ds_commits(list, array->buckets,
+				array->nbuckets, cinfo);
+	return ret;
+}
+
 /* This follows nfs_commit_list pretty closely */
 int
 pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
@@ -345,6 +359,8 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 
 	nreq += pnfs_bucket_alloc_ds_commits(&list, fl_cinfo->buckets,
 			fl_cinfo->nbuckets, cinfo);
+
+	nreq += pnfs_alloc_ds_commits_list(&list, fl_cinfo, cinfo);
 	if (nreq == 0)
 		goto out;
 
-- 
2.25.1

