Return-Path: <linux-nfs+bounces-9884-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80197A29529
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C443A1985
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC721494DF;
	Wed,  5 Feb 2025 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YeWN9vUT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7934415FA7B
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770224; cv=none; b=id8def3XyW6nw61GLxdhA9jriSgsVeJ3prPZV2hTKzlFJSd61UJR/zRCAd7IF/lG3d6zK1pLtzJTam1vZ0sz3kBe47X2qj4Fyp3WMB14Z5tB67iWCNsOD3aPRRAKuea+LAWxHlDtYiFsXktIzIOQ6+wMNKM/QukWsVea0w+P5rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770224; c=relaxed/simple;
	bh=PClFaLceKKrlHjjkUggbhLd0y9eGTgZcIQ+LXxJtRJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mpSDxtcPAuIrAjf5JHMEzmq0imQhUrYGCdPVrjQqjxK5xuQBkoK/nbTdKFXbxKo2C8zdfen5cTNdqZomIOsijQw3+gn2DZ2HlQJ/i/jw00XcPcRazZhI2uA0vN9Krn59LpOFRcOm6PYnA0KgbERubi/oMQ2DYVdkxW2VUgpakZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YeWN9vUT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738770221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EvxjezREji/E3sTzBtYF8DFHKn53uIX4n7f8+6lhhIQ=;
	b=YeWN9vUT8ypgKWrX4wYjcV211DYy8qgt83DH9cup8yrM+Co4x3qCm4QfqojFDYDAbrfTax
	cQTZS2X113GAUUfXTotlXL/AolRkU8IpvM8J6OKIyDnRD37LRXwoN704tZQA6ba2AEGfWF
	38XNdYwfk/NjgRykpg8BwR6judcrhj4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-NziWkbu6N2CcU4_G0ssu2w-1; Wed,
 05 Feb 2025 10:43:40 -0500
X-MC-Unique: NziWkbu6N2CcU4_G0ssu2w-1
X-Mimecast-MFC-AGG-ID: NziWkbu6N2CcU4_G0ssu2w
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3797A1800983
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:39 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 504B3195608D;
	Wed,  5 Feb 2025 15:43:38 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/4] nfs-utils: nfsdctl: fix update_listeners
Date: Wed,  5 Feb 2025 10:43:30 -0500
Message-Id: <20250205154333.58646-2-okorniev@redhat.com>
In-Reply-To: <20250205154333.58646-1-okorniev@redhat.com>
References: <20250205154333.58646-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When adding a listener via an nfsdctl listener command and
passing in a hostname that is longer then 62bytes it leads
to a buffer overlow problem.

Instead allocate the needed buffer to be the size of the
supplied command-line argument.

Fixes: 8c32613d5311 ("nfsdctl: add the nfsdctl utility to nfs-utils")
Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 0e93beda..0530dfdd 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -938,8 +938,6 @@ static void print_listeners(void)
 	}
 }
 
-#define BUFLEN (INET6_ADDRSTRLEN + 16)
-
 /*
  * Format is <+/-><netid>:<address>:port
  *
@@ -950,7 +948,7 @@ static void print_listeners(void)
  */
 static int update_listeners(const char *str)
 {
-	char buf[INET6_ADDRSTRLEN + 16];
+	char *buf;
 	char sign = *str;
 	char *netid, *addr, *port, *end;
 	struct addrinfo *res;
@@ -963,6 +961,9 @@ static int update_listeners(const char *str)
 	if (sign != '+' && sign != '-')
 		goto out_inval;
 
+	buf = malloc(strlen(str) + 1);
+	if (!buf)
+		goto out_inval;
 	strcpy(buf, str + 1);
 
 	/* netid is start */
@@ -971,18 +972,18 @@ static int update_listeners(const char *str)
 	/* find first ':' */
 	addr = strchr(buf, ':');
 	if (!addr)
-		goto out_inval;
+		goto out_inval_free;
 
 	if (addr == buf) {
 		/* empty netid */
-		goto out_inval;
+		goto out_inval_free;
 	}
 	*addr = '\0';
 	++addr;
 
 	port = strrchr(addr, ':');
 	if (!port)
-		goto out_inval;
+		goto out_inval_free;
 	if (port == addr) {
 		/* empty address, give gai a NULL ptr */
 		addr = NULL;
@@ -992,7 +993,7 @@ static int update_listeners(const char *str)
 
 	if (*port == '\0') {
 		/* empty port */
-		goto out_inval;
+		goto out_inval_free;
 	}
 
 	/* IPv6 addrs must be in square brackets */
@@ -1001,7 +1002,7 @@ static int update_listeners(const char *str)
 		++addr;
 		end = strchr(addr, ']');
 		if (!end)
-			goto out_inval;
+			goto out_inval_free;
 		if (end == addr)
 			addr = NULL;
 		*end = '\0';
@@ -1070,7 +1071,10 @@ static int update_listeners(const char *str)
 			++nfsd_socket_count;
 		}
 	}
+	free(buf);
 	return 0;
+out_inval_free:
+	free(buf);
 out_inval:
 	fprintf(stderr, "Invalid listener update string: %s", str);
 	return -EINVAL;
-- 
2.47.1


