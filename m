Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F5D31BDFC
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Feb 2021 17:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhBOP5V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Feb 2021 10:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231947AbhBOPtj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 15 Feb 2021 10:49:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEECF64DA8;
        Mon, 15 Feb 2021 15:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613403471;
        bh=sBSEOLAnJ62Hx6hiipYHp/kHCqxkuFzCoexeJceJmjU=;
        h=From:To:Cc:Subject:Date:From;
        b=WjPuIG8rglUGX33h6UwbScOiSCvZmHWDOo29aCx8fEzJgLLG0Jg4tycrl/eJ+rGTC
         WNN9FzoMjNJNuH56/7tLLAURqKXwXociYWewdnKTr+slozGe1j82JI7tdeBRv20R0q
         kaRqMZT41zkhS9xB6VC2TLAt9UKETQhNn3EtctBT/eHSa/B7kXyVh9/oIpEoIcvAFj
         SjWN65FPNcioSIwEzXtn76nfB3n2IuWg1YXqjnSYhLn8lA92OSW4OX/c1TS6ZlnMib
         fckUJo9lUIIhZIF6oayey1U8W9yGHbi8utcVRZ2upZDNdCEA49//Uy20nYngJxJiZ5
         fwJDb6sSJuawA==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Set TCP_CORK until the transmit queue is empty
Date:   Mon, 15 Feb 2021 10:37:46 -0500
Message-Id: <20210215153746.6228-1-trondmy@kernel.org>
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
v2: Fix issue reported by Intel kernel test robot

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
index c56a66cdf4ac..1e0a20c64ebd 100644
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
 
@@ -2162,6 +2165,7 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 		}
 
 		xs_tcp_set_socket_timeouts(xprt, sock);
+		tcp_sock_set_nodelay(sk);
 
 		write_lock_bh(&sk->sk_callback_lock);
 
@@ -2176,7 +2180,6 @@ static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
 
 		/* socket options */
 		sock_reset_flag(sk, SOCK_LINGER);
-		tcp_sk(sk)->nonagle |= TCP_NAGLE_OFF;
 
 		xprt_clear_connected(xprt);
 
-- 
2.29.2

