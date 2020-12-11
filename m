Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5529B2D7CDB
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Dec 2020 18:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404715AbgLKR1m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Dec 2020 12:27:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395148AbgLKR1A (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 11 Dec 2020 12:27:00 -0500
From:   trondmy@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 15/15] NFSv4.2/pnfs: Don't use READ_PLUS with pNFS yet
Date:   Fri, 11 Dec 2020 12:25:21 -0500
Message-Id: <20201211172521.5567-16-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211172521.5567-15-trondmy@kernel.org>
References: <20201211172521.5567-1-trondmy@kernel.org>
 <20201211172521.5567-2-trondmy@kernel.org>
 <20201211172521.5567-3-trondmy@kernel.org>
 <20201211172521.5567-4-trondmy@kernel.org>
 <20201211172521.5567-5-trondmy@kernel.org>
 <20201211172521.5567-6-trondmy@kernel.org>
 <20201211172521.5567-7-trondmy@kernel.org>
 <20201211172521.5567-8-trondmy@kernel.org>
 <20201211172521.5567-9-trondmy@kernel.org>
 <20201211172521.5567-10-trondmy@kernel.org>
 <20201211172521.5567-11-trondmy@kernel.org>
 <20201211172521.5567-12-trondmy@kernel.org>
 <20201211172521.5567-13-trondmy@kernel.org>
 <20201211172521.5567-14-trondmy@kernel.org>
 <20201211172521.5567-15-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We have no way of tracking server READ_PLUS support in pNFS for now, so
just disable it.

Reported-by: "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 7ab40d0e6a74..61a07dcb963d 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -5320,17 +5320,17 @@ static int nfs4_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 }
 
 #ifdef CONFIG_NFS_V4_2
-static void nfs42_read_plus_support(struct nfs_server *server, struct rpc_message *msg)
+static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+				    struct rpc_message *msg)
 {
-	if (server->caps & NFS_CAP_READ_PLUS)
+	/* Note: We don't use READ_PLUS with pNFS yet */
+	if (nfs_server_capable(hdr->inode, NFS_CAP_READ_PLUS) && !hdr->ds_clp)
 		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ_PLUS];
-	else
-		msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 }
 #else
-static void nfs42_read_plus_support(struct nfs_server *server, struct rpc_message *msg)
+static void nfs42_read_plus_support(struct nfs_pgio_header *hdr,
+				    struct rpc_message *msg)
 {
-	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
 }
 #endif /* CONFIG_NFS_V4_2 */
 
@@ -5340,7 +5340,8 @@ static void nfs4_proc_read_setup(struct nfs_pgio_header *hdr,
 	hdr->timestamp   = jiffies;
 	if (!hdr->pgio_done_cb)
 		hdr->pgio_done_cb = nfs4_read_done_cb;
-	nfs42_read_plus_support(NFS_SERVER(hdr->inode), msg);
+	msg->rpc_proc = &nfs4_procedures[NFSPROC4_CLNT_READ];
+	nfs42_read_plus_support(hdr, msg);
 	nfs4_init_sequence(&hdr->args.seq_args, &hdr->res.seq_res, 0, 0);
 }
 
-- 
2.29.2

