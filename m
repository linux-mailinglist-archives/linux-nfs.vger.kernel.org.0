Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF73BAADC
	for <lists+linux-nfs@lfdr.de>; Sun,  4 Jul 2021 04:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhGDCHr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 3 Jul 2021 22:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhGDCHr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 3 Jul 2021 22:07:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2E04613DC
        for <linux-nfs@vger.kernel.org>; Sun,  4 Jul 2021 02:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625364313;
        bh=/kMmme3b7C8qB1Jw5W6AHsXhyUavIkLzBtqth1MRL+0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lWrAMuIDEP37FaNGS+VI1DhrMWnZdfcLBpJL8FK3Q6S9ZcC3jfuO+wUD9SGAESd41
         uyijkSMf9C1/uLQUf1sil8e1Idf5GC7xo7Wm8ArBz/xHNpPX9UexDzpzjfc2FcbDQR
         AUCusA0jl4VLFo14xJGFBDL97U39NnMEN0f7eQgc7BuiKeZp9rPqNVPMvhquy+ZmIu
         XZCwIJOAg/+MqeJXjr9wLkp8hlRTobcDydsKzlePqV0MutVKuZcSCpptWOjCxrreyN
         Wed429qN7NZHp5WrB5u6a9I5b05W5YNoUmIZ/1PNgX1TWKY1OUK8g/kQKOGqkTQRF5
         tfNVpV7kxxd9Q==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] NFSv4/pnfs: Clean up layout get on open
Date:   Sat,  3 Jul 2021 22:05:08 -0400
Message-Id: <20210704020510.4898-3-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210704020510.4898-2-trondmy@kernel.org>
References: <20210704020510.4898-1-trondmy@kernel.org>
 <20210704020510.4898-2-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Cache the layout in the arguments so we don't have to keep looking it up
