Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB6038114E
	for <lists+linux-nfs@lfdr.de>; Fri, 14 May 2021 21:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233293AbhENT6u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 May 2021 15:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233319AbhENT6p (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 14 May 2021 15:58:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F79E615FF;
        Fri, 14 May 2021 19:57:33 +0000 (UTC)
Subject: [PATCH v3 23/24] NFSD: Remove the nfsd_cb_work and nfsd_cb_done
 tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dwysocha@redhat.com, bfields@fieldses.org
Date:   Fri, 14 May 2021 15:57:32 -0400
Message-ID: <162102225282.10915.17556235969391089960.stgit@klimt.1015granger.net>
In-Reply-To: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
References: <162102191240.10915.5003178983503027218.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: These are noise in properly working systems. If you really
need to observe the operation of the callback mechanism, use the
sunrpc:rpc\* tracepoints along with the workqueue tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    5 -----
 fs/nfsd/trace.h        |   48 ------------------------------------------------
 2 files changed, 53 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index ddab969d7865..84401ca04705 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -970,7 +970,6 @@ static void nfsd4_cb_probe_done(struct rpc_task *task, void *calldata)
 {
 	struct nfs4_client *clp = container_of(calldata, struct nfs4_client, cl_cb_null);
 
-	trace_nfsd_cb_done(clp, task->tk_status);
 	if (task->tk_status)
 		nfsd4_mark_cb_down(clp, task->tk_status);
 	else
@@ -1172,8 +1171,6 @@ static void nfsd4_cb_done(struct rpc_task *task, void *calldata)
 	struct nfsd4_callback *cb = calldata;
 	struct nfs4_client *clp = cb->cb_clp;
 
-	trace_nfsd_cb_done(clp, task->tk_status);
-
 	if (!nfsd4_cb_sequence_done(task, cb))
 		return;
 
@@ -1326,8 +1323,6 @@ nfsd4_run_cb_work(struct work_struct *work)
 	struct rpc_clnt *clnt;
 	int flags;
 
-	trace_nfsd_cb_work(clp, cb->cb_msg.rpc_proc->p_name);
-
 	if (cb->cb_need_restart) {
 		cb->cb_need_restart = false;
 	} else {
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 2cdcf53a2c41..daadcb54886d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -979,54 +979,6 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		__entry->addr, __entry->cl_boot, __entry->cl_id, __entry->error)
 );
 
-TRACE_EVENT(nfsd_cb_work,
-	TP_PROTO(
-		const struct nfs4_client *clp,
-		const char *procedure
-	),
-	TP_ARGS(clp, procedure),
-	TP_STRUCT__entry(
-		__field(u32, cl_boot)
-		__field(u32, cl_id)
-		__string(procedure, procedure)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
-	),
-	TP_fast_assign(
-		__entry->cl_boot = clp->cl_clientid.cl_boot;
-		__entry->cl_id = clp->cl_clientid.cl_id;
-		__assign_str(procedure, procedure)
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
-	),
-	TP_printk("addr=%pISpc client %08x:%08x procedure=%s",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
-		__get_str(procedure))
-);
-
-TRACE_EVENT(nfsd_cb_done,
-	TP_PROTO(
-		const struct nfs4_client *clp,
-		int status
-	),
-	TP_ARGS(clp, status),
-	TP_STRUCT__entry(
-		__field(u32, cl_boot)
-		__field(u32, cl_id)
-		__field(int, status)
-		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
-	),
-	TP_fast_assign(
-		__entry->cl_boot = clp->cl_clientid.cl_boot;
-		__entry->cl_id = clp->cl_clientid.cl_id;
-		__entry->status = status;
-		memcpy(__entry->addr, &clp->cl_cb_conn.cb_addr,
-			sizeof(struct sockaddr_in6));
-	),
-	TP_printk("addr=%pISpc client %08x:%08x status=%d",
-		__entry->addr, __entry->cl_boot, __entry->cl_id,
-		__entry->status)
-);
-
 TRACE_EVENT(nfsd_cb_recall,
 	TP_PROTO(
 		const struct nfs4_stid *stid


