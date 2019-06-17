Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7426948747
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfFQPcr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:32:47 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39521 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQPcq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:32:46 -0400
Received: by mail-io1-f67.google.com with SMTP id r185so16161787iod.6;
        Mon, 17 Jun 2019 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Si3jDmFx5xypB5GvR2QVYXFanK45B7dzGeDn5cZG4jI=;
        b=dVtZDjvFhCr20/CxijnXMRg0rQ4+HkUaW4tgaKJ0kX7r+87aWbvo+vymzqK97nBs8c
         glyxZMAhbujcAXlB7PzZuXQtLPjGAVeskmwZKldQSDCtONhAsk80t7CRtK4q1+iRe5E3
         QORAUyC/MlsWZn2hFRmBXA0c6kve0gh05obsDJdVvewum+NYRK9hGKoNeJ95hDtV1R3M
         VBXGtCaAU1vZWefIBT2XTeN+TmYBhxKKyGd+qBtLE63xLNdrd72c26GG09f5sSp+0aFz
         lZCdpXzVKjNmLZN0sDr3+qWnYy1K6+U5nBexIUGlUpc3nG4srXUJqaZKempe9epiOQZI
         o/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Si3jDmFx5xypB5GvR2QVYXFanK45B7dzGeDn5cZG4jI=;
        b=s8eZacZAcJ59q6fHT1Jso1/4MXctdFYsg5fNGRBf9Zs4kDRK0I1iSXlcsAIBzoKIHs
         nNL+KI96pz+ZUKEblPBtyWiqGEGA6LWcLjputtoW9zGxx2EbNoQ5EDUWLJoMDEy/nFaE
         1t7wFgtJg0X74nJ8zA0nHArWVE82Vg2EO2u5FSwh08d+j6vrdl7d5b9URKMjdwRpjFhZ
         CC5TsXpjHlWmOmIO53L9VG4ve0Fpkn7GmL+2n5PL1fdjXfzBgZcXDu/1WFPBedEYWFZa
         dGsKuVenI902BtuGN91QQzsRG6LfOlsvZmt84Z73TEWlKv3fx9tA7qwhumPqywJ/JTwI
         hyyw==
X-Gm-Message-State: APjAAAXL1hbDcrj4fb0nlBRTjhRLJRy+DzoqylfjAgCapU9XJbJK6zol
        EuYYnE6iCgEMDT613FuX5vmZq7+b
X-Google-Smtp-Source: APXvYqyKNjDKlknSW/BsNL84suim8C1cFWaO/Ll180nREKUsgmGFcBDGQhCyq/DrDmt8X3FV34bEoQ==
X-Received: by 2002:a02:7715:: with SMTP id g21mr36887986jac.24.1560785565504;
        Mon, 17 Jun 2019 08:32:45 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a2sm9028830iod.57.2019.06.17.08.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:32:45 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFWik2031227;
        Mon, 17 Jun 2019 15:32:44 GMT
Subject: [PATCH v3 14/19] xprtrdma: Modernize ops->connect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:32:44 -0400
Message-ID: <20190617153244.12090.49342.stgit@manet.1015granger.net>
In-Reply-To: <20190617152657.12090.11389.stgit@manet.1015granger.net>
References: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Adapt and apply changes that were made to the TCP socket connect
code. See the following commits for details on the purpose of
these changes:

Commit 7196dbb02ea0 ("SUNRPC: Allow changing of the TCP timeout parameters on the fly")
Commit 3851f1cdb2b8 ("SUNRPC: Limit the reconnect backoff timer to the max RPC message timeout")
Commit 02910177aede ("SUNRPC: Fix reconnection timeouts")

