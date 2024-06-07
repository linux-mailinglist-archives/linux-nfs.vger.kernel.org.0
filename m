Return-Path: <linux-nfs+bounces-3588-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C1590067C
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4383BB22DE4
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2024 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1A019645E;
	Fri,  7 Jun 2024 14:26:56 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA01667DE
	for <linux-nfs@vger.kernel.org>; Fri,  7 Jun 2024 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770416; cv=none; b=L8f3XW9dcJajJaIOFQbX6xL99qRgC9EsJfk7V/uy888XSFhe9i3OnCUa6RD3HTt8pkTx1qFGn60bzLMrqxJzsSv71EkN13B6zEjF2q7HDXG8Rcjm1o4LGL4g9tVS5FR6IDR9ujp/28yVBTT0w/7NeJq9Pq8tUnCk7YYR6V+8sPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770416; c=relaxed/simple;
	bh=jjocYvr+4nHiR3wPjCPa2xk142Cb5Q/4WNeBiQuhffU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KP2ofDzqOVDuC27uwl6+5D4u5zu5w6eADQxHlMU15av7wb75M8M3puSS3JTmlJUW+2uDwTNrEBKsMum9gvwiNdzrahHZR5WYUY2vbw8/KrrH/askAbyU7WO4RAFLqoFP2lQJry2WO1dv8AMEwJ2mGhjkVUXrxTM3/FsbNT24HjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-43fb094da40so28208741cf.0
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2024 07:26:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717770413; x=1718375213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ndbqk3syWYWtZFZ1ST2eyB3vmpA4WXtlK9sHUhfw4rc=;
        b=JWrW65mzjRLl5FAcznXEKNTkbvg2DgU9r5OozIKBotykxOxwT2MViS62NEcnv/qHYi
         GK/U3JlIHKB3LAXBHdmvAQSrBREYIS2KWY3URb2dPt9kEYY7GgBi8cgl1KW6sxpBvVtP
         cHaOPhlCQlnegcGj899nURq1YBWPMK+GPD+sguHafK962f5czd+DU8d7ekRE2cDPB8yy
         OfXLHKv02aVggq5pxFp3bfRFp5/wOz4BkYUvv34O8thKfSpkuw+lD2ejrzswoRmbBxqU
         uIQZjH4DhQtOp7Ep71q2pCpiq/Ko251YB/yWxcgdmErfUUDxJUrWmCsXraxKYB2RMeBV
         me2Q==
X-Gm-Message-State: AOJu0Yx/yRn9mqH3C78VC6KKmVpmvW2vvwhryyY8lilpR8rng0oTInBA
	8QGuw9IW7RtlooZLn2l4WqXxEq8WMib1OwAvil/dROkvk7Vki4jA/u+9EAUtnDbA1/x58auH4aB
	4GRnwjQ==
X-Google-Smtp-Source: AGHT+IFaMDfbx7aqmkoEY5zVl95Q89r5WzjBMpNO2dUe5Hz+wDr8I7B4HHljD4BrSsAPOCzNbpRMjA==
X-Received: by 2002:ac8:72d8:0:b0:440:4e60:1b2a with SMTP id d75a77b69052e-4404e6020b0mr14075601cf.15.1717770413049;
        Fri, 07 Jun 2024 07:26:53 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44052953a0fsm1533721cf.92.2024.06.07.07.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:26:52 -0700 (PDT)
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	snitzer@hammerspace.com
Subject: [for-6.11 PATCH 03/29] nfs: pass descriptor thru nfs_initiate_pgio path
Date: Fri,  7 Jun 2024 10:26:20 -0400
Message-ID: <20240607142646.20924-4-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240607142646.20924-1-snitzer@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
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
index 0c4a1fbb6a19..d66f2efbd92f 100644
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
index dee4bc560b8e..d7e9e5ef4085 100644
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
index 13c28cae45c5..873c2339b78a 100644
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


