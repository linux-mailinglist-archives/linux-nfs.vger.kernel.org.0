Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 517AD193442
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCYXLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:07 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:17969 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgCYXLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177867; x=1616713867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=sMkdnGHC1FegmqmweSiQYMODxwe/F6Ym8gjxwWsgDFQ=;
  b=vVOxq2Ag1XJCh0v//iswKaDItCk7e4V0jK1jDRS/8mkUSC8ld22iCKSX
   k2c82uQxnSlNMK31ZGU7gkKYalMUombwaEfqfmW0Js+IMfFCT6B9zz5D3
   +AmPE+0F1Rb2N6b9MlnptkYnPXjf0Km//beAigFCPUsp74+CPhEfrzRPh
   Y=;
IronPort-SDR: VAfjp8FWYmdRMCPN01Y0J70KTjFrEvQJfijoxL2lGrjvfRgMus4in5qIqqENvk5rD65xarj97h
 fyvzvRTuMHog==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="24200174"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 25 Mar 2020 23:10:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 30E3EA239C;
        Wed, 25 Mar 2020 23:10:54 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:52 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:52 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 551E6D92C2; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 04/13] NFSv4.2: query the server for extended attribute support
Date:   Wed, 25 Mar 2020 23:10:42 +0000
Message-ID: <20200325231051.31652-5-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
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
index eef39a4ec114..234635ef307e 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -808,6 +808,9 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 				XATTR_SIZE_MAX);
 	server->lxasize = min_t(unsigned int, raw_max_rpc_payload,
 				nfs42_listxattr_xdrsize(XATTR_LIST_MAX));
+
+	if (fsinfo->xattr_support)
+		server->caps |= NFS_CAP_XATTR;
 #endif
 }
 
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 69b7ab7a5815..11eac1b46749 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -256,6 +256,7 @@ const u32 nfs4_fsinfo_bitmap[3] = { FATTR4_WORD0_MAXFILESIZE
 			| FATTR4_WORD1_FS_LAYOUT_TYPES,
 			FATTR4_WORD2_LAYOUT_BLKSIZE
 			| FATTR4_WORD2_CLONE_BLKSIZE
+			| FATTR4_WORD2_XATTR_SUPPORT
 };
 
 const u32 nfs4_fs_locations_bitmap[3] = {
@@ -3737,7 +3738,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 
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
index 94c77ed55ce1..6fb1f2b65db3 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -149,6 +149,7 @@ struct nfs_fsinfo {
 	__u32			layouttype[NFS_MAX_LAYOUT_TYPES]; /* supported pnfs layout driver */
 	__u32			blksize; /* preferred pnfs io block size */
 	__u32			clone_blksize; /* granularity of a CLONE operation */
+	__u32			xattr_support; /* User xattrs supported */
 };
 
 struct nfs_fsstat {
-- 
2.17.2

