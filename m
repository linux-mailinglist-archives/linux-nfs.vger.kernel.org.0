Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 413F41822E8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgCKT4k (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:40 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:61723 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387409AbgCKT4k (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956600; x=1615492600;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=HaJEBG/I8Qc8WazFV1QuipGViufBZRePivJBBUbdhM8=;
  b=nZjPgqWMPBM7fjYnGb/l9Pz0zvP32vAL+N4i2SAN/BkpdEwMrBRfdINK
   rPDDelieQbkTsmpH8gP76qkUHkQMGS33BE8zA7CZ+CbqveyOMw0oVENfK
   rgRxuAWon774lf1wQvNke4cORePa3Qy649TvDK+GP/LMgOwSj9D2y/udt
   4=;
IronPort-SDR: 3FoBMQPfXGbkrqm3grmRnhVbDsaI4c5awK8CBUk3qMX0zPQ5IhlT1Qn9/IDKTMBNkJEZYTuCzr
 VP+QE/qMzhCg==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="21100373"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Mar 2020 19:56:27 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (Postfix) with ESMTPS id 0C219A2427;
        Wed, 11 Mar 2020 19:56:25 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:24 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id EBA78DEC13; Wed, 11 Mar 2020 19:56:23 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 03/13] NFSv4.2: query the server for extended attribute support
Date:   Wed, 11 Mar 2020 19:56:03 +0000
Message-ID: <20200311195613.26108-4-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
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
 fs/nfs/nfs4proc.c         | 14 ++++++++++++--
 fs/nfs/nfs4xdr.c          | 23 +++++++++++++++++++++++
 include/linux/nfs_fs_sb.h |  1 +
 include/linux/nfs_xdr.h   |  1 +
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 69b7ab7a5815..47bbd7db9d18 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3742,6 +3742,7 @@ static void nfs4_close_context(struct nfs_open_context *ctx, int is_sync)
 static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *fhandle)
 {
 	u32 bitmask[3] = {}, minorversion = server->nfs_client->cl_minorversion;
+	u32 fattr4_word2_nfs42_mask;
 	struct nfs4_server_caps_arg args = {
 		.fhandle = fhandle,
 		.bitmask = bitmask,
@@ -3763,6 +3764,13 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 	if (minorversion)
 		bitmask[2] = FATTR4_WORD2_SUPPATTR_EXCLCREAT;
 
+	fattr4_word2_nfs42_mask = FATTR4_WORD2_NFS42_MASK;
+
+	if (minorversion >= 2) {
+		bitmask[2] |= FATTR4_WORD2_XATTR_SUPPORT;
+		fattr4_word2_nfs42_mask |= FATTR4_WORD2_XATTR_SUPPORT;
+	}
+
 	status = nfs4_call_sync(server->client, server, &msg, &args.seq_args, &res.seq_res, 0);
 	if (status == 0) {
 		/* Sanity check the server answers */
@@ -3775,7 +3783,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 			res.attr_bitmask[2] &= FATTR4_WORD2_NFS41_MASK;
 			break;
 		case 2:
-			res.attr_bitmask[2] &= FATTR4_WORD2_NFS42_MASK;
+			res.attr_bitmask[2] &= fattr4_word2_nfs42_mask;
 		}
 		memcpy(server->attr_bitmask, res.attr_bitmask, sizeof(server->attr_bitmask));
 		server->caps &= ~(NFS_CAP_ACLS|NFS_CAP_HARDLINKS|
@@ -3783,7 +3791,7 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 				NFS_CAP_MODE|NFS_CAP_NLINK|NFS_CAP_OWNER|
 				NFS_CAP_OWNER_GROUP|NFS_CAP_ATIME|
 				NFS_CAP_CTIME|NFS_CAP_MTIME|
-				NFS_CAP_SECURITY_LABEL);
+				NFS_CAP_SECURITY_LABEL|NFS_CAP_XATTR);
 		if (res.attr_bitmask[0] & FATTR4_WORD0_ACL &&
 				res.acl_bitmask & ACL4_SUPPORT_ALLOW_ACL)
 			server->caps |= NFS_CAP_ACLS;
@@ -3811,6 +3819,8 @@ static int _nfs4_server_capabilities(struct nfs_server *server, struct nfs_fh *f
 		if (res.attr_bitmask[2] & FATTR4_WORD2_SECURITY_LABEL)
 			server->caps |= NFS_CAP_SECURITY_LABEL;
 #endif
+		if (res.has_xattr)
+			server->caps |= NFS_CAP_XATTR;
 		memcpy(server->attr_bitmask_nl, res.attr_bitmask,
 				sizeof(server->attr_bitmask));
 		server->attr_bitmask_nl[2] &= ~FATTR4_WORD2_SECURITY_LABEL;
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index 47817ef0aadb..bebc087a1433 100644
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
@@ -4371,6 +4391,9 @@ static int decode_server_caps(struct xdr_stream *xdr, struct nfs4_server_caps_re
 	if ((status = decode_attr_exclcreat_supported(xdr, bitmap,
 				res->exclcreat_bitmask)) != 0)
 		goto xdr_error;
+	status = decode_attr_xattrsupport(xdr, bitmap, &res->has_xattr);
+	if (status != 0)
+		goto xdr_error;
 	status = verify_attr_len(xdr, savep, attrlen);
 xdr_error:
 	dprintk("%s: xdr returned %d!\n", __func__, -status);
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 465fa98258a3..d881f7a38bc9 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -281,5 +281,6 @@ struct nfs_server {
 #define NFS_CAP_OFFLOAD_CANCEL	(1U << 25)
 #define NFS_CAP_LAYOUTERROR	(1U << 26)
 #define NFS_CAP_COPY_NOTIFY	(1U << 27)
+#define NFS_CAP_XATTR		(1U << 28)
 
 #endif
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 94c77ed55ce1..5076fe42c693 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1178,6 +1178,7 @@ struct nfs4_server_caps_res {
 	u32				has_links;
 	u32				has_symlinks;
 	u32				fh_expire_type;
+	u32				has_xattr;
 };
 
 #define NFS4_PATHNAME_MAXCOMPONENTS 512
-- 
2.16.6

