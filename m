Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E89A193446
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYXLK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:10 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:33265 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCYXLK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177870; x=1616713870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=tWhfOnS+iaaxfHy+zXD9/znIxnxGmS+wwK8M7/1QuQs=;
  b=KC6/1g8dJDtry48Wt9rnbgTDHuMAD8DinMZo2KK9ZxLYDaqDseQoFiPx
   7zh0V2Z61KVzr2cm6gj9+YPnBYz+9ktz0gg9JGsGID21lUKCd3PVaJGlG
   iERJ+So9EW7a7P6YZ05tCmHh3PtQebGBqEqhzPa96yeYndZ+UMVg9GEq6
   4=;
IronPort-SDR: 3lgvDmiFTn17XOiKF6pA9LsjHgQK+pWLdzBUpJ3+QpI5FjE/AkLDMYm0ttrOk/QiXo73z9Msjw
 b3DQ2NA5xJsw==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="23184760"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Mar 2020 23:10:54 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id AF55EA20EE;
        Wed, 25 Mar 2020 23:10:52 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:51 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:51 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 67501D92C7; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 09/13] nfs: define and use the NFS_INO_INVALID_XATTR flag
Date:   Wed, 25 Mar 2020 23:10:47 +0000
Message-ID: <20200325231051.31652-10-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
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
index 0bb2241028f0..441bdbb7f247 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -1183,7 +1183,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 
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
2.17.2

