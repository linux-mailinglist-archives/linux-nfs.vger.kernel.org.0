Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360FA22E2AC
	for <lists+linux-nfs@lfdr.de>; Sun, 26 Jul 2020 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgGZU77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 26 Jul 2020 16:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGZU76 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 26 Jul 2020 16:59:58 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4CEC0619D2;
        Sun, 26 Jul 2020 13:59:58 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id p16so644241ile.0;
        Sun, 26 Jul 2020 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PRYgMVIXtgqm6LIgBOqkl74Fauj/p2bxSG5MktH/UF4=;
        b=HLJ/Bt7jxv3jFoI+XlAv/PSQCG92OMBLFuQWOo6Twa9CHnZM+1xHLIlubpR3pwIrQb
         36+u9OEKlsIP0zqBhA0bU/S4avaJLKnHhriAljLcGXp632Rpic4yZmgb+hNGrU7FBdyT
         V5BWicP4Cw29tT6u2f8/MORQxCQ38b+xM9JsxfrLhsdaEGK/09QmuaH1ufbqIwrJ2f5E
         eqWab309CaOiSSO/Ukya4i0JtTsIHp5AXzzFzbB7apoTzK6/q+u6x03U4SF0yYDEnpOd
         AMwpccyzgqJSxTqvzvXVwUa4iOnzTGgtUkGjnk+Sq0dgVGfXZpqsRUcc4m3QqmCnEozj
         3qGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=PRYgMVIXtgqm6LIgBOqkl74Fauj/p2bxSG5MktH/UF4=;
        b=VZeHiJkQEX7+rn9AV6yfiUHVEx9h6mE7UkINhmKBbI0LjGwCIawbj+BAk/lJfZg5NM
         T2lVq7zSpDuTRh+3Ee/grNgnzLJKWzAfClOp3VOVKWvz9/Ziw+MAYksakuWoQIb5+uyG
         iV097F+AQxRW0Ue1VtDVewon0ycqUAbDsK3S7odS2cvX2uo6thcuJwSuRlAjmm5k7Myu
         3Y5tShdNT0oieApiUqdWKxXB1472qmK5vdk2B6tI9uRYiMMESxDj/Yi/DeoHrsf0qpES
         NsljFaHTCAcYfSFNor9hQDXhrSe7OvypCnlOtenGiDMVuPDJUTVTAJoJoZcLSb7kDOqN
         BJPg==
X-Gm-Message-State: AOAM530GVysTnQqoAPGNc/wN5dtArXeQg1SYVnP3kh+9G5+C15Oz6Q1E
        zjzWgHQFZFsE6kP4fRyTEEY+OJo5RXo=
X-Google-Smtp-Source: ABdhPJxBRTHj1FavNSusPZYQ3qcVL6yjKNR97OJeBvXCIjOLcuw085lfkGXHuD/hf43s8pyTFjXiwQ==
X-Received: by 2002:a92:dac8:: with SMTP id o8mr20116061ilq.152.1595797197465;
        Sun, 26 Jul 2020 13:59:57 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id i8sm7089140ilq.67.2020.07.26.13.59.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Jul 2020 13:59:56 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06QKxuAx013841;
        Sun, 26 Jul 2020 20:59:56 GMT
Subject: [PATCH v1 3/3] svcrdma: CM event handler clean up
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sun, 26 Jul 2020 16:59:56 -0400
Message-ID: <159579719607.2004.1280396481349688427.stgit@klimt.1015granger.net>
In-Reply-To: <159579718507.2004.16208139278801479272.stgit@klimt.1015granger.net>
References: <159579718507.2004.16208139278801479272.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that there's a core tracepoint that reports these events, there's
no need to maintain dprintk() call sites in each arm of the switch
statements.

We also refresh the documenting comments.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   56 +++++++++++++-----------------
 1 file changed, 25 insertions(+), 31 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index aa60f75c8c1d..fb044792b571 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -237,62 +237,56 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
 }
 
