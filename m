Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD564795D3
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237401AbhLQUzF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237288AbhLQUzE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:55:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64560C06173E
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 12:55:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0373E623C8
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FA7C36AEC;
        Fri, 17 Dec 2021 20:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639774503;
        bh=oyq6hF0r5XOT4VRw3Gj5irBCLCxdn86r1NVUPaKx7ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MM5l/6n35YTuhqWftmMTemqpsn1QZktO61CG3CYQy8NJKIHDUw6OXJ8o6NQ3FTxaK
         OddNJTXObUPH9wcxxi+lFeYuomzgNWRSgS9N5Ue4CyrX9NLQIJSE6IYu9mnPWYttX1
         rkfNRQOnMAIlUxtfecUqhOFXiAuU8/lM7Ggo2ekZO9QsaMJjiuyoiJWbZpr0qYETip
         gUecs78e+VhEqQCY7cSkGnJS+MezGbF5X6ohJ1/VU255Y9lB5ead4dhc3JcooNlxx1
         KtRZwg+Y8zvCnnwDPzkyfC5+Zoy2aHhL8t8PQy3sT3xz6eCCO11vCdvxcu56PSlzIb
         Oa02dHQegmfVA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/8] NFSv4: Support the offline bit
Date:   Fri, 17 Dec 2021 15:48:52 -0500
Message-Id: <20211217204854.439578-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217204854.439578-6-trondmy@kernel.org>
References: <20211217204854.439578-1-trondmy@kernel.org>
 <20211217204854.439578-2-trondmy@kernel.org>
 <20211217204854.439578-3-trondmy@kernel.org>
 <20211217204854.439578-4-trondmy@kernel.org>
 <20211217204854.439578-5-trondmy@kernel.org>
 <20211217204854.439578-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Add tracking of the NFSv4 'offline' attribute.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c          | 11 +++++++++++
 fs/nfs/nfs4proc.c       |  6 ++++++
 fs/nfs/nfs4trace.h      |  3 ++-
 fs/nfs/nfs4xdr.c        | 31 ++++++++++++++++++++++++++++++-
 include/linux/nfs4.h    |  1 +
 include/linux/nfs_fs.h  |  1 +
 include/linux/nfs_xdr.h |  5 ++++-
 7 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4673b091ea31..33f4410190b6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -528,6 +528,7 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		nfsi->archive = 0;
 		nfsi->hidden = 0;
 		nfsi->system = 0;
+		nfsi->offline = 0;
 		inode_set_iversion_raw(inode, 0);
 		inode->i_size = 0;
 		clear_nlink(inode);
@@ -606,6 +607,10 @@ nfs_fhget(struct super_block *sb, struct nfs_fh *fh, struct nfs_fattr *fattr)
 		} else if (fattr_supported & NFS_ATTR_FATTR_SPACE_USED &&
 			   fattr->size != 0)
 			nfs_set_cache_invalid(inode, NFS_INO_INVALID_BLOCKS);
+		if (fattr->valid & NFS_ATTR_FATTR_OFFLINE)
+			nfsi->offline = (fattr->hsa_flags & NFS_HSA_OFFLINE) ? 1 : 0;
+		else if (fattr_supported & NFS_ATTR_FATTR_OFFLINE)
+			nfs_set_cache_invalid(inode, NFS_INO_INVALID_WINATTR);
 
 		nfs_setsecurity(inode, fattr);
 
@@ -2274,6 +2279,12 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
 		nfsi->cache_validity |=
 			save_cache_validity & NFS_INO_INVALID_BLOCKS;
 
