Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539E0270598
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Sep 2020 21:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRTcJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Sep 2020 15:32:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgIRTcJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 18 Sep 2020 15:32:09 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08DAB22211
        for <linux-nfs@vger.kernel.org>; Fri, 18 Sep 2020 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600457528;
        bh=IxOyqarwUuA8dvKvpvDIQlqQGVMpUuPMLpJByu5iZbQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tLaE/J53mCWwOmQDCd+MaLAaRR48+VPYXJvbPRWFNaa/hpkSm1HmA+2nfwPCfjZB/
         TR1GUq/eNjk0vuQj+TQAZ2gV7spx/ii0HGieA2Vnc/MMazQvkHvg5f1W7jjoJ+jINM
         EELXVvyiXSvvwZA2eugUg+oBktnYdh2sCjg11IVI=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/2] pNFS/flexfiles: Be consistent about mirror index types
Date:   Fri, 18 Sep 2020 15:29:59 -0400
Message-Id: <20200918192959.14270-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200918192959.14270-1-trondmy@kernel.org>
References: <20200918192959.14270-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

A mirror index is always of type u32.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 34 +++++++++++++-------------
 include/linux/nfs_xdr.h                |  4 +--
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 1edeebd51937..a163533446fa 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -715,7 +715,7 @@ nfs4_ff_layout_stat_io_end_write(struct rpc_task *task,
 }
 
 static void
-ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, int idx)
+ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, u32 idx)
 {
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 
@@ -724,7 +724,7 @@ ff_layout_mark_ds_unreachable(struct pnfs_layout_segment *lseg, int idx)
 }
 
 static void
-ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, int idx)
+ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, u32 idx)
 {
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 
@@ -734,14 +734,14 @@ ff_layout_mark_ds_reachable(struct pnfs_layout_segment *lseg, int idx)
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
-			     int start_idx, int *best_idx,
+			     u32 start_idx, u32 *best_idx,
 			     bool check_device)
 {
 	struct nfs4_ff_layout_segment *fls = FF_LAYOUT_LSEG(lseg);
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_pnfs_ds *ds;
 	bool fail_return = false;
-	int idx;
+	u32 idx;
 
 	/* mirrors are initially sorted by efficiency */
 	for (idx = start_idx; idx < fls->mirror_array_cnt; idx++) {
@@ -766,21 +766,21 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_any_ds_for_read(struct pnfs_layout_segment *lseg,
-				 int start_idx, int *best_idx)
+				 u32 start_idx, u32 *best_idx)
 {
 	return ff_layout_choose_ds_for_read(lseg, start_idx, best_idx, false);
 }
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_valid_ds_for_read(struct pnfs_layout_segment *lseg,
-				   int start_idx, int *best_idx)
+				   u32 start_idx, u32 *best_idx)
 {
 	return ff_layout_choose_ds_for_read(lseg, start_idx, best_idx, true);
 }
 
 static struct nfs4_pnfs_ds *
 ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
-				  int start_idx, int *best_idx)
+				  u32 start_idx, u32 *best_idx)
 {
 	struct nfs4_pnfs_ds *ds;
 
@@ -791,7 +791,8 @@ ff_layout_choose_best_ds_for_read(struct pnfs_layout_segment *lseg,
 }
 
 static struct nfs4_pnfs_ds *
-ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio, int *best_idx)
+ff_layout_get_ds_for_read(struct nfs_pageio_descriptor *pgio,
+			  u32 *best_idx)
 {
 	struct pnfs_layout_segment *lseg = pgio->pg_lseg;
 	struct nfs4_pnfs_ds *ds;
@@ -837,8 +838,7 @@ ff_layout_pg_init_read(struct nfs_pageio_descriptor *pgio,
 	struct nfs_pgio_mirror *pgm;
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs4_pnfs_ds *ds;
-	int ds_idx;
-	u32 i;
+	u32 ds_idx, i;
 
 retry:
 	ff_layout_pg_check_layout(pgio, req);
@@ -895,7 +895,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	struct nfs4_ff_layout_mirror *mirror;
 	struct nfs_pgio_mirror *pgm;
 	struct nfs4_pnfs_ds *ds;
-	int i;
+	u32 i;
 
 retry:
 	ff_layout_pg_check_layout(pgio, req);
@@ -1039,7 +1039,7 @@ static void ff_layout_reset_write(struct nfs_pgio_header *hdr, bool retry_pnfs)
 static void ff_layout_resend_pnfs_read(struct nfs_pgio_header *hdr)
 {
 	u32 idx = hdr->pgio_mirror_idx + 1;
-	int new_idx = 0;
+	u32 new_idx = 0;
 
 	if (ff_layout_choose_any_ds_for_read(hdr->lseg, idx + 1, &new_idx))
 		ff_layout_send_layouterror(hdr->lseg);
@@ -1076,7 +1076,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 					   struct nfs4_state *state,
 					   struct nfs_client *clp,
 					   struct pnfs_layout_segment *lseg,
-					   int idx)
+					   u32 idx)
 {
 	struct pnfs_layout_hdr *lo = lseg->pls_layout;
 	struct inode *inode = lo->plh_inode;
@@ -1150,7 +1150,7 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 /* Retry all errors through either pNFS or MDS except for -EJUKEBOX */
 static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 					   struct pnfs_layout_segment *lseg,
-					   int idx)
+					   u32 idx)
 {
 	struct nfs4_deviceid_node *devid = FF_LAYOUT_DEVID_NODE(lseg, idx);
 
@@ -1185,7 +1185,7 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 					struct nfs4_state *state,
 					struct nfs_client *clp,
 					struct pnfs_layout_segment *lseg,
-					int idx)
+					u32 idx)
 {
 	int vers = clp->cl_nfs_mod->rpc_vers->number;
 
@@ -1212,7 +1212,7 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 }
 
 static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
-					int idx, u64 offset, u64 length,
+					u32 idx, u64 offset, u64 length,
 					u32 *op_status, int opnum, int error)
 {
 	struct nfs4_ff_layout_mirror *mirror;
@@ -1810,7 +1810,7 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 	loff_t offset = hdr->args.offset;
 	int vers;
 	struct nfs_fh *fh;
-	int idx = hdr->pgio_mirror_idx;
+	u32 idx = hdr->pgio_mirror_idx;
 
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, true);
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 9408f3252c8e..69cb46f7b8d2 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1611,8 +1611,8 @@ struct nfs_pgio_header {
 	__u64			mds_offset;	/* Filelayout dense stripe */
 	struct nfs_page_array	page_array;
 	struct nfs_client	*ds_clp;	/* pNFS data server */
-	int			ds_commit_idx;	/* ds index if ds_clp is set */
-	int			pgio_mirror_idx;/* mirror index in pgio layer */
+	u32			ds_commit_idx;	/* ds index if ds_clp is set */
+	u32			pgio_mirror_idx;/* mirror index in pgio layer */
 };
 
 struct nfs_mds_commit_info {
-- 
2.26.2

