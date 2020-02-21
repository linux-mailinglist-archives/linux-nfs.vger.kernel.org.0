Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B71689B7
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgBUWAt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:49 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40826 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgBUWAt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:49 -0500
Received: by mail-yb1-f196.google.com with SMTP id f130so1866703ybc.7;
        Fri, 21 Feb 2020 14:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iuQVFceq/fLlB/8RxgnVO5wb/LHs7ibuJv82J21q8ms=;
        b=gUNrGd7tqwOKa4O8aIyw0E9UozUStqNxwCdikWk/Xlp8TuFOCyluWMzDkK93dDwiRo
         vRoVcDSi55fPx0j7ZdbGktuYAAhXW+sHHqnw7zY6bZeX/oyky2FgZGuGX9aqjVNqXHlY
         p+4mxknNeoXGl3ZLE9JRZw442ax6ubigqBTL5X6a1HUjlCb9IU6xoS1NqiSfX6QtYe8a
         wlop9mZyddVUEPTcolMqtHYFTEmQ1fBcZSoofQto+3wNznJH/9ZK7q+K4l5SXFxB5fLh
         H1HcE2RfbXqCjrYrSslZ/2QVnyMp0sfcDcOwO+MN+sdljtAF63zy8uBMqBKnIL+1PWg/
         wh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=iuQVFceq/fLlB/8RxgnVO5wb/LHs7ibuJv82J21q8ms=;
        b=sAtlq/vWnk6WAr+gb/2/73+n2UcQLLu2neSi8Ur+uMMhi2bEsCq29ctFPxJzft/WdX
         eA4Sn7gFiujIsxBO/inzMKJiZYp4sfQDZwwOvuXzQrU7pF3C/lzx/IcsoBo8sQofl8dr
         cNZqH0zfapmKFMBTQaYptegf25fFEYM1fR38DThSZZnmASMlDB1u7iDAMQUzSBJg9UbL
         Bei3lgXMKL2GNLHha9TLt67tv0h4r9k0osue2iuITAHeYLYUtu/00mWl6JHbZEPJKk4S
         OdfyKOq58YNtq169QKyUYV/0DLuQmrC7sVPYRbBY0y3iPlWVMZjE/cH/B934hYp/A4gk
         5n0Q==
X-Gm-Message-State: APjAAAU3jWdJFr/1PhKSDhNkg6A/pWi1UGE7k2qgo3zlePJwAbgsqvvE
        DtzIdPiRALYlyaFij+zBH6AjLRHh
X-Google-Smtp-Source: APXvYqxmS+ZAha8csh0UWlf4dlK6kc4fhXA/vF0n14zYJk97sqNs3KDR/gxQh4v5wToYvoWX6ua+cA==
X-Received: by 2002:a25:2541:: with SMTP id l62mr5267666ybl.294.1582322446360;
        Fri, 21 Feb 2020 14:00:46 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id x84sm1849817ywg.47.2020.02.21.14.00.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:45 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0i0X018997;
        Fri, 21 Feb 2020 22:00:44 GMT
Subject: [PATCH v1 07/11] xprtrdma: Remove rpcrdma_ia::ri_flags
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:44 -0500
Message-ID: <20200221220044.2072.37658.stgit@manet.1015granger.net>
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

Clean up:
The upper layer serializes calls to xprt_rdma_close, so there is no
need for an atomic bit operation, saving 8 bytes in rpcrdma_ia.

This enables merging rpcrdma_ia_remove directly into the disconnect
logic.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |   15 -----------
 net/sunrpc/xprtrdma/verbs.c     |   55 +++++++++------------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h |   10 -------
 3 files changed, 13 insertions(+), 67 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 745dfd149637..d7b7dab0aeb6 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -385,26 +385,11 @@
 void xprt_rdma_close(struct rpc_xprt *xprt)
 {
 	struct rpcrdma_xprt *r_xprt = rpcx_to_rdmax(xprt);
-	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
-	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
-
-	might_sleep();
 
 	trace_xprtrdma_op_close(r_xprt);
 
-	/* Prevent marshaling and sending of new requests */
-	xprt_clear_connected(xprt);
-
-	if (test_and_clear_bit(RPCRDMA_IAF_REMOVING, &ia->ri_flags)) {
-		rpcrdma_ia_remove(ia);
-		goto out;
-	}
-
-	if (ep->rep_connected == -ENODEV)
-		return;
 	rpcrdma_xprt_disconnect(r_xprt);
 
-out:
 	xprt->reestablish_timeout = 0;
 	++xprt->connect_cookie;
 	xprt_disconnect_done(xprt);
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3df20f355579..a7f46bbbf017 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -250,12 +250,11 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
 			rpcrdma_addrstr(r_xprt), rpcrdma_portstr(r_xprt));
 #endif
 		init_completion(&ia->ri_remove_done);
