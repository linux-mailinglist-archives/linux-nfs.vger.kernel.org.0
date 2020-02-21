Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66A21689B0
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Feb 2020 23:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgBUWAb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Feb 2020 17:00:31 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39327 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgBUWAb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Feb 2020 17:00:31 -0500
Received: by mail-yb1-f195.google.com with SMTP id l75so1864539ybf.6;
        Fri, 21 Feb 2020 14:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xybrt5F50nwXq+bPCeuYs0mya8j+hAnUU7L/N6w9l5k=;
        b=YYVLHzygvgaSu8nkcmwhiTc8abFR39R6A0ZNKHSGJxGMwyyXGlvlN6XPOlY37T0UbL
         pb4QkNCxR4jgLC6xxYx8+erzH/NdlrjM389HMOfPgjo485fYJRC26jiwV2pwXcdFbMzT
         7c9IKQX0Yc5+a6730KBW5T0SZYqIp6cEVC06lE86RWOi63enWoiJ70onlfaDrf6WyjBf
         pHLHq2BjtUijuTlgP5LgO8GCN7oHb2/bi3LKBDG+HPhe+icREPv4Xa1GelYNd1tJDy9v
         lQfd5mVl1loh5PWtSky6ZpFjnEj0ZHRc+7nPdv1Gfb9mndbDPCLDL8e2riMKW/kudVXW
         YWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Xybrt5F50nwXq+bPCeuYs0mya8j+hAnUU7L/N6w9l5k=;
        b=OgzyUPWu0SnnptFOn7y69ZK3PVQJIUgetnzKtuR3vw36PsSEstNSm2qrkJHs1fg0Td
         uKTSnnkMVDu+UbQbcsjsx7gtNHsEJGwXNeSLHCbzt94qrnQvEKGW/H4LuYe0xaP+ccQp
         TQfUsU2bKBN8CD2YZSDiuyJx06Txufj16s3e0x74972yQ6IgDuwYRnrsz/rsBjABFKuz
         nH1GVcK5CnJ7AVa82xsbWmbQUNNr+czCOKFifYhZQGYkkuQ/64hclVYa6mDnYeZCvcTM
         PcG6xgqxQFuSxsAKGjgH1XZtRVkkmmHSLD3Gp0Qw9DNGN7lawampq/z7zrkaxTumTQ1o
         rtPA==
X-Gm-Message-State: APjAAAVTB6eeoEjkEwqUIEsSNUoZ/7RCPjXDCDTfWCsoeIGavFlKPmAU
        3Elz0kXzUT78AwSumt/XDZzI59R3
X-Google-Smtp-Source: APXvYqz8OwAQQv7sCDTBaItDrBpc/qRtStJmVYMtZgblbbQE2Wjselr8kisfbnIxwRsPBNoYrFLfOQ==
X-Received: by 2002:a25:8810:: with SMTP id c16mr18458305ybl.270.1582322429737;
        Fri, 21 Feb 2020 14:00:29 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id t15sm1910142ywg.67.2020.02.21.14.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 14:00:29 -0800 (PST)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 01LM0Sg1018988;
        Fri, 21 Feb 2020 22:00:28 GMT
Subject: [PATCH v1 04/11] xprtrdma: Refactor rpcrdma_ep_connect() and
 rpcrdma_ep_disconnect()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 21 Feb 2020 17:00:28 -0500
Message-ID: <20200221220028.2072.48067.stgit@manet.1015granger.net>
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

Clean up: Simplify the synopses of functions in the connect and
disconnect paths in preparation for combining the rpcrdma_ia and
struct rpcrdma_ep structures.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    6 +++---
 net/sunrpc/xprtrdma/verbs.c     |   30 +++++++++++++++---------------
 net/sunrpc/xprtrdma/xprt_rdma.h |    4 ++--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 8934c24a5701..6349e6c98b57 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -240,7 +240,7 @@
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
 	int rc;
 
