Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E49ADA44
	for <lists+linux-nfs@lfdr.de>; Mon,  9 Sep 2019 15:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfIINs5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 9 Sep 2019 09:48:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:32797 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbfIINs5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 9 Sep 2019 09:48:57 -0400
Received: by mail-io1-f65.google.com with SMTP id m11so28825990ioo.0
        for <linux-nfs@vger.kernel.org>; Mon, 09 Sep 2019 06:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocfZ5OwsTrlnGSnz6Lo/yeZCShsngwgHFOdgjRdDBN0=;
        b=NT9RRfLHj/x3CCGQB8nURPOta8btuJKL9RrbESWgpJWLHLlA7qq7DncsOalFSfuuLA
         INbTChadI01wbAA3ck221x+8syKf0501wGixVP9pyjKZrry/YlRnzwDfBJDPyHzsbmFz
         T5E1qA5RW6QntOi8QUUIPgxLWUYfeuJLqXPvfJo7sN9fLKxkWOeQvm5A0oUvIS+C6ech
         esOq6+dB9wLBoefGOAt8zqrttemoUfwSgGQS5272hEDSAMBqU0yAi0VWDk9UkfS+qkJj
         UzN6hd5MyPwDpvr6HvOvMQ0ijRFJ/v3bfNTyfgOICdWTcXFw/7FNzQ2IHZpOjADDuZdU
         Bd4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ocfZ5OwsTrlnGSnz6Lo/yeZCShsngwgHFOdgjRdDBN0=;
        b=NPJ4ssG2AZqDYSOFxaKdmwkaXCrFiY3cJt+wTEPOvnWn8vuolYJ9AHAX3SQ0qeC1g9
         KiJOdksHIzT0AXjPwt/EK3q8aMVCkFxnMK7MIVcDRVQdLQdc+UHo6y2MGP/f8njCY36j
         wlqJpqDv24aoH9D8mKkN8h0NfmBowxE1fjNabl3fh5RsXQwqFi41W8I4tkliEqJDiEu/
         vkWE8f/K8lksaLptF9QJBUdh/qs6KTBY0+Y5XAIH3fppm4bJRm/jSbnOeCqEXD5uTKfh
         V95a2CCm3jVVDoXSLF3CqC16WNB0/tHVeVH4T87N0dJwfgXmbVe0EeoLonKeAL0XbQ4H
         bs1A==
X-Gm-Message-State: APjAAAUIaVwNMcd5u1NGsTFNcdakMNJOxrV5F1LDFBRY7m6Btx6h+w9W
        xiJMkwIyWgQmvNsDsp3ZPiWGGWQScQ==
X-Google-Smtp-Source: APXvYqx62bQNsAthUD0IkVQrUUjyvdvVSsrtrvoq2Lv9HiwRgl+lAQUIK2UrHZ3RCxH7iGi6F7uTtA==
X-Received: by 2002:a5e:da44:: with SMTP id o4mr12114484iop.80.1568036935895;
        Mon, 09 Sep 2019 06:48:55 -0700 (PDT)
Received: from localhost.localdomain (50-36-167-63.alma.mi.frontiernet.net. [50.36.167.63])
        by smtp.gmail.com with ESMTPSA id c4sm11356695ioa.76.2019.09.09.06.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 06:48:55 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumakerr@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Dequeue the request from the receive queue while we're re-encoding
Date:   Mon,  9 Sep 2019 09:46:47 -0400
Message-Id: <20190909134647.77523-1-trond.myklebust@hammerspace.com>
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

