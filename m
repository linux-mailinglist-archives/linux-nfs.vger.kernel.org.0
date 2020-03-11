Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 722DC1822E5
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgCKT4a (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:30 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:55622 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387437AbgCKT4a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956589; x=1615492589;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=ccTugRq1TIagxrvmO7blg+ZcjM1RcAJXXMfxsfgdDJI=;
  b=iOdjWW8MLnB7SGNvO1UtYkDGOVJPwUmuCB4FIgG2dVSouRlJ0A3f8wr8
   6svxyF4iE9eM9dGn0Qjv4m2KpG0D8xuAtlFG4vq5sjInLROvi/v7vJGaH
   OQ8iLy24ipYPzpZEcNI1LDwSBLLDSCo4oy4jcMYtjfxkFIYpffolsxY3t
   g=;
IronPort-SDR: OrdyjOO0KFAMpGuo3yIkUxf8ifp58ejRtY6gW/Qqp2XE5+u8vo+pm1XCDv6n7KmwqU7lYAP4TU
 Na1/pRHHqsWw==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="22301198"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 11 Mar 2020 19:56:28 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 323AAA25BE;
        Wed, 11 Mar 2020 19:56:26 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:25 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 0A6F8DEF48; Wed, 11 Mar 2020 19:56:24 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 10/13] nfs: make the buf_to_pages_noslab function available to the nfs code
Date:   Wed, 11 Mar 2020 19:56:10 +0000
Message-ID: <20200311195613.26108-11-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Make the buf_to_pages_noslab function available to the rest of the NFS
code. Rename it to nfs4_buf_to_pages_noslab to be consistent.

This will be used later in the NFSv4.2 xattr code.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/internal.h | 3 +++
 fs/nfs/nfs4proc.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 68f235a571e1..1e3a7e119c93 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -317,6 +317,9 @@ extern const u32 nfs42_maxlistxattrs_overhead;
 extern const struct rpc_procinfo nfs4_procedures[];
 #endif
 
+extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
+				    struct page **pages);
+
 #ifdef CONFIG_NFS_V4_SECURITY_LABEL
 extern struct nfs4_label *nfs4_label_alloc(struct nfs_server *server, gfp_t flags);
 static inline struct nfs4_label *
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 725ae64f62f7..aee3a1c97def 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5553,7 +5553,7 @@ static inline int nfs4_server_supports_acls(struct nfs_server *server)
  */
 #define NFS4ACL_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
 
-static int buf_to_pages_noslab(const void *buf, size_t buflen,
+int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 		struct page **pages)
 {
 	struct page *newpage, **spages;
@@ -5795,7 +5795,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 		return -EOPNOTSUPP;
 	if (npages > ARRAY_SIZE(pages))
 		return -ERANGE;
-	i = buf_to_pages_noslab(buf, buflen, arg.acl_pages);
+	i = nfs4_buf_to_pages_noslab(buf, buflen, arg.acl_pages);
 	if (i < 0)
 		return i;
 	nfs4_inode_make_writeable(inode);
-- 
2.16.6

