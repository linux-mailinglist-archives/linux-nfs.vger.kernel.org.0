Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4193523CC4A
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Aug 2020 18:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHEQgm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Aug 2020 12:36:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbgHEQeh (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:37 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E904C235F9
        for <linux-nfs@vger.kernel.org>; Wed,  5 Aug 2020 16:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596644215;
        bh=yn16hTfeAN7v9zr3ZQIMfWk0+F1q90uR69Eqk8hWbIo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LKcHVkyRv3qbEzbfKjV2bTWMBFUY0AgEvlQNKzof5DVs3Ed1o1bMM71pUKDmu+qFK
         5I4VstC61g1uuKJrpOyB9oIgtNNyW7LYdnwThCc0Zwmm5HandHG6fQyaiaG4lG+hMt
         WPTl8gqtmDdfwxzM1Lhes+ykBP1acSoYs33/JmVw=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: Add tracepoints for layouterror and layoutstats.
Date:   Wed,  5 Aug 2020 12:14:45 -0400
Message-Id: <20200805161446.383482-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805161446.383482-1-trondmy@kernel.org>
References: <20200805161446.383482-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Allow tracing of the NFSv4.2 layouterror and layoutstats operations.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/nfs42proc.c | 10 ++++++++--
 fs/nfs/nfs4trace.h |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index e200522469af..142225f0af59 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -17,6 +17,7 @@
 #include "nfs4session.h"
 #include "internal.h"
 #include "delegation.h"
+#include "nfs4trace.h"
 
 #define NFSDBG_FACILITY NFSDBG_PROC
 static int nfs42_do_offload_cancel_async(struct file *dst, nfs4_stateid *std);
@@ -714,7 +715,7 @@ nfs42_layoutstat_done(struct rpc_task *task, void *calldata)
 
 	switch (task->tk_status) {
 	case 0:
-		break;
+		return;
 	case -NFS4ERR_BADHANDLE:
 	case -ESTALE:
 		pnfs_destroy_layout(NFS_I(inode));
@@ -760,6 +761,8 @@ nfs42_layoutstat_done(struct rpc_task *task, void *calldata)
 	case -EOPNOTSUPP:
 		NFS_SERVER(inode)->caps &= ~NFS_CAP_LAYOUTSTATS;
 	}
+
+	trace_nfs4_layoutstats(inode, &data->args.stateid, task->tk_status);
 }
 
 static void
@@ -882,7 +885,7 @@ nfs42_layouterror_done(struct rpc_task *task, void *calldata)
 
 	switch (task->tk_status) {
 	case 0:
-		break;
+		return;
 	case -NFS4ERR_BADHANDLE:
 	case -ESTALE:
 		pnfs_destroy_layout(NFS_I(inode));
@@ -926,6 +929,9 @@ nfs42_layouterror_done(struct rpc_task *task, void *calldata)
 	case -EOPNOTSUPP:
 		NFS_SERVER(inode)->caps &= ~NFS_CAP_LAYOUTERROR;
 	}
+
+	trace_nfs4_layouterror(inode, &data->args.errors[0].stateid,
+			       task->tk_status);
 }
 
 static void
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 07ea8d847710..61c33536dcf3 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -1994,6 +1994,8 @@ TRACE_EVENT(nfs4_layoutget,
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_layoutcommit);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_layoutreturn);
 DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_layoutreturn_on_close);
+DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_layouterror);
+DEFINE_NFS4_INODE_STATEID_EVENT(nfs4_layoutstats);
 
 TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_UNKNOWN);
 TRACE_DEFINE_ENUM(PNFS_UPDATE_LAYOUT_NO_PNFS);
-- 
2.26.2

