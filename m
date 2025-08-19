Return-Path: <linux-nfs+bounces-13782-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF02B2CBA9
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 20:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E207F1BC8B3F
	for <lists+linux-nfs@lfdr.de>; Tue, 19 Aug 2025 18:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3128330EF80;
	Tue, 19 Aug 2025 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W40KVOV8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94130EF9D
	for <linux-nfs@vger.kernel.org>; Tue, 19 Aug 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626816; cv=none; b=opCYQ6HoKxlIO+OFgEtN/TAvZJ4jsuOoeFRsZwVosCEjeqN40ivoYUn91RAyKdG1dMFQXuV5pn0hWt8Vm5bzmm3ZGRCDyXjEzPghzIdz0VucAtQzfw4lIK3Lu2MdXoglTwl+EgH5PyHIldfDi6GMmwJXVlWZD2mI1qhqbiGrx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626816; c=relaxed/simple;
	bh=I3W1jikWtKN1PuKLIS7IzkHeMBuAUdWjQkfCtZoW148=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bwBCO/FfTXeP7R+ZLiy2S2Tw+ld0YMdtwYFVoBRNbtzGahhcRVIbVfHBUDLuzMwcCWmzKiiY4jKP2ay1S5fr5f0fC9QC/jFwCr0m0GhH1yjJKV8Xi+2S9vMAb4kGwlpRjNldxJBMgFFUECo1g3aIqHk3bDwBBksW5c4ejzaRu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W40KVOV8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755626806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cqYm/m99tID/jHL4khoHNy8+vtMNv6VMMnm6kUIfjBg=;
	b=W40KVOV8Mpoeile8C3XTrDwz4nypxRORZCVSAB1uWgNnbJIFwai1YlGoaFP7btzXXsmJPx
	VvdR5Rw/CaQEClJGiVebi3TPmBsAOTalou17AfqAKmj0L5gQKAa4TxfLXnU7wgN+WajGGa
	vZ6i0mpyPH9nezcJRMBDjspSQdb70pg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-OIzuGSJWPnS5iePcwo1P-w-1; Tue,
 19 Aug 2025 14:05:01 -0400
X-MC-Unique: OIzuGSJWPnS5iePcwo1P-w-1
X-Mimecast-MFC-AGG-ID: OIzuGSJWPnS5iePcwo1P-w_1755626652
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 556501800290;
	Tue, 19 Aug 2025 18:04:05 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.89.9])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 063931955F24;
	Tue, 19 Aug 2025 18:04:03 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH v2 1/1] nfsd: unregister with rpcbind when deleting a transport
Date: Tue, 19 Aug 2025 14:04:02 -0400
Message-Id: <20250819180403.33090-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When a listener is added, a part of creation of transport also registers
program/port with rpcbind. However, when the listener is removed,
while transport goes away, rpcbind still has the entry for that
port/type.

When deleting the transport, unregister with rpcbind when appropriate.

---v2 created a new xpt_flag XPT_RPCB_UNREG to mark TCP and UDP
transport and at xprt destroy send rpcbind unregister if flag set.

Suggested-by: Chuck Lever <chuck.lever@oracle.com>
Fixes: d093c9089260 ("nfsd: fix management of listener transports")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 include/linux/sunrpc/svc_xprt.h |  3 +++
 net/sunrpc/svc_xprt.c           | 13 +++++++++++++
 net/sunrpc/svcsock.c            |  2 ++
 3 files changed, 18 insertions(+)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index 369a89aea186..2b886f7eb295 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -104,6 +104,9 @@ enum {
 				 * it has access to.  It is NOT counted
 				 * in ->sv_tmpcnt.
 				 */
+	XPT_RPCB_UNREG,		/* transport that needs unregistering
+				 * with rpcbind (TCP, UDP) on destroy
+				 */
 };
 
 /*
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8b1837228799..b800d704d807 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1014,6 +1014,19 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	struct svc_serv	*serv = xprt->xpt_server;
 	struct svc_deferred_req *dr;
 
+	/* unregister with rpcbind for when transport type is TCP or UDP.
+	 */
+	if (test_bit(XPT_RPCB_UNREG, &xprt->xpt_flags)) {
+		struct svc_sock *svsk = container_of(xprt, struct svc_sock,
+						     sk_xprt);
+		struct socket *sock = svsk->sk_sock;
+
+		if (svc_register(serv, xprt->xpt_net, sock->sk->sk_family,
+				 sock->sk->sk_protocol, 0) < 0)
+			pr_warn("failed to unregister %s with rpcbind\n",
+				xprt->xpt_class->xcl_name);
+	}
+
 	if (test_and_set_bit(XPT_DEAD, &xprt->xpt_flags))
 		return;
 
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index c0d5a27ba674..7b90abc5cf0e 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -836,6 +836,7 @@ static void svc_udp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	/* data might have come in before data_ready set up */
 	set_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	set_bit(XPT_CHNGBUF, &svsk->sk_xprt.xpt_flags);
+	set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 
 	/* make sure we get destination address info */
 	switch (svsk->sk_sk->sk_family) {
@@ -1350,6 +1351,7 @@ static void svc_tcp_init(struct svc_sock *svsk, struct svc_serv *serv)
 	if (sk->sk_state == TCP_LISTEN) {
 		strcpy(svsk->sk_xprt.xpt_remotebuf, "listener");
 		set_bit(XPT_LISTENER, &svsk->sk_xprt.xpt_flags);
+		set_bit(XPT_RPCB_UNREG, &svsk->sk_xprt.xpt_flags);
 		sk->sk_data_ready = svc_tcp_listen_data_ready;
 		set_bit(XPT_CONN, &svsk->sk_xprt.xpt_flags);
 	} else {
-- 
2.47.1


