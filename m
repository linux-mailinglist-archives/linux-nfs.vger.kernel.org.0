Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C9035F52F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347092AbhDNNog (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351589AbhDNNoT (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A7F33611F0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407837;
        bh=TVBBJuVLaph3mqMkHTUHDQCga93LuyNRMUNB+JcsDRY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZOw/GJ05IAaScxQdMZ7KSeQsy9V9yvWCHsZUw0NzYeZfCBiDSaKc2u+hpOsZ479xz
         UoJW0IFmd4TPP6KjxvMhJBkePUKdpbRZ6G6ZNU50N0WYWNdEMmv/bc7FCasYvU4m5n
         gQr18DmygW9iJStT914L1hGkN511cs4fa7XHExTAS8WLMnqG9KYtVDWiDqXRTZ0sF9
         1MzGyu4kUkBcf0pZqzHvC0DiSwrqQh9PgHLhLutVYd+ovr4dfwvO6tcKL4jmZiK58d
         ZUrJmiLH8E+6byOEzLViWuWOSsvQDDDnAW14Lxff80aPkR1aBBcfG2zsmR89jbSYOP
         4E2wyxrlsBySw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 06/26] NFS: Don't revalidate attributes that are not being asked for
Date:   Wed, 14 Apr 2021 09:43:33 -0400
Message-Id: <20210414134353.11860-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-6-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
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
index 8b2f4a5eaa42..4982bc18ee26 100644
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

