Return-Path: <linux-nfs+bounces-13348-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 471DEB176C1
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 21:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BB51C24726
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 19:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2224633C;
	Thu, 31 Jul 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJTddcp+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC195245019
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753991095; cv=none; b=DPjiKcmEu5t2wkUIduCLtbDW8ZDJLFHCoV670f5/WD/frxAWzjsVb4Ehl7A38p7rJ+hi7AyuZqdjfSO1DF1YVAaHMkK8VH6/jkz1NgBFnmD5zhdJQ96kzkBLNeSAc0nbh5Y7/RHAsu2XbbXTyydyImOShlsdQkct5wz4Fj6gs9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753991095; c=relaxed/simple;
	bh=ttAh1V9ccl05165UNvMRcUepemPOsXQqRFQ5cLeLLnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Polov1RmgvpYnvGUo7Pt5grAQDk/jLJ+PK71ZIAcd5s5ZdjcR8Jsq6YLhX2u+DlZkU4slsQohBFoLxAV8uLpdQTzKcyFfGXG4Ey4HduO99wXYmVL1MyeS+9+GKc4RJNqrtNJ1Foef4hHVNE3fMRWjbH0YDL6o7e9Tkxe6VRIBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJTddcp+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5471DC4CEEF;
	Thu, 31 Jul 2025 19:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753991095;
	bh=ttAh1V9ccl05165UNvMRcUepemPOsXQqRFQ5cLeLLnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJTddcp+sX0mR/ZmpFf5z0x67p5CGOsrPVFO2RRm3DPxmslWVV2QpCLzEK8ukjftk
	 HlvjnE2/plXWJpq6XgTxjbxsMPLdxhHMJxQ4qUZ06nb1YBYhUJicaWM2PripiypgKC
	 hECK0nO2JOUOPEygWKpWjx/SvPSg8hw4dltpuXQyG8MDwvSfSzyUAks+XxStXObbfJ
	 Jm7URVu1wHXS6WeBL7xBGKGrlst12loJiDaU0c4CqS/gI/7UWDtazajlEcr8ZEwdfs
	 e9A+augOiUYJNO9+uoiGYJGw0ByZVoG8B6A+7DIrgow6dbMJMZlJzkMB9WfLDGXUs4
	 CegeMg4IlJvDg==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/4] NFSD: handle unaligned DIO for NFS reexport
Date: Thu, 31 Jul 2025 15:44:48 -0400
Message-ID: <20250731194448.88816-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250731194448.88816-1-snitzer@kernel.org>
References: <20250731194448.88816-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NFS doesn't have any DIO alignment constraints but it doesn't support
STATX_DIOALIGN, so update NFSD such that it doesn't disable the use of
NFSD_IO_DIRECT if it is reexporting NFS.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/export.c          |  3 ++-
 fs/nfsd/filecache.c      | 11 +++++++++++
 include/linux/exportfs.h | 13 +++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index e9c233b6fd209..2cae75ba6b35d 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -155,5 +155,6 @@ const struct export_operations nfs_export_ops = {
 		 EXPORT_OP_REMOTE_FS		|
 		 EXPORT_OP_NOATOMIC_ATTR	|
 		 EXPORT_OP_FLUSH_ON_CLOSE	|
-		 EXPORT_OP_NOLOCKS,
+		 EXPORT_OP_NOLOCKS		|
+		 EXPORT_OP_NO_DIOALIGN_NEEDED,
 };
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 5601e839a72da..ea489dd44fd9a 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -1066,6 +1066,17 @@ nfsd_file_getattr(const struct svc_fh *fhp, struct nfsd_file *nf)
 	     nfsd_io_cache_write != NFSD_IO_DIRECT))
 		return nfs_ok;
 
+	if (exportfs_handles_unaligned_dio(nf->nf_file->f_path.mnt->mnt_sb->s_export_op)) {
+		/* Underlying filesystem doesn't support STATX_DIOALIGN
+		 * but it can handle all unaligned DIO, so establish
+		 * DIO alignment that is accommodating.
+		 */
+		nf->nf_dio_mem_align = 4;
+		nf->nf_dio_offset_align = PAGE_SIZE;
+		nf->nf_dio_read_offset_align = nf->nf_dio_offset_align;
+		return nfs_ok;
+	}
+
 	status = fh_getattr(fhp, &stat);
 	if (status != nfs_ok)
 		return status;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 9369a607224c1..626b8486dd985 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -247,6 +247,7 @@ struct export_operations {
 						*/
 #define EXPORT_OP_FLUSH_ON_CLOSE	(0x20) /* fs flushes file data on close */
 #define EXPORT_OP_NOLOCKS		(0x40) /* no file locking support */
+#define EXPORT_OP_NO_DIOALIGN_NEEDED	(0x80) /* fs can handle unaligned DIO */
 	unsigned long	flags;
 };
 
@@ -262,6 +263,18 @@ exportfs_cannot_lock(const struct export_operations *export_ops)
 	return export_ops->flags & EXPORT_OP_NOLOCKS;
 }
 
+/**
+ * exportfs_handles_unaligned_dio() - check if export can handle unaligned DIO
+ * @export_ops:	the nfs export operations to check
+ *
+ * Returns true if the export can handle unaligned DIO.
+ */
+static inline bool
+exportfs_handles_unaligned_dio(const struct export_operations *export_ops)
+{
+	return export_ops->flags & EXPORT_OP_NO_DIOALIGN_NEEDED;
+}
+
 extern int exportfs_encode_inode_fh(struct inode *inode, struct fid *fid,
 				    int *max_len, struct inode *parent,
 				    int flags);
-- 
2.44.0


