Return-Path: <linux-nfs+bounces-9886-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63781A2952A
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7BB3A28A7
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Feb 2025 15:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4903F1494DF;
	Wed,  5 Feb 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NI5qX61p"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF9015FA7B
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770231; cv=none; b=LTdnDSB3ZMRiVODWro2ccvVhGEQJQpEFh51O2HvQFzIptvtNsNydo6PIEuRroMYCuZIMRq4ZrdwYzkN0wKnd9iEgPId8YsP8L9IsmQOBuBi5EWb9+LhRai+4nBbIg1CUWaql4ACGQDE1JZLS2pS0sGQUocvoB+fAzLI4w+O3TFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770231; c=relaxed/simple;
	bh=351tppkOywBRvVcFmrA7iYU0pm3YcCeEvcDR4U3+ZhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fo2IotkY4YT4iiYolFULwjJ/W3iJwU5mf+e/4aEpE76gRh5TEneCbGZAp7Wc03CjhJrXAAmSt6ZMGy60XojmwX7BkX0vklIFTHxujtUF9FzXUe9/Bi+B+oKQkHVNf+ac0k001Kk+GsNYNWqyqu+s6XwRj7vXQaM5dCwRin3Nvck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NI5qX61p; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738770226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ue53weQJz0q6CJxCblQXAliUuP9Z0KF8YdE7C3UHcw=;
	b=NI5qX61pIFT5kz07ONWjMz3Wt/uWP7WoXQxtkhnuW0ez2E3bwx7GBek2HKnp9BTAzlcsIa
	zxuT41yOyndsRS6V+6nUZabagVzIPRhkidUkPZ0qmvfp8D09RlA1nPjlKFVXg7X/mE3iZi
	00fmim2Hg0QeeiSqnsNr69/RuouvnKs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-SmjP17B2O4GcU8a2hqWPfA-1; Wed,
 05 Feb 2025 10:43:45 -0500
X-MC-Unique: SmjP17B2O4GcU8a2hqWPfA-1
X-Mimecast-MFC-AGG-ID: SmjP17B2O4GcU8a2hqWPfA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 713D51956094
	for <linux-nfs@vger.kernel.org>; Wed,  5 Feb 2025 15:43:44 +0000 (UTC)
Received: from okorniev-mac.redhat.com (unknown [10.22.82.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8804E1956051;
	Wed,  5 Feb 2025 15:43:43 +0000 (UTC)
From: Olga Kornievskaia <okorniev@redhat.com>
To: steved@redhat.com
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>
Subject: [PATCH 3/4] nfs-utils: nfsdctl: cleanup listeners if some failed
Date: Wed,  5 Feb 2025 10:43:32 -0500
Message-Id: <20250205154333.58646-4-okorniev@redhat.com>
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

If we couldn't start some listeners, then make sure to remove
already added listeners.

Signed-off-by: Olga Kornievskaia <okorniev@redhat.com>
---
 utils/nfsdctl/nfsdctl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/utils/nfsdctl/nfsdctl.c b/utils/nfsdctl/nfsdctl.c
index 624243dc..64ce44a1 100644
--- a/utils/nfsdctl/nfsdctl.c
+++ b/utils/nfsdctl/nfsdctl.c
@@ -1413,6 +1413,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	struct conf_list *thread_str;
 	struct conf_list_node *n;
 	char *scope, *pool_mode;
+	bool failed_listeners = false;
 
 	optind = 1;
 	while ((opt = getopt_long(argc, argv, "h", help_only_options, NULL)) != -1) {
@@ -1447,7 +1448,7 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 		return ret;
 	ret = set_listeners(sock);
 	if (ret)
-		return ret;
+		failed_listeners = true;
 
 	grace = conf_get_num("nfsd", "grace-time", 0);
 	lease = conf_get_num("nfsd", "lease-time", 0);
@@ -1456,6 +1457,12 @@ static int autostart_func(struct nl_sock *sock, int argc, char ** argv)
 	thread_str = conf_get_list("nfsd", "threads");
 	pools = thread_str ? thread_str->cnt : 1;
 
+	/* if we fail to start one or more listeners, then cleanup by
+	 * starting 0 knfsd threads
+	 */
+	if (failed_listeners)
+		pools = 0;
+
 	threads = calloc(pools, sizeof(int));
 	if (!threads)
 		return -ENOMEM;
-- 
2.47.1


