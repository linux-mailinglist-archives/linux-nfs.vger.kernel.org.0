Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2C3193447
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgCYXLO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:14 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:33265 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgCYXLO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177874; x=1616713874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=jVrJZTHir3ub+Fdgg4hefiI3EHBvthaDoftd0LvUzXA=;
  b=l53eG/MCOBeNgS8rz7fWu4sUCVkvQ5j97s7npKSCXN7MomYcN+mGydVN
   u18Mc0TY+HjhKtIA3Kp3D/PS4ETOOooxLwH9ELmcupzndyYtb/LOaNgex
   16kCL8KGb+VkUp+yrRNVXVIBvBpPM/4ZaMyE+Tb8B6zTTkVJpP52oWgtc
   M=;
IronPort-SDR: GThdym+C3jK7KcBmAXNtLe+Nq3HFbCWu2F5cpsrWG+RjU4TLNi7mPw+6C6RUlB9MzOiaAd+Yzc
 lNly81y14YWQ==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="23184860"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 25 Mar 2020 23:11:14 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id 956AAA2D34;
        Wed, 25 Mar 2020 23:11:12 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:53 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:52 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 69EBDD92C8; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 10/13] nfs: make the buf_to_pages_noslab function available to the nfs code
Date:   Wed, 25 Mar 2020 23:10:48 +0000
Message-ID: <20200325231051.31652-11-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
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
index f82c3e884662..da18d0254c75 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -326,6 +326,8 @@ extern void nfs4_update_changeattr(struct inode *dir,
 				   struct nfs4_change_info *cinfo,
 				   unsigned long timestamp,
 				   unsigned long cache_validity);
+extern int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
+				    struct page **pages);
 
 #if defined(CONFIG_NFS_V4_1)
 extern int nfs41_sequence_done(struct rpc_task *, struct nfs4_sequence_res *);
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 441bdbb7f247..c1193766cfe5 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5544,7 +5544,7 @@ static inline int nfs4_server_supports_acls(struct nfs_server *server)
  */
 #define NFS4ACL_MAXPAGES DIV_ROUND_UP(XATTR_SIZE_MAX, PAGE_SIZE)
 
-static int buf_to_pages_noslab(const void *buf, size_t buflen,
+int nfs4_buf_to_pages_noslab(const void *buf, size_t buflen,
 		struct page **pages)
 {
 	struct page *newpage, **spages;
@@ -5786,7 +5786,7 @@ static int __nfs4_proc_set_acl(struct inode *inode, const void *buf, size_t bufl
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

