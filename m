Return-Path: <linux-nfs+bounces-1394-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263DA83C803
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93269B23411
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5116A12AACC;
	Thu, 25 Jan 2024 16:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8UAz5A7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3B712AAC8
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200166; cv=none; b=S5nH3lf6pJvfUKDqVSOEfIPqC8Ff/q1W0NNP8W7hF9BK8yGCMpt3PBrd+rO7jluj+mV1aTSGIjSIV/SLEKKDoPATYUSiGh8CLMitox8Cw829hBI1SE0hEIOjbyS5Cz5rKT/ZdqEgJ3l7nKh8wyCVRd5h4TZAr4WySgrAxl2QDpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200166; c=relaxed/simple;
	bh=JCksfE9E9NZpEYvbjJDNRnwygfp+WHNDxgF+YzMgTPA=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVEtMgfoEZUQcFoOcSM2sx1fZAwyoUDTigK6khcUF7kfMUGlPFa7i/npKi8DeQylPkZce7drWBE7iWrR3SZtam/2W4pceApN4tRBnkGb304wgB+8IUHcHkHIrZeZrYSn9Xu+1nI3FpMUP4c1sUr1lFlVFKb42Wsu0U15Fdh5420=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8UAz5A7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87199C43390
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200165;
	bh=JCksfE9E9NZpEYvbjJDNRnwygfp+WHNDxgF+YzMgTPA=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=D8UAz5A7Uq2++5yXZuyTUcHNz2slMy2gyVFAETkJp1ryKrT/IztRH6QjDG+kNYI5s
	 LtM6oGsLHfPVluriAOp7TmgLMJYD6hVKBSnSZOhcoPhj0hU8IaqFsGHcnd5aZvr8AS
	 cSF6G4P5d0/+waYW2t/qFOUXJo4WeJNR9AT0zyBUPbeMrdCw7GqxouuQJjXvxLbHzV
	 22+OV7EEeS2Aj2WLuL7NQAlan0Vxa7zow2F2SVveVQSgSNUs/hkcPnP90khgRWyJVw
	 Batnrb+8fvv2iA/6R2O9KF0HqL7dtcnyOi3Pihh9rbz+9Xg/G5tuoaDuxxuUk4bY9u
	 uh6xriCPatkxA==
Subject: [PATCH RFC 07/13] NFSD: Add callback operation lifetime trace points
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:24 -0500
Message-ID: 
 <170620016455.2833.5426224225062159088.stgit@manet.1015granger.net>
In-Reply-To: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
References: 
 <170619984210.2833.7173004255003914651.stgit@manet.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c   |    7 +++++++
 fs/nfsd/trace.h          |   42 ++++++++++++++++++++++++++++++++++++++++++
 include/trace/misc/nfs.h |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1c85426830b1..4d5a6370b92c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -887,6 +887,7 @@ static struct workqueue_struct *callback_wq;
 
 static bool nfsd4_queue_cb(struct nfsd4_callback *cb)
 {
+	trace_nfsd_cb_queue(cb->cb_clp, cb);
 	return queue_work(callback_wq, &cb->cb_work);
 }
 
@@ -1106,6 +1107,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
 
+	trace_nfsd_cb_destroy(clp, cb);
 	nfsd41_cb_release_slot(cb);
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
@@ -1220,6 +1222,7 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	goto out;
 need_restart:
 	if (!test_bit(NFSD4_CLIENT_CB_KILL, &clp->cl_flags)) {
+		trace_nfsd_cb_restart(clp, cb);
 		task->tk_status = 0;
 		cb->cb_need_restart = true;
 	}
@@ -1333,11 +1336,14 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
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
@@ -1349,6 +1355,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
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



