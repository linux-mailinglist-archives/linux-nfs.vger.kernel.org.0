Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9594C1DA0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242403AbiBWVUI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242442AbiBWVUF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09A14ECC9
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBEA6189F
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D3C340F1
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651175;
        bh=1GcyI+UqjembG1jSn4h6EOLLDldBloU94xugDNPI6P4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QpL1TX5HHMcuIZSU/EY8iMY9aqZFf0NeoGEwjjWwqWQ+tzouY/iL5hdn4t6AZJK8L
         g9VSxSawKaZOnWlDMUfMxmdvDgted4betGTUtQfy45JLc2cn3dqR52AyJ104fOyXuQ
         LM1SVGvsoqA9A0qupHbT2b3Jgu75m9Z7spdR/HsgvrMBh5Yp+DhpGpoPdlKT8PMYBA
         RBqEupYwpRnNDeTjJS4xYeryidM00kvV98ajLH2Otp3nEVAPIJx10xXDNGqd6y6Jt5
         cmomDQGEzY5VvEldvxG0EBR/m8XRUjQ5uLSHpMJG4N0ytyz4C0XBUG4IPPRp7aMxlf
         /U8mbU2t4R2JQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 10/21] NFS: Reduce use of uncached readdir
Date:   Wed, 23 Feb 2022 16:12:54 -0500
Message-Id: <20220223211305.296816-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-10-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
 <20220223211305.296816-4-trondmy@kernel.org>
 <20220223211305.296816-5-trondmy@kernel.org>
 <20220223211305.296816-6-trondmy@kernel.org>
 <20220223211305.296816-7-trondmy@kernel.org>
 <20220223211305.296816-8-trondmy@kernel.org>
 <20220223211305.296816-9-trondmy@kernel.org>
 <20220223211305.296816-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When reading a very large directory, we want to try to keep the page
cache up to date if doing so is inexpensive. With the change to allow
readdir to continue reading even when the cache is incomplete, we no
longer need to fall back to uncached readdir in order to scale to large
directories.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 9b0f13b52dbf..982b5dbe30d7 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -986,28 +986,11 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
 	return res;
 }
 
-static bool nfs_readdir_dont_search_cache(struct nfs_readdir_descriptor *desc)
-{
-	struct address_space *mapping = desc->file->f_mapping;
-	struct inode *dir = file_inode(desc->file);
-	unsigned int dtsize = NFS_SERVER(dir)->dtsize;
-	loff_t size = i_size_read(dir);
-
-	/*
-	 * Default to uncached readdir if the page cache is empty, and
-	 * we're looking for a non-zero cookie in a large directory.
-	 */
-	return desc->dir_cookie != 0 && mapping->nrpages == 0 && size > dtsize;
-}
-
 /* Search for desc->dir_cookie from the beginning of the page cache */
 static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 {
 	int res;
 
-	if (nfs_readdir_dont_search_cache(desc))
-		return -EBADCOOKIE;
-
 	do {
 		if (desc->page_index == 0) {
 			desc->current_index = 0;
@@ -1262,10 +1245,10 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	}
 	if (offset != filp->f_pos) {
 		filp->f_pos = offset;
-		if (!nfs_readdir_use_cookie(filp)) {
+		dir_ctx->page_index = 0;
+		if (!nfs_readdir_use_cookie(filp))
 			dir_ctx->dir_cookie = 0;
-			dir_ctx->page_index = 0;
-		} else
+		else
 			dir_ctx->dir_cookie = offset;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
-- 
2.35.1

