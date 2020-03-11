Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877A81822EB
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgCKT4n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:43 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:61723 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgCKT4n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956602; x=1615492602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=xooXU7M8vhd10XITmEl/ZD52kvtmY62kFOlidC+EigU=;
  b=VLk6cV647KER/m5pIqd7zPY1bvJLGWgKZ6vcYPcwE7jLC0/jTj+24I51
   LAP3p9GvM9hDxWtoTJao48Hm9/d2qttLUyK/HW1XUMJ6rTivbUu7/GJoP
   Bgka7vqdO+32yamAW6iniSu1jgTj7wpCPWDcmQ51LdXTBG7PKvGWVGy4S
   I=;
IronPort-SDR: xOHd1wMgX0GtGKt/11QC+MiuAsdxsWf24TY/UVcLnJ51a9+KxEDq/OP25EhQxLGwfmJPAQjP7e
 5WR3yAeHdsHg==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="21100390"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Mar 2020 19:56:32 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id CD7B8A2B6B;
        Wed, 11 Mar 2020 19:56:31 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:31 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:30 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 07C16DEF47; Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 09/13] nfs: define and use the NFS_INO_INVALID_XATTR flag
Date:   Wed, 11 Mar 2020 19:56:09 +0000
Message-ID: <20200311195613.26108-10-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Define the NFS_INO_INVALID_XATTR flag, to be used for the NFSv4.2 xattr
cache, and use it where appropriate.

No functional change as yet.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/inode.c         | 7 ++++++-
 fs/nfs/nfs4proc.c      | 3 ++-
 fs/nfs/nfstrace.h      | 3 ++-
 include/linux/nfs_fs.h | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 11bf15800ac9..d2be152796ef 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -205,7 +205,8 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~NFS_INO_INVALID_OTHER;
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE);
+				| NFS_INO_REVAL_PAGECACHE
+				| NFS_INO_INVALID_XATTR);
 	}
 
 	if (inode->i_mapping->nrpages == 0)
@@ -535,6 +536,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			inode->i_gid = fattr->gid;
 		else if (nfs_server_capable(inode, NFS_CAP_OWNER_GROUP))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+		if (nfs_server_capable(inode, NFS_CAP_XATTR))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 			inode->i_blocks = fattr->du.nfs2.blocks;
 		if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
@@ -1365,6 +1368,8 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		inode_set_iversion_raw(inode, fattr->change_attr);
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
+		else if (nfs_server_capable(inode, NFS_CAP_XATTR))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
 	ts = inode->i_ctime;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 31d65bbf4a23..725ae64f62f7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1182,7 +1182,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 
 		if (cinfo->before != inode_peek_iversion_raw(inode))
 			nfsi->cache_validity |= NFS_INO_INVALID_ACCESS |
-						NFS_INO_INVALID_ACL;
+						NFS_INO_INVALID_ACL |
+						NFS_INO_INVALID_XATTR;
 	}
 	inode_set_iversion_raw(inode, cinfo->after);
 	nfsi->read_cache_jiffies = timestamp;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index a9588d19a5ae..b941ad1199e5 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -59,7 +59,8 @@ TRACE_DEFINE_ENUM(NFS_INO_INVALID_OTHER);
 			{ NFS_INO_INVALID_CTIME, "INVALID_CTIME" }, \
 			{ NFS_INO_INVALID_MTIME, "INVALID_MTIME" }, \
 			{ NFS_INO_INVALID_SIZE, "INVALID_SIZE" }, \
-			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" })
+			{ NFS_INO_INVALID_OTHER, "INVALID_OTHER" }, \
+			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" })
 
 TRACE_DEFINE_ENUM(NFS_INO_ADVISE_RDPLUS);
 TRACE_DEFINE_ENUM(NFS_INO_STALE);
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index e86e7a747092..1fcfef670a4a 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -233,6 +233,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_OTHER	BIT(12)		/* other attrs are invalid */
 #define NFS_INO_DATA_INVAL_DEFER	\
 				BIT(13)		/* Deferred cache invalidation */
+#define NFS_INO_INVALID_XATTR	BIT(14)		/* xattrs are invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
-- 
2.16.6

