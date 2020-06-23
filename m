Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24538206762
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbgFWWoU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:20 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:60579 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388047AbgFWWoT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952259; x=1624488259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XcTByK1fbxMIvhRB0LG0OHu7qBYQoSXfHbjmtGfEmXI=;
  b=WVlUTVGEMFOEIGZqGwlJNGplLeHWn600x6lOCoga2INIreOpyDTLjGO9
   h4mO+IB7sRNCxfaopkVanAdSYYlVPadWTiDJVN7wFZjRPLgOi7k2GTRZa
   FcXqFdZQr7Cd+kS7gAxA4jitqecTf7Xqv/UD5+UUB08HBBfkA18q9ATWo
   g=;
IronPort-SDR: HJj3PVM+VX8FOgFqGnhvd4jOnP3EhM7DLMBrMbaq9ak8pB8NUiGBvKM+ChHshtcoPk/Y0t0wOV
 vG8autnV5yhQ==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="54628909"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id A5F83A22D3;
        Tue, 23 Jun 2020 22:39:05 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:04 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:04 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id BD3D1CD35E; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 04/13] NFSv4.2: query the server for extended attribute support
Date:   Tue, 23 Jun 2020 22:38:55 +0000
Message-ID: <20200623223904.31643-5-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Query the server for extended attribute support, and record it
as the NFS_CAP_XATTR flag in the server capabilities.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/client.c           |  3 +++
 fs/nfs/nfs4proc.c         |  3 ++-
 fs/nfs/nfs4xdr.c          | 25 +++++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   |  1 +
 5 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 055040bf1a8e..4b8cc93913f7 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -809,6 +809,9 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 				XATTR_SIZE_MAX);
 	server->lxasize = min_t(unsigned int, raw_max_rpc_payload,
 				nfs42_listxattr_xdrsize(XATTR_LIST_MAX));
+
+	if (fsinfo->xattr_support)
+		server->caps |= NFS_CAP_XATTR;
 #endif
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index e32717fd1169..64e081459327 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -256,6 +256,7 @@ const u32 nfs4_fsinfo_bitmap[3] = { FATTR4_WORD0_MAXFILESIZE
 			| FATTR4_WORD1_FS_LAYOUT_TYPES,
 			FATTR4_WORD2_LAYOUT_BLKSIZE
 			| FATTR4_WORD2_CLONE_BLKSIZE
+			| FATTR4_WORD2_XATTR_SUPPORT
 };
 
 const u32 nfs4_fs_locations_bitmap[3] = {
@@ -3740,7 +3741,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
 #define FATTR4_WORD1_NFS40_MASK (2*FATTR4_WORD1_MOUNTED_ON_FILEID - 1UL)
 #define FATTR4_WORD2_NFS41_MASK (2*FATTR4_WORD2_SUPPATTR_EXCLCREAT - 1UL)
-#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_MODE_UMASK - 1UL)
+#define FATTR4_WORD2_NFS42_MASK (2*FATTR4_WORD2_XATTR_SUPPORT - 1UL)
 
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 47817ef0aadb..9e1b07640e9a 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -4201,6 +4201,26 @@ static int decode_attr_time_modify(struct xdr_stream *xdr, uint32_t *bitmap, str
 	return status;
 }
 
+static int decode_attr_xattrsupport(struct xdr_stream *xdr, uint32_t *bitmap,
+				    uint32_t *res)
+{
+	__be32 *p;
+
+	*res = 0;
+	if (unlikely(bitmap[2] & (FATTR4_WORD2_XATTR_SUPPORT - 1U)))
+		return -EIO;
+	if (likely(bitmap[2] & FATTR4_WORD2_XATTR_SUPPORT)) {
+		p = xdr_inline_decode(xdr, 4);
+		if (unlikely(!p))
+			return -EIO;
+		*res = be32_to_cpup(p);
+		bitmap[2] &= ~FATTR4_WORD2_XATTR_SUPPORT;
+	}
+	dprintk("%s: XATTR support=%s\n", __func__,
+		*res == 0 ? "false" : "true");
+	return 0;
+}
+
 static int verify_attr_len(struct xdr_stream *xdr, unsigned int savep, uint32_t attrlen)
 {
 	unsigned int attrwords = XDR_QUADLEN(attrlen);
@@ -4855,6 +4875,11 @@ static int decode_fsinfo(struct xdr_stream *xdr, struct nfs_fsinfo *fsinfo)
 	if (status)
 		goto xdr_error;
 
+	status = decode_attr_xattrsupport(xdr, bitmap,
+					  &fsinfo->xattr_support);
+	if (status)
+		goto xdr_error;
+
 	status = verify_attr_len(xdr, savep, attrlen);
 xdr_error:
 	dprintk("%s: xdr returned %d!\n", __func__, -status);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 128e01acb4ca..7eae72a8762e 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -286,5 +286,6 @@ struct nfs_server {
 #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
 #define NFS_CAP_LAYOUTERROR	(1U << 26)
 #define NFS_CAP_COPY_NOTIFY	(1U << 27)
+#define NFS_CAP_XATTR		(1U << 28)
 
 #endif
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 5fd0a9ef425f..dee9b1cfa972 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -150,6 +150,7 @@ struct nfs_fsinfo {
 	__u32			layouttype[NFS_MAX_LAYOUT_TYPES]; /* supported pnfs layout driver */
 	__u32			blksize; /* preferred pnfs io block size */
 	__u32			clone_blksize; /* granularity of a CLONE operation */
+	__u32			xattr_support; /* User xattrs supported */
 };
 
 struct nfs_fsstat {
-- 
2.17.2

