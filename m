Return-Path: <linux-nfs+bounces-1391-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD283C7F7
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 17:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0975E1F278C6
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Jan 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8033C7762A;
	Thu, 25 Jan 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lr9m2JgI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D19E73177
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200153; cv=none; b=UcT4/h/zbU/E1WWaQ2lGKqbfvsUFY669NzlERElAAPGPRzHDrKjS0IQDUntwyE1EpiFeBqq+Hdyct+VQyzC4MOop4f4EGIk2+4blIyl0VXyNr3kG9pS3fFVYw0CiesYjhR3DWKjLQMgTg5AJmwERz+U2bPql3oQ1/VZEHAKfCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200153; c=relaxed/simple;
	bh=yg1cathIUyrV9IS6y9PWgPaIGAsOOS1P24iPNTZKq58=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CRFnchcTiPwcZ44r54oLxUD1kS08wSE8j0E1dLRo/YKYgBLNuXFulh0zDkKggdLMe7g3M8dtFdtWpNNHDh803pnk+BcEo6HhToVIKfiRYXX+MuFvPBARoOOvI8gVKFJw0acqIIlPRCjCHtHXag8tGhpGHZ4zMDTxxLSLlV+jCbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lr9m2JgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF91C433F1
	for <linux-nfs@vger.kernel.org>; Thu, 25 Jan 2024 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200153;
	bh=yg1cathIUyrV9IS6y9PWgPaIGAsOOS1P24iPNTZKq58=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Lr9m2JgIJ904brilZ2ichIILSswrLRueCRoWDIPA7eXt0Ejo+pQc9Y026Uyheffl5
	 K3BmcWnohsq++yrpP0GA8qQamkmasazj1J5QWYbXkmbl1C8Yq8LbnsKCmvT2N1sQb4
	 NcacEhvt+MCJatoJgBwTQpl7AxvXx+BU2pKMP1hVTFmIaPylpJHvIG1mV9Bz8Q7WR5
	 LJlF6a0uJlpAD+mUp+qSCWYjVqyzanxF2yO7pZY8DBAdBPeezMzIzc3sBlVEquuJ1k
	 IoH3liyYLmhiW3ETHO/EDu9an+5GeXwMKPioKG1ZzfBKBprApnIoeSDct/aKOJFbuH
	 icTjoT0WQJQvw==
Subject: [PATCH RFC 05/13] NFSD: Replace dprintks in nfsd4_cb_sequence_done()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Thu, 25 Jan 2024 11:29:11 -0500
Message-ID: 
 <170620015178.2833.16037962437262794375.stgit@manet.1015granger.net>
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

Improve observability of backchannel session operation.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    9 ++---
 fs/nfsd/trace.h        |   82 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 1ff64efe1f5c..9f5aebeef83c 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1158,6 +1158,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	if (!cb->cb_holds_slot)
 		goto need_restart;
 
+	/* This is the operation status code for CB_SEQUENCE */
+	trace_nfsd_cb_seq_status(task, cb);
 	switch (cb->cb_seq_status) {
 	case 0:
 		/*
@@ -1203,13 +1205,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		break;
 	default:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
-		dprintk("%s: unprocessed error %d\n", __func__,
-			cb->cb_seq_status);
 	}
-
 	nfsd41_cb_release_slot(cb);
-	dprintk("%s: freed slot, new seqid=%d\n", __func__,
-		clp->cl_cb_session->se_cb_seq_nr);
+
+	trace_nfsd_cb_free_slot(task, cb);
 
 	if (RPC_SIGNALLED(task))
 		goto need_restart;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 38d11b43779c..c134c755ae5d 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -9,8 +9,10 @@
 #define _NFSD_TRACE_H
 
 #include <linux/tracepoint.h>
+#include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
 #include <trace/misc/nfs.h>
+#include <trace/misc/sunrpc.h>
 
 #include "export.h"
 #include "nfsfh.h"
@@ -1440,6 +1442,86 @@ TRACE_EVENT(nfsd_cb_setup_err,
 		__entry->error)
 );
 
+TRACE_EVENT(nfsd_cb_seq_status,
+	TP_PROTO(
+		const struct rpc_task *task,
+		const struct nfsd4_callback *cb
+	),
+	TP_ARGS(task, cb),
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, seqno)
+		__field(u32, reserved)
+		__field(int, tk_status)
+		__field(int, seq_status)
+	),
+	TP_fast_assign(
+		const struct nfs4_client *clp = cb->cb_clp;
+		const struct nfsd4_session *session = clp->cl_cb_session;
+		const struct nfsd4_sessionid *sid =
+			(struct nfsd4_sessionid *)&session->se_sessionid;
+
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client ?
+				     task->tk_client->cl_clid : -1;
+		__entry->cl_boot = sid->clientid.cl_boot;
+		__entry->cl_id = sid->clientid.cl_id;
+		__entry->seqno = sid->sequence;
+		__entry->reserved = sid->reserved;
+		__entry->tk_status = task->tk_status;
+		__entry->seq_status = cb->cb_seq_status;
+	),
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		" sessionid=%08x:%08x:%08x:%08x tk_status=%d seq_status=%d\n",
+		__entry->task_id, __entry->client_id,
+		__entry->cl_boot, __entry->cl_id,
+		__entry->seqno, __entry->reserved,
+		__entry->tk_status, __entry->seq_status
+	)
+);
+
+TRACE_EVENT(nfsd_cb_free_slot,
+	TP_PROTO(
+		const struct rpc_task *task,
+		const struct nfsd4_callback *cb
+	),
+	TP_ARGS(task, cb),
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__field(u32, seqno)
+		__field(u32, reserved)
+		__field(u32, slot_seqno)
+	),
+	TP_fast_assign(
+		const struct nfs4_client *clp = cb->cb_clp;
+		const struct nfsd4_session *session = clp->cl_cb_session;
+		const struct nfsd4_sessionid *sid =
+			(struct nfsd4_sessionid *)&session->se_sessionid;
+
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client ?
+				     task->tk_client->cl_clid : -1;
+		__entry->cl_boot = sid->clientid.cl_boot;
+		__entry->cl_id = sid->clientid.cl_id;
+		__entry->seqno = sid->sequence;
+		__entry->reserved = sid->reserved;
+		__entry->slot_seqno = session->se_cb_seq_nr;
+	),
+	TP_printk(SUNRPC_TRACE_TASK_SPECIFIER
+		" sessionid=%08x:%08x:%08x:%08x new slot seqno=%u\n",
+		__entry->task_id, __entry->client_id,
+		__entry->cl_boot, __entry->cl_id,
+		__entry->seqno, __entry->reserved,
+		__entry->slot_seqno
+	)
+);
+
 TRACE_EVENT_CONDITION(nfsd_cb_recall,
 	TP_PROTO(
 		const struct nfs4_stid *stid



