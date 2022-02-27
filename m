Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184E94C5FCD
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiB0XTR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiB0XTQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D922252B
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36893611D8
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DF3C340EE
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003917;
        bh=UR+8yHtSOydvD9ZfjQSQNJsFHiKjdEUQbnYo80Hg5Ro=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MGSwP2WYSyvmAe/LmkWGwYiqZGDGHcAz/2qsYCwdszRX31Wd+23JRF5Wo1pvxY0iU
         iJLZIM2qnztbg7EoYzG+xXTYD9djyrbQbkz/Xxgdvr/g1sLNX/UOgpQRU41ntn39ho
         BYZujxIAnOl8h+8b03gufF80Rw+mSmLo4krynA1HDyBNVLR+i5idKOcZ2CXN11fTNI
         geKJVVqWJkks/3SdXfyQ2l/AC40lHSpD4s78I6KPNlwqlFU1bwfqa7OJB17IiEw0Rv
         bXQHYWmiY+Pejwaho60bCP7gZxzY60halvxYtYZJi+t8i2GepRtZMRciz5rnO+NFzv
         c0qWmjLpMyaAQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 08/27] NFS: Don't re-read the entire page cache to find the next cookie
Date:   Sun, 27 Feb 2022 18:12:08 -0500
Message-Id: <20220227231227.9038-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227231227.9038-8-trondmy@kernel.org>
References: <20220227231227.9038-1-trondmy@kernel.org>
 <20220227231227.9038-2-trondmy@kernel.org>
 <20220227231227.9038-3-trondmy@kernel.org>
 <20220227231227.9038-4-trondmy@kernel.org>
 <20220227231227.9038-5-trondmy@kernel.org>
 <20220227231227.9038-6-trondmy@kernel.org>
 <20220227231227.9038-7-trondmy@kernel.org>
 <20220227231227.9038-8-trondmy@kernel.org>
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

If the page cache entry that was last read gets invalidated for some
reason, then make sure we can re-create it on the next call to readdir.
This, combined with the cache page validation, allows us to reuse the
cached value of page-index on successive calls to nfs_readdir.

Credit is due to Benjamin Coddington for showing that the concept works,
and that it allows for improved cache sharing between processes even in
the case where pages are lost due to LRU or active invalidation.

Suggested-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c           | 10 +++++++---
 include/linux/nfs_fs.h |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index bfb553c57274..37f78b0ebc40 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1120,6 +1120,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->dup_cookie = dir_ctx->dup_cookie;
 	desc->duped = dir_ctx->duped;
 	page_index = dir_ctx->page_index;
+	desc->page_index = page_index;
+	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
@@ -1168,6 +1170,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	spin_lock(&file->f_lock);
 	dir_ctx->dir_cookie = desc->dir_cookie;
 	dir_ctx->dup_cookie = desc->dup_cookie;
+	dir_ctx->last_cookie = desc->last_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
@@ -1209,10 +1212,11 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	}
 	if (offset != filp->f_pos) {
 		filp->f_pos = offset;
-		if (nfs_readdir_use_cookie(filp))
-			dir_ctx->dir_cookie = offset;
-		else
+		if (!nfs_readdir_use_cookie(filp)) {
 			dir_ctx->dir_cookie = 0;
+			dir_ctx->page_index = 0;
+		} else
+			dir_ctx->dir_cookie = offset;
 		if (offset == 0)
 			memset(dir_ctx->verf, 0, sizeof(dir_ctx->verf));
 		dir_ctx->duped = 0;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 6e10725887d1..1c533f2c1f36 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -105,6 +105,7 @@ struct nfs_open_dir_context {
 	__be32	verf[NFS_DIR_VERIFIER_SIZE];
 	__u64 dir_cookie;
 	__u64 dup_cookie;
+	__u64 last_cookie;
 	pgoff_t page_index;
 	signed char duped;
 	bool eof;
-- 
2.35.1

