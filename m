Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8FA1961D6
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Mar 2020 00:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgC0X1W (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Mar 2020 19:27:22 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:12188 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgC0X1W (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Mar 2020 19:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351642; x=1616887642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BEgJ6f0d4G9lFlPved0AH6fQpspQ/nvMCpPzD8vZEmk=;
  b=CFKKBE3tpeUUdKoM018Xv46Xqh7szALbrrZ90EZW8VB6fV1bH/qTUP4Z
   OCBTM83D0IJ+H6Nf81/0czgMg6Ce+7kOjiAXcfo/E1Bzt6itwLCDu/wm6
   vRlAg5xjdUaZmaQjslH+xnr/2A4hG53qFAGUuz3Fsodeiztpo0J1/wr8X
   I=;
IronPort-SDR: Zd7Hv4zZYhWFbZta75oCUVYRk4SvzgJ0nKkEysB2SDMGerOUS5L6qEzt0cgfjLaSNasa8bBqZS
 QBcOVA5kAGzw==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="33900223"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Mar 2020 23:27:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id B7519A259C;
        Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:17 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:17 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 3848BDEFB0; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 03/11] nfs,nfsd: NFSv4.2 extended attribute protocol definitions
Date:   Fri, 27 Mar 2020 23:27:09 +0000
Message-ID: <20200327232717.15331-4-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add definitions for the new operations, errors and flags as defined
in RFC 8276 (File System Extended Attributes in NFSv4).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 include/linux/nfs4.h      | 20 ++++++++++++++++++++
 include/uapi/linux/nfs4.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 82d8fb422092..350aeda0c48c 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -150,6 +150,12 @@ enum nfs_opnum4 {
 	OP_WRITE_SAME = 70,
 	OP_CLONE = 71,
 
+	/* xattr support (RFC8726) */
+	OP_GETXATTR                = 72,
+	OP_SETXATTR                = 73,
+	OP_LISTXATTRS              = 74,
+	OP_REMOVEXATTR             = 75,
+
 	OP_ILLEGAL = 10044,
 };
 
@@ -280,6 +286,10 @@ enum nfsstat4 {
 	NFS4ERR_WRONG_LFS = 10092,
 	NFS4ERR_BADLABEL = 10093,
 	NFS4ERR_OFFLOAD_NO_REQS = 10094,
+
+	/* xattr (RFC8276) */
+	NFS4ERR_NOXATTR        = 10095,
+	NFS4ERR_XATTR2BIG      = 10096,
 };
 
 static inline bool seqid_mutating_err(u32 err)
@@ -452,6 +462,7 @@ enum change_attr_type4 {
 #define FATTR4_WORD2_CHANGE_ATTR_TYPE	(1UL << 15)
 #define FATTR4_WORD2_SECURITY_LABEL     (1UL << 16)
 #define FATTR4_WORD2_MODE_UMASK		(1UL << 17)
+#define FATTR4_WORD2_XATTR_SUPPORT	(1UL << 18)
 
 /* MDS threshold bitmap bits */
 #define THRESHOLD_RD                    (1UL << 0)
@@ -700,4 +711,13 @@ struct nl4_server {
 		struct nfs42_netaddr	nl4_addr; /* NL4_NETADDR */
 	} u;
 };
+
+/*
+ * Options for setxattr. These match the flags for setxattr(2).
+ */
+enum nfs4_setxattr_options {
+	SETXATTR4_EITHER	= 0,
+	SETXATTR4_CREATE	= 1,
+	SETXATTR4_REPLACE	= 2,
+};
 #endif
diff --git a/include/uapi/linux/nfs4.h b/include/uapi/linux/nfs4.h
index 8572930cf5b0..bf197e99b98f 100644
--- a/include/uapi/linux/nfs4.h
+++ b/include/uapi/linux/nfs4.h
@@ -33,6 +33,9 @@
 #define NFS4_ACCESS_EXTEND      0x0008
 #define NFS4_ACCESS_DELETE      0x0010
 #define NFS4_ACCESS_EXECUTE     0x0020
+#define NFS4_ACCESS_XAREAD      0x0040
+#define NFS4_ACCESS_XAWRITE     0x0080
+#define NFS4_ACCESS_XALIST      0x0100
 
 #define NFS4_FH_PERSISTENT		0x0000
 #define NFS4_FH_NOEXPIRE_WITH_OPEN	0x0001
-- 
2.17.2

