Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDD1DCFE7
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2020 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgEUOfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 May 2020 10:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgEUOfA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 May 2020 10:35:00 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF08C061A0E;
        Thu, 21 May 2020 07:34:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id 4so7308465ilg.1;
        Thu, 21 May 2020 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=naFN0o6bDHNF8CmTkqitirTzkLhYyHiZdARmOi27zX8=;
        b=iFIJ4UwLRMSDGd0i3yo9Tv5sJZVDfAbE1078F1EtP82y4GK/DQx5xj6NGrkGLjcMoD
         yXb9yEvr73mQ+p+7exe8+8tZRdO/erJX1u7wN+wH32FMgzDNaYprJ3VvFdxu/CfNNwAl
         7tdSh1jBQVJMnra8byJ4h5yBIQ7Tlz6YussyD0X+QpbeH5uI0HjQ0vG8CLoi0P0cct9M
         pVgcvbtnvVpWAuTkrHCyPT0HGkgpKwvn5v6oIN3/6A6tx7iDlj3wYO5RMTt1S4tTBXtA
         LKsDJ+axsleZMgvSHorfGFehepiNzfDQhAat+L2bOAHj7TXxdmNcad+jMGwzI0lD23JO
         040Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=naFN0o6bDHNF8CmTkqitirTzkLhYyHiZdARmOi27zX8=;
        b=cKSdlpio78ZEWW7rQfpPcu/gAm0UBBqVMWaCdOk0odpLA9VVgHLldK+zGeg3HoPN5I
         wEMBon8OJVtx3CggjgIPJ3rp/kUGApbV00LJIfMfF6sS11+YuAOdK2CIE5ng/Y4jJlNo
         xUQlZsEDh/nvOHahI317lk8ToBzPynvepiTE9COF9xb+9OqBYzY6/vDvBvrx3E+avlOJ
         IOJtznvCiukU3h8IVGpxIhWVeISkMENq66xu1hX3vzOrQ9cvQnGgV0l29n7Vu8fIiNJW
         bZpZEC3gUPapno55nQNb4u2SbC+2KykZYd8g+V0sA7K5Xe0PZH4/PsEx+oBEig4L4f4c
         56QA==
X-Gm-Message-State: AOAM532eABywhBP5PcULyPcRc403sAyvxCEJxNSYOBXhIz/gHTRdUY6E
        8zxZxM8OVnffKT75ZTNT1ktMDT5t
X-Google-Smtp-Source: ABdhPJwA/VxAawIkEa7LGvd66uzDqyrn64wbok7oPnMxZltiyyFb7t6T00DmwjnNaJtOQULw4HtVsg==
X-Received: by 2002:a92:d087:: with SMTP id h7mr9366190ilh.227.1590071698704;
        Thu, 21 May 2020 07:34:58 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q19sm2413102ioh.28.2020.05.21.07.34.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 07:34:58 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04LEYvcx000864;
        Thu, 21 May 2020 14:34:57 GMT
