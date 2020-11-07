Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143412AA5D8
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Nov 2020 15:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgKGONv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Nov 2020 09:13:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:58260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbgKGONq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 7 Nov 2020 09:13:46 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 963F02087E
        for <linux-nfs@vger.kernel.org>; Sat,  7 Nov 2020 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604758425;
        bh=X2+lGW7G/4LdYGNIaAOy3OIdR/2FceS3tTfu5QZPVLM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1k7Md09odS3jjBoIxghAHHriL785EaRresQVZkcD9eF9apuUWH4x++59tJyC0O8KY
         hi+dAQrmgDdcVUhwqZLcIqPLofaW0CaybQuUffZay4Msh81rSsHP43RIoGpI2FzCfu
         LBKb8tzLf9MChKwKqS8ozVQEMNCt/vb5a13OllNU=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v4 21/21] NFS: Do uncached readdir when we're seeking a cookie in an empty page cache
Date:   Sat,  7 Nov 2020 09:03:25 -0500
Message-Id: <20201107140325.281678-22-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107140325.281678-21-trondmy@kernel.org>
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
 <20201107140325.281678-14-trondmy@kernel.org>
 <20201107140325.281678-15-trondmy@kernel.org>
 <20201107140325.281678-16-trondmy@kernel.org>
 <20201107140325.281678-17-trondmy@kernel.org>
 <20201107140325.281678-18-trondmy@kernel.org>
 <20201107140325.281678-19-trondmy@kernel.org>
 <20201107140325.281678-20-trondmy@kernel.org>
 <20201107140325.281678-21-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the directory is changing, causing the page cache to get invalidated
while we are listing the contents, then the NFS client is currently forced
to read in the entire directory contents from scratch, because it needs
to perform a linear search for the readdir cookie. While this is not
an issue for small directories, it does not scale to directories with
millions of entries.
In order to be able to deal with large directories that are changing,
add a heuristic to ensure that if the page cache is empty, and we are
searching for a cookie that is not the zero cookie, we just default to
performing uncached readdir.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 238872d116f7..d7a9efd31ecd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -917,11 +917,28 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	return res;
 }
 
+static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
+{
+	struct address_space *mapping = desc->file->f_mapping;
+	struct inode *dir = file_inode(desc->file);
+	unsigned int dtsize = NFS_SERVER(dir)->dtsize;
+	loff_t size = i_size_read(dir);
+
+	/*
+	 * Default to uncached readdir if the page cache is empty, and
+	 * we're looking for a non-zero cookie in a large directory.
+	 */
+	return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
+}
+
 /* Search for desc->dir_cookie from the beginning of the page cache */
 static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
+	if (nfs_readdir_dont_search_cache(desc))
+		return -EBADCOOKIE;
+
 	do {
 		if (desc->page_index == 0) {
 			desc->current_index = 0;
-- 
2.28.0

