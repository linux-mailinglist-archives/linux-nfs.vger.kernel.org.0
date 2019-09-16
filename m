Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 292C3B4241
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Sep 2019 22:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbfIPUqb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Sep 2019 16:46:31 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46588 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387671AbfIPUqb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Sep 2019 16:46:31 -0400
Received: by mail-io1-f65.google.com with SMTP id d17so2176271ios.13
        for <linux-nfs@vger.kernel.org>; Mon, 16 Sep 2019 13:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYN5Bd9Dd0vS7p9p+LtozvKO/VbaMtj9Dt0A4GBDoyM=;
        b=MLaM254jQ17Dzcgr86mdcoSvJtglWC2z7sj94p3TG3f8BsblOn3PzWOOpMGuO6Ghhp
         qMyvyxFvVWDVDZ6ifzfx0zIP6VxSni9pSH/CovogTBe3vG65rHSS/PMpnprh4K0f2qC2
         cxcsE1OqBMssQcA/h/XNJKANaDwayz5WiUpOaogN1w+748ZvTv5RyDDXEtJgihitvqMJ
         jekD9BYHmzeY7pHOgnM5N9rI5iEMGnOcMSDq8NC+C7tUeK/eGotl0lrohVjYJh03p0IU
         e9UZoKNvqE/ZdCPzTfwlFM2AIIJdVGvrIJxb4w1oTkMhkIYd+QU5vdaI5Lz1TO9KxF/y
         G5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYN5Bd9Dd0vS7p9p+LtozvKO/VbaMtj9Dt0A4GBDoyM=;
        b=CjXWSsJsOnKHIB7nBLezjKEOVqAc2lBT/RqpgHBfaPmxXG0nPtNwgudpAJsqrg3FxT
         TIL59VCBm7h4PsQNkPuEAwmp6DI4fJfBVnVA+83i45S3iajLIBltGJwFdI8dPZB6RZKA
         TNvWUtTf/qZTcrlRQ7OfpORnnipAd18+9cOR7WFkR8LXMxEYAzG0weDgxM0WScHY3pz7
         2nFSjuJVXdebB7wMOj1UOe/O32kP2M0KCqhW7bOHBO5E+Cz5uROn0muxCuN5DGSt52o0
         ssYz9DmpxgYvC2rlDc6qdpQUo82alteGqMwuUL/AAqXFJRIbIPKiPMUfSeVnr880O0dp
         yIZA==
X-Gm-Message-State: APjAAAXBgJVTCIiHFycxR6WFz6NV7pot/6pYbksOIg/pxZpCrQ2S3ysu
        5W1kRuV5IhXIWypEWOvL8dvM3iQrgg==
X-Google-Smtp-Source: APXvYqz92hRHYarLCn/7E80V8a9oiRf/jYeco1EXQRitg4x4VSgfDIwRW7vP6LHu89p+QCFPa83mLA==
X-Received: by 2002:a6b:b2c3:: with SMTP id b186mr261627iof.128.1568666788846;
        Mon, 16 Sep 2019 13:46:28 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id c6sm3528iom.34.2019.09.16.13.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:46:28 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>, linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/9] NFSv4: Clean up pNFS return-on-close error handling
Date:   Mon, 16 Sep 2019 16:44:12 -0400
Message-Id: <20190916204419.21717-3-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916204419.21717-2-trond.myklebust@hammerspace.com>
References: <20190916204419.21717-1-trond.myklebust@hammerspace.com>
 <20190916204419.21717-2-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Both close and delegreturn have identical code to handle pNFS
return-on-close. This patch refactors that code and places it
in pnfs.c

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs4proc.c | 66 +++++++----------------------------------------
 fs/nfs/pnfs.c     | 27 +++++++++++++++++++
 fs/nfs/pnfs.h     | 13 ++++++++++
 3 files changed, 50 insertions(+), 56 deletions(-)

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 1406858bae6c..fcdfddfd3ab4 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -3358,32 +3358,11 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 	trace_nfs4_close(state, &calldata->arg, &calldata->res, task->tk_status);
 
 	/* Handle Layoutreturn errors */
