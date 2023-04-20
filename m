Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5686E9B21
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjDTR43 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 13:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjDTR42 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 13:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1152690
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 10:56:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCA46151A
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 17:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83BCC433EF;
        Thu, 20 Apr 2023 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682013386;
        bh=8vit0GvIibeS2YwJFIUmR/tYZG0XWRIT7iQh9RIBsmY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XiFHZxEXZldQBwV8ZPMtcDNVT+azMVs+eVlaxaJp45OGvG9tQ+n6g2zdKt+p8YFDL
         VkI40j8yQCcyEc7UVUCQR4V7NSemiOI0Owu/rb+Z9ST3P7+fj8d48OSLavuPawjYlq
         heP19JPt1WKQWaI49qAmSg95NLYwoFLl0MOiJz62EcYlU6QpLHmHWqF1XWXOC8+Z16
         0RWeUKoLVXsj7MYz5X9j/QCUhXVyrDle6OpSQgX6RDO/nI44JkhzcvkrA5YyuA3a8F
         pqTJ1g25csXgyenIc3z+B1+O/YVOdaTqj1jQOWSJdTJvs1XESoM9AR9u0buBc9GAyP
         oBM62rAzHfb6A==
Subject: [PATCH v1 1/2] SUNRPC: Support TLS handshake in the server-side TCP
 socket code
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Thu, 20 Apr 2023 13:56:24 -0400
Message-ID: <168201338475.6370.13549486153072281084.stgit@91.116.238.104.host.secureserver.net>
In-Reply-To: <168201329016.6370.17351667274885826598.stgit@91.116.238.104.host.secureserver.net>
References: <168201329016.6370.17351667274885826598.stgit@91.116.238.104.host.secureserver.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This patch adds opportunitistic RPC-with-TLS to the Linux in-kernel
NFS server. If the client requests RPC-with-TLS and the user space
handshake agent is running, the server will set up a TLS session.