from the inode.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c       |  6 +-----
 fs/nfs/pnfs.c           | 28 ++++++++++++++++------------
 include/linux/nfs_xdr.h |  1 +
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9fbe04cca07e..e1214bb6b7ee 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -9444,7 +9444,7 @@ nfs4_layoutget_handle_exception(struct rpc_task *task,
 {
 	struct inode *inode = lgp->args.inode;
 	struct nfs_server *server = NFS_SERVER(inode);
-	struct pnfs_layout_hdr *lo;
+	struct pnfs_layout_hdr *lo = lgp->lo;
 	int nfs4err = task->tk_status;
 	int err, status = 0;
 	LIST_HEAD(head);
@@ -9496,7 +9496,6 @@ nfs4_layoutget_handle_exception(struct rpc_task *task,
 	case -NFS4ERR_BAD_STATEID:
 		exception->timeout = 0;
 		spin_lock(&inode->i_lock);
-		lo = NFS_I(inode)->layout;
 		/* If the open stateid was bad, then recover it. */
 		if (!lo || test_bit(NFS_LAYOUT_INVALID_STID, &lo->plh_flags) ||
 		    !nfs4_stateid_match_other(&lgp->args.stateid, &lo->plh_stateid)) {
@@ -9580,9 +9579,6 @@ nfs4_proc_layoutget(struct nfs4_layoutget *lgp, long *timeout)
 
 	dprintk("--> %s\n", __func__);
 
-	/* nfs4_layoutget_release calls pnfs_put_layout_hdr */
-	pnfs_get_layout_hdr(NFS_I(inode)->layout);
-
 	nfs4_init_sequence(&lgp->args.seq_args, &lgp->res.seq_res, 0, 0);
 
 	task = rpc_run_task(&task_setup_data);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index be960e47d7f6..ef14ea0b6ab8 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1128,8 +1128,7 @@ void pnfs_layoutget_free(struct nfs4_layoutget *lgp)
 	size_t max_pages = lgp->args.layout.pglen / PAGE_SIZE;
 
 	nfs4_free_pages(lgp->args.layout.pages, max_pages);
-	if (lgp->args.inode)
-		pnfs_put_layout_hdr(NFS_I(lgp->args.inode)->layout);
+	pnfs_put_layout_hdr(lgp->lo);
 	put_nfs_open_context(lgp->args.ctx);
 	kfree(lgp);
 }
@@ -2124,6 +2123,9 @@ pnfs_update_layout(struct inode *ino,
 		goto out_put_layout_hdr;
 	}
 
+	lgp->lo = lo;
+	pnfs_get_layout_hdr(lo);
+
 	lseg = nfs4_proc_layoutget(lgp, &timeout);
 	trace_pnfs_update_layout(ino, pos, count, iomode, lo, lseg,
 				 PNFS_UPDATE_LAYOUT_SEND_LAYOUTGET);
@@ -2255,6 +2257,7 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
 		pnfs_put_layout_hdr(lo);
 		return;
 	}
+	lgp->lo = lo;
 	data->lgp = lgp;
 	data->o_arg.lg_args = &lgp->args;
 	data->o_res.lg_res = &lgp->res;
@@ -2263,6 +2266,7 @@ static void _lgopen_prepare_attached(struct nfs4_opendata *data,
 static void _lgopen_prepare_floating(struct nfs4_opendata *data,
 				     struct nfs_open_context *ctx)
 {
+	struct inode *ino = data->dentry->d_inode;
 	struct pnfs_layout_range rng = {
 		.iomode = (data->o_arg.fmode & FMODE_WRITE) ?
 			  IOMODE_RW: IOMODE_READ,
@@ -2271,7 +2275,7 @@ static void _lgopen_prepare_floating(struct nfs4_opendata *data,
 	};
 	struct nfs4_layoutget *lgp;
 
-	lgp = pnfs_alloc_init_layoutget_args(NULL, ctx, &current_stateid,
+	lgp = pnfs_alloc_init_layoutget_args(ino, ctx, &current_stateid,
 					     &rng, GFP_KERNEL);
 	if (!lgp)
 		return;
@@ -2291,6 +2295,8 @@ void pnfs_lgopen_prepare(struct nfs4_opendata *data,
 	/* Could check on max_ops, but currently hardcoded high enough */
 	if (!nfs_server_capable(data->dir->d_inode, NFS_CAP_LGOPEN))
 		return;
+	if (data->lgp)
+		return;
 	if (data->state)
 		_lgopen_prepare_attached(data, ctx);
 	else
@@ -2330,13 +2336,13 @@ void pnfs_parse_lgopen(struct inode *ino, struct nfs4_layoutget *lgp,
 		}
 		return;
 	}
-	if (!lgp->args.inode) {
+	if (!lgp->lo) {
 		lo = _pnfs_grab_empty_layout(ino, ctx);
 		if (!lo)
 			return;
-		lgp->args.inode = ino;
+		lgp->lo = lo;
 	} else
-		lo = NFS_I(lgp->args.inode)->layout;
+		lo = lgp->lo;
 
 	lseg = pnfs_layout_process(lgp);
 	if (!IS_ERR(lseg)) {
@@ -2349,11 +2355,9 @@ void pnfs_parse_lgopen(struct inode *ino, struct nfs4_layoutget *lgp,
 void nfs4_lgopen_release(struct nfs4_layoutget *lgp)
 {
 	if (lgp != NULL) {
-		struct inode *inode = lgp->args.inode;
-		if (inode) {
-			struct pnfs_layout_hdr *lo = NFS_I(inode)->layout;
-			pnfs_clear_first_layoutget(lo);
-			nfs_layoutget_end(lo);
+		if (lgp->lo) {
+			pnfs_clear_first_layoutget(lgp->lo);
+			nfs_layoutget_end(lgp->lo);
 		}
 		pnfs_layoutget_free(lgp);
 	}
@@ -2362,7 +2366,7 @@ void nfs4_lgopen_release(struct nfs4_layoutget *lgp)
 struct pnfs_layout_segment *
 pnfs_layout_process(struct nfs4_layoutget *lgp)
 {
-	struct pnfs_layout_hdr *lo = NFS_I(lgp->args.inode)->layout;
+	struct pnfs_layout_hdr *lo = lgp->lo;
 	struct nfs4_layoutget_res *res = &lgp->res;
 	struct pnfs_layout_segment *lseg;
 	struct inode *ino = lo->plh_inode;
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 717ecc87c9e7..e9698b6278a5 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -277,6 +277,7 @@ struct nfs4_layoutget {
 	struct nfs4_layoutget_args args;
 	struct nfs4_layoutget_res res;
 	const struct cred *cred;
+	struct pnfs_layout_hdr *lo;
 	gfp_t gfp_flags;
 };
 
-- 
2.31.1