-/*
- * Handles events generated on the listening endpoint. These events will be
- * either be incoming connect requests or adapter removal  events.
+/**
+ * svc_rdma_listen_handler - Handle CM events generated on a listening endpoint
+ * @cma_id: the server's listener rdma_cm_id
+ * @event: details of the event
+ *
+ * Return values:
+ *     %0: Do not destroy @cma_id
+ *     %1: Destroy @cma_id (never returned here)
+ *
+ * NB: There is never a DEVICE_REMOVAL event for INADDR_ANY listeners.
  */
-static int rdma_listen_handler(struct rdma_cm_id *cma_id,
-			       struct rdma_cm_event *event)
+static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
+				   struct rdma_cm_event *event)
 {
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
-		dprintk("svcrdma: Connect request on cma_id=%p, xprt = %p, "
-			"event = %s (%d)\n", cma_id, cma_id->context,
-			rdma_event_msg(event->event), event->event);
 		handle_connect_req(cma_id, &event->param.conn);
 		break;
 	default:
-		/* NB: No device removal upcall for INADDR_ANY listeners */
-		dprintk("svcrdma: Unexpected event on listening endpoint %p, "
-			"event = %s (%d)\n", cma_id,
-			rdma_event_msg(event->event), event->event);
 		break;
 	}
-
 	return 0;
 }
 
-static int rdma_cma_handler(struct rdma_cm_id *cma_id,
-			    struct rdma_cm_event *event)
+/**
+ * svc_rdma_cma_handler - Handle CM events on client connections
+ * @cma_id: the server's listener rdma_cm_id
+ * @event: details of the event
+ *
+ * Return values:
+ *     %0: Do not destroy @cma_id
+ *     %1: Destroy @cma_id (never returned here)
+ */
+static int svc_rdma_cma_handler(struct rdma_cm_id *cma_id,
+				struct rdma_cm_event *event)
 {
 	struct svcxprt_rdma *rdma = cma_id->context;
 	struct svc_xprt *xprt = &rdma->sc_xprt;
 
 	switch (event->event) {
 	case RDMA_CM_EVENT_ESTABLISHED:
-		/* Accept complete */
-		dprintk("svcrdma: Connection completed on DTO xprt=%p, "
-			"cm_id=%p\n", xprt, cma_id);
 		clear_bit(RDMAXPRT_CONN_PENDING, &rdma->sc_flags);
 		svc_xprt_enqueue(xprt);
 		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
-		dprintk("svcrdma: Disconnect on DTO xprt=%p, cm_id=%p\n",
-			xprt, cma_id);
-		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		svc_xprt_enqueue(xprt);
-		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
-		dprintk("svcrdma: Device removal cma_id=%p, xprt = %p, "
-			"event = %s (%d)\n", cma_id, xprt,
-			rdma_event_msg(event->event), event->event);
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		svc_xprt_enqueue(xprt);
 		break;
 	default:
-		dprintk("svcrdma: Unexpected event on DTO endpoint %p, "
-			"event = %s (%d)\n", cma_id,
-			rdma_event_msg(event->event), event->event);
 		break;
 	}
 	return 0;
@@ -318,7 +312,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	set_bit(XPT_LISTENER, &cma_xprt->sc_xprt.xpt_flags);
 	strcpy(cma_xprt->sc_xprt.xpt_remotebuf, "listener");
 
-	listen_id = rdma_create_id(net, rdma_listen_handler, cma_xprt,
+	listen_id = rdma_create_id(net, svc_rdma_listen_handler, cma_xprt,
 				   RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(listen_id)) {
 		ret = PTR_ERR(listen_id);
@@ -482,7 +476,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 		goto errout;
 
 	/* Swap out the handler */
-	newxprt->sc_cm_id->event_handler = rdma_cma_handler;
+	newxprt->sc_cm_id->event_handler = svc_rdma_cma_handler;
 
 	/* Construct RDMA-CM private message */
 	pmsg.cp_magic = rpcrdma_cmp_magic;


