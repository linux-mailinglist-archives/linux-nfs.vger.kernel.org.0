Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F17480458
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhL0TLi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhL0TLg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497F2C061401
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 11:11:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BF74FCE1065
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1FDC36AE7;
        Mon, 27 Dec 2021 19:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632293;
        bh=sQJ8odAgCH9G88ulZCmcn2Y+uOpDQxMbfsFZ1CHWCps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYkowB2uTZTZJImLAEzPdY1HvWkAnP+X918/jiTuFzVuQ3c0c11GwMBux2hUQJ4zp
         qFAGGkDTTobp1tZkkoIwugPs0mBFuyFyXdBaYXF+liHtL33+MoWNUibXtKOXbAGHsd
         Bgt/F60/XWwZ1OCXhu5MZWKQbPIV/65rANPUrkLsZmt7FEYAiGuXqDHzLhlJu4o74d
         7EiuDmbiQrfxhR4SCUT5fLEN2wnkj/GcChgn34h6L64JfABubcjO7HxGzDtE9sbxXA
         pT6wseYHcpNWxJ9/CA49fmZSBEJkSDQaShDeS/F2PpNeaCbAsUNg1dZsNqtz+4bGtN
         rf5Sta6kJvQSA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 5/8] nfs: Add 'time backup' to nfs inode
Date:   Mon, 27 Dec 2021 14:05:01 -0500
Message-Id: <20211227190504.309612-6-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-5-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <20211227190504.309612-2-trondmy@kernel.org>
 <20211227190504.309612-3-trondmy@kernel.org>
 <20211227190504.309612-4-trondmy@kernel.org>
 <20211227190504.309612-5-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anne Marie Merritt <annemarie.merritt@primarydata.com>

Add tracking of the NFSv4 'time backup' attribute, along with
corresponding bitfields, request, and decode xdr routines.

Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c          | 11 +++++++++++
 fs/nfs/nfs4proc.c       |  8 ++++++--
 fs/nfs/nfs4trace.h      |  3 ++-
 fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
 include/linux/nfs_fs.h  |  1 +
 include/linux/nfs_xdr.h |  3 +++
 6 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 9f138dc1880d..4673b091ea31 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -524,6 +524,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
 		memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
 		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
+		memset(&nfsi->timebackup, 0, sizeof(nfsi->timebackup));
 		nfsi->archive = 0;
 		nfsi->hidden = 0;
 		nfsi->system = 0;
@@ -554,6 +555,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			nfsi->btime = fattr->btime;
 		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
+		if (fattr->valid & NFS_ATTR_FATTR_TIME_BACKUP)
+			nfsi->timebackup = fattr->time_backup;
+		else if (fattr_supported & NFS_ATTR_FATTR_TIME_BACKUP)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_WINATTR);
 		if (fattr->valid & NFS_ATTR_FATTR_ARCHIVE)
 			nfsi->archive = (fattr->hsa_flags & NFS_HSA_ARCHIVE) ? 1 : 0;
 		else if (fattr_supported & NFS_ATTR_FATTR_ARCHIVE)
@@ -2161,6 +2166,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BTIME;
 
+	if (fattr->valid & NFS_ATTR_FATTR_TIME_BACKUP)
+		nfsi->timebackup = fattr->time_backup;
+	else if (fattr_supported & NFS_ATTR_FATTR_TIME_BACKUP)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_WINATTR;
+
 	if (fattr->valid & NFS_ATTR_FATTR_ARCHIVE)
 		nfsi->archive = (fattr->hsa_flags & NFS_HSA_ARCHIVE) ? 1 : 0;
 	else if (fattr_supported & NFS_ATTR_FATTR_ARCHIVE)
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 99c7cf5944f8..4e6cc54016ba 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -211,6 +211,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_SYSTEM
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_BACKUP
 	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
@@ -236,6 +237,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_SYSTEM
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_BACKUP
 	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY,
@@ -322,7 +324,7 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 
 	if (!(cache_validity & NFS_INO_INVALID_WINATTR)) {
 		dst[0] &= ~(FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN);
-		dst[1] &= ~FATTR4_WORD1_SYSTEM;
+		dst[1] &= ~(FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_BACKUP);
 	}
 }
 
