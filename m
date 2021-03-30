Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 259D834DCDD
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhC3ATL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229750AbhC3ASk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AE7F61990
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063520;
        bh=uXmtav0HD1YHoLdGD1OavpObIiaLKCCy08ovhHhtnaY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=H2N8PnowH+GYZEwjyU2YZyjTbvb6s1wXQvxpwV/cW0sVNNsVJHLGUKgJp623DqzDy
         jl+rQzil+e8E3Jt2iNtAo3m2Bb/sN/54/N00AVwTnMnK4HK5HV/BrwacFOYHHSTOix
         wuH8M4LttdCyI0SmKs0cfnWdqZdHX4vElGAlvgu5vD+6eZrU0/m5hcP7fLL9/3YlM5
         LqfExp+q7ZIPRHcvpoy6sLDGygp40Mu5ybsf74XM5aMKGTC3FWlmoiiedmaPHRQ8yH
         yuK7QCu7A65zgtorGX2WjiWybMJi7WCyTf2LlRwGkO77x+ODVgAl3cstl9ZWVcG8Ys
         4BLZHN16JIc6A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/17] NFS: NFS_INO_REVAL_PAGECACHE should mark the change attribute invalid
Date:   Mon, 29 Mar 2021 20:18:22 -0400
Message-Id: <20210330001835.41914-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-4-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we're looking to revalidate the page cache, we should just ensure
that we mark the change attribute invalid.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 93f487c15663..f0c983151f3c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -219,7 +219,8 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 				| NFS_INO_INVALID_SIZE
 				| NFS_INO_REVAL_PAGECACHE
 				| NFS_INO_INVALID_XATTR);
-	}
+	} else if (flags & NFS_INO_REVAL_PAGECACHE)
+		flags |= NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE;
 
 	if (!nfs_has_xattr_cache(nfsi))
 		flags &= ~NFS_INO_INVALID_XATTR;
-- 
2.30.2

