Return-Path: <linux-nfs+bounces-1083-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDBF82D43F
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jan 2024 07:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771D21F2140A
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jan 2024 06:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A51FB9;
	Mon, 15 Jan 2024 06:36:54 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017891FAE
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jan 2024 06:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="147791186"
X-IronPort-AV: E=Sophos;i="6.04,196,1695654000"; 
   d="scan'208";a="147791186"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 15:36:42 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 8520CCD6C4
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jan 2024 15:36:39 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7D0FD5E92
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jan 2024 15:36:38 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3C58E2009356E
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jan 2024 15:36:38 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id AF8141A0070;
	Mon, 15 Jan 2024 14:36:37 +0800 (CST)
From: Chen Hanxiao <chenhx.fnst@fujitsu.com>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nfsv4: Add support for the birth time attribute
Date: Mon, 15 Jan 2024 14:36:05 +0800
Message-Id: <20240115063605.2064-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28120.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28120.005
X-TMASE-Result: 10--13.573500-10.000000
X-TMASE-MatchedRID: ZAkTtSyZ7B4/TqR73SoO8x7hLNOPFFWidwX/SSKrKHg6FHRWx2FGsL8F
	Hrw7frluf146W0iUu2vw/CbUDQShN2Io6q3zeo5w30kDaWZBE1QzNsXWBvGVBhBGKTr4ntdJQZq
	Ch5MOmv9yMEK6R2LbV8kSA2eefiegV3KFBhdtw96LzZSKyQypzBgff28UuvIT592Swrd60UktVh
	jze+XbSGn6Ojp4JK5FfFQVW2R7K7tas3j/nymmYpGA/MAGSrEgqlbwyoD3QbVShcWO/83xoh2rr
	Ge8rZbLBSYZqXrR7v0eYZj+jjPzyR8TzIzimOwPC24oEZ6SpSkj80Za3RRg8IqfLZCGs+WFlbn6
	dGjAhdKtme1YzFFyKGSq7JlySKMH7QNVOk9sE+s=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

This patch enable nfs to report btime in nfs_getattr.
If underlying filesystem supports "btime" timestamp,
statx will report btime for STATX_BTIME.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
---
v1:
    Don't revalidate btime attribute

RFC v2:
    properly set cache validity

 fs/nfs/inode.c          | 23 ++++++++++++++++++++---
 fs/nfs/nfs4proc.c       |  3 +++
 fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
 include/linux/nfs_fs.h  |  2 ++
 include/linux/nfs_xdr.h |  5 ++++-
 5 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index ebb8d60e1152..e8b06f508cc0 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -196,6 +196,7 @@ void nfs_set_cache_invalid(struct inode *inode, unsigned long flags)
 		if (!(flags & NFS_INO_REVAL_FORCED))
 			flags &= ~(NFS_INO_INVALID_MODE |
 				   NFS_INO_INVALID_OTHER |
+				   NFS_INO_INVALID_BTIME |
 				   NFS_INO_INVALID_XATTR);
 		flags &= ~(NFS_INO_INVALID_CHANGE | NFS_INO_INVALID_SIZE);
 	}
@@ -515,6 +516,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		inode_set_atime(inode, 0, 0);
 		inode_set_mtime(inode, 0, 0);
 		inode_set_ctime(inode, 0, 0);
+		memset(&nfsi->btime, 0, sizeof(nfsi->btime));
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -538,6 +540,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 			inode_set_ctime_to_ts(inode, fattr->ctime);
 		else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_CTIME);
+		if (fattr->valid & NFS_ATTR_FATTR_V4_BTIME)
+			nfsi->btime = fattr->btime;
+		else if (fattr_supported & NFS_ATTR_FATTR_V4_BTIME)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BTIME);
 		if (fattr->valid & NFS_ATTR_FATTR_CHANGE)
 			inode_set_iversion_raw(inode, fattr->change_attr);
 		else
@@ -835,6 +841,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs_inode *nfsi = NFS_I(inode);
 	unsigned long cache_validity;
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
@@ -845,7 +852,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
 			STATX_CHANGE_COOKIE;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
@@ -920,6 +927,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_CHANGE_MONOTONIC;
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
+	if (!(server->fattr_valid & NFS_ATTR_FATTR_V4_BTIME))
+		stat->result_mask &= ~STATX_BTIME;
+	else
+		stat->btime = nfsi->btime;
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
@@ -1803,7 +1814,7 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_ATIME | NFS_INO_INVALID_CTIME |
 		NFS_INO_INVALID_MTIME | NFS_INO_INVALID_SIZE |
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
-		NFS_INO_INVALID_NLINK;
+		NFS_INO_INVALID_NLINK | NFS_INO_INVALID_BTIME;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
 	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
