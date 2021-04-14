Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1486135F538
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351575AbhDNNoj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351614AbhDNNoZ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC5EE611B0
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407844;
        bh=dY1TAALyeP8SE0xKxibXz1C+F7HcSHRO0NJpJMGsXng=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=obmCAAv+sm2QmfYFPT+RDI7QDwtX/hOAXM3olhXESIx3OXq88kQVTErc17cYnVeDk
         eoiJAA0AJy9/Sha54huNCPwXSyk15HcuGtY67TiVcFMHdAZnTradn0nT+QbskfoF8c
         strNcpDE4gLs3UUQMlgw5OmmtMIw3BaxAEUKyi+w1nV0KI+BZOE1pTXTwPZbEVdZC6
         mZv++Svhxt9AWAvuv8yKlQpVGIV3GHOeTyPqkijacm1nzlkmIdSujxqlxRopI+M7I8
         Io/zPsrPkKVaTyE36vs3JIjsdWhjQiMiiSr2/Y57sWMQDluQ+TlSaCXCwqa4XPDlC/
         cPJrlT6S2aPRw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 20/26] NFSv4: Add support for the NFSv4.2 "change_attr_type" attribute
Date:   Wed, 14 Apr 2021 09:43:47 -0400
Message-Id: <20210414134353.11860-21-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210414134353.11860-20-trondmy@kernel.org>
References: <20210414134353.11860-1-trondmy@kernel.org>
 <20210414134353.11860-2-trondmy@kernel.org>
 <20210414134353.11860-3-trondmy@kernel.org>
 <20210414134353.11860-4-trondmy@kernel.org>
 <20210414134353.11860-5-trondmy@kernel.org>
 <20210414134353.11860-6-trondmy@kernel.org>
 <20210414134353.11860-7-trondmy@kernel.org>
 <20210414134353.11860-8-trondmy@kernel.org>
 <20210414134353.11860-9-trondmy@kernel.org>
 <20210414134353.11860-10-trondmy@kernel.org>
 <20210414134353.11860-11-trondmy@kernel.org>
 <20210414134353.11860-12-trondmy@kernel.org>
 <20210414134353.11860-13-trondmy@kernel.org>
 <20210414134353.11860-14-trondmy@kernel.org>
 <20210414134353.11860-15-trondmy@kernel.org>
 <20210414134353.11860-16-trondmy@kernel.org>
 <20210414134353.11860-17-trondmy@kernel.org>
 <20210414134353.11860-18-trondmy@kernel.org>
 <20210414134353.11860-19-trondmy@kernel.org>
 <20210414134353.11860-20-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The change_attr_type allows the server to provide a description of how
the change attribute will behave. This again will allow the client to
optimise its behaviour w.r.t. attribute revalidation.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/client.c           |  3 +++
 fs/nfs/nfs3xdr.c          |  1 +
 fs/nfs/nfs4proc.c         |  1 +
 fs/nfs/nfs4xdr.c          | 32 ++++++++++++++++++++++++++++++++
 fs/nfs/proc.c             |  1 +
 include/linux/nfs4.h      |  9 +++++++++
 include/linux/nfs_fs_sb.h |  3 +++
 include/linux/nfs_xdr.h   |  2 ++
 8 files changed, 52 insertions(+)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 399a8eb15397..2aeb4e52a4f1 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -792,6 +792,7 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 	server->maxfilesize = fsinfo->maxfilesize;
 
 	server->time_delta = fsinfo->time_delta;
+	server->change_attr_type = fsinfo->change_attr_type;
 
 	server->clone_blksize = fsinfo->clone_blksize;
 	/* We're airborne Set socket buffersize */
@@ -933,6 +934,8 @@ struct nfs_server *nfs_alloc_server(void)
 		return NULL;
 	}
 
+	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
+
 	ida_init(&server->openowner_id);
 	ida_init(&server->lockowner_id);
 	pnfs_init_server(server);
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index ed1c83738c30..83ad62c81fc7 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2227,6 +2227,7 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 
 	/* ignore properties */
 	result->lease_time = 0;
+	result->change_attr_type = NFS4_CHANGE_TYPE_IS_TIME_METADATA;
 	return 0;
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index bc90f2a12d5d..6992c88a25e7 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -264,6 +264,7 @@ const u32 nfs4_fsinfo_bitmap[3] = { FATTR4_WORD0_MAXFILESIZE
 			| FATTR4_WORD1_FS_LAYOUT_TYPES,
 			FATTR4_WORD2_LAYOUT_BLKSIZE
 			| FATTR4_WORD2_CLONE_BLKSIZE
+			| FATTR4_WORD2_CHANGE_ATTR_TYPE
 			| FATTR4_WORD2_XATTR_SUPPORT
 };
 
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index d8a1911dd39e..edac4718dec1 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -153,6 +153,7 @@ static int decode_layoutget(struct xdr_stream *xdr, struct rpc_rqst *req,
 				 5 /* fs layout types */ + \
 				 1 /* layout blksize */ + \
 				 1 /* clone blksize */ + \
+				 1 /* change attr type */ + \
 				 1 /* xattr support */)
 #define encode_renew_maxsz	(op_encode_hdr_maxsz + 3)
 #define decode_renew_maxsz	(op_decode_hdr_maxsz)
