Return-Path: <linux-nfs+bounces-4327-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5ED918E4E
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 20:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0EC28CF04
	for <lists+linux-nfs@lfdr.de>; Wed, 26 Jun 2024 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FF19049F;
	Wed, 26 Jun 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHO+8oqI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D8719047F
	for <linux-nfs@vger.kernel.org>; Wed, 26 Jun 2024 18:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426282; cv=none; b=RyNY75likIIBWG9Lg5ai/KnN53roIfuKIiGqYBb6fOynwYq33MopSXrjtPjJgza7ZiEnXJYQTw+mHmTwyt1HuzjSCuW84Ll2PIkUCIYxduhsjr/CgkS+YE2SXunGSrF59oIgU1FogkWZ66ipHQs5D03dDGI0QETRqqRuwah0vr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426282; c=relaxed/simple;
	bh=YJoyVHLFZHGnnH7iXlxdzrZ6OyrIVltCHpztKjaNMD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mi1wp4fH3bbwoV1DLhIgmcfddEDJUEvKiN3FHXpc6Bu3tLMEg03bd/ZUbfxfag5v6BrLFMYhRFeXHbGgnCiNupi/LtIsPa+ENpcnGMtBPiBa6GxnA4t7bKji5tGT70YZOC1ffYemC454MpZyClJq70zChsMNBisnT9rC1teOctc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHO+8oqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292FEC116B1;
	Wed, 26 Jun 2024 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719426282;
	bh=YJoyVHLFZHGnnH7iXlxdzrZ6OyrIVltCHpztKjaNMD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHO+8oqIxvmrIoZFXHW6nuhPnF79EO5CqgvD0avlbSMozfrqr7/zhxGPHHWyWKvBH
	 1ndHXQCMMLw5BJL2XvUhO7VdtwdPaSyT6ik0po1TaI7SgMcrUpF5iPr5Lse72H9ExJ
	 wsffdzu+ejHhWWj2rd4UZyG3IlzPXFmwb9n+nCzglUmZZnnH26NWWjbW6G7dCjW+Ef
	 3yAcDi6LWNWuwpvnpV7xW78rsvxbho8z4Wx2Zu3xt8r6caGWY1ZThVbNlFhG59CHtz
	 h0R4pNb+45JEpc1WJDw5sk+aqExBO0H2X06/kCnIuN61+jkEddqQEFX7xHby5LdoWo
	 3BHuxOOQPeWFg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v8 02/18] nfs: pass descriptor thru nfs_initiate_pgio path
Date: Wed, 26 Jun 2024 14:24:22 -0400
Message-ID: <20240626182438.69539-3-snitzer@kernel.org>
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
Signed-off-by: Peng Tao <tao.peng@primarydata.com>
Signed-off-by: Lance Shelton <lance.shelton@hammerspace.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/blocklayout/blocklayout.c       |  6 ++++--
 fs/nfs/filelayout/filelayout.c         | 10 ++++++----
 fs/nfs/flexfilelayout/flexfilelayout.c | 10 ++++++----
 fs/nfs/internal.h                      |  6 +++---
 fs/nfs/pagelist.c                      |  6 ++++--
 fs/nfs/pnfs.c                          | 24 +++++++++++++-----------
 fs/nfs/pnfs.h                          |  6 ++++--
 7 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 6be13e0ec170..6a61ddd1835f 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -227,7 +227,8 @@ bl_end_par_io_read(void *data)
 }
 
 static enum pnfs_try_status
-bl_read_pagelist(struct nfs_pgio_header *header)
+bl_read_pagelist(struct nfs_pageio_descriptor *desc,
+		 struct nfs_pgio_header *header)
 {
 	struct pnfs_block_layout *bl = BLK_LSEG2EXT(header->lseg);
 	struct pnfs_block_dev_map map = { .start = NFS4_MAX_UINT64 };
@@ -372,7 +373,8 @@ static void bl_end_par_io_write(void *data)
 }
 
 static enum pnfs_try_status
