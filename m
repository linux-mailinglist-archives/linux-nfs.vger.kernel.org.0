Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D161E1822E4
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbgCKT4a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:30 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:18122 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387464AbgCKT43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956589; x=1615492589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=aUyCvmJeVimsldJavFTnJVPmccm351/T0R89OCZpMT8=;
  b=nyK7UL1Zr3X27K++Efb1mIU2hgnpJ2uX7e9p0blLzrF6rz6Tg2cOFttC
   r0vVOnDr6L7B/527PA2gDPEa5XRgtW6siCiQddVDHWKNz5LcGTTJcNC+E
   rBOy/OU8aL1JP1dnNUIRlHD8VvfPMIHrNzptCq5+vQHEGPo3udP6pDcef
   k=;
IronPort-SDR: 9tgZHRYT99s5olU882VBiyEyLDCMf3dwDj0Q/ktT/r/ZG2qL+sbJm1GWUNe60gQnhK/dAOWTyn
 x0ORM+QLGnzg==
X-IronPort-AV: E=Sophos;i="5.70,542,1574121600"; 
   d="scan'208";a="22094073"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS id 63DD6A28C2;
        Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:24 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:24 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id E8E10DEC12; Wed, 11 Mar 2020 19:56:23 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 02/13] nfs: add client side only definitions for user xattrs
Date:   Wed, 11 Mar 2020 19:56:02 +0000
Message-ID: <20200311195613.26108-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
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
2.16.6