@@ -3916,6 +3918,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_BACKUP))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_TIME_BACKUP;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_BTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_SYSTEM))
@@ -5481,7 +5485,7 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 		bitmask[1] |= FATTR4_WORD1_TIME_CREATE;
 	if (cache_validity & NFS_INO_INVALID_WINATTR) {
 		bitmask[0] |= FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN;
-		bitmask[1] |= FATTR4_WORD1_SYSTEM;
+		bitmask[1] |= FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_BACKUP;
 	}
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index babcd3207e8f..5e72639b469e 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -34,7 +34,8 @@
 		{ NFS_ATTR_FATTR_BTIME, "BTIME" }, \
 		{ NFS_ATTR_FATTR_HIDDEN, "HIDDEN" }, \
 		{ NFS_ATTR_FATTR_SYSTEM, "SYSTEM" }, \
-		{ NFS_ATTR_FATTR_ARCHIVE, "ARCHIVE" })
+		{ NFS_ATTR_FATTR_ARCHIVE, "ARCHIVE" }, \
+		{ NFS_ATTR_FATTR_TIME_BACKUP, "TIME_BACKUP" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 2131754e64f0..280df43c5bf2 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1619,6 +1619,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			    FATTR4_WORD1_OWNER| FATTR4_WORD1_OWNER_GROUP |
 			    FATTR4_WORD1_RAWDEV | FATTR4_WORD1_SPACE_USED |
 			    FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_ACCESS |
+			    FATTR4_WORD1_TIME_BACKUP |
 			    FATTR4_WORD1_TIME_CREATE |
 			    FATTR4_WORD1_TIME_METADATA |
 			    FATTR4_WORD1_TIME_MODIFY;
@@ -4192,6 +4193,24 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
 	return status;
 }
 
+static int decode_attr_time_backup(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
+{
+	int status = 0;
+
+	time->tv_sec = 0;
+	time->tv_nsec = 0;
+	if (unlikely(bitmap[1] & (FATTR4_WORD1_TIME_BACKUP - 1U)))
+		return -EIO;
+	if (likely(bitmap[1] & FATTR4_WORD1_TIME_BACKUP)) {
+		status = decode_attr_time(xdr, time);
+		if (status == 0)
+			status = NFS_ATTR_FATTR_TIME_BACKUP;
+		bitmap[1] &= ~FATTR4_WORD1_TIME_BACKUP;
+	}
+	dprintk("%s: time_backup=%ld\n", __func__, (long)time->tv_sec);
+	return status;
+}
+
 static int decode_attr_time_create(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
 {
 	int status = 0;
@@ -4783,6 +4802,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		goto xdr_error;
 	fattr->valid |= status;
 
+	status = decode_attr_time_backup(xdr, bitmap, &fattr->time_backup);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
+
 	status = decode_attr_time_create(xdr, bitmap, &fattr->btime);
 	if (status < 0)
 		goto xdr_error;
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 34288dcf8547..1839fed16b18 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -143,6 +143,7 @@ struct nfs_inode {
 	 */
 
 	struct timespec64	btime;
+	struct timespec64	timebackup;
 
 	unsigned char		archive : 1;
 	unsigned char		hidden : 1;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 308324d197f4..dedc7e0bf2b9 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -73,6 +73,7 @@ struct nfs_fattr {
 	struct timespec64	mtime;
 	struct timespec64	ctime;
 	struct timespec64	btime;
+	struct timespec64	time_backup;
 	__u32			hsa_flags;	/* hidden, system, archive flags bitfield */
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
@@ -117,6 +118,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_HIDDEN           BIT_ULL(27)
 #define NFS_ATTR_FATTR_SYSTEM           BIT_ULL(28)
 #define NFS_ATTR_FATTR_ARCHIVE          BIT_ULL(29)
+#define NFS_ATTR_FATTR_TIME_BACKUP      BIT_ULL(30)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -141,6 +143,7 @@ struct nfs_fattr {
 		| NFS_ATTR_FATTR_HIDDEN \
 		| NFS_ATTR_FATTR_SYSTEM \
 		| NFS_ATTR_FATTR_ARCHIVE \
+		| NFS_ATTR_FATTR_TIME_BACKUP \
 		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
 
 /*
-- 
2.33.1

