Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A477EADAA7
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405085AbfIIODP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 10:03:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45826 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405066AbfIIODO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 10:03:14 -0400
Received: by mail-io1-f67.google.com with SMTP id f12so28825352iog.12
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 07:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYN5Bd9Dd0vS7p9p+LtozvKO/VbaMtj9Dt0A4GBDoyM=;
        b=sU0bsG0ddHq/A1WhfDx17RCzU1xNxFpPEdvN60DUmOdli5heM0hoARipzomg7LpIvh
         NfzmfSMDfmkmK9LkchhocxOBqN8BrZZ4QYy/L9wRm5FnuQd+xh4k/qadyDWCtZDf06xR
         wYdIWW+3Ips2UTZ7nXj0L22Vo8zD0W2tHnaZ7i1xNxAyAd/h/seNXuDTh617I3qJCrZk
         TVinHBeQVYZCIb4IaE/xVRwu0t03QRjHZ+Lz4AX7FrirqhtTw0b8cyxw7S/1VpVi2CyP
         TlDnQ77wFCJU8K9V1KRFHM7qnlc0LQ0Cz6KtAxxPWxgJSWyUUJNSXv8T4qDls19QLpTn
         LzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYN5Bd9Dd0vS7p9p+LtozvKO/VbaMtj9Dt0A4GBDoyM=;
        b=Xg//Oqrey5ATq9OkSPQVHMx9IgLU/GZC0ZwkCgFzyqmVHRmCeEd+9BxacECuYDoCby
         M7MJx8IT/WKYsPXR4XzjbvkM35fHEdRU/p8U7i0O5wbGDQJLzDB5NtSAlkyvrSgTn+7y
         VFXyFI6LM9ylsPOPasGmvTO93OG04s4xBzHfNPbJRXNdetkWGA8BcbF8A3eFJ5eAmniv
         lHWA6Z1LgjIBEjQiP+pe4KPCxlTGWpSaMpEX1FLpwVdSs7k6uF/I1XbHizJe/d/TB9r4
         9ksR3kRkpWr0z6jSKTu7IX9I4BvwWlj6YnjVr4hFXKivBKz22jxob2rFGkHfqz5Fu4di
         KLcQ==
X-Gm-Message-State: APjAAAUp/14oZ+tFZnh4UCrXs1wfX3x4SzEaIiL72jd27xpmKoY11/1l
        ywiX/KHI+vC/yDia5EcdNcDmT6iWoQ==
X-Google-Smtp-Source: APXvYqyv0Y/XYJ8FUAH5vxHZXh4cb47TnjBVM2NpYmu0dRiH0Bmr9jF17gUX8wFTB66geKPhGGKYaA==
X-Received: by 2002:a05:6638:73d:: with SMTP id j29mr27531439jad.21.1568037793928;
        Mon, 09 Sep 2019 07:03:13 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id h70sm33727176iof.48.2019.09.09.07.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 07:03:12 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/9] NFSv4: Clean up pNFS return-on-close error handling
Date:   Mon,  9 Sep 2019 10:00:57 -0400
Message-Id: <20190909140104.78818-2-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
References: <20190909140104.78818-1-trond.myklebust@hammerspace.com>
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

