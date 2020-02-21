Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C57B31689B5
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgBUWAo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:44 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:32835 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgBUWAo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:44 -0500
Received: by mail-yw1-f65.google.com with SMTP id 192so1816319ywy.0;
        Fri, 21 Feb 2020 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=eZZVK4Lqf0ODb+7KsK4tYDJHuDk0tILL3tKyxc+4HRk=;
        b=Humdro8meZ4gPQ7+MHBQi0hJr0eFRI3669KURPmBauhTzdQHypNe0MsmkumX5br9eJ
         2Bvbv4pYQUsKymB4m+3o9zlEKGD2pHgzoCkyc13y5YamW3t/jKK5z87HRmiS/vqdvFS6
         KN3WdcF/kLxAO4UgT+JzyXtkWHysAcmgQHL9l/pmYQ3B8cuz4SgyLJMHuHs03B1KnAan
         qjNeiC4uX4jcx0KafPg4RTUa4FqxFOSJ9a/as4p8SZ/CA8YB6zU7zR3nU101xmwypQKn
         CJu5b25gl5Im+O3JjHplxiA3jkn5oc6HbtVSsrfkfLdN7uwPzpHFxrskFwXsNdpN+cq2
         KFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=eZZVK4Lqf0ODb+7KsK4tYDJHuDk0tILL3tKyxc+4HRk=;
        b=IC5A1EMgg199vJHLDDJvX+vPYPK9AUcqfY4mngm6tems72btjnNuoWxD5yxNdhbvZ7
         j66LXLli/kzFlRThELKcSbsyje3wiIj1wuUc0antYVDbvwSKLURsJjwmY2/kr1+Mr6/l
         a+21U4oxNhGu6mNVq/L2K7qNaKADOjaU2idogq7BZjZfkmQ8u6MteEMxO+3rXOkwA3uo
         G5KeYh8azlu+fOEa9kt35/9fFnD74JZH7GztQZ6pDRw0g2lnQfJGQQ33T+gQ6LNz5X1v
         jL7i0e/N9O5ab8PSkjaOBXIdd3jwZhN6PuJohBdRkvJMVbcAD9oTodEvQm4yupL14TjL
         Wkaw==
X-Gm-Message-State: APjAAAUCttIP+uwnjM+SPJLJncxr7kzZsj78X+4gIaPrklHkcnMfvO90
        bySIo/ktkgafSpefSMH0e73G1LNq
X-Google-Smtp-Source: APXvYqxdtQWQayBRrF+PCyb9XRoSRAFnopsk8SHpDG0gnBGEWQlEd+t9hu6s/z8LgOyyCsSjPV0UFQ==
X-Received: by 2002:a0d:c345:: with SMTP id f66mr33083657ywd.388.1582322440166;
        Fri, 21 Feb 2020 14:00:40 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id m62sm1811313ywb.107.2020.02.21.14.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:39 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0c32018994;
        Fri, 21 Feb 2020 22:00:38 GMT
Subject: [PATCH v1 06/11] xprtrdma: Invoke rpcrdma_ia_open in the connect
 worker
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:38 -0500
Message-ID: <20200221220038.2072.45482.stgit@manet.1015granger.net>
In-Reply-To: <20200221214906.2072.32572.stgit@manet.1015granger.net>
References: <20200221214906.2072.32572.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Move rdma_cm_id creation into rpcrdma_ep_create() so that it is now
responsible for allocating all per-connection hardware resources.

With this clean-up, all three arms of the switch statement in
rpcrdma_ep_connect are exactly the same now, thus the switch can be
removed.

Because device removal behaves a little differently than
disconnection, there is a little more work to be done before
rpcrdma_ep_destroy() can release the connection's rdma_cm_id. So
it is not quite symmetrical with rpcrdma_ep_create() yet.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h  |    1 
 net/sunrpc/xprtrdma/transport.c |    7 --
 net/sunrpc/xprtrdma/verbs.c     |  153 +++++----------------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 -
 4 files changed, 20 insertions(+), 143 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index c0e4c93324f5..ce2126a90806 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -413,7 +413,6 @@
 DEFINE_RXPRT_EVENT(xprtrdma_create);
 DEFINE_RXPRT_EVENT(xprtrdma_op_destroy);
 DEFINE_RXPRT_EVENT(xprtrdma_remove);
