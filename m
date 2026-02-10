Return-Path: <linux-nfs+bounces-18836-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOEVF9pai2ljUAAAu9opvQ
	(envelope-from <linux-nfs+bounces-18836-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:42 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F611D0ED
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 201CA3031E8C
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Feb 2026 16:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6CA207A09;
	Tue, 10 Feb 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6V6iqqW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C7F36683F
	for <linux-nfs@vger.kernel.org>; Tue, 10 Feb 2026 16:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770740430; cv=none; b=o9592BDpsjo5Ak+rq5397pXfXQItJJrHApnZyoSljNC6FeswSOewBIi9Q/cWmydj0l8KUq7nWkzBjaHmj4yCDbxZwXVdxxfWvOTToqO0DUw2TRynmLFQJl3B2C/7mZgepgQLqP7WtG3XQQuD1enUFhWxeNeTH06SdoO/LfplLiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770740430; c=relaxed/simple;
	bh=NoQyPw0lEzEnufSLPO3aFeN0spY3kjiLTWeT8eyI96M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0Hy93BVqN69uZGXhOAsoYFzrzpSI0C0AIyAKXcngyBn2rN2mryBnd5ckcNCb1iEZJqkB7QN+a5QiE+P1E5YhLgrev3IlznEFzIZI4xeR9Cb90jxbT3GauY8t4vhf4JRUHRHHInBkNiq/zhpoGP6B43qP0W9f8m/v99XCrU4T8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6V6iqqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B147C19421;
	Tue, 10 Feb 2026 16:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770740430;
	bh=NoQyPw0lEzEnufSLPO3aFeN0spY3kjiLTWeT8eyI96M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6V6iqqW/Kx7AOLRe/CxBjWHT6XHHFmmFk96Z1E49DzoC3Wkma4XePPX2+k//dSdu
	 iQW85CpEGwYISPkFiO/Iipc/kgBgkkJQ3B+WCRizTpncOzvrdTT0i1ZAjKjO+7c41F
	 U/Yw6yEt3fsHt/KCQbml/5h65OzROAJklwD6IOOI8AZsQlR10ndN1Sp/6gh2tlhesb
	 j/OX/vFgXjmcCf0/h67AaXNUr8viE7G++wsY9awd/w/Gr3dhP64do2PuMzMigf1Diz
	 VQGZLdrnDBNVTALVJ5UwkSp7eAugsd5/V7t/ZMWWeAzp68ZdN6gRvuPlDeyzxfi2cj
	 LeJCEdo5VEISQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/8] sunrpc: split svc_data_ready into protocol-specific callbacks
Date: Tue, 10 Feb 2026 11:20:20 -0500
Message-ID: <20260210162025.2356389-4-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18836-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: ED5F611D0ED
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Separate data-ready callbacks enable protocol-specific
optimizations. UDP and TCP transports already have different
requirements: currently UDP sockets do not implement DTLS, so the
XPT_HANDSHAKE check is unnecessary overhead for them.

Prepare the server-side socket infrastructure for additional
changes to TCP's data_ready callback.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |  3 ++-
 net/sunrpc/svcsock.c          | 39 +++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 076182ae19ec..c5a15b7a321d 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -2313,7 +2313,8 @@ DEFINE_SVCSOCK_EVENT(tcp_send);
 DEFINE_SVCSOCK_EVENT(tcp_recv);
 DEFINE_SVCSOCK_EVENT(tcp_recv_eagain);
 DEFINE_SVCSOCK_EVENT(tcp_recv_err);
-DEFINE_SVCSOCK_EVENT(data_ready);
+DEFINE_SVCSOCK_EVENT(udp_data_ready);
+DEFINE_SVCSOCK_EVENT(tcp_data_ready);
 DEFINE_SVCSOCK_EVENT(write_space);
 
 TRACE_EVENT(svcsock_tcp_recv_short,
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d61cd9b40491..73644f3b63c7 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -397,10 +397,14 @@ static void svc_sock_secure_port(struct svc_rqst *rqstp)
 		clear_bit(RQ_SECURE, &rqstp->rq_flags);
 }
 
-/*
- * INET callback when data has been received on the socket.
+/**
+ * svc_udp_data_ready - sk->sk_data_ready callback for UDP sockets
+ * @sk: socket whose receive buffer contains data
+ *
+ * This implementation does not yet support DTLS, so the
+ * XPT_HANDSHAKE check is not needed here.
  */
-static void svc_data_ready(struct sock *sk)
+static void svc_udp_data_ready(struct sock *sk)
 {
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
@@ -410,7 +414,30 @@ static void svc_data_ready(struct sock *sk)
 		/* Refer to svc_setup_socket() for details. */
 		rmb();
 		svsk->sk_odata(sk);
-		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
+		trace_svcsock_udp_data_ready(&svsk->sk_xprt, 0);
+		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
+			svc_xprt_enqueue(&svsk->sk_xprt);
+	}
+}
+
+/**
+ * svc_tcp_data_ready - sk->sk_data_ready callback for TCP sockets
+ * @sk: socket whose receive buffer contains data
+ *
+ * Data ingest is skipped while a TLS handshake is in progress
+ * (XPT_HANDSHAKE).
+ */
+static void svc_tcp_data_ready(struct sock *sk)
+{
+	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
+
+	trace_sk_data_ready(sk);
+
+	if (svsk) {
+		/* Refer to svc_setup_socket() for details. */
+		rmb();
+		svsk->sk_odata(sk);
+		trace_svcsock_tcp_data_ready(&svsk->sk_xprt, 0);
 		if (test_bit(XPT_HANDSHAKE, &svsk->sk_xprt.xpt_flags))
 			return;
 		if (!test_and_set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags))
@@ -835,7 +862,7 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	svc_xprt_init(sock_net(svsk->sk_sock->sk), &svc_udp_class,
 		      &svsk->sk_xprt, serv);
 	clear_bit(XPT_CACHE_AUTH, &svsk->sk_xprt.xpt_flags);
-	svsk->sk_sk->sk_data_ready = svc_data_ready;
+	svsk->sk_sk->sk_data_ready = svc_udp_data_ready;
 	svsk->sk_sk->sk_write_space = svc_write_space;
 
 	/* initialise setting must have enough space to
@@ -1368,7 +1395,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
 		sk->sk_state_change = svc_tcp_state_change;
-		sk->sk_data_ready = svc_data_ready;
+		sk->sk_data_ready = svc_tcp_data_ready;
 		sk->sk_write_space = svc_write_space;
 
 		svsk->sk_marker = xdr_zero;
-- 
2.52.0


