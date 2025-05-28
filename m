Return-Path: <linux-nfs+bounces-11945-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F3AC69BD
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 14:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F23329E6C92
	for <lists+linux-nfs@lfdr.de>; Wed, 28 May 2025 12:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A966E2857CB;
	Wed, 28 May 2025 12:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGyQ+R6E"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638E2857E4
	for <linux-nfs@vger.kernel.org>; Wed, 28 May 2025 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436614; cv=none; b=EBWgQyagvK3dgyK4A60kWI30eUfHC2wrpzSFXdls7nVY7bXiAlrg+SeONEk1HEyKxKv9nvPTXXQPu1szuSUKvTU1KvDV7xFkkuvvhwEpzYtamNO9WRrZmHyu8R63rc6BeAaG+M9a3WrqpKSzX5fGNCTdSMUfTN90sqGLqb95CBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436614; c=relaxed/simple;
	bh=I4RMVu6Ti/D+9WI0pGJhAmM/ugg2E9hH3CJv1G0OgUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILLPr4I0HWA5vqqeZYbtUGpPwvXK2d3ARuLEZZFfum6/rH1YicAfus14R+21lQwYevCqevriOItbJs1fLkPVhRI2O4Jc4lSpsGHRMQPQo2xGxExqB0iVmd2tK9N+UvlZdipgTgwLugsfxWsLMwHLGxWzR5lhS4l6OAPrlAVtd08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IGyQ+R6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748436611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akeR25cIFDqSle9qc4PQKFD0iqjn2GsYnh8JVKrZZ2E=;
	b=IGyQ+R6E8Liw4PQeLMOMrjqZjJJboje9UmjmWGL/J7pEZfqFQPA4K5CFNghD6nt0S4NJz/
	9KsozNTgXKa+8zF/4CoSgW8CJ6ZECjNgHODY3d+GUE8GEj24tWyT3ikdvtxTJO+AyF7mdn
	ZBpV6+sijMuAhN7/Btjzp8AVUY5v5Nw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-KS3j4VCSPqC0UhiwxiIS6A-1; Wed,
 28 May 2025 08:50:08 -0400
X-MC-Unique: KS3j4VCSPqC0UhiwxiIS6A-1
X-Mimecast-MFC-AGG-ID: KS3j4VCSPqC0UhiwxiIS6A_1748436607
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA53F195608E;
	Wed, 28 May 2025 12:50:06 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.2])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 889B01956095;
	Wed, 28 May 2025 12:50:05 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 2/3] nfs: Add timecreate to nfs inode
Date: Wed, 28 May 2025 08:50:00 -0400
Message-ID: <ee8d37a7b6495e95aa2875241e2962d41e57dc14.1748436487.git.bcodding@redhat.com>
In-Reply-To: <cover.1748436487.git.bcodding@redhat.com>
References: <cover.1748436487.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Anne Marie Merritt <annemarie.merritt@primarydata.com>

Add tracking of the create time (a.k.a. btime) along with corresponding
bitfields, request, and decode xdr routines.

Signed-off-by: Anne Marie Merritt <annemarie.merritt@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c          | 28 ++++++++++++++++++++++------
 fs/nfs/nfs4proc.c       | 14 +++++++++++++-
 fs/nfs/nfs4xdr.c        | 24 ++++++++++++++++++++++++
 fs/nfs/nfstrace.h       |  3 ++-
 include/linux/nfs_fs.h  |  7 +++++++
 include/linux/nfs_xdr.h |  3 +++
 6 files changed, 71 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 160f3478a835..fd84c24963b3 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -197,6 +197,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
+				   NFS_INO_INVALID_BTIME |
 				   NFS_INO_INVALID_XATTR);
 		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 	}
@@ -522,6 +523,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode_set_atime(inode, 0, 0);
 		inode_set_mtime(inode, 0, 0);
 		inode_set_ctime(inode, 0, 0);
+		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -545,6 +547,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
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
@@ -1900,7 +1906,7 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
 		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
-		NFS_INO_INVALID_NLINK;
+		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
 	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
@@ -2219,10 +2225,13 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
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
@@ -2261,7 +2270,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_MODE
-					| NFS_INO_INVALID_OTHER;
+					| NFS_INO_INVALID_OTHER
+					| NFS_INO_INVALID_BTIME;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
 				attr_changed = true;
@@ -2295,6 +2305,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
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
index b1d2122bd5a7..f7fb61f805a3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -222,6 +222,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
@@ -243,6 +244,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
 	| FATTR4_WORD1_TIME_ACCESS
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY,
 	FATTR4_WORD2_MDSTHRESHOLD
@@ -323,6 +325,9 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!(cache_validity & NFS_INO_INVALID_OTHER))
 		dst[1] &= ~(FATTR4_WORD1_OWNER | FATTR4_WORD1_OWNER_GROUP);
 
+	if (!(cache_validity & NFS_INO_INVALID_BTIME))
+		dst[1] &= ~FATTR4_WORD1_TIME_CREATE;
+
 	if (nfs_have_delegated_mtime(inode)) {
 		if (!(cache_validity & NFS_INO_INVALID_ATIME))
 			dst[1] &= ~FATTR4_WORD1_TIME_ACCESS;
@@ -1307,7 +1312,8 @@ nfs4_update_changeattr_locked(struct inode *inode,
 				NFS_INO_INVALID_ACCESS | NFS_INO_INVALID_ACL |
 				NFS_INO_INVALID_SIZE | NFS_INO_INVALID_OTHER |
 				NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_NLINK |
-				NFS_INO_INVALID_MODE | NFS_INO_INVALID_XATTR;
+				NFS_INO_INVALID_MODE | NFS_INO_INVALID_BTIME |
+				NFS_INO_INVALID_XATTR;
 		nfsi->attrtimeo = NFS_MINATTRTIMEO(inode);
 	}
 	nfsi->attrtimeo_timestamp = jiffies;
@@ -4047,6 +4053,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
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
@@ -5773,6 +5783,8 @@ void nfs4_bitmask_set(__u32 bitmask[], const __u32 src[],
 		bitmask[1] |= FATTR4_WORD1_TIME_MODIFY;
 	if (cache_validity & NFS_INO_INVALID_BLOCKS)
 		bitmask[1] |= FATTR4_WORD1_SPACE_USED;
+	if (cache_validity & NFS_INO_INVALID_BTIME)
+		bitmask[1] |= FATTR4_WORD1_TIME_CREATE;
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
 		bitmask[0] |= FATTR4_WORD0_SIZE;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 55bef5fbfa47..f8d019c9d58d 100644
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
index 9cacbbd14787..ac4bff6e9913 100644
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