@@ -4846,6 +4847,32 @@ static int decode_attr_clone_blksize(struct xdr_stream *xdr, uint32_t *bitmap,
 	return 0;
 }
 
+static int decode_attr_change_attr_type(struct xdr_stream *xdr,
+					uint32_t *bitmap,
+					enum nfs4_change_attr_type *res)
+{
+	u32 tmp = NFS4_CHANGE_TYPE_IS_UNDEFINED;
+
+	dprintk("%s: bitmap is %x\n", __func__, bitmap[2]);
+	if (bitmap[2] & FATTR4_WORD2_CHANGE_ATTR_TYPE) {
+		if (xdr_stream_decode_u32(xdr, &tmp))
+			return -EIO;
+		bitmap[2] &= ~FATTR4_WORD2_CHANGE_ATTR_TYPE;
+	}
+
+	switch(tmp) {
+	case NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR:
+	case NFS4_CHANGE_TYPE_IS_VERSION_COUNTER:
+	case NFS4_CHANGE_TYPE_IS_VERSION_COUNTER_NOPNFS:
+	case NFS4_CHANGE_TYPE_IS_TIME_METADATA:
+		*res = tmp;
+		break;
+	default:
+		*res = NFS4_CHANGE_TYPE_IS_UNDEFINED;
+	}
+	return 0;
+}
+
 static int decode_fsinfo(struct xdr_stream *xdr, struct nfs_fsinfo *fsinfo)
 {
 	unsigned int savep;
@@ -4894,6 +4921,11 @@ static int decode_fsinfo(struct xdr_stream *xdr, struct nfs_fsinfo *fsinfo)
 	if (status)
 		goto xdr_error;
 
+	status = decode_attr_change_attr_type(xdr, bitmap,
+					      &fsinfo->change_attr_type);
+	if (status)
+		goto xdr_error;
+
 	status = decode_attr_xattrsupport(xdr, bitmap,
 					  &fsinfo->xattr_support);
 	if (status)
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 73ab7c59d3a7..ea19dbf12301 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -91,6 +91,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
 	info->dtpref = fsinfo.tsize;
 	info->maxfilesize = 0x7FFFFFFF;
 	info->lease_time = 0;
+	info->change_attr_type = NFS4_CHANGE_TYPE_IS_TIME_METADATA;
 	return 0;
 }
 
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 5b4c67c91f56..15004c469807 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -452,6 +452,7 @@ enum lock_type4 {
 #define FATTR4_WORD2_LAYOUT_BLKSIZE     (1UL << 1)
 #define FATTR4_WORD2_MDSTHRESHOLD       (1UL << 4)
 #define FATTR4_WORD2_CLONE_BLKSIZE	(1UL << 13)
+#define FATTR4_WORD2_CHANGE_ATTR_TYPE	(1UL << 15)
 #define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
 #define FATTR4_WORD2_MODE_UMASK		(1UL << 17)
 #define FATTR4_WORD2_XATTR_SUPPORT	(1UL << 18)
@@ -709,6 +710,14 @@ struct nl4_server {
 	} u;
 };
 
+enum nfs4_change_attr_type {
+	NFS4_CHANGE_TYPE_IS_MONOTONIC_INCR = 0,
+	NFS4_CHANGE_TYPE_IS_VERSION_COUNTER = 1,
+	NFS4_CHANGE_TYPE_IS_VERSION_COUNTER_NOPNFS = 2,
+	NFS4_CHANGE_TYPE_IS_TIME_METADATA = 3,
+	NFS4_CHANGE_TYPE_IS_UNDEFINED = 4,
+};
+
 /*
  * Options for setxattr. These match the flags for setxattr(2).
  */
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 6f76b32a0238..fbcdfd9f7a7f 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -180,6 +180,9 @@ struct nfs_server {
 #define NFS_OPTION_FSCACHE	0x00000001	/* - local caching enabled */
 #define NFS_OPTION_MIGRATION	0x00000002	/* - NFSv4 migration enabled */
 
+	enum nfs4_change_attr_type
+				change_attr_type;/* Description of change attribute */
+
 	struct nfs_fsid		fsid;
 	__u64			maxfilesize;	/* maximum file size */
 	struct timespec64	time_delta;	/* smallest time granularity */
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index cc29dee508f7..717ecc87c9e7 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -152,6 +152,8 @@ struct nfs_fsinfo {
 	__u32			layouttype[NFS_MAX_LAYOUT_TYPES]; /* supported pnfs layout driver */
 	__u32			blksize; /* preferred pnfs io block size */
 	__u32			clone_blksize; /* granularity of a CLONE operation */
+	enum nfs4_change_attr_type
+				change_attr_type; /* Info about change attr */
 	__u32			xattr_support; /* User xattrs supported */
 };
 
-- 
2.30.2

