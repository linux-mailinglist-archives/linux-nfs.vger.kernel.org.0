Return-Path: <linux-nfs+bounces-21774-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF4eKU2cD2qCNwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21774-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:59:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A77E5AD29A
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 01:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFA1030CCC5B
	for <lists+linux-nfs@lfdr.de>; Thu, 21 May 2026 23:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8FA384CDA;
	Thu, 21 May 2026 23:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mkh8EVpv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475C3876D7
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779407251; cv=none; b=RutH01bPWlHPCkdO05goYjv8Dco/t5MFAfXkHs1tg/oWKo0H/jj4jW8rCfJR/j/+0T4SN5sE5cn1P0kZHdjhJxlFfTIxk1Flvyi5cnJ5M+h3Jkx4WCpfRoKgYLV84zIxnR85uKSS7QCy4PngoW9xX3adtNlRu+mlBUGl4ggp9Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779407251; c=relaxed/simple;
	bh=pDptKCIoeW3hG+KBwTsbDbuESh0Bnxq7XGybx6v08Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vps+kWdq4csTVnoEzCS0uyWZSP3JkewPLCCSoczeBnIzEztwZtrT9Zk3jjjrL2nQ/flMWjIWfEo24FHdYCyQWTmG0Ka9mY898PLaBcWIAzZoCtEeNjN+ra0fVNwY/EEnaUZwuVg3dt5ZosOobMKCvweifGzcUWCE5prVKWWgUyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mkh8EVpv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779407244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vc7MrB+++fJHsHkfJ2col7KiVSXpGX1Q8ed4zsa/bRo=;
	b=Mkh8EVpvwkcpHuZ8y9ftWE2zxRg4h6mSjPgE8Fi1maCzsKzFECqac/4qD7wWY2ztQi57Us
	j02d45IcbJVw15KO+zjs/Z/lU+CCu4k60v0P1EbgrEt3P05xYqCa0G/3OanCZWWQE4rMEW
	N12WAWhXAEudB9WkBcOPQLPiqSMYMZY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-9bHrBa-VM5y9pDAvEJAViQ-1; Thu,
 21 May 2026 19:47:22 -0400
X-MC-Unique: 9bHrBa-VM5y9pDAvEJAViQ-1
X-Mimecast-MFC-AGG-ID: 9bHrBa-VM5y9pDAvEJAViQ_1779407241
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B8D81956088
	for <linux-nfs@vger.kernel.org>; Thu, 21 May 2026 23:47:21 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.88.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 002B819560A3;
	Thu, 21 May 2026 23:47:20 +0000 (UTC)
Received: from aion.redhat.com (localhost [IPv6:::1])
	by aion.redhat.com (Postfix) with ESMTP id 4155E8A8683;
	Thu, 21 May 2026 19:47:20 -0400 (EDT)
From: Scott Mayhew <smayhew@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] rpcbind: fix memory leaks in network_init()
Date: Thu, 21 May 2026 19:47:19 -0400
Message-ID: <20260521234720.818996-3-smayhew@redhat.com>
In-Reply-To: <20260521234720.818996-1-smayhew@redhat.com>
References: <20260521234720.818996-1-smayhew@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21774-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[smayhew@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6A77E5AD29A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1. Before reusing res in another getaddrinfo() call, we need to free the
   previous value stored there.  Fixes memory leaks such as:

==8754== 128 (64 direct, 64 indirect) bytes in 1 blocks are definitely lost in loss record 68 of 93
==8754==    at 0x484C826: malloc (vg_replace_malloc.c:447)
==8754==    by 0x4B7C296: generate_addrinfo (getaddrinfo.c:1090)
==8754==    by 0x4B7C296: gaih_inet (getaddrinfo.c:1208)
==8754==    by 0x4B7C296: getaddrinfo (getaddrinfo.c:2387)
==8754==    by 0x40BF9D: network_init (util.c:316)
==8754==    by 0x405E1D: main (rpcbind.c:361)

2. getifaddrs() needs to be paired with freeifaddrs().  Fixes memory
   leaks such as:

==8754== 1,296 bytes in 1 blocks are definitely lost in loss record 89 of 93
==8754==    at 0x485436B: calloc (vg_replace_malloc.c:1616)
==8754==    by 0x4B5D0BD: getifaddrs_internal (ifaddrs.c:405)
==8754==    by 0x4B5E357: getifaddrs (ifaddrs.c:831)
==8754==    by 0x40BFEF: network_init (util.c:347)
==8754==    by 0x405E1D: main (rpcbind.c:361)

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 src/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/util.c b/src/util.c
index 4af8b9b..ead4899 100644
--- a/src/util.c
+++ b/src/util.c
@@ -328,6 +328,7 @@ network_init()
 
 #ifdef INET6
 	hints.ai_family = AF_INET6;
+	freeaddrinfo(res);
 	if ((ecode = getaddrinfo(NULL, "sunrpc", &hints, &res))) {
 		if (debugging)
 			fprintf(stderr, "can't get local ip6 address: %s\n",
@@ -355,6 +356,7 @@ network_init()
 	if (s < 0) {
 	    if (debugging)
 		    fprintf(stderr, "socket(AF_INET6) failed: %s\n", strerror(errno));
+	    freeifaddrs(ifp);
 	    freeaddrinfo (res);
 	    return;
 	}
@@ -381,6 +383,7 @@ network_init()
 				perror("setsockopt v6 multicast");
 	}
 	close(s);
+	freeifaddrs(ifp);
 #endif
 	freeaddrinfo (res);
 }
-- 
2.54.0