Some common transport code is moved to xprt.c to satisfy the code
duplication police.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprt.h     |    3 ++
 include/trace/events/rpcrdma.h  |   31 ++++++++++++++++++
 net/sunrpc/sched.c              |    1 +
 net/sunrpc/xprt.c               |   32 +++++++++++++++++++
 net/sunrpc/xprtrdma/transport.c |   66 ++++++++++++++++++++++++++++++---------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 net/sunrpc/xprtsock.c           |   23 +-------------
 7 files changed, 121 insertions(+), 36 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index a6d9fce..cc78fd3 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -334,6 +334,9 @@ struct xprt_class {
  */
 struct rpc_xprt		*xprt_create_transport(struct xprt_create *args);
 void			xprt_connect(struct rpc_task *task);
+unsigned long		xprt_reconnect_delay(const struct rpc_xprt *xprt);
+void			xprt_reconnect_backoff(struct rpc_xprt *xprt,
+					       unsigned long init_to);
 void			xprt_reserve(struct rpc_task *task);
 void			xprt_retry_reserve(struct rpc_task *task);
 int			xprt_reserve_xprt(struct rpc_xprt *xprt, struct rpc_task *task);
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 98023d9..f6a4eaa 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -375,6 +375,37 @@
 DEFINE_RXPRT_EVENT(xprtrdma_op_close);
 DEFINE_RXPRT_EVENT(xprtrdma_op_connect);
 
+TRACE_EVENT(xprtrdma_op_set_cto,
+	TP_PROTO(
+		const struct rpcrdma_xprt *r_xprt,
+		unsigned long connect,
+		unsigned long reconnect
+	),
+
+	TP_ARGS(r_xprt, connect, reconnect),
+
+	TP_STRUCT__entry(
+		__field(const void *, r_xprt)
+		__field(unsigned long, connect)
+		__field(unsigned long, reconnect)
+		__string(addr, rpcrdma_addrstr(r_xprt))
+		__string(port, rpcrdma_portstr(r_xprt))
+	),
+
+	TP_fast_assign(
+		__entry->r_xprt = r_xprt;
+		__entry->connect = connect;
+		__entry->reconnect = reconnect;
+		__assign_str(addr, rpcrdma_addrstr(r_xprt));
+		__assign_str(port, rpcrdma_portstr(r_xprt));
+	),
+
+	TP_printk("peer=[%s]:%s r_xprt=%p: connect=%lu reconnect=%lu",
+		__get_str(addr), __get_str(port), __entry->r_xprt,
+		__entry->connect / HZ, __entry->reconnect / HZ
+	)
+);
+
 TRACE_EVENT(xprtrdma_qp_event,
 	TP_PROTO(
 		const struct rpcrdma_xprt *r_xprt,
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index bb04ae5..5ad5dea 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -58,6 +58,7 @@
  */
 struct workqueue_struct *rpciod_workqueue __read_mostly;
 struct workqueue_struct *xprtiod_workqueue __read_mostly;
+EXPORT_SYMBOL_GPL(xprtiod_workqueue);
 
 unsigned long
 rpc_task_timeout(const struct rpc_task *task)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index ad21880..b1f54b7 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -850,6 +850,38 @@ void xprt_connect(struct rpc_task *task)
 	xprt_release_write(xprt, task);
 }
 
+/**
+ * xprt_reconnect_delay - compute the wait before scheduling a connect
+ * @xprt: transport instance
+ *
+ */
+unsigned long xprt_reconnect_delay(const struct rpc_xprt *xprt)
+{
+	unsigned long start, now = jiffies;
+
+	start = xprt->stat.connect_start + xprt->reestablish_timeout;
+	if (time_after(start, now))
+		return start - now;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xprt_reconnect_delay);
+
+/**
+ * xprt_reconnect_backoff - compute the new re-establish timeout
+ * @xprt: transport instance
+ * @init_to: initial reestablish timeout
+ *
+ */
+void xprt_reconnect_backoff(struct rpc_xprt *xprt, unsigned long init_to)
+{
+	xprt->reestablish_timeout <<= 1;
+	if (xprt->reestablish_timeout > xprt->max_reconnect_timeout)
+		xprt->reestablish_timeout = xprt->max_reconnect_timeout;
+	if (xprt->reestablish_timeout < init_to)
+		xprt->reestablish_timeout = init_to;
+}
+EXPORT_SYMBOL_GPL(xprt_reconnect_backoff);
+
 enum xprt_xid_rb_cmp {
 	XID_RB_EQUAL,
 	XID_RB_LEFT,
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 3688e078..4993aa4 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -298,6 +298,7 @@
 	module_put(THIS_MODULE);
 }
 
+/* 60 second timeout, no retries */
 static const struct rpc_timeout xprt_rdma_default_timeout = {
 	.to_initval = 60 * HZ,
 	.to_maxval = 60 * HZ,
@@ -323,8 +324,9 @@
 	if (!xprt)
 		return ERR_PTR(-ENOMEM);
 
-	/* 60 second timeout, no retries */
 	xprt->timeout = &xprt_rdma_default_timeout;
+	xprt->connect_timeout = xprt->timeout->to_initval;
+	xprt->max_reconnect_timeout = xprt->timeout->to_maxval;
 	xprt->bind_timeout = RPCRDMA_BIND_TO;
 	xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
 	xprt->idle_timeout = RPCRDMA_IDLE_DISC_TO;
@@ -487,31 +489,64 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 }
 
 /**
- * xprt_rdma_connect - try to establish a transport connection
+ * xprt_rdma_set_connect_timeout - set timeouts for establishing a connection
+ * @xprt: controlling transport instance
+ * @connect_timeout: reconnect timeout after client disconnects
+ * @reconnect_timeout: reconnect timeout after server disconnects
+ *
+ */
+static void xprt_rdma_tcp_set_connect_timeout(struct rpc_xprt *xprt,
+					      unsigned long connect_timeout,
+					      unsigned long reconnect_timeout)
+{
+	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+
+	trace_xprtrdma_op_set_cto(r_xprt, connect_timeout, reconnect_timeout);
+
+	spin_lock(&xprt->transport_lock);
+
+	if (connect_timeout < xprt->connect_timeout) {
+		struct rpc_timeout to;
+		unsigned long initval;
+
+		to = *xprt->timeout;
+		initval = connect_timeout;
+		if (initval < RPCRDMA_INIT_REEST_TO << 1)
+			initval = RPCRDMA_INIT_REEST_TO << 1;
+		to.to_initval = initval;
+		to.to_maxval = initval;
+		r_xprt->rx_timeout = to;
+		xprt->timeout = &r_xprt->rx_timeout;
+		xprt->connect_timeout = connect_timeout;
+	}
+
+	if (reconnect_timeout < xprt->max_reconnect_timeout)
+		xprt->max_reconnect_timeout = reconnect_timeout;
+
+	spin_unlock(&xprt->transport_lock);
+}
+
+/**
+ * xprt_rdma_connect - schedule an attempt to reconnect
  * @xprt: transport state
- * @task: RPC scheduler context
+ * @task: RPC scheduler context (unused)
  *
  */
 static void
 xprt_rdma_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
+	unsigned long delay;
 
 	trace_xprtrdma_op_connect(r_xprt);
+
+	delay = 0;
 	if (r_xprt->rx_ep.rep_connected != 0) {
-		/* Reconnect */
-		schedule_delayed_work(&r_xprt->rx_connect_worker,
-				      xprt->reestablish_timeout);
-		xprt->reestablish_timeout <<= 1;
-		if (xprt->reestablish_timeout > RPCRDMA_MAX_REEST_TO)
-			xprt->reestablish_timeout = RPCRDMA_MAX_REEST_TO;
-		else if (xprt->reestablish_timeout < RPCRDMA_INIT_REEST_TO)
-			xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
-	} else {
-		schedule_delayed_work(&r_xprt->rx_connect_worker, 0);
-		if (!RPC_IS_ASYNC(task))
-			flush_delayed_work(&r_xprt->rx_connect_worker);
+		delay = xprt_reconnect_delay(xprt);
+		xprt_reconnect_backoff(xprt, RPCRDMA_INIT_REEST_TO);
 	}
+	queue_delayed_work(xprtiod_workqueue, &r_xprt->rx_connect_worker,
+			   delay);
 }
 
 /**
@@ -769,6 +804,7 @@ void xprt_rdma_print_stats(struct rpc_xprt *xprt, struct seq_file *seq)
 	.send_request		= xprt_rdma_send_request,
 	.close			= xprt_rdma_close,
 	.destroy		= xprt_rdma_destroy,
+	.set_connect_timeout	= xprt_rdma_tcp_set_connect_timeout,
 	.print_stats		= xprt_rdma_print_stats,
 	.enable_swap		= xprt_rdma_enable_swap,
 	.disable_swap		= xprt_rdma_disable_swap,
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 117e328..8378f45 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -432,6 +432,7 @@ struct rpcrdma_xprt {
 	struct rpcrdma_ep	rx_ep;
 	struct rpcrdma_buffer	rx_buf;
 	struct delayed_work	rx_connect_worker;
+	struct rpc_timeout	rx_timeout;
 	struct rpcrdma_stats	rx_stats;
 };
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c69951e..b154600 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2402,25 +2402,6 @@ static void xs_tcp_setup_socket(struct work_struct *work)
 	xprt_wake_pending_tasks(xprt, status);
 }
 
-static unsigned long xs_reconnect_delay(const struct rpc_xprt *xprt)
-{
-	unsigned long start, now = jiffies;
-
-	start = xprt->stat.connect_start + xprt->reestablish_timeout;
-	if (time_after(start, now))
-		return start - now;
-	return 0;
-}
-
-static void xs_reconnect_backoff(struct rpc_xprt *xprt)
-{
-	xprt->reestablish_timeout <<= 1;
-	if (xprt->reestablish_timeout > xprt->max_reconnect_timeout)
-		xprt->reestablish_timeout = xprt->max_reconnect_timeout;
-	if (xprt->reestablish_timeout < XS_TCP_INIT_REEST_TO)
-		xprt->reestablish_timeout = XS_TCP_INIT_REEST_TO;
-}
-
 /**
  * xs_connect - connect a socket to a remote endpoint
  * @xprt: pointer to transport structure
@@ -2450,8 +2431,8 @@ static void xs_connect(struct rpc_xprt *xprt, struct rpc_task *task)
 		/* Start by resetting any existing state */
 		xs_reset_transport(transport);
 
-		delay = xs_reconnect_delay(xprt);
-		xs_reconnect_backoff(xprt);
+		delay = xprt_reconnect_delay(xprt);
+		xprt_reconnect_backoff(xprt, XS_TCP_INIT_REEST_TO);
 
 	} else
 		dprintk("RPC:       xs_connect scheduled xprt %p\n", xprt);

