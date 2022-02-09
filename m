Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAB04AF9FA
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 19:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiBISdV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 13:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiBISdR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 13:33:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8B3C05CB82
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 10:33:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1948061B54
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA99C340E9
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644431599;
        bh=LT3oiE2s5w2MuFuDkkyDXRTGEM63nKhWEzYxuFdHwzU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Hr2fsOPqOY9QwudFfJQHdJDc2H+S17EU30/Z+aAXlOXDIVdvUMfrc7CPSm7xtVw38
         BNzKkBj3RlVup0OH6WWt6a9C1UgT3ptl4WAnAWTgNvLos4K90B1gri/RxTRBQw4Kj2
         +UvucqrspzZwjlvzXF88pbSbJB/YwH8obZqofZ2NhXTO+L+ad3QmEJYfGjKXIl2ao+
         jiSVLeAgFHGZV+7WF2tJwtbc1WoguTWentJNVTqpRFfuYqOBL135e9zDJRQ7s/Fj6X
         jfryjSTVKC9gLJMfdQic55At7FIj2aPu3YzauWbz+5LWiYhhxr00O3WNg7z9TeFH44
         Q67/XODZb8dVg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] NFS: Remove unused flag NFS_INO_REVAL_PAGECACHE
Date:   Wed,  9 Feb 2022 13:27:12 -0500
Message-Id: <20220209182712.23306-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220209182712.23306-1-trondmy@kernel.org>
References: <20220209182712.23306-1-trondmy@kernel.org>
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

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c         | 5 ++---
 fs/nfs/nfstrace.h      | 1 -
 include/linux/nfs_fs.h | 1 -
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 5eab46e9cbc0..90432fc389a0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -203,14 +203,13 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 				   NFS_INO_INVALID_OTHER |
 				   NFS_INO_INVALID_XATTR);
 		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
-	} else if (flags & NFS_INO_REVAL_PAGECACHE)
-		flags |= NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
+	}
 
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
 	if (flags & NFS_INO_INVALID_DATA)
 		nfs_fscache_invalidate(inode, 0);
-	flags &= ~(NFS_INO_REVAL_PAGECACHE | NFS_INO_REVAL_FORCED);
+	flags &= ~NFS_INO_REVAL_FORCED;
 
 	nfsi->cache_validity |= flags;
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4611aa3a21a4..45a310b586ce 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -21,7 +21,6 @@
 			{ NFS_INO_INVALID_ATIME, "INVALID_ATIME" }, \
 			{ NFS_INO_INVALID_ACCESS, "INVALID_ACCESS" }, \
 			{ NFS_INO_INVALID_ACL, "INVALID_ACL" }, \
-			{ NFS_INO_REVAL_PAGECACHE, "REVAL_PAGECACHE" }, \
 			{ NFS_INO_REVAL_FORCED, "REVAL_FORCED" }, \
 			{ NFS_INO_INVALID_LABEL, "INVALID_LABEL" }, \
 			{ NFS_INO_INVALID_CHANGE, "INVALID_CHANGE" }, \
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index afb66281afd5..98120f2d7e0b 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -248,7 +248,6 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_ATIME	BIT(2)		/* cached atime is invalid */
 #define NFS_INO_INVALID_ACCESS	BIT(3)		/* cached access cred invalid */
 #define NFS_INO_INVALID_ACL	BIT(4)		/* cached acls are invalid */
-#define NFS_INO_REVAL_PAGECACHE	BIT(5)		/* must revalidate pagecache */
 #define NFS_INO_REVAL_FORCED	BIT(6)		/* force revalidation ignoring a delegation */
 #define NFS_INO_INVALID_LABEL	BIT(7)		/* cached label is invalid */
 #define NFS_INO_INVALID_CHANGE	BIT(8)		/* cached change is invalid */
-- 
2.34.1

