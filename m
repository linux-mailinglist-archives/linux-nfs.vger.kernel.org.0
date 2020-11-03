Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63AC2A4A2A
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgKCPnr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgKCPnq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:46 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A23042236F
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418225;
        bh=fP8mF/QyWT8AjyqHoLygoPSmGXi5i/cnj5jFbOxXyKo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DfMSzZQPHIxOw9FQSL+Tn8SRJBexadWRLpZCyijtKgJM+vvGKRnzPWKzDMeTX2QNC
         bDRVubf5yimq7uFvbR9jAI3rsdQ2R+UluyhYwUm9Fq5aCf4i8PFuvj8+wBJJnCwvxv
         X4w8THJeDTYKw6z8Uh58IJ6s5o+GolkviF2HjkuQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 11/16] NFS: nfs_do_filldir() does not return a value
Date:   Tue,  3 Nov 2020 10:33:24 -0500
Message-Id: <20201103153329.531942-12-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103153329.531942-11-trondmy@kernel.org>
References: <20201103153329.531942-1-trondmy@kernel.org>
 <20201103153329.531942-2-trondmy@kernel.org>
 <20201103153329.531942-3-trondmy@kernel.org>
 <20201103153329.531942-4-trondmy@kernel.org>
 <20201103153329.531942-5-trondmy@kernel.org>
 <20201103153329.531942-6-trondmy@kernel.org>
 <20201103153329.531942-7-trondmy@kernel.org>
 <20201103153329.531942-8-trondmy@kernel.org>
 <20201103153329.531942-9-trondmy@kernel.org>
 <20201103153329.531942-10-trondmy@kernel.org>
 <20201103153329.531942-11-trondmy@kernel.org>
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
index b09073afb51b..647585358901 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -882,13 +882,11 @@ int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
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
@@ -915,9 +913,8 @@ int nfs_do_filldir(nfs_readdir_descriptor_t *desc)
 		desc->eof = true;
 
 	kunmap(desc->page);
-	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %Lu; returning = %d\n",
-			(unsigned long long)desc->dir_cookie, res);
-	return res;
+	dfprintk(DIRCACHE, "NFS: nfs_do_filldir() filling ended @ cookie %llu\n",
+			(unsigned long long)desc->dir_cookie);
 }
 
 /*
@@ -958,7 +955,7 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	if (status < 0)
 		goto out_release;
 
-	status = nfs_do_filldir(desc);
+	nfs_do_filldir(desc);
 
  out_release:
 	nfs_readdir_clear_array(desc->page);
@@ -1033,10 +1030,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		if (res < 0)
 			break;
 
-		res = nfs_do_filldir(desc);
+		nfs_do_filldir(desc);
 		nfs_readdir_page_unlock_and_put_cached(desc);
-		if (res < 0)
-			break;
 	} while (!desc->eof);
 
 	spin_lock(&file->f_lock);
@@ -1047,8 +1042,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	spin_unlock(&file->f_lock);
 
 out:
-	if (res > 0)
-		res = 0;
 	dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
 	return res;
 }
-- 
2.28.0

