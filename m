Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAC8206752
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387842AbgFWWoK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:10 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14750 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgFWWoJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952248; x=1624488248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=90k9R2laag9b9yU9BeMIcBFv1kEnSoVU6phDOygQXqI=;
  b=gkaaOLMF4AXF2It7aaPv8ygnEXzK/QY2O//3kBpbWQhrCpz5LmA4JZLL
   vm/9z4GpGu5RVDp9+cqPFTKINBb6966zCEl3MgM8gS7bNycXzC3gG+bmI
   ANAKuoIpRTZXt+RxTlOcbs2D61qBNid5y4D1c9lBCwmenpOML3oVC/B9K
   g=;
IronPort-SDR: gF1o6aeFdcFWsSWZgYRWBWfSRxoFVe9kpxtpUHFO7W0CIzpMXw4p/7pe8SpzTgitCUoCQ2daUb
 cHMT/0cnYhYQ==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="53337203"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jun 2020 22:39:07 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (Postfix) with ESMTPS id 29719C0756;
        Tue, 23 Jun 2020 22:39:06 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:05 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:05 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id D3A6CCD364; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 10/13] nfs: make the buf_to_pages_noslab function available to the nfs code
Date:   Tue, 23 Jun 2020 22:39:01 +0000
Message-ID: <20200623223904.31643-11-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
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
 fs/nfs/nfs4_fs.h  | 2 ++
 fs/nfs/nfs4proc.c | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index c16ec860b8b3..2fa9e4ea98d2 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -328,6 +328,8 @@ extern void nfs4_update_changeattr(struct inode *dir,
 				   struct nfs4_change_info *cinfo,
 				   unsigned long timestamp,
 				   unsigned long cache_validity);
+extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
+				    struct page **pages);
 
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 0d123fe0a423..0fbd2925a828 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5541,7 +5541,7 @@ static inline int nfs4_server_supports_acls(struct nfs_server *server)
  */
 #define NFS4ACL_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
 
-static int buf_to_pages_noslab(const void *buf, size_t buflen,
+int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 		struct page **pages)
 {
 	struct page *newpage, **spages;
@@ -5783,7 +5783,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
 		return -EOPNOTSUPP;
 	if (npages > ARRAY_SIZE(pages))
 		return -ERANGE;
-	i = buf_to_pages_noslab(buf, buflen, arg.acl_pages);
+	i = nfs4_buf_to_pages_noslab(buf, buflen, arg.acl_pages);
 	if (i < 0)
 		return i;
 	nfs4_inode_make_writeable(inode);
-- 
2.17.2

