Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC2E12C3F
	for <lists+linux-nfs@lfdr.de>; Fri,  3 May 2019 13:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfECLWl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 May 2019 07:22:41 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39762 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfECLWk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 May 2019 07:22:40 -0400
Received: by mail-it1-f193.google.com with SMTP id t200so8448172itf.4
        for <linux-nfs@vger.kernel.org>; Fri, 03 May 2019 04:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Foa/rdW5oWVTMtltKa1BAoJvs1d8yn6Dzy0JCVZ/STc=;
        b=rgDW3KEBvrnfzwDqQQ6agRKWMlN3KupkyMmBS5gz1zhaqBpSHpnHFS9M8NwbfGFvSP
         9zCkyFXR6Edn1jO5s9ISCdV4Laua/Cl7pZ2xjyYt729s+veU/53Gzlo78Kw0JLVEmkXu
         NLdhp0W9+uaS0x00D47CVLwePxblm8qcSK4FUsAJVatyJ7RPHmg9aXJqavYBZVgjI4VX
         aN7PSVngcEtyvUR5w2s9/F+OgGxHo22XQwMWkpz7mcDv8aptpfj1Knclzik5wOFQ/EXF
         OvK+nJnVmmC8QY0EATZFBesXmxxdXo/YWCfKmximWW9l+mnPAlhh8hTIv1Y1tXLLNOKO
         yMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Foa/rdW5oWVTMtltKa1BAoJvs1d8yn6Dzy0JCVZ/STc=;
        b=lOZ0DNTY709SDXfwDcV+JlaDGPhyaegMCiTcBEaHMYTIReaQUWrXBvobsnTQ/ckHWv
         nyRJzGx/I2Ek7wdH2g+FGqU/vC7jtsv2NhlGI8z1N5hhEOobloMTITGCGi9kJX92YIlL
         xZDlwfZetezAQRBPpJfP4elrTsk+oeM1FxBTq89hCOYhQOXG21vClgGiUds1QkU3ibX3
         9T6NBV3TWniMhJr4GXKVQ1MbfsrsNOOx8+oXHTWUVpUV6eDX/JQJDE8CPaI+GBP8Wyco
         +/E+vip5yia6gfuO5okjMLfWCyfhZnVJED/dw7T/UP6Lgd/+j0x2vyAxf+96EAIuGPE6
         jP4A==
X-Gm-Message-State: APjAAAXh8eklL7MJyOjmBT/aa+YIy+mPTu8T4pXzuurxuX3tQUoXJDRm
        8FpOUMEvxP/IHx94W9Dlybo+L4RGyw==
X-Google-Smtp-Source: APXvYqz6leZ8fkw1cLPU0Cg5wleTE+IbFkdFcvACDhiR/EB64Fdf9E5wo/diqrvwGQFcvFWJEIZtwg==
X-Received: by 2002:a24:c2c1:: with SMTP id i184mr6380206itg.82.1556882559363;
        Fri, 03 May 2019 04:22:39 -0700 (PDT)
Received: from localhost.localdomain ([8.46.76.65])
        by smtp.gmail.com with ESMTPSA id d193sm737325iog.34.2019.05.03.04.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 04:22:38 -0700 (PDT)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [RFC PATCH 3/5] SUNRPC: Remove the bh-safe lock requirement on xprt->transport_lock
Date:   Fri,  3 May 2019 06:18:39 -0500
Message-Id: <20190503111841.4391-4-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190503111841.4391-3-trond.myklebust@hammerspace.com>
References: <20190503111841.4391-1-trond.myklebust@hammerspace.com>
 <20190503111841.4391-2-trond.myklebust@hammerspace.com>
 <20190503111841.4391-3-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/xprt.c                          | 61 ++++++++++------------
 net/sunrpc/xprtrdma/rpc_rdma.c             |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  8 +--
 net/sunrpc/xprtsock.c                      | 23 ++++----
 5 files changed, 47 insertions(+), 53 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index bc1c8247750d..b87d185cf010 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -301,9 +301,9 @@ static inline int xprt_lock_write(struct rpc_xprt *xprt, struct rpc_task *task)
 
 	if (test_bit(XPRT_LOCKED, &xprt->state) && xprt->snd_task == task)
 		return 1;
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	retval = xprt->ops->reserve_xprt(xprt, task);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	return retval;
 }
 
