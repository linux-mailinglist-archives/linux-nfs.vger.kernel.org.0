Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D19206767
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbgFWWoY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:24 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:57642 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbgFWWoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952257; x=1624488257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=j1Hg3b1SaY8O1r6RWUjI0tTgIlQ3ROwZYX38HNamZk8=;
  b=u65jS+Es/Yz5vI50gqcLzz9MVHYruldXrI3qJKAXlLboAM/tHGWjeeuF
   kUNCMR3qCeGMuCGitbH8vACgMRr6oOxpWEO+cde0GhqvjjH8a9RP73jKl
   MSUd4uG984lEhTnXUMKpelu9CI0xuiS3+zIL0ytPdiSkuAPb4KPfc6Lxo
   0=;
IronPort-SDR: uohiUaXSSJSVMzy4EeqxCXNrdL1wyGT3TIo4lRh9U9uBVmka9vi5ng+j36/ZlsPoou6Wc7MTi+
 d59rd1LLcW4g==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="46390848"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:36 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 54767A1D43;
        Tue, 23 Jun 2020 22:39:34 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:28 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:28 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:27 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0D4D0CD35D; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 03/10] nfs,nfsd: NFSv4.2 extended attribute protocol definitions
Date:   Tue, 23 Jun 2020 22:39:20 +0000
Message-ID: <20200623223927.31795-4-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
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
index 4dba3c948932..e6ca9d1d2e76 100644
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

