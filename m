Return-Path: <linux-nfs+bounces-18757-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Bg0JPW9hGmd5AMAu9opvQ
	(envelope-from <linux-nfs+bounces-18757-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 16:57:41 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 37998F4D75
	for <lists+linux-nfs@lfdr.de>; Thu, 05 Feb 2026 16:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5461630059BD
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Feb 2026 15:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F212D42B75C;
	Thu,  5 Feb 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm73jIWI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0608421F10
	for <linux-nfs@vger.kernel.org>; Thu,  5 Feb 2026 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307054; cv=none; b=SN7G/55w93YLgdKE2+RuurTBV7Mj13iWaBwTY3OaoFwlFPOS2AFUqerUj7shwsleugL++53FcIhrvMaLxaXj/9HLXh8CidngQnlPm7VtYrEiEmqZYcUXwjXXcMBwEb6Qm9Nmu83lhWODoLhJ/mw62MWxcqXBsWnrwCaAh/+tbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307054; c=relaxed/simple;
	bh=1Da8qzI8DTPm9S7pMml7edYlQCEYT9LrcZLToQ0SOQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j2ITv1IR0iczmqiF41ABtAs5iUS+sxzwcgZU3nj+C2BDyDdEIj51tB9TwC9C/A4b+JoSHcNDtWfytyt7hM/AtRxXWf6aVGEHoxypZtmZxPKdLpYAgGxdWn9qVUHgrF0qfYci9XGSP5Kb3bGgh7aHTtqwR/W5bgjBvhB2JCEcMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm73jIWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC7DC116D0;
	Thu,  5 Feb 2026 15:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770307054;
	bh=1Da8qzI8DTPm9S7pMml7edYlQCEYT9LrcZLToQ0SOQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm73jIWI2w/Xm4VmGpb4pfTuM6uG1my6kSFIL8E7w9sp8I9NLRvTJEoOE4j349Dzk
	 6XI4PFYuz7GWfGbsaNPhl/VScPAh6mtKMy9pnzfIXQBTA4BcvSF8ElngOugAJJ32w6
	 HbNXG9mKMqJVWKR8pywW6AFEYq6b81dnZanVGMpwCdKiyevZVCGTrVjny4wlwx2BY1
	 KJhbb54n00cNXonolxykhJ/K4FoNl93dLvKysNvw/rQhOImaWzT0chw1yciHTgZ7hP
	 UClwBWAaa+MtshY0N7lC25J5h8zn+TQZATip0L8BEa+28jpfe403VDoNoxUpm8NrJ/
	 v0iEtD15siXTA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	daire@dneg.com,
	Mike Snitzer <snitzer@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 2/7] sunrpc: split svc_data_ready into protocol-specific callbacks
Date: Thu,  5 Feb 2026 10:57:24 -0500
Message-ID: <20260205155729.6841-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205155729.6841-1-cel@kernel.org>
References: <20260205155729.6841-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18757-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,dneg.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 37998F4D75
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
 net/sunrpc/svcsock.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index d61cd9b40491..3ec50812b110 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -397,10 +397,37 @@ static void svc_sock_secure_port(struct svc_rqst *rqstp)
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
+{
+	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
+
+	trace_sk_data_ready(sk);
+
+	if (svsk) {
+		/* Refer to svc_setup_socket() for details. */
+		rmb();
+		svsk->sk_odata(sk);
+		trace_svcsock_data_ready(&svsk->sk_xprt, 0);
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
 {
 	struct svc_sock	*svsk = (struct svc_sock *)sk->sk_user_data;
 
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


