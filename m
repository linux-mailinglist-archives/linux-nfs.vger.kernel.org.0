Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCF33D4F5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Mar 2021 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhCPNgg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 Mar 2021 09:36:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhCPNgE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 16 Mar 2021 09:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4033664DD8;
        Tue, 16 Mar 2021 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615901764;
        bh=ogyyCh0M8xPcsZQ8I9C8rpbT7OsRqpdL8QMy7aDnaoM=;
        h=From:To:Cc:Subject:Date:From;
        b=Oey/2xkD/h5nqeDC2pvfbXdSEKTtTB4FN2TW4f6DKX6zZY+bJyIoHk+rIT1SwHLuH
         NobN1wLMlNWoXzivQK9cebjg8q0fpHEcS3hrMBOfZ+u43Pp3mkfBt9I1bWXA1ORxr0
         lH2CORtbFZY6/jNKo5FBwbZiFZK/RQW6AI1zZls/6kH/euewPATIXx1CcquCRsR3fQ
         OUKcbmBKhM34/CrFFAgdr/MmrQQurqdUZs2S7CBWGX1n8fJKCXIVBL2odUBZtdV6g7
         nkFdZAb5UpnabBog8LAwf5jmnsBwzzimRGMmdEI/5m1HN0Ip3K/zHN56dNBVQ1+5c0
         ysRAqEbT/hrNQ==
From:   trondmy@kernel.org
To:     Nagendra S Tomar <natomar@microsoft.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: Fix handling of cookie verifier in uncached_readdir()
Date:   Tue, 16 Mar 2021 09:36:03 -0400
Message-Id: <20210316133603.1228154-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If we're doing uncached readdir(), then the readdir cookie could be
different from the one cached in the nfs_inode. We should therefore
ensure that we save that one in the struct nfs_open_dir_context.

Fixes: 35df59d3ef69 ("NFS: Reduce number of RPC calls when doing uncached readdir")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 08a1e2e31d0b..2cf2a7d92faf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -976,10 +976,10 @@ static int readdir_search_pagecache(struct nfs_readdir_descriptor *desc)
 /*
  * Once we've found the start of the dirent within a page: fill 'er up...
  */
-static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
+static void nfs_do_filldir(struct nfs_readdir_descriptor *desc,
+			   const __be32 *verf)
 {
 	struct file	*file = desc->file;
-	struct nfs_inode *nfsi = NFS_I(file_inode(file));
 	struct nfs_cache_array *array;
 	unsigned int i = 0;
 
@@ -993,7 +993,7 @@ static void nfs_do_filldir(struct nfs_readdir_descriptor *desc)
 			desc->eof = true;
 			break;
 		}
-		memcpy(desc->verf, nfsi->cookieverf, sizeof(desc->verf));
+		memcpy(desc->verf, verf, sizeof(desc->verf));
 		if (i < (array->size-1))
 			desc->dir_cookie = array->array[i+1].cookie;
 		else
@@ -1050,7 +1050,7 @@ static int uncached_readdir(struct nfs_readdir_descriptor *desc)
 
 	for (i = 0; !desc->eof && i < sz && arrays[i]; i++) {
 		desc->page = arrays[i];
-		nfs_do_filldir(desc);
+		nfs_do_filldir(desc, verf);
 	}
 	desc->page = NULL;
 
@@ -1071,6 +1071,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct dentry	*dentry = file_dentry(file);
 	struct inode	*inode = d_inode(dentry);
+	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_open_dir_context *dir_ctx = file->private_data;
 	struct nfs_readdir_descriptor *desc;
 	int res;
@@ -1124,7 +1125,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		}
 		if (res == -ETOOSMALL && desc->plus) {
-			clear_bit(NFS_INO_ADVISE_RDPLUS, &NFS_I(inode)->flags);
+			clear_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
 			nfs_zap_caches(inode);
 			desc->page_index = 0;
 			desc->plus = false;
@@ -1134,7 +1135,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 		if (res < 0)
 			break;
 
-		nfs_do_filldir(desc);
+		nfs_do_filldir(desc, nfsi->cookieverf);
 		nfs_readdir_page_unlock_and_put_cached(desc);
 	} while (!desc->eof);
 
-- 
2.30.2

