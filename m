Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89D62ECA29
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Jan 2021 06:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbhAGFcN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Jan 2021 00:32:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbhAGFcM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 7 Jan 2021 00:32:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D29A422DBF
        for <linux-nfs@vger.kernel.org>; Thu,  7 Jan 2021 05:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609997492;
        bh=UwRpi2SsWyuH83X0KeAmSMXmfltTYsDRWeMhjkDRAHA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eDfAC1uZfnUpVDSYMzWp2y5htHv3ytLnzdInF+Z0YFN0fKIDdp5X30Qe9mJU7E1Js
         h70MJ3qSh7y/zFUF9lXpCZnCX+ETQrdQXUOc1lFc5ZUmNHPEZx7as0ZsCLhx10tezf
         MjEOxye/1X6DjSGw+mmwenmw157i8UIiOtkMO0gQxh4UP5nCHnHR0UOMtnIevk96Bq
         hu2W/dt5JhrcjTzgxQZ4CLx5djpnsWOElr/VzDccVSpn2F0ze8y+57S/GdDDUQL25J
         beobxhEEfDDuukmVrSrrNugg0kXaQmtPEC+InASiWD5+FRFJH5GyQIUSDFExkbZLMe
         Mb3PgMnQGVvuQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/7] pNFS: We want return-on-close to complete when evicting the inode
Date:   Thu,  7 Jan 2021 00:31:25 -0500
Message-Id: <20210107053130.20341-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210107053130.20341-1-trondmy@kernel.org>
References: <20210107053130.20341-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the inode is being evicted, it should be safe to run return-on-close,
so we should do it to ensure we don't inadvertently leak layout segments.

Fixes: 1c5bd76d17cc ("pNFS: Enable layoutreturn operation for return-on-close")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 26 ++++++++++----------------
 fs/nfs/pnfs.c     |  8 +++-----
 fs/nfs/pnfs.h     |  8 +++-----
 3 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 14acd2f79107..2f4679a62712 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3536,10 +3536,8 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 	trace_nfs4_close(state, &calldata->arg, &calldata->res, task->tk_status);
 
 	/* Handle Layoutreturn errors */
-	if (pnfs_roc_done(task, calldata->inode,
-				&calldata->arg.lr_args,
-				&calldata->res.lr_res,
-				&calldata->res.lr_ret) == -EAGAIN)
+	if (pnfs_roc_done(task, &calldata->arg.lr_args, &calldata->res.lr_res,
+			  &calldata->res.lr_ret) == -EAGAIN)
 		goto out_restart;
 
 	/* hmm. we are done with the inode, and in the process of freeing
@@ -6384,10 +6382,8 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 	trace_nfs4_delegreturn_exit(&data->args, &data->res, task->tk_status);
 
 	/* Handle Layoutreturn errors */
-	if (pnfs_roc_done(task, data->inode,
-				&data->args.lr_args,
-				&data->res.lr_res,
-				&data->res.lr_ret) == -EAGAIN)
+	if (pnfs_roc_done(task, &data->args.lr_args, &data->res.lr_res,
+			  &data->res.lr_ret) == -EAGAIN)
 		goto out_restart;
 
 	switch (task->tk_status) {
@@ -6441,10 +6437,10 @@ static void nfs4_delegreturn_release(void *calldata)
 	struct nfs4_delegreturndata *data = calldata;
 	struct inode *inode = data->inode;
 
+	if (data->lr.roc)
+		pnfs_roc_release(&data->lr.arg, &data->lr.res,
+				 data->res.lr_ret);
 	if (inode) {
-		if (data->lr.roc)
-			pnfs_roc_release(&data->lr.arg, &data->lr.res,
-					data->res.lr_ret);
 		nfs_post_op_update_inode_force_wcc(inode, &data->fattr);
 		nfs_iput_and_deactive(inode);
 	}
@@ -6520,16 +6516,14 @@ static int _nfs4_proc_delegreturn(struct inode *inode, const struct cred *cred,
 	nfs_fattr_init(data->res.fattr);
 	data->timestamp = jiffies;
 	data->rpc_status = 0;
-	data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res, cred);
 	data->inode = nfs_igrab_and_active(inode);
-	if (data->inode) {
+	if (data->inode || issync) {
+		data->lr.roc = pnfs_roc(inode, &data->lr.arg, &data->lr.res,
+					cred);
 		if (data->lr.roc) {
 			data->args.lr_args = &data->lr.arg;
 			data->res.lr_res = &data->lr.res;
 		}
-	} else if (data->lr.roc) {
-		pnfs_roc_release(&data->lr.arg, &data->lr.res, 0);
-		data->lr.roc = false;
 	}
 
 	task_setup_data.callback_data = data;
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index e8d08ec6fa86..30802d45c99a 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1509,10 +1509,8 @@ bool pnfs_roc(struct inode *ino,
 	return false;
 }
 
-int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
-		struct nfs4_layoutreturn_args **argpp,
-		struct nfs4_layoutreturn_res **respp,
-		int *ret)
+int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
+		  struct nfs4_layoutreturn_res **respp, int *ret)
 {
 	struct nfs4_layoutreturn_args *arg = *argpp;
 	int retval = -EAGAIN;
@@ -1545,7 +1543,7 @@ int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
 		return 0;
 	case -NFS4ERR_OLD_STATEID:
 		if (!nfs4_layout_refresh_old_stateid(&arg->stateid,
-					&arg->range, inode))
+						     &arg->range, arg->inode))
 			break;
 		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
 		return -EAGAIN;
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index bbd3de1025f2..d810ae674f4e 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -297,10 +297,8 @@ bool pnfs_roc(struct inode *ino,
 		struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
 		const struct cred *cred);
-int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
-		struct nfs4_layoutreturn_args **argpp,
-		struct nfs4_layoutreturn_res **respp,
-		int *ret);
+int pnfs_roc_done(struct rpc_task *task, struct nfs4_layoutreturn_args **argpp,
+		  struct nfs4_layoutreturn_res **respp, int *ret);
 void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
 		int ret);
@@ -772,7 +770,7 @@ pnfs_roc(struct inode *ino,
 }
 
 static inline int
-pnfs_roc_done(struct rpc_task *task, struct inode *inode,
+pnfs_roc_done(struct rpc_task *task,
 		struct nfs4_layoutreturn_args **argpp,
 		struct nfs4_layoutreturn_res **respp,
 		int *ret)
-- 
2.29.2

