Return-Path: <linux-nfs+bounces-16615-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EF23FC73E9F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 13:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C5EC628D4B
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Nov 2025 12:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BB51F37A1;
	Thu, 20 Nov 2025 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxDd+ZrX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A562304BD6
	for <linux-nfs@vger.kernel.org>; Thu, 20 Nov 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640783; cv=none; b=gbtFwJAFKDRZxLZEBT+koNHg9zTTAfI2ikaMg9zy5zE7Y2usvQubxBhfOPVHH0c55lA3HDWTiX7BdiupxTnooqaVWk74s1vKci7TilIGfJe5wArR8Dv+KlmMi4O04TTcVfNYaQiHVlpZVg2XSZOoU4XBKhK3fGyI/JAn5ynSvY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640783; c=relaxed/simple;
	bh=gaULbjt2BgbiIiJf7J5YW6STxksEUNiGiuhQ57CtdjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VlXQRX1NNr5zgdff7GBqu3rh60icVTEiKde1uZuVGSw2MsjHyS4Jcn+KepmY1RmvxDhxDCAIS/4pmR0Ko7OMk6PpXyQMyeRxA1mZfS5xSQBqzq3NxcGJKaRAe59M7fx/IWPHK2AmcqUxvDpHnzWgp/I/7wbgkAhgtGoD9l/zq4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxDd+ZrX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763640779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jIoPyEZxlrqImoH/e33Rs/0Dmxv/uLu+sTTbEyIm5b4=;
	b=CxDd+ZrXhz/adSvvnQsSDEPcY/SSrv3s4ZFxgXaJn1fnDtbmEp+NERmPVAVMOzbqq/fSGj
	rMXs7l4WY2i1b0RaQmk26BvAsyFA2ZX0bnE9y7sPt51iKbnS8zws+yMs9vw3PeilBUoCeA
	frabw4ZLnWE6flpjRYqpAXXu4Gf384E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-oNFNARbfNe-YRQh6QcjH2Q-1; Thu,
 20 Nov 2025 07:12:56 -0500
X-MC-Unique: oNFNARbfNe-YRQh6QcjH2Q-1
X-Mimecast-MFC-AGG-ID: oNFNARbfNe-YRQh6QcjH2Q_1763640775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3FD381956068;
	Thu, 20 Nov 2025 12:12:55 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.81.26])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E51011940E85;
	Thu, 20 Nov 2025 12:12:54 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id CDBF650BF78;
	Thu, 20 Nov 2025 07:12:52 -0500 (EST)
From: Scott Mayhew <smayhew@redhat.com>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2] SUNRPC: Check if we need to recalculate slack estimates
Date: Thu, 20 Nov 2025 07:12:52 -0500
Message-ID: <20251120121252.3724988-1-smayhew@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

If the incoming GSS verifier is larger than what we previously recorded
on the gss_auth, that would indicate the GSS cred/context used for that
RPC is using a different enctype than the one used by the machine
cred/context, and we should recalculate the slack variables accordingly.

Link: https://bugs.debian.org/1120598
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 net/sunrpc/auth_gss/auth_gss.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5c095cb8cb20..bff5f10581a2 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1721,6 +1721,18 @@ gss_validate(struct rpc_task *task, struct xdr_stream *xdr)
 	if (maj_stat)
 		goto bad_mic;
 
+	/*
+	 * Normally we only recalculate the slack variables once after
+	 * creating a new gss_auth, but we should also do it if the incoming
+	 * verifier has a larger size than what was previously recorded.
+	 * When the incoming verifier is larger than expected, the
+	 * GSS context is using a different enctype than the one used
+	 * initially by the machine credential. Force a slack size update
+	 * to maintain good payload alignment.
+	 */
+	if (cred->cr_auth->au_verfsize < (XDR_QUADLEN(len) + 2))
+		__set_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags);
+
 	/* We leave it to unwrap to calculate au_rslack. For now we just
 	 * calculate the length of the verifier: */
 	if (test_bit(RPCAUTH_AUTH_UPDATE_SLACK, &cred->cr_auth->au_flags))
-- 
2.51.0


