Return-Path: <linux-nfs+bounces-4090-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E490F799
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8241F228A9
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E4159217;
	Wed, 19 Jun 2024 20:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDnCSIau"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051E7159204
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829636; cv=none; b=n1Muwl4KQuXKUxxej8RWeWrTeFyuw4P4QyP95F6sv27k+mbP131XhIrb+cen+gouIWHh5unNSAsFJXNpkg0l4X8EfVNq6GxXisJwzQ8+MMIJ7YZvwEJiqlsiuL/rMiaWWs03ZFfV2VOFk2qtiQ0+FjpwufaVbJ4iMM+wMSFSSWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829636; c=relaxed/simple;
	bh=zqo5A9VtZlcvmmu0XkGwH+wtxeFhmulZftxFgSSuOAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRFoDUWJJ1rrNzyn1U+aXCN6zqIu06xnVDDxaB6DnZQYVDJ4th6onYWESxbqxa7Q/2l4qB8/RvlPb8ZiRgGid2/lWtM3D2WN+CeRu/fo5nMLJR7I9kn+hc2lcYghpmjSu/ltlcvYEHAFWLSsEPjNon5ziUZTXrn/3+fUYNPtZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDnCSIau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54649C4AF09;
	Wed, 19 Jun 2024 20:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829635;
	bh=zqo5A9VtZlcvmmu0XkGwH+wtxeFhmulZftxFgSSuOAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TDnCSIaumf92xNB3X4bZyBwVVPNId6vcg7B766F5P4VQjlF7YHlzXKIvL0iBGCpy3
	 guwGnVXQ95mCjgN+QCRFAhP9Kfv17J9lYgU5WdJNn3SWLJlKWXSDn26ZuyYXfUed08
	 40Q4pHbW99GRuCyFSAN50xUUFos2ORFq5LvIGTrFXuka4h+t7Owun2OxPNFgwRJc9g
	 DK/RH33jTj+/NTihnsP7vfgj3a8/T1PGEI7ERJZgojJ/lEBQv7iIkbZGQ/L2i/KvbV
	 SUeLcfkAkO6ilBoSzzo/SzFiTyDnSkb2pIouZ1WMI47hnCGe5B2iMOw+FUQVWvVeeC
	 imqlfUwAVCa7w==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 01/18] nfs: pass nfs_client to nfs_initiate_pgio
Date: Wed, 19 Jun 2024 16:40:15 -0400
Message-ID: <20240619204032.93740-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weston Andros Adamson <dros@primarydata.com>

The nfs_client is needed for localio support. Otherwise it won't be
possible to disable localio if it is attempted but fails.

Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/filelayout/filelayout.c         |  4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c |  6 ++++--
 fs/nfs/internal.h                      |  5 +++--
 fs/nfs/pagelist.c                      | 10 ++++++----
 4 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 29d84dc66ca3..43e16e9e0176 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -486,7 +486,7 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Perform an asynchronous read to ds */
-	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
 			  0, RPC_TASK_SOFTCONN);
 	return PNFS_ATTEMPTED;
@@ -528,7 +528,7 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = filelayout_get_dserver_offset(lseg, offset);
 
 	/* Perform an asynchronous write */
-	nfs_initiate_pgio(ds_clnt, hdr, hdr->cred,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
 			  sync, RPC_TASK_SOFTCONN);
 	return PNFS_ATTEMPTED;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 24188af56d5b..327f1a5c9fbe 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1803,7 +1803,8 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Perform an asynchronous read to ds */
-	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
+			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
 			  0, RPC_TASK_SOFTCONN);
@@ -1871,7 +1872,8 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Perform an asynchronous write */
-	nfs_initiate_pgio(ds_clnt, hdr, ds_cred, ds->ds_clp->rpc_ops,
+	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
+			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
 			  sync, RPC_TASK_SOFTCONN);
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 9f0f4534744b..a9c0c29f7804 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -306,8 +306,9 @@ extern const struct nfs_pageio_ops nfs_pgio_rw_ops;
 struct nfs_pgio_header *nfs_pgio_header_alloc(const struct nfs_rw_ops *);
 void nfs_pgio_header_free(struct nfs_pgio_header *);
 int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
-int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
-		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
+int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
+		      struct nfs_pgio_header *hdr, const struct cred *cred,
+		      const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index 6efb5068c116..d9b795c538cd 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -844,8 +844,9 @@ static void nfs_pgio_prepare(struct rpc_task *task, void *calldata)
 		rpc_exit(task, err);
 }
 
-int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
-		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
+int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
+		      struct nfs_pgio_header *hdr, const struct cred *cred,
+		      const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags)
 {
 	struct rpc_task *task;
@@ -855,7 +856,7 @@ int nfs_initiate_pgio(struct rpc_clnt *clnt, struct nfs_pgio_header *hdr,
 		.rpc_cred = cred,
 	};
 	struct rpc_task_setup task_setup_data = {
-		.rpc_client = clnt,
+		.rpc_client = rpc_clnt,
 		.task = &hdr->task,
 		.rpc_message = &msg,
 		.callback_ops = call_ops,
@@ -1070,7 +1071,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	if (ret == 0) {
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
-		ret = nfs_initiate_pgio(NFS_CLIENT(hdr->inode),
+		ret = nfs_initiate_pgio(NFS_SERVER(hdr->inode)->nfs_client,
+					NFS_CLIENT(hdr->inode),
 					hdr,
 					hdr->cred,
 					NFS_PROTO(hdr->inode),
-- 
2.44.0


