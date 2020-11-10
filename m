Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064C52AE203
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Nov 2020 22:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgKJVrx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 16:47:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgKJVrx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 16:47:53 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF9FB20797
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605044873;
        bh=ScIdmztlvC5lGaF8OhAEJdAQTYeDvTVf/YgYH6yqrBA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PD6O4DyB7NG8nw7jOm/lUimqHclo4QeR9QNSYCb69k/fI6Z2n4W8Weoce+tRyUJK2
         WXMZX+3JNrZZnwzdbPuaMEgEG2jh4cG9ZxWX28uhhIJ8JaTzT4B2spDN9pmSMjxJGG
         WhYd82A9dOBufFiR7OaRwHqFq4wW3gU0l58Gu9Ys=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v5 01/22] NFS: Remove unnecessary inode locking in nfs_llseek_dir()
Date:   Tue, 10 Nov 2020 16:37:20 -0500
Message-Id: <20201110213741.860745-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110213741.860745-1-trondmy@kernel.org>
References: <20201110213741.860745-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Remove the contentious inode lock, and instead provide thread safety
using the file->f_lock spinlock.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cb52db9a0cfb..e56b1bd99537 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -955,7 +955,6 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 
 static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 {
-	struct inode *inode = file_inode(filp);
 	struct nfs_open_dir_context *dir_ctx = filp->private_data;
 
 	dfprintk(FILE, "NFS: llseek dir(%pD2, %lld, %d)\n",
@@ -967,15 +966,15 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 	case SEEK_SET:
 		if (offset < 0)
 			return -EINVAL;
-		inode_lock(inode);
+		spin_lock(&filp->f_lock);
 		break;
 	case SEEK_CUR:
 		if (offset == 0)
 			return filp->f_pos;
-		inode_lock(inode);
+		spin_lock(&filp->f_lock);
 		offset += filp->f_pos;
 		if (offset < 0) {
-			inode_unlock(inode);
+			spin_unlock(&filp->f_lock);
 			return -EINVAL;
 		}
 	}
@@ -987,7 +986,7 @@ static loff_t nfs_llseek_dir(struct file *filp, loff_t offset, int whence)
 			dir_ctx->dir_cookie = 0;
 		dir_ctx->duped = 0;
 	}
-	inode_unlock(inode);
+	spin_unlock(&filp->f_lock);
 	return offset;
 }
 
-- 
2.28.0

