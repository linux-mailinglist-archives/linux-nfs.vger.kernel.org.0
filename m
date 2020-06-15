Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F41F1F9844
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2020 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgFONVL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Jun 2020 09:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbgFONVK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Jun 2020 09:21:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5ABC061A0E;
        Mon, 15 Jun 2020 06:21:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id x189so8685603iof.9;
        Mon, 15 Jun 2020 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SGsil05SR5HyEHxBqow0AuD9rbhVsw4TLPg5c/VcqZw=;
        b=g0ybEJW4V18N3WdbeKPGuiCzBGFUnIhO34bjpwDKfrTYCPoRmzr2ckTOxH72t4dnzw
         fAqqme3xzKSL8SX4Park350Lambi2PP2H4jHlGV6Zu7D/o2i25Rf8QmCjPoNAIYCJNzU
         kjos6KdzO+vKW6rYTMUEG592GFbjUkYa/Aj4OIjaXQserr9K1pYW2zKcDD09lrQEep6f
         mE/smCtmbAuHXhAAK4fWLXwhU5SUUS2n6wMiJNiwqH+GOXPnhvE7qPypd7kho6GnR7Kh
         p4t2Fta0BbKWpZLEZC97gnDg5SA3d4t1toqYuVPOtN4CWrLl/3N3RTcJD49gE+5nzFVQ
         GDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=SGsil05SR5HyEHxBqow0AuD9rbhVsw4TLPg5c/VcqZw=;
        b=PHhdp15hCK8sTMNkI55x4XivqM+aJS5Nl2u8tImIphqw+jmf/YoJ8VO4uAnliD61RI
         DHrW45rkmBuTP49KT3fWRp9iI0gQJqoX5SGCrtSul2EY1Obtf2K7hxxG6dW46l7/OQFQ
         e5sJgraubhgQ1b34T8W6+COgkohyAYXVK+AagTfVf6qo5u/Jwc5NsppLtI5dlx3lGJz/
         Jps8A3mnMvUGZZZd5LsFxtNe72I3gsVvgDG1RMV8qhmYiAfwF+lTQkwShZozbEc1p+zK
         i/oD/bhoGuDnXPzhtPR6J5aueA+Gb+Wa6ILrZwXYU+2WaNOKQT8Sru7J8mxWcVuPw/bt
         7Cqg==
X-Gm-Message-State: AOAM531idtrm2DDwtqYlyDONslOmSOhBkqmJh/1lbep2V08wQa6j7Msr
        F1E4ag7SEgm1ayW5yQILk/tN4yJM
X-Google-Smtp-Source: ABdhPJzVq4HvLVbJYAQwSYBN3oupkDPxJd6rUakldO2GKLKLUH1qFjyqP0I3SNTAqkHNBYz1w6ygHQ==
X-Received: by 2002:a5e:dd0a:: with SMTP id t10mr28365436iop.9.1592227268829;
        Mon, 15 Jun 2020 06:21:08 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id p11sm7971935ioo.26.2020.06.15.06.21.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 06:21:08 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05FDL7k2018441;
        Mon, 15 Jun 2020 13:21:07 GMT
Subject: [PATCH v1 4/5] xprtrdma: Clean up disconnect
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:21:07 -0400
Message-ID: <20200615132107.11800.86974.stgit@manet.1015granger.net>
In-Reply-To: <20200615131642.11800.27486.stgit@manet.1015granger.net>
References: <20200615131642.11800.27486.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

1. Ensure that only rpcrdma_cm_event_handler() modifies
   ep->re_connect_status to avoid racy changes to that field.

2. Ensure that xprt_force_disconnect() is invoked only once as a
   transport is closed or destroyed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c     |   23 +++++++++++++----------
 net/sunrpc/xprtrdma/xprt_rdma.h |    1 +
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 7a112612fc8f..2198c8ec8dff 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -130,6 +130,16 @@ static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
 	trace_xprtrdma_qp_event(ep, event);
 }
 
+/* Ensure xprt_force_disconnect() is invoked exactly once when a
+ * connection is closed or lost. (The important thing is it needs
+ * to be invoked "at least" once).
+ */
+static void rpcrdma_force_disconnect(struct rpcrdma_ep *ep)
+{
+	if (atomic_add_unless(&ep->re_force_disconnect, 1, 1))
+		xprt_force_disconnect(ep->re_xprt);
+}
+
 /**
  * rpcrdma_flush_disconnect - Disconnect on flushed completion
  * @r_xprt: transport to disconnect
@@ -139,13 +149,8 @@ static void rpcrdma_qp_event_handler(struct ib_event *event, void *context)
  */
 void rpcrdma_flush_disconnect(struct rpcrdma_xprt *r_xprt, struct ib_wc *wc)
 {
-	struct rpc_xprt *xprt = &r_xprt->rx_xprt;
-
-	if (wc->status != IB_WC_SUCCESS &&
-	    r_xprt->rx_ep->re_connect_status == 1) {
-		r_xprt->rx_ep->re_connect_status = -ECONNABORTED;
-		xprt_force_disconnect(xprt);
-	}
+	if (wc->status != IB_WC_SUCCESS)
+		rpcrdma_force_disconnect(r_xprt->rx_ep);
 }
 
 /**
@@ -243,7 +248,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
 	struct sockaddr *sap = (struct sockaddr *)&id->route.addr.dst_addr;
 	struct rpcrdma_ep *ep = id->context;
-	struct rpc_xprt *xprt = ep->re_xprt;
 
 	might_sleep();
 
@@ -267,7 +271,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		/* fall through */
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		ep->re_connect_status = -ENODEV;
-		xprt_force_disconnect(xprt);
 		goto disconnected;
 	case RDMA_CM_EVENT_ESTABLISHED:
 		rpcrdma_ep_get(ep);
@@ -292,7 +295,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
 disconnected:
-		xprt_force_disconnect(xprt);
+		rpcrdma_force_disconnect(ep);
 		return rpcrdma_ep_put(ep);
 	default:
 		break;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 098d05a62ead..43974ef39a50 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -82,6 +82,7 @@ struct rpcrdma_ep {
 	unsigned int		re_max_inline_recv;
 	int			re_async_rc;
 	int			re_connect_status;
+	atomic_t		re_force_disconnect;
 	struct ib_qp_init_attr	re_attr;
 	wait_queue_head_t       re_connect_wait;
 	struct rpc_xprt		*re_xprt;

