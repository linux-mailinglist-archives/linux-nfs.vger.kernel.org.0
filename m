Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D5834DCE5
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhC3ATN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhC3ASo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B346192F
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063522;
        bh=fR9gaySojGjKUIgSpbAC5NqSIhTOudtIW2k4bOTQ4Y4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VYaiQNyF+xio92GJl/zaT/cMM30gHUBN5Cjnbvc7lWUa5oL576I3WVql9ZkO3mxpf
         X2Zt/W6ZRSnwEB9LF/KrU6dPh66N+NU+gH890X431mSaPj2xwEEoqZXRiOT5H1F6h0
         zQjwyMQc4NEJsTdGXUm7aPLpVfIQ4zWDZPc2ecTppRHh9f4ERYcp445c8vPomThLTs
         OiLJ/IYyzkmWB0ziCwRYkPCJ3jRB4PILgvf/Xx6F3vhvncoNmgrdb1avsiNwbHgweQ
         KE/sLrWJod92wfYq5Zf1e9ywLA/JfdnJWpeq70W482TwLKKf8kkDTwkoUh1UONKDSS
         547S6z0WSrqXg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 06/17] NFS: Don't revalidate attributes that are not being asked for
Date:   Mon, 29 Mar 2021 20:18:24 -0400
Message-Id: <20210330001835.41914-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-6-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
 <20210330001835.41914-4-trondmy@kernel.org>
 <20210330001835.41914-5-trondmy@kernel.org>
 <20210330001835.41914-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the user doesn't set STATX_UID/GID/MODE, then don't care if they are
known to be stale. Ditto if we're not being asked for the file size.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 138d0998fd91..5280f28a67a7 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -857,12 +857,17 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 	/* Check whether the cached attributes are stale */
 	do_update |= force_sync || nfs_attribute_cache_expired(inode);
 	cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
-	do_update |= cache_validity &
-		(NFS_INO_INVALID_ATTR|NFS_INO_INVALID_LABEL);
+	do_update |= cache_validity & NFS_INO_INVALID_CHANGE;
 	if (request_mask & STATX_ATIME)
 		do_update |= cache_validity & NFS_INO_INVALID_ATIME;
-	if (request_mask & (STATX_CTIME|STATX_MTIME))
-		do_update |= cache_validity & NFS_INO_REVAL_PAGECACHE;
+	if (request_mask & STATX_CTIME)
+		do_update |= cache_validity & NFS_INO_INVALID_CTIME;
+	if (request_mask & STATX_MTIME)
+		do_update |= cache_validity & NFS_INO_INVALID_MTIME;
+	if (request_mask & STATX_SIZE)
+		do_update |= cache_validity & NFS_INO_INVALID_SIZE;
+	if (request_mask & (STATX_UID | STATX_GID | STATX_MODE | STATX_NLINK))
+		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
 	if (do_update) {
-- 
2.30.2

