Return-Path: <linux-nfs+bounces-4328-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3F5918E4F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018AE28CE4F
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC1419066E;
	Wed, 26 Jun 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvS9UKfH"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0941619047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426284; cv=none; b=cvtPVbTNUzjuQdzQfnpLUfyiobtpyzF4J/wmm5GsT6jik0KC6Hz4Nj2gwJfKqCQVm99H9SESC7rRadQ0v+3/rsi8xK4NF7XJ7XXEt6Qt2E3cKXSEZ+75z/BJY70hgyd3R90BGG2nJA1TjRyfJGK38jXiqYo6fcRFzJ4yhM2x3hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426284; c=relaxed/simple;
	bh=c62d+ZXcPpDaY/PyiTod1QnTXLKtUvBe/2Fn296kbD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gj/gxVCYX5HyoHFcYE2VG9mcmHKu0HhTe1vkPBrLQlhiLPFxi2vB19Qf+4MEk1MHfWESB7qU1U4CRsq3VBZloPr4ryQF29CkW13TDIWz8fsht6WChjtYj1gXBNAgAaZcsympMfGHs2euCZTnYdPpISYoGaqFPMIfu3DfKH9d0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvS9UKfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BB6C116B1;
	Wed, 26 Jun 2024 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426283;
	bh=c62d+ZXcPpDaY/PyiTod1QnTXLKtUvBe/2Fn296kbD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvS9UKfHRJCDSyBTEGw2CxIVRxlkhpe2BiawF73WsCUZ864/tc5c3MfWJNSDF65ef
	 wOUwNE8fUUMHHk1/mxD+WWPLWXnDQdNuKdtuD+/1oPt++I0MsIdaHmcXBJxL/BRlmS
	 IztNTSZNcWs/XV8spHeBiYsfLpY7tN6OFWGm1HoDsN/hWzaz0Oura0rwjYj8edzMp8
	 94tEbrLsRh/PpNYm/qbIqtmpdgrd1mK0xTwK3L7gZJk0AdLOaWEkTgZ0WNSbjh+JUD
	 4XcuoB5vFUUY3c7O31GaxPynTNwwRr2WzQ3N1HsjfpoPKbZo7D/T7Wvbj+G4YnOH/R
	 PU6izZOPI0BMw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 03/18] nfs: pass struct file to nfs_init_pgio and nfs_init_commit
Date: Wed, 26 Jun 2024 14:24:23 -0400
Message-ID: <20240626182438.69539-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240626182438.69539-1-snitzer@kernel.org>
References: <20240626182438.69539-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

This is needed for localio support.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/filelayout/filelayout.c         | 6 +++---
 fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
 fs/nfs/internal.h                      | 6 ++++--
 fs/nfs/pagelist.c                      | 6 ++++--
 fs/nfs/pnfs_nfs.c                      | 2 +-
 fs/nfs/write.c                         | 5 +++--
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index f9b600c4a2b5..b9e5e7bd15ca 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -489,7 +489,7 @@ filelayout_read_pagelist(struct nfs_pageio_descriptor *desc,
 	/* Perform an asynchronous read to ds */
 	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
-			  0, RPC_TASK_SOFTCONN);
+			  0, RPC_TASK_SOFTCONN, NULL);
 	return PNFS_ATTEMPTED;
 }
 
@@ -532,7 +532,7 @@ filelayout_write_pagelist(struct nfs_pageio_descriptor *desc,
 	/* Perform an asynchronous write */
 	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
-			  sync, RPC_TASK_SOFTCONN);
+			  sync, RPC_TASK_SOFTCONN, NULL);
 	return PNFS_ATTEMPTED;
 }
 
@@ -1013,7 +1013,7 @@ static int filelayout_initiate_commit(struct nfs_commit_data *data, int how)
 		data->args.fh = fh;
 	return nfs_initiate_commit(ds_clnt, data, NFS_PROTO(data->inode),
 				   &filelayout_commit_call_ops, how,
-				   RPC_TASK_SOFTCONN);
+				   RPC_TASK_SOFTCONN, NULL);
 out_err:
 	pnfs_generic_prepare_to_resend_writes(data);
 	pnfs_generic_commit_release(data);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 22c0e8014afb..3ea07446f05a 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1808,7 +1808,7 @@ ff_layout_read_pagelist(struct nfs_pageio_descriptor *desc,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
-			  0, RPC_TASK_SOFTCONN);
+			  0, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1878,7 +1878,7 @@ ff_layout_write_pagelist(struct nfs_pageio_descriptor *desc,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
-			  sync, RPC_TASK_SOFTCONN);
+			  sync, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return PNFS_ATTEMPTED;
 
