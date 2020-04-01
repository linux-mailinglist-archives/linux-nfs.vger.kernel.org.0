Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D847F19B617
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbgDAS7D (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732214AbgDAS7D (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:03 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1D3206F5
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767542;
        bh=VH3naXrZJNmMM76JYbMGM3fauW+ZNrMH7wpXWz6OOaE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E89UrnRaO4Sxi4Ltid+X6g5It7HMKhA3MAI/v2gWSCsLzy2ZsI8HyVZFhiaFvEuxn
         m7mnt9lWWJPAb2cx6zAvS4lXovohFSLgztz+mCci7Q+JxYnkfrFmIphFxqPSowuU3Y
         Quh79sVInOpEHu0/6RKMhIrT9HR9Q0PHWOr9Vr2Y=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/10] NFS: Fix memory leaks in nfs_pageio_stop_mirroring()
Date:   Wed,  1 Apr 2020 14:56:47 -0400
Message-Id: <20200401185652.1904777-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401185652.1904777-5-trondmy@kernel.org>
References: <20200401185652.1904777-1-trondmy@kernel.org>
 <20200401185652.1904777-2-trondmy@kernel.org>
 <20200401185652.1904777-3-trondmy@kernel.org>
 <20200401185652.1904777-4-trondmy@kernel.org>
 <20200401185652.1904777-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we just set the mirror count to 1 without first clearing out
the mirrors, we can leak queued up requests.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 99eb839c5778..1fd4862217e0 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -900,15 +900,6 @@ static void nfs_pageio_setup_mirroring(struct nfs_pageio_descriptor *pgio,
 	pgio->pg_mirror_count = mirror_count;
 }
 
-/*
- * nfs_pageio_stop_mirroring - stop using mirroring (set mirror count to 1)
- */
-void nfs_pageio_stop_mirroring(struct nfs_pageio_descriptor *pgio)
-{
-	pgio->pg_mirror_count = 1;
-	pgio->pg_mirror_idx = 0;
-}
-
 static void nfs_pageio_cleanup_mirroring(struct nfs_pageio_descriptor *pgio)
 {
 	pgio->pg_mirror_count = 1;
@@ -1334,6 +1325,14 @@ void nfs_pageio_cond_complete(struct nfs_pageio_descriptor *desc, pgoff_t index)
 	}
 }
 
+/*
+ * nfs_pageio_stop_mirroring - stop using mirroring (set mirror count to 1)
+ */
+void nfs_pageio_stop_mirroring(struct nfs_pageio_descriptor *pgio)
+{
+	nfs_pageio_complete(pgio);
+}
+
 int __init nfs_init_nfspagecache(void)
 {
 	nfs_page_cachep = kmem_cache_create("nfs_page",
-- 
2.25.1