-	if (calldata->arg.lr_args && task->tk_status != 0) {
-		switch (calldata->res.lr_ret) {
-		default:
-			calldata->res.lr_ret = -NFS4ERR_NOMATCHING_LAYOUT;
-			break;
-		case 0:
-			calldata->arg.lr_args = NULL;
-			calldata->res.lr_res = NULL;
-			break;
-		case -NFS4ERR_OLD_STATEID:
-			if (nfs4_layoutreturn_refresh_stateid(&calldata->arg.lr_args->stateid,
-						&calldata->arg.lr_args->range,
-						calldata->inode))
-				goto lr_restart;
-			/* Fallthrough */
-		case -NFS4ERR_ADMIN_REVOKED:
-		case -NFS4ERR_DELEG_REVOKED:
-		case -NFS4ERR_EXPIRED:
-		case -NFS4ERR_BAD_STATEID:
-		case -NFS4ERR_UNKNOWN_LAYOUTTYPE:
-		case -NFS4ERR_WRONG_CRED:
-			calldata->arg.lr_args = NULL;
-			calldata->res.lr_res = NULL;
-			goto lr_restart;
-		}
-	}
+	if (pnfs_roc_done(task, calldata->inode,
+				&calldata->arg.lr_args,
+				&calldata->res.lr_res,
+				&calldata->res.lr_ret) == -EAGAIN)
+		goto out_restart;
 
 	/* hmm. we are done with the inode, and in the process of freeing
 	 * the state_owner. we keep this around to process errors
@@ -3430,8 +3409,6 @@ static void nfs4_close_done(struct rpc_task *task, void *data)
 	nfs_refresh_inode(calldata->inode, &calldata->fattr);
 	dprintk("%s: done, ret = %d!\n", __func__, task->tk_status);
 	return;
-lr_restart:
-	calldata->res.lr_ret = 0;
 out_restart:
 	task->tk_status = 0;
 	rpc_restart_call_prepare(task);
@@ -6129,32 +6106,11 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 	trace_nfs4_delegreturn_exit(&data->args, &data->res, task->tk_status);
 
 	/* Handle Layoutreturn errors */
-	if (data->args.lr_args && task->tk_status != 0) {
-		switch(data->res.lr_ret) {
-		default:
-			data->res.lr_ret = -NFS4ERR_NOMATCHING_LAYOUT;
-			break;
-		case 0:
-			data->args.lr_args = NULL;
-			data->res.lr_res = NULL;
-			break;
-		case -NFS4ERR_OLD_STATEID:
-			if (nfs4_layoutreturn_refresh_stateid(&data->args.lr_args->stateid,
-						&data->args.lr_args->range,
-						data->inode))
-				goto lr_restart;
-			/* Fallthrough */
-		case -NFS4ERR_ADMIN_REVOKED:
-		case -NFS4ERR_DELEG_REVOKED:
-		case -NFS4ERR_EXPIRED:
-		case -NFS4ERR_BAD_STATEID:
-		case -NFS4ERR_UNKNOWN_LAYOUTTYPE:
-		case -NFS4ERR_WRONG_CRED:
-			data->args.lr_args = NULL;
-			data->res.lr_res = NULL;
-			goto lr_restart;
-		}
-	}
+	if (pnfs_roc_done(task, data->inode,
+				&data->args.lr_args,
+				&data->res.lr_res,
+				&data->res.lr_ret) == -EAGAIN)
+		goto out_restart;
 
 	switch (task->tk_status) {
 	case 0:
@@ -6192,8 +6148,6 @@ static void nfs4_delegreturn_done(struct rpc_task *task, void *calldata)
 	}
 	data->rpc_status = task->tk_status;
 	return;
-lr_restart:
-	data->res.lr_ret = 0;
 out_restart:
 	task->tk_status = 0;
 	rpc_restart_call_prepare(task);
diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0418b198edd3..8769422a12f5 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1440,6 +1440,33 @@ bool pnfs_roc(struct inode *ino,
 	return false;
 }
 
+int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
+		struct nfs4_layoutreturn_args **argpp,
+		struct nfs4_layoutreturn_res **respp,
+		int *ret)
+{
+	struct nfs4_layoutreturn_args *arg = *argpp;
+	int retval = -EAGAIN;
+
+	if (!arg)
+		return 0;
+	/* Handle Layoutreturn errors */
+	switch (*ret) {
+	case 0:
+		retval = 0;
+		break;
+	case -NFS4ERR_OLD_STATEID:
+		if (!nfs4_layoutreturn_refresh_stateid(&arg->stateid,
+					&arg->range, inode))
+			break;
+		*ret = -NFS4ERR_NOMATCHING_LAYOUT;
+		return -EAGAIN;
+	}
+	*argpp = NULL;
+	*respp = NULL;
+	return retval;
+}
+
 void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
 		int ret)
diff --git a/fs/nfs/pnfs.h b/fs/nfs/pnfs.h
index f15609c003d8..3ef3756d437c 100644
--- a/fs/nfs/pnfs.h
+++ b/fs/nfs/pnfs.h
@@ -282,6 +282,10 @@ bool pnfs_roc(struct inode *ino,
 		struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
 		const struct cred *cred);
+int pnfs_roc_done(struct rpc_task *task, struct inode *inode,
+		struct nfs4_layoutreturn_args **argpp,
+		struct nfs4_layoutreturn_res **respp,
+		int *ret);
 void pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
 		int ret);
@@ -701,6 +705,15 @@ pnfs_roc(struct inode *ino,
 	return false;
 }
 
+static inline int
+pnfs_roc_done(struct rpc_task *task, struct inode *inode,
+		struct nfs4_layoutreturn_args **argpp,
+		struct nfs4_layoutreturn_res **respp,
+		int *ret)
+{
+	return 0;
+}
+
 static inline void
 pnfs_roc_release(struct nfs4_layoutreturn_args *args,
 		struct nfs4_layoutreturn_res *res,
-- 
2.21.0