-bl_write_pagelist(struct nfs_pgio_header *header, int sync)
+bl_write_pagelist(struct nfs_pageio_descriptor *desc,
+		  struct nfs_pgio_header *header, int sync)
 {
 	struct pnfs_block_layout *bl = BLK_LSEG2EXT(header->lseg);
 	struct pnfs_block_dev_map map = { .start = NFS4_MAX_UINT64 };
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 43e16e9e0176..f9b600c4a2b5 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -447,7 +447,8 @@ static const struct rpc_call_ops filelayout_commit_call_ops = {
 };
 
 static enum pnfs_try_status
-filelayout_read_pagelist(struct nfs_pgio_header *hdr)
+filelayout_read_pagelist(struct nfs_pageio_descriptor *desc,
+			 struct nfs_pgio_header *hdr)
 {
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
@@ -486,7 +487,7 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Perform an asynchronous read to ds */
-	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
+	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_read_call_ops,
 			  0, RPC_TASK_SOFTCONN);
 	return PNFS_ATTEMPTED;
@@ -494,7 +495,8 @@ filelayout_read_pagelist(struct nfs_pgio_header *hdr)
 
 /* Perform async writes. */
 static enum pnfs_try_status
-filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
+filelayout_write_pagelist(struct nfs_pageio_descriptor *desc,
+			  struct nfs_pgio_header *hdr, int sync)
 {
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
@@ -528,7 +530,7 @@ filelayout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = filelayout_get_dserver_offset(lseg, offset);
 
 	/* Perform an asynchronous write */
-	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, hdr->cred,
+	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, hdr->cred,
 			  NFS_PROTO(hdr->inode), &filelayout_write_call_ops,
 			  sync, RPC_TASK_SOFTCONN);
 	return PNFS_ATTEMPTED;
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 327f1a5c9fbe..22c0e8014afb 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1751,7 +1751,8 @@ static const struct rpc_call_ops ff_layout_commit_call_ops_v4 = {
 };
 
 static enum pnfs_try_status
-ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
+ff_layout_read_pagelist(struct nfs_pageio_descriptor *desc,
+			struct nfs_pgio_header *hdr)
 {
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
@@ -1803,7 +1804,7 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 	hdr->mds_offset = offset;
 
 	/* Perform an asynchronous read to ds */
-	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
+	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, ds_cred,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_read_call_ops_v3 :
 				      &ff_layout_read_call_ops_v4,
@@ -1822,7 +1823,8 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 
 /* Perform async writes. */
 static enum pnfs_try_status
-ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
+ff_layout_write_pagelist(struct nfs_pageio_descriptor *desc,
+			 struct nfs_pgio_header *hdr, int sync)
 {
 	struct pnfs_layout_segment *lseg = hdr->lseg;
 	struct nfs4_pnfs_ds *ds;
@@ -1872,7 +1874,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	hdr->args.offset = offset;
 
 	/* Perform an asynchronous write */
-	nfs_initiate_pgio(ds->ds_clp, ds_clnt, hdr, ds_cred,
+	nfs_initiate_pgio(desc, ds->ds_clp, ds_clnt, hdr, ds_cred,
 			  ds->ds_clp->rpc_ops,
 			  vers == 3 ? &ff_layout_write_call_ops_v3 :
 				      &ff_layout_write_call_ops_v4,
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a9c0c29f7804..f6e56fdd8bc2 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -306,9 +306,9 @@ extern const struct nfs_pageio_ops nfs_pgio_rw_ops;
 struct nfs_pgio_header *nfs_pgio_header_alloc(const struct nfs_rw_ops *);
 void nfs_pgio_header_free(struct nfs_pgio_header *);
 int nfs_generic_pgio(struct nfs_pageio_descriptor *, struct nfs_pgio_header *);
-int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
-		      struct nfs_pgio_header *hdr, const struct cred *cred,
-		      const struct nfs_rpc_ops *rpc_ops,
+int nfs_initiate_pgio(struct nfs_pageio_descriptor *, struct nfs_client *clp,
+		      struct rpc_clnt *rpc_clnt, struct nfs_pgio_header *hdr,
+		      const struct cred *cred, const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags);
 void nfs_free_request(struct nfs_page *req);
 struct nfs_pgio_mirror *
diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
index d9b795c538cd..3786d767e2ff 100644
--- a/fs/nfs/pagelist.c
+++ b/fs/nfs/pagelist.c
@@ -844,7 +844,8 @@ static void nfs_pgio_prepare(struct rpc_task *task, void *calldata)
 		rpc_exit(task, err);
 }
 
-int nfs_initiate_pgio(struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
+int nfs_initiate_pgio(struct nfs_pageio_descriptor *desc,
+		      struct nfs_client *clp, struct rpc_clnt *rpc_clnt,
 		      struct nfs_pgio_header *hdr, const struct cred *cred,
 		      const struct nfs_rpc_ops *rpc_ops,
 		      const struct rpc_call_ops *call_ops, int how, int flags)
@@ -1071,7 +1072,8 @@ static int nfs_generic_pg_pgios(struct nfs_pageio_descriptor *desc)
 	if (ret == 0) {
 		if (NFS_SERVER(hdr->inode)->nfs_client->cl_minorversion)
 			task_flags = RPC_TASK_MOVEABLE;
-		ret = nfs_initiate_pgio(NFS_SERVER(hdr->inode)->nfs_client,
+		ret = nfs_initiate_pgio(desc,
+					NFS_SERVER(hdr->inode)->nfs_client,
 					NFS_CLIENT(hdr->inode),
 					hdr,
 					hdr->cred,
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index b5834728f31b..c9015179b72c 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -2885,10 +2885,11 @@ pnfs_write_through_mds(struct nfs_pageio_descriptor *desc,
 }
 
 static enum pnfs_try_status
-pnfs_try_to_write_data(struct nfs_pgio_header *hdr,
-			const struct rpc_call_ops *call_ops,
-			struct pnfs_layout_segment *lseg,
-			int how)
+pnfs_try_to_write_data(struct nfs_pageio_descriptor *desc,
+		       struct nfs_pgio_header *hdr,
+		       const struct rpc_call_ops *call_ops,
+		       struct pnfs_layout_segment *lseg,
+		       int how)
 {
 	struct inode *inode = hdr->inode;
 	enum pnfs_try_status trypnfs;
@@ -2898,7 +2899,7 @@ pnfs_try_to_write_data(struct nfs_pgio_header *hdr,
 
 	dprintk("%s: Writing ino:%lu %u@%llu (how %d)\n", __func__,
 		inode->i_ino, hdr->args.count, hdr->args.offset, how);
-	trypnfs = nfss->pnfs_curr_ld->write_pagelist(hdr, how);
+	trypnfs = nfss->pnfs_curr_ld->write_pagelist(desc, hdr, how);
 	if (trypnfs != PNFS_NOT_ATTEMPTED)
 		nfs_inc_stats(inode, NFSIOS_PNFS_WRITE);
 	dprintk("%s End (trypnfs:%d)\n", __func__, trypnfs);
@@ -2913,7 +2914,7 @@ pnfs_do_write(struct nfs_pageio_descriptor *desc,
 	struct pnfs_layout_segment *lseg = desc->pg_lseg;
 	enum pnfs_try_status trypnfs;
 
-	trypnfs = pnfs_try_to_write_data(hdr, call_ops, lseg, how);
+	trypnfs = pnfs_try_to_write_data(desc, hdr, call_ops, lseg, how);
 	switch (trypnfs) {
 	case PNFS_NOT_ATTEMPTED:
 		pnfs_write_through_mds(desc, hdr);
@@ -3012,9 +3013,10 @@ pnfs_read_through_mds(struct nfs_pageio_descriptor *desc,
  * Call the appropriate parallel I/O subsystem read function.
  */
 static enum pnfs_try_status
-pnfs_try_to_read_data(struct nfs_pgio_header *hdr,
-		       const struct rpc_call_ops *call_ops,
-		       struct pnfs_layout_segment *lseg)
+pnfs_try_to_read_data(struct nfs_pageio_descriptor *desc,
+		      struct nfs_pgio_header *hdr,
+		      const struct rpc_call_ops *call_ops,
+		      struct pnfs_layout_segment *lseg)
 {
 	struct inode *inode = hdr->inode;
 	struct nfs_server *nfss = NFS_SERVER(inode);
@@ -3025,7 +3027,7 @@ pnfs_try_to_read_data(struct nfs_pgio_header *hdr,
 	dprintk("%s: Reading ino:%lu %u@%llu\n",
 		__func__, inode->i_ino, hdr->args.count, hdr->args.offset);
 
-	trypnfs = nfss->pnfs_curr_ld->read_pagelist(hdr);
+	trypnfs = nfss->pnfs_curr_ld->read_pagelist(desc, hdr);
 	if (trypnfs != PNFS_NOT_ATTEMPTED)
 		nfs_inc_stats(inode, NFSIOS_PNFS_READ);
 	dprintk("%s End (trypnfs:%d)\n", __func__, trypnfs);
@@ -3058,7 +3060,7 @@ pnfs_do_read(struct nfs_pageio_descriptor *desc, struct nfs_pgio_header *hdr)
 	struct pnfs_layout_segment *lseg = desc->pg_lseg;
 	enum pnfs_try_status trypnfs;
 
-	trypnfs = pnfs_try_to_read_data(hdr, call_ops, lseg);
+	trypnfs = pnfs_try_to_read_data(desc, hdr, call_ops, lseg);
 	switch (trypnfs) {
 	case PNFS_NOT_ATTEMPTED:
 		pnfs_read_through_mds(desc, hdr);
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index fa5beeaaf5da..92acb837cfa6 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -157,8 +157,10 @@ struct pnfs_layoutdriver_type {
 	 * Return PNFS_ATTEMPTED to indicate the layout code has attempted
 	 * I/O, else return PNFS_NOT_ATTEMPTED to fall back to normal NFS
 	 */
-	enum pnfs_try_status (*read_pagelist)(struct nfs_pgio_header *);
-	enum pnfs_try_status (*write_pagelist)(struct nfs_pgio_header *, int);
+	enum pnfs_try_status (*read_pagelist)(struct nfs_pageio_descriptor *,
+					      struct nfs_pgio_header *);
+	enum pnfs_try_status (*write_pagelist)(struct nfs_pageio_descriptor *,
+					       struct nfs_pgio_header *, int);
 
 	void (*free_deviceid_node) (struct nfs4_deviceid_node *);
 	struct nfs4_deviceid_node * (*alloc_deviceid_node)
-- 
2.44.0


