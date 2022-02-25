Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D900A4C4DE3
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Feb 2022 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiBYSfX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 25 Feb 2022 13:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbiBYSfQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 25 Feb 2022 13:35:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A81A905E
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 10:34:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0B95B83311
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5465AC340F4
        for <linux-nfs@vger.kernel.org>; Fri, 25 Feb 2022 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645814079;
        bh=Maf7kKFFOFCnH8ZDoumF8Xs6FCKA8kE874bD1VZHvxA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hX+lGPLzLG5mXa2qvBnWQbcEwBeMh9p09HocNCqsPQvCzpiBkgFggncRxxxEYaiwO
         L4EMY/nLl++QmGrcTPLdntRvbnQcyetz4UysOmaAmeUp35losaQYJ3t7H2RWgLjuo2
         +Sutdc+Dkjzb0Jgs0FQGBJ4AzWB6fJ9FqEeWTlYUuvZuIeXm73kdf7EJnY8k/j/t4K
         LowPvVgRsRYczbbjXTUpk8shh0Cc5ppdEfmQiteWxiLXNPgEZtX8vKyc3saJGAMmds
         Z1Fjhbx8KUs2ZPb/ELO5WA/SucT5E3vreFWNSHdz602wLaOOWfGb2dEwqR/U8SodHf
         yzfy/KrwZw56g==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v8 09/24] NFS: Don't re-read the entire page cache to find the next cookie
Date:   Fri, 25 Feb 2022 13:28:14 -0500
Message-Id: <20220225182829.1236093-10-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225182829.1236093-9-trondmy@kernel.org>
References: <20220225182829.1236093-1-trondmy@kernel.org>
 <20220225182829.1236093-2-trondmy@kernel.org>
 <20220225182829.1236093-3-trondmy@kernel.org>
 <20220225182829.1236093-4-trondmy@kernel.org>
 <20220225182829.1236093-5-trondmy@kernel.org>
 <20220225182829.1236093-6-trondmy@kernel.org>
 <20220225182829.1236093-7-trondmy@kernel.org>
 <20220225182829.1236093-8-trondmy@kernel.org>
 <20220225182829.1236093-9-trondmy@kernel.org>
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
index 1ce24e255b2b..713028043c6d 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1124,6 +1124,8 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	desc->dup_cookie = dir_ctx->dup_cookie;
 	desc->duped = dir_ctx->duped;
 	page_index = dir_ctx->page_index;
+	desc->page_index = page_index;
+	desc->last_cookie = dir_ctx->last_cookie;
 	desc->attr_gencount = dir_ctx->attr_gencount;
 	desc->eof = dir_ctx->eof;
 	memcpy(desc->verf, dir_ctx->verf, sizeof(desc->verf));
@@ -1172,6 +1174,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	spin_lock(&file->f_lock);
 	dir_ctx->dir_cookie = desc->dir_cookie;
 	dir_ctx->dup_cookie = desc->dup_cookie;
+	dir_ctx->last_cookie = desc->last_cookie;
 	dir_ctx->duped = desc->duped;
 	dir_ctx->attr_gencount = desc->attr_gencount;
 	dir_ctx->page_index = desc->page_index;
@@ -1213,10 +1216,11 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
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

