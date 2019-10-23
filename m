Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A833DE1D97
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2019 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406297AbfJWOCB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 23 Oct 2019 10:02:01 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42187 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406291AbfJWOCA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 23 Oct 2019 10:02:00 -0400
Received: by mail-io1-f68.google.com with SMTP id i26so15723839iog.9;
        Wed, 23 Oct 2019 07:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=W7UsRbq7aje9TPWgB472YV41+uwKYUwUlhGW9rS1hMo=;
        b=ZSvcnLK/oRmbSwEc9rVHojYYa1uO689j9xvXKr/W9YqHfZqNniKOGiC8l/tcgBvzNQ
         pncHKEtCpMe7DcZDfoi+13S1x+rHZbeSA7lb0WMKfjGTraU6tznC2N4bsSj5rKEkgjmY
         /3Ras3iITwfOLxpcJ7qgQnp8n5brC462ucuDrEOL/pLcfs9LLpKm0zjlbYfo5igVDmDa
         LkzsbujeqiMM1I5FMEDLZ1vQWN0wpMVhmyWCjzp0LePrOvEC+K19WMJkLlsm3LmQErdP
         jzNXLsmc4Y3LS28E/kkGTYvtTRWRvjWBQvpNd/l+GEQC1YrbFXx1Zkaf0vcJDMcufP6E
         NBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=W7UsRbq7aje9TPWgB472YV41+uwKYUwUlhGW9rS1hMo=;
        b=b0Ni6Ap8ZeR9vvQNdzKh8tTJPH/GxMXDljS27v9KEpgUIF4ImB8uB9qEw+gwthv5BO
         Tkjy5B98xbTTUOspLtd9yHbwN50paHDtsIOtLw5cyJxaicMKnMi4iIYBQYaUlNDT+IHW
         znfWFSrhgEd+7cMQdX47UUnPxPB+uuCzgAMTscTXF3Lp5j+br1q58WHub3omTPjUMMy4
         z5U0nxaFWlwhIo6gOg1lC+KwZ+rWlpa2DIO8/kBqu3zXY0swAYSXdEZQ+i9Qnef9yC4F
         j08fYYTxuwAfAyVQaV0O1uU321+hjeowfMaUUk1i/qIpZr3fxH9WPp1KdftitUTP6P5F
         vgEQ==
X-Gm-Message-State: APjAAAVifICe62xCDnANz9zgjEeaWUDC1v3qm0AJIjZnnipKfqhvFtdU
        hpqTLSETWhdyqqS9NnonolLvLYTc
X-Google-Smtp-Source: APXvYqw6Bay9O/S04iZN02xTzrWNjVdaN49qPzDtaGW3M7P0St7U0n43BoDoljL+HhQkwbdy4MZvpg==
X-Received: by 2002:a5e:de43:: with SMTP id e3mr3380684ioq.23.1571839319497;
        Wed, 23 Oct 2019 07:01:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d14sm7963750ilr.76.2019.10.23.07.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Oct 2019 07:01:58 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x9NE1wsR012545;
        Wed, 23 Oct 2019 14:01:58 GMT
Subject: [PATCH v1 2/5] xprtrdma: Report the computed connect delay
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 23 Oct 2019 10:01:58 -0400
Message-ID: <20191023140157.3992.30932.stgit@manet.1015granger.net>
In-Reply-To: <20191023135907.3992.69010.stgit@manet.1015granger.net>
References: <20191023135907.3992.69010.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

For debugging, the op_connect trace point should report the computed
connect delay. We can then ensure that the delay is computed at the
proper times, for example.

As a further clean-up, remove a few low-value "heartbeat" trace
points in the connect path.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |   77 ++++++++++++++++++++++++++++-----------
 net/sunrpc/xprtrdma/transport.c |    3 +-
 net/sunrpc/xprtrdma/verbs.c     |   13 ++-----
 3 files changed, 60 insertions(+), 33 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 336a65d..201623c 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -85,6 +85,44 @@
 				),					\
 				TP_ARGS(r_xprt))
 
+DECLARE_EVENT_CLASS(xprtrdma_connect_class,
+	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
+		int rc
+	),
+
+	TP_ARGS(r_xprt, rc),
+
+	TP_STRUCT__entry(
+		__field(const void *, r_xprt)
+		__field(int, rc)
+		__field(int, connect_status)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
+	),
+
+	TP_fast_assign(
+		__entry->r_xprt = r_xprt;
+		__entry->rc = rc;
+		__entry->connect_status = r_xprt->rx_ep.rep_connected;
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
+	),
+
+	TP_printk("peer=[%s]:%s r_xprt=%p: rc=%d connect status=%d",
+		__get_str(addr), __get_str(port), __entry->r_xprt,
+		__entry->rc, __entry->connect_status
+	)
+);
+
+#define DEFINE_CONN_EVENT(name)						\
+		DEFINE_EVENT(xprtrdma_connect_class, xprtrdma_##name,	\
+				TP_PROTO(				\
+					const struct rpcrdma_xprt *r_xprt, \
+					int rc				\
+				),					\
+				TP_ARGS(r_xprt, rc))
+
 DECLARE_EVENT_CLASS(xprtrdma_rdch_event,
 	TP_PROTO(
 		const struct rpc_task *task,
@@ -333,47 +371,44 @@
 	)
 );
 
