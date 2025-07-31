Return-Path: <linux-nfs+bounces-13367-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D74B17943
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 01:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95E341C266DF
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC80C27E1D0;
	Thu, 31 Jul 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdfeyfDi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790E27A469
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 23:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003200; cv=none; b=MlbAhSAyPWeX0gUNXL14dXp4ZcfNwX1PK0+TbLx23S/onRLZf0QtVSl0eWBnyrO0qrFAo0RrEem/CpxNNc6DWxAWmTGhAOnIOTFkb7dHX5ZLSn9dPW35kHaUu9U71y9+32XheOCVOVVuEsK/DZX570jhIwB3R56wRFldOi4qwL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003200; c=relaxed/simple;
	bh=ttAh1V9ccl05165UNvMRcUepemPOsXQqRFQ5cLeLLnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POwFl0Kapa+OOOHbmynxHpNJBzohCztphNpdVcSnags+uSzRfSk1qUKXZIvt1eVrSeHAcEtRxx8nzoYBZ8Ty9Ejqa/+XmE2Z0pHbMlmF6j91B79GSe0rviTWhtGK7Ds3nPxv2VwsFfAN/Ric79CdZwqUVaYeodlp/eAY2SFH2fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdfeyfDi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE708C4CEF8;
	Thu, 31 Jul 2025 23:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003200;
	bh=ttAh1V9ccl05165UNvMRcUepemPOsXQqRFQ5cLeLLnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sdfeyfDiK3NuykmKoiwrsXcDCTlv5kSDH5Kc2owBI1eAhPxAvtgCm48I2vK6N6UtH
	 cuswYXUG96dI7pFcIwwK8dcmbYAA9p0ggREaQSIRF3RJFJQd4NsLH8oF45viztFo4N
	 BVPgoRZkTzVLlg1a1PHxEuKBbrXoAHoUbTVuB0pC1I7PdWR5W3ZRSNcIdY9kIdISQk
	 HNhs37iku6tUU7tGI3YkWqwyJCmCmw6jItDgCB/xzcMdz6L/Hczh5jvacXmYsbjpfD
	 I6bD+1iKtE8KqkgVfaYL0XhV3xljB2AgejkeDDZZTl9nshaxchW3dWZ5Ta7LzT/NrK
	 16pg3O+3OdC2Q==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 4/4] NFSD: handle unaligned DIO for NFS reexport
Date: Thu, 31 Jul 2025 19:06:33 -0400
Message-ID: <20250731230633.89983-5-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250731230633.89983-1-snitzer@kernel.org>
References: <20250731230633.89983-1-snitzer@kernel.org>
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


