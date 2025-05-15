Return-Path: <linux-nfs+bounces-11747-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA595AB8999
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A936A3A94FC
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5DB7260C;
	Thu, 15 May 2025 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGrsGVaO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18581E5B71
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320030; cv=none; b=GZkQD8puAu70m0CFMonBprtwi67z7t7KF1oRTnH8G/F0HobxzoQiT3TlAwgxoG6a/lg/4W5mc73l+u79zu+G92xvwTo+T4efXtKtk8+2+1MykgjknKmU5iAIGix+mR7XRFLPYcQmMggi3zPVGWEplA38Jg5eLEPZnopbTAxSjkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320030; c=relaxed/simple;
	bh=Kf+5X9JuSmtyanTsKWgSPX61fjBSOU1yWPBzB4NG3LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtZ1IpiyMxHOv3LmTo3D2cRJSFHIGN9VG+ec96WPCc0lYPFkuUMyNRw4QZtmtQPiZ500fIYrjtJYxOwvxbyMl4oaUAF6NL6tiS1kjEsRzdD/9ySFcvR5NZVOkAn0qj+OvVfpWS3xKADPlMwl7Fsn+h/zLMQioBGPv1+Gjgd5d9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGrsGVaO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747320027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nMJLwau4wF5GlUgF+RBszkAyRgPt1CQipKMu8yoXjE0=;
	b=FGrsGVaOFoBuIFGUyCdi9MPY0cmPGohFPIT1T1Rj8fUp5H4m9aKOqSmBOP3KRLiIhBMaPH
	A4CqYYkP+5WPZwawFRAl4jhyf4Dq6i1oS9x3EQ4u5hmjLJvN/vlfgbQdWEM+bpCo5HMuCL
	K1y09A9RU/W1NXWKLt+YrjmUWF3UZrA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-bLOEEmJpPO-4nnV0ibroaQ-1; Thu,
 15 May 2025 10:40:24 -0400
X-MC-Unique: bLOEEmJpPO-4nnV0ibroaQ-1
X-Mimecast-MFC-AGG-ID: bLOEEmJpPO-4nnV0ibroaQ_1747320023
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 04F26195608C;
	Thu, 15 May 2025 14:40:23 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.90.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CB653195608D;
	Thu, 15 May 2025 14:40:21 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>
Subject: [PATCH v1 1/3] Expand the type of nfs_fattr->valid
Date: Thu, 15 May 2025 10:40:16 -0400
Message-ID: <725abd9afbe268c50b99a1b2ded6c2339a5e79c0.1747318805.git.bcodding@redhat.com>
In-Reply-To: <cover.1747318805.git.bcodding@redhat.com>
References: <cover.1747318805.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

From: Trond Myklebust <trond.myklebust@primarydata.com>

We need to be able to track more than 32 attributes per inode.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/inode.c            |  5 ++--
 include/linux/nfs_fs_sb.h |  2 +-
 include/linux/nfs_xdr.h   | 54 +++++++++++++++++++--------------------
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 1aa67fca69b2..d4e449fa076e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2164,10 +2164,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
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
index f00bfcee7120..056d0ad38756 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -168,8 +168,8 @@ struct nfs_server {
 #define NFS_MOUNT_SHUTDOWN			0x08000000
 #define NFS_MOUNT_NO_ALIGNWRITE		0x10000000
 
-	unsigned int		fattr_valid;	/* Valid attributes */
 	unsigned int		caps;		/* server capabilities */
+	__u64			fattr_valid;	/* Valid attributes */
 	unsigned int		rsize;		/* read size */
 	unsigned int		rpages;		/* read size (in pages) */
 	unsigned int		wsize;		/* write size */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9155a6ffc370..b7b06f0d2fb9 100644
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


