Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922DF38B46F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 18:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhETQk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 12:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233284AbhETQk1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 12:40:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0B9F61059
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 16:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528745;
        bh=GsFHXztCfvoUUwNbVgk4zQ/rMt8XD+/wAKn8hW/C/UQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OGUvs+iNXXsBylH23qaqZocStjjGiCBAXDhtB2twIf1Nu/25ABJG1PRFljmMjXe1R
         dm85WIFuQEAlZF1VHAI9EfurFnaMUCmsoIzQrVNW2++kAgPrfjKGKIzyc1umgxPD3O
         GfvKwvesJDQ1+iAsBxcQynC6rrGZy3EWt6wz9CSpo7AmAj7imU+w8dKWXfvXuDmp+k
         VTB/iCtapaXjJ7xHeX0ARlm6NwMD7ZzVScpLWOKyETnaDghk5J+tjF+fdSWA5765Vj
         fiNEvT5Yc8eE+wyTypbcXM83pC6DvGFNbaJQjm6cUToMHJDmb1phgNTBSb3od673hj
         8/l9mVXU4QFjw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFS: nfs_find_open_context() may only select open files
Date:   Thu, 20 May 2021 12:39:02 -0400
Message-Id: <20210520163902.215745-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520163902.215745-4-trondmy@kernel.org>
References: <20210520163902.215745-1-trondmy@kernel.org>
 <20210520163902.215745-2-trondmy@kernel.org>
 <20210520163902.215745-3-trondmy@kernel.org>
 <20210520163902.215745-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If a file has already been closed, then it should not be selected to
support further I/O.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c         | 4 ++++
 include/linux/nfs_fs.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 529c4099f482..5ccc6b258ca5 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1101,6 +1101,7 @@ EXPORT_SYMBOL_GPL(nfs_inode_attach_open_context);
 void nfs_file_set_open_context(struct file *filp, struct nfs_open_context *ctx)
 {
 	filp->private_data = get_nfs_open_context(ctx);
+	set_bit(NFS_CONTEXT_FILE_OPEN, &ctx->flags);
 	if (list_empty(&ctx->list))
 		nfs_inode_attach_open_context(ctx);
 }
@@ -1120,6 +1121,8 @@ struct nfs_open_context *nfs_find_open_context(struct inode *inode, const struct
 			continue;
 		if ((pos->mode & (FMODE_READ|FMODE_WRITE)) != mode)
 			continue;
+		if (!test_bit(NFS_CONTEXT_FILE_OPEN, &ctx->flags))
+			continue;
 		ctx = get_nfs_open_context(pos);
 		if (ctx)
 			break;
@@ -1135,6 +1138,7 @@ void nfs_file_clear_open_context(struct file *filp)
 	if (ctx) {
 		struct inode *inode = d_inode(ctx->dentry);
 
+		clear_bit(NFS_CONTEXT_FILE_OPEN, &ctx->flags);
 		/*
 		 * We fatal error on write before. Try to writeback
 		 * every page again.
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index ffba254d2098..ce6474594872 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -84,6 +84,7 @@ struct nfs_open_context {
 #define NFS_CONTEXT_RESEND_WRITES	(1)
 #define NFS_CONTEXT_BAD			(2)
 #define NFS_CONTEXT_UNLOCK	(3)
+#define NFS_CONTEXT_FILE_OPEN		(4)
 	int error;
 
 	struct list_head list;
-- 
2.31.1

