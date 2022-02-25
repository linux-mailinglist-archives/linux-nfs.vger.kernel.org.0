Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5D34C4DE5
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbiBYSfW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EBE1AAA53
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DC4DB83308
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A9EC340F1
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814080;
        bh=OiFNVdnDpPaKpdskCdO53xgbGuUF9Blf9zplN9ZKsvU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hMEBHZ0K2b/hz7IS4VnLZNA2N+8fLvRYqR5g+KAl00Robzz5hP6BhDhh0F9OrKNEI
         VF2ua4enPdfnWaSNmUcqpxkqWIV5N4vfO1n1OVgVOXEDORcXSEQIj28fnJbA1kb7cj
         Djj8GCXhOmDiGv6TOa3/vs8MG7KDUt2u34/t1NUx2c1NdtIGxfcOCEbjQLsV6wbUy8
         j8yRwArpEMzaIBaPWgXT4i2iMXvcZvTksTGpr1q/uZw/jJpBhjmYz8G8BdeRI/Z8Gj
         X95JNzISChRADIP4CB6CvdrgM91ygGGtyJJP28R02Oi9vTq3wKkdeEZ3JUkwd8Tfne
         LiGHoZjGVhaLg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 12/24] NFS: Reduce use of uncached readdir
Date:   Fri, 25 Feb 2022 13:28:17 -0500
Message-Id: <20220225182829.1236093-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-12-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
 <20220225182829.1236093-10-trondmy@kernel.org>
 <20220225182829.1236093-11-trondmy@kernel.org>
 <20220225182829.1236093-12-trondmy@kernel.org>
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
index 1c79244115f0..03ba892bb195 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -989,28 +989,11 @@ static int find_and_lock_cache_page(struct nfs_readdir_descriptor *desc)
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
@@ -1260,10 +1243,10 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
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