@@ -380,9 +380,9 @@ static inline void xprt_release_write(struct rpc_xprt *xprt, struct rpc_task *ta
 {
 	if (xprt->snd_task != task)
 		return;
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	xprt->ops->release_xprt(xprt, task);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 }
 
 /*
@@ -434,9 +434,9 @@ xprt_request_get_cong(struct rpc_xprt *xprt, struct rpc_rqst *req)
 
 	if (req->rq_cong)
 		return true;
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	ret = __xprt_get_cong(xprt, req) != 0;
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xprt_request_get_cong);
@@ -463,9 +463,9 @@ static void
 xprt_clear_congestion_window_wait(struct rpc_xprt *xprt)
 {
 	if (test_and_clear_bit(XPRT_CWND_WAIT, &xprt->state)) {
-		spin_lock_bh(&xprt->transport_lock);
+		spin_lock(&xprt->transport_lock);
 		__xprt_lock_write_next_cong(xprt);
-		spin_unlock_bh(&xprt->transport_lock);
+		spin_unlock(&xprt->transport_lock);
 	}
 }
 
@@ -562,9 +562,9 @@ bool xprt_write_space(struct rpc_xprt *xprt)
 
 	if (!test_bit(XPRT_WRITE_SPACE, &xprt->state))
 		return false;
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	ret = xprt_clear_write_space_locked(xprt);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(xprt_write_space);
@@ -633,9 +633,9 @@ int xprt_adjust_timeout(struct rpc_rqst *req)
 		req->rq_retries = 0;
 		xprt_reset_majortimeo(req);
 		/* Reset the RTT counters == "slow start" */
-		spin_lock_bh(&xprt->transport_lock);
+		spin_lock(&xprt->transport_lock);
 		rpc_init_rtt(req->rq_task->tk_client->cl_rtt, to->to_initval);
-		spin_unlock_bh(&xprt->transport_lock);
+		spin_unlock(&xprt->transport_lock);
 		status = -ETIMEDOUT;
 	}
 
@@ -667,11 +667,11 @@ static void xprt_autoclose(struct work_struct *work)
 void xprt_disconnect_done(struct rpc_xprt *xprt)
 {
 	dprintk("RPC:       disconnected transport %p\n", xprt);
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	xprt_clear_connected(xprt);
 	xprt_clear_write_space_locked(xprt);
 	xprt_wake_pending_tasks(xprt, -ENOTCONN);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 }
 EXPORT_SYMBOL_GPL(xprt_disconnect_done);
 
@@ -683,7 +683,7 @@ EXPORT_SYMBOL_GPL(xprt_disconnect_done);
 void xprt_force_disconnect(struct rpc_xprt *xprt)
 {
 	/* Don't race with the test_bit() in xprt_clear_locked() */
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	set_bit(XPRT_CLOSE_WAIT, &xprt->state);
 	/* Try to schedule an autoclose RPC call */
 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state) == 0)
@@ -691,7 +691,7 @@ void xprt_force_disconnect(struct rpc_xprt *xprt)
 	else if (xprt->snd_task)
 		rpc_wake_up_queued_task_set_status(&xprt->pending,
 				xprt->snd_task, -ENOTCONN);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 }
 EXPORT_SYMBOL_GPL(xprt_force_disconnect);
 
@@ -725,7 +725,7 @@ xprt_request_retransmit_after_disconnect(struct rpc_task *task)
 void xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie)
 {
 	/* Don't race with the test_bit() in xprt_clear_locked() */
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	if (cookie != xprt->connect_cookie)
 		goto out;
 	if (test_bit(XPRT_CLOSING, &xprt->state))
@@ -736,7 +736,7 @@ void xprt_conditional_disconnect(struct rpc_xprt *xprt, unsigned int cookie)
 		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
 	xprt_wake_pending_tasks(xprt, -EAGAIN);
 out:
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 }
 
 static bool
