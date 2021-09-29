Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABAD41C60C
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Sep 2021 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344314AbhI2Nv1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Sep 2021 09:51:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344273AbhI2Nv0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 Sep 2021 09:51:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9891613A9
        for <linux-nfs@vger.kernel.org>; Wed, 29 Sep 2021 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632923385;
        bh=jEJG5fJNarbSEkt+raE0Nj5Yif+ZxMIBuFhYajUUpnk=;
        h=From:To:Subject:Date:From;
        b=RHB85BWupXOqEQIInD5kQHYKqy0UfCW0Y5qxgP9QsSqIwzGvXSOopO1p2YdpKMfhJ
         3SRg4yWG7SPOgnRlpCW1FaQFKg+hJMzRvX3cHVo24X5mciP1WsGp8s869navcDCzgk
         yDMt3oaktZyFDLkiLvH7pAbKSadyyeJQtmHr9L+cgoeq/4bhK2YL9liOdVX3A9Hh1y
         TaGBZLWtWvRxSwKsbOcpD9qiUeqjYA/pBxEZ0bU3JxxNXv7fcyYB7fdGu9BD7VLN6k
         rzS5SxaWJtnlWHI80HyAo6SrPFa3C31/qaK9X7cxUNlgQKmkhuk/PyV9+mDTY3Ilx/
         qwxsm88H7yvaA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] NFS: Don't set NFS_INO_DATA_INVAL_DEFER and NFS_INO_INVALID_DATA
Date:   Wed, 29 Sep 2021 09:49:40 -0400
Message-Id: <20210929134944.632844-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

NFS_INO_DATA_INVAL_DEFER and NFS_INO_INVALID_DATA should be considered
mutually exclusive.

Fixes: 1c341b777501 ("NFS: Add deferred cache invalidation for close-to-open consistency violations")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0f092ccb0ca1..dcb885b7ad73 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -210,10 +210,15 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode);
-	if (inode->i_mapping->nrpages == 0)
-		flags &= ~(NFS_INO_INVALID_DATA|NFS_INO_DATA_INVAL_DEFER);
 	flags &= ~(NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED);
+
 	nfsi->cache_validity |= flags;
+
+	if (inode->i_mapping->nrpages == 0)
+		nfsi->cache_validity &= ~(NFS_INO_INVALID_DATA |
+					  NFS_INO_DATA_INVAL_DEFER);
+	else if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
+		nfsi->cache_validity &= ~NFS_INO_DATA_INVAL_DEFER;
 }
 EXPORT_SYMBOL_GPL(nfs_set_cache_invalid);
 
-- 
2.31.1

