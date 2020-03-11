Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06014182306
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 21:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgCKUAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 16:00:03 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:62480 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387465AbgCKUAB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 16:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956800; x=1615492800;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=hTGKUo6Uq6PG8dHjHGv5Arulaqx2wFajptSp9n4AP8U=;
  b=Q4GlN1OrtAS5AF+4qy0BYllYIuibSDE9iDJ2Ym+WN5nVvZyZO/Hlxb2S
   TJdSzur6yUtfdqhOQBwTSzm2y1OvtJdVCzSmf7X8RUf8eEF+fmN6nzCad
   CBc3uBJ8GOmVWMaYUFgm10yiRA/X9GnKKJnSh/9yIBQTVZiQCKRA0J52M
   g=;
IronPort-SDR: AvItUznlFTWqqSYgBhm3uGRGI6zAaHzntuRwoj8IjDm116Xsbpc7IjrzRuhZ7uxdAwq1TRKzyW
 J+s/R9wbHyYQ==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="21101080"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 11 Mar 2020 19:59:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 191F2A2573;
        Wed, 11 Mar 2020 19:59:57 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:59:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:59:55 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:59:55 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 23FB3DEF4A; Wed, 11 Mar 2020 19:59:55 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 12/14] nfsd: add xattr operations to ops array
Date:   Wed, 11 Mar 2020 19:59:52 +0000
Message-ID: <20200311195954.27117-13-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195954.27117-1-fllinden@amazon.com>
References: <20200311195954.27117-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With all underlying code implemented, let's add the user extended
attributes operations to nfsd4_ops.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfsd/nfs4proc.c   | 22 ++++++++++++++++++++++
 include/linux/nfs4.h |  2 +-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 44d488bdebd9..889cb6538244 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3195,6 +3195,28 @@ static const struct nfsd4_operation nfsd4_ops[LAST_NFS4_OP + 1] = {
 		.op_name = "OP_COPY_NOTIFY",
 		.op_rsize_bop = nfsd4_copy_notify_rsize,
 	},
+	[OP_GETXATTR] = {
+		.op_func = nfsd4_getxattr,
+		.op_name = "OP_GETXATTR",
+		.op_rsize_bop = nfsd4_getxattr_rsize,
+	},
+	[OP_SETXATTR] = {
+		.op_func = nfsd4_setxattr,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
+		.op_name = "OP_SETXATTR",
+		.op_rsize_bop = nfsd4_setxattr_rsize,
+	},
+	[OP_LISTXATTRS] = {
+		.op_func = nfsd4_listxattrs,
+		.op_name = "OP_LISTXATTRS",
+		.op_rsize_bop = nfsd4_listxattrs_rsize,
+	},
+	[OP_REMOVEXATTR] = {
+		.op_func = nfsd4_removexattr,
+		.op_flags = OP_MODIFIES_SOMETHING | OP_CACHEME,
+		.op_name = "OP_REMOVEXATTR",
+		.op_rsize_bop = nfsd4_removexattr_rsize,
+	},
 };
 
 /**
diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 350aeda0c48c..cbe50e452f19 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -165,7 +165,7 @@ Needs to be updated if more operations are defined in future.*/
 #define FIRST_NFS4_OP	OP_ACCESS
 #define LAST_NFS40_OP	OP_RELEASE_LOCKOWNER
 #define LAST_NFS41_OP	OP_RECLAIM_COMPLETE
-#define LAST_NFS42_OP	OP_CLONE
+#define LAST_NFS42_OP	OP_REMOVEXATTR
 #define LAST_NFS4_OP	LAST_NFS42_OP
 
 enum nfsstat4 {
-- 
2.16.6

