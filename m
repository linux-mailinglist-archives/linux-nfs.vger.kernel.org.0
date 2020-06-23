Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4026206751
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387838AbgFWWoK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:10 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:54762 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgFWWoJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952248; x=1624488248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=MuO4pbfrhnFBY58Nu7gt1MsJgRrXsq6GWFzAbghLgMk=;
  b=fk2rCMlGDRDPbWR/YZiiD444hHoungnplSagxsPLfdciz2NWFjBnr53D
   eS4GYugnLbpmYDq7+HhyuoFMywR9L1RVIryEHEe7i9Fj2a79oUqg1scin
   XWdAOzTfY2hgGZAvZJNiVSahBUx8Jv8x8HY3ovzU3JjF0wIzDH1y2h6RI
   4=;
IronPort-SDR: 7ZcaXIBGYKAp0FAHQovGEWl4jDZqQeaJXBpxLgdZ0oFls6pHwhXZgPv5t3lMueoqdssE2AFZTK
 GziHGRxnP1Kg==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="37981944"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id CDF2CA1D28;
        Tue, 23 Jun 2020 22:39:05 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:04 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id B98D9CD35D; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 03/13] NFSv4.2: define limits and sizes for user xattr handling
Date:   Tue, 23 Jun 2020 22:38:54 +0000
Message-ID: <20200623223904.31643-4-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Set limits for extended attributes (attribute value size and listxattr
buffer size), based on the fs-independent limits (XATTR_*_MAX).

Define the maximum XDR sizes for the RFC 8276 XATTR operations.
In the case of operations that carry a larger payload (SETXATTR,
GETXATTR, LISTXATTR), these exclude that payload, which is added
as separate pages, like other operations do.

Define, much like for read and write operations, the maximum overhead
sizes for get/set/listxattr, and use them to limit the maximum payload
size for those operations, in combination with the channel attributes.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/client.c           | 19 ++++++++--
 fs/nfs/nfs42.h            | 16 +++++++++
 fs/nfs/nfs42xdr.c         | 74 +++++++++++++++++++++++++++++++++++++++
 fs/nfs/nfs4_fs.h          |  6 ++++
 fs/nfs/nfs4client.c       | 31 ++++++++++++++++
 include/linux/nfs_fs_sb.h |  5 +++
 6 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index f1ff3076e4a4..055040bf1a8e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -50,6 +50,7 @@
 #include "nfs.h"
 #include "netns.h"
 #include "sysfs.h"
