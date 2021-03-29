Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAB34D288
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbhC2OkO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 10:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230297AbhC2OkA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 10:40:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C37E861933;
        Mon, 29 Mar 2021 14:39:59 +0000 (UTC)
Subject: [PATCH v1 2/6] SUNRPC: Move svc_xprt_received() call sites
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Mar 2021 10:39:59 -0400
Message-ID: <161702879897.5937.2121487527673071137.stgit@klimt.1015granger.net>
In-Reply-To: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
References: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Currently, XPT_BUSY is not cleared until xpo_recvfrom returns.
That effectively blocks the receipt and handling of the next RPC
message until the current one has been taken off the transport.
This strict ordering is a requirement for socket transports.

For our kernel RPC/RDMA transport implementation, however, dequeuing
an ingress message is nothing more than a list_del(). The transport
can safely be marked un-busy as soon as that is done.

To keep the changes simpler, this patch just moves the
svc_xprt_received() call site from svc_handle_xprt() into the
transports, so that the actual optimization can be done in a
subsequent patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svc_xprt.c                   |    7 ++++---
 net/sunrpc/svcsock.c                    |    9 +++++++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    6 ++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 9d1374e82e90..42565f0c7d5a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -820,8 +820,10 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			newxpt->xpt_cred = get_cred(xprt->xpt_cred);
 			svc_add_new_temp_xprt(serv, newxpt);
 			trace_svc_xprt_accept(newxpt, serv->sv_name);
-		} else
+		} else {
 			module_put(xprt->xpt_class->xcl_owner);
+		}
+		svc_xprt_received(xprt);
 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
 		/* XPT_DATA|XPT_DEFERRED case: */
 		dprintk("svc: server %p, pool %u, transport %p, inuse=%d\n",
@@ -836,8 +838,6 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		rqstp->rq_reserved = serv->sv_max_mesg;
 		atomic_add(rqstp->rq_reserved, &xprt->xpt_reserved);
 	}
-	/* clear XPT_BUSY: */
-	svc_xprt_received(xprt);
 out:
 	trace_svc_handle_xprt(xprt, len);
 	return len;
@@ -1248,6 +1248,7 @@ static noinline int svc_deferred_recv(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_hlen   = dr->xprt_hlen;
 	rqstp->rq_daddr       = dr->daddr;
 	rqstp->rq_respages    = rqstp->rq_pages;
+	svc_xprt_received(rqstp->rq_xprt);
 	return (dr->argslen<<2) - dr->xprt_hlen;
 }
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 22454b2df5be..9eb5b6b89077 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -519,6 +519,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	if (serv->sv_stats)
 		serv->sv_stats->netudpcnt++;
 
+	svc_xprt_received(rqstp->rq_xprt);
 	return len;
 
 out_recv_err:
@@ -527,7 +528,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 		set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	}
 	trace_svcsock_udp_recv_err(&svsk->sk_xprt, err);
-	return 0;
+	goto out_clear_busy;
 out_cmsg_err:
 	net_warn_ratelimited("svc: received unknown control message %d/%d; dropping RPC reply datagram\n",
 			     cmh->cmsg_level, cmh->cmsg_type);
@@ -536,6 +537,8 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	local_bh_enable();
 out_free:
 	kfree_skb(skb);
+out_clear_busy:
+	svc_xprt_received(rqstp->rq_xprt);
 	return 0;
 }
 
@@ -1033,6 +1036,7 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	if (serv->sv_stats)
 		serv->sv_stats->nettcpcnt++;
 
+	svc_xprt_received(rqstp->rq_xprt);
 	return rqstp->rq_arg.len;
 
 err_incomplete:
@@ -1050,13 +1054,14 @@ static int svc_tcp_recvfrom(struct svc_rqst *rqstp)
 	if (len != -EAGAIN)
 		goto err_delete;
 	trace_svcsock_tcp_recv_eagain(&svsk->sk_xprt, 0);
-	return 0;
+	goto err_noclose;
 err_nuts:
 	svsk->sk_datalen = 0;
 err_delete:
 	trace_svcsock_tcp_recv_err(&svsk->sk_xprt, len);
 	svc_xprt_deferred_close(&svsk->sk_xprt);
 err_noclose:
+	svc_xprt_received(rqstp->rq_xprt);
 	return 0;	/* record not complete */
 }
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 8d93d26e0318..9cb5a09c4a01 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -846,6 +846,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 		/* No new incoming requests, terminate the loop */
 		clear_bit(XPT_DATA, &xprt->xpt_flags);
 		spin_unlock(&rdma_xprt->sc_rq_dto_lock);
+		svc_xprt_received(xprt);
 		return 0;
 	}
 	list_del(&ctxt->rc_list);
@@ -883,28 +884,33 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
+	svc_xprt_received(xprt);
 	return rqstp->rq_arg.len;
 
 out_readlist:
 	ret = svc_rdma_process_read_list(rdma_xprt, rqstp, ctxt);
 	if (ret < 0)
 		goto out_readfail;
+	svc_xprt_received(xprt);
 	return 0;
 
 out_err:
 	svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
+	svc_xprt_received(xprt);
 	return 0;
 
 out_readfail:
 	if (ret == -EINVAL)
 		svc_rdma_send_error(rdma_xprt, ctxt, ret);
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
+	svc_xprt_received(xprt);
 	return ret;
 
 out_backchannel:
 	svc_rdma_handle_bc_reply(rqstp, ctxt);
 out_drop:
 	svc_rdma_recv_ctxt_put(rdma_xprt, ctxt);
+	svc_xprt_received(xprt);
 	return 0;
 }


