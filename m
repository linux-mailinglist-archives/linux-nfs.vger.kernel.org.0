Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA757480456
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Dec 2021 20:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhL0TLf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Dec 2021 14:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhL0TLf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Dec 2021 14:11:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9DFC06173E
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 11:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2AA6FCE114B
        for <linux-nfs@vger.kernel.org>; Mon, 27 Dec 2021 19:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67858C36AEC;
        Mon, 27 Dec 2021 19:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640632291;
        bh=O5YT/FOTCSe0an4CaWKzPFvNsly5YLxV7SWVj+pEVUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qD0vK9Ig9kR0cCWe+/PEcqx/OOIiBHwg2xcP60jD9Teq/E66ei+oV1Jhx90NmVES2
         pQV1ElK42VVRbn+v0HLDHQcfKdLmXHoJ2JQ63u1CEhWxZWzOoU0utge98TxWoI3NVf
         Ctp10j1DZuYWgJTBp5Pb5ehqtdPwYRTcdXq/7DE6pW+W/pmDQEdKvII1zQ9NihJuVt
         SNCFjdbo4vCFm3bdtHeLzCKQj2bMP+uGna5GGxqB3f+I2K1hr++sx3DWTVDrirpPBN
         roZcaSpkNwBN6UIz8ZZt0/8mvWOtbAT3bLcuHiJqYRf49Ao/kCsqe9fGt4kfL8JqV0
         A+lVf/EOPp8pQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/8] nfs: Add timecreate to nfs inode
Date:   Mon, 27 Dec 2021 14:04:58 -0500
Message-Id: <20211227190504.309612-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211227190504.309612-2-trondmy@kernel.org>
References: <20211227190504.309612-1-trondmy@kernel.org>
 <20211227190504.309612-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anne Marie Merritt <annemarie.merritt@primarydata.com>

Add tracking of the create time (a.k.a. btime) along with corresponding
bitfields, request, and decode xdr routines.

Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c          | 28 ++++++++++++++++++++++------
 fs/nfs/nfs4proc.c       | 15 +++++++++++++--
 fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
 fs/nfs/nfstrace.h       |  3 ++-
 include/linux/nfs_fs.h  |  7 +++++++
 include/linux/nfs_xdr.h |  3 +++
 6 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 897dec07cf4b..908a62d6a29c 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -201,6 +201,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
+				   NFS_INO_INVALID_BTIME |
 				   NFS_INO_INVALID_XATTR);
 		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 	} else if (flags & NFS_INO_REVAL_PAGECACHE)
@@ -521,6 +522,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		memset(&inode->i_atime, 0, sizeof(inode->i_atime));
 		memset(&inode->i_mtime, 0, sizeof(inode->i_mtime));
 		memset(&inode->i_ctime, 0, sizeof(inode->i_ctime));
+		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -544,6 +546,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			inode->i_ctime = fattr->ctime;
 		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
+		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
+			nfsi->btime = fattr->btime;
+		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		else
@@ -1801,7 +1807,7 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
 		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
-		NFS_INO_INVALID_NLINK;
+		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
 	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
@@ -2052,10 +2058,13 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfsi->read_cache_jiffies = fattr->time_start;
 
 	save_cache_validity = nfsi->cache_validity;
-	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
-			| NFS_INO_INVALID_ATIME
-			| NFS_INO_REVAL_FORCED
-			| NFS_INO_INVALID_BLOCKS);
+	nfsi->cache_validity &=
+		~(NFS_INO_INVALID_ATIME | NFS_INO_REVAL_FORCED |
+		  NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_CTIME |
+		  NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
+		  NFS_INO_INVALID_OTHER | NFS_INO_INVALID_BLOCKS |
+		  NFS_INO_INVALID_NLINK | NFS_INO_INVALID_MODE |
+		  NFS_INO_INVALID_BTIME);
 
 	/* Do atomic weak cache consistency updates */
 	nfs_wcc_update_inode(inode, fattr);
@@ -2085,7 +2094,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_MODE
-					| NFS_INO_INVALID_OTHER;
+					| NFS_INO_INVALID_OTHER
+					| NFS_INO_INVALID_BTIME;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
@@ -2116,6 +2126,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_CTIME;
 
