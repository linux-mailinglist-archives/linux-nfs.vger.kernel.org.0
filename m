Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB234823E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 20:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhCXTy0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 15:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237988AbhCXTxz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Mar 2021 15:53:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B53FE61A25;
        Wed, 24 Mar 2021 19:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616615635;
        bh=ecFlRpAXfv6ERDufsKh1iuuuyOp8pPZVV3oduTd3dMc=;
        h=From:To:Cc:Subject:Date:From;
        b=mp72TLmIf6+F8KfEvTYw+7sHFBeRt5U2mn6gme6PCVcL+1HOT4Y+uDHFbxRg5L+Mf
         JajdaPbqLhxDxoX8wr72RGqMYKCZyUOWOg5gqj3q9A+IQc7UzwOP6BYgUSA/22bpJV
         wSPy1qcr1/YRcjlfiaOUt5FPW2XfC6SruQI57dNlde7F97ipgaVPePk9xbQn29B6kd
         ZDizlFot8nByuYhtEhjlf7JfV/+a05clq01H/cD3HzNHjg1HKNXeWwtHC28wvVgoja
         Oyq50T5W8LeoLAFaRH2PoUoOYmP6DkgtyN/IWG6RbyY3zjPSrho2T0wImsmhmaUdye
         ZmykpyTjeLxrQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH] NFS: fix nfs_fetch_iversion()
Date:   Wed, 24 Mar 2021 15:53:53 -0400
Message-Id: <20210324195353.577432-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The change attribute is always set by all NFS client versions so get rid
of the open-coded version.

Fixes: 3cc55f4434b4 ("nfs: use change attribute for NFS re-exports")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/export.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index f2b34cfe286c..b347e3ce0cc8 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -171,17 +171,10 @@ static u64 nfs_fetch_iversion(struct inode *inode)
 {
 	struct nfs_server *server = NFS_SERVER(inode);
 
-	/* Is this the right call?: */
-	nfs_revalidate_inode(server, inode);
-	/*
-	 * Also, note we're ignoring any returned error.  That seems to be
-	 * the practice for cache consistency information elsewhere in
-	 * the server, but I'm not sure why.
-	 */
-	if (server->nfs_client->rpc_ops->version >= 4)
-		return inode_peek_iversion_raw(inode);
-	else
-		return time_to_chattr(&inode->i_ctime);
+	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_CHANGE |
+						   NFS_INO_REVAL_PAGECACHE))
+		__nfs_revalidate_inode(server, inode);
+	return inode_peek_iversion_raw(inode);
 }
 
 const struct export_operations nfs_export_ops = {
-- 
2.30.2

