Return-Path: <linux-nfs+bounces-22015-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKgaCZ8IF2oo1wcAu9opvQ
	(envelope-from <linux-nfs+bounces-22015-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:07:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 887575E68C9
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9314A3120C7F
	for <lists+linux-nfs@lfdr.de>; Wed, 27 May 2026 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55355426EDE;
	Wed, 27 May 2026 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUe6a0qi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED234279E4;
	Wed, 27 May 2026 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894026; cv=none; b=CV5mMbyRLHwGJdVvMSDSeV6XtU0nkATbBemJhUkdcvx3o09bpPvcnMeA/Wk1r/rXR7EXcwGI5QZi/akPTYPX93A0mM/s1SY7vgajpO/jMb8KWkCDXETVJhEtQsLhoHKpBuly0bRn7yt6GAbQrwv5UpeYm40CoOcjncls9Rz5pSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894026; c=relaxed/simple;
	bh=ZG6jlxSeR0e2CWWk0awVIzChBm7R+EPVOGjFzbAX4KU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WJFf2xxKdmAoof5xPefu02KRIFJR5qMsWCs0gyH+8VGHU/cJ6LPDjt7CUcouskU6T26ebTd3pRLBK7z7dYmDHXj1qajsTO89cyZEjx2WV0txvhOmuuDvGo60HV3wm7QOVj5Un3C7cFXIDS7e1YKM0KD9lUbw2MdDQ5V8dlH5cYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUe6a0qi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D091F00A3D;
	Wed, 27 May 2026 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894025;
	bh=DrFlqZjflaZMqUuD86q45crfQVhsAdoD4tQaRXwG84E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PUe6a0qiHmepBsi8sskAAkUqZ/Rh64IXhlnTjWg9wtJ6gVSLgb2unfC+TZkAqLN+h
	 jDTT13juTWtvPg8aLINgUTXUGQfLwd7EsG2zmXOCblphq7r5iJrMSZ0V7ecoriA5tr
	 zz4zXmwP2fk2WyjLRG/SQ7R4zhShyilQx6f4IYHDkMSC9Blaw7OHD/8qa9tyCIgqV/
	 K7ueWFlwnVXEDuA1HBIYN8Tzxs5NCe39266sx0/wtOEBN+vrT1wgBf1O5t7rwF0BWY
	 kq91rA/6PLKuhpdUvEnm5lhuZn1wcc9ANBD2T4YfHY7StrA3vKo3zs0eDalibfjGZ2
	 JSKVP/9YCl89Q==
From: Chuck Lever <cel@kernel.org>
Date: Wed, 27 May 2026 11:00:14 -0400
Subject: [PATCH 4/5] svcrdma: Reject connection when transport allocation
 fails
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260527-rdma-follow-on-v1-4-1b09bd87b6cd@oracle.com>
References: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
In-Reply-To: <20260527-rdma-follow-on-v1-0-1b09bd87b6cd@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Mw+4W2c66qsslIjtmFrwZbSPcJN3fZs9a1N5+ZqpZj0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqFwcEFeffLx93avfcnXWF+A18G43icmAswesqs
 OhQgI5ZbcSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahcHBAAKCRAzarMzb2Z/
 l6iZD/9azTibBhrNq44+FOxikoHNoesxeSAxLJQcwWv7pQlzgmV53RkxTUBLTcXMXaESEo3NcOq
 eTLklLkDEEGmSXRr63ZxxmIJhGwaQ81sAiDMuZDM3GY4uYrsyVFALhcQrVPAXOVE0NAlX9QoARF
 kxLM5qC9fDu7wKkjN6tiDE7MKq8LFax3uYbx3wTATMvLmwE8aogxkZl61vyJWLMruWZ1xziv2Ym
 gw1uOvRDe3FbYj+iuWyjemcVm+47PCIPktDFwJd+zDNlaFe94sYJMYsy18q1NV5Az1PpP6FBH+L
 q3lKIgfPTpfPEmPZ1RxlmJBP35CHrZl4KFITP16yIns6GoNful1vczNLMNbYhO+9IP/HTUkUZ6K
 EIwUODx2kVcq9gpdbgPyMGmk8nKmWP1FkdJaWKJRsZD9sWuD+RQ2S/5c+FURtMKmFEdtuGX8c2l
 wYcd5sc8/1zqbXsG5bKcqZGq5JpAj/U/gB6YSlA/bCf63kCEP5C/w4l3qXRtwkdrSFbRb+e/w31
 I4gvqWYVhhcx4cdWrH2tgxTjEGO/djN6fDK3e6O0ZDGmW/i3/lVx+tekTDTxxaeeGc/aTc4X//w
 WKKHbg8wD3wYjOFONrx2XRzCAxBFgptjSDL5n+6VciLF+P684MkyEJIbOoqS3unedBuw6u1ATyS
 olgzzdV+5XGFVaA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22015-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:mid,oracle.com:email]
X-Rspamd-Queue-Id: 887575E68C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

handle_connect_req() returns without action when
svc_rdma_create_xprt() fails to allocate the new transport.
The CM core returns 0 for CONNECT_REQUEST events, so it does
not destroy the new rdma_cm_id. Each allocation failure under
memory pressure leaks one rdma_cm_id, and a remote peer driving
connection attempts can amplify this.

Reject the connection by returning a non-zero status from the
CM event handler, which tells the CM core to destroy the
orphaned cm_id.

Fixes: 377f9b2f4529 ("rdma: SVCRDMA Core Transport Services")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 63dbf16dbe7f..656b2bd258a9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -246,12 +246,16 @@ svc_rdma_parse_connect_private(struct svcxprt_rdma *newxprt,
  * structure for the listening endpoint.
  *
  * This function creates a new xprt for the new connection and enqueues it on
- * the accept queue for the listent xprt. When the listen thread is kicked, it
+ * the accept queue for the listen xprt. When the listen thread is kicked, it
  * will call the recvfrom method on the listen xprt which will accept the new
  * connection.
+ *
+ * Return values:
+ *     %0: Do not destroy @new_cma_id
+ *     %1: Destroy @new_cma_id (allocation failure)
  */
-static void handle_connect_req(struct rdma_cm_id *new_cma_id,
-			       struct rdma_conn_param *param)
+static int handle_connect_req(struct rdma_cm_id *new_cma_id,
+			      struct rdma_conn_param *param)
 {
 	struct svcxprt_rdma *listen_xprt = new_cma_id->context;
 	struct svcxprt_rdma *newxprt;
@@ -261,7 +265,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 				       listen_xprt->sc_xprt.xpt_net,
 				       ibdev_to_node(new_cma_id->device));
 	if (!newxprt)
-		return;
+		return 1;
 	newxprt->sc_cm_id = new_cma_id;
 	new_cma_id->context = newxprt;
 	svc_rdma_parse_connect_private(newxprt, param);
@@ -295,6 +299,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 
 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
+	return 0;
 }
 
 /**
@@ -318,8 +323,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
-		handle_connect_req(cma_id, &event->param.conn);
-		break;
+		return handle_connect_req(cma_id, &event->param.conn);
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		listen_id = svc_rdma_create_listen_id(cma_rdma->xpt_net,
 						      sap, cma_xprt);

-- 
2.54.0


