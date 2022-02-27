Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23514C5FCC
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbiB0XTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiB0XTQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662B022504
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2647BB80CDE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 943ECC340F4
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003915;
        bh=MmRjb0IrsOuCdjpF4K+k4IyOZ+lwxr6BM19ISvFn1VY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JPitooxviwwun316bz6sUDk2Bx9nXfO6LHgFKQDsjzSOpcmcN73cFnNGNO2jI3cAD
         6uK1G+gSrYBS+kjt6w7P2biroTlHzUWImG0k0YEsjZ0T4k/oPfOuagSAsl2hi49/kX
         2Wbkaf12dtaBaygiwOA61Isnf/EEw1O2Oxgjd8mJBECJzZkROnYkLY+0LU4kEJHuP1
         vd+wEE4FFKmwAzfwQn9beML/t8ndzD0Ru7GZOctSl/FMAsFMfdVsbO2lPq7psodlvf
         JZ96HUhlpKjOGhlQvCZPQM8buZ2Zw4hlEwXXfadYsq/ZKpa4doySHHtvy6BZerBfbE
         2MVOFTnd3pzsw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 05/27] NFS: Use kzalloc() to avoid initialising the nfs_open_dir_context
Date:   Sun, 27 Feb 2022 18:12:05 -0500
Message-Id: <20220227231227.9038-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-5-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 1dfbd05081ad..379f88b158fb 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -69,18 +69,15 @@ const struct address_space_operations nfs_dir_aops = {
 	.freepage = nfs_readdir_clear_array,
 };
 
-static struct nfs_open_dir_context *alloc_nfs_open_dir_context(struct inode *dir)
+static struct nfs_open_dir_context *
+alloc_nfs_open_dir_context(struct inode *dir)
 {
 	struct nfs_inode *nfsi = NFS_I(dir);
 	struct nfs_open_dir_context *ctx;
-	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL_ACCOUNT);
 	if (ctx != NULL) {
-		ctx->duped = 0;
 		ctx->attr_gencount = nfsi->attr_gencount;
-		ctx->dir_cookie = 0;
-		ctx->dup_cookie = 0;
-		ctx->page_index = 0;
-		ctx->eof = false;
 		spin_lock(&dir->i_lock);
 		if (list_empty(&nfsi->open_files) &&
 		    (nfsi->cache_validity & NFS_INO_DATA_INVAL_DEFER))
-- 
2.35.1