Subject: [PATCH v3 14/32] SUNRPC: Trace a few more generic svc_xprt events
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 21 May 2020 10:34:57 -0400
Message-ID: <20200521143457.3557.51229.stgit@klimt.1015granger.net>
In-Reply-To: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
References: <20200521141100.3557.17098.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In lieu of dprintks or tracepoints in each individual transport
implementation, introduce tracepoints in the generic part of the RPC
layer. These typically fire for connection lifetime events, so
shouldn't contribute a lot of noise.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h           |   32 -------------------------
 include/trace/events/sunrpc.h            |   39 ++++++++++++++++++++++++++++--
 net/sunrpc/svc_xprt.c                    |   22 ++++-------------
 net/sunrpc/svcsock.c                     |   12 ---------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   21 +++-------------
 5 files changed, 45 insertions(+), 81 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 79ef2ab7743c..bdcde7d33f14 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1279,38 +1279,6 @@ TRACE_EVENT(xprtrdma_leaked_rep,
  ** Server-side RPC/RDMA events
  **/
 
-DECLARE_EVENT_CLASS(svcrdma_xprt_event,
-	TP_PROTO(
-		const struct svc_xprt *xprt
-	),
-
-	TP_ARGS(xprt),
-
-	TP_STRUCT__entry(
-		__field(const void *, xprt)
-		__string(addr, xprt->xpt_remotebuf)
-	),
-
-	TP_fast_assign(
-		__entry->xprt = xprt;
-		__assign_str(addr, xprt->xpt_remotebuf);
-	),
-
-	TP_printk("xprt=%p addr=%s",
-		__entry->xprt, __get_str(addr)
-	)
-);
-
-#define DEFINE_XPRT_EVENT(name)						\
-		DEFINE_EVENT(svcrdma_xprt_event, svcrdma_xprt_##name,	\
-				TP_PROTO(				\
-					const struct svc_xprt *xprt	\
-				),					\
-				TP_ARGS(xprt))
-
-DEFINE_XPRT_EVENT(accept);
-DEFINE_XPRT_EVENT(free);
-
 DECLARE_EVENT_CLASS(svcrdma_accept_class,
 	TP_PROTO(
 		const struct svcxprt_rdma *rdma,
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index f3296ed2b753..d40ec8f5c220 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1236,9 +1236,42 @@ DECLARE_EVENT_CLASS(svc_xprt_event,
 		show_svc_xprt_flags(__entry->flags))
 );
 
-DEFINE_EVENT(svc_xprt_event, svc_xprt_no_write_space,
-	TP_PROTO(struct svc_xprt *xprt),
-	TP_ARGS(xprt));
+#define DEFINE_SVC_XPRT_EVENT(name) \
+	DEFINE_EVENT(svc_xprt_event, svc_xprt_##name, \
+			TP_PROTO( \
+				struct svc_xprt *xprt \
+			), \
+			TP_ARGS(xprt))
+
+DEFINE_SVC_XPRT_EVENT(no_write_space);
+DEFINE_SVC_XPRT_EVENT(close);
+DEFINE_SVC_XPRT_EVENT(detach);
+DEFINE_SVC_XPRT_EVENT(free);
+
+TRACE_EVENT(svc_xprt_accept,
+	TP_PROTO(
+		const struct svc_xprt *xprt,
+		const char *service
+	),
+
+	TP_ARGS(xprt, service),
+
+	TP_STRUCT__entry(
+		__string(addr, xprt->xpt_remotebuf)
+		__string(protocol, xprt->xpt_class->xcl_name)
+		__string(service, service)
+	),
+
+	TP_fast_assign(
+		__assign_str(addr, xprt->xpt_remotebuf);
+		__assign_str(protocol, xprt->xpt_class->xcl_name)
+		__assign_str(service, service);
+	),
+
+	TP_printk("addr=%s protocol=%s service=%s",
+		__get_str(addr), __get_str(protocol), __get_str(service)
+	)
+);
 
 TRACE_EVENT(svc_xprt_dequeue,
 	TP_PROTO(struct svc_rqst *rqst),
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index f89e04210a48..0a546ef02dde 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -153,6 +153,7 @@ static void svc_xprt_free(struct kref *kref)
 		xprt_put(xprt->xpt_bc_xprt);
 	if (xprt->xpt_bc_xps)
 		xprt_switch_put(xprt->xpt_bc_xps);
+	trace_svc_xprt_free(xprt);
 	xprt->xpt_ops->xpo_free(xprt);
 	module_put(owner);
 }
@@ -309,15 +310,11 @@ int svc_create_xprt(struct svc_serv *serv, const char *xprt_name,
 {
 	int err;
 
-	dprintk("svc: creating transport %s[%d]\n", xprt_name, port);
 	err = _svc_create_xprt(serv, xprt_name, net, family, port, flags, cred);
 	if (err == -EPROTONOSUPPORT) {
 		request_module("svc%s", xprt_name);
 		err = _svc_create_xprt(serv, xprt_name, net, family, port, flags, cred);
 	}
-	if (err < 0)
-		dprintk("svc: transport %s not found, err %d\n",
-			xprt_name, -err);
 	return err;
 }
 EXPORT_SYMBOL_GPL(svc_create_xprt);
@@ -785,7 +782,6 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 	int len = 0;
 
 	if (test_bit(XPT_CLOSE, &xprt->xpt_flags)) {
-		dprintk("svc_recv: found XPT_CLOSE\n");
 		if (test_and_clear_bit(XPT_KILL_TEMP, &xprt->xpt_flags))
 			xprt->xpt_ops->xpo_kill_temp_xprt(xprt);
 		svc_delete_xprt(xprt);
@@ -804,6 +800,7 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 		if (newxpt) {
 			newxpt->xpt_cred = get_cred(xprt->xpt_cred);
 			svc_add_new_temp_xprt(serv, newxpt);
+			trace_svc_xprt_accept(newxpt, serv->sv_name);
 		} else
 			module_put(xprt->xpt_class->xcl_owner);
 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
@@ -840,14 +837,6 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 	struct svc_serv		*serv = rqstp->rq_server;
 	int			len, err;
 
-	dprintk("svc: server %p waiting for data (to = %ld)\n",
-		rqstp, timeout);
-
-	if (rqstp->rq_xprt)
-		printk(KERN_ERR
-			"svc_recv: service %p, transport not NULL!\n",
-			 rqstp);
-
 	err = svc_alloc_arg(rqstp);
 	if (err)
 		goto out;
@@ -895,7 +884,6 @@ EXPORT_SYMBOL_GPL(svc_recv);
 void svc_drop(struct svc_rqst *rqstp)
 {
 	trace_svc_drop(rqstp);
-	dprintk("svc: xprt %p dropped request\n", rqstp->rq_xprt);
 	svc_xprt_release(rqstp);
 }
 EXPORT_SYMBOL_GPL(svc_drop);
@@ -1030,11 +1018,10 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	struct svc_serv	*serv = xprt->xpt_server;
 	struct svc_deferred_req *dr;
 
-	/* Only do this once */
 	if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
-		BUG();
+		return;
 
-	dprintk("svc: svc_delete_xprt(%p)\n", xprt);
+	trace_svc_xprt_detach(xprt);
 	xprt->xpt_ops->xpo_detach(xprt);
 	if (xprt->xpt_bc_xprt)
 		xprt->xpt_bc_xprt->ops->close(xprt->xpt_bc_xprt);
@@ -1055,6 +1042,7 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 
 void svc_close_xprt(struct svc_xprt *xprt)
 {
+	trace_svc_xprt_close(xprt);
 	set_bit(XPT_CLOSE, &xprt->xpt_flags);
 	if (test_and_set_bit(XPT_BUSY, &xprt->xpt_flags))
 		/* someone else will have to effect the close */
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 3e7b6445e317..cf4bd198c19d 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -727,7 +727,6 @@ static struct svc_xprt *svc_tcp_accept(struct svc_xprt *xprt)
 	int		err, slen;
 	RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 
-	dprintk("svc: tcp_accept %p sock %p\n", svsk, sock);
 	if (!sock)
 		return NULL;
 
@@ -1363,11 +1362,6 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	int		newlen;
 	int		family;
 	int		val;
-	RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
-
-	dprintk("svc: svc_create_socket(%s, %d, %s)\n",
-			serv->sv_program->pg_name, protocol,
-			__svc_print_addr(sin, buf, sizeof(buf)));
 
 	if (protocol != IPPROTO_UDP && protocol != IPPROTO_TCP) {
 		printk(KERN_WARNING "svc: only UDP and TCP "
@@ -1427,7 +1421,6 @@ static struct svc_xprt *svc_create_socket(struct svc_serv *serv,
 	svc_xprt_set_local(&svsk->sk_xprt, newsin, newlen);
 	return (struct svc_xprt *)svsk;
 bummer:
-	dprintk("svc: svc_create_socket error = %d\n", -error);
 	sock_release(sock);
 	return ERR_PTR(error);
 }
@@ -1441,8 +1434,6 @@ static void svc_sock_detach(struct svc_xprt *xprt)
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 	struct sock *sk = svsk->sk_sk;
 
-	dprintk("svc: svc_sock_detach(%p)\n", svsk);
-
 	/* put back the old socket callbacks */
 	lock_sock(sk);
 	sk->sk_state_change = svsk->sk_ostate;
@@ -1459,8 +1450,6 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
-	dprintk("svc: svc_tcp_sock_detach(%p)\n", svsk);
-
 	svc_sock_detach(xprt);
 
 	if (!test_bit(XPT_LISTENER, &xprt->xpt_flags)) {
@@ -1475,7 +1464,6 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
-	dprintk("svc: svc_sock_free(%p)\n", svsk);
 
 	if (svsk->sk_sock->file)
 		sockfd_put(svsk->sk_sock);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index f3b5ad2bec2f..d38be57b00ed 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -314,11 +314,8 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	struct svcxprt_rdma *cma_xprt;
 	int ret;
 
-	dprintk("svcrdma: Creating RDMA listener\n");
-	if ((sa->sa_family != AF_INET) && (sa->sa_family != AF_INET6)) {
-		dprintk("svcrdma: Address family %d is not supported.\n", sa->sa_family);
+	if (sa->sa_family != AF_INET && sa->sa_family != AF_INET6)
 		return ERR_PTR(-EAFNOSUPPORT);
-	}
 	cma_xprt = svc_rdma_create_xprt(serv, net);
 	if (!cma_xprt)
 		return ERR_PTR(-ENOMEM);
@@ -329,7 +326,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 				   RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(listen_id)) {
 		ret = PTR_ERR(listen_id);
-		dprintk("svcrdma: rdma_create_id failed = %d\n", ret);
 		goto err0;
 	}
 
@@ -338,23 +334,17 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	 */
 #if IS_ENABLED(CONFIG_IPV6)
 	ret = rdma_set_afonly(listen_id, 1);
-	if (ret) {
-		dprintk("svcrdma: rdma_set_afonly failed = %d\n", ret);
+	if (ret)
 		goto err1;
-	}
 #endif
 	ret = rdma_bind_addr(listen_id, sa);
-	if (ret) {
-		dprintk("svcrdma: rdma_bind_addr failed = %d\n", ret);
+	if (ret)
 		goto err1;
-	}
 	cma_xprt->sc_cm_id = listen_id;
 
 	ret = rdma_listen(listen_id, RPCRDMA_LISTEN_BACKLOG);
-	if (ret) {
-		dprintk("svcrdma: rdma_listen failed = %d\n", ret);
+	if (ret)
 		goto err1;
-	}
 
 	/*
 	 * We need to use the address from the cm_id in case the
@@ -537,7 +527,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	dprintk("    ord             : %d\n", conn_param.initiator_depth);
 #endif
 
-	trace_svcrdma_xprt_accept(&newxprt->sc_xprt);
 	return &newxprt->sc_xprt;
 
  errout:
@@ -578,8 +567,6 @@ static void __svc_rdma_free(struct work_struct *work)
 		container_of(work, struct svcxprt_rdma, sc_work);
 	struct svc_xprt *xprt = &rdma->sc_xprt;
 
-	trace_svcrdma_xprt_free(xprt);
-
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
 

