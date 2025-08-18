Return-Path: <linux-nfs+bounces-13742-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66014B2B03E
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 20:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA9617B6A2
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Aug 2025 18:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B033314A2;
	Mon, 18 Aug 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GIqGdsRT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE93314A1
	for <linux-nfs@vger.kernel.org>; Mon, 18 Aug 2025 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541572; cv=none; b=RTyns/fSSm3ce6VcEyeUGHZorKgy6a7yOidloy5MUCMKLBjiCTOZ1mMCi66oCQ1S//gnNGcMUGx5Aj/qnFfjq+WdwPLoe/JymoKJ+lUcgarlhySsbjUl/NQ5G3w3unEjh8WZ7zbKPjNBVHPcXQSE0zoiRrttjL4kLVJvqSGkCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541572; c=relaxed/simple;
	bh=DL3Q+Sq/lfN1yajqa/9sGDP9XPQQmZIgP9Q9oumFU+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=khQqqfNgo9sTRb9PWMoqPtAd1+LcP8cKUEtRfhPVq2mxgRKjRsyxsj4pjBXog5bhHg+DExy9x4sgJn+JDLxi9YdDl+n3cy9VFVCpjj9tg+zvHTeg8WYNzFesOinYmHNhmDLmXefPv+mAZN8SnorNthzmF6sLqeo/YU6tdzcXTms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GIqGdsRT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755541569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xTTr85FTrHx+UNpfm9rwqNnrzwBymKvjmG157abacSQ=;
	b=GIqGdsRTtGoYjv2NEhI0tdzJlCGrjrGtHT6J0jP800T+v0arpFENTXtT/T1CdZVB9KNxzo
	m2jAzgh4fGILyTQZwjoe1GQaOTdzSfEDZNFh571R/HzaICEtCcxQxw2qTC3fPODbyFC3hj
	uLSBz+xI0NaEshRWal5Xdx6eA/usHdE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664--Mv9xslQPmOt2ox5sGk9hQ-1; Mon,
 18 Aug 2025 14:26:02 -0400
X-MC-Unique: -Mv9xslQPmOt2ox5sGk9hQ-1
X-Mimecast-MFC-AGG-ID: -Mv9xslQPmOt2ox5sGk9hQ_1755541560
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05E9A19560A0;
	Mon, 18 Aug 2025 18:26:00 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.66.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B4C418004A3;
	Mon, 18 Aug 2025 18:25:58 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: chuck.lever@oracle.com,
	jlayton@kernel.org
Cc: linux-nfs@vger.kernel.org,
	neil@brown.name,
	Dai.Ngo@oracle.com,
	tom@talpey.com
Subject: [PATCH 1/1] nfsd: unregister with rpcbind when deleting a transport
Date: Mon, 18 Aug 2025 14:25:57 -0400
Message-Id: <20250818182557.11259-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When a listener is added, a part of creation of transport also registers
program/port with rpcbind. However, when the listener is removed,
while transport goes away, rpcbind still has the entry for that
port/type.

When deleting the transport, unregister with rpcbind when appropriate.

Fixes: d093c9089260 ("nfsd: fix management of listener transports")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 net/sunrpc/svc_xprt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 8b1837228799..223737fac95d 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1014,6 +1014,23 @@ static void svc_delete_xprt(struct svc_xprt *xprt)
 	struct svc_serv	*serv = xprt->xpt_server;
 	struct svc_deferred_req *dr;
 
+	/* unregister with rpcbind for when transport type is TCP or UDP.
+	 * Only TCP and RDMA sockets are marked as LISTENER sockets, so
+	 * check for UDP separately.
+	 */
+	if ((test_bit(XPT_LISTENER, &xprt->xpt_flags) &&
+	    xprt->xpt_class->xcl_ident != XPRT_TRANSPORT_RDMA) ||
+	    xprt->xpt_class->xcl_ident == XPRT_TRANSPORT_UDP) {
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
 
-- 
2.47.1


