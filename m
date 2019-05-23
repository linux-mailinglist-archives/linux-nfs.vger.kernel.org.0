Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 678F028B5A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 22:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfEWUOH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 16:14:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbfEWUOH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 16:14:07 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E07EADF26
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 20:14:06 +0000 (UTC)
Received: from f29-node1.dwysocha.net (dhcp145-42.rdu.redhat.com [10.13.145.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B52C26012C
        for <linux-nfs@vger.kernel.org>; Thu, 23 May 2019 20:14:06 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] SUNRPC: Move call to rpc_count_iostats before rpc_call_done
Date:   Thu, 23 May 2019 16:13:48 -0400
Message-Id: <20190523201351.12232-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 23 May 2019 20:14:06 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For diagnostic purposes, it would be useful to have an rpc_iostats
metric of RPCs completing with tk_status < 0.  Unfortunately,
tk_status is reset inside the rpc_call_done functions for each
operation, and the call to tally the per-op metrics comes after
rpc_call_done.  Refactor the call to rpc_count_iostat earlier in
rpc_exit_task so we can count these RPCs completing in error.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 net/sunrpc/sched.c | 5 +++++
 net/sunrpc/xprt.c  | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 28956c70100a..543caef296e4 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -22,6 +22,7 @@
 #include <linux/sched/mm.h>
 
 #include <linux/sunrpc/clnt.h>
+#include <linux/sunrpc/metrics.h>
 
 #include "sunrpc.h"
 
@@ -770,6 +771,10 @@ rpc_reset_task_statistics(struct rpc_task *task)
 void rpc_exit_task(struct rpc_task *task)
 {
 	task->tk_action = NULL;
+	if (task->tk_ops->rpc_count_stats)
+		task->tk_ops->rpc_count_stats(task, task->tk_calldata);
+	else if (task->tk_client)
+		rpc_count_iostats(task, task->tk_client->cl_metrics);
 	if (task->tk_ops->rpc_call_done != NULL) {
 		task->tk_ops->rpc_call_done(task, task->tk_calldata);
 		if (task->tk_action != NULL) {
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index d7117d241460..d4477b227a96 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1716,10 +1716,6 @@ void xprt_release(struct rpc_task *task)
 	}
 
 	xprt = req->rq_xprt;
-	if (task->tk_ops->rpc_count_stats != NULL)
-		task->tk_ops->rpc_count_stats(task, task->tk_calldata);
-	else if (task->tk_client)
-		rpc_count_iostats(task, task->tk_client->cl_metrics);
 	xprt_request_dequeue_all(task, req);
 	spin_lock_bh(&xprt->transport_lock);
 	xprt->ops->release_xprt(xprt, task);
-- 
2.20.1

