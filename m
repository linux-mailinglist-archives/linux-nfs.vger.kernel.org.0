Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6723935F531
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347581AbhDNNoh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:52164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351595AbhDNNoV (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDCE6121E
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407839;
        bh=sDu3zp5CaotO32H5p0ITE4eA68qZnwL422YCxMr8c0M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=iMJznVxvLRcR6bzBGsxB8vnYIomRye0l8GGBk7V1K/A7hD5q/k8zTf4ty0b+ZHze2
         oMQu36X8eAyErm8c6LMmCmBCVxi2UB3UBW9HXuGL+WfZ4/VoflBHojNBvZKtEN5INT
         Fhg/kXXki6GFdqFCf0RPWRl74putcOgqTk8yboUTrvCSp157p22T3zu/ssGdOwacPq
         6N/QHsptYHdoW/Cxdirmw9IO2BQW8b7v3YAX5vmcBThkPZxmUbQljvWpKqYW8GGuo0
         1ffhXDNJ1ELfPYkuDBRA9mOAWAdmyCzlti+j/VV4HgQf8wcXl2eHBci2r4BNcDk0rY
         Qvqhhty1BUVHg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 10/26] NFS: Replace use of NFS_INO_REVAL_PAGECACHE when checking cache validity
Date:   Wed, 14 Apr 2021 09:43:37 -0400
Message-Id: <20210414134353.11860-11-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-10-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When checking cache validity, be more specific than just 'we want to
check the page cache validity'. In almost all cases, we want to check
that change attribute, and possibly also the size.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c     |  2 +-
 fs/nfs/inode.c    | 41 ++++++++++++-----------------------------
 fs/nfs/nfs4proc.c |  5 ++---
 fs/nfs/write.c    |  2 +-
 4 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 16ad5050e046..1fef107961bc 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -105,7 +105,7 @@ static int nfs_revalidate_file_size(struct inode *inode, struct file *filp)
 
 	if (filp->f_flags & O_DIRECT)
 		goto force_reval;
-	if (nfs_check_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE))
+	if (nfs_check_cache_invalid(inode, NFS_INO_INVALID_SIZE))
 		goto force_reval;
 	return 0;
 force_reval:
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index b9aac408f03a..aec402d048eb 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -164,34 +164,19 @@ static int nfs_attribute_timeout(struct inode *inode)
 	return !time_in_range_open(jiffies, nfsi->read_cache_jiffies, nfsi->read_cache_jiffies + nfsi->attrtimeo);
 }
 
-static bool nfs_check_cache_invalid_delegated(struct inode *inode, unsigned long flags)
+static bool nfs_check_cache_flags_invalid(struct inode *inode,
+					  unsigned long flags)
 {
 	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
 
-	/* Special case for the pagecache or access cache */
-	if (flags == NFS_INO_REVAL_PAGECACHE &&
-	    !(cache_validity & NFS_INO_REVAL_FORCED))
-		return false;
 	return (cache_validity & flags) != 0;
 }
 
-static bool nfs_check_cache_invalid_not_delegated(struct inode *inode, unsigned long flags)
-{
-	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
-
-	if ((cache_validity & flags) != 0)
-		return true;
-	if (nfs_attribute_timeout(inode))
-		return true;
-	return false;
-}
-
 bool nfs_check_cache_invalid(struct inode *inode, unsigned long flags)
 {
-	if (NFS_PROTO(inode)->have_delegation(inode, FMODE_READ))
-		return nfs_check_cache_invalid_delegated(inode, flags);
-
-	return nfs_check_cache_invalid_not_delegated(inode, flags);
+	if (nfs_check_cache_flags_invalid(inode, flags))
+		return true;
+	return nfs_attribute_cache_expired(inode);
 }
 EXPORT_SYMBOL_GPL(nfs_check_cache_invalid);
 
@@ -809,14 +794,12 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 
 	if (!(cache_validity & NFS_INO_INVALID_ATIME))
 		reply_mask |= STATX_ATIME;
-	if (!(cache_validity & NFS_INO_REVAL_PAGECACHE)) {
-		if (!(cache_validity & NFS_INO_INVALID_CTIME))
-			reply_mask |= STATX_CTIME;
-		if (!(cache_validity & NFS_INO_INVALID_MTIME))
-			reply_mask |= STATX_MTIME;
-		if (!(cache_validity & NFS_INO_INVALID_SIZE))
-			reply_mask |= STATX_SIZE;
-	}
+	if (!(cache_validity & NFS_INO_INVALID_CTIME))
+		reply_mask |= STATX_CTIME;
+	if (!(cache_validity & NFS_INO_INVALID_MTIME))
+		reply_mask |= STATX_MTIME;
+	if (!(cache_validity & NFS_INO_INVALID_SIZE))
+		reply_mask |= STATX_SIZE;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
 		reply_mask |= STATX_UID | STATX_GID | STATX_MODE | STATX_NLINK;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
@@ -1362,7 +1345,7 @@ int nfs_clear_invalid_mapping(struct address_space *mapping)
 
 bool nfs_mapping_need_revalidate_inode(struct inode *inode)
 {
-	return nfs_check_cache_invalid(inode, NFS_INO_REVAL_PAGECACHE) ||
+	return nfs_check_cache_invalid(inode, NFS_INO_INVALID_CHANGE) ||
 		NFS_STALE(inode);
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6b990fe5bc1f..a21311520404 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5429,7 +5429,7 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 
 	memcpy(bitmask, src, sizeof(*bitmask) * NFS4_BITMASK_SZ);
 
-	if (cache_validity & (NFS_INO_INVALID_CHANGE | NFS_INO_REVAL_PAGECACHE))
+	if (cache_validity & NFS_INO_INVALID_CHANGE)
 		bitmask[0] |= FATTR4_WORD0_CHANGE;
 	if (cache_validity & NFS_INO_INVALID_ATIME)
 		bitmask[1] |= FATTR4_WORD1_TIME_ACCESS;
@@ -5449,8 +5449,7 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 	if (nfs4_have_delegation(inode, FMODE_READ) &&
 	    !(cache_validity & NFS_INO_REVAL_FORCED))
 		bitmask[0] &= ~FATTR4_WORD0_SIZE;
-	else if (cache_validity &
-		 (NFS_INO_INVALID_SIZE | NFS_INO_REVAL_PAGECACHE))
+	else if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
 
 	for (i = 0; i < NFS4_BITMASK_SZ; i++)
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f05a90338a76..7a39b3d424da 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1293,7 +1293,7 @@ static bool nfs_write_pageuptodate(struct page *page, struct inode *inode,
 	if (nfs_have_delegated_attributes(inode))
 		goto out;
 	if (nfsi->cache_validity &
-	    (NFS_INO_REVAL_PAGECACHE | NFS_INO_INVALID_SIZE))
+	    (NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE))
 		return false;
 	smp_rmb();
 	if (test_bit(NFS_INO_INVALIDATING, &nfsi->flags) && pagelen != 0)
-- 
2.30.2

