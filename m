Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A21EC191DB3
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCXXtn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgCXXtn (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:43 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A9C920719
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093782;
        bh=9TfW3eJyhlN+A0d2XUhAtxTSyb8hkL/qjLtKnnStKMQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=q4Rza0JzomfBzJ3eoxHDfR07M9Y25chOHx4A5kjYQ+FjT59INNakePyljNkf8dZpW
         q65wTD9VhbdiR1DrGv/NEsrMqgrMJYBWnnYSx/4TAPMeRqFzLzPMZVXsxvnAQeq+Y7
         cGhIEfon7I7b7UJCpa4UWtjGVDKHDWgwntMKlkwc=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/22] NFS/pNFS: Support commit arrays in nfs_clear_pnfs_ds_commit_verifiers()
Date:   Tue, 24 Mar 2020 19:47:17 -0400
Message-Id: <20200324234728.8997-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324234728.8997-11-trondmy@kernel.org>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for scanning the full list of per-layout segment commit
arrays to nfs_clear_pnfs_ds_commit_verifiers().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/internal.h | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6542411c020f..4a1adad3740f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -517,13 +517,26 @@ int nfs_filemap_write_and_wait_range(struct address_space *mapping,
 		loff_t lstart, loff_t lend);
 
 #ifdef CONFIG_NFS_V4_1
+static inline void
+pnfs_bucket_clear_pnfs_ds_commit_verifiers(struct pnfs_commit_bucket *buckets,
+		unsigned int nbuckets)
+{
+	unsigned int i;
+
+	for (i = 0; i < nbuckets; i++)
+		buckets[i].direct_verf.committed = NFS_INVALID_STABLE_HOW;
+}
 static inline
 void nfs_clear_pnfs_ds_commit_verifiers(struct pnfs_ds_commit_info *cinfo)
 {
-	int i;
+	struct pnfs_commit_array *array;
+
+	pnfs_bucket_clear_pnfs_ds_commit_verifiers(cinfo->buckets,
+			cinfo->nbuckets);
 
-	for (i = 0; i < cinfo->nbuckets; i++)
-		cinfo->buckets[i].direct_verf.committed = NFS_INVALID_STABLE_HOW;
+	list_for_each_entry(array, &cinfo->commits, cinfo_list)
+		pnfs_bucket_clear_pnfs_ds_commit_verifiers(array->buckets,
+				array->nbuckets);
 }
 #else
 static inline
-- 
2.25.1

