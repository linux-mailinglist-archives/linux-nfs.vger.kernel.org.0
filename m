Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2622A4A2D
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgKCPns (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbgKCPnr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:47 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939472080D
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418226;
        bh=qWt0VQmiDeAZrFk0vH2q8s8BUHR3wjC7YClarsfV/lw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Tu0pVo3/DsAew0Bi7FvMoq76RSx91co6LQZTSogSdsoCIQ/sXXMT8CprVbQm1Nrya
         qxEwieWob9lFne8qg8VNHabh8Y7W1BzE/y9ynpiDpFwirl3UnG6tJs7N04wO8iq+7o
         KWKgGRPdAKUSy17RTv/pZrXlkuJj3zOZR1jzJhlo=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 13/16] NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
Date:   Tue,  3 Nov 2020 10:33:26 -0500
Message-Id: <20201103153329.531942-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103153329.531942-13-trondmy@kernel.org>
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
 <20201103153329.531942-12-trondmy@kernel.org>
 <20201103153329.531942-13-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 75d7c3e8cf03..bc5260b8fe45 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,7 +144,7 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
-typedef struct nfs_readdir_descriptor {
+struct nfs_readdir_descriptor {
 	struct file	*file;
 	struct page	*page;
 	struct dir_context *ctx;
@@ -163,7 +163,7 @@ typedef struct nfs_readdir_descriptor {
 	signed char duped;
 	bool plus;
 	bool eof;
-} nfs_readdir_descriptor_t;
+};
 
 static void nfs_readdir_array_init(struct nfs_cache_array *array)
 {
@@ -363,8 +363,8 @@ bool nfs_readdir_use_cookie(const struct file *filp)
 	return true;
 }
 
-static
-int nfs_readdir_search_for_pos(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_pos(struct nfs_cache_array *array,
+				      struct nfs_readdir_descriptor *desc)
 {
 	loff_t diff = desc->ctx->pos - desc->current_index;
 	unsigned int index;
@@ -395,8 +395,8 @@ nfs_readdir_inode_mapping_valid(struct nfs_inode *nfsi)
 	return !test_bit(NFS_INO_INVALIDATING, &nfsi->flags);
 }
 
-static
-int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_for_cookie(struct nfs_cache_array *array,
+					 struct nfs_readdir_descriptor *desc)
 {
 	int i;
 	loff_t new_pos;
@@ -444,8 +444,7 @@ int nfs_readdir_search_for_cookie(struct nfs_cache_array *array, nfs_readdir_des
 	return status;
 }
 
-static
-int nfs_readdir_search_array(nfs_readdir_descriptor_t *desc)
+static int nfs_readdir_search_array(struct nfs_readdir_descriptor *desc)
 {
 	struct nfs_cache_array *array;
 	int status;
@@ -498,7 +497,7 @@ static int nfs_readdir_xdr_filler(struct nfs_readdir_descriptor *desc,
 	return error;
 }
 
-static int xdr_decode(nfs_readdir_descriptor_t *desc,
+static int xdr_decode(struct nfs_readdir_descriptor *desc,
 		      struct nfs_entry *entry, struct xdr_stream *xdr)
 {
 	struct inode *inode = file_inode(desc->file);
@@ -758,8 +757,8 @@ static struct page **nfs_readdir_alloc_pages(size_t npages)
 	return NULL;
 }
 
-static
-int nfs_readdir_xdr_to_array(nfs_readdir_descriptor_t *desc, struct page *page, struct inode *inode)
+static int nfs_readdir_xdr_to_array(struct nfs_readdir_descriptor *desc,
+				    struct page *page, struct inode *inode)
 {
 	struct page **pages;
 	struct nfs_entry *entry;
@@ -839,8 +838,7 @@ nfs_readdir_page_get_cached(struct nfs_readdir_descriptor *desc)
  * Returns 0 if desc->dir_cookie was found on page desc->page_index
  * and locks the page to prevent removal from the page cache.
  */
-static
-int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
+static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 {
 	struct inode *inode = file_inode(desc->file);
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -865,8 +863,7 @@ int find_and_lock_cache_page(nfs_readdir_descriptor_t *desc)
 }
 
 /* Search for desc->dir_cookie from the beginning of the page cache */
-static inline
-int readdir_search_pagecache(nfs_readdir_descriptor_t *desc)
+static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
@@ -931,8 +928,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
  *	 we should already have a complete representation of the
  *	 directory in the page cache by the time we get here.
  */
-static inline
-int uncached_readdir(nfs_readdir_descriptor_t *desc)
+static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 {
 	struct page	*page = NULL;
 	int		status;
-- 
2.28.0