@@ -758,18 +758,13 @@ xprt_init_autodisconnect(struct timer_list *t)
 {
 	struct rpc_xprt *xprt = from_timer(xprt, t, timer);
 
-	spin_lock(&xprt->transport_lock);
 	if (!RB_EMPTY_ROOT(&xprt->recv_queue))
-		goto out_abort;
+		return;
 	/* Reset xprt->last_used to avoid connect/autodisconnect cycling */
 	xprt->last_used = jiffies;
 	if (test_and_set_bit(XPRT_LOCKED, &xprt->state))
-		goto out_abort;
-	spin_unlock(&xprt->transport_lock);
+		return;
 	queue_work(xprtiod_workqueue, &xprt->task_cleanup);
-	return;
-out_abort:
-	spin_unlock(&xprt->transport_lock);
 }
 
 bool xprt_lock_connect(struct rpc_xprt *xprt,
@@ -778,7 +773,7 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
 {
 	bool ret = false;
 
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	if (!test_bit(XPRT_LOCKED, &xprt->state))
 		goto out;
 	if (xprt->snd_task != task)
@@ -786,13 +781,13 @@ bool xprt_lock_connect(struct rpc_xprt *xprt,
 	xprt->snd_task = cookie;
 	ret = true;
 out:
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	return ret;
 }
 
 void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 {
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	if (xprt->snd_task != cookie)
 		goto out;
 	if (!test_bit(XPRT_LOCKED, &xprt->state))
@@ -801,7 +796,7 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 	xprt->ops->release_xprt(xprt, NULL);
 	xprt_schedule_autodisconnect(xprt);
 out:
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	wake_up_bit(&xprt->state, XPRT_LOCKED);
 }
 
@@ -1411,14 +1406,14 @@ xprt_request_transmit(struct rpc_rqst *req, struct rpc_task *snd_task)
 	xprt_inject_disconnect(xprt);
 
 	task->tk_flags |= RPC_TASK_SENT;
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 
 	xprt->stat.sends++;
 	xprt->stat.req_u += xprt->stat.sends - xprt->stat.recvs;
 	xprt->stat.bklog_u += xprt->backlog.qlen;
 	xprt->stat.sending_u += xprt->sending.qlen;
 	xprt->stat.pending_u += xprt->pending.qlen;
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 
 	req->rq_connect_cookie = connect_cookie;
 out_dequeue:
@@ -1769,13 +1764,13 @@ void xprt_release(struct rpc_task *task)
 	else if (task->tk_client)
 		rpc_count_iostats(task, task->tk_client->cl_metrics);
 	xprt_request_dequeue_all(task, req);
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	xprt->ops->release_xprt(xprt, task);
 	if (xprt->ops->release_request)
 		xprt->ops->release_request(task);
 	xprt->last_used = jiffies;
 	xprt_schedule_autodisconnect(xprt);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	if (req->rq_buffer)
 		xprt->ops->buf_free(task);
 	xprt_inject_disconnect(xprt);
diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 6c1fb270f127..26419be782d0 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1359,10 +1359,10 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 	else if (credits > buf->rb_max_requests)
 		credits = buf->rb_max_requests;
 	if (buf->rb_credits != credits) {
-		spin_lock_bh(&xprt->transport_lock);
+		spin_lock(&xprt->transport_lock);
 		buf->rb_credits = credits;
 		xprt->cwnd = credits << RPC_CWNDSHIFT;
-		spin_unlock_bh(&xprt->transport_lock);
+		spin_unlock(&xprt->transport_lock);
 	}
 
 	req = rpcr_to_rdmar(rqst);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index bed57d8b5c19..d1fcc41d5eb5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -72,9 +72,9 @@ int svc_rdma_handle_bc_reply(struct rpc_xprt *xprt, __be32 *rdma_resp,
 	else if (credits > r_xprt->rx_buf.rb_bc_max_requests)
 		credits = r_xprt->rx_buf.rb_bc_max_requests;
 
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	xprt->cwnd = credits << RPC_CWNDSHIFT;
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 
 	spin_lock(&xprt->queue_lock);
 	ret = 0;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 027a3b07d329..18ffc6190ea9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -221,9 +221,9 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 	 * Enqueue the new transport on the accept queue of the listening
 	 * transport
 	 */
-	spin_lock_bh(&listen_xprt->sc_lock);
+	spin_lock(&listen_xprt->sc_lock);
 	list_add_tail(&newxprt->sc_accept_q, &listen_xprt->sc_accept_q);
-	spin_unlock_bh(&listen_xprt->sc_lock);
+	spin_unlock(&listen_xprt->sc_lock);
 
 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
@@ -396,7 +396,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	listen_rdma = container_of(xprt, struct svcxprt_rdma, sc_xprt);
 	clear_bit(XPT_CONN, &xprt->xpt_flags);
 	/* Get the next entry off the accept list */
-	spin_lock_bh(&listen_rdma->sc_lock);
+	spin_lock(&listen_rdma->sc_lock);
 	if (!list_empty(&listen_rdma->sc_accept_q)) {
 		newxprt = list_entry(listen_rdma->sc_accept_q.next,
 				     struct svcxprt_rdma, sc_accept_q);
@@ -404,7 +404,7 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	}
 	if (!list_empty(&listen_rdma->sc_accept_q))
 		set_bit(XPT_CONN, &listen_rdma->sc_xprt.xpt_flags);
-	spin_unlock_bh(&listen_rdma->sc_lock);
+	spin_unlock(&listen_rdma->sc_lock);
 	if (!newxprt)
 		return NULL;
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e0195b1a0c18..d7b8e95a61c8 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -880,7 +880,7 @@ static int xs_nospace(struct rpc_rqst *req)
 			req->rq_slen);
 
 	/* Protect against races with write_space */
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 
 	/* Don't race with disconnect */
 	if (xprt_connected(xprt)) {
@@ -890,7 +890,7 @@ static int xs_nospace(struct rpc_rqst *req)
 	} else
 		ret = -ENOTCONN;
 
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 
 	/* Race breaker in case memory is freed before above code is called */
 	if (ret == -EAGAIN) {
@@ -1344,6 +1344,7 @@ static void xs_destroy(struct rpc_xprt *xprt)
 	cancel_delayed_work_sync(&transport->connect_worker);
 	xs_close(xprt);
 	cancel_work_sync(&transport->recv_worker);
+	cancel_work_sync(&transport->error_worker);
 	xs_xprt_free(xprt);
 	module_put(THIS_MODULE);
 }
@@ -1397,9 +1398,9 @@ static void xs_udp_data_read_skb(struct rpc_xprt *xprt,
 	}
 
 
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	xprt_adjust_cwnd(xprt, task, copied);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 	spin_lock(&xprt->queue_lock);
 	xprt_complete_rqst(task, copied);
 	__UDPX_INC_STATS(sk, UDP_MIB_INDATAGRAMS);
@@ -1509,7 +1510,6 @@ static void xs_tcp_state_change(struct sock *sk)
 	trace_rpc_socket_state_change(xprt, sk->sk_socket);
 	switch (sk->sk_state) {
 	case TCP_ESTABLISHED:
-		spin_lock(&xprt->transport_lock);
 		if (!xprt_test_and_set_connected(xprt)) {
 			xprt->connect_cookie++;
 			clear_bit(XPRT_SOCK_CONNECTING, &transport->sock_state);
@@ -1520,7 +1520,6 @@ static void xs_tcp_state_change(struct sock *sk)
 						   xprt->stat.connect_start;
 			xs_run_error_worker(transport, XPRT_SOCK_WAKE_PENDING);
 		}
-		spin_unlock(&xprt->transport_lock);
 		break;
 	case TCP_FIN_WAIT1:
 		/* The client initiated a shutdown of the socket */
@@ -1677,9 +1676,9 @@ static void xs_udp_set_buffer_size(struct rpc_xprt *xprt, size_t sndsize, size_t
  */
 static void xs_udp_timer(struct rpc_xprt *xprt, struct rpc_task *task)
 {
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	xprt_adjust_cwnd(xprt, task, -ETIMEDOUT);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 }
 
 static int xs_get_random_port(void)
@@ -2214,13 +2213,13 @@ static void xs_tcp_set_socket_timeouts(struct rpc_xprt *xprt,
 	unsigned int opt_on = 1;
 	unsigned int timeo;
 
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	keepidle = DIV_ROUND_UP(xprt->timeout->to_initval, HZ);
 	keepcnt = xprt->timeout->to_retries + 1;
 	timeo = jiffies_to_msecs(xprt->timeout->to_initval) *
 		(xprt->timeout->to_retries + 1);
 	clear_bit(XPRT_SOCK_UPD_TIMEOUT, &transport->sock_state);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 
 	/* TCP Keepalive options */
 	kernel_setsockopt(sock, SOL_SOCKET, SO_KEEPALIVE,
@@ -2245,7 +2244,7 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 	struct rpc_timeout to;
 	unsigned long initval;
 
-	spin_lock_bh(&xprt->transport_lock);
+	spin_lock(&xprt->transport_lock);
 	if (reconnect_timeout < xprt->max_reconnect_timeout)
 		xprt->max_reconnect_timeout = reconnect_timeout;
 	if (connect_timeout < xprt->connect_timeout) {
@@ -2262,7 +2261,7 @@ static void xs_tcp_set_connect_timeout(struct rpc_xprt *xprt,
 		xprt->connect_timeout = connect_timeout;
 	}
 	set_bit(XPRT_SOCK_UPD_TIMEOUT, &transport->sock_state);
-	spin_unlock_bh(&xprt->transport_lock);
+	spin_unlock(&xprt->transport_lock);
 }
 
 static int xs_tcp_finish_connecting(struct rpc_xprt *xprt, struct socket *sock)
-- 
2.21.0

