Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAA92E9C4
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfE3AnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:46392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3AnK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26D29AC66;
        Thu, 30 May 2019 00:43:09 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 1/9] SUNRPC: Add basic load balancing to the transport switch
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688854.3988.7703839883828652258.stgit@noble.brown>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

For now, just count the queue length. It is less accurate than counting
number of bytes queued, but easier to implement.

As we now increment a queue length whenever an xprt is attached to a
task, and decrement when it is detached, we need to ensure that
happens for *all* tasks, whether selected automatically or passed in
by the caller.

Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/sunrpc/xprt.h          |    1 +
 include/linux/sunrpc/xprtmultipath.h |    2 +
 net/sunrpc/clnt.c                    |   57 ++++++++++++++++++++++++++++++++--
 net/sunrpc/sched.c                   |    3 +-
 net/sunrpc/sunrpc.h                  |    3 ++
 net/sunrpc/xprtmultipath.c           |   20 +++++++++++-
 6 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index a6d9fce7f20e..15322c1d9c8c 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -238,6 +238,7 @@ struct rpc_xprt {
 	/*
 	 * Send stuff
 	 */
+	atomic_long_t		queuelen;
 	spinlock_t		transport_lock;	/* lock transport info */
 	spinlock_t		reserve_lock;	/* lock slot table */
 	spinlock_t		queue_lock;	/* send/receive queue lock */
diff --git a/include/linux/sunrpc/xprtmultipath.h b/include/linux/sunrpc/xprtmultipath.h
index af1257c030d2..c6cce3fbf29d 100644
--- a/include/linux/sunrpc/xprtmultipath.h
+++ b/include/linux/sunrpc/xprtmultipath.h
@@ -15,6 +15,8 @@ struct rpc_xprt_switch {
 	struct kref		xps_kref;
 
 	unsigned int		xps_nxprts;
+	unsigned int		xps_nactive;
+	atomic_long_t		xps_queuelen;
 	struct list_head	xps_xprt_list;
 
 	struct net *		xps_net;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index d6e57da56c94..371080ad698a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -969,13 +969,64 @@ struct rpc_clnt *rpc_bind_new_program(struct rpc_clnt *old,
 }
 EXPORT_SYMBOL_GPL(rpc_bind_new_program);
 
+static struct rpc_xprt *
+rpc_task_get_xprt(struct rpc_clnt *clnt)
+{
+	struct rpc_xprt_switch *xps;
+	struct rpc_xprt *xprt= xprt_iter_get_next(&clnt->cl_xpi);
+
+	if (!xprt)
+		return NULL;
+	rcu_read_lock();
+	xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+	atomic_long_inc(&xps->xps_queuelen);
+	rcu_read_unlock();
+	atomic_long_inc(&xprt->queuelen);
+
+	return xprt;
+}
+
+struct rpc_xprt *
+xprt_get_client(struct rpc_xprt *xprt, struct rpc_clnt *clnt)
+{
+	struct rpc_xprt_switch *xps;
+
+	rcu_read_lock();
+	if (xprt) {
+		xprt_get(xprt);
+		atomic_long_inc(&xprt->queuelen);
+		xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+		atomic_long_inc(&xps->xps_queuelen);
+	}
+	rcu_read_unlock();
+
+	return xprt;
+}
+
+static void
+rpc_task_release_xprt(struct rpc_clnt *clnt, struct rpc_xprt *xprt)
+{
+	struct rpc_xprt_switch *xps;
+
+	atomic_long_dec(&xprt->queuelen);
+	rcu_read_lock();
+	xps = rcu_dereference(clnt->cl_xpi.xpi_xpswitch);
+	atomic_long_dec(&xps->xps_queuelen);
+	rcu_read_unlock();
+
+	xprt_put(xprt);
+}
+
 void rpc_task_release_transport(struct rpc_task *task)
 {
 	struct rpc_xprt *xprt = task->tk_xprt;
 
 	if (xprt) {
 		task->tk_xprt = NULL;
-		xprt_put(xprt);
+		if (task->tk_client)
+			rpc_task_release_xprt(task->tk_client, xprt);
+		else
+			xprt_put(xprt);
 	}
 }
 EXPORT_SYMBOL_GPL(rpc_task_release_transport);
@@ -984,6 +1035,7 @@ void rpc_task_release_client(struct rpc_task *task)
 {
 	struct rpc_clnt *clnt = task->tk_client;
 
+	rpc_task_release_transport(task);
 	if (clnt != NULL) {
 		/* Remove from client task list */
 		spin_lock(&clnt->cl_lock);
@@ -993,14 +1045,13 @@ void rpc_task_release_client(struct rpc_task *task)
 
 		rpc_release_client(clnt);
 	}
-	rpc_task_release_transport(task);
 }
 
 static
 void rpc_task_set_transport(struct rpc_task *task, struct rpc_clnt *clnt)
 {
 	if (!task->tk_xprt)
-		task->tk_xprt = xprt_iter_get_next(&clnt->cl_xpi);
+		task->tk_xprt = rpc_task_get_xprt(clnt);
 }
 
 static
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index bb04ae52803a..d1391ea8c9bb 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1078,7 +1078,8 @@ static void rpc_init_task(struct rpc_task *task, const struct rpc_task_setup *ta
 	/* Initialize workqueue for async tasks */
 	task->tk_workqueue = task_setup_data->workqueue;
 
-	task->tk_xprt = xprt_get(task_setup_data->rpc_xprt);
+	task->tk_xprt = xprt_get_client(task_setup_data->rpc_xprt,
+					task_setup_data->rpc_client);
 
 	task->tk_op_cred = get_rpccred(task_setup_data->rpc_op_cred);
 
diff --git a/net/sunrpc/sunrpc.h b/net/sunrpc/sunrpc.h
index c9bacb3c930f..c52605222448 100644
--- a/net/sunrpc/sunrpc.h
+++ b/net/sunrpc/sunrpc.h
@@ -56,4 +56,7 @@ int svc_send_common(struct socket *sock, struct xdr_buf *xdr,
 
 int rpc_clients_notifier_register(void);
 void rpc_clients_notifier_unregister(void);
+
+struct rpc_xprt *
+xprt_get_client(struct rpc_xprt *xprt, struct rpc_clnt *clnt);
 #endif /* _NET_SUNRPC_SUNRPC_H */
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 8394124126f8..394e427533be 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -36,6 +36,7 @@ static void xprt_switch_add_xprt_locked(struct rpc_xprt_switch *xps,
 	if (xps->xps_nxprts == 0)
 		xps->xps_net = xprt->xprt_net;
 	xps->xps_nxprts++;
+	xps->xps_nactive++;
 }
 
 /**
@@ -62,6 +63,7 @@ static void xprt_switch_remove_xprt_locked(struct rpc_xprt_switch *xps,
 {
 	if (unlikely(xprt == NULL))
 		return;
+	xps->xps_nactive--;
 	xps->xps_nxprts--;
 	if (xps->xps_nxprts == 0)
 		xps->xps_net = NULL;
@@ -317,8 +319,24 @@ struct rpc_xprt *xprt_switch_find_next_entry_roundrobin(struct list_head *head,
 static
 struct rpc_xprt *xprt_iter_next_entry_roundrobin(struct rpc_xprt_iter *xpi)
 {
-	return xprt_iter_next_entry_multiple(xpi,
+	struct rpc_xprt_switch *xps = rcu_dereference(xpi->xpi_xpswitch);
+	struct rpc_xprt *xprt;
+	unsigned long xprt_queuelen;
+	unsigned long xps_queuelen;
+	unsigned long xps_avglen;
+
+	do {
+		xprt = xprt_iter_next_entry_multiple(xpi,
 			xprt_switch_find_next_entry_roundrobin);
+		if (xprt == NULL)
+			break;
+		xprt_queuelen = atomic_long_read(&xprt->queuelen);
+		if (xprt_queuelen <= 2)
+			break;
+		xps_queuelen = atomic_long_read(&xps->xps_queuelen);
+		xps_avglen = DIV_ROUND_UP(xps_queuelen, xps->xps_nactive);
+	} while (xprt_queuelen > xps_avglen);
+	return xprt;
 }
 
 static


