Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3C73469EE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbhCWUhO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 16:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233389AbhCWUhK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 16:37:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87A93619BA;
        Tue, 23 Mar 2021 20:37:09 +0000 (UTC)
Subject: [PATCH 1 1/4] svcrdma: Add a "deferred close" helper
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Mar 2021 16:37:08 -0400
Message-ID: <161653182869.1499.13690697391581140635.stgit@klimt.1015granger.net>
In-Reply-To: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
References: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Refactor a bit of commonly used logic so that every site that wants
a close deferred to an nfsd thread does all the right things
(set_bit(XPT_CLOSE) then enqueue).

Also, once XPT_CLOSE is set on a transport, it is never cleared. If
XPT_CLOSE is already set, then the close is already being handled
and the enqueue can be skipped.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h          |    1 +
 net/sunrpc/svc_xprt.c                    |   14 ++++++++++++++
 net/sunrpc/svcsock.c                     |   15 ++++++---------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |    3 +--
 net/sunrpc/xprtrdma/svc_rdma_rw.c        |    5 ++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |   10 ++++------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    6 ++----
 7 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 92455e0d5244..34dacadfe517 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -143,6 +143,7 @@ struct	svc_xprt *svc_find_xprt(struct svc_serv *serv, const char *xcl_name,
 int	svc_xprt_names(struct svc_serv *serv, char *buf, const int buflen);
 void	svc_add_new_perm_xprt(struct svc_serv *serv, struct svc_xprt *xprt);
 void	svc_age_temp_xprts_now(struct svc_serv *, struct sockaddr *);
+void	svc_xprt_deferred_close(struct svc_xprt *xprt);
 
 static inline void svc_xprt_get(struct svc_xprt *xprt)
 {
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 3cdd71a8df1e..b134fc5f3b8d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -139,6 +139,20 @@ int svc_print_xprts(char *buf, int maxlen)
 	return len;
 }
 
+/**
+ * svc_xprt_deferred_close - Close a transport
+ * @xprt: transport instance
+ *
+ * Used in contexts that need to defer the work of shutting down
+ * the transport to an nfsd thread.
+ */
+void svc_xprt_deferred_close(struct svc_xprt *xprt)
+{
+	if (!test_and_set_bit(XPT_CLOSE, &xprt->xpt_flags))
+		svc_xprt_enqueue(xprt);
+}
+EXPORT_SYMBOL_GPL(svc_xprt_deferred_close);
+
 static void svc_xprt_free(struct kref *kref)
 {
 	struct svc_xprt *xprt =
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2e2f007dfc9f..22454b2df5be 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -728,10 +728,8 @@ static void svc_tcp_state_change(struct sock *sk)
 		rmb();
 		svsk->sk_ostate(sk);
 		trace_svcsock_tcp_state(&svsk->sk_xprt, svsk->sk_sock);
-		if (sk->sk_state != TCP_ESTABLISHED) {
-			set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
-			svc_xprt_enqueue(&svsk->sk_xprt);
-		}
+		if (sk->sk_state != TCP_ESTABLISHED)
+			svc_xprt_deferred_close(&svsk->sk_xprt);
 	}
 }
 
@@ -901,7 +899,7 @@ static ssize_t svc_tcp_read_marker(struct svc_sock *svsk,
 	net_notice_ratelimited("svc: %s %s RPC fragment too large: %d\n",
 			       __func__, svsk->sk_xprt.xpt_server->sv_name,
 			       svc_sock_reclen(svsk));
-	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
+	svc_xprt_deferred_close(&svsk->sk_xprt);
 err_short:
 	return -EAGAIN;
 }
@@ -1057,7 +1055,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	svsk->sk_datalen = 0;
 err_delete:
 	trace_svcsock_tcp_recv_err(&svsk->sk_xprt, len);
-	set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
+	svc_xprt_deferred_close(&svsk->sk_xprt);
 err_noclose:
 	return 0;	/* record not complete */
 }
