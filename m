Return-Path: <linux-nfs+bounces-22040-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEdSKcSWGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22040-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:25:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B9A5F70BD
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51E18319EE60
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2728133ADBF;
	Thu, 28 May 2026 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gQX81fnt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AA2BCF45
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 19:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779995969; cv=none; b=JC7l6tXV1RoZEAr4pGff+lR68jTgf3pTSKZiLjU+IfPcm5Sql8Y1kjaWVm7q/eM7w7R/EXKE+vsfHQEEYxsLw8oXDcLEm8+7grzMlVKUyOwCM+Y1va/zBn8HjD0Ol7wcNdliM2XIfoLKFOa2LEIoYb0movOgGX7pQnrzD8F9his=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779995969; c=relaxed/simple;
	bh=19cP7/EmJS7NpJUIDWnC+O8se5hl0iSY+wc8Zv4w3kQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UL4aU4BdaTB0K872O1mBBhucTui58umVrOisEzkgfwxJnVKl5yW/OMRic7YhIzpWb04+dQZ3kspcgghMLpQt09eXLFSJLnaSeNMdzbzuFETDUYUR7ick5//VPwOiENAFyQ+YDxHVsfCiAf9BFYRoJRLLLus5DKLseRqidqvniE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gQX81fnt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779995966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=v7OtCuLllx7Qzqc3CX/Z+dGHfgIoMmAN1uq18AQKP0U=;
	b=gQX81fnt77j0IXMDlXg53v7X1jS6kOlsCsbR1PliD4D8BoFwTYS5zGxSA97/qr/LK98wz5
	z4mUmUlYywqftx+FuXnlMAZfBIiuKyhBJgEiEK4iiI/RLnl6H8VFO6ffxRTJ+nxpFta807
	4EpyHTeFTjYHZ7Snqz1KD/4kZwyne8g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-dJGx4SISNBW9zz3Co9fM4g-1; Thu,
 28 May 2026 15:19:25 -0400
X-MC-Unique: dJGx4SISNBW9zz3Co9fM4g-1
X-Mimecast-MFC-AGG-ID: dJGx4SISNBW9zz3Co9fM4g_1779995964
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7AB4619560A5
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 19:19:24 +0000 (UTC)
Received: from bighat.com (unknown [10.22.89.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 049D419560A3
	for <linux-nfs@vger.kernel.org>; Thu, 28 May 2026 19:19:23 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] Removed warnings in nfs_sockaddr2universal()
Date: Thu, 28 May 2026 15:19:22 -0400
Message-ID: <20260528191922.67906-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22040-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 09B9A5F70BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

in function 'nfs_sockaddr2universal',
    inlined from 'nsm_xmit_getaddr.constprop' at ../../support/nsm/rpc.c:251:17:
../../support/nfs/getport.c:459:24: warning: 'strndup' specified bound 108 exceeds source size 26 [-Wstringop-overread]
  459 |                 return strndup(sun->sun_path, sizeof(sun->sun_path));
      |                        ^

Signed-off-by: Steve Dickson <steved@redhat.com>
---
This is a chatgpt solution to remove the warning... untested (yet)
---
 support/nfs/getport.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/support/nfs/getport.c b/support/nfs/getport.c
index 813f7bf9..608e185b 100644
--- a/support/nfs/getport.c
+++ b/support/nfs/getport.c
@@ -452,11 +452,12 @@ char *nfs_sockaddr2universal(const struct sockaddr *sap)
 	uint16_t port;
 	size_t count;
 	char *result;
-	int len;
+	int len = sizeof(struct sockaddr);
 
 	switch (sap->sa_family) {
 	case AF_LOCAL:
-		return strndup(sun->sun_path, sizeof(sun->sun_path));
+		size_t path_len = len - offsetof(struct sockaddr_un, sun_path);
+		return strndup(sun->sun_path, path_len);
 	case AF_INET:
 		if (inet_ntop(AF_INET, (const void *)&sin->sin_addr.s_addr,
 					buf, (socklen_t)sizeof(buf)) == NULL)
-- 
2.54.0


