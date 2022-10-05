Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0165F5ACA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 22:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJEUEc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 16:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJEUEb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 16:04:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF6A27CDF
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 13:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EEC13CE135A
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 20:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB54FC433D6;
        Wed,  5 Oct 2022 20:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665000267;
        bh=YxqS60rF1OjORJKpdffQNEOOaMmZ866Xt7LyJomilO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJUY87Bm/40Ohmeqs2eL7t7DCEu2Lb6r/hr6P9wy+alzTGvlj10f3rysvBj3O3LZZ
         2BL8CXq+e6q3Z0onPGLExoNEJ0PAn6mYGN2eXIPCyvOlXz+uSQEPne63Euq/7H+91H
         eGFjTqm3gua8cp8+KkdtEvO9YB9cyrzkEYCJBS4X/6yL6qHEAiWDKI2ayDu4gWwHsD
         YpiNCYn5BSoERIMhoqSD2FVQ4CGR+ZwWKBdFWcBzVu+1NZVBUb9xrTVuyQETQiSIS2
         yS9adzSQOS5YUKcJdTbCGNU4v30xwA9/GZE0otovW16w3ts/1kQMAMVfB0S0jwyIL7
         HCPK4aYoywu4Q==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 4/4] NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked
Date:   Wed,  5 Oct 2022 15:57:38 -0400
Message-Id: <20221005195738.4552-5-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005195738.4552-4-trondmy@kernel.org>
References: <20221005195738.4552-1-trondmy@kernel.org>
 <20221005195738.4552-2-trondmy@kernel.org>
 <20221005195738.4552-3-trondmy@kernel.org>
 <20221005195738.4552-4-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the layout is recalled or revoked, we want to cancel I/O as quickly
as possible so that we can return the layout.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 84 +++++++++++++++++++++++++-
 fs/nfs/pnfs.c                          |  9 ++-
 fs/nfs/pnfs.h                          |  9 +++
 3 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index 1443330ae998..1ec79ccf89ad 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1379,6 +1379,11 @@ static int ff_layout_read_prepare_common(struct rpc_task *task,
 		return -EIO;
 	}
 
+	if (!pnfs_is_valid_lseg(hdr->lseg)) {
+		rpc_exit(task, -EAGAIN);
+		return -EAGAIN;
+	}
+
 	ff_layout_read_record_layoutstats_start(task, hdr);
 	return 0;
 }
@@ -1559,6 +1564,11 @@ static int ff_layout_write_prepare_common(struct rpc_task *task,
 		return -EIO;
 	}
 
+	if (!pnfs_is_valid_lseg(hdr->lseg)) {
+		rpc_exit(task, -EAGAIN);
+		return -EAGAIN;
+	}
+
 	ff_layout_write_record_layoutstats_start(task, hdr);
 	return 0;
 }
@@ -1651,15 +1661,23 @@ static void ff_layout_commit_record_layoutstats_done(struct rpc_task *task,
 	set_bit(NFS_LSEG_LAYOUTRETURN, &cdata->lseg->pls_flags);
 }
 
-static void ff_layout_commit_prepare_common(struct rpc_task *task,
-		struct nfs_commit_data *cdata)
+static int ff_layout_commit_prepare_common(struct rpc_task *task,
+					   struct nfs_commit_data *cdata)
 {
+	if (!pnfs_is_valid_lseg(cdata->lseg)) {
+		rpc_exit(task, -EAGAIN);
+		return -EAGAIN;
+	}
+
 	ff_layout_commit_record_layoutstats_start(task, cdata);
+	return 0;
 }
 
 static void ff_layout_commit_prepare_v3(struct rpc_task *task, void *data)
 {
-	ff_layout_commit_prepare_common(task, data);
+	if (ff_layout_commit_prepare_common(task, data))
+		return;
+
 	rpc_call_start(task);
 }
 
@@ -1955,6 +1973,65 @@ ff_layout_commit_pagelist(struct inode *inode, struct list_head *mds_pages,
 					    ff_layout_initiate_commit);
 }
 
