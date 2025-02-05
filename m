Return-Path: <linux-nfs+bounces-9885-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9D4A29516
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 16:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82E8165EDA
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BB218952C;
	Wed,  5 Feb 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JY9ljJGW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4314A15FA7B
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770227; cv=none; b=i3VS9uwB+2uvasF7GZBsKUxkC4u7FFbXDhcktyJgQKqlIykBmKJ6poaN2uqllS5ErxCemXbHRwK/buFnQUPXawJIdfDvHSS8fD4nOTAtH6W5m9Rw+oWGux+7BM5ne4L7fDKOaC/GD/d6iAxyQnC3RlQNgg1txw4Yr2Gt+vQWclk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770227; c=relaxed/simple;
	bh=IykN3c1X42iqx8cAkLlwE3yprV0MhYEUAvJnkHCerDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dt6bJhn2SPolc2GpaVwuPzebNLsfC0Ow9Yjsq0PKpbkj+uFp9wnGxMH18H/VqfxcRrGSA8Ni3K739aG2e1y8fYm5Yszx9CiSXi3tHlstPUUBP6c9SAX1V/OV/qreT2wdZXtGgLyhwwgIjQNK8uMCA/ZSeic/gqcqmnpHyCEqEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JY9ljJGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738770224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CisEwXdVN53ah8bmYpFQiU6+tn6g05Qn5jPpgl6FYck=;
	b=JY9ljJGWCSPjIZzRJLwx1KUa0PT1EH44TPKEKFrDgccHIG0L4/tkBSXsPIqS730Xx2aaKH
	0LCpSgEi9afKXGkJVJxwbqToN1+uhW5rsXxhgZoHxwbcN5iNOKMDKv51yKXi8mROcdzqRQ
	RVY5rYb8q1dDl9A6mJbFVsDYdv2UP3I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-hhxL4xGlPGyqPsEBeW9Y7g-1; Wed,
 05 Feb 2025 10:43:43 -0500
X-MC-Unique: hhxL4xGlPGyqPsEBeW9Y7g-1
X-Mimecast-MFC-AGG-ID: hhxL4xGlPGyqPsEBeW9Y7g
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 473F21956086
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:42 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5ED9D195608D;
	Wed,  5 Feb 2025 15:43:41 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 2/4] nfs-utils: nfsdctl: fix autostart
Date: Wed,  5 Feb 2025 10:43:31 -0500
Message-Id: <20250205154333.58646-3-okorniev@redhat.com>
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

During nfsdctl autostart the nfsdctl reads the nfs.conf file and
tries to setup the listeners and start knfsd threads. However,
if we failed to start a listener, it currently ignores the error
and starts the threads anyway.

Suggesting that if we fail to start a UDP/TCP listener then do not
start threads. At the moment ignoring the failure of adding an
RDMA listener (because default config might have rdma=y set but
not RDMA-enabled interface is available and previously we did not
fail the start of knfsd in that case).

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 0530dfdd..624243dc 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1285,7 +1285,7 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 
 #define MAX_LISTENER_LEN (64 * 2 + 16)
 
-static void
+static int
 add_listener(const char *netid, const char *addr, const char *port)
 {
 		char buf[MAX_LISTENER_LEN];
@@ -1297,7 +1297,7 @@ add_listener(const char *netid, const char *addr, const char *port)
 			snprintf(buf, MAX_LISTENER_LEN, "+%s:%s:%s",
 				 netid, addr, port);
 		buf[MAX_LISTENER_LEN - 1] = '\0';
-		update_listeners(buf);
+		return update_listeners(buf);
 }
 
 static void
@@ -1350,11 +1350,12 @@ static int configure_versions(void)
 	return 0;
 }
 
-static void configure_listeners(void)
+static int configure_listeners(void)
 {
 	char *port, *rdma_port;
 	bool rdma, udp, tcp;
 	struct conf_list *hosts;
+	int ret = 0;
 
 	udp = conf_get_bool("nfsd", "udp", false);
 	tcp = conf_get_bool("nfsd", "tcp", true);
@@ -1378,20 +1379,23 @@ static void configure_listeners(void)
 		struct conf_list_node *n;
 		TAILQ_FOREACH(n, &(hosts->fields), link) {
 			if (udp)
-				add_listener("udp", n->field, port);
+				ret = add_listener("udp", n->field, port);
 			if (tcp)
-				add_listener("tcp", n->field, port);
+				ret = add_listener("tcp", n->field, port);
 			if (rdma)
 				add_listener("rdma", n->field, rdma_port);
+			if (ret)
+				return ret;
 		}
 	} else {
 		if (udp)
-			add_listener("udp", "", port);
+			ret = add_listener("udp", "", port);
 		if (tcp)
-			add_listener("tcp", "", port);
+			ret = add_listener("tcp", "", port);
 		if (rdma)
 			add_listener("rdma", "", rdma_port);
 	}
+	return ret;
 }
 
 static void autostart_usage(void)
@@ -1438,7 +1442,9 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	if (ret)
 		return ret;
 
-	configure_listeners();
+	ret = configure_listeners();
+	if (ret)
+		return ret;
 	ret = set_listeners(sock);
 	if (ret)
 		return ret;
-- 
2.47.1


