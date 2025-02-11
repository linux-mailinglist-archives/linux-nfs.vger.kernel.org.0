Return-Path: <linux-nfs+bounces-10041-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 453DEA31320
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 18:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE243A4066
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Feb 2025 17:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A466261562;
	Tue, 11 Feb 2025 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gO0FsEen"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05872261569
	for <linux-nfs@vger.kernel.org>; Tue, 11 Feb 2025 17:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295128; cv=none; b=rGKDgsxUqBKUDS32qlVSOgv/wXigocQi3nU4j56NpA3Kw02J2GahMxRvsdpUQDNjHKn7/GwEdgbDduZlAGFd8rfFK912us/qCwhOsoKhlTlJ1pKtujF6U8RXowQMW4sjyOJlm/TXMe4nX3V6KEDq2OT/1A8Uxe8vIwFoZQVeOuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295128; c=relaxed/simple;
	bh=gK2JBoO2t/VNfIzxZaIyRkTzYVsQso5hE3lSKqkemFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=USRbADpCFmlG7AipjuuGc+BNXk8uOC3AwPtpSpWGB0zXZ9G/iZ2Uie72R39nMqh4SXstRRG/UszBVzA3p2Uf72SeXAY1rzB/7JjFo5M0V0/MUX7hAysIL0s8hevk3DpW9xKLFMu80EvpTRQ6bwipy1QIyo7fJyK1bSghYyouLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gO0FsEen; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739295124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5ygXg1yAXHTtIVrmRRHbCfErBDRhtDyOq247gftT11M=;
	b=gO0FsEenuKvBjLmi0jcew3l23IBfUT7fQWnLQF9nUPhJnjxe3D90lBJtaWx3239tZ2Khai
	5nbx8GCMN3wxHw1aHlIZxbjqnB8nlPSWnbgzuud3e/CPveRXWyhCMOjkT14bAXAbpo4idL
	GPHynkYkNQWK/HKCni8ZJV1HWqSAezM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-XRQs8HVtOkWTPk-SD-l4XQ-1; Tue,
 11 Feb 2025 12:32:01 -0500
X-MC-Unique: XRQs8HVtOkWTPk-SD-l4XQ-1
X-Mimecast-MFC-AGG-ID: XRQs8HVtOkWTPk-SD-l4XQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 208911955D6A;
	Tue, 11 Feb 2025 17:32:00 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EAD1719560A3;
	Tue, 11 Feb 2025 17:31:58 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Handle -ETIMEDOUT return from tlshd
Date: Tue, 11 Feb 2025 12:31:57 -0500
Message-ID: <614d3c3bcceeedb933400bdc00f812518c05a4a6.1739294902.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

If the TLS handshake attempt returns -ETIMEDOUT, we currently translate
that error into -EACCES.  This becomes problematic for cases where the RPC
layer is attempting to re-connect in paths that don't resonably handle
-EACCES, for example: writeback.  The RPC layer can handle -ETIMEDOUT quite
well, however - so if the handshake returns this error let's just pass it
along.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprtsock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index c60936d8cef7..6b80b2aaf763 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2581,7 +2581,15 @@ static void xs_tls_handshake_done(void *data, int status, key_serial_t peerid)
 	struct sock_xprt *lower_transport =
 				container_of(lower_xprt, struct sock_xprt, xprt);
 
-	lower_transport->xprt_err = status ? -EACCES : 0;
+	switch (status) {
+	case 0:
+	case -EACCES:
+	case -ETIMEDOUT:
+		lower_transport->xprt_err = status;
+		break;
+	default:
+		lower_transport->xprt_err = -EACCES;
+	}
 	complete(&lower_transport->handshake_done);
 	xprt_put(lower_xprt);
 }

base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
-- 
2.47.0


