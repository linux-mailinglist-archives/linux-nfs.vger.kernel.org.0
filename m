Return-Path: <linux-nfs+bounces-8908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C97CA0157E
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3D6163941
	for <lists+linux-nfs@lfdr.de>; Sat,  4 Jan 2025 15:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD01C5F11;
	Sat,  4 Jan 2025 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrwksU5a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE311CA0
	for <linux-nfs@vger.kernel.org>; Sat,  4 Jan 2025 15:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736004597; cv=none; b=iY18fsOJbXLTa9/etAdSYuIfKq0lTI+FRjNmEd0RV2vNj+GAg+jOHfyttWep4x7CvqKysN/X1nLyfnnYLhQ0DNmNkfgXUawihhf4wuUgx8BU7ThqMTyilid7/hrGSvX/8Usou+SauU3OgCfaY4FF3686VWbbfF1LfMkZl3QjlHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736004597; c=relaxed/simple;
	bh=U57buj9G2siMfW2sXnigbwSKDilrkriOtcFdMRkwtZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GzvgZt2j6trWG9f5x93pMwdQw+nXyVZxC2iBj9oZCg/HxphLmDHUv1JcJVGRNcx7PjHYQXXLVrtRVvcP4c7r8nAE6Go/TDvcWIRncZVBpg5A2lrFFfrg7Y6kIU+zFXpqWF5eVxvX+urRfvrU2LWJV8qVg7cVjNlBVmBKRPMh2Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrwksU5a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736004593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5QfsSW0/w50mw5rP1A7sUS5Wbk8ld/K3Kku0dCFploI=;
	b=KrwksU5adGNJB4a/+RMV/8xPPbx6CLVkg+nwXTcmhiOZDG0mM0r07XTcTizUPKBn/794b/
	RMErCbeOCLe8rRQ61nefjTHdhU4YEvxaoRZg+GKFlReQMMexs3E6703g4/cE9M/pRvJFZS
	9Y7h1AxSh9wIGntD1vZRjIIR1dUXJo4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-jgxWK_AaP4-b5GuROFefkA-1; Sat,
 04 Jan 2025 10:29:50 -0500
X-MC-Unique: jgxWK_AaP4-b5GuROFefkA-1
X-Mimecast-MFC-AGG-ID: jgxWK_AaP4-b5GuROFefkA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBE0919560A5;
	Sat,  4 Jan 2025 15:29:48 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.76.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72002195608A;
	Sat,  4 Jan 2025 15:29:46 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] tls: Fix tls_sw_sendmsg error handling
Date: Sat,  4 Jan 2025 10:29:45 -0500
Message-ID: <9594185559881679d81f071b181a10eb07cd079f.1736004079.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

We've noticed that NFS can hang when using RPC over TLS on an unstable
connection, and investigation shows that the RPC layer is stuck in a tight
loop attempting to transmit, but forever getting -EBADMSG back from the
underlying network.  The loop begins when tcp_sendmsg_locked() returns
-EPIPE to tls_tx_records(), but that error is converted to -EBADMSG when
calling the socket's error reporting handler.

Instead of converting errors from tcp_sendmsg_locked(), let's pass them
along in this path.  The RPC layer handles -EPIPE by reconnecting the
transport, which prevents the endless attempts to transmit on a broken
connection.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index bbf26cc4f6ee..7bcc9b4408a2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -458,7 +458,7 @@ int tls_tx_records(struct sock *sk, int flags)
 
 tx_err:
 	if (rc < 0 && rc != -EAGAIN)
-		tls_err_abort(sk, -EBADMSG);
+		tls_err_abort(sk, rc);
 
 	return rc;
 }

base-commit: 0bc21e701a6ffacfdde7f04f87d664d82e8a13bf
-- 
2.47.0


