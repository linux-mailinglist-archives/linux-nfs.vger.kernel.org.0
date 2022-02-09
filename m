Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BEF4AF9F9
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiBISdS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 13:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiBISdR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 13:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17492C0613C9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 10:33:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A69B961B7F
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67DDC340E7
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644431599;
        bh=I1c94OKssf61miANbbpys7mGxAspozv+fqccX6h8z0k=;
        h=From:To:Subject:Date:From;
        b=Amv4okRu3DGql737pRuNh1H584pCzHlevIDrNdNnYg4uVD37/FSx8SneptV+2rryi
         tsfESLJI5q8I+pP4uaIzvfMqZawxEQmJxhjX1WnPnzXUla9gcJcec5F5nwgxHJZgvJ
         IDvaRJ6y54jVE8+QsAYCfeHedBCW7SMId0P96L+81TiFyb3QmvXnR5dVzyLiz1Lsg+
         vEqJ7/kFEdzKFSP9IQDRQu+znt0kbAtPXD0YWaBZZ6PHpF5mJi2M5PYO6BXJ4/G7Nh
         y8gSoC8lfRvkw6AjbhObPOD0sm6GPhJh8rpTTH7XnEoOClJcdJ8bvnMwEh0nkB6JKy
         Z9gOiJ7w1fdrw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] NFS: Replace last uses of NFS_INO_REVAL_PAGECACHE
Date:   Wed,  9 Feb 2022 13:27:11 -0500
Message-Id: <20220209182712.23306-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Now that we have more fine grained attribute revalidation, let's just
get rid of NFS_INO_REVAL_PAGECACHE.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c         | 24 +++++++++++-------------
 fs/nfs/write.c         |  2 +-
 include/linux/nfs_fs.h |  8 +++-----
 3 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index dce96289e474..5eab46e9cbc0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -236,19 +236,17 @@ static void nfs_zap_caches_locked(struct inode *inode)
 	nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	nfsi->attrtimeo_timestamp = jiffies;
 
-	if (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode)) {
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATTR
-					| NFS_INO_INVALID_DATA
-					| NFS_INO_INVALID_ACCESS
-					| NFS_INO_INVALID_ACL
-					| NFS_INO_INVALID_XATTR
-					| NFS_INO_REVAL_PAGECACHE);
-	} else
-		nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATTR
-					| NFS_INO_INVALID_ACCESS
-					| NFS_INO_INVALID_ACL
-					| NFS_INO_INVALID_XATTR
-					| NFS_INO_REVAL_PAGECACHE);
+	if (S_ISREG(mode) || S_ISDIR(mode) || S_ISLNK(mode))
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATTR |
+						     NFS_INO_INVALID_DATA |
+						     NFS_INO_INVALID_ACCESS |
+						     NFS_INO_INVALID_ACL |
+						     NFS_INO_INVALID_XATTR);
+	else
+		nfs_set_cache_invalid(inode, NFS_INO_INVALID_ATTR |
+						     NFS_INO_INVALID_ACCESS |
+						     NFS_INO_INVALID_ACL |
+						     NFS_INO_INVALID_XATTR);
 	nfs_zap_label_cache_locked(nfsi);
 }
 
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 987a187bd39a..f88b0eb9b18e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -306,7 +306,7 @@ static void nfs_set_pageerror(struct address_space *mapping)
 	/* Force file size revalidation */
 	spin_lock(&inode->i_lock);
 	nfs_set_cache_invalid(inode, NFS_INO_REVAL_FORCED |
-					     NFS_INO_REVAL_PAGECACHE |
+					     NFS_INO_INVALID_CHANGE |
 					     NFS_INO_INVALID_SIZE);
 	spin_unlock(&inode->i_lock);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 0842364ab784..afb66281afd5 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -357,11 +357,9 @@ static inline void nfs_mark_for_revalidate(struct inode *inode)
 	struct nfs_inode *nfsi = NFS_I(inode);
 
 	spin_lock(&inode->i_lock);
-	nfsi->cache_validity |= NFS_INO_REVAL_PAGECACHE
-		| NFS_INO_INVALID_ACCESS
-		| NFS_INO_INVALID_ACL
-		| NFS_INO_INVALID_CHANGE
-		| NFS_INO_INVALID_CTIME;
+	nfsi->cache_validity |= NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
+				NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+				NFS_INO_INVALID_SIZE;
 	if (S_ISDIR(inode->i_mode))
 		nfsi->cache_validity |= NFS_INO_INVALID_DATA;
 	spin_unlock(&inode->i_lock);
-- 
2.34.1

