Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0579E6C14A5
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjCTOYy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjCTOYu (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:24:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C74136EF
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:24:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6517261543
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D8FC43326;
        Mon, 20 Mar 2023 14:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322287;
        bh=BM7tNLhE+0Mt5qoH8loLbuAi0FN8KfqvcNPON9fwcoQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GR/wbHFL9gyNcTKh0qQEdvCpCn4qcYyyqd4Gf2rcPg6IeRpBnH9rmQ+ICktAhkR45
         E+r2/iGmCi7B82F3EQpHDNSi8a2icBHC3K1e7Y09JpptyubRm3Xwk4v1keBHrj6R4N
         r75BkGuO4n+n1ZZyaTUIawrpfUkcCdWV+TmU61JXTMa7bSn/v5QQKYmQoPkB3e8itG
         GklDMDTULhE95Ntbqs29pJUlN+buiQa8e6XAvDP6gdNYQqWxKUlrdQguV4WrtLmTa8
         aWKclFx2/a79y1YWWDHN14nos9dBlebHnFSd3fWbN3v9a7BIBjm/emynkaEJV76AKy
         Dm8QUoR8mzR1g==
Subject: [PATCH RFC 4/5] SUNRPC: Support TLS handshake in the server-side TCP
 socket code
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Mon, 20 Mar 2023 10:24:46 -0400
Message-ID: <167932228666.3131.1680559749292527734.stgit@manet.1015granger.net>
In-Reply-To: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
References: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 include/trace/events/sunrpc.h   |   16 ++++++-
 net/sunrpc/svc_xprt.c           |    5 ++
 net/sunrpc/svcauth_unix.c       |   11 ++++-
 net/sunrpc/svcsock.c            |   91 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 125 insertions(+), 5 deletions(-)

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
index bcc555c7ae9c..1175e1c38bac 100644
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
index cf286a0a17d0..2667a8db4811 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1948,7 +1948,10 @@ TRACE_EVENT(svc_stats_latency,
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
@@ -2081,6 +2084,17 @@ DEFINE_SVC_XPRT_EVENT(close);
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
index ba629297da4e..b68c04dbf876 100644
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
@@ -829,6 +829,9 @@ static int svc_handle_xprt(struct svc_rqst *rqstp, struct svc_xprt *xprt)
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
index 983c5891cb56..374995201df4 100644
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
 
@@ -823,6 +824,7 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
 {
 	struct xdr_stream *xdr = &rqstp->rq_arg_stream;
 	struct svc_cred	*cred = &rqstp->rq_cred;
+	struct svc_xprt *xprt = rqstp->rq_xprt;
 	u32 flavor, len;
 	void *body;
 	__be32 *p;
@@ -856,14 +858,19 @@ svcauth_tls_accept(struct svc_rqst *rqstp)
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
index b6df73cb706a..16ba8d6ab20e 100644
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
@@ -64,6 +66,7 @@
 
 #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
 
+#define SVC_HANDSHAKE_TO	(20U * HZ)
 
 static struct svc_sock *svc_setup_socket(struct svc_serv *, struct socket *,
 					 int flags);
@@ -360,6 +363,8 @@ static void svc_data_ready(struct sock *sk)
 		rmb();
 		svsk->sk_odata(sk);
 		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
+		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
+			return;
 		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
 			svc_xprt_enqueue(&svsk->sk_xprt);
 	}
@@ -397,6 +402,89 @@ static void svc_tcp_kill_temp_xprt(struct svc_xprt *xprt)
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
+	smp_wmb();
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
+		if (tls_handshake_cancel(svsk->sk_sock)) {
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
+	/*
+	 * Mark the transport ready in case the remote sent RPC
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
@@ -1260,6 +1348,7 @@ static const struct svc_xprt_ops svc_tcp_ops = {
 	.xpo_has_wspace = svc_tcp_has_wspace,
 	.xpo_accept = svc_tcp_accept,
 	.xpo_kill_temp_xprt = svc_tcp_kill_temp_xprt,
+	.xpo_handshake = svc_tcp_handshake,
 };
 
 static struct svc_xprt_class svc_tcp_class = {
@@ -1584,6 +1673,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
 {
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 
+	tls_handshake_cancel(svsk->sk_sock);
+
 	if (svsk->sk_sock->file)
 		sockfd_put(svsk->sk_sock);
 	else


