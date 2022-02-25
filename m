Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBCF4C4DE0
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiBYSfT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B88A1A9055
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 286EDB8330D
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A644EC340E7
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814077;
        bh=MmRjb0IrsOuCdjpF4K+k4IyOZ+lwxr6BM19ISvFn1VY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dm9g35mBQ1qK7mT/8ZKwzfbpJ+td0qe+k36QjAKmhVMQfOJ4fD/wxP9KCQHGQ7e4j
         GkPIqjV/Cw824HGk4ub0Y5dGQIK9wwUae7p38C5GqhgE8PEYo/DVfNLbNaw4R8Tjxa
         RGpZ8nD5KCw5Il9KBnF2to+vn8YOlZFvZpGeCnWQZOHShAc8Q7JrCVFWRbZ86CSoQ3
         FnIsw836/g2KoTPOvA0gzSVaTrbrx3Go2HRqyPLWkWafYcZ0xVDUy9ZafuC0+5IeW/
         q1UTPe04gfQu5WmuniKb6Jytmh1+PDRpm30mNW3neI5ZOliOZAfFKk2+8NrqsTefHM
         iviLr0C3ZlA6A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 05/24] NFS: Use kzalloc() to avoid initialising the nfs_open_dir_context
Date:   Fri, 25 Feb 2022 13:28:10 -0500
Message-Id: <20220225182829.1236093-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-5-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
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

