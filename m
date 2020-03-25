Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB6193440
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCYXLH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:07 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:40828 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgCYXLH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177866; x=1616713866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jShQsppeNQiclOwSiJuTdkCLFhm1YG3VaNa0tfsVfhY=;
  b=MCJ72c3jeIFyv/NjydH8J3Q3QZE/jrio6eQmjonvHfYGyptQXZYj2nJi
   Ftqrv6dxOQQrcrHksMxx9hTjShZ4xZiD70PUunVSywyRqFANfTNN6npIV
   iX0loeeJvpbVJBGSmCUp06B4A/FAbb2Q6aFkr0eGQ30mqZ42MxdPdQk0Q
   I=;
IronPort-SDR: E2i5eaJ+LEcBmLcDTaTUpC7Zir4fFX7cFu+Or6u/rKC7VUCC0IuD1ya9sddKvlWcZVQUksiYf5
 TaABa29IhMFw==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="22761096"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 25 Mar 2020 23:10:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id D2057A23A9;
        Wed, 25 Mar 2020 23:10:52 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:51 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:51 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 4DECFD92C0; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 02/13] nfs: add client side only definitions for user xattrs
Date:   Wed, 25 Mar 2020 23:10:40 +0000
Message-ID: <20200325231051.31652-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Add client-side only definitions for user extended
attributes (RFC8276). These are the access bits
as used by the client code, and the CLNT procedure
number definition.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 include/linux/nfs4.h   | 5 +++++
 include/linux/nfs_fs.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 350aeda0c48c..dd3871b05ae5 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -553,6 +553,11 @@ enum {
 	NFSPROC4_CLNT_LAYOUTERROR,
 
 	NFSPROC4_CLNT_COPY_NOTIFY,
+
+	NFSPROC4_CLNT_GETXATTR,
+	NFSPROC4_CLNT_SETXATTR,
+	NFSPROC4_CLNT_LISTXATTRS,
+	NFSPROC4_CLNT_REMOVEXATTR,
 };
 
 /* nfs41 types */
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 5d5b91e54f73..442458e94ab5 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -212,6 +212,9 @@ struct nfs4_copy_state {
 #define NFS_ACCESS_EXTEND      0x0008
 #define NFS_ACCESS_DELETE      0x0010
 #define NFS_ACCESS_EXECUTE     0x0020
+#define NFS_ACCESS_XAREAD      0x0040
+#define NFS_ACCESS_XAWRITE     0x0080
+#define NFS_ACCESS_XALIST      0x0100
 
 /*
  * Cache validity bit flags
-- 
2.17.2

