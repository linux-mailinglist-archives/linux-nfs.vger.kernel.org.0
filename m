Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6070E219137
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGHUKV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUKV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71405C061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b185so32258875qkg.1
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=4JpwSIHwoxA44k5nzKvCXZpqZ/9QkDmJ18xQ54luejk=;
        b=dfEyiqTYX0NDE4NYg4GZTGmJpYpHc3cI6ASR8kJ5rtN1L5SZc/hyz8Sbwb5an+p3Ox
         Qdmj/8T2z4bS0qjIcYLdKO6Xj+tYDnRxyx/lJVUrEnmVzSt8AeRhAWDoI22+aqqFWmaa
         OnsoJiJHL5WEmb0YQobRT5T4Cg2bPrUvivO2kcelieSidIGhlheqPhmEziFlPQAmwCdh
         k53TOOfNN0XOhKIdPzNVP6Si7p+HKu3ZUGIPtwpUpt5R5MDg5LZUWVAnDn5mSej6dXZz
         klXhumF6URmKLFLQoZzBEgRF/xTkkrmsp5K5CwGKmzE9ySEaTNVH8syhMgINXh3Bloeq
         QoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=4JpwSIHwoxA44k5nzKvCXZpqZ/9QkDmJ18xQ54luejk=;
        b=LudIqqQUvPMKCTg54MQk8H3LBwN/Tc8OUL5pzMaoncowFrnxIemBzg1bKl79nohSm4
         IVhgtMnJWtTQYfqGJhoyfpgkVOd/iDo3d7Lvomod0C3y9ikXLjWkeDFEdqZZ1ej4F7Gr
         cbWt4QClOl6NsZHkfpf6xJskKwIVB4nlnfCtMoKocgMcjOFYda/+9hhKKUx+eDEVrOG7
         q+867c6Fo50G5JnFfTGkaJ3mwztYGaOxeRkTf8Ysds6UYKymzIxWfQMF0HvBgGZbi5zF
         kYzrGjzhOw6gFZpIrtSS+4YKvznhAzketP9a6rf/XILoIx7W0jc+IRpFFrC7ftebEp9/
         jHYA==
X-Gm-Message-State: AOAM533EpqRt4CtpxtXLE5wNyRbhWR2v72uvNE/lvw7mjAhmbHihBUOA
        URcpgPaWhBieglSdoaPbF3oBoRT4
X-Google-Smtp-Source: ABdhPJzzCYy6LfsL5xWUi4/yD9PgdEFHfnQ0YoQq2+zlMj+G4Z4Q0pzErKS0Z7NC/f6gXLDKY+bk1A==
X-Received: by 2002:a05:620a:1649:: with SMTP id c9mr35824943qko.330.1594239020429;
        Wed, 08 Jul 2020 13:10:20 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x13sm829495qts.57.2020.07.08.13.10.19
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:20 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAJSV006118
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:19 GMT
Subject: [PATCH v1 15/22] SUNRPC: Remove rpcb_getport_async dprintk call
 sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:19 -0400
Message-ID: <20200708201019.22129.13610.stgit@manet.1015granger.net>
In-Reply-To: <20200708200121.22129.92375.stgit@manet.1015granger.net>
References: <20200708200121.22129.92375.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In many cases, tracepoints already report these errors. In others,
the dprintks were mainly useful when this code was less mature.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   35 +++++++++++++++++++++++++++++++++++
 net/sunrpc/rpcb_clnt.c        |   23 +++--------------------
 2 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 8bc5f966b22d..e6df6740a242 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1269,6 +1269,41 @@ TRACE_EVENT(xs_stream_read_request,
 			__entry->copied, __entry->reclen, __entry->offset)
 );
 
