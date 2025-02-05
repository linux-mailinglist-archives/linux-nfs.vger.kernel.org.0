Return-Path: <linux-nfs+bounces-9887-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E776AA29519
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 16:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 784BF165F6D
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227118A6BD;
	Wed,  5 Feb 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z9Umfx9+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094AB18952C
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770231; cv=none; b=sXyIWVtG4Fe+7Lxu21h39Ozp2wjCEfh0tMW+f+3y5xy4wsS7PKp+Wya/e5Z5P0+49v3ZJWePwzU27tEtB5g2LjHRCnqgrYfecOey/PQ9oEchkHPXYru8W0+gQyvlYm7rgQlbWjeK4h0veAhEtrXKm3OukRcWF5k/fYEvqKl1zfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770231; c=relaxed/simple;
	bh=d5gRQRQJHc7bCxRTVTalqlk70Zkgm6gwkVcduipd9iE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NeMyvGRvI6Zo1ZM/AiOGew4Saw7wrq4KuQXGFlKcNJzj2WO2XImUnkRGlbtiGEhfpUfgbH3uE8rCEanx3Unq1+Qlt5XEoTaVfDbbB8BAPJj5yjzjeacAlc1XQVv10rqgZwigIpik+LDV5gtXrBBLWh2U+eDZD9aMQg358fIhyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z9Umfx9+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738770228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiECIRWiChw3CvjpDSmrgdHpXeGdFVubGgfvtUUJPu0=;
	b=Z9Umfx9+gZliQyY01s58LmEAt3VfXnOP3ojimcnwfO64o90mX/lxPvO0QucyDTACNQoRmm
	rIsvHjWFQCNv7yrkwgVALNzmlpGwq2F/VhF2B9GZ0932vO2cCnKepq1H1kuCouJ4ePBhKN
	Q2R3ZFUtcZR+AJ7fD8ddt4nOhA3Ycgg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-208-Yxpgh8KFNpGBKeBx7j_6xA-1; Wed,
 05 Feb 2025 10:43:47 -0500
X-MC-Unique: Yxpgh8KFNpGBKeBx7j_6xA-1
X-Mimecast-MFC-AGG-ID: Yxpgh8KFNpGBKeBx7j_6xA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D144B1956086
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:46 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E7E73195608D;
	Wed,  5 Feb 2025 15:43:45 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 4/4] nfs-utils: nfsdctl: fix host-limited add listener
Date: Wed,  5 Feb 2025 10:43:33 -0500
Message-Id: <20250205154333.58646-5-okorniev@redhat.com>
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

If in nfs.conf there was "host=<hostname>" configuration that
limited knfsd to listen on a particular hostname, then
add_listener() had to fit <type>:<hostname>:<port> into
144bytes to create a listener or be truncated which leads
to failure of said listener creation.

Instead allocate needed memory dynamically to allow for
long hostname values.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 64ce44a1..05fecc71 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1283,21 +1283,26 @@ static int pool_mode_func(struct nl_sock *sock, int argc, char **argv)
 	return pool_mode_doit(sock, cmd, pool_mode);
 }
 
-#define MAX_LISTENER_LEN (64 * 2 + 16)
-
 static int
 add_listener(const char *netid, const char *addr, const char *port)
 {
-		char buf[MAX_LISTENER_LEN];
+		char *buf;
+		int ret;
+		int size = strlen(addr) + 1 + 16;
 
+		buf = calloc(size, sizeof(int));
+		if (!buf)
+			return -ENOMEM;
 		if (strchr(addr, ':'))
-			snprintf(buf, MAX_LISTENER_LEN, "+%s:[%s]:%s",
+			snprintf(buf, size, "+%s:[%s]:%s",
 				 netid, addr, port);
 		else
-			snprintf(buf, MAX_LISTENER_LEN, "+%s:%s:%s",
+			snprintf(buf, size, "+%s:%s:%s",
 				 netid, addr, port);
-		buf[MAX_LISTENER_LEN - 1] = '\0';
-		return update_listeners(buf);
+		buf[size - 1] = '\0';
+		ret = update_listeners(buf);
+		free(buf);
+		return ret;
 }
 
 static void
-- 
2.47.1


