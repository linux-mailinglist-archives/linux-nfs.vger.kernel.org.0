Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2C350560
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 19:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbhCaRW4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 13:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233867AbhCaRWW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 13:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C977861042;
        Wed, 31 Mar 2021 17:22:21 +0000 (UTC)
Subject: [PATCH 2/3] SUNRPC: Fix trace_xprt_transmit_queued()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 13:22:20 -0400
Message-ID: <161721134086.515091.16531400209127881709.stgit@manet.1015granger.net>
In-Reply-To: <161721133412.515091.3634995666026759187.stgit@manet.1015granger.net>
References: <161721133412.515091.3634995666026759187.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This tracepoint can crash when dereferencing snd_task because
when some transports connect, they put a cookie in that field
instead of a pointer to an rpc_task.

BUG: KASAN: use-after-free in trace_event_raw_event_xprt_writelock_event+0x141/0x18e [sunrpc]
Read of size 2 at addr ffff8881a83bd3a0 by task git/331872

CPU: 11 PID: 331872 Comm: git Tainted: G S                5.12.0-rc2-00007-g3ab6e585a7f9 #1453
Hardware name: Supermicro SYS-6028R-T/X10DRi, BIOS 1.1a 10/16/2015
Call Trace:
 dump_stack+0x9c/0xcf
 print_address_description.constprop.0+0x18/0x239
 kasan_report+0x174/0x1b0
 trace_event_raw_event_xprt_writelock_event+0x141/0x18e [sunrpc]
 xprt_prepare_transmit+0x8e/0xc1 [sunrpc]
 call_transmit+0x4d/0xc6 [sunrpc]

Fixes: 9ce07ae5eb1d ("SUNRPC: Replace dprintk() call site in xprt_prepare_transmit")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   35 ++++++++++++++++++++++++++++++++++-
 net/sunrpc/xprt.c             |    2 +-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 036eb1f5c133..690988530d60 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1141,7 +1141,40 @@ DECLARE_EVENT_CLASS(xprt_writelock_event,
 
 DEFINE_WRITELOCK_EVENT(reserve_xprt);
 DEFINE_WRITELOCK_EVENT(release_xprt);
-DEFINE_WRITELOCK_EVENT(transmit_queued);
+
+TRACE_EVENT(xprt_transmit_queued,
+	TP_PROTO(
+		const struct rpc_task *task
+	),
+
+	TP_ARGS(task),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(unsigned long, runstate)
+		__field(u32, xid)
+		__field(int, status)
+		__field(unsigned short, flags)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id =
+			task->tk_client ? task->tk_client->cl_clid : -1;
+		__entry->runstate = task->tk_runstate;
+		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
+		__entry->status = task->tk_status;
+		__entry->flags = task->tk_flags;
+	),
+
+	TP_printk("task:%u@%u xid=0x%08x flags=%s runstate=%s status=%d",
+		__entry->task_id, __entry->client_id, __entry->xid,
+		rpc_show_task_flags(__entry->flags),
+		rpc_show_runstate(__entry->runstate),
+		__entry->status
+	)
+);
 
 DECLARE_EVENT_CLASS(xprt_cong_event,
 	TP_PROTO(
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index d616b93751d8..b694af4504c4 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1469,7 +1469,7 @@ bool xprt_prepare_transmit(struct rpc_task *task)
 	struct rpc_xprt	*xprt = req->rq_xprt;
 
 	if (!xprt_lock_write(xprt, task)) {
-		trace_xprt_transmit_queued(xprt, task);
+		trace_xprt_transmit_queued(task);
 
 		/* Race breaker: someone may have transmitted us */
 		if (!test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate))


