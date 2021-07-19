Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3FB3CD72A
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Jul 2021 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhGSOLg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 10:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241216AbhGSOI2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Jul 2021 10:08:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B85B6112D;
        Mon, 19 Jul 2021 14:48:29 +0000 (UTC)
Subject: [PATCH v2 5/6] SUNRPC: xprt_retransmit() displays the the NULL
 procedure incorrectly
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 19 Jul 2021 10:48:28 -0400
Message-ID: <162670610850.468132.2740198466674594098.stgit@manet.1015granger.net>
In-Reply-To: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
References: <162670594361.468132.16222376053830760696.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently:

  xprt_retransmit:      task:11@1 xid=0x55a7ffac nfsv4 (null) ntrans=2

should be:

  xprt_retransmit:      task:11@1 xid=0x55a7ffac nfsv4 NULL ntrans=2

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index b13130903a50..59ad1718496b 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1063,8 +1063,7 @@ TRACE_EVENT(xprt_retransmit,
 		__field(int, version)
 		__string(progname,
 			 rqst->rq_task->tk_client->cl_program->name)
-		__string(procedure,
-			 rqst->rq_task->tk_msg.rpc_proc->p_name)
+		__string(procname, rpc_proc_name(rqst->rq_task))
 	),
 
 	TP_fast_assign(
@@ -1078,14 +1077,15 @@ TRACE_EVENT(xprt_retransmit,
 		__assign_str(progname,
 			     task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
-		__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
+		__assign_str(procname, rpc_proc_name(task));
 	),
 
 	TP_printk(
 		"task:%u@%u xid=0x%08x %sv%d %s ntrans=%d",
 		__entry->task_id, __entry->client_id, __entry->xid,
-		__get_str(progname), __entry->version, __get_str(procedure),
-		__entry->ntrans)
+		__get_str(progname), __entry->version, __get_str(procname),
+		__entry->ntrans
+	)
 );
 
 TRACE_EVENT(xprt_ping,


