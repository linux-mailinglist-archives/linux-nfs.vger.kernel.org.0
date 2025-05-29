Return-Path: <linux-nfs+bounces-11970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6B8AC7BE9
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 12:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4D9F1BC6FFB
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 10:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3A02036E9;
	Thu, 29 May 2025 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZdpM/MRV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA818DF62
	for <linux-nfs@vger.kernel.org>; Thu, 29 May 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515558; cv=none; b=L0V7RVhjF34oP+pHecq5FrzuVkvH9UAHxjvTuYS4UKTkWcpWe0oXeV4kJJnGDmzcKIOM6/rEewHi472DQaenJGcSN1w0E2jOZFYPHocGETAu50F9tQuWae0se0Xj3IpnwP4rtSbB+0PoGQGuXAnfhABM8hs9QKFEzpUCosfSee8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515558; c=relaxed/simple;
	bh=9Z2W8MxpxSveFi2xltFszE62caWBdPG/r+QyuO9aI2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOzdsu7WkySFtsuOvuwhYuzy2xrZc7l/LcXMYa9Pt0LXO9UFVxci2OuTJ3pD5qIkhGV4WBmfB69gchiaQamsDtX5oFEF+6ikl2ewxWIeebUyXLbuuAESrqCosUGF/uGbagNFhEtBX+hzxZLBxMehxEB+tLSvd3NUTqKjCBts+mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZdpM/MRV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748515555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Du69AYvqsz0LpC0UqVXiJ1nYpx1CQHYm+7a8g7meyTA=;
	b=ZdpM/MRVVjWsDIY6/0LR/K8iz00jW7IQuZE8gcb4JzBnslh+YoJhkRdJHugu+aD0SHBpRR
	O1p4qSYSeBuGI4yCzAggybGwAAsP/LcWDaw/Im8+Xm5HanzMm4NcV+jnpzSJOmr+wSnXph
	elu8AmcPzExJFVBBKiNXs7/vj4Pt6PI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-G9a2YC5-PJaIL-Mqy-GM0Q-1; Thu,
 29 May 2025 06:45:52 -0400
X-MC-Unique: G9a2YC5-PJaIL-Mqy-GM0Q-1
X-Mimecast-MFC-AGG-ID: G9a2YC5-PJaIL-Mqy-GM0Q_1748515551
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC9EB1800570;
	Thu, 29 May 2025 10:45:50 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA33630002C1;
	Thu, 29 May 2025 10:45:49 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 1/3] Expand the type of nfs_fattr->valid
Date: Thu, 29 May 2025 06:45:45 -0400
Message-ID: <1e3405fca54efd0be7c91c1da77917b94f5dfcc4.1748515333.git.bcodding@redhat.com>
In-Reply-To: <cover.1748515333.git.bcodding@redhat.com>
References: <cover.1748515333.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Trond Myklebust <trond.myklebust@primarydata.com>

We need to be able to track more than 32 attributes per inode.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/inode.c            |  2 +-
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 54 +++++++++++++++++++--------------------
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 119e447758b9..160f3478a835 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2166,7 +2166,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	bool attr_changed = false;
 	bool have_delegation;
 
-	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%x)\n",
+	dfprintk(VFS, "NFS: %s(%s/%lu fh_crc=0x%08x ct=%d info=0x%llx)\n",
 			__func__, inode->i_sb->s_id, inode->i_ino,
 			nfs_display_fhandle_hash(NFS_FH(inode)),
 			atomic_read(&inode->i_count), fattr->valid);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index ee03f3cef30c..4b38b8e709f8 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -171,8 +171,8 @@ struct nfs_server {
 #define NFS_MOUNT_FORCE_RDIRPLUS	0x20000000
 #define NFS_MOUNT_NETUNREACH_FATAL	0x40000000
 
-	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
+	__u64			fattr_valid;	/* Valid attributes */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 67f6632f723b..9cacbbd14787 100644
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
2.47.0