+static bool ff_layout_match_rw(const struct rpc_task *task,
+			       const struct nfs_pgio_header *hdr,
+			       const struct pnfs_layout_segment *lseg)
+{
+	return hdr->lseg == lseg;
+}
+
+static bool ff_layout_match_commit(const struct rpc_task *task,
+				   const struct nfs_commit_data *cdata,
+				   const struct pnfs_layout_segment *lseg)
+{
+	return cdata->lseg == lseg;
+}
+
+static bool ff_layout_match_io(const struct rpc_task *task, const void *data)
+{
+	const struct rpc_call_ops *ops = task->tk_ops;
+
+	if (ops == &ff_layout_read_call_ops_v3 ||
+	    ops == &ff_layout_read_call_ops_v4 ||
+	    ops == &ff_layout_write_call_ops_v3 ||
+	    ops == &ff_layout_write_call_ops_v4)
+		return ff_layout_match_rw(task, task->tk_calldata, data);
+	if (ops == &ff_layout_commit_call_ops_v3 ||
+	    ops == &ff_layout_commit_call_ops_v4)
+		return ff_layout_match_commit(task, task->tk_calldata, data);
+	return false;
+}
+
+static void ff_layout_cancel_io(struct pnfs_layout_segment *lseg)
+{
+	struct nfs4_ff_layout_segment *flseg = FF_LAYOUT_LSEG(lseg);
+	struct nfs4_ff_layout_mirror *mirror;
+	struct nfs4_ff_layout_ds *mirror_ds;
+	struct nfs4_pnfs_ds *ds;
+	struct nfs_client *ds_clp;
+	struct rpc_clnt *clnt;
+	u32 idx;
+
+	for (idx = 0; idx < flseg->mirror_array_cnt; idx++) {
+		mirror = flseg->mirror_array[idx];
+		mirror_ds = mirror->mirror_ds;
+		if (!mirror_ds)
+			continue;
+		ds = mirror->mirror_ds->ds;
+		if (!ds)
+			continue;
+		ds_clp = ds->ds_clp;
+		if (!ds_clp)
+			continue;
+		clnt = ds_clp->cl_rpcclient;
+		if (!clnt)
+			continue;
+		if (!rpc_cancel_tasks(clnt, -EAGAIN, ff_layout_match_io, lseg))
+			continue;
+		rpc_clnt_disconnect(clnt);
+	}
+}
+
 static struct pnfs_ds_commit_info *
 ff_layout_get_ds_info(struct inode *inode)
 {
@@ -2512,6 +2589,7 @@ static struct pnfs_layoutdriver_type flexfilelayout_type = {
 	.prepare_layoutreturn   = ff_layout_prepare_layoutreturn,
 	.sync			= pnfs_nfs_generic_sync,
 	.prepare_layoutstats	= ff_layout_prepare_layoutstats,
+	.cancel_io		= ff_layout_cancel_io,
 };
 
 static int __init nfs4flexfilelayout_init(void)
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 2613b7e36eb9..d41fc1558e91 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -710,6 +710,7 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 			    u32 seq)
 {
 	struct pnfs_layout_segment *lseg, *next;
+	struct nfs_server *server = NFS_SERVER(lo->plh_inode);
 	int remaining = 0;
 
 	dprintk("%s:Begin lo %p\n", __func__, lo);
@@ -722,8 +723,10 @@ pnfs_mark_matching_lsegs_invalid(struct pnfs_layout_hdr *lo,
 				"offset %llu length %llu\n", __func__,
 				lseg, lseg->pls_range.iomode, lseg->pls_seq,
 				lseg->pls_range.offset, lseg->pls_range.length);
-			if (!mark_lseg_invalid(lseg, tmp_list))
-				remaining++;
+			if (mark_lseg_invalid(lseg, tmp_list))
+				continue;
+			remaining++;
+			pnfs_lseg_cancel_io(server, lseg);
 		}
 	dprintk("%s:Return %i\n", __func__, remaining);
 	return remaining;
@@ -2485,6 +2488,7 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				u32 seq)
 {
 	struct pnfs_layout_segment *lseg, *next;
+	struct nfs_server *server = NFS_SERVER(lo->plh_inode);
 	int remaining = 0;
 
 	dprintk("%s:Begin lo %p\n", __func__, lo);
@@ -2507,6 +2511,7 @@ pnfs_mark_matching_lsegs_return(struct pnfs_layout_hdr *lo,
 				continue;
 			remaining++;
 			set_bit(NFS_LSEG_LAYOUTRETURN, &lseg->pls_flags);
+			pnfs_lseg_cancel_io(server, lseg);
 		}
 
 	if (remaining) {
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index f331f067691b..e3e6a41f19de 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -169,6 +169,8 @@ struct pnfs_layoutdriver_type {
 	void (*cleanup_layoutcommit) (struct nfs4_layoutcommit_data *data);
 	int (*prepare_layoutcommit) (struct nfs4_layoutcommit_args *args);
 	int (*prepare_layoutstats) (struct nfs42_layoutstat_args *args);
+
+	void (*cancel_io)(struct pnfs_layout_segment *lseg);
 };
 
 struct pnfs_commit_ops {
@@ -685,6 +687,13 @@ pnfs_lseg_request_intersecting(struct pnfs_layout_segment *lseg, struct nfs_page
 				req_offset(req), req_last);
 }
 
+static inline void pnfs_lseg_cancel_io(struct nfs_server *server,
+				       struct pnfs_layout_segment *lseg)
+{
+	if (server->pnfs_curr_ld->cancel_io)
+		server->pnfs_curr_ld->cancel_io(lseg);
+}
+
 extern unsigned int layoutstats_timer;
 
 #ifdef NFS_DEBUG
-- 
2.37.3