There are no policy settings yet. For example, the server cannot
yet require the use of RPC-with-TLS to access its data.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_xprt.h |    5 ++
 include/linux/sunrpc/svcsock.h  |    2 +
 include/trace/events/sunrpc.h   |   16 ++++++
 net/sunrpc/svc_xprt.c           |    5 ++
 net/sunrpc/svcauth_unix.c       |   11 +++-
 net/sunrpc/svcsock.c            |  101 ++++++++++++++++++++++++++++++++++++++-
 6 files changed, 132 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 775368802762..867479204840 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -27,7 +27,7 @@ struct svc_xprt_ops {
 	void		(*xpo_detach)(struct svc_xprt *);
 	void		(*xpo_free)(struct svc_xprt *);
 	void		(*xpo_kill_temp_xprt)(struct svc_xprt *);
-	void		(*xpo_start_tls)(struct svc_xprt *);
+	void		(*xpo_handshake)(struct svc_xprt *xprt);
 };
 
 struct svc_xprt_class {
@@ -70,6 +70,9 @@ struct svc_xprt {
 #define XPT_LOCAL	12		/* connection from loopback interface */
 #define XPT_KILL_TEMP   13		/* call xpo_kill_temp_xprt before closing */
 #define XPT_CONG_CTRL	14		/* has congestion control */
+#define XPT_HANDSHAKE	15		/* xprt requests a handshake */
+#define XPT_TLS_SESSION	16		/* transport-layer security established */
+#define XPT_PEER_AUTH	17		/* peer has been authenticated */
 
 	struct svc_serv		*xpt_server;	/* service for transport */
 	atomic_t    	    	xpt_reserved;	/* space on outq that is rsvd */
diff --git a/include/linux/sunrpc/svcsock.h b/include/linux/sunrpc/svcsock.h
index dd73fa174af5..d16ae621782c 100644
--- a/include/linux/sunrpc/svcsock.h
+++ b/include/linux/sunrpc/svcsock.h
@@ -38,6 +38,8 @@ struct svc_sock {
 	/* Number of queued send requests */
 	atomic_t		sk_sendqlen;
 
+	struct completion	sk_handshake_done;
+
 	struct page *		sk_pages[RPCSVC_MAXPAGES];	/* received data */
 };
 
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 030c7ff6862b..88ef5537c49e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1870,7 +1870,10 @@ TRACE_EVENT(svc_stats_latency,
 		{ BIT(XPT_CACHE_AUTH),		"CACHE_AUTH" },		\
 		{ BIT(XPT_LOCAL),		"LOCAL" },		\
 		{ BIT(XPT_KILL_TEMP),		"KILL_TEMP" },		\
-		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" })
+		{ BIT(XPT_CONG_CTRL),		"CONG_CTRL" },		\
+		{ BIT(XPT_HANDSHAKE),		"HANDSHAKE" },		\
+		{ BIT(XPT_TLS_SESSION),		"TLS_SESSION" },	\
+		{ BIT(XPT_PEER_AUTH),		"PEER_AUTH" })
 
 TRACE_EVENT(svc_xprt_create_err,
 	TP_PROTO(
@@ -2003,6 +2006,17 @@ DEFINE_SVC_XPRT_EVENT(close);
 DEFINE_SVC_XPRT_EVENT(detach);
 DEFINE_SVC_XPRT_EVENT(free);
 
+#define DEFINE_SVC_TLS_EVENT(name) \
+	DEFINE_EVENT(svc_xprt_event, svc_tls_##name, \
+		TP_PROTO(const struct svc_xprt *xprt), \
+		TP_ARGS(xprt))
+
+DEFINE_SVC_TLS_EVENT(start);
+DEFINE_SVC_TLS_EVENT(upcall);
+DEFINE_SVC_TLS_EVENT(unavailable);
+DEFINE_SVC_TLS_EVENT(not_started);
+DEFINE_SVC_TLS_EVENT(timed_out);
+
 TRACE_EVENT(svc_xprt_accept,
 	TP_PROTO(
 		const struct svc_xprt *xprt,
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 3b9708b39e35..84e5d7d31481 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -427,7 +427,7 @@ static bool svc_xprt_ready(struct svc_xprt *xprt)
 
 	if (xpt_flags & BIT(XPT_BUSY))
 		return false;
-	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE)))
+	if (xpt_flags & (BIT(XPT_CONN) | BIT(XPT_CLOSE) | BIT(XPT_HANDSHAKE)))
 		return true;
 	if (xpt_flags & (BIT(XPT_DATA) | BIT(XPT_DEFERRED))) {
 		if (xprt->xpt_ops->xpo_has_wspace(xprt) &&
@@ -828,6 +828,9 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
 			module_put(xprt->xpt_class->xcl_owner);
 		}
 		svc_xprt_received(xprt);
+	} else if (test_bit(XPT_HANDSHAKE, &xprt->xpt_flags)) {
+		xprt->xpt_ops->xpo_handshake(xprt);
+		svc_xprt_received(xprt);
 	} else if (svc_xprt_reserve_slot(rqstp, xprt)) {
 		/* XPT_DATA|XPT_DEFERRED case: */
 		dprintk("svc: server %p, pool %u, transport %p, inuse=%d\n",
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index 4485088ce27b..174783f804fa 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -17,8 +17,9 @@
 #include <net/ipv6.h>
 #include <linux/kernel.h>
 #include <linux/user_namespace.h>
-#define RPCDBG_FACILITY	RPCDBG_AUTH
+#include <trace/events/sunrpc.h>
 
+#define RPCDBG_FACILITY	RPCDBG_AUTH
 
 #include "netns.h"
 
@@ -832,6 +833,7 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
 	u32 flavor, len;
 	void *body;
 	__be32 *p;
@@ -865,14 +867,19 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 	if (cred->cr_group_info == NULL)
 		return SVC_CLOSE;
 
-	if (rqstp->rq_xprt->xpt_ops->xpo_start_tls) {
+	if (xprt->xpt_ops->xpo_handshake) {
 		p = xdr_reserve_space(&rqstp->rq_res_stream, XDR_UNIT * 2 + 8);
 		if (!p)
 			return SVC_CLOSE;
+		trace_svc_tls_start(xprt);
 		*p++ = rpc_auth_null;
 		*p++ = cpu_to_be32(8);
 		memcpy(p, "STARTTLS", 8);
+
+		set_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
+		svc_xprt_enqueue(xprt);
 	} else {
+		trace_svc_tls_unavailable(xprt);
 		if (xdr_stream_encode_opaque_auth(&rqstp->rq_res_stream,
 						  RPC_AUTH_NULL, NULL, 0) < 0)
 			return SVC_CLOSE;
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index f4a7d99360e8..4e50c6187c63 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -44,9 +44,11 @@
 #include <net/tcp.h>
 #include <net/tcp_states.h>
 #include <net/tls.h>
+#include <net/handshake.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
 #include <asm/ioctls.h>
+#include <linux/key.h>
 
 #include <linux/sunrpc/types.h>
 #include <linux/sunrpc/clnt.h>
@@ -64,6 +66,12 @@
 
 #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
 
+/* To-do: to avoid tying up an nfsd thread while waiting for a
+ * handshake request, the request could instead be deferred.
+ */
+enum {
+	SVC_HANDSHAKE_TO	= 5U * HZ
+};
 
 static struct svc_sock *svc_setup_socket(struct svc_serv *, struct socket *,
 					 int flags);
@@ -360,6 +368,8 @@ static void svc_data_ready(struct sock *sk)
 		rmb();
 		svsk->sk_odata(sk);
 		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
+		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
+			return;
 		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
 			svc_xprt_enqueue(&svsk->sk_xprt);
 	}
@@ -397,6 +407,88 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
 	sock_no_linger(svsk->sk_sock->sk);
 }
 
+/**
+ * svc_tcp_handshake_done - Handshake completion handler
+ * @data: address of xprt to wake
+ * @status: status of handshake
+ * @peerid: serial number of key containing the remote peer's identity
+ *
+ * If a security policy is specified as an export option, we don't
+ * have a specific export here to check. So we set a "TLS session
+ * is present" flag on the xprt and let an upper layer enforce local
+ * security policy.
+ */
+static void svc_tcp_handshake_done(void *data, int status, key_serial_t peerid)
+{
+	struct svc_xprt *xprt = data;
+	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
+
+	if (!status) {
+		if (peerid != TLS_NO_PEERID)
+			set_bit(XPT_PEER_AUTH, &xprt->xpt_flags);
+		set_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
+	}
+	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
+	complete_all(&svsk->sk_handshake_done);
+}
+
+/**
+ * svc_tcp_handshake - Perform a transport-layer security handshake
+ * @xprt: connected transport endpoint
+ *
+ */
+static void svc_tcp_handshake(struct svc_xprt *xprt)
+{
+	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct sock *sk = svsk->sk_sock->sk;
+	struct tls_handshake_args args = {
+		.ta_sock	= svsk->sk_sock,
+		.ta_done	= svc_tcp_handshake_done,
+		.ta_data	= xprt,
+	};
+	int ret;
+
+	trace_svc_tls_upcall(xprt);
+
+	clear_bit(XPT_TLS_SESSION, &xprt->xpt_flags);
+	init_completion(&svsk->sk_handshake_done);
+
+	ret = tls_server_hello_x509(&args, GFP_KERNEL);
+	if (ret) {
+		trace_svc_tls_not_started(xprt);
+		goto out_failed;
+	}
+
+	ret = wait_for_completion_interruptible_timeout(&svsk->sk_handshake_done,
+							SVC_HANDSHAKE_TO);
+	if (ret <= 0) {
+		if (tls_handshake_cancel(sk)) {
+			trace_svc_tls_timed_out(xprt);
+			goto out_close;
+		}
+	}
+
+	if (!test_bit(XPT_TLS_SESSION, &xprt->xpt_flags)) {
+		trace_svc_tls_unavailable(xprt);
+		goto out_close;
+	}
+
+	/* Mark the transport ready in case the remote sent RPC
+	 * traffic before the kernel received the handshake
+	 * completion downcall.
+	 */
+	set_bit(XPT_DATA, &xprt->xpt_flags);
+	svc_xprt_enqueue(xprt);
+	return;
+
+out_close:
+	set_bit(XPT_CLOSE, &xprt->xpt_flags);
+out_failed:
+	clear_bit(XPT_HANDSHAKE, &xprt->xpt_flags);
+	set_bit(XPT_DATA, &xprt->xpt_flags);
+	svc_xprt_enqueue(xprt);
+}
+
 /*
  * See net/ipv6/ip_sockglue.c : ip_cmsg_recv_pktinfo
  */
@@ -1258,6 +1350,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_has_wspace = svc_tcp_has_wspace,
 	.xpo_accept = svc_tcp_accept,
 	.xpo_kill_temp_xprt = svc_tcp_kill_temp_xprt,
+	.xpo_handshake = svc_tcp_handshake,
 };
 
 static struct svc_xprt_class svc_tcp_class = {
@@ -1581,10 +1674,12 @@ static void svc_tcp_sock_detach(struct svc_xprt *xprt)
 static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
+	struct socket *sock = svsk->sk_sock;
 
-	if (svsk->sk_sock->file)
-		sockfd_put(svsk->sk_sock);
+	tls_handshake_cancel(sock->sk);
+	if (sock->file)
+		sockfd_put(sock);
 	else
-		sock_release(svsk->sk_sock);
+		sock_release(sock);
 	kfree(svsk);
 }