+	if (fattr->valid & NFS_ATTR_FATTR_OFFLINE)
+		nfsi->offline = (fattr->hsa_flags & NFS_HSA_OFFLINE) ? 1 : 0;
+	else if (fattr_supported & NFS_ATTR_FATTR_OFFLINE)
+		nfsi->cache_validity |=
+			save_cache_validity & NFS_INO_INVALID_WINATTR;
+
 	/* Update attrtimeo value if we're out of the unstable period */
 	if (attr_changed) {
 		nfs_inc_stats(inode, NFSIOS_ATTRINVALIDATE);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index d3a528a4c9b7..d497616ca149 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -218,6 +218,7 @@ const u32 nfs4_fattr_bitmap[3] = {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	FATTR4_WORD2_SECURITY_LABEL
 #endif
+	| FATTR4_WORD2_OFFLINE
 };
 
 static const u32 nfs4_pnfs_open_bitmap[3] = {
@@ -244,6 +245,7 @@ static const u32 nfs4_pnfs_open_bitmap[3] = {
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 	| FATTR4_WORD2_SECURITY_LABEL
 #endif
+	| FATTR4_WORD2_OFFLINE
 };
 
 static const u32 nfs4_open_noattr_bitmap[3] = {
@@ -324,6 +326,7 @@ static void nfs4_bitmap_copy_adjust(__u32 *dst, const __u32 *src,
 	if (!(cache_validity & NFS_INO_INVALID_WINATTR)) {
 		dst[0] &= ~(FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN);
 		dst[1] &= ~(FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_BACKUP);
+		dst[2] &= ~FATTR4_WORD2_OFFLINE;
 	}
 }
 
@@ -3927,6 +3930,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
+		if (!(res.attr_bitmask[2] & FATTR4_WORD2_OFFLINE))
+			server->fattr_valid &= ~NFS_ATTR_FATTR_OFFLINE;
 
 		memcpy(server->cache_consistency_bitmask, res.attr_bitmask, sizeof(server->cache_consistency_bitmask));
 		server->cache_consistency_bitmask[0] &= FATTR4_WORD0_CHANGE|FATTR4_WORD0_SIZE;
@@ -5484,6 +5489,7 @@ static void nfs4_bitmask_set(__u32 bitmask[NFS4_BITMASK_SZ], const __u32 *src,
 	if (cache_validity & NFS_INO_INVALID_WINATTR) {
 		bitmask[0] |= FATTR4_WORD0_ARCHIVE | FATTR4_WORD0_HIDDEN;
 		bitmask[1] |= FATTR4_WORD1_SYSTEM | FATTR4_WORD1_TIME_BACKUP;
+		bitmask[2] |= FATTR4_WORD2_OFFLINE;
 	}
 
 	if (cache_validity & NFS_INO_INVALID_SIZE)
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 5e72639b469e..02c78d66c36d 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -35,7 +35,8 @@
 		{ NFS_ATTR_FATTR_HIDDEN, "HIDDEN" }, \
 		{ NFS_ATTR_FATTR_SYSTEM, "SYSTEM" }, \
 		{ NFS_ATTR_FATTR_ARCHIVE, "ARCHIVE" }, \
-		{ NFS_ATTR_FATTR_TIME_BACKUP, "TIME_BACKUP" })
+		{ NFS_ATTR_FATTR_TIME_BACKUP, "TIME_BACKUP" }, \
+		{ NFS_ATTR_FATTR_OFFLINE, "OFFLINE" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 68885ba5fc58..d2c240effc87 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1623,7 +1623,7 @@ static void encode_readdir(struct xdr_stream *xdr, const struct nfs4_readdir_arg
 			    FATTR4_WORD1_TIME_CREATE |
 			    FATTR4_WORD1_TIME_METADATA |
 			    FATTR4_WORD1_TIME_MODIFY;
-		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL;
+		attrs[2] |= FATTR4_WORD2_SECURITY_LABEL | FATTR4_WORD2_OFFLINE;
 		dircount >>= 1;
 	}
 	/* Use mounted_on_fileid only if the server supports it */
@@ -4353,6 +4353,29 @@ static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
+static int decode_attr_offline(struct xdr_stream *xdr, uint32_t *bitmap,
+			       uint32_t *res, uint64_t *flags)
+{
+	int status = 0;
+	__be32 *p;
+
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_OFFLINE - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_OFFLINE)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		if (be32_to_cpup(p))
+			*res |= NFS_HSA_OFFLINE;
+		else
+			*res &= ~NFS_HSA_OFFLINE;
+		bitmap[2] &= ~FATTR4_WORD2_OFFLINE;
+		*flags |= NFS_ATTR_FATTR_OFFLINE;
+	}
+	dprintk("%s: system file: =%s\n", __func__, (*res & NFS_HSA_OFFLINE) == 0 ? "false" : "true");
+	return status;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4841,6 +4864,12 @@ static int decode_getfattr_attrs(struct xdr_stream *xdr, uint32_t *bitmap,
 		fattr->valid |= status;
 	}
 
+	status = decode_attr_offline(xdr, bitmap, &fattr->hsa_flags,
+				     &fattr->valid);
+	if (status < 0)
+		goto xdr_error;
+
+	status = 0;
 xdr_error:
 	dprintk("%s: xdr returned %d\n", __func__, -status);
 	return status;
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 5662d8be04eb..817b349c24ca 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -460,6 +460,7 @@ enum lock_type4 {
 #define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
 #define FATTR4_WORD2_MODE_UMASK		(1UL << 17)
 #define FATTR4_WORD2_XATTR_SUPPORT	(1UL << 18)
+#define FATTR4_WORD2_OFFLINE		(1UL << 19)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5f1dbd7a7b69..058fc11338d9 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -146,6 +146,7 @@ struct nfs_inode {
 	unsigned char		archive : 1;
 	unsigned char		hidden : 1;
 	unsigned char		system : 1;
+	unsigned char		offline : 1;
 
 	/*
 	 * read_cache_jiffies is when we started read-caching this inode.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 69c19f465571..0d5b11c1bfec 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -21,6 +21,7 @@
 #define NFS_HSA_HIDDEN		BIT(0)
 #define NFS_HSA_SYSTEM		BIT(1)
 #define NFS_HSA_ARCHIVE		BIT(2)
+#define NFS_HSA_OFFLINE		BIT(3)
 
 struct nfs4_string {
 	unsigned int len;
@@ -119,6 +120,7 @@ struct nfs_fattr {
 #define NFS_ATTR_FATTR_SYSTEM           BIT_ULL(28)
 #define NFS_ATTR_FATTR_ARCHIVE          BIT_ULL(29)
 #define NFS_ATTR_FATTR_TIME_BACKUP      BIT_ULL(30)
+#define NFS_ATTR_FATTR_OFFLINE          BIT_ULL(31)
 
 #define NFS_ATTR_FATTR (NFS_ATTR_FATTR_TYPE \
 		| NFS_ATTR_FATTR_MODE \
@@ -144,7 +146,8 @@ struct nfs_fattr {
 		| NFS_ATTR_FATTR_SYSTEM \
 		| NFS_ATTR_FATTR_ARCHIVE \
 		| NFS_ATTR_FATTR_TIME_BACKUP \
-		| NFS_ATTR_FATTR_V4_SECURITY_LABEL)
+		| NFS_ATTR_FATTR_V4_SECURITY_LABEL \
+		| NFS_ATTR_FATTR_OFFLINE)
 
 /*
  * Maximal number of supported layout drivers.
-- 
2.33.1

