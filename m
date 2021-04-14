Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7A535F52A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhDNNof (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351586AbhDNNoR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56E03611CC
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407836;
        bh=lakbWgi8LMZGSSz5LueXhFvQkt6vz8GjyIYagQB0XB8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dIlyvhoOz6K2+5nYbahVhJTu80YAi8Aur2wDJyP/8E1ovr92+0I4cJSpUl00Qmie4
         oL45nyOnmTHrPoGkeUJCszU+SszN19P3PVEmNNgcIosKV64aK9zdB6s1yGQEDbv8jD
         SejJcBZ3ofoDG4y5WT38zS4Q0zq8DQ31hoSi0vI3GnlxGnWEWXVRF4Oqaft8s6TC77
         2G8pySkPzUCom7SOpovbSmfOqO7s4zGgB7Se4o5AvfWNPFsg9easAcJDeEqaRCWikE
         p4WcSYBDgxnMxttI6J4W5H92fo3NPCbuXihP0nKLzMK9AZqCyNRfzuXnbJ6Xu64drk
         y4i3nXb+rcYDQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 03/26] NFS: Mask out unsupported attributes in nfs_getattr()
Date:   Wed, 14 Apr 2021 09:43:30 -0400
Message-Id: <20210414134353.11860-4-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-3-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
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
index 8de5b3b9da91..c429a5375b92 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -815,6 +815,10 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	trace_nfs_getattr_enter(inode);
 
+	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
+			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS;
+
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		nfs_readdirplus_parent_cache_hit(path->dentry);
 		goto out_no_update;
-- 
2.30.2

