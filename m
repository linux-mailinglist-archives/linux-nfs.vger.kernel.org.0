Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2273B206755
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbgFWWoN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:13 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:54762 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgFWWoL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lOKlIHexULpLaLYxF4+NArLZvMEYRv7NIPANzEKoWIo=;
  b=K+7ELGtxpwU5JeIx4Ne0Ced0NFhMQ9cfm0ixSsPJv1t/0xLhaQ7n8qVv
   olaNdRn+Lc6d38H8WovzA3QTDLKhuL5kIMChfWA7HIANBb64vbVfIwAzC
   Aus7Mr1wCvde1kPfSBkZe+zGfWb0TrPn3u7+SBFabPgLZHrewF4x3zH0y
   o=;
IronPort-SDR: ENVZMrn1fsCzVF2aVMvYzh+ipbursmulnGztUVUW/eLI6w95mDkQ5Z3WHiik2QRZtlfzNn6CC9
 1/E3UeOrKySw==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="37981945"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 209BDA1DF3;
        Tue, 23 Jun 2020 22:39:06 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:05 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id CFEF5CD363; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 09/13] nfs: define and use the NFS_INO_INVALID_XATTR flag
Date:   Tue, 23 Jun 2020 22:39:00 +0000
Message-ID: <20200623223904.31643-10-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
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
index 0bf1f835de01..629af798dfc9 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -204,7 +204,8 @@ static void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 			flags &= ~NFS_INO_INVALID_OTHER;
 		flags &= ~(NFS_INO_INVALID_CHANGE
 				| NFS_INO_INVALID_SIZE
-				| NFS_INO_REVAL_PAGECACHE);
+				| NFS_INO_REVAL_PAGECACHE
+				| NFS_INO_INVALID_XATTR);
 	}
 
 	if (inode->i_mapping->nrpages == 0)
@@ -542,6 +543,8 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr, st
 			inode->i_gid = fattr->gid;
 		else if (nfs_server_capable(inode, NFS_CAP_OWNER_GROUP))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_OTHER);
+		if (nfs_server_capable(inode, NFS_CAP_XATTR))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_BLOCKS_USED)
 			inode->i_blocks = fattr->du.nfs2.blocks;
 		if (fattr->valid & NFS_ATTR_FATTR_SPACE_USED) {
@@ -1375,6 +1378,8 @@ static void nfs_wcc_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		inode_set_iversion_raw(inode, fattr->change_attr);
 		if (S_ISDIR(inode->i_mode))
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_DATA);
+		else if (nfs_server_capable(inode, NFS_CAP_XATTR))
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_XATTR);
 	}
 	/* If we have atomic WCC data, we may update some attributes */
 	ts = inode->i_ctime;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 6540071cb228..0d123fe0a423 100644
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
index 547cec79899f..5a59dcdce0b2 100644
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
index 714b577dce19..943ee750d68c 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -234,6 +234,7 @@ struct nfs4_copy_state {
 #define NFS_INO_DATA_INVAL_DEFER	\
 				BIT(13)		/* Deferred cache invalidation */
 #define NFS_INO_INVALID_BLOCKS	BIT(14)         /* cached blocks are invalid */
+#define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
-- 
2.17.2

