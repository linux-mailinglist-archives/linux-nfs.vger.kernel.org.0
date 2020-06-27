Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4627A20C317
	for <lists+linux-nfs@lfdr.de>; Sat, 27 Jun 2020 18:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgF0QfM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 27 Jun 2020 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QfM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 27 Jun 2020 12:35:12 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F1C061794;
        Sat, 27 Jun 2020 09:35:12 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e13so11676778qkg.5;
        Sat, 27 Jun 2020 09:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=RUw34TT2rSwOKq3vM9E+XLzokUjgR20CFjUZD3sc9Fc=;
        b=mO3Ez2f5Ap/EL5DGjuHDBZmpv5YtmMQs7dkrchSG06WLT3PfqpT3miCSdXf/PyoNRj
         zppWCTbECpKWom7pggv/7O4G13EWt5V3a1xEtBqc+QTjZj99BgnkDKP02ak4E4/R4yd7
         tMVMLVD7/TNrwjutDTFGahYBcjOu5V5K4pwFjuA8QulAcSOhx02yJQNtCh9erJn/jK99
         yQIQpmnEUUPM3Q+yT5/irOvHTPbnXwd0qlEkYx2BdsiqpBIhdFGBHNPxFkBiV0w9B4qf
         yGri/cEt/+GrmmBjByt3tGLdvu1P0QK6rPt4cEXwK9f4mpHYThyInC2e3FSVBgO4Mr+Q
         okfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=RUw34TT2rSwOKq3vM9E+XLzokUjgR20CFjUZD3sc9Fc=;
        b=JETrUg9yifFrboSO3NeS86hWyY6V/1C14Q3FKzG65+bA9djseXF323isdjjFgFHvf1
         Y7y1KKjGn3lLCfCYUE3T9UMN2JZvrFpv8RYKN/nKow0N5rGd9Dz/2ZsbUSPr9I+PbMHp
         jss4LS1FyyEDZB50guvkSEQ2HVt2sZQYOsctcm9SkRaMHUuOXyfd+CvSBkkLeIuUL8mM
         P+G0G9gW1OdPtLSFyjRI0z+hkf0HN2BntnyFnLmXsEffydwYSnW5tGexDhFNrG8Qaqhm
         oqtS81SQAJ3p7tgTS+c6VxK18yNrwqfImuEVkpRw55ugdekNWYUt8uhNJj9xLJ5fZ4fe
         EkJA==
X-Gm-Message-State: AOAM531We9+Y6JRHcbnHQFtkwHCbR/SIZ30PWugeJ543TN8RdJ9zdJIN
        gw9FgN1ocIdchW7ri4rhKsE=
X-Google-Smtp-Source: ABdhPJwLi52XM1ZdJoOYcGT26RGrluigH/nGqa5dr5cx01Foi2QrhjwXcsPs269C195fVroT/If4+Q==
X-Received: by 2002:a37:62c6:: with SMTP id w189mr7880519qkb.67.1593275711323;
        Sat, 27 Jun 2020 09:35:11 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id e129sm11243842qkf.132.2020.06.27.09.35.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 09:35:10 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 05RGZ90c003761;
        Sat, 27 Jun 2020 16:35:09 GMT
Subject: [PATCH v1 2/4] xprtrdma: Fix recursion into
 rpcrdma_xprt_disconnect()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     dan@kernelim.com
Date:   Sat, 27 Jun 2020 12:35:09 -0400
Message-ID: <20200627163509.22826.24171.stgit@manet.1015granger.net>
In-Reply-To: <20200627162911.22826.34426.stgit@manet.1015granger.net>
References: <20200627162911.22826.34426.stgit@manet.1015granger.net>
User-Agent: StGit/0.22-38-gfb18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Both Dan and I have observed two processes invoking
rpcrdma_xprt_disconnect() concurrently. In my case:

1. The connect worker invokes rpcrdma_xprt_disconnect(), which
   drains the QP and waits for the final completion
2. This causes the newly posted Receive to flush and invoke
   xprt_force_disconnect()
3. xprt_force_disconnect() sets CLOSE_WAIT and wakes up the RPC task
   that is holding the transport lock
4. The RPC task invokes xprt_connect(), which calls ->ops->close
5. xprt_rdma_close() invokes rpcrdma_xprt_disconnect(), which tries
   to destroy the QP.

Deadlock.

To prevent xprt_force_disconnect() from waking anything, handle the
clean up after a failed connection attempt in the xprt's sndtask.

The retry loop is removed from rpcrdma_xprt_connect() to ensure
that the newly allocated ep and id are properly released before
a REJECTED connection attempt can be retried.

Reported-by: Dan Aloni <dan@kernelim.com>
Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/transport.c |    5 +++++
 net/sunrpc/xprtrdma/verbs.c     |   10 ++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 14165b673b20..053c8ab1265a 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -249,6 +249,11 @@ xprt_rdma_connect_worker(struct work_struct *work)
 					   xprt->stat.connect_start;
 		xprt_set_connected(xprt);
 		rc = -EAGAIN;
+	} else {
+		/* Force a call to xprt_rdma_close to clean up */
+		spin_lock(&xprt->transport_lock);
+		set_bit(XPRT_CLOSE_WAIT, &xprt->state);
+		spin_unlock(&xprt->transport_lock);
 	}
 	xprt_wake_pending_tasks(xprt, rc);
 }
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index e4c0df7c7d78..641a3ca0fc8f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -290,7 +290,7 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 			sap, rdma_reject_msg(id, event->status));
 		ep->re_connect_status = -ECONNREFUSED;
 		if (event->status == IB_CM_REJ_STALE_CONN)
-			ep->re_connect_status = -EAGAIN;
+			ep->re_connect_status = -ENOTCONN;
 		goto disconnected;
 	case RDMA_CM_EVENT_DISCONNECTED:
 		ep->re_connect_status = -ECONNABORTED;
@@ -521,8 +521,6 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	struct rpcrdma_ep *ep;
 	int rc;
 
-retry:
-	rpcrdma_xprt_disconnect(r_xprt);
 	rc = rpcrdma_ep_create(r_xprt);
 	if (rc)
 		return rc;
@@ -550,17 +548,13 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	wait_event_interruptible(ep->re_connect_wait,
 				 ep->re_connect_status != 0);
 	if (ep->re_connect_status <= 0) {
-		if (ep->re_connect_status == -EAGAIN)
-			goto retry;
 		rc = ep->re_connect_status;
 		goto out;
 	}
 
 	rc = rpcrdma_reqs_setup(r_xprt);
-	if (rc) {
-		rpcrdma_xprt_disconnect(r_xprt);
+	if (rc)
 		goto out;
-	}
 	rpcrdma_mrs_create(r_xprt);
 
 out:

