Return-Path: <linux-nfs+bounces-18841-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LX1IeRai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18841-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:52 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A4F11D110
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9375F30276A1
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89631B114;
	Tue, 10 Feb 2026 16:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIhcIhz/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9B207A09
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740435; cv=none; b=hgPSerIJH2yzzrGkMrKQbauIwCvISP6nGgjsDmQN9GJRcO3eRUaBXFJoN+yef83BoQsTCLkcmPBmbfg9fh5XpyU7y9HIQdeM3WKZRJSAkmc8AwhOII8/Kb3Pp0NHmhrA6zUzm15vUeeiVBfTKHgclW4SccuTeTZQbvJXr2xpsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740435; c=relaxed/simple;
	bh=TjTWTWSioZexKOcg45Sq8X+jbTiW7lVPRgFphaRqgrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nfkBwn7gROFjqZ9cUUUMrGHLwfTHkjY5EZonP4fqnLDoQTOcf7TJH6iyEY5+2lK+gqjtYPHKP8mDOFxhykfA8dG6h8jaGIj89FvHXVeniOAztqzaSNLk09lehywem5NvTwAWCB/m/GVx7Mkg3X76PzBOEvm+lg2cuEY2jUf4O34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIhcIhz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13406C19424;
	Tue, 10 Feb 2026 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740434;
	bh=TjTWTWSioZexKOcg45Sq8X+jbTiW7lVPRgFphaRqgrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NIhcIhz/vcqYs6pZTR1gm29+RT2EXL0Fs2oq6EyVvXEMElj0Du6GrcZEC+/3+yUOR
	 pYLe/bNWQqPmFCiW+civaYRnh1SwGGjeogFx6P8TMq8tSzN2UpwHicIUtT9If3iTFe
	 QbG5wiJ8VMmQDCQZIVrfkGx0QpsKKd7PtodRw9su5Tbam1BYLB3dcS9DbuPZnLJikO
	 PMQWsIgbBzgy3p7VM/8HemZT8zlaD+BK65QFnUx8w5Vrtk+/8RJpEhFAfbtQWQ/FQm
	 gvtupJTigz2uB0FYeXI15wua5e0Vai28VShR5qnHfU+0iVcz3GVfdIFvLqz/D9uP61
	 eef3a2ClaTQ3Q==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 8/8] sunrpc: Set explicit TCP socket buffer sizes for NFSD
Date: Tue, 10 Feb 2026 11:20:25 -0500
Message-ID: <20260210162025.2356389-9-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260210162025.2356389-1-cel@kernel.org>
References: <20260210162025.2356389-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18841-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29A4F11D110
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

NFSD TCP sockets currently rely on system defaults with TCP
auto-tuning. On networks with large bandwidth-delay products, the
default maximum buffer sizes (6MB receive, 4MB send) can throttle
throughput. Administrators must resort to system-wide sysctl
adjustments (tcp_rmem/tcp_wmem), which affect all TCP connections
rather than just NFS traffic.

This change sets explicit buffer sizes for NFSD TCP data sockets.
The buffer size is set to 4 * sv_max_mesg, yielding approximately
16MB with default NFS payload sizes. On memory-constrained systems,
the buffer size is capped at 1/1024 of physical RAM, with a hard
ceiling of 16MB. SOCK_SNDBUF_LOCK and SOCK_RCVBUF_LOCK disable
auto-tuning, providing predictable memory consumption.

The existing svc_sock_setbufsize() is renamed to
svc_udp_setbufsize() to reflect its UDP-specific purpose, and a
new svc_tcp_setbufsize() handles TCP data connections. Listener
sockets remain unaffected, as listeners do not transfer data.

This approach improves throughput on high-speed networks without
requiring system-wide configuration changes, while automatically
scaling down buffer sizes on small systems.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/svcsock.c | 52 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 8b2e9f524506..91a472021d0a 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -50,6 +50,7 @@
 #include <net/handshake.h>
 #include <linux/uaccess.h>
 #include <linux/highmem.h>
