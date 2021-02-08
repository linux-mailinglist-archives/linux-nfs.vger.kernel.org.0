Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6791313409
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Feb 2021 14:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBHN4s (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Feb 2021 08:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:36832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231633AbhBHN4b (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 8 Feb 2021 08:56:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E6DA264E54;
        Mon,  8 Feb 2021 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612792549;
        bh=VOJhhzPT4zqVkVRP+sH27VNH/uNeD0GbS0Uy5Qxih4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=jfJid8xw/+s4niWoiPG11ffyrRMxHHG4G8pMdroPmNXQrYOtc9xAZBGtEiSnbdUa7
         u4PHfJ2d5hB5tTwyebzP62+HEkHE8t/PQxrA/ix1pCpOA++Co0CxKqE71MGS1AdNhL
         F6JxuLFG6tZj8MYBr+imCK+UbqN5yo+e9ceSTCpqNt1ZkmD2I2WBqRMhi9Zp2VG6hn
         2UJj5iqda0BzgOdpgGGWd20Lz5+t8bwW+3rzBShhWjvGrZk+Ujwcl0F5P7SmDEolaF
         7q7kAYpJ0yQ9cietc7DesPwwj0Y3HrV1nt1EAbrdfUQHrCOEbydTVT9G2zCqSia+Qo
         4cGksd4L2JjDA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFS: Fix documenting comment for nfs_revalidate_file_size()
Date:   Mon,  8 Feb 2021 08:55:45 -0500
Message-Id: <20210208135547.27153-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 63940a7a70be..d02a63af9c15 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -89,7 +89,7 @@ nfs_file_release(struct inode *inode, struct file *filp)
 EXPORT_SYMBOL_GPL(nfs_file_release);
 
 /**
- * nfs_revalidate_size - Revalidate the file size
+ * nfs_revalidate_file_size - Revalidate the file size
  * @inode: pointer to inode struct
  * @filp: pointer to struct file
  *
-- 
2.29.2

