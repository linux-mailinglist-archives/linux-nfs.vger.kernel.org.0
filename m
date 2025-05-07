Return-Path: <linux-nfs+bounces-11561-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B08CAADDA6
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 13:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C71B84A12F4
	for <lists+linux-nfs@lfdr.de>; Wed,  7 May 2025 11:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD38234970;
	Wed,  7 May 2025 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvOZdt0K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C920A24DFF6
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618255; cv=none; b=MWtXQdn77N34el6BRCMTUXVmeeM+C/8hhQWS8Uizdi3sB/yf3nywLQ+xlskoc2zO08bNkv/xrF+ipoodL6y9nS31SEu/I4YHGLJ7aHsW0MjVIvE0H5bM7T96a2fJI7SDZXRCIbejjnTPeKDhFEiopIWfQwQm3UGG/mKCUp8eJ1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618255; c=relaxed/simple;
	bh=JM2uua32zYxY+v+E41TLKeEtFDcnY2NrMVLdibGfq00=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HGaUkTkmAjZ15ojTHZzQezUkquyQR9fLajZehDjhymHMh1DCeOj0Ji7XSCjjGDGKLof4JAe+Lc64TArEfl8iBsgNCchxPUtu1SkipVXLLHoSHpbULLfl9lxxLqoyb6+x/ZPXhNI/7+1S54oS9l+gh/loR9Capa1SmF4VmN60Rok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvOZdt0K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746618251;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2T4963+h9fGmgUuI3+2RDiR456W/f3Td1+AewO9Kiss=;
	b=VvOZdt0K+RiX186NmHmIDYc7H143A8sXf0th/WnWvCqAmjdyQEVjZrrFIpYoMLZNBIgCxQ
	rLuvy/1XagRusUhEnQFKcNk8RhvcCNDRB/D/lPrZQ5cddolOC3srxJh77wpKnOpHrTrCNk
	lXvWxvghfL1jGhfUcJmpRuhuVlpEBwU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-34NFHiOgMbaGBeDTLnsRKg-1; Wed,
 07 May 2025 07:44:10 -0400
X-MC-Unique: 34NFHiOgMbaGBeDTLnsRKg-1
X-Mimecast-MFC-AGG-ID: 34NFHiOgMbaGBeDTLnsRKg_1746618249
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61702195608C
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:44:09 +0000 (UTC)
Received: from bighat.boston.devel.redhat.com (unknown [10.22.80.171])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFD2018003FC
	for <linux-nfs@vger.kernel.org>; Wed,  7 May 2025 11:44:08 +0000 (UTC)
From: Steve Dickson <steved@redhat.com>
To: Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsdctl: Warning Clean Up
Date: Wed,  7 May 2025 07:44:07 -0400
Message-ID: <20250507114407.101530-1-steved@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Removed a number of unused variables

Initialized a variable that could be used
before initialized

Signed-off-by: Steve Dickson <steved@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index c2e34260..e7a0e124 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1521,7 +1521,7 @@ static int configure_versions(void)
 
 static int configure_listeners(void)
 {
-	char *port, *rdma_port;
+	char *port, *rdma_port = NULL;
 	bool rdma, udp, tcp;
 	struct conf_list *hosts;
 	int ret = 0;
@@ -1675,10 +1675,7 @@ static void nlm_usage(void)
 
 static int nlm_func(struct nl_sock *sock, int argc, char ** argv)
 {
-	int *threads, grace, lease, idx, ret, opt, pools;
-	struct conf_list *thread_str;
-	struct conf_list_node *n;
-	char *scope, *pool_mode;
+	int opt;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
-- 
2.49.0


