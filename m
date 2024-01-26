Return-Path: <linux-nfs+bounces-1495-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A5283E0D0
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 18:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01E4B1C21205
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jan 2024 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2C208DA;
	Fri, 26 Jan 2024 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaaRCeiL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324EB208A7
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706291150; cv=none; b=PzzNQqrY6Ov3V55cJzRF+yQviwBWx6PIucvvp4bAJ7ctpjoKcSAV3lJaRkGQwKncnw8jAI2pN/UPJFomv3jwxuag2J0CSVmcO8E9/TzUNVEdBrsoRheW1+h77ygYv8Jg0gnADdeWdZysqp1FmaY8LH8HPrOCz0H6tAMGQIz4aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706291150; c=relaxed/simple;
	bh=p6AHnFHKX18WddjVdsVpNt9qXCxw0HaBX+zRFxXcUZU=;
	h=Subject:From:To:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCjrjPjv924iuzAOpovtaHcRWsPJmgHCINFA3ApSpjoWJCX7p82wPSLL2w+M/P6lexLBM72Yk/wBhZGU1gcENSUKHVA4cZWJnBrsRThYPTWCKZFU3HMRfcl6QSiZnYL7meXB4E5TaLNyLeEKV4cn0iDIrpORXLgFhymXFmEb1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaaRCeiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF29C43143
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jan 2024 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706291149;
	bh=p6AHnFHKX18WddjVdsVpNt9qXCxw0HaBX+zRFxXcUZU=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=FaaRCeiLkK0fHj8Re92ribO/2HSgWzDjIRg1esa94XyH2Zjbc57a3UPQEzEA+DAAh
	 w43XD3ait6tq39kw7sbZaXKpDBzZERTSb7JotPkiUNRKLJ+bXw+STrw4iZtUiBZZ2K
	 XtL6CvaL5UdmaPvzLhtIOlSa1LB43K/kkN/JspnPgzem/cCEnCjeLWaJIgeSdzFJTo
	 KufcZmYdHEUTOOYRZgF8oJ2zMNgwBxHaBgsKE+yyDk8EICrhQTVhaByYmn7q2NHJ7b
	 26hxP6/9yRahCSCNT70Is1tIaIt4jmvjU/rRz/CbBTXbjBANm1db8rGf49p8Aiakk/
	 7hsHHEBRZD1rA==
Subject: [PATCH 2 06/14] NFSD: Replace dprintks in nfsd4_cb_sequence_done()
From: Chuck Lever <cel@kernel.org>
To: linux-nfs@vger.kernel.org
Date: Fri, 26 Jan 2024 12:45:48 -0500
Message-ID: 
 <170629114861.20612.12626133349616644679.stgit@manet.1015granger.net>
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

Improve observability of backchannel session operation.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4callback.c |    9 ++---
 fs/nfsd/trace.h        |   82 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 3bff14241b3c..78d9939cf4b0 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1165,6 +1165,8 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	if (!cb->cb_holds_slot)
 		goto need_restart;
 
+	/* This is the operation status code for CB_SEQUENCE */
+	trace_nfsd_cb_seq_status(task, cb);
 	switch (cb->cb_seq_status) {
 	case 0:
 		/*
@@ -1210,13 +1212,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
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



