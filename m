Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2091334
	for <lists+linux-nfs@lfdr.de>; Sat, 17 Aug 2019 23:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfHQVYx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 17 Aug 2019 17:24:53 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44960 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfHQVYw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 17 Aug 2019 17:24:52 -0400
Received: by mail-io1-f67.google.com with SMTP id j4so13251013iop.11
        for <linux-nfs@vger.kernel.org>; Sat, 17 Aug 2019 14:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1Wa20v9DOwhTLOoklk7B249Gl+XVh94Z1PjBBWmbtMI=;
        b=GB5IeCplcOsZV+u2lhozqOEjlfAOlMnbNPfW7zsYsZ3UqWxE33zUzszRjefIdzKeLK
         0wRCflse6Ih38iWi29tCn2BW1WHvMxvVNZj566RXci/Ua4VlXBR8HZ6Z9g2/IOs5MVrY
         QAeMQ86714FBIvth5TxX9XtZaOWQ8A40VkVzFx5d0YCWN9hGxlfUj6jodgAPbdJNrdas
         KHogEBiFzw76u+8P8uVztqfYDLG8ydwkXeaqo7t4EdNXjG1OClKt3vocnWXEXeO6FCng
         CDnt2HhdL4LKQJnDpxfr2pKeHnfTIzoKYLbBJBeMjjYlmOGFRehfXWaZim0eNPpStOcQ
         m1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Wa20v9DOwhTLOoklk7B249Gl+XVh94Z1PjBBWmbtMI=;
        b=cbdPmc8v6sBVsYHDoM09zkuIYScz+ybwbHwSjHJhDqIaZobkYoraPLl2pwrAnpbFSD
         s28bz/gvpPcSvYGt+VUv9Sa8By4yxbrqGfLlKpOkNqok1Lx5Ge5KSG/u3zfpSr7r8g4n
         RVNJUDKmk5Ue8M2aM1CGaiqvnrJTkP6A3wXfXvFxKd58+p+YpZqQLG9Uemo3CZUed+06
         UbMt2JR3WLGhcdNJ9CAV0WCEGOGHT9c7Pn9xbbqbF2kSXPINYaLjpcJW8B684wsZDoT1
         Ra+uMZNnv8n1IzvlQy6ZIgS4pagbAqgXY15xwkLVtz2oiurBAMfjnpnNBxE0vJNPHHt/
         azpA==
X-Gm-Message-State: APjAAAXDqwWgzu6HPF7fLg+7wEGhns3rEvOYco26sRDTZIi8BKnOAKpI
        lOp19dLxehV3UqIgPenE7XBgprE=
X-Google-Smtp-Source: APXvYqzOeuEZLsUSv+aCU50/c+0vx5Sbd5YL0kuKgAs6PXTc+7M+hzuwy2lCnc1av5Kbja0ElvEzzA==
X-Received: by 2002:a5d:8ad0:: with SMTP id e16mr15611297iot.262.1566077090737;
        Sat, 17 Aug 2019 14:24:50 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id q3sm4609806ios.70.2019.08.17.14.24.49
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2019 14:24:50 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 7/8] Revert "NFSv4/flexfiles: Abort I/O early if the layout segment was invalidated"
Date:   Sat, 17 Aug 2019 17:22:16 -0400
Message-Id: <20190817212217.22766-7-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190817212217.22766-6-trond.myklebust@hammerspace.com>
References: <20190817212217.22766-1-trond.myklebust@hammerspace.com>
 <20190817212217.22766-2-trond.myklebust@hammerspace.com>
 <20190817212217.22766-3-trond.myklebust@hammerspace.com>
 <20190817212217.22766-4-trond.myklebust@hammerspace.com>
 <20190817212217.22766-5-trond.myklebust@hammerspace.com>
 <20190817212217.22766-6-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This reverts commit a79f194aa4879e9baad118c3f8bb2ca24dbef765.
