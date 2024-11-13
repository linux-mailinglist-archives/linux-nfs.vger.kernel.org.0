Return-Path: <linux-nfs+bounces-7932-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394969C785A
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 17:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01241F25280
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF11158D93;
	Wed, 13 Nov 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eCGbz6Zo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B019249EB
	for <linux-nfs@vger.kernel.org>; Wed, 13 Nov 2024 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514281; cv=none; b=CJbXwwXO55b7XYbJMmsnGwLSV3tFySFnROa8pOvtwdalIg3eWbPS/iaw2A1m4mFQWR9FAdghjHsWfBvjxHu5NlGJEe2VPTPlFpS1Gr05K+TphRvP90Y/4X6pbtICMcDHieLIArH4AwyKSWZv1wlDiaxYhj+hWjgXclwp3pCagcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514281; c=relaxed/simple;
	bh=uXM4JEW9yp3XfBdidc/OrbcLlciJB8CWLy63ozvy0rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D50R+n1k3ouD6vw6b0e/XwNPkqGBKSIBTkC8Q8EkT2h1z3xXhwzgF5MfBIoFLXXy0JNVoAn/+J+hVIYa5xyo2HMZ/AH/xCLNZ+HH1vUlMKXO8tXG3Yd5KL6oeZYW7rhnBSnV1lyFSiJP4pDcVTncnhMtpXb7QjSEWmlVpiyqniQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eCGbz6Zo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731514279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oq7jTnUukVdiVLRduRQF3b5nIrUZ/yz5kaeLrCXqDro=;
	b=eCGbz6ZoGDHyfKla/KNV1Ca1H5ZrpQVm+4etyPPNCW1zpQ6eaZ929h7fiFMDWLsyqMU39b
	0103F1BffD+L3aPfo1OoQ15xovb9PQnBg+YI6LXVJvOaAzgyxBhwF8jF1SQ4WcEmKRgYvN
	od3cYaWXITCytmxldcsdBaqBsHZfGuk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-G9a1gq12PgmX-pBaYBI6cw-1; Wed,
 13 Nov 2024 11:11:15 -0500
X-MC-Unique: G9a1gq12PgmX-pBaYBI6cw-1
X-Mimecast-MFC-AGG-ID: G9a1gq12PgmX-pBaYBI6cw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B56F21944DD9;
	Wed, 13 Nov 2024 16:11:13 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BE5D1956054;
	Wed, 13 Nov 2024 16:11:12 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org,
	Philip Rowlands <linux-nfs@dimebar.com>,
	Chuck Lever III <chuck.lever@oracle.com>
Subject: [PATCH] libnsm: safer atomic filenames
Date: Wed, 13 Nov 2024 11:11:11 -0500
Message-ID: <95b7c243dae00ef4fd745f2b6d2cd0c979779237.1731514115.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We've gotten a report of reboot notifications being sent to domains that
end in '.new', which can happen if the NSM temporary pathname code leaves a
file behind.  Let's fix this up by prepending a single '.' to the temp path
which will never be resolvable as a DNS record.

https://lore.kernel.org/linux-nfs/04D30B5A-C53E-4920-ADCB-C77F5577669E@oracle.com/T/#t

Reported-by: Philip Rowlands <linux-nfs@dimebar.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 support/nsm/file.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index f5b448015751..e0804136ccbe 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -184,10 +184,10 @@ static char *
 nsm_make_temp_pathname(const char *pathname)
 {
 	size_t size;
-	char *path;
+	char *path, *base;
 	int len;
 
-	size = strlen(pathname) + sizeof(".new") + 2;
+	size = strlen(pathname) + sizeof(".new") + 3;
 	if (size > PATH_MAX)
 		return NULL;
 
@@ -195,7 +195,11 @@ nsm_make_temp_pathname(const char *pathname)
 	if (path == NULL)
 		return NULL;
 
-	len = snprintf(path, size, "%s.new", pathname);
+	base = strrchr(pathname, '/');
+	strcpy(path, pathname);
+
+	len = base - pathname;
+	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
 	if (error_check(len, size)) {
 		free(path);
 		return NULL;

base-commit: 38b46cb1f28737069d7887b5ccf7001ba4a4ff59
-- 
2.47.0


