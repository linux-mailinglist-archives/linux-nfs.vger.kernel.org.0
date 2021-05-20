Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E4F38B46C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 May 2021 18:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhETQk2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 May 2021 12:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231810AbhETQk0 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 20 May 2021 12:40:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C83FF61019
        for <linux-nfs@vger.kernel.org>; Thu, 20 May 2021 16:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621528745;
        bh=KrWfKNGaBxAF9AHeINJ20QjbxFcNOq2KGpuCeMAdj4M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=C0KpuDE072Nvv2CGaJjMMa6M4/c8p49+gUn11qb3tqJeBHEvFRIJMNYKh5stV66DR
         i1UKpW8/KIWelJzP4pixINmasAGboyYzfuN6GB9yf/31rxXYpu4FiecZwnjVCWL7pR
         cl8cCZG9nDdEiowT/GaWENs5yWYxO4h08S7M7tKXNRh+YFdAcP/E3JJYixV24tLsW5
         4JTvFLqLcEdnncQSFYU9rGVbbvYxfZqW3z5Uih+RrH+zeZWkE1LIbpMsRyju6NoK5n
         SbLa9xEq1t4yMff80JGE0tqmnmfe0lLYkh/RgcnS7G3Krzw/MMRvbI8RYFx1mZHKkL
         9KB0tA/+shUgQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] NFSv4: Add lease breakpoints in case of a delegation recall or return
Date:   Thu, 20 May 2021 12:39:00 -0400
Message-Id: <20210520163902.215745-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520163902.215745-2-trondmy@kernel.org>
References: <20210520163902.215745-1-trondmy@kernel.org>
 <20210520163902.215745-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we add support for application level leases and knfsd delegations
to the NFS client, we we want to have them safely underpinned by a
"real" delegation to provide the caching guarantees. If that real
delegation is recalled, then we need to ensure that the application
leases/delegations are recalled too.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/delegation.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index 7c45ac3c3b0b..11118398f495 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -530,11 +530,18 @@ int nfs_inode_set_delegation(struct inode *inode, const struct cred *cred,
 static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation *delegation, int issync)
 {
 	struct nfs_client *clp = NFS_SERVER(inode)->nfs_client;
+	unsigned int mode = O_WRONLY | O_RDWR;
 	int err = 0;
 
 	if (delegation == NULL)
 		return 0;
-	do {
+
+	if (!issync)
+		mode |= O_NONBLOCK;
+	/* Recall of any remaining application leases */
+	err = break_lease(inode, mode);
+
+	while (err == 0) {
 		if (test_bit(NFS_DELEGATION_REVOKED, &delegation->flags))
 			break;
 		err = nfs_delegation_claim_opens(inode, &delegation->stateid,
@@ -545,7 +552,7 @@ static int nfs_end_delegation_return(struct inode *inode, struct nfs_delegation
 		 * Guard against state recovery
 		 */
 		err = nfs4_wait_clnt_recover(clp);
-	} while (err == 0);
+	}
 
 	if (err) {
 		nfs_abort_delegation_return(delegation, clp, err);
@@ -746,13 +753,14 @@ int nfs4_inode_return_delegation(struct inode *inode)
 {
 	struct nfs_inode *nfsi = NFS_I(inode);
 	struct nfs_delegation *delegation;
-	int err = 0;
 
-	nfs_wb_all(inode);
 	delegation = nfs_start_delegation_return(nfsi);
+	/* Synchronous recall of any application leases */
+	break_lease(inode, O_WRONLY | O_RDWR);
+	nfs_wb_all(inode);
 	if (delegation != NULL)
-		err = nfs_end_delegation_return(inode, delegation, 1);
-	return err;
+		return nfs_end_delegation_return(inode, delegation, 1);
+	return 0;
 }
 
 /**
@@ -1051,6 +1059,9 @@ int nfs_async_inode_return_delegation(struct inode *inode,
 	nfs_mark_return_delegation(server, delegation);
 	rcu_read_unlock();
 
+	/* If there are any application leases or delegations, recall them */
+	break_lease(inode, O_WRONLY | O_RDWR | O_NONBLOCK);
+
 	nfs_delegation_run_state_manager(clp);
 	return 0;
 out_enoent:
-- 
2.31.1