@@ -1188,8 +1186,7 @@ static int svc_tcp_sendto(struct svc_rqst *rqstp)
 		  xprt->xpt_server->sv_name,
 		  (err < 0) ? "got error" : "sent",
 		  (err < 0) ? err : sent, xdr->len);
-	set_bit(XPT_CLOSE, &xprt->xpt_flags);
-	svc_xprt_enqueue(xprt);
+	svc_xprt_deferred_close(xprt);
 	atomic_dec(&svsk->sk_sendqlen);
 	mutex_unlock(&xprt->xpt_mutex);
 	return -EAGAIN;
@@ -1268,7 +1265,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		case TCP_ESTABLISHED:
 			break;
 		default:
-			set_bit(XPT_CLOSE, &svsk->sk_xprt.xpt_flags);
+			svc_xprt_deferred_close(&svsk->sk_xprt);
 		}
 	}
 }
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 2571188ef7f2..8d93d26e0318 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -367,8 +367,7 @@ static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 
 flushed:
 	svc_rdma_recv_ctxt_put(rdma, ctxt);
-	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
-	svc_xprt_enqueue(&rdma->sc_xprt);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 693d139a8633..d7054e3a8e33 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -250,7 +250,7 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	wake_up(&rdma->sc_send_wait);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS))
-		set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
+		svc_xprt_deferred_close(&rdma->sc_xprt);
 
 	svc_rdma_write_info_free(info);
 }
@@ -334,7 +334,6 @@ static void svc_rdma_wc_read_done(struct ib_cq *cq, struct ib_wc *wc)
 static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 {
 	struct svcxprt_rdma *rdma = cc->cc_rdma;
-	struct svc_xprt *xprt = &rdma->sc_xprt;
 	struct ib_send_wr *first_wr;
 	const struct ib_send_wr *bad_wr;
 	struct list_head *tmp;
@@ -373,7 +372,7 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 	} while (1);
 
 	trace_svcrdma_sq_post_err(rdma, ret);
-	set_bit(XPT_CLOSE, &xprt->xpt_flags);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 
 	/* If even one was posted, there will be a completion. */
 	if (bad_wr != first_wr)
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index e6fab5dd20d0..4471a0fcd3a3 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -285,10 +285,8 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
 
 	svc_rdma_send_ctxt_put(rdma, ctxt);
 
-	if (unlikely(wc->status != IB_WC_SUCCESS)) {
-		set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
-		svc_xprt_enqueue(&rdma->sc_xprt);
-	}
+	if (unlikely(wc->status != IB_WC_SUCCESS))
+		svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /**
@@ -334,7 +332,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	}
 
 	trace_svcrdma_sq_post_err(rdma, ret);
-	set_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 	wake_up(&rdma->sc_send_wait);
 	return ret;
 }
@@ -994,7 +992,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	svc_rdma_send_ctxt_put(rdma, sctxt);
  err0:
 	trace_svcrdma_send_err(rqstp, ret);
-	set_bit(XPT_CLOSE, &xprt->xpt_flags);
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 	return -ENOTCONN;
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index e629eacfedfc..3646216211c5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -119,8 +119,7 @@ static void qp_event_handler(struct ib_event *event, void *context)
 	case IB_EVENT_QP_ACCESS_ERR:
 	case IB_EVENT_DEVICE_FATAL:
 	default:
-		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		svc_xprt_enqueue(xprt);
+		svc_xprt_deferred_close(xprt);
 		break;
 	}
 }
@@ -286,8 +285,7 @@ static int svc_rdma_cma_handler(struct rdma_cm_id *cma_id,
 		break;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
-		set_bit(XPT_CLOSE, &xprt->xpt_flags);
-		svc_xprt_enqueue(xprt);
+		svc_xprt_deferred_close(xprt);
 		break;
 	default:
 		break;


