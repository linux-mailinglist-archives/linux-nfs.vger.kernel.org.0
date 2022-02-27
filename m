Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303874C5FD8
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiB0XTV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiB0XTS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7552250A
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA1DB80CE0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536BC340F0
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003919;
        bh=Bg2e85OO/+fRAPnmVClp7gJZuYJlnK6kyX6mkYltXGU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NNa5i7v0JsVuCOru40rv6uEpBbic9+L/Qlt0waNcfcRm8QpTbSudDV9WCiuhzQuB1
         K68NMuWJu84XFpj1eeuR5qTfgglxKtpKKJaFW4mmLSLu9wE/KtNQSYEMRX1OHGyfgm
         aPPXntOp0zcV9nZKvNzGnvxTnJ8o0znKZ5XOtG74sW70mAzEII34taSsEC0DpcwmcZ
         OfKckY3+P6nyaUtTL2PwNPccYrrCkKMbOvLiJNW8KijYRAZQEmSiGlXPZxqIRuIxiT
         AIYh/R5NWOrrvJaGbD8XLXRjs1xoALwHRO3Jxv9ZH47JkbBkUwKCHR28/r1foT+wMT
         xzQKMfQORdWww==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 13/27] NFS: Reduce use of uncached readdir
Date:   Sun, 27 Feb 2022 18:12:13 -0500
Message-Id: <20220227231227.9038-14-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-13-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
 <20220227231227.9038-9-trondmy@kernel.org>
 <20220227231227.9038-10-trondmy@kernel.org>
 <20220227231227.9038-11-trondmy@kernel.org>
 <20220227231227.9038-12-trondmy@kernel.org>
 <20220227231227.9038-13-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index 0c190c93901e..0b7d4be38452 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -999,28 +999,11 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
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
@@ -1273,10 +1256,10 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
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

