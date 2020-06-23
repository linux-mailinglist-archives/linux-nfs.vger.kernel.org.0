Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08880206753
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgFWWoL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:11 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16532 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387793AbgFWWoK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952249; x=1624488249;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=j1Hg3b1SaY8O1r6RWUjI0tTgIlQ3ROwZYX38HNamZk8=;
  b=Zy7GFPiqpLbQb63GR0bSrzU2NGl7PJEyRKv4cU4nrmYC8kr0xVPAPhvT
   sB7vmlJSlKHOjn+Xd1/LTxAgYH2rHJjfDnC1kf616Ox5g89Ab9EMJXtqV
   lk19V2XB6gJuJ/GzMscO2LQ1tSqTnl9uoc1C1MIRurimn6l5+8lcqs5If
   I=;
IronPort-SDR: OYbS4RrUs8zXOEsfQS2gDNdN2VWGNzAGBzEVHIDeWH6XIu4187oIFRU1z5NwLGkLLPIhbBjhN9
 epo75ClJJJAg==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="39410335"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-16acd5e0.us-east-1.amazon.com (Postfix) with ESMTPS id BDC32A1F5F;
        Tue, 23 Jun 2020 22:39:06 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id B253BCD35A; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 01/13] nfs,nfsd:  NFSv4.2 extended attribute protocol definitions
Date:   Tue, 23 Jun 2020 22:38:52 +0000
Message-ID: <20200623223904.31643-2-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
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

