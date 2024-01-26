Return-Path: <linux-nfs+bounces-1497-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9F383E0D2
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFC271F23300
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCAB20B28;
	Fri, 26 Jan 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDgCM3Zn"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCA120B03
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291162; cv=none; b=mrksbRo17Yphc8RFaf8lel/h2LvlUwoat7P9RHuhfFYLcP2C4EcV0nByk8Cwzqt2pqF5b2NkZcKXiBHYFyKlVVnHm2Hac8KD4BVm+7RSLlNG6SZ2qMFm//LuFPDdm485kdWVjThXDmUtwaOOtc1UE55/J2TPaPINax6H5SWBdQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291162; c=relaxed/simple;
	bh=DkD/KcOBF8Z+mhx6XAKVG9fTU633JRqvcNiCjaWtq6U=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VisSXd2+wzdXx5OFKuLYeXaUdP+FzYEgXzPmbbaclaMs3GS51v3idWtcyT/mcVnibNfV88d7MW2uG8Bk4dTXJTrqptFe6oMWpmoIo8VxZaNFZSAWILQPzS0LSHARRc9T03J6mraaxQDE9Q6nH6KjczGtUD5QqY11gMIb836+lUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDgCM3Zn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2636BC433F1
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291162;
	bh=DkD/KcOBF8Z+mhx6XAKVG9fTU633JRqvcNiCjaWtq6U=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=qDgCM3ZnKpW4hOX9K8V0n5YF0xOXUaDZSh9F04HiQYjytqK1FJ+B3Z/DRgKi7Fdib
	 tIam3cHeiMpG19OuTkm0YXNaH1GjeH+2MSHV1fOwxR7v2X3N+qfbmGfnQswznljoD5
	 fDPZP0PWWj7y2OLqbFkm1o941maKvN8SMiDPJOW7IUNQW7eBMVJ9aNonEIzM/2izJ0
	 hRJh52aX5ugZ95d9LcXPNhC4fL/0cplfmlO1OuBVziH/7aC0+qJoBNiJ4C1QTGKsN+
	 TwJ3g0fyLLOHtWi3XA5iUQPgMH+1zh73UhqlQ1bBjGzf2SyczvBzKJ5JX0A5FHuFb7
	 bqCMd9DggF3iQ==
Subject: [PATCH 2 08/14] NFSD: Add callback operation lifetime trace points
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:46:01 -0500
Message-ID: 
 <170629116121.20612.7731503761991240803.stgit@manet.1015granger.net>
In-Reply-To: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
References: 
 <170629091560.20612.563908774748586696.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Chuck Lever <chuck.lever@oracle.com>

Help observe the flow of callback operations.

bc_shutdown() records exactly when the backchannel RPC client is
destroyed and cl_cb_client is replaced with NULL.

Examples include:

         nfsd-955   [004]   650.013997: nfsd_cb_queue:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 cb=0xffff8881134b02f8 (first try)
kworker/u21:4-497   [004]   650.014050: nfsd_cb_seq_status:   task:00000001@00000001 sessionid=65b3c5b8:f541f749:00000001:00000000 tk_status=-107 seq_status=1
kworker/u21:4-497   [004]   650.014051: nfsd_cb_restart:      addr=192.168.122.6:0 client 65b3c5b8:f541f749 cb=0xffff88810e39f400 (first try)
kworker/u21:4-497   [004]   650.014066: nfsd_cb_queue:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 cb=0xffff88810e39f400 (need restart)


kworker/u16:0-10    [006]   650.065750: nfsd_cb_start:        addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=UNKNOWN
kworker/u16:0-10    [006]   650.065752: nfsd_cb_bc_update:    addr=192.168.122.6:0 client 65b3c5b8:f541f749 cb=0xffff8881134b02f8 (first try)
kworker/u16:0-10    [006]   650.065754: nfsd_cb_bc_shutdown:  addr=192.168.122.6:0 client 65b3c5b8:f541f749 cb=0xffff8881134b02f8 (first try)
kworker/u16:0-10    [006]   650.065810: nfsd_cb_new_state:    addr=192.168.122.6:0 client 65b3c5b8:f541f749 state=DOWN

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c   |    8 ++++++++
 fs/nfsd/trace.h          |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/trace/misc/nfs.h |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index a63171ccfc2b..b50ce54aa1bf 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -887,12 +887,14 @@ static struct workqueue_struct *callback_wq;
 
 static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 {
+	trace_nfsd_cb_queue(cb->cb_clp, cb);
 	return queue_delayed_work(callback_wq, &cb->cb_work, 0);
 }
 
 static void nfsd4_queue_cb_delayed(struct nfsd4_callback *cb,
 				   unsigned long msecs)
 {
+	trace_nfsd_cb_queue(cb->cb_clp, cb);
 	queue_delayed_work(callback_wq, &cb->cb_work,
 			   msecs_to_jiffies(msecs));
 }
@@ -1113,6 +1115,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 
+	trace_nfsd_cb_destroy(clp, cb);
 	nfsd41_cb_release_slot(cb);
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
@@ -1227,6 +1230,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	goto out;
 need_restart:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;
 		cb->cb_need_restart = true;
 	}
@@ -1340,11 +1344,14 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	struct nfsd4_conn *c;
 	int err;
 
+	trace_nfsd_cb_bc_update(clp, cb);
+
 	/*
 	 * This is either an update, or the client dying; in either case,
 	 * kill the old client:
 	 */
 	if (clp->cl_cb_client) {
+		trace_nfsd_cb_bc_shutdown(clp, cb);
 		rpc_shutdown_client(clp->cl_cb_client);
 		clp->cl_cb_client = NULL;
 		put_cred(clp->cl_cb_cred);
@@ -1356,6 +1363,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 	}
 	if (test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags))
 		return;
