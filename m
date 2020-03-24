Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3DE191DB0
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgCXXtm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgCXXtl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:41 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D8F2072E
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093781;
        bh=7EnajCoY61wyaI04/xGUaouttgnSwwfGTe62JcRBxjE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dQani27y7k6IiSGhhX0m61Hq93Oy1jTHlLTgyqq+7b31On8zh8ycHEXA8XNUU+9Ep
         jDXnW8Zt183CRRtbkZVVhErVN1jIcXrUXDpGS5yeZB0eSGp9O4mT/Gdxz2M95BQlSq
         pwqGt/KdQ5qEm7aiWX2jDLahzziU0gqr/2q5WDxM=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 07/22] pNFS: Support per-layout segment commits in pnfs_generic_commit_pagelist()
Date:   Tue, 24 Mar 2020 19:47:13 -0400
Message-Id: <20200324234728.8997-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-7-trondmy@kernel.org>
References: <20200324234728.8997-1-trondmy@kernel.org>
 <20200324234728.8997-2-trondmy@kernel.org>
 <20200324234728.8997-3-trondmy@kernel.org>
 <20200324234728.8997-4-trondmy@kernel.org>
 <20200324234728.8997-5-trondmy@kernel.org>
 <20200324234728.8997-6-trondmy@kernel.org>
 <20200324234728.8997-7-trondmy@kernel.org>
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

