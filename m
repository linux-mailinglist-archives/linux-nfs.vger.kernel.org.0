Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C5D2AA5D4
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 15:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgKGONo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Nov 2020 09:13:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgKGONm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 7 Nov 2020 09:13:42 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E927220885
        for <linux-nfs@vger.kernel.org>; Sat,  7 Nov 2020 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604758422;
        bh=SQprFueWxwo11HUVBgIewh1mzfWa9F+j7S5MTfLxYzA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y/nTfI/tD6Mw+6V646D9jqL/ZENFpo9F2x/5IsE1TN7HHJQZ3QsY9MlhKTZSAi3cN
         VlnhVjcG0Psybw0JepjA4U7V9CF+jK/tfj3SORMG7SVAenzj3PkR7X3zpA8LGhKM+Z
         tfq5W6et7Qh2t+dReEXgEF0nUyR7GuNKU2i6thdY=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 13/21] NFS: nfs_do_filldir() does not return a value
Date:   Sat,  7 Nov 2020 09:03:17 -0500
Message-Id: <20201107140325.281678-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107140325.281678-13-trondmy@kernel.org>
References: <20201107140325.281678-1-trondmy@kernel.org>
 <20201107140325.281678-2-trondmy@kernel.org>
 <20201107140325.281678-3-trondmy@kernel.org>
 <20201107140325.281678-4-trondmy@kernel.org>
 <20201107140325.281678-5-trondmy@kernel.org>
 <20201107140325.281678-6-trondmy@kernel.org>
 <20201107140325.281678-7-trondmy@kernel.org>
 <20201107140325.281678-8-trondmy@kernel.org>
 <20201107140325.281678-9-trondmy@kernel.org>
 <20201107140325.281678-10-trondmy@kernel.org>
 <20201107140325.281678-11-trondmy@kernel.org>
 <20201107140325.281678-12-trondmy@kernel.org>
 <20201107140325.281678-13-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Clean up nfs_do_filldir().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bc366bd8e8f3..48856cee10de 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -881,13 +881,11 @@ int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
-static 
-int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
+static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 {
 	struct file	*file = desc->file;
-	int i = 0;
-	int res = 0;
-	struct nfs_cache_array *array = NULL;
+	struct nfs_cache_array *array;
+	unsigned int i = 0;
 
 	array = kmap(desc->page);
 	for (i = desc->cache_entry_index; i < array->size; i++) {
@@ -914,9 +912,8 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		desc->eof = true;
 
 	kunmap(desc->page);
-	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n",
-			(unsigned long long)desc->dir_cookie, res);
-	return res;
+	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
+			(unsigned long long)desc->dir_cookie);
 }
 
 /*
@@ -957,7 +954,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	if (status < 0)
 		goto out_release;
 
-	status = nfs_do_filldir(desc);
+	nfs_do_filldir(desc);
 
  out_release:
 	nfs_readdir_clear_array(desc->page);
@@ -1032,10 +1029,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		if (res < 0)
 			break;
 
-		res = nfs_do_filldir(desc);
+		nfs_do_filldir(desc);
 		nfs_readdir_page_unlock_and_put_cached(desc);
-		if (res < 0)
-			break;
 	} while (!desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1046,8 +1041,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	spin_unlock(&file->f_lock);
 
 out:
-	if (res > 0)
-		res = 0;
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
 }
-- 
2.28.0

