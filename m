Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0442FADA79
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 15:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404956AbfIINwn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 09:52:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46236 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404954AbfIINwn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 09:52:43 -0400
Received: by mail-io1-f66.google.com with SMTP id d17so6896223ios.13
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 06:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocfZ5OwsTrlnGSnz6Lo/yeZCShsngwgHFOdgjRdDBN0=;
        b=qKFWFBSRpbc5Lua9hGMok+6P/DYrMQ0JlCkDmLHs/bcSj/hR2EKtm2dEMVVnt9Won0
         CPGZUH4pJXYr6be+2WtYRx1V5jPCBZ8AuPWBTUqpUnUlu4iRcDdhLq073ellxDFq2S5I
         OirO2YWJ2vnb/UAzmzLNDt2JMfplpUWMKp6g20KcDWrGFYSgD+QP1G3DvDzRfrlcK6RF
         bBDhZ3705Bw3YQ3/RR++FZRmmzBahCXFYmhrPyl/KEWqqU0vILoinzhLgXIzLA17Fc8E
         nExF2iFc83KvozWMlshNiFcxmhEApqxr0bEN2RVqyMTibkbFcQ8CcaafWB4AkCBfhHl6
         0HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocfZ5OwsTrlnGSnz6Lo/yeZCShsngwgHFOdgjRdDBN0=;
        b=BhzzBLxjtPR+i3r/29tEti8o6nxt1ETx7S4dWVAe8GFZKwYPXbOSzaxOjvS67BFQE0
         81Hm2B5jZXFPtVLhe6MXIvxvrOqsl1qDgLWzsEI90SBUdLrb5RwOcZIl7eFAXx87u3TP
         lxH5R1pZinmX3H3Q+xdEOylx2k8vFuhsZFL1y6sNmzatIYWsBJG6h4IR5Cy1EoBWWEbi
         9cY0ktNFnCynbs+u0RPHotnRjWrmnNAgCfkEomZW21Wnbc8c/ODwweNhYV+6tVml7L5h
         eGDwcDrhmh2vokY7N6ZBydvXblzlwKa0rELPtd5Mkxp43spK1SBT1idWPVxJsC3GmWHX
         /kHQ==
X-Gm-Message-State: APjAAAV6KmlUVh326P2Thea2NyeS8XxbICzcuEo8MMcAMaj2Vq7ayJ7f
        RisaAYy9UcA1YqrcsZkZAepSPDKOHw==
X-Google-Smtp-Source: APXvYqzZLSblZV7zml2Irj46R1QqjRWY0MP/dy7v/t0WZTO0YBMGQuaroBubu1R86rYLRjY9p5dO/g==
X-Received: by 2002:a6b:3b94:: with SMTP id i142mr26910902ioa.212.1568037161802;
        Mon, 09 Sep 2019 06:52:41 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id i20sm958308ioh.77.2019.09.09.06.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 06:52:41 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Dequeue the request from the receive queue while we're re-encoding
Date:   Mon,  9 Sep 2019 09:50:33 -0400
Message-Id: <20190909135033.77710-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ensure that we dequeue the request from the transport receive queue
while we're re-encoding to prevent issues like use-after-free when
we release the bvec.

Fixes: 7536908982047 ("SUNRPC: Ensure the bvecs are reset when we re-encode...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20+
---
 include/linux/sunrpc/xprt.h |  1 +
 net/sunrpc/clnt.c           |  2 ++
 net/sunrpc/xprt.c           | 54 +++++++++++++++++++++----------------
 3 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index 13e108bcc9eb..d783e15ba898 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -352,6 +352,7 @@ bool			xprt_prepare_transmit(struct rpc_task *task);
 void			xprt_request_enqueue_transmit(struct rpc_task *task);
 void			xprt_request_enqueue_receive(struct rpc_task *task);
 void			xprt_request_wait_receive(struct rpc_task *task);
+void			xprt_request_dequeue_xprt(struct rpc_task *task);
 bool			xprt_request_need_retransmit(struct rpc_task *task);
 void			xprt_transmit(struct rpc_task *task);
 void			xprt_end_transmit(struct rpc_task *task);
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a07b516e503a..9904ee635d07 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1881,6 +1881,8 @@ call_encode(struct rpc_task *task)
 	if (!rpc_task_need_encode(task))
 		goto out;
 	dprint_status(task);
+	/* Dequeue task from the receive queue while we're encoding */
+	xprt_request_dequeue_xprt(task);
 	/* Encode here so that rpcsec_gss can use correct sequence number. */
 	rpc_xdr_encode(task);
 	/* Did the encode result in an error condition? */
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 2e71f5455c6c..20631d64312c 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1323,6 +1323,36 @@ xprt_request_dequeue_transmit(struct rpc_task *task)
 	spin_unlock(&xprt->queue_lock);
 }
 
+/**
+ * xprt_request_dequeue_xprt - remove a task from the transmit+receive queue
+ * @task: pointer to rpc_task
+ *
+ * Remove a task from the transmit and receive queues, and ensure that
+ * it is not pinned by the receive work item.
+ */
+void
+xprt_request_dequeue_xprt(struct rpc_task *task)
+{
+	struct rpc_rqst	*req = task->tk_rqstp;
+	struct rpc_xprt *xprt = req->rq_xprt;
+
+	if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate) ||
+	    test_bit(RPC_TASK_NEED_RECV, &task->tk_runstate) ||
+	    xprt_is_pinned_rqst(req)) {
+		spin_lock(&xprt->queue_lock);
+		xprt_request_dequeue_transmit_locked(task);
+		xprt_request_dequeue_receive_locked(task);
+		while (xprt_is_pinned_rqst(req)) {
+			set_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
+			spin_unlock(&xprt->queue_lock);
+			xprt_wait_on_pinned_rqst(req);
+			spin_lock(&xprt->queue_lock);
+			clear_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
+		}
+		spin_unlock(&xprt->queue_lock);
+	}
+}
+
 /**
  * xprt_request_prepare - prepare an encoded request for transport
  * @req: pointer to rpc_rqst
@@ -1747,28 +1777,6 @@ void xprt_retry_reserve(struct rpc_task *task)
 	xprt_do_reserve(xprt, task);
 }
 
-static void
-xprt_request_dequeue_all(struct rpc_task *task, struct rpc_rqst *req)
-{
-	struct rpc_xprt *xprt = req->rq_xprt;
-
-	if (test_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate) ||
-	    test_bit(RPC_TASK_NEED_RECV, &task->tk_runstate) ||
-	    xprt_is_pinned_rqst(req)) {
-		spin_lock(&xprt->queue_lock);
-		xprt_request_dequeue_transmit_locked(task);
-		xprt_request_dequeue_receive_locked(task);
-		while (xprt_is_pinned_rqst(req)) {
-			set_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
-			spin_unlock(&xprt->queue_lock);
-			xprt_wait_on_pinned_rqst(req);
-			spin_lock(&xprt->queue_lock);
-			clear_bit(RPC_TASK_MSG_PIN_WAIT, &task->tk_runstate);
-		}
-		spin_unlock(&xprt->queue_lock);
-	}
-}
-
 /**
  * xprt_release - release an RPC request slot
  * @task: task which is finished with the slot
@@ -1788,7 +1796,7 @@ void xprt_release(struct rpc_task *task)
 	}
 
 	xprt = req->rq_xprt;
-	xprt_request_dequeue_all(task, req);
+	xprt_request_dequeue_xprt(task);
 	spin_lock(&xprt->transport_lock);
 	xprt->ops->release_xprt(xprt, task);
 	if (xprt->ops->release_request)
-- 
2.21.0