+TRACE_EVENT(rpcb_getport,
+	TP_PROTO(
+		const struct rpc_clnt *clnt,
+		const struct rpc_task *task,
+		unsigned int bind_version
+	),
+
+	TP_ARGS(clnt, task, bind_version),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(unsigned int, program)
+		__field(unsigned int, version)
+		__field(int, protocol)
+		__field(unsigned int, bind_version)
+		__string(servername, task->tk_xprt->servername)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = clnt->cl_clid;
+		__entry->program = clnt->cl_prog;
+		__entry->version = clnt->cl_vers;
+		__entry->protocol = task->tk_xprt->prot;
+		__entry->bind_version = bind_version;
+		__assign_str(servername, task->tk_xprt->servername);
+	),
+
+	TP_printk("task:%u@%u server=%s program=%u version=%u protocol=%d bind_version=%u",
+		__entry->task_id, __entry->client_id, __get_str(servername),
+		__entry->program, __entry->version, __entry->protocol,
+		__entry->bind_version
+	)
+);
 
 DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 	TP_PROTO(
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index c27123e6ba80..d5c00c0da4f8 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -31,6 +31,8 @@
 #include <linux/sunrpc/sched.h>
 #include <linux/sunrpc/xprtsock.h>
 
+#include <trace/events/sunrpc.h>
+
 #include "netns.h"
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
@@ -693,18 +695,12 @@ void rpcb_getport_async(struct rpc_task *task)
 	rcu_read_unlock();
 	xprt = xprt_get(task->tk_xprt);
 
-	dprintk("RPC: %5u %s(%s, %u, %u, %d)\n",
-		task->tk_pid, __func__,
-		xprt->servername, clnt->cl_prog, clnt->cl_vers, xprt->prot);
-
 	/* Put self on the wait queue to ensure we get notified if
 	 * some other task is already attempting to bind the port */
 	rpc_sleep_on_timeout(&xprt->binding, task,
 			NULL, jiffies + xprt->bind_timeout);
 
 	if (xprt_test_and_set_binding(xprt)) {
-		dprintk("RPC: %5u %s: waiting for another binder\n",
-			task->tk_pid, __func__);
 		xprt_put(xprt);
 		return;
 	}
@@ -712,8 +708,6 @@ void rpcb_getport_async(struct rpc_task *task)
 	/* Someone else may have bound if we slept */
 	if (xprt_bound(xprt)) {
 		status = 0;
-		dprintk("RPC: %5u %s: already bound\n",
-			task->tk_pid, __func__);
 		goto bailout_nofree;
 	}
 
@@ -732,20 +726,15 @@ void rpcb_getport_async(struct rpc_task *task)
 		break;
 	default:
 		status = -EAFNOSUPPORT;
-		dprintk("RPC: %5u %s: bad address family\n",
-				task->tk_pid, __func__);
 		goto bailout_nofree;
 	}
 	if (proc == NULL) {
 		xprt->bind_index = 0;
 		status = -EPFNOSUPPORT;
-		dprintk("RPC: %5u %s: no more getport versions available\n",
-			task->tk_pid, __func__);
 		goto bailout_nofree;
 	}
 
-	dprintk("RPC: %5u %s: trying rpcbind version %u\n",
-		task->tk_pid, __func__, bind_version);
+	trace_rpcb_getport(clnt, task, bind_version);
 
 	rpcb_clnt = rpcb_create(xprt->xprt_net,
 				clnt->cl_nodename,
@@ -754,16 +743,12 @@ void rpcb_getport_async(struct rpc_task *task)
 				clnt->cl_cred);
 	if (IS_ERR(rpcb_clnt)) {
 		status = PTR_ERR(rpcb_clnt);
-		dprintk("RPC: %5u %s: rpcb_create failed, error %ld\n",
-			task->tk_pid, __func__, PTR_ERR(rpcb_clnt));
 		goto bailout_nofree;
 	}
 
 	map = kzalloc(sizeof(struct rpcbind_args), GFP_NOFS);
 	if (!map) {
 		status = -ENOMEM;
-		dprintk("RPC: %5u %s: no memory available\n",
-			task->tk_pid, __func__);
 		goto bailout_release_client;
 	}
 	map->r_prog = clnt->cl_prog;
@@ -780,8 +765,6 @@ void rpcb_getport_async(struct rpc_task *task)
 		map->r_addr = rpc_sockaddr2uaddr(sap, GFP_NOFS);
 		if (!map->r_addr) {
 			status = -ENOMEM;
-			dprintk("RPC: %5u %s: no memory available\n",
-				task->tk_pid, __func__);
 			goto bailout_free_args;
 		}
 		map->r_owner = "";