-TRACE_EVENT(xprtrdma_disconnect,
+DEFINE_CONN_EVENT(connect);
+DEFINE_CONN_EVENT(disconnect);
+
+DEFINE_RXPRT_EVENT(xprtrdma_create);
+DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
+DEFINE_RXPRT_EVENT(xprtrdma_remove);
+DEFINE_RXPRT_EVENT(xprtrdma_reinsert);
+DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
+DEFINE_RXPRT_EVENT(xprtrdma_op_close);
+
+TRACE_EVENT(xprtrdma_op_connect,
 	TP_PROTO(
 		const struct rpcrdma_xprt *r_xprt,
-		int status
+		unsigned long delay
 	),
 
-	TP_ARGS(r_xprt, status),
+	TP_ARGS(r_xprt, delay),
 
 	TP_STRUCT__entry(
 		__field(const void *, r_xprt)
-		__field(int, status)
-		__field(int, connected)
+		__field(unsigned long, delay)
 		__string(addr, rpcrdma_addrstr(r_xprt))
 		__string(port, rpcrdma_portstr(r_xprt))
 	),
 
 	TP_fast_assign(
 		__entry->r_xprt = r_xprt;
-		__entry->status = status;
-		__entry->connected = r_xprt->rx_ep.rep_connected;
+		__entry->delay = delay;
 		__assign_str(addr, rpcrdma_addrstr(r_xprt));
 		__assign_str(port, rpcrdma_portstr(r_xprt));
 	),
 
-	TP_printk("peer=[%s]:%s r_xprt=%p: status=%d %sconnected",
-		__get_str(addr), __get_str(port),
-		__entry->r_xprt, __entry->status,
-		__entry->connected == 1 ? "still " : "dis"
+	TP_printk("peer=[%s]:%s r_xprt=%p delay=%lu",
+		__get_str(addr), __get_str(port), __entry->r_xprt,
+		__entry->delay
 	)
 );
 
-DEFINE_RXPRT_EVENT(xprtrdma_conn_start);
-DEFINE_RXPRT_EVENT(xprtrdma_conn_tout);
-DEFINE_RXPRT_EVENT(xprtrdma_create);
-DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
-DEFINE_RXPRT_EVENT(xprtrdma_remove);
-DEFINE_RXPRT_EVENT(xprtrdma_reinsert);
-DEFINE_RXPRT_EVENT(xprtrdma_reconnect);
-DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
-DEFINE_RXPRT_EVENT(xprtrdma_op_close);
-DEFINE_RXPRT_EVENT(xprtrdma_op_connect);
 
 TRACE_EVENT(xprtrdma_op_set_cto,
 	TP_PROTO(
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 361e591..ce263e6 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -527,13 +527,12 @@ static void xprt_rdma_set_connect_timeout(struct rpc_xprt *xprt,
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 	unsigned long delay;
 
-	trace_xprtrdma_op_connect(r_xprt);
-
 	delay = 0;
 	if (r_xprt->rx_ep.rep_connected != 0) {
 		delay = xprt_reconnect_delay(xprt);
 		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
+	trace_xprtrdma_op_connect(r_xprt, delay);
 	queue_delayed_work(xprtiod_workqueue, &r_xprt->rx_connect_worker,
 			   delay);
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index a514e2c..92bdf05 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -297,8 +297,6 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	struct rdma_cm_id *id;
 	int rc;
 
-	trace_xprtrdma_conn_start(xprt);
-
 	init_completion(&ia->ri_done);
 	init_completion(&ia->ri_remove_done);
 
@@ -314,10 +312,8 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out;
 	rc = wait_for_completion_interruptible_timeout(&ia->ri_done, wtimeout);
-	if (rc < 0) {
-		trace_xprtrdma_conn_tout(xprt);
+	if (rc < 0)
 		goto out;
-	}
 
 	rc = ia->ri_async_rc;
 	if (rc)
@@ -328,10 +324,8 @@ static void rpcrdma_xprt_drain(struct rpcrdma_xprt *r_xprt)
 	if (rc)
 		goto out;
 	rc = wait_for_completion_interruptible_timeout(&ia->ri_done, wtimeout);
-	if (rc < 0) {
-		trace_xprtrdma_conn_tout(xprt);
+	if (rc < 0)
 		goto out;
-	}
 	rc = ia->ri_async_rc;
 	if (rc)
 		goto out;
@@ -644,8 +638,6 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 	struct rdma_cm_id *id, *old;
 	int err, rc;
 
-	trace_xprtrdma_reconnect(r_xprt);
-
 	rpcrdma_ep_disconnect(&r_xprt->rx_ep, ia);
 
 	rc = -EHOSTUNREACH;
@@ -744,6 +736,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt,
 		ep->rep_connected = rc;
 
 out_noupdate:
+	trace_xprtrdma_connect(r_xprt, rc);
 	return rc;
 }
 