-DEFINE_RXPRT_EVENT(xprtrdma_reinsert);
 DEFINE_RXPRT_EVENT(xprtrdma_op_inject_dsc);
 DEFINE_RXPRT_EVENT(xprtrdma_op_close);
 DEFINE_RXPRT_EVENT(xprtrdma_op_setport);
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 6349e6c98b57..745dfd149637 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -286,7 +286,6 @@
 
 	rpcrdma_xprt_disconnect(r_xprt);
 	rpcrdma_buffer_destroy(&r_xprt->rx_buf);
-	rpcrdma_ia_close(&r_xprt->rx_ia);
 
 	xprt_rdma_free_addresses(xprt);
 	xprt_free(xprt);
@@ -347,10 +346,6 @@
 	xprt_rdma_format_addresses(xprt, sap);
 
 	new_xprt = rpcx_to_rdmax(xprt);
-	rc = rpcrdma_ia_open(new_xprt);
-	if (rc)
-		goto out1;
-
 	rc = rpcrdma_buffer_create(new_xprt);
 	if (rc)
 		goto out2;
@@ -372,8 +367,6 @@
 	rpcrdma_buffer_destroy(&new_xprt->rx_buf);
 	rc = -ENODEV;
 out2:
-	rpcrdma_ia_close(&new_xprt->rx_ia);
-out1:
 	trace_xprtrdma_op_destroy(new_xprt);
 	xprt_rdma_free_addresses(xprt);
 	xprt_free(xprt);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 36fe7baea014..3df20f355579 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -346,31 +346,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
  */
 
 /**
- * rpcrdma_ia_open - Open and initialize an Interface Adapter.
- * @xprt: transport with IA to (re)initialize
- *
- * Returns 0 on success, negative errno if an appropriate
- * Interface Adapter could not be found and opened.
- */
-int
-rpcrdma_ia_open(struct rpcrdma_xprt *xprt)
-{
-	struct rpcrdma_ia *ia = &xprt->rx_ia;
-	int rc;
-
-	ia->ri_id = rpcrdma_create_id(xprt, ia);
-	if (IS_ERR(ia->ri_id)) {
-		rc = PTR_ERR(ia->ri_id);
-		goto out_err;
-	}
-	return 0;
-
-out_err:
-	rpcrdma_ia_close(ia);
-	return rc;
-}
-
-/**
  * rpcrdma_ia_remove - Handle device driver unload
  * @ia: interface adapter being removed
  *
@@ -401,34 +376,26 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 	trace_xprtrdma_remove(r_xprt);
 }
 
-/**
- * rpcrdma_ia_close - Clean up/close an IA.
- * @ia: interface adapter to close
- *
- */
-void
-rpcrdma_ia_close(struct rpcrdma_ia *ia)
-{
-	if (ia->ri_id && !IS_ERR(ia->ri_id))
-		rdma_destroy_id(ia->ri_id);
-	ia->ri_id = NULL;
-}
-
-static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
-			     struct rdma_cm_id *id)
+static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rpcrdma_connect_private *pmsg = &ep->rep_cm_private;
+	struct rdma_cm_id *id;
 	int rc;
 
+	id = rpcrdma_create_id(r_xprt, ia);
+	if (IS_ERR(id))
+		return PTR_ERR(id);
+
 	ep->rep_max_requests = r_xprt->rx_xprt.max_reqs;
 	ep->rep_inline_send = xprt_rdma_max_inline_write;
 	ep->rep_inline_recv = xprt_rdma_max_inline_read;
 
 	rc = frwr_query_device(r_xprt, id->device);
 	if (rc)
-		return rc;
+		goto out_destroy;
+
 	r_xprt->rx_buf.rb_max_requests = cpu_to_be32(ep->rep_max_requests);
 
 	ep->rep_attr.event_handler = rpcrdma_qp_event_handler;
@@ -507,10 +474,12 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt,
 	rc = rdma_create_qp(id, ia->ri_pd, &ep->rep_attr);
 	if (rc)
 		goto out_destroy;
+	ia->ri_id = id;
 	return 0;
 
 out_destroy:
 	rpcrdma_ep_destroy(r_xprt);
