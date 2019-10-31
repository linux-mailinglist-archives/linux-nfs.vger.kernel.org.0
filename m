Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E57AEB9D0
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Oct 2019 23:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfJaWnO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Oct 2019 18:43:14 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38265 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfJaWnO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Oct 2019 18:43:14 -0400
Received: by mail-yb1-f194.google.com with SMTP id w6so1529775ybj.5
        for <linux-nfs@vger.kernel.org>; Thu, 31 Oct 2019 15:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JF4c76sI+h5J2OwX5ENMfoC6j5DXu//F/qWIv+iv3q0=;
        b=Gy5p46Tl1+G3B5erIQTB/OsufbXW8OXFq6QT9HGnbys4Wwzr+pQdF3ueq1OahMRIQW
         2khs0Z+NyXEFqpuw5jeXqFJ8Q0cdnVHNs7vodgj4LOlwNlNIdp6EGOJS8zuAjQUnnacz
         ror96Sn7kYvPmYVUW4Tjv6kgzY2bAAt5Lgc216f1QtX3EZdD+T+TtDlhglTbH5XbhXYS
         ONR0sutsi6RpbaMa977MJnZ6kAIy+M4VUDNLo59JSkfdC9/Rqt0gQPAltGrSa2HMeWk+
         qoZFimGKPIpvJnl26zBkvP5XBza2Oc02L+vBSXSw8H0wknTq59brs7bKvq3jrRhi3vdV
         Dk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JF4c76sI+h5J2OwX5ENMfoC6j5DXu//F/qWIv+iv3q0=;
        b=LeMOhGfq1y8K3h+D/I9tzlML4n/j6Qtqwp0bBk4x2XYxJy9+oJR4Ud9KsrpdcCAPoG
         V1k1fJjxO4km8p6BcoUpMri37eLUQfGGA7msDS3E021jQz+oWLUNBi4vS54XAN6wPUpG
         qWS+AI6I0qLoxxNHhExWgQRfoCvg7d8RtTF64QG5uMycAPSBVM7MAeB8zzy1ESgeRqAY
         3EfZ1eKx08+u7kAqb8PXgqAFmrEErR3WkK60t4+Om9uJP1oyqYgp1o481Bw9i78jWC/q
         xaNagy3wvVqYO1Hg7kCbgyKXghonZRImu15aJYi+gHbeT9oK9E2bIU03zK0T/Q6pMctq
         Am9Q==
X-Gm-Message-State: APjAAAVP0o3If7Q3rY9BVad0drWtYLRQhI8a4OKf9q39rQYWJyqLW35m
        LWK+MTED4TTwTgBQaWqpz/5h7t4=
X-Google-Smtp-Source: APXvYqyyWqRe9gMvvL72y8K4Tr0IojYYExC/fDFLF+uV80lqWjQsQxk04z2x0y/gTAlcIQc96JNj3Q==
X-Received: by 2002:a25:7395:: with SMTP id o143mr6734752ybc.190.1572561792910;
        Thu, 31 Oct 2019 15:43:12 -0700 (PDT)
Received: from localhost.localdomain ([50.105.87.1])
        by smtp.gmail.com with ESMTPSA id d192sm1720287ywb.3.2019.10.31.15.43.11
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:43:11 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 07/20] NFS: Rename nfs_inode_return_delegation_noreclaim()
Date:   Thu, 31 Oct 2019 18:40:38 -0400
Message-Id: <20191031224051.8923-8-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191031224051.8923-7-trond.myklebust@hammerspace.com>
References: <20191031224051.8923-1-trond.myklebust@hammerspace.com>
 <20191031224051.8923-2-trond.myklebust@hammerspace.com>
 <20191031224051.8923-3-trond.myklebust@hammerspace.com>
 <20191031224051.8923-4-trond.myklebust@hammerspace.com>
 <20191031224051.8923-5-trond.myklebust@hammerspace.com>
 <20191031224051.8923-6-trond.myklebust@hammerspace.com>
 <20191031224051.8923-7-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Rename nfs_inode_return_delegation_noreclaim() to
nfs_inode_evict_delegation(), which better describes what it
does.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 11 +++++++----
 fs/nfs/delegation.h |  2 +-
 fs/nfs/nfs4super.c  |  4 ++--
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 630167e243be..0c9339d559f5 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -585,19 +585,22 @@ int nfs_client_return_marked_delegations(struct nfs_client *clp)
 }
 
 /**
- * nfs_inode_return_delegation_noreclaim - return delegation, don't reclaim opens
+ * nfs_inode_evict_delegation - return delegation, don't reclaim opens
  * @inode: inode to process
  *
  * Does not protect against delegation reclaims, therefore really only safe
- * to be called from nfs4_clear_inode().
+ * to be called from nfs4_clear_inode(). Guaranteed to always free
+ * the delegation structure.
  */
-void nfs_inode_return_delegation_noreclaim(struct inode *inode)
+void nfs_inode_evict_delegation(struct inode *inode)
 {
 	struct nfs_delegation *delegation;
 
 	delegation = nfs_inode_detach_delegation(inode);
-	if (delegation != NULL)
+	if (delegation != NULL) {
+		set_bit(NFS_DELEGATION_INODE_FREEING, &delegation->flags);
 		nfs_do_return_delegation(inode, delegation, 1);
+	}
 }
 
 /**
diff --git a/fs/nfs/delegation.h b/fs/nfs/delegation.h
index 8b14d441e699..74b7fb601365 100644
--- a/fs/nfs/delegation.h
+++ b/fs/nfs/delegation.h
@@ -43,7 +43,7 @@ void nfs_inode_reclaim_delegation(struct inode *inode, const struct cred *cred,
 		fmode_t type, const nfs4_stateid *stateid, unsigned long pagemod_limit);
 int nfs4_inode_return_delegation(struct inode *inode);
 int nfs_async_inode_return_delegation(struct inode *inode, const nfs4_stateid *stateid);
-void nfs_inode_return_delegation_noreclaim(struct inode *inode);
+void nfs_inode_evict_delegation(struct inode *inode);
 
 struct inode *nfs_delegation_find_inode(struct nfs_client *clp, const struct nfs_fh *fhandle);
 void nfs_server_return_all_delegations(struct nfs_server *);
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 04c57066a11a..2c9cbade561a 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -92,8 +92,8 @@ static void nfs4_evict_inode(struct inode *inode)
 {
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
-	/* If we are holding a delegation, return it! */
-	nfs_inode_return_delegation_noreclaim(inode);
+	/* If we are holding a delegation, return and free it */
+	nfs_inode_evict_delegation(inode);
 	/* Note that above delegreturn would trigger pnfs return-on-close */
 	pnfs_return_layout(inode);
 	pnfs_destroy_layout(NFS_I(inode));
-- 
2.23.0