-		set_bit(RPCRDMA_IAF_REMOVING, &ia->ri_flags);
 		ep->rep_connected = -ENODEV;
 		xprt_force_disconnect(xprt);
 		wait_for_completion(&ia->ri_remove_done);
+		trace_xprtrdma_remove(r_xprt);
 
-		ia->ri_id = NULL;
 		/* Return 1 to ensure the core destroys the id. */
 		return 1;
 	case RDMA_CM_EVENT_ESTABLISHED:
@@ -345,37 +344,6 @@ static void rpcrdma_update_cm_private(struct rpcrdma_xprt *r_xprt,
  * Exported functions.
  */
 
-/**
- * rpcrdma_ia_remove - Handle device driver unload
- * @ia: interface adapter being removed
- *
- * Divest transport H/W resources associated with this adapter,
- * but allow it to be restored later.
- *
- * Caller must hold the transport send lock.
- */
-void
-rpcrdma_ia_remove(struct rpcrdma_ia *ia)
-{
-	struct rpcrdma_xprt *r_xprt = container_of(ia, struct rpcrdma_xprt,
-						   rx_ia);
-
-	if (ia->ri_id->qp)
-		rpcrdma_xprt_drain(r_xprt);
-
-	rpcrdma_reps_unmap(r_xprt);
-	rpcrdma_reqs_reset(r_xprt);
-	rpcrdma_mrs_destroy(r_xprt);
-	rpcrdma_sendctxs_destroy(r_xprt);
-
-	rpcrdma_ep_destroy(r_xprt);
-
-	/* Allow waiters to continue */
-	complete(&ia->ri_remove_done);
-
-	trace_xprtrdma_remove(r_xprt);
-}
-
 static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
@@ -573,12 +541,13 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rdma_cm_id *id = ia->ri_id;
-	int rc;
+	int rc, status = ep->rep_connected;
+
+	might_sleep();
 
 	if (!id)
-		goto out;
+		return;
 
-	/* returns without wait if ID is not connected */
 	rc = rdma_disconnect(id);
 	if (!rc)
 		wait_event_interruptible(ep->rep_connect_wait,
@@ -589,15 +558,17 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 
 	if (id->qp)
 		rpcrdma_xprt_drain(r_xprt);
-out:
+	rpcrdma_reps_unmap(r_xprt);
 	rpcrdma_reqs_reset(r_xprt);
 	rpcrdma_mrs_destroy(r_xprt);
 	rpcrdma_sendctxs_destroy(r_xprt);
 
 	rpcrdma_ep_destroy(r_xprt);
 
-	if (ia->ri_id)
-		rdma_destroy_id(ia->ri_id);
+	if (status == -ENODEV)
+		complete(&ia->ri_remove_done);
+	else
+		rdma_destroy_id(id);
 	ia->ri_id = NULL;
 }
 
@@ -815,10 +786,10 @@ void rpcrdma_mrs_refresh(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
 
-	/* If there is no underlying device, it's no use to
-	 * wake the refresh worker.
+	/* If there is no underlying connection, it's no use
+	 * to wake the refresh worker.
 	 */
-	if (ep->rep_connected != -ENODEV) {
+	if (ep->rep_connected == 1) {
 		/* The work is scheduled on a WQ_MEM_RECLAIM
 		 * workqueue in order to prevent MR allocation
 		 * from recursing into NFS during direct reclaim.
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 8be1b70b71a2..d2a0f125f7a8 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -75,15 +75,10 @@ struct rpcrdma_ia {
 	unsigned int		ri_max_frwr_depth;
 	bool			ri_implicit_roundup;
 	enum ib_mr_type		ri_mrtype;
-	unsigned long		ri_flags;
 	struct completion	ri_done;
 	struct completion	ri_remove_done;
 };
 
-enum {
-	RPCRDMA_IAF_REMOVING = 0,
-};
-
 /*
  * RDMA Endpoint -- one per transport instance
  */
@@ -455,11 +450,6 @@ struct rpcrdma_xprt {
 extern unsigned int xprt_rdma_memreg_strategy;
 
 /*
- * Interface Adapter calls - xprtrdma/verbs.c
- */
-void rpcrdma_ia_remove(struct rpcrdma_ia *ia);
-
-/*
  * Endpoint calls - xprtrdma/verbs.c
  */
 int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);

