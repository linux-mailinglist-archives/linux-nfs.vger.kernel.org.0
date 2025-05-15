Return-Path: <linux-nfs+bounces-11748-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD05CAB899B
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E831BC294F
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C12B1E3775;
	Thu, 15 May 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMVVqxmo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB011E5B71
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320034; cv=none; b=n3XyWk/3TVGmwM4PgnncHgikLlsglr0ybnL8wuMdx0N9U0uHQQVmhVN7GdyYmfHGjeZ60tBn+7rbcKG6nu59wA8r7SMK6gCVRYC3a3HYD2dQgzOUwzMFVo6dby05VjQwMOwH48ij36lWPHYoAfFd8K/jBqPucvhnGVY2ckHfdnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320034; c=relaxed/simple;
	bh=1Q88wlMYVnLoOjdpCTyYP4tCafzXJ4cltO5zFUx6kdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1cj4aOAYvzrNIm0+V0isZxA75ADMuHJll2oSpA+YERe16RO8F9akpBDC5NhiJRlubJrB4yTH0XOc3uanKw5/2x1j3vH8azERBhp1BQoqMffNf3N5n9e1WKuorpVZ0hOL5HwBQIhuljjxcz+AsPVGDNwS6XCl+Tll0nxHBruz7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMVVqxmo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747320030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R4mRuHK7QAsinuTSdf47Xo6TCHg8PKyPvE+X/7dizqA=;
	b=IMVVqxmoESOH0RgGs4pCi/SiYn6HHFyRexVn2P2wIYS+tmDirMc0EujvKjcDDWLv49u7gO
	UTJdpbtY7+OG3fT4CzGVikzQfyCWjt6vDqD88vph8Vid1clWQHYenXE0KyNiMcbrao2k+N
	x1hdvOD1OwgSgYFsJZD/u4HMw6HS64s=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-wcxH4mJrOkykxtb4CJNbnQ-1; Thu,
 15 May 2025 10:40:25 -0400
X-MC-Unique: wcxH4mJrOkykxtb4CJNbnQ-1
X-Mimecast-MFC-AGG-ID: wcxH4mJrOkykxtb4CJNbnQ_1747320024
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C660195608A;
	Thu, 15 May 2025 14:40:24 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.90.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 678A2195608D;
	Thu, 15 May 2025 14:40:23 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>
Subject: [PATCH v1 2/3] nfs: Add timecreate to nfs inode
Date: Thu, 15 May 2025 10:40:17 -0400
Message-ID: <b73f058a586931460d07f6510d9ae0ed4b562dc4.1747318805.git.bcodding@redhat.com>
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

From: Anne Marie Merritt <annemarie.merritt@primarydata.com>

Add tracking of the create time (a.k.a. btime) along with corresponding
bitfields, request, and decode xdr routines.

Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/inode.c          | 28 ++++++++++++++++++++++------
 fs/nfs/nfs4proc.c       | 14 +++++++++++++-
 fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
 fs/nfs/nfstrace.h       |  3 ++-
 include/linux/nfs_fs.h  |  7 +++++++
 include/linux/nfs_xdr.h |  3 +++
 6 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index d4e449fa076e..ffbcecb65bc7 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -195,6 +195,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
+				   NFS_INO_INVALID_BTIME |
 				   NFS_INO_INVALID_XATTR);
 		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 	}
@@ -520,6 +521,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode_set_atime(inode, 0, 0);
 		inode_set_mtime(inode, 0, 0);
 		inode_set_ctime(inode, 0, 0);
+		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -543,6 +545,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			inode_set_ctime_to_ts(inode, fattr->ctime);
 		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
+		if (fattr->valid & NFS_ATTR_FATTR_BTIME)
+			nfsi->btime = fattr->btime;
+		else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		else
@@ -1898,7 +1904,7 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
 		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
-		NFS_INO_INVALID_NLINK;
+		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
 	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
@@ -2218,10 +2224,13 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfs_fattr_fixup_delegated(inode, fattr);
 
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
@@ -2260,7 +2269,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_MODE
-					| NFS_INO_INVALID_OTHER;
+					| NFS_INO_INVALID_OTHER
+					| NFS_INO_INVALID_BTIME;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
@@ -2294,6 +2304,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
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
index 6e95db6c17e9..8b81b378ba5f 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -219,6 +219,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
@@ -240,6 +241,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY,
 	FATTR4_WORD2_MDSTHRESHOLD
@@ -320,6 +322,9 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
 		dst[1] &= ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
 
+	if (!(cache_validity & NFS_INO_INVALID_BTIME))
+		dst[1] &= ~FATTR4_WORD1_TIME_CREATE;
+
 	if (nfs_have_delegated_mtime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
 			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
@@ -1291,7 +1296,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
-				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR;
+				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
+				NFS_INO_INVALID_XATTR;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
 	nfsi->attrtimeo_timestamp = jiffies;
@@ -4032,6 +4038,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
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
@@ -5739,6 +5749,8 @@ void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
 		bitmask[1] |= FATTR4_WORD1_TIME_MODIFY;
 	if (cache_validity & NFS_INO_INVALID_BLOCKS)
 		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
+	if (cache_validity & NFS_INO_INVALID_BTIME)
+		bitmask[1] |= FATTR4_WORD1_TIME_CREATE;
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index e8ac3f615f93..5f0d08b500ef 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1623,6 +1623,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			| FATTR4_WORD1_RAWDEV
 			| FATTR4_WORD1_SPACE_USED
 			| FATTR4_WORD1_TIME_ACCESS
+			| FATTR4_WORD1_TIME_CREATE
 			| FATTR4_WORD1_TIME_METADATA
 			| FATTR4_WORD1_TIME_MODIFY;
 		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
@@ -4207,6 +4208,24 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
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
@@ -4781,6 +4800,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
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
index 7a058bd8c566..f49f064c5ee5 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -32,7 +32,8 @@
 			{ NFS_INO_INVALID_BLOCKS, "INVALID_BLOCKS" }, \
 			{ NFS_INO_INVALID_XATTR, "INVALID_XATTR" }, \
 			{ NFS_INO_INVALID_NLINK, "INVALID_NLINK" }, \
-			{ NFS_INO_INVALID_MODE, "INVALID_MODE" })
+			{ NFS_INO_INVALID_MODE, "INVALID_MODE" }, \
+			{ NFS_INO_INVALID_BTIME, "INVALID_BTIME" })
 
 #define nfs_show_nfsi_flags(v) \
 	__print_flags(v, "|", \
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 67ae2c3f41d2..5cc5f7f02887 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -160,6 +160,12 @@ struct nfs_inode {
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
@@ -316,6 +322,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
 #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
+#define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index b7b06f0d2fb9..2fd7890214df 100644
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
2.47.0


