Return-Path: <linux-nfs+bounces-7661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 423C69BC0A0
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 23:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9F3282ABC
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Nov 2024 22:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81871F7553;
	Mon,  4 Nov 2024 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8r7ijpf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDC51AAE27
	for <linux-nfs@vger.kernel.org>; Mon,  4 Nov 2024 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758297; cv=none; b=GbTS2SGWcF7eW0yRY70KsVUYpHz5ELnjq9qJ7cW9e3w+OCinJozbNBF0jX7y5acTCJw/Amimk8Oc0AKU1scRsPM8IRIdUFb95C8g3nZW/SWOEu6bUImeMhX2vNx9kneFtY3DPC6Qwd+ag/gKI3fS1q0R+ZH6JPaPvTHlk6rHAMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758297; c=relaxed/simple;
	bh=Wn0Dhi+TuBUlSWjDq3zWU8QHO8cOme8m+M5a7vrSukI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPvB+xAiztoOL6rLL4euLqeYhiJiTN3+ZTAbg6//fLzbyuWNtfii2yG5gZV3aAkgnh7yhxIkFLGqlVPL+ng1fjCsETVfaKOEGDucTXpc3MrQwBtT3eBX+rxp0sAb49pxo48uwiLPbp+OIPPaik07GC/4LIsaHnz82zszlZPXbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8r7ijpf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730758293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hTd3u4boJekTUbnUXXQVXV6oRkG6/ipNFBye8AsM41E=;
	b=h8r7ijpfLpPrw+3FlbSKXojZOi41sajI4DtQ8by8Yppfl2lEYwtLQYO2cMnS5a/eplXxqp
	la0ib4+fxS2gkTNq1ObTMBzimKfv+yUMn3W6e+V7mdqgwo7upDcB6nuZ8fCw5bNbwwJO4V
	h7kz/q5auytEEqMnydXxnS7SM769k4A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-w-1_XfDANuy8KNaDp6b9Wg-1; Mon,
 04 Nov 2024 17:11:30 -0500
X-MC-Unique: w-1_XfDANuy8KNaDp6b9Wg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70CCD1956096;
	Mon,  4 Nov 2024 22:11:29 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.17])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30B6319560AA;
	Mon,  4 Nov 2024 22:11:28 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Fix a hang in TLS sock_close if sk_write_pending
Date: Mon,  4 Nov 2024 17:11:27 -0500
Message-ID: <5c2d3830c23146af5e1935df9e646113a8b8e4ad.1730758056.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We've observed an NFS server shrink the TCP window and then reset the TCP
connection as part of a HA failover.  When the connection has TLS, often
the NFS client will hang indefinitely in this stack:

     wait_woken+0x70/0x80
     wait_on_pending_writer+0xe4/0x110 [tls]
     tls_sk_proto_close+0x368/0x3a0 [tls]
     inet_release+0x54/0xb0
     __sock_release+0x48/0xc8
     sock_close+0x20/0x38
     __fput+0xe0/0x2f0
     __fput_sync+0x58/0x70
     xs_reset_transport+0xe8/0x1f8 [sunrpc]
     xs_tcp_shutdown+0xa4/0x190 [sunrpc]
     xprt_autoclose+0x68/0x170 [sunrpc]
     process_one_work+0x180/0x420
     worker_thread+0x258/0x368
     kthread+0x104/0x118
     ret_from_fork+0x10/0x20

This hang prevents the client from closing the socket and reconnecting to
the server.

Because xs_nospace() elevates sk_write_pending, and sk_sndtimeo is
MAX_SCHEDULE_TIMEOUT, tls_sk_proto_close is never able to complete its wait
for pending writes to the socket.  For this case where we are resetting the
transport anyway, we don't expect the socket to ever have write space, so
fix this by simply clearing the sock's sndtimeo under the sock's lock.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprtsock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 0e1691316f42..8b56d4a8c660 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1278,6 +1278,7 @@ static void xs_reset_transport(struct sock_xprt *transport)
 	transport->file = NULL;
 
 	sk->sk_user_data = NULL;
+	sk->sk_sndtimeo = 0;
 
 	xs_restore_old_callbacks(transport, sk);
 	xprt_clear_connected(xprt);

base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
-- 
2.47.0


