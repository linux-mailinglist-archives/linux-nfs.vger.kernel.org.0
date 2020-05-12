Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE62A1D0074
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgELVNh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731271AbgELVNg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:13:36 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2CC061A0C
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so14131926qkh.11
        for <linux-nfs@vger.kernel.org>; Tue, 12 May 2020 14:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=v0wimesOpmxd1KvdsoN97nhQKHFPqtuYm4Ygpvvnngw=;
        b=lsui1crzNKJ2bb65U7cPYRHLSUwFoxNsI/26pgICsyIK3erws6M/N7OFJNiBTT6qKW
         07cWCMiVS9FSmIJInUkjfHJk4iDZaL48xIq8KUgumDKZ1DsdK1kjCbNssUFTrV8LCy4o
         1zboaJ13gVs+Qw/UvpjccRQezMyItuETPTc1I1cUQO9eNV8I9gsjO/IQamwW95NEDpxl
         T+mE4HuY+95cSHw7CFlsBJyfM0/h/Ptu9tDXoLn3F7/5EBVfwV+Oo8hoIgVyNtV2hggQ
         0ZhgXHn9VmskzC2vL3oFW7SybZ3lmT0BFvpwfy9tWh87DiAIahIIejH2WLWx7UhCdLgY
         U7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=v0wimesOpmxd1KvdsoN97nhQKHFPqtuYm4Ygpvvnngw=;
        b=l5XPtjF3PoeJtVdZH/Tx2JqsYPAzKlZzwJNz6yuIg6E/9jnNLzKPxcLecE8blETT1H
         8TQQjYGqObi6ncXcM+rLdeMyo/CbHdcQTlHs19PDqmEHbXkO2VaHW5v+tb/f9d5h0IJm
         TyCgtY+Uxnl2C3w/0GoJDJTkN3r/uU/hvYX9DL9/O/ObDiYpSeXcKo8V60yXZuPZ69xf
         +6l1utZCBRuTGog30aTKmu8TV+vi0i+3DzIwnOn6GoSRDnQlP8jGW8yTyPMumplYkDOQ
         Ix4PRg2uaGWEk/B7viRkv2H16K37Y83h60h77LgnW/V0+b/XFr6zKKLE1l7IOFs7SR4e
         L+9w==
X-Gm-Message-State: AOAM532xsO5/xt7y+nIXes9DVdeqUGrADZwo9Ya+O5CUbBuGZBayBkpG
        omOvbDT6lpkFCKPjTTurZtc=
X-Google-Smtp-Source: ABdhPJxd7qEXUERPh+Di9IqpkwekW/tzbjV5wRakxszaZY0I2e3OeFixFB1morC4IIXLl042mzGd8g==
X-Received: by 2002:a37:a809:: with SMTP id r9mr7115075qke.96.1589318015567;
        Tue, 12 May 2020 14:13:35 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 132sm12316742qkj.117.2020.05.12.14.13.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:13:35 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLDYIh009807;
        Tue, 12 May 2020 21:13:34 GMT
Subject: [PATCH v1 08/15] SUNRPC: Trace transport lifetime events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 12 May 2020 17:13:34 -0400
Message-ID: <20200512211333.3288.44263.stgit@manet.1015granger.net>
In-Reply-To: <20200512210724.3288.15187.stgit@manet.1015granger.net>
References: <20200512210724.3288.15187.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor: Hoist create/destroy/disconnect tracepoints out of
xprtrdma and into the generic RPC client. Some benefits include:

- Enable tracing of xprt lifetime events for the socket transport
  types

- Expose the different types of disconnect to help run down
  issues with lingering connections

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |    4 ----
 include/trace/events/sunrpc.h   |   35 +++++++++++++++++++++++++++++++++++
 net/sunrpc/xprt.c               |   21 +++++++++++----------
 net/sunrpc/xprtrdma/transport.c |    8 --------
 net/sunrpc/xprtrdma/verbs.c     |    1 -
 5 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 132c3c778a43..edb55eab4762 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -380,12 +380,8 @@
 
 DEFINE_CONN_EVENT(connect);
 DEFINE_CONN_EVENT(disconnect);
-DEFINE_CONN_EVENT(flush_dct);
 
-DEFINE_RXPRT_EVENT(xprtrdma_create);
-DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
 DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
-DEFINE_RXPRT_EVENT(xprtrdma_op_close);
 DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
 
 TRACE_EVENT(xprtrdma_op_connect,
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 4747803b370e..fc8a969ba306 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -724,6 +724,41 @@
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_close);
 DEFINE_RPC_SOCKET_EVENT(rpc_socket_shutdown);
 
