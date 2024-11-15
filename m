Return-Path: <linux-nfs+bounces-8001-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DE39CE0D0
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 15:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 626B51F21C12
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Nov 2024 14:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720451CD20F;
	Fri, 15 Nov 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y5hkpF4z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E51CDA01
	for <linux-nfs@vger.kernel.org>; Fri, 15 Nov 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679193; cv=none; b=NCXxbI1937d8E73ZmXbYtL0t5kYjXb+j+RFoVOZ9gZi5g58vkm5zVvbZFWXhaB3fUFBxLb+rjRUjdEtJaDRUdyk0sR4PXOkdVKGfKEGRJRXbOqaxH0zvRqJCCsMRzSTam8N2ZV0f71aKoiKw0RHC006tVTPEoYnMuZJfTNguLIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679193; c=relaxed/simple;
	bh=Hbk4G+p+XBUkLdFeQDGLNEGtIRngQWxS3btzm3A8L+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sypcSOtxqE1oKAuGsSV7KEGSx/jxBIGox/L2Bu7/u6hh3LacBRcen3cSqqK9UUE5A43gU6qzYMR/NvuvZUJdPpVybOpPZnFA2lurhN9nbS0sDcDoRURpYtUDNBPlhn/KNZx7xjT2yN4kmAZPo/PJa9o55tkX5ny75BA4UVKHSqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y5hkpF4z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731679190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HrpURNc3s1+sOKqNJ75eMn2RRnYZdy4xSGq8FIqJePo=;
	b=Y5hkpF4zUm1Nz+pje/Littyi5cHix7TeTUKjT19yKtn+BIfy69hCqMpexC2n7CKXpZaEPV
	HG6PnZToSHgJCO2JCw9lTWZ8FqenBpidOTrbMb2gxH95vEgjr+jQsHtr+WZRiIQefrKk7A
	+wlRJ1Qcwx5dDEQgpUWmyI3/QT4PI6c=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-xKA4yg8cN8m6ffypOTUycQ-1; Fri,
 15 Nov 2024 08:59:45 -0500
X-MC-Unique: xKA4yg8cN8m6ffypOTUycQ-1
X-Mimecast-MFC-AGG-ID: xKA4yg8cN8m6ffypOTUycQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 238731955F41;
	Fri, 15 Nov 2024 13:59:44 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DA0D61953880;
	Fri, 15 Nov 2024 13:59:42 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: timeout and cancel TLS handshake with -ETIMEDOUT
Date: Fri, 15 Nov 2024 08:59:36 -0500
Message-ID: <ee226061afc4152fb8c6a829565dc5af390842ec.1731678901.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

We've noticed a situation where an unstable TCP connection can cause the
TLS handshake to timeout waiting for userspace to complete it.  When this
happens, we don't want to return from xs_tls_handshake_sync() with zero, as
this will cause the upper xprt to be set CONNECTED, and subsequent attempts
to transmit will be returned with -EPIPE.  The sunrpc machine does not
recover from this situation and will spin attempting to transmit.

The return value of tls_handshake_cancel() can be used to detect a race
with completion:

 * tls_handshake_cancel - cancel a pending handshake
 * Return values:
 *   %true - Uncompleted handshake request was canceled
 *   %false - Handshake request already completed or not found

If true, we do not want the upper xprt to be connected, so return
-ETIMEDOUT.  If false, its possible the handshake request was lost and
that may be the reason for our timeout.  Again we do not want the upper
xprt to be connected, so return -ETIMEDOUT.

Ensure that we alway return an error from xs_tls_handshake_sync() if we
call tls_handshake_cancel().

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/sunrpc/xprtsock.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 1326fbf45a34..95161a8cd138 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -2614,11 +2614,10 @@ static int xs_tls_handshake_sync(struct rpc_xprt *lower_xprt, struct xprtsec_par
 	rc = wait_for_completion_interruptible_timeout(&lower_transport->handshake_done,
 						       XS_TLS_HANDSHAKE_TO);
 	if (rc <= 0) {
-		if (!tls_handshake_cancel(sk)) {
-			if (rc == 0)
-				rc = -ETIMEDOUT;
-			goto out_put_xprt;
-		}
+		tls_handshake_cancel(sk);
+		if (rc == 0)
+			rc = -ETIMEDOUT;
+		goto out_put_xprt;
 	}
 
 	rc = lower_transport->xprt_err;

base-commit: a9cda7c0ffedb47b23002e109bd26ab2a2ab99c9
-- 
2.47.0


