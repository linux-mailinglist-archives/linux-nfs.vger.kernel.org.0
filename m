Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7AFD1822E0
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Mar 2020 20:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387465AbgCKT43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Mar 2020 15:56:29 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:22799 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387410AbgCKT42 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Mar 2020 15:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1583956588; x=1615492588;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VI11F3whyg9N5whzL67BPNSOezYDc4w2i+BelRZdURU=;
  b=BJPKSwaJzTeAWJkk70QyeMGx7xCqRGrBsZT48E7r0louVQQdgA0EIqSu
   Vigc4keN7fEXQ16OvY90S3iUf73NwWLLjE7ZTaiLayJsPZEuXC30drana
   0eT7+pjJGCSavyDU8Cd5LYyVOjyADOrOUnzT2v1kY34LdJo/hXmJa69mN
   4=;
IronPort-SDR: zDWDavlO9Tul0HF7CdUspaCSNAUsWxxlHWPxWpv47QdFLlgxd9LMq/oJUMu23AyyboR9KXtlUL
 r9rNmy0jkShg==
X-IronPort-AV: E=Sophos;i="5.70,541,1574121600"; 
   d="scan'208";a="20655375"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 11 Mar 2020 19:56:28 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-303d0b0e.us-east-1.amazon.com (Postfix) with ESMTPS id 33AAEA2B6B;
        Wed, 11 Mar 2020 19:56:25 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Mar 2020 19:56:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 11 Mar 2020 19:56:25 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 11 Mar 2020 19:56:24 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id F3E9ADEF44; Wed, 11 Mar 2020 19:56:23 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <trond.myklebust@hammerspace.com>, <anna.schumaker@netapp.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>
Subject: [PATCH 06/13] nfs: define nfs_access_get_cached function
Date:   Wed, 11 Mar 2020 19:56:06 +0000
Message-ID: <20200311195613.26108-7-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
References: <20200311195613.26108-1-fllinden@amazon.com>
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
2.16.6

