Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE59134DCE6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhC3ATP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhC3ASp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F2E460295
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063525;
        bh=vVssDi5vxdg/ckVG4mCug4s3T504yxY8NzjKMtj1ElA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FQA5jp98TsaWXcgBt+QKXLjahJu7MEDgI+1uZD9CyO5nLIXrxfENjZpBnRphvRSGV
         GNnTJctwU/11Sxp8yU6Q9+x40QFC5V1vnLmx1EPyKZuaJY7HlOJjsvvWf01XrnxWtc
         IbYSC9tFOwGXZhshsga4JDTBkEWNzhXlEzN8hKx4Mdx+5FP6kLMiaE5HpeuhhY55Q/
         GjtDah1kCy9sjWlhS3+ya0grRwFtVFnBfyGewrC84ZMZZ85DNssiVtbCLkvJCkvKRr
         yVVpzVFx4w89c0lRn/jM7nAaDVUWEK7u+UR3SF1OX+XI5rEqpBnwR1sXgQvNxnCOT0
         D22WGD6hFg7sA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 12/17] NFS: Fix up handling of outstanding layoutcommit in nfs_update_inode()
Date:   Mon, 29 Mar 2021 20:18:30 -0400
Message-Id: <20210330001835.41914-13-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-12-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
 <20210330001835.41914-5-trondmy@kernel.org>
 <20210330001835.41914-6-trondmy@kernel.org>
 <20210330001835.41914-7-trondmy@kernel.org>
 <20210330001835.41914-8-trondmy@kernel.org>
 <20210330001835.41914-9-trondmy@kernel.org>
 <20210330001835.41914-10-trondmy@kernel.org>
 <20210330001835.41914-11-trondmy@kernel.org>
 <20210330001835.41914-12-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If there is an outstanding layoutcommit, then the list of attributes
whose values are expected to change is not the full set. So let's
be explicit about the full list.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index c9386981d210..e57cd490bc4d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1939,7 +1939,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfs_wcc_update_inode(inode, fattr);
 
 	if (pnfs_layoutcommit_outstanding(inode)) {
-		nfsi->cache_validity |= save_cache_validity & NFS_INO_INVALID_ATTR;
+		nfsi->cache_validity |=
+			save_cache_validity &
+			(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+			 NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
+			 NFS_INO_REVAL_FORCED);
 		cache_revalidated = false;
 	}
 
-- 
2.30.2

