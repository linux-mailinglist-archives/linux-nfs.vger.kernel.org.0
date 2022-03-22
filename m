Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869D94E35F0
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiCVBX7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiCVBX4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:23:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6072D1D0D4
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:22:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA218615E5
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14645C340E8;
        Tue, 22 Mar 2022 01:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647912149;
        bh=eD2KQYnN8f7Yvi+SCRjQOL9lO3dzZe1LYm9ivcVGoCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GTEfe9X12Y/ltRILgQhfV1hbB1jLGGM7rzpKqGSgC/7tAtUt1urLckF3Z4KqtFMen
         wvSHkEd1IWL1SwiMV04p03+/lKy1huYiGjAy02yXj6qevUbqn4Lj/Hbrz9EOeVIf7x
         0Q9i7WmXNkfvnubOo6beEbbrH4uRWcnJOaPeOEEXn2QacnUBiYVcohdH7q6MBw4ZG7
         B9+5lHSLXb+IkAyMxfRopofIgv+Gm6W+K2AUyQazIAJ/U1CFBQ0XubJ8Q13Mq0lL2T
         lQVqsAcsWab6yAX2Hn8iZgn+JCFqUWGFb1UEu8+UNNjJxBJto87Q+jLhy49B+m7mI6
         hVV1ZdPmYk0kA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Neil Brown <neilb@suse.de>
Subject: [PATCH v2 8/9] pNFS/flexfiles: Ensure pNFS allocation modes are consistent with nfsiod
Date:   Mon, 21 Mar 2022 21:16:17 -0400
Message-Id: <20220322011618.1052288-9-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322011618.1052288-8-trondmy@kernel.org>
References: <20220322011618.1052288-1-trondmy@kernel.org>
 <20220322011618.1052288-2-trondmy@kernel.org>
 <20220322011618.1052288-3-trondmy@kernel.org>
 <20220322011618.1052288-4-trondmy@kernel.org>
 <20220322011618.1052288-5-trondmy@kernel.org>
 <20220322011618.1052288-6-trondmy@kernel.org>
 <20220322011618.1052288-7-trondmy@kernel.org>
 <20220322011618.1052288-8-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that pNFS flexfile allocations in rpciod/nfsiod callbacks can
fail in low memory mode, so that the threads don't block and loop
forever.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 50 +++++++++++---------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index e28f2177afb7..604be402ae13 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -663,7 +663,7 @@ nfs4_ff_layout_stat_io_start_read(struct inode *inode,
 	spin_unlock(&mirror->lock);
 
 	if (report)
-		pnfs_report_layoutstat(inode, GFP_KERNEL);
+		pnfs_report_layoutstat(inode, nfs_io_gfp_mask());
 }
 
 static void
@@ -694,7 +694,7 @@ nfs4_ff_layout_stat_io_start_write(struct inode *inode,
 	spin_unlock(&mirror->lock);
 
 	if (report)
-		pnfs_report_layoutstat(inode, GFP_KERNEL);
+		pnfs_report_layoutstat(inode, nfs_io_gfp_mask());
 }
 
 static void
@@ -806,13 +806,10 @@ ff_layout_pg_get_read(struct nfs_pageio_descriptor *pgio,
 		      bool strict_iomode)
 {
 	pnfs_put_lseg(pgio->pg_lseg);
-	pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
-					   nfs_req_openctx(req),
-					   req_offset(req),
-					   req->wb_bytes,
-					   IOMODE_READ,
-					   strict_iomode,
-					   GFP_KERNEL);
+	pgio->pg_lseg =
+		pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
+				   req_offset(req), req->wb_bytes, IOMODE_READ,
+				   strict_iomode, nfs_io_gfp_mask());
 	if (IS_ERR(pgio->pg_lseg)) {
 		pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 		pgio->pg_lseg = NULL;
@@ -894,13 +891,10 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 retry:
 	ff_layout_pg_check_layout(pgio, req);
 	if (!pgio->pg_lseg) {
-		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
-						   nfs_req_openctx(req),
-						   req_offset(req),
-						   req->wb_bytes,
-						   IOMODE_RW,
-						   false,
-						   GFP_KERNEL);
+		pgio->pg_lseg =
+			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
+					   req_offset(req), req->wb_bytes,
+					   IOMODE_RW, false, nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -953,13 +947,10 @@ ff_layout_pg_get_mirror_count_write(struct nfs_pageio_descriptor *pgio,
 				    struct nfs_page *req)
 {
 	if (!pgio->pg_lseg) {
-		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
-						   nfs_req_openctx(req),
-						   req_offset(req),
-						   req->wb_bytes,
-						   IOMODE_RW,
-						   false,
-						   GFP_KERNEL);
+		pgio->pg_lseg =
+			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
+					   req_offset(req), req->wb_bytes,
+					   IOMODE_RW, false, nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -1258,7 +1249,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	err = ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
 				       mirror, offset, length, status, opnum,
-				       GFP_KERNEL);
+				       nfs_io_gfp_mask());
 
 	switch (status) {
 	case NFS4ERR_DELAY:
@@ -1973,7 +1964,8 @@ ff_layout_setup_ds_info(struct pnfs_ds_commit_info *fl_cinfo,
 	struct inode *inode = lseg->pls_layout->plh_inode;
 	struct pnfs_commit_array *array, *new;
 
-	new = pnfs_alloc_commit_array(flseg->mirror_array_cnt, GFP_KERNEL);
+	new = pnfs_alloc_commit_array(flseg->mirror_array_cnt,
+				      nfs_io_gfp_mask());
 	if (new) {
 		spin_lock(&inode->i_lock);
 		array = pnfs_add_commit_array(fl_cinfo, new, lseg);
@@ -2152,10 +2144,10 @@ ff_layout_prepare_layoutreturn(struct nfs4_layoutreturn_args *args)
 	struct nfs4_flexfile_layoutreturn_args *ff_args;
 	struct nfs4_flexfile_layout *ff_layout = FF_LAYOUT_FROM_HDR(args->layout);
 
-	ff_args = kmalloc(sizeof(*ff_args), GFP_KERNEL);
+	ff_args = kmalloc(sizeof(*ff_args), nfs_io_gfp_mask());
 	if (!ff_args)
 		goto out_nomem;
-	ff_args->pages[0] = alloc_page(GFP_KERNEL);
+	ff_args->pages[0] = alloc_page(nfs_io_gfp_mask());
 	if (!ff_args->pages[0])
 		goto out_nomem_free;
 
@@ -2193,7 +2185,7 @@ ff_layout_send_layouterror(struct pnfs_layout_segment *lseg)
 		return;
 
 	errors = kmalloc_array(NFS42_LAYOUTERROR_MAX, sizeof(*errors),
-			       GFP_KERNEL);
+			       nfs_io_gfp_mask());
 	if (errors != NULL) {
 		const struct nfs4_ff_layout_ds_err *pos;
 		size_t n = 0;
@@ -2445,7 +2437,7 @@ ff_layout_prepare_layoutstats(struct nfs42_layoutstat_args *args)
 
 	/* For now, send at most PNFS_LAYOUTSTATS_MAXDEV statistics */
 	args->devinfo = kmalloc_array(dev_count, sizeof(*args->devinfo),
-				      GFP_KERNEL);
+				      nfs_io_gfp_mask());
 	if (!args->devinfo)
 		return -ENOMEM;
 
-- 
2.35.1

