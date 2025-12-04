Return-Path: <linux-nfs+bounces-16909-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B522CA55FD
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 21:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8E9A300C232
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582333164A6;
	Thu,  4 Dec 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4IhURm5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D53316904
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881345; cv=none; b=nIer7HRITKEGX7vcHmnDZGY9JGCWY9CaF+Kii5HKX60zFnZRBpMHt1pV64Vtlo1ssEcgjUQxwTnaA5PKJkoCl4trDp6mjAF712/LGvrzjzEanA+AB3xOb8mHSyvU0A4Hi6T0x2ccnZ3Gq3VN0JtvUZPUBu0HMYEgJnwvxQCzxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881345; c=relaxed/simple;
	bh=ZBor8csrxyl+jnZPgzSCErydHK7t1jSEs+iRMB0QEjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mk0PHJwT7FvBmiQFXAOScq66XDPAnmktwBI2GnKuucPouQ3xZ+ugRfbFmk8vucrgBnEOIxquIbs9zexIOz3txUp00i9cDd9y8shmLa/QYnBYPvHKxDMlVaEh94IHlLIkVeD8ZEWwyqvmjjMfsFQU05pvrmxOma0upqRaWY1ikOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K4IhURm5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764881338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qU6bG+EkSfDWS3zE20MWbO2V+K6RMnoSLVxqlSJtJh4=;
	b=K4IhURm5VvikiDcL/1EFHTjz5iZG2rkAw0gPlU15v8tsEHFQgmhbzDXIqQ6Sy/Byol9mIA
	jNoVohf6Zp4FgWpJdtJgySVsGgVx9T+kzThgDClTK1abcBGkG5pZdMaKPnbMruRYQui3gP
	uvB9uyqHIgX7dYGc+XaVGV+bk7hs65g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-WAogVWxhPBippovwPJJQpA-1; Thu,
 04 Dec 2025 15:48:56 -0500
X-MC-Unique: WAogVWxhPBippovwPJJQpA-1
X-Mimecast-MFC-AGG-ID: WAogVWxhPBippovwPJJQpA_1764881336
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23AF918001DE
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 20:48:56 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.26])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CB6E1800298;
	Thu,  4 Dec 2025 20:48:55 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfs-utils: nfsdctl: ignore ipv6 listener creation error
Date: Thu,  4 Dec 2025 15:48:54 -0500
Message-ID: <20251204204854.91431-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

If ipv6 is not supported by the kernel and during the nfsd start
we are trying to create an ipv6 listener, ignore the error (this
restores how nfsd handled this failure).

Fixes: 8b02f0d5590e ("nfsdctl: cleanup listeners if some failed")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index eb0b8e7d..ecce66b5 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -967,6 +967,17 @@ static void print_listeners(void)
 	}
 }
 
+static bool ipv6_is_enabled(void)
+{
+	int s;
+
+	s = socket(AF_INET6, SOCK_STREAM, 0);
+	if (s < 0)
+		return false;
+	close(s);
+	return true;
+}
+
 /*
  * Format is <+/-><netid>:<address>:port
  *
@@ -1081,7 +1092,8 @@ static int update_listeners(const char *str)
 					continue;
 			case AF_INET6:
 				if (r6->sin6_port != l6->sin6_port ||
-				    memcmp(&r6->sin6_addr, &l6->sin6_addr, sizeof(l6->sin6_addr)))
+				    memcmp(&r6->sin6_addr, &l6->sin6_addr, sizeof(l6->sin6_addr)) ||
+				    !ipv6_is_enabled())
 					continue;
 			default:
 
@@ -1127,6 +1139,11 @@ static int set_listeners(struct nl_sock *sock)
 		struct server_socket *sock = &nfsd_sockets[i];
 		struct nlattr *a;
 
+		if (sock->ss.ss_family == AF_INET6 && !ipv6_is_enabled()) {
+			xlog(L_WARNING, "IPv6 isn't enabled, skip IPv6 "
+					"listener\n");
+			continue;
+		}
 		if (sock->ss.ss_family == 0)
 			break;
 
-- 
2.47.3