+#include "nfs42.h"
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
@@ -749,7 +750,7 @@ static int nfs_init_server(struct nfs_server *server,
 static void nfs_server_set_fsinfo(struct nfs_server *server,
 				  struct nfs_fsinfo *fsinfo)
 {
-	unsigned long max_rpc_payload;
+	unsigned long max_rpc_payload, raw_max_rpc_payload;
 
 	/* Work out a lot of parameters */
 	if (server->rsize == 0)
@@ -762,7 +763,9 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 	if (fsinfo->wtmax >= 512 && server->wsize > fsinfo->wtmax)
 		server->wsize = nfs_block_size(fsinfo->wtmax, NULL);
 
-	max_rpc_payload = nfs_block_size(rpc_max_payload(server->client), NULL);
+	raw_max_rpc_payload = rpc_max_payload(server->client);
+	max_rpc_payload = nfs_block_size(raw_max_rpc_payload, NULL);
+
 	if (server->rsize > max_rpc_payload)
 		server->rsize = max_rpc_payload;
 	if (server->rsize > NFS_MAX_FILE_IO_SIZE)
@@ -795,6 +798,18 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 	server->clone_blksize = fsinfo->clone_blksize;
 	/* We're airborne Set socket buffersize */
 	rpc_setbufsize(server->client, server->wsize + 100, server->rsize + 100);
+
+#ifdef CONFIG_NFS_V4_2
+	/*
+	 * Defaults until limited by the session parameters.
+	 */
+	server->gxasize = min_t(unsigned int, raw_max_rpc_payload,
+				XATTR_SIZE_MAX);
+	server->sxasize = min_t(unsigned int, raw_max_rpc_payload,
+				XATTR_SIZE_MAX);
+	server->lxasize = min_t(unsigned int, raw_max_rpc_payload,
+				nfs42_listxattr_xdrsize(XATTR_LIST_MAX));
+#endif
 }
 
 /*
diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index c891af949886..51de8ddc7d88 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -6,6 +6,8 @@
 #ifndef __LINUX_FS_NFS_NFS4_2_H
 #define __LINUX_FS_NFS_NFS4_2_H
 
+#include <linux/xattr.h>
+
 /*
  * FIXME:  four LAYOUTSTATS calls per compound at most! Do we need to support
  * more? Need to consider not to pre-alloc too much for a compound.
@@ -36,5 +38,19 @@ static inline bool nfs42_files_from_same_server(struct file *in,
 	return nfs4_check_serverowner_major_id(c_in->cl_serverowner,
 					       c_out->cl_serverowner);
 }
+
+/*
+ * Maximum XDR buffer size needed for a listxattr buffer of buflen size.
+ *
+ * The upper boundary is a buffer with all 1-byte sized attribute names.
+ * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
+ * 8 bytes long XDR-encoded.
+ *
+ * Include the trailing eof word as well.
+ */
+static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
+{
+	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
+}
 #endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index c03f3246d6c5..6712daa9d85b 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -169,6 +169,80 @@
 					 decode_clone_maxsz + \
 					 decode_getattr_maxsz)
 
+#ifdef CONFIG_NFS_V4_2
+/* Not limited by NFS itself, limited by the generic xattr code */
+#define nfs4_xattr_name_maxsz   XDR_QUADLEN(XATTR_NAME_MAX)
+
+#define encode_getxattr_maxsz   (op_encode_hdr_maxsz + 1 + \
+				 nfs4_xattr_name_maxsz)
+#define decode_getxattr_maxsz   (op_decode_hdr_maxsz + 1 + 1)
+#define encode_setxattr_maxsz   (op_encode_hdr_maxsz + \
+				 1 + nfs4_xattr_name_maxsz + 1)
+#define decode_setxattr_maxsz   (op_decode_hdr_maxsz + decode_change_info_maxsz)
+#define encode_listxattrs_maxsz  (op_encode_hdr_maxsz + 2 + 1)
+#define decode_listxattrs_maxsz  (op_decode_hdr_maxsz + 2 + 1 + 1)
+#define encode_removexattr_maxsz (op_encode_hdr_maxsz + 1 + \
+				  nfs4_xattr_name_maxsz)
+#define decode_removexattr_maxsz (op_decode_hdr_maxsz + \
+				  decode_change_info_maxsz)
+
+#define NFS4_enc_getxattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_getxattr_maxsz)
+#define NFS4_dec_getxattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_getxattr_maxsz)
+#define NFS4_enc_setxattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_setxattr_maxsz)
+#define NFS4_dec_setxattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_setxattr_maxsz)
+#define NFS4_enc_listxattrs_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_listxattrs_maxsz)
+#define NFS4_dec_listxattrs_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_listxattrs_maxsz)
+#define NFS4_enc_removexattr_sz	(compound_encode_hdr_maxsz + \
+				encode_sequence_maxsz + \
+				encode_putfh_maxsz + \
+				encode_removexattr_maxsz)
+#define NFS4_dec_removexattr_sz	(compound_decode_hdr_maxsz + \
+				decode_sequence_maxsz + \
+				decode_putfh_maxsz + \
+				decode_removexattr_maxsz)
+
+/*
+ * These values specify the maximum amount of data that is not
+ * associated with the extended attribute name or extended
+ * attribute list in the SETXATTR, GETXATTR and LISTXATTR
+ * respectively.
+ */
+const u32 nfs42_maxsetxattr_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
+					compound_encode_hdr_maxsz +
+					encode_sequence_maxsz +
+					encode_putfh_maxsz + 1 +
+					nfs4_xattr_name_maxsz)
+					* XDR_UNIT);
+
+const u32 nfs42_maxgetxattr_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
+					compound_decode_hdr_maxsz +
+					decode_sequence_maxsz +
+					decode_putfh_maxsz + 1) * XDR_UNIT);
+
+const u32 nfs42_maxlistxattrs_overhead = ((RPC_MAX_HEADER_WITH_AUTH +
+					compound_decode_hdr_maxsz +
+					decode_sequence_maxsz +
+					decode_putfh_maxsz + 3) * XDR_UNIT);
+#endif
+
 static void encode_fallocate(struct xdr_stream *xdr,
 			     const struct nfs42_falloc_args *args)
 {
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 2b7f6dcd2eb8..526b3e70d57c 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -557,6 +557,12 @@ static inline void nfs4_unregister_sysctl(void)
 /* nfs4xdr.c */
 extern const struct rpc_procinfo nfs4_procedures[];
 
+#ifdef CONFIG_NFS_V4_2
+extern const u32 nfs42_maxsetxattr_overhead;
+extern const u32 nfs42_maxgetxattr_overhead;
+extern const u32 nfs42_maxlistxattrs_overhead;
+#endif
+
 struct nfs4_mount_data;
 
 /* callback_xdr.c */
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 0bd77cc1f639..c41cbd86612c 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -992,6 +992,36 @@ static void nfs4_session_limit_rwsize(struct nfs_server *server)
 #endif /* CONFIG_NFS_V4_1 */
 }
 
