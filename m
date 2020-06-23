Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABF20675A
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2020 00:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387666AbgFWWoP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jun 2020 18:44:15 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:16538 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbgFWWoN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Jun 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vG+vmY+ZPX3W0KRNMcWVgMr/gmLQ8MA0IjCLtESqO34=;
  b=pEY+dhK/zDoXji4tMqyPzor/mQiADjP7C0muC9wcKihBXzjI7y6wpJZZ
   bsPNgVSHJXnNqBKvj3efQs0PRiiGKFRDluDQwtNeH0V0dRWNb7iTTyek7
   aa//TLW+8pfVHYHNqK0g3IlYGZZViCyno9drvV1jns5j9mLHCCCXxRJUF
   s=;
IronPort-SDR: s5nYGzvE4zJVBu1jVVBOH5C8vNLcLoKribpVRuuVkD8kPt7nApf9hltZKihIi7KvMScpwg/AJp
 1G4V2ghBVU5A==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="39410359"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:21 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS id 85932A17E7;
        Tue, 23 Jun 2020 22:39:20 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:12 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:12 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:05 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id C4AFFCD360; Tue, 23 Jun 2020 22:39:04 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <linux-nfs@vger.kernel.org>, <anna.schumaker@netapp.com>,
        <trond.myklebust@hammerspace.com>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH v3 06/13] nfs: define nfs_access_get_cached function
Date:   Tue, 23 Jun 2020 22:38:57 +0000
Message-ID: <20200623223904.31643-7-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223904.31643-1-fllinden@amazon.com>
References: <20200623223904.31643-1-fllinden@amazon.com>
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
index 5a331da5f55a..f04fc0f7843b 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2460,7 +2460,7 @@ static struct nfs_access_entry *nfs_access_search_rbtree(struct inode *inode, co
 	return NULL;
 }
 
-static int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
+static int nfs_access_get_cached_locked(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res, bool may_block)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_access_entry *cache;
@@ -2533,6 +2533,20 @@ static int nfs_access_get_cached_rcu(struct inode *inode, const struct cred *cre
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
@@ -2647,9 +2661,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 
 	trace_nfs_access_enter(inode);
 
-	status = nfs_access_get_cached_rcu(inode, cred, &cache);
-	if (status != 0)
-		status = nfs_access_get_cached(inode, cred, &cache, may_block);
+	status = nfs_access_get_cached(inode, cred, &cache, may_block);
 	if (status == 0)
 		goto out_cached;
 
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index b743988fcbd0..714b577dce19 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -493,6 +493,8 @@ extern int nfs_instantiate(struct dentry *dentry, struct nfs_fh *fh,
 			struct nfs_fattr *fattr, struct nfs4_label *label);
 extern int nfs_may_open(struct inode *inode, const struct cred *cred, int openflags);
 extern void nfs_access_zap_cache(struct inode *inode);
+extern int nfs_access_get_cached(struct inode *inode, const struct cred *cred, struct nfs_access_entry *res,
+				 bool may_block);
 
 /*
  * linux/fs/nfs/symlink.c
-- 
2.17.2

