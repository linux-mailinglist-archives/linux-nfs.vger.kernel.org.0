Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9762AE218
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbgKJVsG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:48:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:43198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731968AbgKJVsF (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:48:05 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5D91207D3
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044884;
        bh=3RbKvUSlWZDM/tngtumr72VAvY3JMDjHf3flKcaK+Ag=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xgOqKkPxgGUC8HTn9hSxUd8PRLjYD6+MGdw6Vm2VyjDENzA2jilTEA1juw/cGAIJ2
         zyuefnEw69XYKsg20KfwFICrTxcPI9Y6F5XN44ydlTWhfB0iQrPV9h1aebrxGwrGIl
         Y+lPUH93opb6K9lANu/4rtyoJUpCmuilXh2LgUYk=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 22/22] NFS: Do uncached readdir when we're seeking a cookie in an empty page cache
Date:   Tue, 10 Nov 2020 16:37:41 -0500
Message-Id: <20201110213741.860745-23-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-22-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
 <20201110213741.860745-2-trondmy@kernel.org>
 <20201110213741.860745-3-trondmy@kernel.org>
 <20201110213741.860745-4-trondmy@kernel.org>
 <20201110213741.860745-5-trondmy@kernel.org>
 <20201110213741.860745-6-trondmy@kernel.org>
 <20201110213741.860745-7-trondmy@kernel.org>
 <20201110213741.860745-8-trondmy@kernel.org>
 <20201110213741.860745-9-trondmy@kernel.org>
 <20201110213741.860745-10-trondmy@kernel.org>
 <20201110213741.860745-11-trondmy@kernel.org>
 <20201110213741.860745-12-trondmy@kernel.org>
 <20201110213741.860745-13-trondmy@kernel.org>
 <20201110213741.860745-14-trondmy@kernel.org>
 <20201110213741.860745-15-trondmy@kernel.org>
 <20201110213741.860745-16-trondmy@kernel.org>
 <20201110213741.860745-17-trondmy@kernel.org>
 <20201110213741.860745-18-trondmy@kernel.org>
 <20201110213741.860745-19-trondmy@kernel.org>
 <20201110213741.860745-20-trondmy@kernel.org>
 <20201110213741.860745-21-trondmy@kernel.org>
 <20201110213741.860745-22-trondmy@kernel.org>
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
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/dir.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 93c6f22cdc62..3f70697729d8 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -937,11 +937,28 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
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

