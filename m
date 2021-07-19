Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52BE3CD72B
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhGSOLh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 10:11:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241054AbhGSOI2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572296113B;
        Mon, 19 Jul 2021 14:48:35 +0000 (UTC)
Subject: [PATCH v2 6/6] SUNRPC: Record timeout value in xprt_retransmit
 tracepoint
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 19 Jul 2021 10:48:34 -0400
Message-ID: <162670611464.468132.12153190117646878882.stgit@manet.1015granger.net>
In-Reply-To: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
References: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The client can alter the timeout value after each retransmit. Record
the updated timeout value in the trace log.

Suggested-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 59ad1718496b..18d552a17c19 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1061,6 +1061,7 @@ TRACE_EVENT(xprt_retransmit,
 		__field(u32, xid)
 		__field(int, ntrans)
 		__field(int, version)
+		__field(unsigned long, timeout)
 		__string(progname,
 			 rqst->rq_task->tk_client->cl_program->name)
 		__string(procname, rpc_proc_name(rqst->rq_task))
@@ -1074,6 +1075,7 @@ TRACE_EVENT(xprt_retransmit,
 			task->tk_client->cl_clid : -1;
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->ntrans = rqst->rq_ntrans;
+		__entry->timeout = task->tk_timeout;
 		__assign_str(progname,
 			     task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
@@ -1081,10 +1083,10 @@ TRACE_EVENT(xprt_retransmit,
 	),
 
 	TP_printk(
-		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d",
+		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d timeout=%lu",
 		__entry->task_id, __entry->client_id, __entry->xid,
 		__get_str(progname), __entry->version, __get_str(procname),
-		__entry->ntrans
+		__entry->ntrans, __entry->timeout
 	)
 );
 


