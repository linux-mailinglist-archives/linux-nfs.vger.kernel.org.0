Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD1F4E3640
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbiCVB4I (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiCVB4F (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076B51D306
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9068160B15
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42CCC340F0;
        Tue, 22 Mar 2022 01:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647914077;
        bh=cCVkVoMAlDQfoVIQE3s7VVfidrskFyjLShmlmXXc8Qw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQpoaE9cMd6YgMu77JCXfvYFMWbgaNh6TKn4OouMVenvrXqTAXAOg5AObKoiK4nEc
         BhE1eKJB/vVT/mLYvZptfy+rSS/GsAdBO5PedphZOFm8XGLr8CakDImysq3o3V2RtW
         s0i6acJs0aIBu2ctdXSyHlOiIUsfe2RfPzmK5OIJ/rcpZWUt2Zvugyy6k3Qmto09pG
         Ggd1JGPCBUOHy7CClOOQaOh52ZNv/4NYSd6jdtTzO0BOIYe/kQlr9lSoenq95+4OLU
         4bjq1sHl2kOA11BCneO2P2pr9uZbpzSs+5J9IaaGAzZtMLmBKsf5mZ0OzJ883g3hTj
         yrnhGYX0ep79A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH v2 7/9] NFSv4/pnfs: Ensure pNFS allocation modes are consistent with nfsiod
Date:   Mon, 21 Mar 2022 21:47:44 -0400
Message-Id: <20220322014746.1052984-8-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322014746.1052984-7-trondmy@kernel.org>
References: <20220322014746.1052984-1-trondmy@kernel.org>
 <20220322014746.1052984-2-trondmy@kernel.org>
 <20220322014746.1052984-3-trondmy@kernel.org>
 <20220322014746.1052984-4-trondmy@kernel.org>
 <20220322014746.1052984-5-trondmy@kernel.org>
 <20220322014746.1052984-6-trondmy@kernel.org>
 <20220322014746.1052984-7-trondmy@kernel.org>
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

Ensure that pNFS allocations that can be called from rpciod/nfsiod
callback can fail in low memory mode, so that the threads don't block
and loop forever.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c |  2 +-
 fs/nfs/pnfs.c      | 39 +++++++++++++++++----------------------
 2 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 882bf84484ac..b841e267b764 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -1017,7 +1017,7 @@ int nfs42_proc_layouterror(struct pnfs_layout_segment *lseg,
 		return -EOPNOTSUPP;
 	if (n > NFS42_LAYOUTERROR_MAX)
 		return -EINVAL;
-	data = nfs42_alloc_layouterror_data(lseg, GFP_KERNEL);
+	data = nfs42_alloc_layouterror_data(lseg, nfs_io_gfp_mask());
 	if (!data)
 		return -ENOMEM;
 	for (i = 0; i < n; i++) {
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index f089e11fd001..de318bb5d349 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1233,7 +1233,7 @@ pnfs_send_layoutreturn(struct pnfs_layout_hdr *lo,
 	int status = 0;
 
 	*pcred = NULL;
-	lrp = kzalloc(sizeof(*lrp), GFP_KERNEL);
+	lrp = kzalloc(sizeof(*lrp), nfs_io_gfp_mask());
 	if (unlikely(lrp == NULL)) {
 		status = -ENOMEM;
 		spin_lock(&ino->i_lock);
@@ -2206,7 +2206,7 @@ _pnfs_grab_empty_layout(struct inode *ino, struct nfs_open_context *ctx)
 	struct pnfs_layout_hdr *lo;
 
 	spin_lock(&ino->i_lock);
-	lo = pnfs_find_alloc_layout(ino, ctx, GFP_KERNEL);
+	lo = pnfs_find_alloc_layout(ino, ctx, nfs_io_gfp_mask());
 	if (!lo)
 		goto out_unlock;
 	if (!test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags))
@@ -2249,8 +2249,8 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
 	lo = _pnfs_grab_empty_layout(ino, ctx);
 	if (!lo)
 		return;
-	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid,
-					     &rng, GFP_KERNEL);
+	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid, &rng,
+					     nfs_io_gfp_mask());
 	if (!lgp) {
 		pnfs_clear_first_layoutget(lo);
 		nfs_layoutget_end(lo);
@@ -2275,8 +2275,8 @@ static void _lgopen_prepare_floating(struct nfs4_opendata *data,
 	};
 	struct nfs4_layoutget *lgp;
 
-	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid,
-					     &rng, GFP_KERNEL);
+	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid, &rng,
+					     nfs_io_gfp_mask());
 	if (!lgp)
 		return;
 	data->lgp = lgp;
@@ -2691,13 +2691,11 @@ pnfs_generic_pg_init_read(struct nfs_pageio_descriptor *pgio, struct nfs_page *r
 		else
 			rd_size = nfs_dreq_bytes_left(pgio->pg_dreq);
 
-		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
-						   nfs_req_openctx(req),
-						   req_offset(req),
-						   rd_size,
-						   IOMODE_READ,
-						   false,
-						   GFP_KERNEL);
+		pgio->pg_lseg =
+			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
+					   req_offset(req), rd_size,
+					   IOMODE_READ, false,
+					   nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -2718,13 +2716,10 @@ pnfs_generic_pg_init_write(struct nfs_pageio_descriptor *pgio,
 	pnfs_generic_pg_check_layout(pgio);
 	pnfs_generic_pg_check_range(pgio, req);
 	if (pgio->pg_lseg == NULL) {
-		pgio->pg_lseg = pnfs_update_layout(pgio->pg_inode,
-						   nfs_req_openctx(req),
-						   req_offset(req),
-						   wb_size,
-						   IOMODE_RW,
-						   false,
-						   GFP_KERNEL);
+		pgio->pg_lseg =
+			pnfs_update_layout(pgio->pg_inode, nfs_req_openctx(req),
+					   req_offset(req), wb_size, IOMODE_RW,
+					   false, nfs_io_gfp_mask());
 		if (IS_ERR(pgio->pg_lseg)) {
 			pgio->pg_error = PTR_ERR(pgio->pg_lseg);
 			pgio->pg_lseg = NULL;
@@ -3183,7 +3178,7 @@ pnfs_layoutcommit_inode(struct inode *inode, bool sync)
 
 	status = -ENOMEM;
 	/* Note kzalloc ensures data->res.seq_res.sr_slot == NULL */
-	data = kzalloc(sizeof(*data), GFP_NOFS);
+	data = kzalloc(sizeof(*data), nfs_io_gfp_mask());
 	if (!data)
 		goto clear_layoutcommitting;
 
@@ -3250,7 +3245,7 @@ struct nfs4_threshold *pnfs_mdsthreshold_alloc(void)
 {
 	struct nfs4_threshold *thp;
 
-	thp = kzalloc(sizeof(*thp), GFP_KERNEL);
+	thp = kzalloc(sizeof(*thp), nfs_io_gfp_mask());
 	if (!thp) {
 		dprintk("%s mdsthreshold allocation failed\n", __func__);
 		return NULL;
-- 
2.35.1