@@ -2122,7 +2133,8 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 	nfsi->cache_validity &= ~(NFS_INO_INVALID_ATTR
 			| NFS_INO_INVALID_ATIME
 			| NFS_INO_REVAL_FORCED
-			| NFS_INO_INVALID_BLOCKS);
+			| NFS_INO_INVALID_BLOCKS
+			| NFS_INO_INVALID_BTIME);
 
 	/* Do atomic weak cache consistency updates */
 	nfs_wcc_update_inode(inode, fattr);
@@ -2161,6 +2173,7 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 					| NFS_INO_INVALID_BLOCKS
 					| NFS_INO_INVALID_NLINK
 					| NFS_INO_INVALID_MODE
+					| NFS_INO_INVALID_BTIME
 					| NFS_INO_INVALID_OTHER;
 				if (S_ISDIR(inode->i_mode))
 					nfs_force_lookup_revalidate(inode);
@@ -2189,6 +2202,9 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MTIME;
 
+	if (fattr->valid & NFS_ATTR_FATTR_V4_BTIME)
+		nfsi->btime = fattr->btime;
+
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
 		inode_set_ctime_to_ts(inode, fattr->ctime);
 	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
@@ -2332,6 +2348,7 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #endif /* CONFIG_NFS_V4 */
 #ifdef CONFIG_NFS_V4_2
 	nfsi->xattr_cache = NULL;
+	memset(&nfsi->btime, 0, sizeof(nfsi->btime));
 #endif
 	nfs_netfs_inode_init(nfsi);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 23819a756508..e151f7e0361c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -212,6 +212,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_TIME_ACCESS
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	FATTR4_WORD2_SECURITY_LABEL
@@ -3940,6 +3941,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->fattr_valid &= ~NFS_ATTR_FATTR_CTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_V4_BTIME;
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 69406e60f391..df178519fb29 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4180,6 +4180,24 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
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
+			status = NFS_ATTR_FATTR_V4_BTIME;
+		bitmap[1] &= ~FATTR4_WORD1_TIME_CREATE;
+	}
+	dprintk("%s: btime=%lld\n", __func__, time->tv_sec);
+	return status;
+}
+
 static int decode_attr_time_metadata(struct xdr_stream *xdr, uint32_t *bitmap, struct timespec64 *time)
 {
 	int status = 0;
@@ -4739,6 +4757,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
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
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index f5ce7b101146..88cff15a8ee7 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -159,6 +159,7 @@ struct nfs_inode {
 	unsigned long		read_cache_jiffies;
 	unsigned long		attrtimeo;
 	unsigned long		attrtimeo_timestamp;
+	struct timespec64       btime;
 
 	unsigned long		attr_gencount;
 
@@ -298,6 +299,7 @@ struct nfs4_copy_state {
 #define NFS_INO_INVALID_XATTR	BIT(15)		/* xattrs are invalid */
 #define NFS_INO_INVALID_NLINK	BIT(16)		/* cached nlinks is invalid */
 #define NFS_INO_INVALID_MODE	BIT(17)		/* cached mode is invalid */
+#define NFS_INO_INVALID_BTIME	BIT(18)		/* cached btime is invalid */
 
 #define NFS_INO_INVALID_ATTR	(NFS_INO_INVALID_CHANGE \
 		| NFS_INO_INVALID_CTIME \
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 539b57fbf3ce..85911e216bc2 100644
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
 #define NFS_ATTR_FATTR_OWNER_NAME	(1U << 23)
 #define NFS_ATTR_FATTR_GROUP_NAME	(1U << 24)
 #define NFS_ATTR_FATTR_V4_SECURITY_LABEL (1U << 25)
+#define NFS_ATTR_FATTR_V4_BTIME		(1U << 26)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -126,7 +128,8 @@ struct nfs_fattr {
 		| NFS_ATTR_FATTR_SPACE_USED)
 #define NFS_ATTR_FATTR_V4 (NFS_ATTR_FATTR \
 		| NFS_ATTR_FATTR_SPACE_USED \
-		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
+		| NFS_ATTR_FATTR_V4_SECURITY_LABEL \
+		| NFS_ATTR_FATTR_V4_BTIME)
 
 /*
  * Maximal number of supported layout drivers.
-- 
2.39.1


