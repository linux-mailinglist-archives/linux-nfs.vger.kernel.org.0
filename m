Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E92F34DCDF
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhC3ATM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC3ASk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 935A661996
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063519;
        bh=sKgXKWMaferrfB6lSm0CMcZnwhLSUOM7E2zrhQfQOmY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MxwYrWFGb6KczU6raDG3S/HaPz7p4GJ/FTeBtVECVLI9wIvaf+pZx3OwglcbBs6jC
         ulugLQB1b9DkERcBs6NMYa8zXejKJydp+kszZ4bW7k+3Yxjrjv54QFIUzhEqIqSAu6
         XFRD5R5F9c1tcT70IorbuFnKNwVWK5NANBj9gntx+C6ZUiZj3ZKvCpud+FwIuXZ+pg
         c7AMgGwNWccWeIIh9whY+h1OYY+NPIyGc4ClfvQfYE6kj+hnhe+IuhDZC9ara35Afs
         gGbVLVSsm8w8EVAPQf00oOsopVHxBKBweZR5PvC9djOSghINSsoEBn4VNJvXfwzhHo
         Qp6cGln/5VC2Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/17] NFS: Mask out unsupported attributes in nfs_getattr()
Date:   Mon, 29 Mar 2021 20:18:21 -0400
Message-Id: <20210330001835.41914-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330001835.41914-3-trondmy@kernel.org>
References: <20210330001835.41914-1-trondmy@kernel.org>
 <20210330001835.41914-2-trondmy@kernel.org>
 <20210330001835.41914-3-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We don't currently support STATX_BTIME, so don't advertise it in the
return values for nfs_getattr().

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8de5b3b9da91..93f487c15663 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -815,6 +815,10 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	trace_nfs_getattr_enter(inode);
 
+	request_mask &= ~(STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
+			  STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
+			  STATX_INO | STATX_SIZE | STATX_BLOCKS);
+
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		nfs_readdirplus_parent_cache_hit(path->dentry);
 		goto out_no_update;
-- 
2.30.2

