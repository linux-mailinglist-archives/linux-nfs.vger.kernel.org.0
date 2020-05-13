Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4701D2240
	for <lists+linux-nfs@lfdr.de>; Thu, 14 May 2020 00:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbgEMWny (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 May 2020 18:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgEMWnx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 May 2020 18:43:53 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08731204EF
        for <linux-nfs@vger.kernel.org>; Wed, 13 May 2020 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589409833;
        bh=RBvILxO3fIBJpS47UJWk9PAICzYABxE4O0cUZFARiIQ=;
        h=From:To:Subject:Date:From;
        b=UGU17S1MFp8Ni1O8S49kmUkD0Lvbhqt/kAUWLggRAr37u/t7ceQlELp24p8UtlBmz
         7lljn+Lws2jdVhtBZEL36z6QzF5xZ1gCK4UNsLvdfdMbg67Qx5SByQtUvDGD20oGuL
         juq52R02pAGPHByMz505RAHsNaCsy3xvN/7fIsqM=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] NFS/pnfs: Don't use RPC_TASK_CRED_NOREF with pnfs
Date:   Wed, 13 May 2020 18:41:44 -0400
Message-Id: <20200513224144.53043-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we're doing pnfs then the credential being used for the RPC call
is not necessarily the same as the one used in the open context, so
don't use RPC_TASK_CRED_NOREF.

Fixes: 612965072020 ("NFSv4: Avoid referencing the cred unnecessarily during NFSv4 I/O")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/pagelist.c | 5 +++--
 fs/nfs/pnfs_nfs.c | 3 ++-
 fs/nfs/write.c    | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index f61f96603df7..6ca421cbe19c 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -752,7 +752,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		.callback_ops = call_ops,
 		.callback_data = hdr,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF | flags,
+		.flags = RPC_TASK_ASYNC | flags,
 	};
 
 	hdr->rw_ops->rw_initiate(hdr, &msg, rpc_ops, &task_setup_data, how);
@@ -950,7 +950,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					hdr->cred,
 					NFS_PROTO(hdr->inode),
 					desc->pg_rpc_callops,
-					desc->pg_ioflags, 0);
+					desc->pg_ioflags,
+					RPC_TASK_CRED_NOREF);
 	return ret;
 }
 
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index e7ddbce48321..679767ac258d 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -536,7 +536,8 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 			nfs_init_commit(data, NULL, NULL, cinfo);
 			nfs_initiate_commit(NFS_CLIENT(inode), data,
 					    NFS_PROTO(data->inode),
-					    data->mds_ops, how, 0);
+					    data->mds_ops, how,
+					    RPC_TASK_CRED_NOREF);
 		} else {
 			nfs_init_commit(data, NULL, data->lseg, cinfo);
 			initiate_commit(data, how);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index df4b87c30ac9..1e767f779c49 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1695,7 +1695,7 @@ int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 		.callback_ops = call_ops,
 		.callback_data = data,
 		.workqueue = nfsiod_workqueue,
-		.flags = RPC_TASK_ASYNC | RPC_TASK_CRED_NOREF | flags,
+		.flags = RPC_TASK_ASYNC | flags,
 		.priority = priority,
 	};
 	/* Set up the initial task struct.  */
@@ -1813,7 +1813,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 	nfs_init_commit(data, head, NULL, cinfo);
 	atomic_inc(&cinfo->mds->rpcs_out);
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
-				   data->mds_ops, how, 0);
+				   data->mds_ops, how, RPC_TASK_CRED_NOREF);
 }
 
 /*
-- 
2.26.2

