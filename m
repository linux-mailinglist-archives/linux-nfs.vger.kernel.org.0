Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 665746CDDE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbfGRMLe (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 08:11:34 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:32805 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbfGRMLe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 08:11:34 -0400
Received: by mail-io1-f67.google.com with SMTP id z3so51080741iog.0
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 05:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM+mLKzgLRn+iq29l6dOVe/Yj8+vEvBU79Z3j7UysQ0=;
        b=HKsJQGkNkDAxZxGnVsYKx5WTsCOipTWszaBJ0ph+VfQcMjD3jBgVJ803jYwQnO9+Sq
         0FnkZ1r0MUDLvDW2iDxHdAaiq6A2rUxWFtjB5vUXlYe7rBHezuKjJSh0K1q4jyfIRjGs
         pDxnqba2kJZjHQNP9y2jbxRJ+9IjgsoRMhTBM+4PU9O48H2NjasF7go25YNtgf6RDQDv
         ZOxuakZdYGffK77sKcjoTvsAy33781z3P3COkI5Ck8OOyIzV5nmiGRdxw+u+5ijj0ivH
         9XL0X1ZsME3t1QqAiSqHAxdhCagrFeT2UYgPDbu/ugJwtsGIl7FyHkBVhroc0yBpc/CY
         pnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HM+mLKzgLRn+iq29l6dOVe/Yj8+vEvBU79Z3j7UysQ0=;
        b=owNckEAaQ3JsSMfe96zEm9I7HRIB3MO1pMcRpcJvQva1y+ahx/fo11Wybysqw7zfnB
         8rLwXJrxYwgdMxbNwcofREg09gR7Qv+WZbVCeyEN/k27WlYXTM6fZQbLXtv5GRtjOGc0
         Sh8aKJcxLnyeJi9HK6+sEnjZeCHLH1GyjJwnPAuwmHQeSIvD5Zrl/2cvnFZdzFV7KGgF
         zsrmInnpPr+4zNx0PIen71R3ZAiQdIOpPhlyhp9LdH1WHAzsfI7pUFzth1CedZXhPiga
         v6lu4+JR0gNT2HGGvRVU2tM055xhUg6v31b2Emn9E5KJmq/BLMlHDdcwfJGicj/+2lJF
         6lBw==
X-Gm-Message-State: APjAAAXwA+ccvjGet02SU48nz3obF8gjddJ99exOtiCMfD7BVrQSONfW
        5iB1efsNYIwW0Irc30045DFOqN4=
X-Google-Smtp-Source: APXvYqyA9e3Gp5PsYGnDFkrKBZVmFeN7Mb3pyLJWjt5QqaALCzjGd8tD1EehCu6RoUCz5VMJZvLbyw==
X-Received: by 2002:a02:54c1:: with SMTP id t184mr15644842jaa.10.1563451892960;
        Thu, 18 Jul 2019 05:11:32 -0700 (PDT)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id i3sm23406741ion.9.2019.07.18.05.11.31
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 05:11:31 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Ensure the bvecs are reset when we re-encode the RPC request
Date:   Thu, 18 Jul 2019 08:08:02 -0400
Message-Id: <20190718120804.108146-1-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The bvec tracks the list of pages, so if the number of pages changes
due to a re-encode, we need to reset the bvec as well.

Fixes: 277e4ab7d530 ("SUNRPC: Simplify TCP receive code by switching...")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: stable@vger.kernel.org # v4.20+
---
 net/sunrpc/clnt.c     | 3 +--
 net/sunrpc/xprt.c     | 2 ++
 net/sunrpc/xprtsock.c | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 79c849391cb9..d8679b6027e9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1865,6 +1865,7 @@ rpc_xdr_encode(struct rpc_task *task)
 	req->rq_snd_buf.head[0].iov_len = 0;
 	xdr_init_encode(&xdr, &req->rq_snd_buf,
 			req->rq_snd_buf.head[0].iov_base, req);
+	xdr_free_bvec(&req->rq_snd_buf);
 	if (rpc_encode_header(task, &xdr))
 		return;
 
@@ -1904,8 +1905,6 @@ call_encode(struct rpc_task *task)
 			rpc_call_rpcerror(task, task->tk_status);
 		}
 		return;
-	} else {
-		xprt_request_prepare(task->tk_rqstp);
 	}
 
 	/* Add task to reply queue before transmission to avoid races */
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 70a704c44c6d..783748dc5e6f 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1041,6 +1041,8 @@ xprt_request_enqueue_receive(struct rpc_task *task)
 
 	if (!xprt_request_need_enqueue_receive(task, req))
 		return;
+
+	xprt_request_prepare(task->tk_rqstp);
 	spin_lock(&xprt->queue_lock);
 
 	/* Update the softirq receive buffer */
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 6b1fca51028a..e2176c167a57 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -909,6 +909,7 @@ static int xs_nospace(struct rpc_rqst *req)
 static void
 xs_stream_prepare_request(struct rpc_rqst *req)
 {
+	xdr_free_bvec(&req->rq_rcv_buf);
 	req->rq_task->tk_status = xdr_alloc_bvec(&req->rq_rcv_buf, GFP_KERNEL);
 }
 
-- 
2.21.0

