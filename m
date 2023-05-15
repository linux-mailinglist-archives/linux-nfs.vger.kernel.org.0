Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA6702E2D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 May 2023 15:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241883AbjEONdG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 May 2023 09:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbjEONdG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 May 2023 09:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54516E69
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 06:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5408617FB
        for <linux-nfs@vger.kernel.org>; Mon, 15 May 2023 13:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33754C433EF;
        Mon, 15 May 2023 13:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684157581;
        bh=UX5dBEOvzI+VJ3/nDoYVwDa423Kh9seDFIkHWcTue6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=AHFOaLrJfsOVzi+tsd1sqSf65oxMoZMV2J7+SEEpwVNvLFzWNDK89OwyJ4Ov7dj7U
         tSjdTG4PxzqMd6cWNOhRqZS/tAeEumDb9Wet0CQAIxuOQIah0m9UPcT9zg0AWjSTEA
         fOLPFYRtsLvoZoRo3nwBHWJNXX7HRCb5DLQD+UfDjJpNaEaVno15fleMNscOJLlYFd
         lKHptxEmkdEsQn494qwvfwK4qwJ8W68xAxm96zkSW7r1enykxcAngO2ODUXxR64gcq
         hEpfVCE26m6HABTi/NoQKeb/1GDQlfH5rDAEtLqybZscLfAnzf4edibK1PlH4w2RBC
         No0qWZ+LIxQrw==
Subject: [PATCH 4/4] SUNRPC: Trace struct svc_sock lifetime events
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 15 May 2023 09:33:00 -0400
Message-ID: <168415758025.9504.3906067170627211847.stgit@manet.1015granger.net>
In-Reply-To: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
References: <168415745478.9504.1882537002036193828.stgit@manet.1015granger.net>
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

Capture a timestamp and pointer address during the creation and
destruction of struct svc_sock to record its lifetime. This helps
to diagnose transport reference counting issues.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   39 +++++++++++++++++++++++++++------------
 net/sunrpc/svcsock.c          |    4 +++-
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 31bc7025cb44..69e42ef30979 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2104,31 +2104,46 @@ DEFINE_SVC_DEFERRED_EVENT(drop);
 DEFINE_SVC_DEFERRED_EVENT(queue);
 DEFINE_SVC_DEFERRED_EVENT(recv);
 
-TRACE_EVENT(svcsock_new_socket,
+DECLARE_EVENT_CLASS(svcsock_lifetime_class,
 	TP_PROTO(
+		const void *svsk,
 		const struct socket *socket
 	),
-
-	TP_ARGS(socket),
-
+	TP_ARGS(svsk, socket),
 	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(const void *, svsk)
+		__field(const void *, sk)
 		__field(unsigned long, type)
 		__field(unsigned long, family)
-		__field(bool, listener)
+		__field(unsigned long, state)
 	),
-
 	TP_fast_assign(
+		struct sock *sk = socket->sk;
+
+		__entry->netns_ino = sock_net(sk)->ns.inum;
+		__entry->svsk = svsk;
+		__entry->sk = sk;
 		__entry->type = socket->type;
-		__entry->family = socket->sk->sk_family;
-		__entry->listener = (socket->sk->sk_state == TCP_LISTEN);
+		__entry->family = sk->sk_family;
+		__entry->state = sk->sk_state;
 	),
-
-	TP_printk("type=%s family=%s%s",
-		show_socket_type(__entry->type),
+	TP_printk("svsk=%p type=%s family=%s%s",
+		__entry->svsk, show_socket_type(__entry->type),
 		rpc_show_address_family(__entry->family),
-		__entry->listener ? " (listener)" : ""
+		__entry->state == TCP_LISTEN ? " (listener)" : ""
 	)
 );
+#define DEFINE_SVCSOCK_LIFETIME_EVENT(name) \
+	DEFINE_EVENT(svcsock_lifetime_class, name, \
+		TP_PROTO( \
+			const void *svsk, \
+			const struct socket *socket \
+		), \
+		TP_ARGS(svsk, socket))
+
+DEFINE_SVCSOCK_LIFETIME_EVENT(svcsock_new);
+DEFINE_SVCSOCK_LIFETIME_EVENT(svcsock_free);
 
 TRACE_EVENT(svcsock_marker,
 	TP_PROTO(
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 2058641ab9f6..e30716248989 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1476,7 +1476,7 @@ static struct svc_sock *svc_setup_socket(struct svc_serv *serv,
 	else
 		svc_tcp_init(svsk, serv);
 
-	trace_svcsock_new_socket(sock);
+	trace_svcsock_new(svsk, sock);
 	return svsk;
 }
 
@@ -1669,6 +1669,8 @@ static void svc_sock_free(struct svc_xprt *xprt)
 	struct svc_sock *svsk = container_of(xprt, struct svc_sock, sk_xprt);
 	struct socket *sock = svsk->sk_sock;
 
+	trace_svcsock_free(svsk, sock);
+
 	tls_handshake_cancel(sock->sk);
 	if (sock->file)
 		sockfd_put(sock);