-	rc = rpcrdma_ep_connect(&r_xprt->rx_ep, &r_xprt->rx_ia);
+	rc = rpcrdma_xprt_connect(r_xprt);
 	xprt_clear_connecting(xprt);
 	if (r_xprt->rx_ep.rep_connected > 0) {
 		xprt->stat.connect_count++;
@@ -284,7 +284,7 @@
 
 	cancel_delayed_work_sync(&r_xprt->rx_connect_worker);
 
-	rpcrdma_ep_disconnect(&r_xprt->rx_ep, &r_xprt->rx_ia);
+	rpcrdma_xprt_disconnect(r_xprt);
 	rpcrdma_buffer_destroy(&r_xprt->rx_buf);
 	rpcrdma_ia_close(&r_xprt->rx_ia);
 
@@ -409,7 +409,7 @@ void xprt_rdma_close(struct rpc_xprt *xprt)
 
 	if (ep->rep_connected == -ENODEV)
 		return;
-	rpcrdma_ep_disconnect(ep, ia);
+	rpcrdma_xprt_disconnect(r_xprt);
 
 out:
 	xprt->reestablish_timeout = 0;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 8fd6682d2646..f361213a8157 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -610,15 +610,17 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt)
 	return rc;
 }
 
-/*
- * Connect unconnected endpoint.
+/**
+ * rpcrdma_xprt_connect - Connect an unconnected transport
+ * @r_xprt: controlling transport instance
+ *
+ * Returns 0 on success or a negative errno.
  */
-int
-rpcrdma_ep_connect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
+int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_xprt *r_xprt = container_of(ia, struct rpcrdma_xprt,
-						   rx_ia);
 	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	int rc;
 
 retry:
@@ -634,7 +636,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt)
 			goto out_noupdate;
 		break;
 	case 1:
-		rpcrdma_ep_disconnect(ep, ia);
+		rpcrdma_xprt_disconnect(r_xprt);
 		/* fall through */
 	default:
 		rc = rpcrdma_ep_reconnect(r_xprt);
@@ -668,7 +670,7 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt)
 
 	rc = rpcrdma_reqs_setup(r_xprt);
 	if (rc) {
-		rpcrdma_ep_disconnect(ep, ia);
+		rpcrdma_xprt_disconnect(r_xprt);
 		goto out;
 	}
 	rpcrdma_mrs_create(r_xprt);
@@ -683,18 +685,16 @@ static int rpcrdma_ep_reconnect(struct rpcrdma_xprt *r_xprt)
 }
 
 /**
- * rpcrdma_ep_disconnect - Disconnect underlying transport
- * @ep: endpoint to disconnect
- * @ia: associated interface adapter
+ * rpcrdma_xprt_disconnect - Disconnect underlying transport
+ * @r_xprt: controlling transport instance
  *
  * Caller serializes. Either the transport send lock is held,
  * or we're being called to destroy the transport.
  */
-void
-rpcrdma_ep_disconnect(struct rpcrdma_ep *ep, struct rpcrdma_ia *ia)
+void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_xprt *r_xprt = container_of(ep, struct rpcrdma_xprt,
-						   rx_ep);
+	struct rpcrdma_ep *ep = &r_xprt->rx_ep;
+	struct rpcrdma_ia *ia = &r_xprt->rx_ia;
 	struct rdma_cm_id *id = ia->ri_id;
 	int rc;
 
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 82ec4c25432f..9ead06b1d8a4 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -464,8 +464,8 @@ struct rpcrdma_xprt {
 /*
  * Endpoint calls - xprtrdma/verbs.c
  */
-int rpcrdma_ep_connect(struct rpcrdma_ep *, struct rpcrdma_ia *);
-void rpcrdma_ep_disconnect(struct rpcrdma_ep *, struct rpcrdma_ia *);
+int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
+void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 
 int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
 void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);