+#include <linux/mm.h>
 #include <asm/ioctls.h>
 #include <linux/key.h>
 
@@ -377,9 +378,12 @@ static ssize_t svc_tcp_read_msg(struct svc_rqst *rqstp, size_t buflen,
 }
 
 /*
- * Set socket snd and rcv buffer lengths
+ * Set socket snd and rcv buffer lengths for UDP sockets.
+ *
+ * UDP sockets need large buffers because pending requests remain
+ * in the receive buffer until processed by a worker thread.
  */
-static void svc_sock_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
+static void svc_udp_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
 {
 	unsigned int max_mesg = svsk->sk_xprt.xpt_server->sv_max_mesg;
 	struct socket *sock = svsk->sk_sock;
@@ -393,6 +397,45 @@ static void svc_sock_setbufsize(struct svc_sock *svsk, unsigned int nreqs)
 	release_sock(sock->sk);
 }
 
+/* Accommodate high bandwidth-delay product connections */
+#define SVC_TCP_SNDBUF_MAX	(16 * 1024 * 1024)
+#define SVC_TCP_RCVBUF_MAX	(16 * 1024 * 1024)
+
+/*
+ * Set socket snd and rcv buffer lengths for TCP data sockets.
+ *
+ * Buffers are sized to accommodate high-bandwidth data transfers on
+ * high-latency networks (large bandwidth-delay product). Automatic
+ * buffer tuning is disabled to allow control of server memory
+ * consumption.
+ */
+static void svc_tcp_setbufsize(struct svc_sock *svsk)
+{
+	struct svc_serv *serv = svsk->sk_xprt.xpt_server;
+	struct socket *sock = svsk->sk_sock;
+	unsigned long mem_cap, ideal;
+	unsigned int sndbuf, rcvbuf;
+
+	/* Buffer multiple in-flight RPC messages */
+	ideal = serv->sv_max_mesg * 4;
+
+	/* Memory-based cap: 1/1024 of physical RAM */
+	mem_cap = (totalram_pages() >> 10) << PAGE_SHIFT;
+
+	sndbuf = clamp_t(unsigned long, ideal,
+			 serv->sv_max_mesg, min(mem_cap, SVC_TCP_SNDBUF_MAX));
+	rcvbuf = clamp_t(unsigned long, ideal,
+			 serv->sv_max_mesg, min(mem_cap, SVC_TCP_RCVBUF_MAX));
+
+	lock_sock(sock->sk);
+	sock->sk->sk_sndbuf = sndbuf;
+	sock->sk->sk_rcvbuf = rcvbuf;
+	sock->sk->sk_userlocks |= SOCK_SNDBUF_LOCK;
+	sock->sk->sk_userlocks |= SOCK_RCVBUF_LOCK;
+	sock->sk->sk_write_space(sock->sk);
+	release_sock(sock->sk);
+}
+
 static void svc_sock_secure_port(struct svc_rqst *rqstp)
 {
 	if (svc_port_is_privileged(svc_addr(rqstp)))
@@ -668,7 +711,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	     * provides an upper bound on the number of threads
 	     * which will access the socket.
 	     */
-	    svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
+	    svc_udp_setbufsize(svsk, serv->sv_nrthreads + 3);
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	err = kernel_recvmsg(svsk->sk_sock, &msg, NULL,
@@ -884,7 +927,7 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	 * receive and respond to one request.
 	 * svc_udp_recvfrom will re-adjust if necessary
 	 */
-	svc_sock_setbufsize(svsk, 3);
+	svc_udp_setbufsize(svsk, 3);
 
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
@@ -1993,6 +2036,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		       svsk->sk_maxpages * sizeof(struct page *));
 
 		tcp_sock_set_nodelay(sk);
+		svc_tcp_setbufsize(svsk);
 
 		switch (sk->sk_state) {
 		case TCP_SYN_RECV:
-- 
2.52.0


