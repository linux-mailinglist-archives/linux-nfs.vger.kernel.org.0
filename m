Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEF4219138
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jul 2020 22:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgGHUK1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 8 Jul 2020 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgGHUK1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 8 Jul 2020 16:10:27 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B339BC061A0B
        for <linux-nfs@vger.kernel.org>; Wed,  8 Jul 2020 13:10:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 145so40358616qke.9
        for <linux-nfs@vger.kernel.org>; Wed, 08 Jul 2020 13:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aefQUW0KUT090aweBC5KVGAREgZu/wiKuoxG7ug/vcQ=;
        b=Syb9Q2i30jakudiUGXqlBQnqVuqLjRuzFe/YCREHSEGyQa05Ieb0/j9FfpOR2ZwLHH
         2nI43ii4WwMX+TmA2W3YGEhRdTJQQk0ZGXAr1PFzqbz42DdbYycMD+Zyoq3eEplS4VXJ
         U1nwPBbZO1Hw6PRk9PxdLf+vDDzwD0lvpc6XJWJHquB7zi7Zg4BzWpitWsDVYwjoIbh2
         suvkxaiqemWHrOGLBpQR3OKRIwB3RHD9nQt89B+Hg/HAxDda4/5uYAVfZ9hqoK58HyaZ
         eL9oRt9OMAzDMRLz31MD0LqrRNyLOi7o1fAh7yMKpVgnu3ySnnLx5hsNrJobrWp6A20N
         54Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=aefQUW0KUT090aweBC5KVGAREgZu/wiKuoxG7ug/vcQ=;
        b=OjUE5GQl8gjF7a7IY+xCcA0jRs3RHReQ8coDY2Agiqa6YmDAZ4AIZQoVFqYvrE2VsN
         nDi4XvyM+GLb43w/b3qkqOytQYwltB9zYq7RcmC/LPasOFRyj2TtEtBRMTMri56O/YNb
         BKyXB67IZ0vQCKmLk1DX5nQTKrvxMWy/IBZ7w1n927Q0qlSMl+XiuFkBa3K5RahoFLcz
         BZ1egUrdmaBVpOvUPxSSZ5W4B4LJHGmEvXCB5K0oiTuQCZJPinpo3wdLSxCd+p/sXcxi
         9cjDLyAsSzwsOkexXT/8XacpICX49pLveJn+3ASx0X/bS4wtG1UV+p5/5u9O0T7J+YIs
         89cg==
X-Gm-Message-State: AOAM532ONmNWyTYIKppAcJld5iNpjfP+hCzw+e415gAPhK1rSli+4wYQ
        HoBboxSnelx9y84GsXAU0AYuPneJ
X-Google-Smtp-Source: ABdhPJw/Dgm93QfZTHB1wLTGcrdTSPO0vrokd+Tr3Z+hvXRTS5zdf2s6RL/pMbSI3dq+EvoyFgWk2g==
X-Received: by 2002:a37:796:: with SMTP id 144mr59783630qkh.84.1594239025740;
        Wed, 08 Jul 2020 13:10:25 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p25sm863712qtk.67.2020.07.08.13.10.25
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 13:10:25 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 068KAOfJ006121
        for <linux-nfs@vger.kernel.org>; Wed, 8 Jul 2020 20:10:24 GMT
Subject: [PATCH v1 16/22] SUNRPC: Hoist trace_xprtrdma_op_setport into
 generic code
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Wed, 08 Jul 2020 16:10:24 -0400
Message-ID: <20200708201024.22129.40185.stgit@manet.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |    1 -
 include/trace/events/sunrpc.h   |   29 +++++++++++++++++++++++++++++
 net/sunrpc/rpcb_clnt.c          |   29 ++++++++++++++---------------
 net/sunrpc/xprtrdma/transport.c |    3 ---
 4 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 4a93c166512b..137cec2d7a47 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -382,7 +382,6 @@ DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
 
 DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
-DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
 
 TRACE_EVENT(xprtrdma_op_connect,
 	TP_PROTO(
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index e6df6740a242..946bb73afc95 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1305,6 +1305,35 @@ TRACE_EVENT(rpcb_getport,
 	)
 );
 
+TRACE_EVENT(rpcb_setport,
+	TP_PROTO(
+		const struct rpc_task *task,
+		int status,
+		unsigned short port
+	),
+
+	TP_ARGS(task, status, port),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, task_id)
+		__field(unsigned int, client_id)
+		__field(int, status)
+		__field(unsigned short, port)
+	),
+
+	TP_fast_assign(
+		__entry->task_id = task->tk_pid;
+		__entry->client_id = task->tk_client->cl_clid;
+		__entry->status = status;
+		__entry->port = port;
+	),
+
+	TP_printk("task:%u@%u status=%d port=%u",
+		__entry->task_id, __entry->client_id,
+		__entry->status, __entry->port
+	)
+);
+
 DECLARE_EVENT_CLASS(svc_xdr_buf_class,
 	TP_PROTO(
 		const struct svc_rqst *rqst,
diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index d5c00c0da4f8..596c83ba647f 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -801,34 +801,33 @@ static void rpcb_getport_done(struct rpc_task *child, void *data)
 {
 	struct rpcbind_args *map = data;
 	struct rpc_xprt *xprt = map->r_xprt;
-	int status = child->tk_status;
+
+	map->r_status = child->tk_status;
 
 	/* Garbage reply: retry with a lesser rpcbind version */
-	if (status == -EIO)
-		status = -EPROTONOSUPPORT;
+	if (map->r_status == -EIO)
+		map->r_status = -EPROTONOSUPPORT;
 
 	/* rpcbind server doesn't support this rpcbind protocol version */
-	if (status == -EPROTONOSUPPORT)
+	if (map->r_status == -EPROTONOSUPPORT)
 		xprt->bind_index++;
 
-	if (status < 0) {
+	if (map->r_status < 0) {
 		/* rpcbind server not available on remote host? */
-		xprt->ops->set_port(xprt, 0);
+		map->r_port = 0;
+
 	} else if (map->r_port == 0) {
 		/* Requested RPC service wasn't registered on remote host */
-		xprt->ops->set_port(xprt, 0);
-		status = -EACCES;
+		map->r_status = -EACCES;
 	} else {
 		/* Succeeded */
-		xprt->ops->set_port(xprt, map->r_port);
-		xprt_set_bound(xprt);
-		status = 0;
+		map->r_status = 0;
 	}
 
-	dprintk("RPC: %5u rpcb_getport_done(status %d, port %u)\n",
-			child->tk_pid, status, map->r_port);
-
-	map->r_status = status;
+	trace_rpcb_setport(child, map->r_status, map->r_port);
+	xprt->ops->set_port(xprt, map->r_port);
+	if (map->r_port)
+		xprt_set_bound(xprt);
 }
 
 /*
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 819a922830da..8915e42240d3 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -413,9 +413,6 @@ xprt_rdma_set_port(struct rpc_xprt *xprt, u16 port)
 	kfree(xprt->address_strings[RPC_DISPLAY_HEX_PORT]);
 	snprintf(buf, sizeof(buf), "%4hx", port);
 	xprt->address_strings[RPC_DISPLAY_HEX_PORT] = kstrdup(buf, GFP_KERNEL);
-
-	trace_xprtrdma_op_setport(container_of(xprt, struct rpcrdma_xprt,
-					       rx_xprt));
 }
 
 /**

