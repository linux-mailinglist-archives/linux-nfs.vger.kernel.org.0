Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9501783D76
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234558AbjHVKAg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 06:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjHVKAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 06:00:31 -0400
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4DD1A1
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 03:00:28 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="128847088"
X-IronPort-AV: E=Sophos;i="6.01,192,1684767600"; 
   d="scan'208";a="128847088"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 19:00:26 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 48A49DE62D
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 19:00:24 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6E770BF4A5
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 19:00:23 +0900 (JST)
Received: from G08FNSTD200033.g08.fujitsu.local (unknown [10.167.225.189])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id C4DB620050190;
        Tue, 22 Aug 2023 19:00:19 +0900 (JST)
From:   Chen Hanxiao <chenhx.fnst@fujitsu.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, Chen Hanxiao <chenhx.fnst@fujitsu.com>
Subject: [RFC PATCH v1.1] nfs: Add support for the birth time attribute
Date:   Tue, 22 Aug 2023 18:00:08 +0800
Message-Id: <20230822100008.1942-1-chenhx.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27828.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27828.005
X-TMASE-Result: 10--13.898900-10.000000
X-TMASE-MatchedRID: ZAkTtSyZ7B4kinkyECdW86oXHZz/dXlx1QQ6Jx/fflZxwW4lAqHnHnw6
        H06bMgivjx5X3FdI4UDmn3xyPJAJoh2P280ZiGmRupDIC9422DqZIt4iAQN6P8H0F6hf9KOr+oA
        N6qKcRV/vOPZOIImsUf0bVLkspps2U6K87V98CkTkbaItvRsDdhUgYNic7ed6d2O5KVSlq58l47
        Z7tpcJi06bXwaM1dBVXZAaaV0ZMrrOjw1+OFXGOfgWrMZvbmeHkKAa/khZ3iT2apmI5+Nrz0+R2
        5DV/fo6HSfhHeW9DZhl3tpAIdU89B8TzIzimOwPC24oEZ6SpSkj80Za3RRg8JX4RKcG21dOzqyV
        lh5UgA4EjRr0Mk0ePuDN5fAj/cKp1PYfTfPNTUk=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfsd already support btime by:
commit e377a3e698fb ("nfsd: Add support for the birth time attribute")

This patch enable nfs to report btime in nfs_getattr.
If underlying filesystem supports "btime" timestamp,
statx will report btime for STATX_BTIME.

Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>

---
1.1:
	minor fix

 fs/nfs/inode.c          | 14 +++++++++++++-
 fs/nfs/nfs4proc.c       |  3 +++
 fs/nfs/nfs4xdr.c        | 23 +++++++++++++++++++++++
 include/linux/nfs_fs.h  |  2 ++
 include/linux/nfs_xdr.h |  2 ++
 5 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 8172dd4135a1..36e322b993f8 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -835,6 +835,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct nfs_server *server = NFS_SERVER(inode);
+	struct nfs_inode *nfsi = NFS_I(inode);
 	unsigned long cache_validity;
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
@@ -845,7 +846,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
 			STATX_CHANGE_COOKIE;
 
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
@@ -911,6 +912,10 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 out_no_revalidate:
 	/* Only return attributes that were revalidated. */
 	stat->result_mask = nfs_get_valid_attrmask(inode) | request_mask;
+	if (nfsi->btime.tv_sec == 0 && nfsi->btime.tv_nsec == 0)
+		stat->result_mask &= ~STATX_BTIME;
+	else
+		stat->btime = nfsi->btime;
 
 	generic_fillattr(&nop_mnt_idmap, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
@@ -2189,6 +2194,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_MTIME;
 
+	if (fattr->valid & NFS_ATTR_FATTR_BTIME) {
+		nfsi->btime = fattr->btime;
+	} else if (fattr_supported & NFS_ATTR_FATTR_BTIME)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_BTIME;
+
 	if (fattr->valid & NFS_ATTR_FATTR_CTIME)
 		inode->i_ctime = fattr->ctime;
 	else if (fattr_supported & NFS_ATTR_FATTR_CTIME)
@@ -2332,6 +2343,7 @@ struct inode *nfs_alloc_inode(struct super_block *sb)
 #endif /* CONFIG_NFS_V4 */
 #ifdef CONFIG_NFS_V4_2
 	nfsi->xattr_cache = NULL;
+	memset(&nfsi->btime, 0, sizeof(nfsi->btime));
 #endif
 	nfs_netfs_inode_init(nfsi);
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e1a886b58354..c4717ae4b1b3 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -211,6 +211,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 	| FATTR4_WORD1_TIME_ACCESS
 	| FATTR4_WORD1_TIME_METADATA
 	| FATTR4_WORD1_TIME_MODIFY
+	| FATTR4_WORD1_TIME_CREATE
 	| FATTR4_WORD1_MOUNTED_ON_FILEID,
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	FATTR4_WORD2_SECURITY_LABEL
@@ -3909,6 +3910,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->fattr_valid &= ~NFS_ATTR_FATTR_CTIME;
 		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_MODIFY))
 			server->fattr_valid &= ~NFS_ATTR_FATTR_MTIME;
+		if (!(res.attr_bitmask[1] & FATTR4_WORD1_TIME_CREATE))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_BTIME;
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index deec76cf5afe..df3699eb29e8 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4171,6 +4171,24 @@ static int decode_attr_time_access(struct xdr_stream *xdr, uint32_t *bitmap, str
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
@@ -4730,6 +4748,11 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
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
index 279262057a92..ba8c1872494d 100644
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
index 12bbb5c63664..8e90c5bbf5e4 100644
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
+#define NFS_ATTR_FATTR_BTIME		(1U << 26)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
-- 
2.39.1

