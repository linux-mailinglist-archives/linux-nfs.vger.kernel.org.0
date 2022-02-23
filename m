Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53844C1D92
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Feb 2022 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiBWVUC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Feb 2022 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242398AbiBWVUC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Feb 2022 16:20:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E695B4EA25
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 13:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8104F6189D
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1701C340F3
        for <linux-nfs@vger.kernel.org>; Wed, 23 Feb 2022 21:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645651172;
        bh=bB/gp+z+dEpo/jps+MUjpp/jwTznG73nN6OpN9S8BH0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pWmdSRq5EIK+WvIhz+KUDfLzwwtaIK7GLFYV96+Bc/6HwNx4lUApQH8g+couqp1AN
         41tILiqkATDg07z6H0YkLq/y1or057ieQhSa4y64/cLAUi1MOun2E+wI+BCk2ru2gg
         Vt8IDailtWklxcIz/8hOVKcA7DYyO5Q3O48s/CmYT2YvYT+5DO0i9NuTLkqpLuG5yZ
         N4fKRCglO9Ws6Dhd1jWQfhQrx+cYbaAi0e4eGFmX1b8lNhrCsDeY+/yBYQsPcztBH2
         PAfjtH7VBu8kJyMTcA8Ivo9nd/CcUK0PC9xfHWWvCsF0zQzFzuK89q5YSBdvxm1Lm5
         B9q+kr0o5vjUQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v7 03/21] NFS: Use kzalloc() to avoid initialising the nfs_open_dir_context
Date:   Wed, 23 Feb 2022 16:12:47 -0500
Message-Id: <20220223211305.296816-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220223211305.296816-3-trondmy@kernel.org>
References: <20220223211305.296816-1-trondmy@kernel.org>
 <20220223211305.296816-2-trondmy@kernel.org>
 <20220223211305.296816-3-trondmy@kernel.org>
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
index 1aa55cac9d9a..8f17aaebcd77 100644
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