@@ -1953,7 +1953,7 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	ret = nfs_initiate_commit(ds_clnt, data, ds->ds_clp->rpc_ops,
 				   vers == 3 ? &ff_layout_commit_call_ops_v3 :
 					       &ff_layout_commit_call_ops_v4,
-				   how, RPC_TASK_SOFTCONN);
+				   how, RPC_TASK_SOFTCONN, NULL);
 	put_cred(ds_cred);
 	return ret;
 out_err:
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index f6e56fdd8bc2..958c8de072e2 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -309,7 +309,8 @@ int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
 int nfs_initiate_pgio(struct nfs_pageio_descriptor *, struct nfs_client *clp,
 		      struct rpc_clnt *rpc_clnt, struct nfs_pgio_header *hdr,
 		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags);
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct file *localio);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
 nfs_pgio_current_mirror(struct nfs_pageio_descriptor *desc);
@@ -529,7 +530,8 @@ extern int nfs_initiate_commit(struct rpc_clnt *clnt,
 			       struct nfs_commit_data *data,
 			       const struct nfs_rpc_ops *nfs_ops,
 			       const struct rpc_call_ops *call_ops,
-			       int how, int flags);
+			       int how, int flags,
+			       struct file *localio);
 extern void nfs_init_commit(struct nfs_commit_data *data,
 			    struct list_head *head,
 			    struct pnfs_layout_segment *lseg,
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 3786d767e2ff..57d62db3be5b 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -848,7 +848,8 @@ int nfs_initiate_pgio(struct nfs_pageio_descriptor *desc,
 		      struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
 		      struct nfs_pgio_header *hdr, const struct cred *cred,
 		      const struct nfs_rpc_ops *rpc_ops,
-		      const struct rpc_call_ops *call_ops, int how, int flags)
+		      const struct rpc_call_ops *call_ops, int how, int flags,
+		      struct file *localio)
 {
 	struct rpc_task *task;
 	struct rpc_message msg = {
@@ -1080,7 +1081,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 					NFS_PROTO(hdr->inode),
 					desc->pg_rpc_callops,
 					desc->pg_ioflags,
-					RPC_TASK_CRED_NOREF | task_flags);
+					RPC_TASK_CRED_NOREF | task_flags,
+					NULL);
 	}
 	return ret;
 }
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 88e061bd711b..ecfde2649cf3 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -537,7 +537,7 @@ pnfs_generic_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 			nfs_initiate_commit(NFS_CLIENT(inode), data,
 					    NFS_PROTO(data->inode),
 					    data->mds_ops, how,
-					    RPC_TASK_CRED_NOREF);
+					    RPC_TASK_CRED_NOREF, NULL);
 		} else {
 			nfs_init_commit(data, NULL, data->lseg, cinfo);
 			initiate_commit(data, how);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 2329cbb0e446..267bed2a4ceb 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1670,7 +1670,8 @@ EXPORT_SYMBOL_GPL(nfs_commitdata_release);
 int nfs_initiate_commit(struct rpc_clnt *clnt, struct nfs_commit_data *data,
 			const struct nfs_rpc_ops *nfs_ops,
 			const struct rpc_call_ops *call_ops,
-			int how, int flags)
+			int how, int flags,
+			struct file *localio)
 {
 	struct rpc_task *task;
 	int priority = flush_task_priority(how);
@@ -1816,7 +1817,7 @@ nfs_commit_list(struct inode *inode, struct list_head *head, int how,
 		task_flags = RPC_TASK_MOVEABLE;
 	return nfs_initiate_commit(NFS_CLIENT(inode), data, NFS_PROTO(inode),
 				   data->mds_ops, how,
-				   RPC_TASK_CRED_NOREF | task_flags);
+				   RPC_TASK_CRED_NOREF | task_flags, NULL);
 }
 
 /*
-- 
2.44.0


