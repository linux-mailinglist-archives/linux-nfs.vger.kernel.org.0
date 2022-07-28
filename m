Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148C7584108
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Jul 2022 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiG1OYN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 Jul 2022 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiG1OYM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 Jul 2022 10:24:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F865679
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 07:24:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 303C8B82483
        for <linux-nfs@vger.kernel.org>; Thu, 28 Jul 2022 14:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB31C433C1;
        Thu, 28 Jul 2022 14:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659018248;
        bh=DMqJPYyKbkY+oxzus1MnyYlhu5NqZim4Kn2OsLjfWdA=;
        h=From:To:Cc:Subject:Date:From;
        b=E1QJ8ubqBiM7msbMajba1+7EV8Oyoj2/YCQqXx/sjn3WBA6WNPzkKBkSua8Z543SC
         hN6rncdE2o4h4AbA4Q0z/KsRJJK69Z/MtXiOmuXlq2QXafaUWenaA1szZigDQCknEX
         cEY6OifV9/xEqkjYejKiqjEWyOLKUb+WOYRIhSaHHgvbbIaODFG8sL9ai62VUjYdTw
         htS1tEE8WB6jDMrn7zxHSH/LiIuEfJGbY7YTNUlWDXnJYDlJzwuWfn+ZOP93HPU+eH
         TSUdJgYNHf7fQ8x5lExgzI/6btEgzE9quROXdM0JVngnSvXxbnO3wurDUL9hTv5BJJ
         NNrpTg211NE3Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, Scott Mayhew <smayhew@redhat.com>,
        Ben Coddington <bcodding@redhat.com>,
        Olga Kornieskaia <kolga@netapp.com>
Subject: [RFC PATCH] nfs: don't skip CTO on v2/3 mounts, regardless of order of reference puts
Date:   Thu, 28 Jul 2022 10:24:06 -0400
Message-Id: <20220728142406.91832-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Olga reported a case of data corruption in a situation where two clients
(v3 and v4) were alternately doing open/write/close the same file.

Looking at captures, the v3 client failed to perform any of the GETATTR
calls for CTO during one of the events, leading it to overwrite some
data that had been written by the v4 client.

We have two calls that work similarly: put_nfs_open_context and
put_nfs_open_context_sync. The only difference is the is_sync parameter
that gets passed to close_context. The only caller of the _sync variant
is in the close codepath.

On a v2/3 mount, if the last reference is not put by
put_nfs_open_context_sync, then CTO revalidation never happens. Fix this
by adding a new flag to nfs_open_context and set that in
put_nfs_open_context_sync. In nfs_close_context, check for that flag
when we're checking is_sync and treat them as equivalent.

Cc: Scott Mayhew <smayhew@redhat.com>
Cc: Ben Coddington <bcodding@redhat.com>
Reported-by: Olga Kornieskaia <kolga@netapp.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfs/inode.c         | 3 ++-
 include/linux/nfs_fs.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

I'm not sure this is the right fix. Maybe we'd be better off just
ignoring the is_sync parameter in nfs_close_context? It's probably
functionally equivalent anyway.

Thoughts?

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b4e46b0ffa2d..58b506a0a2f2 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1005,7 +1005,7 @@ void nfs_close_context(struct nfs_open_context *ctx, int is_sync)
 
 	if (!(ctx->mode & FMODE_WRITE))
 		return;
-	if (!is_sync)
+	if (!is_sync && !test_bit(NFS_CONTEXT_DO_CLOSE, &ctx->flags))
 		return;
 	inode = d_inode(ctx->dentry);
 	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
@@ -1091,6 +1091,7 @@ EXPORT_SYMBOL_GPL(put_nfs_open_context);
 
 static void put_nfs_open_context_sync(struct nfs_open_context *ctx)
 {
+	set_bit(NFS_CONTEXT_DO_CLOSE, &ctx->flags);
 	__put_nfs_open_context(ctx, 1);
 }
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index a17c337dbdf1..faff0d60aad2 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -85,8 +85,9 @@ struct nfs_open_context {
 	unsigned long flags;
 #define NFS_CONTEXT_RESEND_WRITES	(1)
 #define NFS_CONTEXT_BAD			(2)
-#define NFS_CONTEXT_UNLOCK	(3)
+#define NFS_CONTEXT_UNLOCK		(3)
 #define NFS_CONTEXT_FILE_OPEN		(4)
+#define NFS_CONTEXT_DO_CLOSE		(5)
 	int error;
 
 	struct list_head list;
-- 
2.37.1

