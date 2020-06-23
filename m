Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6020676A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388036AbgFWWoZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:25 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:60591 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388140AbgFWWoV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952261; x=1624488261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ZGArR/13+cpXke2lvAlETYqJsymL8p1GBpYaP62fxEs=;
  b=X75JXQYfJcP7jMjc0u2YN4eKSyBN6rHu5vwe14teUtRn1j6CzNNO/xEg
   +IFJNyOMPyvXP3bzeC+QK3JCKWwsz1pXe7OXh8G7jPluYZp+vMipIuJm0
   qx52px501fhHZIIRx1tK6t7JDGN2vbt6XTtovE0/7cxzuvmLjQ6TV9Trp
   A=;
IronPort-SDR: Z3COOWWeihLYjEH0K0UoYyIHM8Nvh7/pbsW6GCf6UN9/PGX3rAVTOjCckV9xaONi/xJTqyujMm
 MtjFSi3npcqA==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="54628917"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 23 Jun 2020 22:39:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id C5537A21F9;
        Tue, 23 Jun 2020 22:39:06 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:06 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:06 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:04 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id B5E79CD35B; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 02/13] nfs: add client side only definitions for user xattrs
Date:   Tue, 23 Jun 2020 22:38:53 +0000
Message-ID: <20200623223904.31643-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
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
index e6ca9d1d2e76..db13026ac7d1 100644
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
index 6ee9119acc5d..b743988fcbd0 100644
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

