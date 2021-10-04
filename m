Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805E421107
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhJDOMA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233159AbhJDOL7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:11:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C23D161216;
        Mon,  4 Oct 2021 14:10:10 +0000 (UTC)
Subject: [PATCH 3/4] SUNRPC: Per-rpc_clnt task PIDs
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:10:10 -0400
Message-ID: <163335661005.1225.6870220946398100360.stgit@morisot.1015granger.net>
In-Reply-To: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
References: <163335628674.1225.6965764965914263799.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The current range of RPC task PIDs is 0..65535. That's not adequate
for distinguishing tasks across multiple rpc_clnts running high
throughput workloads.

To help relieve this situation and to reduce the bottleneck of
having a single atomic for assigning all RPC task PIDs, assign task
PIDs per rpc_clnt.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/clnt.h |    1 +
 net/sunrpc/sched.c          |   12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index bd22f14c4b19..d5860a000806 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -40,6 +40,7 @@ struct rpc_clnt {
 	int			cl_clid;	/* client id */
 	struct list_head	cl_clients;	/* Global list of clients */
 	struct list_head	cl_tasks;	/* List of tasks */
+	atomic_t		cl_pid;		/* task PID counter */
 	spinlock_t		cl_lock;	/* spinlock */
 	struct rpc_xprt __rcu *	cl_xprt;	/* transport */
 	const struct rpc_procinfo *cl_procinfo;	/* procedure info */
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index c045f63d11fa..b3402aeb8f30 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -277,9 +277,17 @@ static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 static void rpc_task_set_debuginfo(struct rpc_task *task)
 {
-	static atomic_t rpc_pid;
+	struct rpc_clnt *clnt = task->tk_client;
 
-	task->tk_pid = atomic_inc_return(&rpc_pid);
+	/* Might be a task carrying a reverse-direction operation */
+	if (!clnt) {
+		static atomic_t rpc_pid;
+
+		task->tk_pid = atomic_inc_return(&rpc_pid);
+		return;
+	}
+
+	task->tk_pid = atomic_inc_return(&clnt->cl_pid);
 }
 #else
 static inline void rpc_task_set_debuginfo(struct rpc_task *task)