+	if (fattr->valid & NFS_ATTR_FATTR_BTIME)
+		nfsi->btime = fattr->btime;
+	else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_BTIME;
+
 	/* Check if our cached file size is stale */
 	if (fattr->valid & NFS_ATTR_FATTR_SIZE) {
 		new_isize = nfs_size_to_loff_t(fattr->size);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 5d9ff01ddf46..be8eeb22b35f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -208,6 +208,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
@@ -229,6 +230,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY,
 	FATTR4_WORD2_MDSTHRESHOLD
@@ -308,6 +310,9 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 		dst[1] &= ~FATTR4_WORD1_MODE;
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
 		dst[1] &= ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
+
+	if (!(cache_validity & NFS_INO_INVALID_BTIME))
+		dst[1] &= ~FATTR4_WORD1_TIME_CREATE;
 }
 
 static void nfs4_setup_readdir(u64 cookie, __be32 *verifier, struct dentry *dentry,
@@ -1233,8 +1238,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
-				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR |
-				NFS_INO_REVAL_PAGECACHE;
+				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
+				NFS_INO_INVALID_XATTR | NFS_INO_REVAL_PAGECACHE;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
 	nfsi->attrtimeo_timestamp = jiffies;
@@ -3893,6 +3898,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->fattr_valid &= ~NFS_ATTR_FATTR_CTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_BTIME;
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
@@ -5450,6 +5459,8 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 		bitmask[1] |= FATTR4_WORD1_TIME_MODIFY;
 	if (cache_validity & NFS_INO_INVALID_BLOCKS)
 		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
+	if (cache_validity & NFS_INO_INVALID_BTIME)
+		bitmask[1] |= FATTR4_WORD1_TIME_CREATE;
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 801119b7a596..33ab1377f443 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1616,6 +1616,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 		attrs[1] |= FATTR4_WORD1_MODE|FATTR4_WORD1_NUMLINKS|FATTR4_WORD1_OWNER|
 			FATTR4_WORD1_OWNER_GROUP|FATTR4_WORD1_RAWDEV|
 			FATTR4_WORD1_SPACE_USED|FATTR4_WORD1_TIME_ACCESS|
+			FATTR4_WORD1_TIME_CREATE |
 			FATTR4_WORD1_TIME_METADATA|FATTR4_WORD1_TIME_MODIFY;
 		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
 		dircount >>= 1;
@@ -4121,6 +4122,24 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
 	return status;
 }
 
+static int decode_attr_time_create(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
+{
+	int status = 0;
+
+	time->tv_sec = 0;
+	time->tv_nsec = 0;
+	if (unlikely(bitmap[1] & (FATTR4_WORD1_TIME_CREATE - 1U)))
+		return -EIO;
+	if (likely(bitmap[1] & FATTR4_WORD1_TIME_CREATE)) {
+		status = decode_attr_time(xdr, time);
+		if (status == 0)
+			status = NFS_ATTR_FATTR_BTIME;
+		bitmap[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	}
+	dprintk("%s: btime=%lld\n", __func__, time->tv_sec);
+	return status;
+}
+
 static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
 {
 	int status = 0;
@@ -4678,6 +4697,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		goto xdr_error;
 	fattr->valid |= status;
 
+	status = decode_attr_time_create(xdr, bitmap, &fattr->btime);
+	if (status < 0)
+		goto xdr_error;
+	fattr->valid |= status;
+
 	status = decode_attr_time_metadata(xdr, bitmap, &fattr->ctime);
 	if (status < 0)
 		goto xdr_error;
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index b3aee261801e..cba86d167c38 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -33,7 +33,8 @@
 			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
 			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
-			{ NFS_INO_INVALID_MODE, "INVALID_MODE" })
+			{ NFS_INO_INVALID_MODE, "INVALID_MODE" }, \
+			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" })
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 450e393d4bf2..8d944d399b17 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -138,6 +138,12 @@ struct nfs_inode {
 	unsigned long		flags;			/* atomic bit ops */
 	unsigned long		cache_validity;		/* bit mask */
 
+	/*
+	 * NFS Attributes not included in struct inode
+	 */
+
+	struct timespec64	btime;
+
 	/*
 	 * read_cache_jiffies is when we started read-caching this inode.
 	 * attrtimeo is for how long the cached information is assumed
@@ -260,6 +266,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
 #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
+#define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 6e604d6a3e6d..8e8ff5def523 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -67,6 +67,7 @@ struct nfs_fattr {
 	struct timespec64	atime;
 	struct timespec64	mtime;
 	struct timespec64	ctime;
+	struct timespec64	btime;
 	__u64			change_attr;	/* NFSv4 change attribute */
 	__u64			pre_change_attr;/* pre-op NFSv4 change attribute */
 	__u64			pre_size;	/* pre_op_attr.size	  */
@@ -106,6 +107,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_OWNER_NAME	BIT_ULL(23)
 #define NFS_ATTR_FATTR_GROUP_NAME	BIT_ULL(24)
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL BIT_ULL(25)
+#define NFS_ATTR_FATTR_BTIME		BIT_ULL(26)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -126,6 +128,7 @@ struct nfs_fattr {
 		| NFS_ATTR_FATTR_SPACE_USED)
 #define NFS_ATTR_FATTR_V4 (NFS_ATTR_FATTR \
 		| NFS_ATTR_FATTR_SPACE_USED \
+		| NFS_ATTR_FATTR_BTIME \
 		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
 
 /*
-- 
2.33.1

