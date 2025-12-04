Return-Path: <linux-nfs+bounces-16908-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 233EACA55FA
	for <lists+linux-nfs@lfdr.de>; Thu, 04 Dec 2025 21:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F2F307DB53
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Dec 2025 20:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FDC3176EE;
	Thu,  4 Dec 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtM4c0Av"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCDD315D45
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764881332; cv=none; b=ZvBuCp1SPrRNFDaX1QblFnY0gEvsjnSefbe3DDtJpqFTT3bKqYxv89cUcEIIaXz5/wospMZGHQXn4Ni+tdnJJf7rpof4jdChHWMcGeGFFGvF+l/TZ/Jn06X8Iv6W5/wYtUkTtqU8L/4qk4b474v2rL71TpHCOPsFa7hKZFi0B9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764881332; c=relaxed/simple;
	bh=W4JQTZQgKcH0p7aMYVe3jiDOIqVw5ocr54PwBKXUTnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRVX4lhplRJqd5pnFBEgs4bMe2IP22ouSsa8OughaUNgzzFAd198eh+8NJUoImOM77UiYzZ5yH2RYytFtYf4GHqKzcuBdJqN0URI5y1QNSKWc/Di9RRQeC3leuGFJWNH300LuuNMb2xJCYJlnVwJubplLWO/H0LoH/zjd1F5vRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PtM4c0Av; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764881323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5iP7bwD9l8LdG6J0pwZLhb3WvX8RW9n+VUKbcIOTs68=;
	b=PtM4c0Avfjzv7nKGRWcuIGN+8EXUgph7qUtXYxJBauRtreIaIJtySqZB2HJcBuGmUs4x1Q
	XnMFiR9eqbdDTKbHGWffFHCLc7zRY9kvbgZBjltboJ7PXPVBNuLI4Oi5WaEJFhupMwlDDN
	m6Kfg2WEXBFHSI/J+/WDMgTDn9y0F+E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-AoEou5q4McO2dbqyyVm8QA-1; Thu,
 04 Dec 2025 15:48:42 -0500
X-MC-Unique: AoEou5q4McO2dbqyyVm8QA-1
X-Mimecast-MFC-AGG-ID: AoEou5q4McO2dbqyyVm8QA_1764881321
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37202195608D
	for <linux-nfs@vger.kernel.org>; Thu,  4 Dec 2025 20:48:41 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.65.26])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6848619560BD;
	Thu,  4 Dec 2025 20:48:40 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] nfs-utils: nfsdctl: function location identifying error messages
Date: Thu,  4 Dec 2025 15:48:39 -0500
Message-ID: <20251204204839.91425-1-okorniev@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A lot of places where x_log() error function logs a generic error
which makes hard to tell where it is coming from. Add function
location to error logging.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index e7a0e124..eb0b8e7d 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -507,7 +507,7 @@ static int status_func(struct nl_sock *sock, int argc, char ** argv)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -568,7 +568,7 @@ static int threads_doit(struct nl_sock *sock, int cmd, int grace, int lease,
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -655,7 +655,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "send failed: %d", ret);
+		xlog(L_ERROR, "[%s] send failed: %d", __func__, ret);
 		goto out_cb;
 	}
 
@@ -668,7 +668,7 @@ static int fetch_nfsd_versions(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -741,7 +741,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "Send failed: %d", ret);
+		xlog(L_ERROR, "[%s] Send failed: %d", __func__, ret);
 		goto out_cb;
 	}
 
@@ -754,7 +754,7 @@ static int set_nfsd_versions(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -901,7 +901,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "send failed: %d", ret);
+		xlog(L_ERROR, "[%s] send failed: %d", __func__, ret);
 		goto out_cb;
 	}
 
@@ -914,7 +914,7 @@ static int fetch_current_listeners(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1157,7 +1157,7 @@ static int set_listeners(struct nl_sock *sock)
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "Send failed: %d", ret);
+		xlog(L_ERROR, "[%s] Send failed: %d", __func__, ret);
 		goto out_cb;
 	}
 
@@ -1170,7 +1170,7 @@ static int set_listeners(struct nl_sock *sock)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1254,7 +1254,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "send failed (%d)!", ret);
+		xlog(L_ERROR, "[%s] send failed (%d)!", __func__, ret);
 		goto out_cb;
 	}
 
@@ -1267,7 +1267,7 @@ static int pool_mode_doit(struct nl_sock *sock, int cmd, const char *pool_mode)
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
@@ -1352,7 +1352,7 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 
 	ret = nl_send_auto(sock, msg);
 	if (ret < 0) {
-		xlog(L_ERROR, "send failed (%d)!\n", ret);
+		xlog(L_ERROR, "[%s] send failed (%d)!\n", __func__, ret);
 		goto out_cb;
 	}
 
@@ -1365,7 +1365,7 @@ static int lockd_config_doit(struct nl_sock *sock, int cmd, int grace, int tcppo
 	while (ret > 0)
 		nl_recvmsgs(sock, cb);
 	if (ret < 0) {
-		xlog(L_ERROR, "Error: %s\n", strerror(-ret));
+		xlog(L_ERROR, "[%s] Error: %s\n", __func__, strerror(-ret));
 		ret = 1;
 	}
 out_cb:
-- 
2.47.3


