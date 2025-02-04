Return-Path: <linux-nfs+bounces-9870-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D21A2777A
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 17:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E06E1652D8
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Feb 2025 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E602AF00;
	Tue,  4 Feb 2025 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7lNi98c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553EC214A61
	for <linux-nfs@vger.kernel.org>; Tue,  4 Feb 2025 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687510; cv=none; b=Y/MFufHD4SDKwmwcsc+Xit97Q8Q1LNmUG5i9lzpStiv4Mykoqzy+GACsT4k3xUnaD1v008CaqQm4pUMZc1nUhSZOhpBm/8qP9DlRVCczBg3GEBkndj0q9+jW5+st+pG4ex8+aIuD7jkTwa30rTeaK5mxYgn3ni620BvINbWSo10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687510; c=relaxed/simple;
	bh=PClFaLceKKrlHjjkUggbhLd0y9eGTgZcIQ+LXxJtRJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AxEILU3wjcIKuvgxKt8u1oU3vuB2TtSZPF8YnRbjLrGRPBJWoOfgTdkYtpjUZBsAomGFwJLhu6Gbf3VfJ+/YUYaFInbEWCWFkPqSIJ7ypD1xiui3QosOHZX0cTQhpYyl7C1mAZ/rLUvQxcL3K9VnHW1cs/Mq6PBnyC0mSLBk7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7lNi98c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738687507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EvxjezREji/E3sTzBtYF8DFHKn53uIX4n7f8+6lhhIQ=;
	b=F7lNi98coR0WdifmC2/khHoe113K6xVsd9rgcscRiHEu90Caaj8HV+zxvK4W+DJONPkJ3T
	MQ7rmBYGukvKDlyFvjU2cGTd5TyPXPrkvKgLL2WrJonnxiBSQyPIU6U3o5fiiWWJNBv0jY
	F5PY2jkwxonkDU194QPJuJ+bE7LjgwY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-qKHs2QahPzSqsXBUVMWGpA-1; Tue,
 04 Feb 2025 11:45:05 -0500
X-MC-Unique: qKHs2QahPzSqsXBUVMWGpA-1
X-Mimecast-MFC-AGG-ID: qKHs2QahPzSqsXBUVMWGpA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34A5318009F9
	for <linux-nfs@vger.kernel.org>; Tue,  4 Feb 2025 16:45:04 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.81.202])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29B7819560AD;
	Tue,  4 Feb 2025 16:45:03 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 1/1] nfs-utils: nfsdctl: fix update_listeners
Date: Tue,  4 Feb 2025 11:44:50 -0500
Message-Id: <20250204164450.53127-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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


