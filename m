Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F78F31A700
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Feb 2021 22:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbhBLVlE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Feb 2021 16:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:34896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhBLVlC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Feb 2021 16:41:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF7F164E36;
        Fri, 12 Feb 2021 21:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613166022;
        bh=exsYu/68dA9Zxid1D6fArr06lhCg8qgT9TLFRPhyvnM=;
        h=From:To:Cc:Subject:Date:From;
        b=mG/F8vuvClD0o6B7LE4riuaHZUsTYYqbJZ68Xs5pkK1KArfs/KWpJtD4CViWxS7/P
         uIJFW1z8Ph3F8EjBNFVQo1Pbau6JwKbA7YjxaILEgNpQKZp8DToatSUlDFlBxKqsoT
         aQHqvQN8Pc8N+L2dvulkFWB3VPW7ewvfT4S4iB0ctA8QGG1YKjJJGKro/w86HKJ4rw
         V43hm1G8j8qymUr+8UBgVF1nXsyKikflf/s41BFwVGcXRNrWkVQ2TRDCle7bQwa4yP
         sHEnjOrxHa5YjgXmmReu9P1Vw0bsPogEAsgDvPd5yOhaBPbd61P6woFfZV8mxKkc2/
         V+sCGRuUZLTDw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Set TCP_CORK until the transmit queue is empty
Date:   Fri, 12 Feb 2021 16:40:20 -0500
Message-Id: <20210212214020.4140-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When we have multiple RPC requests queued up, it makes sense to set the
TCP_CORK option while the transmit queue is non-empty.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 include/linux/sunrpc/xprt.h | 1 +
 net/sunrpc/xprt.c           | 2 ++
 net/sunrpc/xprtsock.c       | 5 ++++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xprt.h b/include/linux/sunrpc/xprt.h
index d2e97ee802af..d81fe8b364d0 100644
--- a/include/linux/sunrpc/xprt.h
+++ b/include/linux/sunrpc/xprt.h
@@ -247,6 +247,7 @@ struct rpc_xprt {
 	struct rpc_task *	snd_task;	/* Task blocked in send */
 
 	struct list_head	xmit_queue;	/* Send queue */
+	atomic_long_t		xmit_queuelen;
 
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
 #if defined(CONFIG_SUNRPC_BACKCHANNEL)
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 691ccf8049a4..a853f75d4968 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1352,6 +1352,7 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 		list_add_tail(&req->rq_xmit, &xprt->xmit_queue);
 		INIT_LIST_HEAD(&req->rq_xmit2);
 out:
+		atomic_long_inc(&xprt->xmit_queuelen);
 		set_bit(RPC_TASK_NEED_XMIT, &task->tk_runstate);
 		spin_unlock(&xprt->queue_lock);
 	}
@@ -1381,6 +1382,7 @@ xprt_request_dequeue_transmit_locked(struct rpc_task *task)
 		}
 	} else
 		list_del(&req->rq_xmit2);
+	atomic_long_dec(&req->rq_xprt->xmit_queuelen);
 }
 
 /**
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c56a66cdf4ac..610b60b08438 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1018,6 +1018,7 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 	 * to cope with writespace callbacks arriving _after_ we have
 	 * called sendmsg(). */
 	req->rq_xtime = ktime_get();
+	tcp_sock_set_cork(transport->inet, true);
 	while (1) {
 		status = xprt_sock_sendmsg(transport->sock, &msg, xdr,
 					   transport->xmit.offset, rm, &sent);
@@ -1032,6 +1033,8 @@ static int xs_tcp_send_request(struct rpc_rqst *req)
 		if (likely(req->rq_bytes_sent >= msglen)) {
 			req->rq_xmit_bytes_sent += transport->xmit.offset;
 			transport->xmit.offset = 0;
+			if (atomic_long_read(&xprt->xmit_queuelen) == 1)
+				tcp_sock_set_cork(transport->inet, false);
 			return 0;
 		}
 
@@ -2176,7 +2179,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 		/* socket options */
 		sock_reset_flag(sk, SOCK_LINGER);
-		tcp_sk(sk)->nonagle |= TCP_NAGLE_OFF;
+		tcp_sock_set_nodelay(sk);
 
 		xprt_clear_connected(xprt);
 
-- 
2.29.2