+/*
+ * Limit xattr sizes using the channel attributes.
+ */
+static void nfs4_session_limit_xasize(struct nfs_server *server)
+{
+#ifdef CONFIG_NFS_V4_2
+	struct nfs4_session *sess;
+	u32 server_gxa_sz;
+	u32 server_sxa_sz;
+	u32 server_lxa_sz;
+
+	if (!nfs4_has_session(server->nfs_client))
+		return;
+
+	sess = server->nfs_client->cl_session;
+
+	server_gxa_sz = sess->fc_attrs.max_resp_sz - nfs42_maxgetxattr_overhead;
+	server_sxa_sz = sess->fc_attrs.max_rqst_sz - nfs42_maxsetxattr_overhead;
+	server_lxa_sz = sess->fc_attrs.max_resp_sz -
+	    nfs42_maxlistxattrs_overhead;
+
+	if (server->gxasize > server_gxa_sz)
+		server->gxasize = server_gxa_sz;
+	if (server->sxasize > server_sxa_sz)
+		server->sxasize = server_sxa_sz;
+	if (server->lxasize > server_lxa_sz)
+		server->lxasize = server_lxa_sz;
+#endif
+}
+
 static int nfs4_server_common_setup(struct nfs_server *server,
 		struct nfs_fh *mntfh, bool auth_probe)
 {
@@ -1039,6 +1069,7 @@ static int nfs4_server_common_setup(struct nfs_server *server,
 		goto out;
 
 	nfs4_session_limit_rwsize(server);
+	nfs4_session_limit_xasize(server);
 
 	if (server->namelen == 0 || server->namelen > NFS4_MAXNAMLEN)
 		server->namelen = NFS4_MAXNAMLEN;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 465fa98258a3..128e01acb4ca 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -163,6 +163,11 @@ struct nfs_server {
 	unsigned int		dtsize;		/* readdir size */
 	unsigned short		port;		/* "port=" setting */
 	unsigned int		bsize;		/* server block size */
+#ifdef CONFIG_NFS_V4_2
+	unsigned int		gxasize;	/* getxattr size */
+	unsigned int		sxasize;	/* setxattr size */
+	unsigned int		lxasize;	/* listxattr size */
+#endif
 	unsigned int		acregmin;	/* attr cache timeouts */
 	unsigned int		acregmax;
 	unsigned int		acdirmin;
-- 
2.17.2