+DECLARE_EVENT_CLASS(rpc_xprt_lifetime_class,
+	TP_PROTO(
+		const struct rpc_xprt *xprt
+	),
+
+	TP_ARGS(xprt),
+
+	TP_STRUCT__entry(
+		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
+		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
+	),
+
+	TP_fast_assign(
+		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
+		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+	),
+
+	TP_printk("peer=[%s]:%s", __get_str(addr), __get_str(port))
+);
+
+#define DEFINE_RPC_XPRT_LIFETIME_EVENT(name) \
+	DEFINE_EVENT(rpc_xprt_lifetime_class, \
+			xprt_##name, \
+			TP_PROTO( \
+				const struct rpc_xprt *xprt \
+			), \
+			TP_ARGS(xprt))
+
+DEFINE_RPC_XPRT_LIFETIME_EVENT(create);
+DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_auto);
+DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_done);
+DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_force);
+DEFINE_RPC_XPRT_LIFETIME_EVENT(disconnect_cleanup);
+DEFINE_RPC_XPRT_LIFETIME_EVENT(destroy);
+
 DECLARE_EVENT_CLASS(rpc_xprt_event,
 	TP_PROTO(
 		const struct rpc_xprt *xprt,
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 053de053a024..d5cc5db9dbf3 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -663,6 +663,7 @@ static void xprt_autoclose(struct work_struct *work)
 		container_of(work, struct rpc_xprt, task_cleanup);
 	unsigned int pflags = memalloc_nofs_save();
 
+	trace_xprt_disconnect_auto(xprt);
 	clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
 	xprt->ops->close(xprt);
 	xprt_release_write(xprt, NULL);
@@ -677,7 +678,7 @@ static void xprt_autoclose(struct work_struct *work)
  */
 void xprt_disconnect_done(struct rpc_xprt *xprt)
 {
-	dprintk("RPC:       disconnected transport %p\n", xprt);
+	trace_xprt_disconnect_done(xprt);
 	spin_lock(&xprt->transport_lock);
 	xprt_clear_connected(xprt);
 	xprt_clear_write_space_locked(xprt);
@@ -694,6 +695,8 @@ void xprt_disconnect_done(struct rpc_xprt *xprt)
  */
 void xprt_force_disconnect(struct rpc_xprt *xprt)
 {
+	trace_xprt_disconnect_force(xprt);
+
 	/* Don't race with the test_bit() in xprt_clear_locked() */
 	spin_lock(&xprt->transport_lock);
 	set_bit(XPRT_CLOSE_WAIT, &xprt->state);
@@ -832,8 +835,10 @@ void xprt_connect(struct rpc_task *task)
 	if (!xprt_lock_write(xprt, task))
 		return;
 
-	if (test_and_clear_bit(XPRT_CLOSE_WAIT, &xprt->state))
+	if (test_and_clear_bit(XPRT_CLOSE_WAIT, &xprt->state)) {
+		trace_xprt_disconnect_cleanup(xprt);
 		xprt->ops->close(xprt);
+	}
 
 	if (!xprt_connected(xprt)) {
 		task->tk_rqstp->rq_connect_cookie = xprt->connect_cookie;
@@ -1903,11 +1908,8 @@ struct rpc_xprt *xprt_create_transport(struct xprt_create *args)
 
 found:
 	xprt = t->setup(args);
-	if (IS_ERR(xprt)) {
-		dprintk("RPC:       xprt_create_transport: failed, %ld\n",
-				-PTR_ERR(xprt));
+	if (IS_ERR(xprt))
 		goto out;
-	}
 	if (args->flags & XPRT_CREATE_NO_IDLE_TIMEOUT)
 		xprt->idle_timeout = 0;
 	INIT_WORK(&xprt->task_cleanup, xprt_autoclose);
@@ -1928,8 +1930,7 @@ struct rpc_xprt *xprt_create_transport(struct xprt_create *args)
 
 	rpc_xprt_debugfs_register(xprt);
 
-	dprintk("RPC:       created transport %p with %u slots\n", xprt,
-			xprt->max_reqs);
+	trace_xprt_create(xprt);
 out:
 	return xprt;
 }
@@ -1939,6 +1940,8 @@ static void xprt_destroy_cb(struct work_struct *work)
 	struct rpc_xprt *xprt =
 		container_of(work, struct rpc_xprt, task_cleanup);
 
+	trace_xprt_destroy(xprt);
+
 	rpc_xprt_debugfs_unregister(xprt);
 	rpc_destroy_wait_queue(&xprt->binding);
 	rpc_destroy_wait_queue(&xprt->pending);
@@ -1963,8 +1966,6 @@ static void xprt_destroy_cb(struct work_struct *work)
  */
 static void xprt_destroy(struct rpc_xprt *xprt)
 {
-	dprintk("RPC:       destroying transport %p\n", xprt);
-
 	/*
 	 * Exclude transport connect/disconnect handlers and autoclose
 	 */
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 659da37020a4..048c2fd85728 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -281,8 +281,6 @@
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 
-	trace_xprtrdma_op_destroy(r_xprt);
-
 	cancel_delayed_work_sync(&r_xprt->rx_connect_worker);
 
 	rpcrdma_xprt_disconnect(r_xprt);
@@ -365,10 +363,6 @@
 
 	xprt->max_payload = RPCRDMA_MAX_DATA_SEGS << PAGE_SHIFT;
 
-	dprintk("RPC:       %s: %s:%s\n", __func__,
-		xprt->address_strings[RPC_DISPLAY_ADDR],
-		xprt->address_strings[RPC_DISPLAY_PORT]);
-	trace_xprtrdma_create(new_xprt);
 	return xprt;
 }
 
@@ -385,8 +379,6 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
 
-	trace_xprtrdma_op_close(r_xprt);
-
 	rpcrdma_xprt_disconnect(r_xprt);
 
 	xprt->reestablish_timeout = 0;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 05c4d3a9cda2..2ae348377806 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -141,7 +141,6 @@ void rpcrdma_flush_disconnect(struct ib_cq *cq, struct ib_wc *wc)
 	if (wc->status != IB_WC_SUCCESS &&
 	    r_xprt->rx_ep->re_connect_status == 1) {
 		r_xprt->rx_ep->re_connect_status = -ECONNABORTED;
-		trace_xprtrdma_flush_dct(r_xprt, wc->status);
 		xprt_force_disconnect(xprt);
 	}
 }

