Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9472A47959F
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 21:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbhLQUnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 17 Dec 2021 15:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240881AbhLQUnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 17 Dec 2021 15:43:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ECFC061746
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 12:43:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 586EAB827E0
        for <linux-nfs@vger.kernel.org>; Fri, 17 Dec 2021 20:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3DEC36AE8;
        Fri, 17 Dec 2021 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639773786;
        bh=NE6VwOBgFeyw5ddb6tXe+Nuiy4Dj6QfIFxb6X1h8r/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+GP9YStP8CdGMyae+8PRHgqVvYJz4/aC73ST+l1cUAEuwy+3mswBHywLx+TK5ro0
         0wMpWVUmcqG0WhCNOddI9OwT6l1vpknmF3rGOxQBbGnoE4r4C+HiOoF3DQDeaUHHpF
         pm2Rw/bCPJHbXmaBO2w65JL3XoOVQJS06dotD4j6vbH0vyoSgBRFof3mCxTueXyZ3m
         o0Z0D7ftazG+Px1U4p4w7itp1MzQxbz4pW5tdlh4iGA96ZG2JVKRP1FbH9bSzdSg3X
         ut12pYPGCgt+PLtYsBEsp0NBtCkr73LPe0S4bwDAdQmo0zLSwpyy9ngexMhZo7ZXMk
         jpcQrcaUvhlpg==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/5] NFSv4: Add some support for case insensitive filesystems
Date:   Fri, 17 Dec 2021 15:36:54 -0500
Message-Id: <20211217203658.439352-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217203658.439352-1-trondmy@kernel.org>
References: <20211217203658.439352-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Add capabilities to allow the NFS client to recognise when it is dealing
with case insensitive and case preserving filesystems.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c         |  8 +++++++-
 fs/nfs/nfs4xdr.c          | 40 +++++++++++++++++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  2 ++
 include/linux/nfs_xdr.h   |  2 ++
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 535436dbdc9a..422375149c7c 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3840,7 +3840,9 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		     FATTR4_WORD0_FH_EXPIRE_TYPE |
 		     FATTR4_WORD0_LINK_SUPPORT |
 		     FATTR4_WORD0_SYMLINK_SUPPORT |
-		     FATTR4_WORD0_ACLSUPPORT;
+		     FATTR4_WORD0_ACLSUPPORT |
+		     FATTR4_WORD0_CASE_INSENSITIVE |
+		     FATTR4_WORD0_CASE_PRESERVING;
 	if (minorversion)
 		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
 
@@ -3869,6 +3871,10 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			server->caps |= NFS_CAP_HARDLINKS;
 		if (res.has_symlinks != 0)
 			server->caps |= NFS_CAP_SYMLINKS;
+		if (res.case_insensitive)
+			server->caps |= NFS_CAP_CASE_INSENSITIVE;
+		if (res.case_preserving)
+			server->caps |= NFS_CAP_CASE_PRESERVING;
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 69862bf6db00..c7250645e8b4 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -3533,6 +3533,42 @@ static int decode_attr_aclsupport(struct xdr_stream *xdr, uint32_t *bitmap, uint
 	return 0;
 }
 
+static int decode_attr_case_insensitive(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	__be32 *p;
+
+	*res = 0;
+	if (unlikely(bitmap[0] & (FATTR4_WORD0_CASE_INSENSITIVE - 1U)))
+		return -EIO;
+	if (likely(bitmap[0] & FATTR4_WORD0_CASE_INSENSITIVE)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*res = be32_to_cpup(p);
+		bitmap[0] &= ~FATTR4_WORD0_CASE_INSENSITIVE;
+	}
+	dprintk("%s: case_insensitive=%s\n", __func__, *res == 0 ? "false" : "true");
+	return 0;
+}
+
+static int decode_attr_case_preserving(struct xdr_stream *xdr, uint32_t *bitmap, uint32_t *res)
+{
+	__be32 *p;
+
+	*res = 0;
+	if (unlikely(bitmap[0] & (FATTR4_WORD0_CASE_PRESERVING - 1U)))
+		return -EIO;
+	if (likely(bitmap[0] & FATTR4_WORD0_CASE_PRESERVING)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*res = be32_to_cpup(p);
+		bitmap[0] &= ~FATTR4_WORD0_CASE_PRESERVING;
+	}
+	dprintk("%s: case_preserving=%s\n", __func__, *res == 0 ? "false" : "true");
+	return 0;
+}
+
 static int decode_attr_fileid(struct xdr_stream *xdr, uint32_t *bitmap, uint64_t *fileid)
 {
 	__be32 *p;
@@ -4412,6 +4448,10 @@ static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_re
 		goto xdr_error;
 	if ((status = decode_attr_aclsupport(xdr, bitmap, &res->acl_bitmask)) != 0)
 		goto xdr_error;
+	if ((status = decode_attr_case_insensitive(xdr, bitmap, &res->case_insensitive)) != 0)
+		goto xdr_error;
+	if ((status = decode_attr_case_preserving(xdr, bitmap, &res->case_preserving)) != 0)
+		goto xdr_error;
 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
 				res->exclcreat_bitmask)) != 0)
 		goto xdr_error;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 2a9acbfe00f0..f24fc67af42d 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -271,6 +271,8 @@ struct nfs_server {
 #define NFS_CAP_ACLS		(1U << 3)
 #define NFS_CAP_ATOMIC_OPEN	(1U << 4)
 #define NFS_CAP_LGOPEN		(1U << 5)
+#define NFS_CAP_CASE_INSENSITIVE	(1U << 6)
+#define NFS_CAP_CASE_PRESERVING	(1U << 7)
 #define NFS_CAP_POSIX_LOCK	(1U << 14)
 #define NFS_CAP_UIDGID_NOMAP	(1U << 15)
 #define NFS_CAP_STATEID_NFSV41	(1U << 16)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 967a0098f0a9..1d1f77809d5e 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1194,6 +1194,8 @@ struct nfs4_server_caps_res {
 	u32				has_links;
 	u32				has_symlinks;
 	u32				fh_expire_type;
+	u32				case_insensitive;
+	u32				case_preserving;
 };
 
 #define NFS4_PATHNAME_MAXCOMPONENTS 512
-- 
2.33.1

