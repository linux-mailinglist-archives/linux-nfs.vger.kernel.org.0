Return-Path: <linux-nfs+bounces-2892-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D0E8AA5F7
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Apr 2024 01:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40278285B12
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Apr 2024 23:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3041F6A025;
	Thu, 18 Apr 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="Y5KCgxxV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B7C54907
	for <linux-nfs@vger.kernel.org>; Thu, 18 Apr 2024 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483552; cv=none; b=EJ38mSiN+Q4rVdwx386eGAn/A554RiwyXugS8NqBxhF6iKIJLUpgrrmHpurWQ7rmomvXpKScd1CaKUPvoV5Ur0gvCmW71v+ydA21z+mEuUJoU7DamEMWf2DGG7/TDHK12fBtKc3m478xeGtdCPvbHPwEWF30i4tX5i2SS00oCnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483552; c=relaxed/simple;
	bh=PNDHf/Dx3byc5ncHAW+Oq1n3hZaH/igRKzPg457xoSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NI/J1IlDWH4GewK5KaSAgXxg3TnoA30wsc1Xixd4JUc0VC+bYEfNovdxvP7LxIqcEyzbWmgFvINHhxwMiiagTFgfNmq+HsEC3r0LbCYX1Mw7oZYvSOz14PbcByt5ptyqOuBS4xl1O1DsZjJkn0/81lg7WXg8FmqtDwqrLrqAoZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=Y5KCgxxV; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8DE1480006C;
	Thu, 18 Apr 2024 23:39:07 +0000 (UTC)
Received: from carkeek.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id DAF2313C2B0;
	Thu, 18 Apr 2024 16:39:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DAF2313C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1713483546;
	bh=PNDHf/Dx3byc5ncHAW+Oq1n3hZaH/igRKzPg457xoSM=;
	h=From:To:Cc:Subject:Date:From;
	b=Y5KCgxxVH0CRWrU/Lwg0MKZCacGD0Zrw3F0uVrs2lLaol13Z9ncxDpihb01X2lBTm
	 tIRIm2WjSqXoNzzmR/34xFx/e0Qlv7ypFTOPAZEZ5ClZTzsyAfvbqv+PoQ+DC8e6jU
	 SfaHQcz9KB9nKQg5fMtuhWaSDRw4U9bodX+OxpHk=
From: Rory Little <rory@candelatech.com>
To: linux-nfs@vger.kernel.org
Cc: jlayton@kernel.org,
	Rory Little <rory@candelatech.com>
Subject: [PATCH] sunrpc: Only defer bind to ephemeral ports if a srcaddr has not been set
Date: Thu, 18 Apr 2024 16:38:28 -0700
Message-Id: <20240418233828.1799437-1-rory@candelatech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1713483548-0eafaXn1PSse
X-MDID-O:
 us5;at1;1713483548;0eafaXn1PSse;<rory@candelatech.com>;4386b9add147bdd7cd0f741f08a4a119

The previous binding behavior ignores the possible need to bind to a
local ip address as well as a port in the event that an ephemeral port
is requested. In this event, the binding would be done at connect time,
where all information about desired source addresses is inaccessible.

Instead, we need to consider the case where a source address is given,
in which case the sockaddr will be given an address of 0.0.0.0 or ::0.
We can use these values as a second condition when choosing to defer
the socket binding.

Signed-off-by: Rory Little <rory@candelatech.com>
---
 net/sunrpc/xprtsock.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index bb9b747d58a1..0139db7424aa 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1736,6 +1736,23 @@ static void xs_set_port(struct rpc_xprt *xprt, unsigned short port)
 	xs_update_peer_port(xprt);
 }
 
+static bool xs_is_anyaddr(const struct sockaddr *sap)
+{
+	switch (sap->sa_family) {
+	case AF_LOCAL:
+		return true;
+	case AF_INET:
+		return ((struct sockaddr_in *)sap)->sin_addr.s_addr == htonl(INADDR_ANY);
+	case AF_INET6:
+		return !memcmp(&((struct sockaddr_in6 *)sap)->sin6_addr, &in6addr_any,
+			       sizeof(struct in6_addr));
+	default:
+		dprintk("RPC:       %s: Bad address family %d\n", __func__, sap->sa_family);
+	}
+
+	return false;
+}
+
 static void xs_reset_srcport(struct sock_xprt *transport)
 {
 	transport->srcport = 0;
@@ -1818,8 +1835,11 @@ static int xs_bind(struct sock_xprt *transport, struct socket *sock)
 	 * transport->xprt.resvport == 1) xs_get_srcport above will
 	 * ensure that port is non-zero and we will bind as needed.
 	 */
-	if (port <= 0)
+	if (port <= 0 && xs_is_anyaddr((struct sockaddr *)&transport->srcaddr)) {
+		dprintk("RPC:       %s: Deferring bind to invalid or ephemeral port: %d\n",
+			__func__, port);
 		return port;
+	}
 
 	memcpy(&myaddr, &transport->srcaddr, transport->xprt.addrlen);
 	do {
-- 
2.34.1