+
 	spin_lock(&clp->cl_lock);
 	/*
 	 * Only serialized callback code is allowed to clear these
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 6003af2bee33..9f9e58debc26 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1443,6 +1443,48 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		__entry->error)
 );
 
+DECLARE_EVENT_CLASS(nfsd_cb_lifetime_class,
+	TP_PROTO(
+		const struct nfs4_client *clp,
+		const struct nfsd4_callback *cb
+	),
+	TP_ARGS(clp, cb),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(const void *, cb)
+		__field(bool, need_restart)
+		__sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
+	),
+	TP_fast_assign(
+		__entry->cl_boot = clp->cl_clientid.cl_boot;
+		__entry->cl_id = clp->cl_clientid.cl_id;
+		__entry->cb = cb;
+		__entry->need_restart = cb->cb_need_restart;
+		__assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
+				  clp->cl_cb_conn.cb_addrlen)
+	),
+	TP_printk("addr=%pISpc client %08x:%08x cb=%p%s",
+		__get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
+		__entry->cb, __entry->need_restart ?
+			" (need restart)" : " (first try)"
+	)
+);
+
+#define DEFINE_NFSD_CB_LIFETIME_EVENT(name)		\
+DEFINE_EVENT(nfsd_cb_lifetime_class, nfsd_cb_##name,	\
+	TP_PROTO(					\
+		const struct nfs4_client *clp,		\
+		const struct nfsd4_callback *cb		\
+	),						\
+	TP_ARGS(clp, cb))
+
+DEFINE_NFSD_CB_LIFETIME_EVENT(queue);
+DEFINE_NFSD_CB_LIFETIME_EVENT(destroy);
+DEFINE_NFSD_CB_LIFETIME_EVENT(restart);
+DEFINE_NFSD_CB_LIFETIME_EVENT(bc_update);
+DEFINE_NFSD_CB_LIFETIME_EVENT(bc_shutdown);
+
 TRACE_EVENT(nfsd_cb_seq_status,
 	TP_PROTO(
 		const struct rpc_task *task,
diff --git a/include/trace/misc/nfs.h b/include/trace/misc/nfs.h
index 0d9d48dca38a..64ab5dac59ce 100644
--- a/include/trace/misc/nfs.h
+++ b/include/trace/misc/nfs.h
@@ -385,3 +385,37 @@ TRACE_DEFINE_ENUM(IOMODE_ANY);
 		{ SEQ4_STATUS_RESTART_RECLAIM_NEEDED,	"RESTART_RECLAIM_NEEDED" }, \
 		{ SEQ4_STATUS_CB_PATH_DOWN_SESSION,	"CB_PATH_DOWN_SESSION" }, \
 		{ SEQ4_STATUS_BACKCHANNEL_FAULT,	"BACKCHANNEL_FAULT" })
+
+TRACE_DEFINE_ENUM(OP_CB_GETATTR);
+TRACE_DEFINE_ENUM(OP_CB_RECALL);
+TRACE_DEFINE_ENUM(OP_CB_LAYOUTRECALL);
+TRACE_DEFINE_ENUM(OP_CB_NOTIFY);
+TRACE_DEFINE_ENUM(OP_CB_PUSH_DELEG);
+TRACE_DEFINE_ENUM(OP_CB_RECALL_ANY);
+TRACE_DEFINE_ENUM(OP_CB_RECALLABLE_OBJ_AVAIL);
+TRACE_DEFINE_ENUM(OP_CB_RECALL_SLOT);
+TRACE_DEFINE_ENUM(OP_CB_SEQUENCE);
+TRACE_DEFINE_ENUM(OP_CB_WANTS_CANCELLED);
+TRACE_DEFINE_ENUM(OP_CB_NOTIFY_LOCK);
+TRACE_DEFINE_ENUM(OP_CB_NOTIFY_DEVICEID);
+TRACE_DEFINE_ENUM(OP_CB_OFFLOAD);
+TRACE_DEFINE_ENUM(OP_CB_ILLEGAL);
+
+#define show_nfs4_cb_op(x) \
+	__print_symbolic(x, \
+		{ 0,				"CB_NULL" }, \
+		{ 1,				"CB_COMPOUND" }, \
+		{ OP_CB_GETATTR,		"CB_GETATTR" }, \
+		{ OP_CB_RECALL,			"CB_RECALL" }, \
+		{ OP_CB_LAYOUTRECALL,		"CB_LAYOUTRECALL" }, \
+		{ OP_CB_NOTIFY,			"CB_NOTIFY" }, \
+		{ OP_CB_PUSH_DELEG,		"CB_PUSH_DELEG" }, \
+		{ OP_CB_RECALL_ANY,		"CB_RECALL_ANY" }, \
+		{ OP_CB_RECALLABLE_OBJ_AVAIL,	"CB_RECALLABLE_OBJ_AVAIL" }, \
+		{ OP_CB_RECALL_SLOT,		"CB_RECALL_SLOT" }, \
+		{ OP_CB_SEQUENCE,		"CB_SEQUENCE" }, \
+		{ OP_CB_WANTS_CANCELLED,	"CB_WANTS_CANCELLED" }, \
+		{ OP_CB_NOTIFY_LOCK,		"CB_NOTIFY_LOCK" }, \
+		{ OP_CB_NOTIFY_DEVICEID,	"CB_NOTIFY_DEVICEID" }, \
+		{ OP_CB_OFFLOAD,		"CB_OFFLOAD" }, \
+		{ OP_CB_ILLEGAL,		"CB_ILLEGAL" })