The mechanism for aborting I/O is racy, since we are not guaranteed that
the request is asleep while we're changing both task->tk_status and
task->tk_action.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v5.1
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 17 -----------------
 include/linux/sunrpc/sched.h           |  1 -
 net/sunrpc/xprt.c                      |  7 -------
 3 files changed, 25 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index b04e20d28162..2c7e1eca1ed7 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1148,8 +1148,6 @@ static int ff_layout_async_handle_error_v4(struct rpc_task *task,
 		break;
 	case -NFS4ERR_RETRY_UNCACHED_REP:
 		break;
-	case -EAGAIN:
-		return -NFS4ERR_RESET_TO_PNFS;
 	/* Invalidate Layout errors */
 	case -NFS4ERR_PNFS_NO_LAYOUT:
 	case -ESTALE:           /* mapped NFS4ERR_STALE */
@@ -1210,7 +1208,6 @@ static int ff_layout_async_handle_error_v3(struct rpc_task *task,
 	case -EBADHANDLE:
 	case -ELOOP:
 	case -ENOSPC:
-	case -EAGAIN:
 		break;
 	case -EJUKEBOX:
 		nfs_inc_stats(lseg->pls_layout->plh_inode, NFSIOS_DELAY);
@@ -1445,16 +1442,6 @@ static void ff_layout_read_prepare_v4(struct rpc_task *task, void *data)
 	ff_layout_read_prepare_common(task, hdr);
 }
 
-static void
-ff_layout_io_prepare_transmit(struct rpc_task *task,
-		void *data)
-{
-	struct nfs_pgio_header *hdr = data;
-
-	if (!pnfs_is_valid_lseg(hdr->lseg))
-		rpc_exit(task, -EAGAIN);
-}
-
 static void ff_layout_read_call_done(struct rpc_task *task, void *data)
 {
 	struct nfs_pgio_header *hdr = data;
@@ -1740,7 +1727,6 @@ static void ff_layout_commit_release(void *data)
 
 static const struct rpc_call_ops ff_layout_read_call_ops_v3 = {
 	.rpc_call_prepare = ff_layout_read_prepare_v3,
-	.rpc_call_prepare_transmit = ff_layout_io_prepare_transmit,
 	.rpc_call_done = ff_layout_read_call_done,
 	.rpc_count_stats = ff_layout_read_count_stats,
 	.rpc_release = ff_layout_read_release,
@@ -1748,7 +1734,6 @@ static const struct rpc_call_ops ff_layout_read_call_ops_v3 = {
 
 static const struct rpc_call_ops ff_layout_read_call_ops_v4 = {
 	.rpc_call_prepare = ff_layout_read_prepare_v4,
-	.rpc_call_prepare_transmit = ff_layout_io_prepare_transmit,
 	.rpc_call_done = ff_layout_read_call_done,
 	.rpc_count_stats = ff_layout_read_count_stats,
 	.rpc_release = ff_layout_read_release,
@@ -1756,7 +1741,6 @@ static const struct rpc_call_ops ff_layout_read_call_ops_v4 = {
 
 static const struct rpc_call_ops ff_layout_write_call_ops_v3 = {
 	.rpc_call_prepare = ff_layout_write_prepare_v3,
-	.rpc_call_prepare_transmit = ff_layout_io_prepare_transmit,
 	.rpc_call_done = ff_layout_write_call_done,
 	.rpc_count_stats = ff_layout_write_count_stats,
 	.rpc_release = ff_layout_write_release,
@@ -1764,7 +1748,6 @@ static const struct rpc_call_ops ff_layout_write_call_ops_v3 = {
 
 static const struct rpc_call_ops ff_layout_write_call_ops_v4 = {
 	.rpc_call_prepare = ff_layout_write_prepare_v4,
-	.rpc_call_prepare_transmit = ff_layout_io_prepare_transmit,
 	.rpc_call_done = ff_layout_write_call_done,
 	.rpc_count_stats = ff_layout_write_count_stats,
 	.rpc_release = ff_layout_write_release,
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index baa3ecdb882f..27536b961552 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -98,7 +98,6 @@ typedef void			(*rpc_action)(struct rpc_task *);
 
 struct rpc_call_ops {
 	void (*rpc_call_prepare)(struct rpc_task *, void *);
-	void (*rpc_call_prepare_transmit)(struct rpc_task *, void *);
 	void (*rpc_call_done)(struct rpc_task *, void *);
 	void (*rpc_count_stats)(struct rpc_task *, void *);
 	void (*rpc_release)(void *);
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 783748dc5e6f..2e71f5455c6c 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1408,13 +1408,6 @@ xprt_request_transmit(struct rpc_rqst *req, struct rpc_task *snd_task)
 			status = -EBADMSG;
 			goto out_dequeue;
 		}
-		if (task->tk_ops->rpc_call_prepare_transmit) {
-			task->tk_ops->rpc_call_prepare_transmit(task,
-					task->tk_calldata);
-			status = task->tk_status;
-			if (status < 0)
-				goto out_dequeue;
-		}
 		if (RPC_SIGNALLED(task)) {
 			status = -ERESTARTSYS;
 			goto out_dequeue;
-- 
2.21.0

