Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22E9480455
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhL0TLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45252 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbhL0TLd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 765D1B81144
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6B5C36AEA;
        Mon, 27 Dec 2021 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632291;
        bh=jW3o+Y7QNxe9LqB8UZWWE7G4YIBzkiHs6AU1ziioXZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iixa9/P5rK4cMq10ztvzxe8kEc3jmIFSHzmgCC427wqwLt+FHhlXaRua+xP//dw5C
         +mWGj6RqD4jRWfy90Af2IcHIVCuqmr2CxORXk2nf12ciJfIpsRvnMqo0vDmTGZ0jJ2
         3FSju1C+DzHT24/NnTiPAz1uciIcCXOa6ISjnm0GI9YQ8jTNH0foLhRuH5S/W+oItm
         q2ETzmFL9wk68wM6Lf7+RSRRF8pq81hVzxFumK0wG3/FbIjeCFhEUcu01xbxNW/wZ7
         TzKpHoy45LZrNj68FxCe9RGvYL3NTUPLJqw47ARWC7//YNokGhf3NkniK+m5P8dPJx
         OqfqhvSTG8e+g==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/8] NFS: Expand the type of nfs_fattr->valid
Date:   Mon, 27 Dec 2021 14:04:57 -0500
Message-Id: <20211227190504.309612-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-1-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

We need to be able to track more than 32 attributes per inode.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c            |  5 ++--
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 54 +++++++++++++++++++--------------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index fda530d5e764..897dec07cf4b 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2001,10 +2001,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	bool attr_changed = false;
 	bool have_delegation;
 
-	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%x)\n",
+	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%lx)\n",
 			__func__, inode->i_sb->s_id, inode->i_ino,
 			nfs_display_fhandle_hash(NFS_FH(inode)),
-			atomic_read(&inode->i_count), fattr->valid);
+			atomic_read(&inode->i_count),
+			(unsigned long)fattr->valid);
 
 	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
 		/* Only a mounted-on-fileid? Just exit */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 2a9acbfe00f0..8468206fb535 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -157,8 +157,8 @@ struct nfs_server {
 #define NFS_MOUNT_WRITE_EAGER		0x01000000
 #define NFS_MOUNT_WRITE_WAIT		0x02000000
 
-	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
+	__u64			fattr_valid;	/* Valid attributes */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9102bdaa3faa..6e604d6a3e6d 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -45,7 +45,7 @@ struct nfs4_threshold {
 };
 
 struct nfs_fattr {
-	unsigned int		valid;		/* which fields are valid */
+	__u64			valid;		/* which fields are valid */
 	umode_t			mode;
 	__u32			nlink;
 	kuid_t			uid;
@@ -80,32 +80,32 @@ struct nfs_fattr {
 	struct nfs4_label	*label;
 };
 
-#define NFS_ATTR_FATTR_TYPE		(1U << 0)
-#define NFS_ATTR_FATTR_MODE		(1U << 1)
-#define NFS_ATTR_FATTR_NLINK		(1U << 2)
-#define NFS_ATTR_FATTR_OWNER		(1U << 3)
-#define NFS_ATTR_FATTR_GROUP		(1U << 4)
-#define NFS_ATTR_FATTR_RDEV		(1U << 5)
-#define NFS_ATTR_FATTR_SIZE		(1U << 6)
-#define NFS_ATTR_FATTR_PRESIZE		(1U << 7)
-#define NFS_ATTR_FATTR_BLOCKS_USED	(1U << 8)
-#define NFS_ATTR_FATTR_SPACE_USED	(1U << 9)
-#define NFS_ATTR_FATTR_FSID		(1U << 10)
-#define NFS_ATTR_FATTR_FILEID		(1U << 11)
-#define NFS_ATTR_FATTR_ATIME		(1U << 12)
-#define NFS_ATTR_FATTR_MTIME		(1U << 13)
-#define NFS_ATTR_FATTR_CTIME		(1U << 14)
-#define NFS_ATTR_FATTR_PREMTIME		(1U << 15)
-#define NFS_ATTR_FATTR_PRECTIME		(1U << 16)
-#define NFS_ATTR_FATTR_CHANGE		(1U << 17)
-#define NFS_ATTR_FATTR_PRECHANGE	(1U << 18)
-#define NFS_ATTR_FATTR_V4_LOCATIONS	(1U << 19)
-#define NFS_ATTR_FATTR_V4_REFERRAL	(1U << 20)
-#define NFS_ATTR_FATTR_MOUNTPOINT	(1U << 21)
-#define NFS_ATTR_FATTR_MOUNTED_ON_FILEID (1U << 22)
-#define NFS_ATTR_FATTR_OWNER_NAME	(1U << 23)
-#define NFS_ATTR_FATTR_GROUP_NAME	(1U << 24)
-#define NFS_ATTR_FATTR_V4_SECURITY_LABEL (1U << 25)
+#define NFS_ATTR_FATTR_TYPE		BIT_ULL(0)
+#define NFS_ATTR_FATTR_MODE		BIT_ULL(1)
+#define NFS_ATTR_FATTR_NLINK		BIT_ULL(2)
+#define NFS_ATTR_FATTR_OWNER		BIT_ULL(3)
+#define NFS_ATTR_FATTR_GROUP		BIT_ULL(4)
+#define NFS_ATTR_FATTR_RDEV		BIT_ULL(5)
+#define NFS_ATTR_FATTR_SIZE		BIT_ULL(6)
+#define NFS_ATTR_FATTR_PRESIZE		BIT_ULL(7)
+#define NFS_ATTR_FATTR_BLOCKS_USED	BIT_ULL(8)
+#define NFS_ATTR_FATTR_SPACE_USED	BIT_ULL(9)
+#define NFS_ATTR_FATTR_FSID		BIT_ULL(10)
+#define NFS_ATTR_FATTR_FILEID		BIT_ULL(11)
+#define NFS_ATTR_FATTR_ATIME		BIT_ULL(12)
+#define NFS_ATTR_FATTR_MTIME		BIT_ULL(13)
+#define NFS_ATTR_FATTR_CTIME		BIT_ULL(14)
+#define NFS_ATTR_FATTR_PREMTIME		BIT_ULL(15)
+#define NFS_ATTR_FATTR_PRECTIME		BIT_ULL(16)
+#define NFS_ATTR_FATTR_CHANGE		BIT_ULL(17)
+#define NFS_ATTR_FATTR_PRECHANGE	BIT_ULL(18)
+#define NFS_ATTR_FATTR_V4_LOCATIONS	BIT_ULL(19)
+#define NFS_ATTR_FATTR_V4_REFERRAL	BIT_ULL(20)
+#define NFS_ATTR_FATTR_MOUNTPOINT	BIT_ULL(21)
+#define NFS_ATTR_FATTR_MOUNTED_ON_FILEID BIT_ULL(22)
+#define NFS_ATTR_FATTR_OWNER_NAME	BIT_ULL(23)
+#define NFS_ATTR_FATTR_GROUP_NAME	BIT_ULL(24)
+#define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
-- 
2.33.1

