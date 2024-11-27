Return-Path: <linux-nfs+bounces-8237-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F539DA6F3
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 12:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2A628203D
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Nov 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BDB1F8EFB;
	Wed, 27 Nov 2024 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LBlNCCi6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35091F8F17
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707856; cv=none; b=S6iXdwlkJ3PbO7PaN2GFRiIucZRH3/+Iwb+PeivVQgucdYDIfpSwiIXoScMwIPjdy0m1itH2FbF/8NUZXNjMWZq4k/ruv66j0trifz8Wjk1tqmx9DzT+xGI1J2ABwwRlAm/Vrk70ljKXWGRBPtjJVgSwHfv4t1h3rS2wzFQCwOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707856; c=relaxed/simple;
	bh=dfeKnMlo1nK95A9NlcGNm4MvDFy7KG5Q1Fay8uq73lg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yww1wHr9TeO6nn6tu52yCZJPBZU5ZlD05RKNxfKGY9EoMVddjKGjaY+jp8fXKrEPRoXh3IDLZyhcoGqiSfB+PeNbJkFSuDGA/n089xZA8LLHhPH4wbosuAwlp7lD5R3ok20xYgd9aMJLQB+yQlAea3pYHvxOFYU8SqrwwwqDmmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LBlNCCi6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732707853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dRLp8sPPbJVNX73kk5KXY32kmpbo0+1Et4i0izBsFbU=;
	b=LBlNCCi6NB8uUJCFkxjOE5Z//KJhtwceZ0/XqrFatMKWhlt22E9Se1FtmNkdo5z6FMRoyJ
	M2ZaRHG+JH7cmsBvVg7GTiXOYt+oYrfg752WHjG0qV9F89KGhJqyG8wWnN7dfcM2V1o/oD
	oIpRTCdHfU3hyk317Mxq1sViQdrE3O8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-otDOM79fMsyEXEUCTp0JxA-1; Wed,
 27 Nov 2024 06:44:12 -0500
X-MC-Unique: otDOM79fMsyEXEUCTp0JxA-1
X-Mimecast-MFC-AGG-ID: otDOM79fMsyEXEUCTp0JxA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 651D219560A6
	for <linux-nfs@vger.kernel.org>; Wed, 27 Nov 2024 11:44:11 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.74.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BFBF51956056;
	Wed, 27 Nov 2024 11:44:10 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Steve Dickson <steved@redhat.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v2] libnsm: fix the safer atomic filenames fix
Date: Wed, 27 Nov 2024 06:44:09 -0500
Message-ID: <7fa1fc7f2a8d72e11e5a468c0ed4bbdefb035830.1732707758.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit 9f7a91b51ffc ("libnsm: safer atomic filenames") messed up the length
arguement to snprintf() in nsm_make_temp_pathname such that the length is
longer than the computed string.  When compiled with "-O
-D_FORTIFY_SOURCE=3", __snprintf_chk will fail and abort statd.

The fix is to correct the original size calculation, then pull one from the
snprintf length for the final "/".

Fixes: 9f7a91b51ffc ("libnsm: safer atomic filenames")
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
v2: ensure we handle paths without '/', simplify.

---
 support/nsm/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/support/nsm/file.c b/support/nsm/file.c
index e0804136ccbe..de122b0fc5a1 100644
--- a/support/nsm/file.c
+++ b/support/nsm/file.c
@@ -187,7 +187,7 @@ nsm_make_temp_pathname(const char *pathname)
 	char *path, *base;
 	int len;
 
-	size = strlen(pathname) + sizeof(".new") + 3;
+	size = strlen(pathname) + sizeof(".new") + 1;
 	if (size > PATH_MAX)
 		return NULL;
 
@@ -196,15 +196,19 @@ nsm_make_temp_pathname(const char *pathname)
 		return NULL;
 
 	base = strrchr(pathname, '/');
-	strcpy(path, pathname);
+	if (base == NULL)
+		base = pathname;
+	else
+		base++;
 
+	strcpy(path, pathname);
 	len = base - pathname;
-	len += snprintf(path + len + 1, size-len, ".%s.new", base+1);
+	len += snprintf(path + len, size - len, ".%s.new", base);
+
 	if (error_check(len, size)) {
 		free(path);
 		return NULL;
 	}
-
 	return path;
 }
 

base-commit: eb5abb5c60ab60f3c2f22518d513ed187f39bd9b
-- 
2.47.0