+	rdma_destroy_id(id);
 	return rc;
 }
 
@@ -536,79 +505,8 @@ static void rpcrdma_ep_destroy(struct rpcrdma_xprt *r_xprt)
 	ia->ri_pd = NULL;
 }
 
-/* Re-establish a connection after a device removal event.
- * Unlike a normal reconnection, a fresh PD and a new set
- * of MRs and buffers is needed.
- */
-static int rpcrdma_ep_recreate_xprt(struct rpcrdma_xprt *r_xprt)
-{
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	int rc, err;
-
-	trace_xprtrdma_reinsert(r_xprt);
-
-	rc = -EHOSTUNREACH;
-	if (rpcrdma_ia_open(r_xprt))
-		goto out1;
-
-	rc = -ENETUNREACH;
-	err = rpcrdma_ep_create(r_xprt, ia->ri_id);
-	if (err)
-		goto out2;
-	return 0;
-
-out2:
-	rpcrdma_ia_close(ia);
-out1:
-	return rc;
-}
-
-static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt)
-{
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-	struct rdma_cm_id *id, *old;
-	int err, rc;
-
-	rc = -EHOSTUNREACH;
-	id = rpcrdma_create_id(r_xprt, ia);
-	if (IS_ERR(id))
-		goto out;
-
-	/* As long as the new ID points to the same device as the
-	 * old ID, we can reuse the transport's existing PD and all
-	 * previously allocated MRs. Also, the same device means
-	 * the transport's previous DMA mappings are still valid.
-	 *
-	 * This is a sanity check only. There should be no way these
-	 * point to two different devices here.
-	 */
-	old = id;
-	rc = -ENETUNREACH;
-	if (ia->ri_id->device != id->device) {
-		pr_err("rpcrdma: can't reconnect on different device!\n");
-		goto out_destroy;
-	}
-
-	err = rpcrdma_ep_create(r_xprt, id);
-	if (err)
-		goto out_destroy;
-
-	/* Atomically replace the transport's ID. */
-	rc = 0;
-	old = ia->ri_id;
-	ia->ri_id = id;
-
-out_destroy:
-	rdma_destroy_id(old);
-out:
-	return rc;
-}
-
-/**
- * rpcrdma_xprt_connect - Connect an unconnected transport
- * @r_xprt: controlling transport instance
- *
- * Returns 0 on success or a negative errno.
+/*
+ * Connect unconnected endpoint.
  */
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 {
@@ -618,25 +516,10 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	int rc;
 
 retry:
-	switch (ep->rep_connected) {
-	case 0:
-		rc = -ENETUNREACH;
-		if (rpcrdma_ep_create(r_xprt, ia->ri_id))
-			goto out_noupdate;
-		break;
-	case -ENODEV:
-		rc = rpcrdma_ep_recreate_xprt(r_xprt);
-		if (rc)
-			goto out_noupdate;
-		break;
-	case 1:
-		rpcrdma_xprt_disconnect(r_xprt);
-		/* fall through */
-	default:
-		rc = rpcrdma_ep_reconnect(r_xprt);
-		if (rc)
-			goto out;
-	}
+	rpcrdma_xprt_disconnect(r_xprt);
+	rc = rpcrdma_ep_create(r_xprt);
+	if (rc)
+		goto out_noupdate;
 
 	ep->rep_connected = 0;
 	xprt_clear_connected(xprt);
@@ -712,6 +595,10 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	rpcrdma_sendctxs_destroy(r_xprt);
 
 	rpcrdma_ep_destroy(r_xprt);
+
+	if (ia->ri_id)
+		rdma_destroy_id(ia->ri_id);
+	ia->ri_id = NULL;
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 9ead06b1d8a4..8be1b70b71a2 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -457,9 +457,7 @@ struct rpcrdma_xprt {
 /*
  * Interface Adapter calls - xprtrdma/verbs.c
  */
-int rpcrdma_ia_open(struct rpcrdma_xprt *xprt);
 void rpcrdma_ia_remove(struct rpcrdma_ia *ia);
-void rpcrdma_ia_close(struct rpcrdma_ia *);
 
 /*
  * Endpoint calls - xprtrdma/verbs.c

