Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C84348234
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237935AbhCXTxW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 15:53:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237898AbhCXTxN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 24 Mar 2021 15:53:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5320C61A1D
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616615593;
        bh=FNGCzus+Rq+gR3KbHmTbx2y7A8siG2J5uwPXx5KAsxk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ddFBSCVkKSw3Fo9OBoCBvfKUfWj85EKc+MnhZ2wrAKGYbL4ZxwbNMlhQ7XHtBTeP9
         q5Ze9GsklKUnt8GZVj72YFN/0KD/gv063hwyMwysL0cipfm0bHk/OL3zVG5EVqXkPD
         /CW5HAUMUP3noSK8Hp5aj5R8ULkyv0VVcnRPDdHzQ7GJ9//5ZcBrDVgh2FtdGOAgOM
         wVuLjbNUjZzFHQxjcY0FfNqz7Cgt74kZ7MzwMRzl0jimHOe1e+dXIPAVfL7yyJaYgi
         H3ztLcMQmrhle/Q+bNOLLjU3HGtYmzuHU9JpaBY8Fhuafx/7uWPTGxjcYF1ZfGOuqn
         I6blEbHziw0CA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Don't revalidate attributes that are not being asked for
Date:   Wed, 24 Mar 2021 15:53:10 -0400
Message-Id: <20210324195311.577373-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210324195311.577373-1-trondmy@kernel.org>
References: <20210324195311.577373-1-trondmy@kernel.org>
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
 fs/nfs/inode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 398f814ff8f8..001a6e4aabfd 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -852,12 +852,20 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
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
+		do_update |= cache_validity &
+			     (NFS_INO_INVALID_CTIME | NFS_INO_REVAL_PAGECACHE);
+	if (request_mask & STATX_MTIME)
+		do_update |= cache_validity &
+			     (NFS_INO_INVALID_MTIME | NFS_INO_REVAL_PAGECACHE);
+	if (request_mask & STATX_SIZE)
+		do_update |= cache_validity &
+			     (NFS_INO_INVALID_SIZE | NFS_INO_REVAL_PAGECACHE);
+	if (request_mask & (STATX_UID | STATX_GID | STATX_MODE | STATX_NLINK))
+		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
 	if (do_update) {
-- 
2.30.2

