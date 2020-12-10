Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5C22D58AD
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Dec 2020 11:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbgLJK4f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Dec 2020 05:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgLJK43 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Dec 2020 05:56:29 -0500
Received: from smtp-o-1.desy.de (smtp-o-1.desy.de [IPv6:2001:638:700:1038::1:9a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2DC0613D6
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 02:55:48 -0800 (PST)
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id CCCD6E0858
        for <linux-nfs@vger.kernel.org>; Thu, 10 Dec 2020 11:55:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de CCCD6E0858
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1607597745; bh=B+jlAUAcRssnYcKi4pFhrdSjTYVxa6h13RNO3igboK0=;
        h=From:To:Cc:Subject:Date:From;
        b=SiBbE53KDF/JvuCBNGSc6JdASTeH5On9HUFaHmNsB7a/jP/UzTTvmG2KYSLrbtSJe
         42INOooH9mJBtYTDkdc2kGt+ALZeZ+R8G562P1RQN07ofQgQ8c/RRyWVFMrNJmxaYm
         +VuJ8dEfZsEXHDm8qAk4VVsbLLXPMkPqOQa0XfSE=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [IPv6:2001:638:700:1038::1:81])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id C60661208A0;
        Thu, 10 Dec 2020 11:55:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from os-46-nfs-devel.desy.de (os-46-nfs-devel.desy.de [131.169.46.150])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 9807880067;
        Thu, 10 Dec 2020 11:55:45 +0100 (CET)
From:   Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
To:     linux-nfs@vger.kernel.org
Cc:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com,
        Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Subject: [PATCH] nfs41: update ff_layout_io_track_ds_error to accept rpc task
Date:   Thu, 10 Dec 2020 10:55:43 +0000
Message-Id: <20201210105543.22489-1-tigran.mkrtchyan@desy.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When debugging READ_PLUS issues sent to DS I noticed that layoutstats
was reporting READ, though READ_PLUS was used.

The ff_layout_io_track_ds_error function takes the 'major' opnum as an
argumentas well as the corresponding resulting error code.

By passing rpc task as an argument, the bogh values can be extracted
insideff_layout_io_track_ds_error and reduce a possibility of calling
with incorrect opnum.

Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a163533446fa..9da11586f685 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1213,11 +1213,13 @@ static int ff_layout_async_handle_error(struct rpc_task *task,
 
 static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 					u32 idx, u64 offset, u64 length,
-					u32 *op_status, int opnum, int error)
+					u32 *op_status, struct rpc_task *task)
 {
 	struct nfs4_ff_layout_mirror *mirror;
 	u32 status = *op_status;
 	int err;
+	int error = task->tk_status;
+	int opnum = task->tk_msg.rpc_proc->p_statidx;
 
 	if (status == 0) {
 		switch (error) {
@@ -1279,8 +1281,7 @@ static int ff_layout_read_done_cb(struct rpc_task *task,
 	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
-					    &hdr->res.op_status, OP_READ,
-					    task->tk_status);
+					    &hdr->res.op_status, task);
 		trace_ff_layout_read_error(hdr);
 	}
 
@@ -1446,8 +1447,7 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
-					    &hdr->res.op_status, OP_WRITE,
-					    task->tk_status);
+					    &hdr->res.op_status, task);
 		trace_ff_layout_write_error(hdr);
 	}
 
@@ -1492,8 +1492,7 @@ static int ff_layout_commit_done_cb(struct rpc_task *task,
 	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(data->lseg, data->ds_commit_index,
 					    data->args.offset, data->args.count,
-					    &data->res.op_status, OP_COMMIT,
-					    task->tk_status);
+					    &data->res.op_status, task);
 		trace_ff_layout_commit_error(data);
 	}
 
-- 
2.27.0

