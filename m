Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51805193444
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 00:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbgCYXLJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 19:11:09 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:45746 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbgCYXLI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 19:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585177867; x=1616713867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KatEFjI2jPn7fetiU6/lu4aiwgIU+vsVMmnpk6wO1PQ=;
  b=uCnRPlQqK5GLQMBZoP+1Xwh5SsrjehZEExNNwPXlAQthWJBV9ERQlQd7
   liDaf1/YSOzpEVIRLufmTeUJg/Ys0UN/TX0xm/fV8Lv3wjw2A4immVtPk
   eOeD15uBQginLKBUs85uPzj4kUv1lbE4vM9bvIWj0ovWESiWR+3ykILW9
   o=;
IronPort-SDR: Kzg3XG3jOFWtDjRth7J9FCDueX6cdazOC37HxUoxucsIvFjDKf3vijD2eIAYzNziOy3+aTjP9V
 NZzDSa8svNOA==
X-IronPort-AV: E=Sophos;i="5.72,306,1580774400"; 
   d="scan'208";a="22920039"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 25 Mar 2020 23:10:55 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id B02C4A2F3C;
        Wed, 25 Mar 2020 23:10:54 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 25 Mar 2020 23:10:53 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 25 Mar 2020 23:10:52 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 25 Mar 2020 23:10:51 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 5C10AD92C4; Wed, 25 Mar 2020 23:10:51 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v2 06/13] nfs: define nfs_access_get_cached function
Date:   Wed, 25 Mar 2020 23:10:44 +0000
Message-ID: <20200325231051.31652-7-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200325231051.31652-1-fllinden@amazon.com>
References: <20200325231051.31652-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The only consumer of nfs_access_get_cached_rcu and nfs_access_cached
calls these static functions in order to first try RCU access, and
then locked access.

Combine them in to a single function, and call that. Make this function
available to the rest of the NFS code.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/nfs/dir.c           | 20 ++++++++++++++++----
 include/linux/nfs_fs.h |  2 ++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 193d6fb363b7..a0b564781e3e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2433,7 +2433,7 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
+static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_access_entry *cache;
@@ -2506,6 +2506,20 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
 	return err;
 }
 
+int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct
+nfs_access_entry *res, bool may_block)
+{
+	int status;
+
+	status = nfs_access_get_cached_rcu(inode, cred, res);
+	if (status != 0)
+		status = nfs_access_get_cached_locked(inode, cred, res,
+		    may_block);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(nfs_access_get_cached);
+
 static void nfs_access_add_rbtree(struct inode *inode, struct nfs_access_entry *set)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
@@ -2620,9 +2634,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 
 	trace_nfs_access_enter(inode);
 
-	status = nfs_access_get_cached_rcu(inode, cred, &cache);
-	if (status != 0)
-		status = nfs_access_get_cached(inode, cred, &cache, may_block);
+	status = nfs_access_get_cached(inode, cred, &cache, may_block);
 	if (status == 0)
 		goto out_cached;
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 442458e94ab5..e86e7a747092 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -491,6 +491,8 @@ extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr, struct nfs4_label *label);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
+extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res,
+				 bool may_block);
 
 /*
  * linux/fs/nfs/symlink.c
-- 
2.17.2

